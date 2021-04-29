module Day09 exposing (main)

import Html exposing (Html, text)


main : Html msg
main =
    -- partOne 25 xmasData 0
    partTwo
        |> Debug.toString
        |> text


partOne : Int -> List Int -> Int -> Maybe Int
partOne preamble list offset =
    let
        ( preambleData, target ) =
            validationGroup preamble list offset

        isVerified =
            verify preambleData target
    in
    if isVerified then
        partOne preamble list (offset + 1)

    else
        target


partTwo : Maybe Int
partTwo =
    partOne 25 xmasData 0
        |> Maybe.andThen (findContiguousSet xmasData)
        |> Maybe.andThen miniMaxSum


miniMaxSum : List Int -> Maybe Int
miniMaxSum l =
    Maybe.map2 (+) (List.minimum l) (List.maximum l)


findContiguousSet : List Int -> Int -> Maybe (List Int)
findContiguousSet =
    findContiguousSetHelp []


findContiguousSetHelp : List Int -> List Int -> Int -> Maybe (List Int)
findContiguousSetHelp acc list target =
    case compare (List.sum acc) target of
        LT ->
            case list of
                [] ->
                    Nothing

                x :: xs ->
                    findContiguousSetHelp (acc ++ [ x ]) xs target

        EQ ->
            Just acc

        GT ->
            case acc of
                [] ->
                    Nothing

                _ :: xs ->
                    findContiguousSetHelp xs list target


verify : List Int -> Maybe Int -> Bool
verify preambleData target =
    case target of
        Nothing ->
            False

        Just int ->
            isPairExist preambleData int


isPairExist : List Int -> Int -> Bool
isPairExist list target =
    case list of
        [] ->
            False

        x :: xs ->
            if List.member (target - x) xs then
                True

            else
                isPairExist xs target


validationGroup : Int -> List Int -> Int -> ( List Int, Maybe Int )
validationGroup preamble list offset =
    ( chopPreambleData preamble list offset
    , extractCurrentNumber preamble list offset
    )


chopPreambleData : Int -> List Int -> Int -> List Int
chopPreambleData preamble list offset =
    List.take (preamble + offset) list
        |> List.drop offset


extractCurrentNumber : Int -> List Int -> Int -> Maybe Int
extractCurrentNumber preamble list offset =
    List.take (preamble + offset + 1) list
        |> List.drop (preamble + offset)
        |> List.head


xmasData : List Int
xmasData =
    (String.lines >> List.filterMap String.toInt) input


input : String
input =
    """17
31
1
10
41
37
24
22
35
11
49
4
48
5
46
15
7
45
6
30
12
19
33
9
50
8
13
14
16
10
17
18
21
22
34
84
11
58
23
60
20
28
15
42
26
24
41
19
25
27
37
29
31
30
32
33
35
47
39
64
34
36
40
38
43
44
45
81
54
46
48
49
50
52
56
59
60
91
114
82
69
97
70
76
72
74
78
108
90
87
98
93
99
141
106
125
128
102
111
115
119
129
139
142
214
143
217
150
146
152
161
165
218
177
202
339
363
201
208
352
213
258
304
226
234
262
540
376
289
589
370
302
441
420
313
326
379
378
411
421
409
739
681
434
439
447
523
460
488
643
564
615
591
698
733
881
1341
639
826
790
704
799
787
1062
830
843
873
1099
1273
1328
1262
948
1024
1314
1206
1179
1230
1289
1547
1426
1343
1512
1438
1491
1586
1503
1617
1854
1673
1897
2546
1972
3315
2522
2127
2154
3827
2203
2385
4588
2409
2801
2632
2769
2846
2781
4923
4818
3077
3630
3357
3869
3527
3570
4024
5041
5154
4935
5784
4330
8804
4612
6373
4794
9741
5178
5846
5401
5550
5627
5858
6434
8151
6604
6927
7226
7097
7900
9729
9178
8942
9731
9124
9406
10162
9790
9972
15252
10728
10805
12450
10951
11028
11177
15078
22422
14827
14504
13531
14997
14323
16039
16842
24005
18909
18066
18530
19568
34956
19762
21000
34820
28528
21533
25274
21979
36360
22205
44567
27854
28035
29150
36596
34105
40735
31165
38821
34908
36975
41547
37634
69885
44184
82201
40762
42533
62855
50240
55889
71504
49833
72421
80167
81542
57004
90568
64058
114069
90975
100073
81818
84741
75670
86717
136957
78396
140808
83295
183341
90595
136056
105722
112893
119947
129425
113891
121062
132674
147572
143721
139728
168991
154066
157488
165113
158965
161691
218615
170012
173890
283628
189017
223269
203488
310079
245450
219613
233955
253736
291074
257612
301638
283449
287300
368601
502243
315757
311554
316453
320656
607527
331703
343902
359029
362907
898601
511348
423101
626589
453568
545509
510687
596862
874255
541061
894827
570749
683563
628007
637109
627311
632210
959014
660355
721936
675605
1258799
970491
816475
786008
1138694
1361984
1642577
964255
994629
1051748
1081436
1111810
1168372
1169068
2427171
1231104
1954380
1688857
1302916
1259521
1292565
1335960
1382291
2370609
2223054
1602483
1897818
2413732
1837756
2045691
1958884
2016003
2193246
2046377
3280109
2249808
2280182
2400172
4000757
3213901
2490625
2562437
2552086
2595481
2628525
4433237
2984774
3852291
4237928
4389842
3440239
5264956
4296185
3796640
3974887
4005261
4062380
4845289
4537002
5114523
4529990
4680354
4890797
5042711
5053062
5086106
5992325
9027949
7736424
7445500
7415126
10167585
7236879
7502619
7859020
13564951
12912082
9723065
7771527
7980148
8067641
12468188
9066992
9210344
16443075
9420787
21632592
9933508
10095773
17582085
13407451
13229204
14652005
21296845
16303871
14739498
16712963
23949842
17790706
15630547
17190492
16047789
24423223
17192314
18001149
17134633
21535180
18487779
22439548
26636655
33438504
31874131
20029281
28059456
27881209
27968702
29276993
31043369
31452461
31678336
32760752
32343510
32765180
40927327
32821039
49899813
34048938
35680093
34326947
35622412
66199256
38517060
74976265
46665936
47910490
47997983
48088737
49306274
55940665
55849911
57245695
101821668
116099069
63130797
64021846
68383164
67965922
65586219
66869977
67147986
94576426
72844007
95999227
74139472
122139921
85182996
86427550
94663919
161446403
157762333
96086720
97395011
234290410
130000774
132734205
186161767
259584001
127152643
246629399
301438396
132456196
227032622
134017963
161811905
139991993
230104683
146983479
159322468
395736813
179846915
182514270
181091469
221816562
561022397
193481731
223239363
367024615
257153417
274009956
259886848
266474159
308795384
261170606
272448189
279439675
391916588
362361185
704532197
299314461
321083462
306305947
370222842
339169383
494264751
467491687
363605739
497249319
481703410
669537303
416721094
480392780
758941203
517040265
569965990
521057454
527644765
1066893382
533618795
1064230741
578754136
827363401
605620408
620397923
627389409
645475330
669911686
702775122
755890477
780326833
897113874
1091023444
898424504
937778548
933761359
944365859
1571755268
1038097719
1044685030
1054676249
1184374544
1432043299
1139239203
1647140981
1936522223
1199152059
1226018331
1233009817
1247787332
1978446389
1315387016
2253165564
1483101955
1536217310
1677440707
1309761972
1832185863
2387026535
2360072046
2845979282
2287686066
2099361279
2082782749
2183924233
2193915452
3398169765
2792863927
2338391262
2473805663
2625148988
2425170390
4619085842
3730132762
2557549304
5029903515
2798488971
3776801986
3565884704
3734932362
4763561652
5039894734
8540363638
4276698201
4182144028
4266706982
5904275966
4283285512
4377839685
4522315495
4532306714
4895940566
4812196925
6980632999
4898976053
4982719694
9470160670
5356038275
6287682066
6292481666
6364373675
7320804466
7300817066
7748028732
8001639344
8448851010
11876573565
8559983713
8543405183
8465429540
8549992494
8900155180
8661125197
12303524160
9054622209
17561280377
9708137491
11176570600
14369136723
9881695747
10338757969
17103388896
16174177413
14366013019
15025498872
14907778858
14621621532
15048845798
15749668076
16467068884
16914280550
24077274214
17008834723
17015422034
17126554737
17211117691
19837695797
17715747406
18762759700
29529400390
19589833238
20046895460
20220453716
24503317279
24704770988
27253038519
31223023211
28987634551
29391511891
38352592938
29670467330
30371289608
30798513874
32765090110
44550212739
44723770995
56923505849
36478507106
34226539725
34337672428
36800950929
51942287131
37762642866
52985543826
47473492235
51018967590
40267349176
58051552393
49208088267
51957809507
56240673070
69566041039
90578345498
82740801005
69243597216
60468981204
61169803482
83951999341
66991629835
94852503322
68564212153
107258979011
70705046831
71027490654
71138623357
74563593795
135894286472
86970731133
87740841411
91286316766
89475437443
92225158683
107259640660
101165897774
108198482577
129734015635
121638784686
129033193357
139591702807
132197294136
127460611039
132308426839
135555841988
137696676666
139269258984
139702835510
160614060800
179027158177
210619193461
222526573121
161534324928
176446168576
174711572544
195000482071
180761754209
181700596126
199484799343
222804682460
228626508813
229837267263
253947211525
261230487493
300205763607
259657905175
259769037878
263016453027
267864268827
310267414532
276965935650
334269741055
342314656926
398972741697
356412168670
336245897472
430393380101
438500260578
358146764702
404505278586
362462350335
380246553552
381185395469
452641949723
513605116700
766967628921
483784478788
539982388677
658352528309
794051893320
578131683359
610178925753
1171472907507
544830204477
587233350182
611235676705
670515638527
1123784042453
692658066142
694392662174
698708247807
1151218065382
720609115037
738393318254
918110395286
742708903887
1148153024390
833827345192
936426428511
997389595488
1023766867465
1352887829640
1084812593154
1122961887836
1132063554659
1243538452284
1584622945670
1156065881182
1215345843004
1435366970029
1281751315232
1679135332398
1989893226374
1554436460229
1393100909981
1463318018924
1481102222141
1459002433291
2608446752985
1576536249079
2724640674425
1857594212657
2108579460619
2240928047772
2216876147813
2146728755301
3035538682370
2366563908386
3255671581477
2288129435841
2371411724186
3501680370600
2437817196414
3830414157477
2762853537373
2674852225213
2944420241065
2852103343272
2856418928905
3338696434798
2922320452215
3793412396892
3316596645948
4960682803891
5294236125319
3966173673276
5069049207516
5930523806690
5796523584337
8862461604408
5227830653091
7398500000305
4654693344227
6268231353891
4659541160027
7467854043876
6840376805398
5597172677428
5437705762586
5774423795487
5619272466278
5708522272177
6261016887013
5778739381120
6238917098163
8754302408534
11024354237428
7282770319224
10843473003003
8620867017503
8625714833303
11487261653297
9314234504254
13176376316053
9882523997318
9887371813118
10092399106813
10363215616404
10097246922613
10256713837455
11146228034763
14218039694931
14063420595889
13543787206237
11327794738455
14334237105480
11947439370340
12017656479283
16331316204976
17246581850806
21206688619407
15903637336727
15908485152527
18503391014821
20245739613722
21420193845268
30502453451177
24431484028093
31783409461672
24871581944692
20144085650573
20189646029426
20353960760068
21243474957376
23163884514046
22474022773218
33224345098690
23275234108795
23345451217738
40335121364820
34407028351548
36098131181953
37328678997795
31812122489254
33150219187533
34411876167348
36047722987300
55087356598049
92416035595844
56343870795675
73485340552353
59802701771013
44785444788161
40333731679999
41387560607949
40498046410641
57682262460343
42827983533286
43717497730594
45637907287264
45749256882013
46620685326533
55157573706992
80833167775461
73376401985095
80156662531081
117485341528876
66223998656602
67562095354881
92369942208546
70459599154648
95655620117633
80831778090640
84215544141235
81721292287948
81885607018590
83161715213285
125438790018542"""
