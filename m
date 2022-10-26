Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269BC60DF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiJZLaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiJZLaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:30:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590182E68A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v13-20020a17090a6b0d00b0021332e5388fso1829739pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dqnfmFZmWGwlSuMIxQAg5tMxa0wZrbePY1655SN7R4=;
        b=J3QQ1s7dK3/OQBd66+6yegtnfTc8SSeJsjIytIYP9ZjLcHf1nnkU7fyGkbkD8LwnXm
         ZSiygTCvNm+7M3SLtWj7uoH1PplFJa29eZUPp/H0hmEF4ePWyYA2xKVS4+eIXDgg2Lql
         3aj5rAjhrEl/LqoNPBh3xfib5H2CcwP85N9mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dqnfmFZmWGwlSuMIxQAg5tMxa0wZrbePY1655SN7R4=;
        b=O+81Pe1Kea2H6GCU+bVxGALQwl2q3bH4q36+G08wSASnnAqth4zU54JbHbeyY/SQCx
         WMKGXi4eEERPtlVP41HwnjJ5SPsraNWl3tYMk5DX6PbPbui3qDKNuPRNjwiuYH7x7iSc
         BKYINeUZvqcTtpgKFpDdRkJSXMS51jJJ4xD1ddN+R6F/EKT1jAEQ6Yl75nLe9ePFqdwL
         v5peos1GO2w9ZpneasME0HAE7Mnl/TS+HfcLyMbu0lR/EdUlM97dAs3nkVwy8vnWJ6xX
         SF9QuOrzj7wAKzJlcnLiIn5uAItjVXQjZbsjTBVspbNt9rSomYiekZGsReFZnmd3PCZv
         0EMg==
X-Gm-Message-State: ACrzQf3TGmWWKuc2RuKUYG1X0DVyV5//0bxKKKCAh93p+9UCLI+Njp7S
        zY5vJy4DXomN5tuvfm6CE0FTnMRqp/bOVw==
X-Google-Smtp-Source: AMsMyM5v8HqYcLtI3ZIScQoHvZF8R7UkJHoAm2xhwh7mxWP/5bKHmHGjsoXU/MBAKOFtgpGx8luMeg==
X-Received: by 2002:a17:90b:384a:b0:213:2907:a528 with SMTP id nl10-20020a17090b384a00b002132907a528mr3697714pjb.183.1666783815395;
        Wed, 26 Oct 2022 04:30:15 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:749c:f7f5:1a8e:d0be])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b005627868e27esm2814919pfb.127.2022.10.26.04.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:30:15 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 2/9] zsmalloc: turn zspage order into runtime variable
Date:   Wed, 26 Oct 2022 20:29:26 +0900
Message-Id: <20221026112933.4122957-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221026112933.4122957-1-senozhatsky@chromium.org>
References: <20221026112933.4122957-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zsmalloc has 255 size classes. Size classes contain a number of zspages,
which store objects of the same size. zspage can consist of up to four
physical pages. The exact (most optimal) zspage size is calculated for
each size class during zsmalloc pool creation.

As a reasonable optimization, zsmalloc merges size classes that have
similar characteristics: number of pages per zspage and number of
objects zspage can store.

For example, let's look at the following size classes:

class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
..
   94  1536           0            0             0          0          0                3        0
  100  1632           0            0             0          0          0                2        0
..

Size classes #95-99 are merged with size class #100. That is, each time
we store an object of size, say, 1568 bytes instead of using class #96
we end up storing it in size class #100. Class #100 is for objects of
1632 bytes in size, hence every 1568 bytes object wastes 1632-1568 bytes.
Class #100 zspages consist of 2 physical pages and can hold 5 objects.
When we need to store, say, 13 objects of size 1568 we end up allocating
three zspages; in other words, 6 physical pages.

However, if we'll look closer at size class #96 (which should hold objects
of size 1568 bytes) and trace get_pages_per_zspage():

    pages per zspage      wasted bytes     used%
           1                  960           76
           2                  352           95
           3                 1312           89
           4                  704           95
           5                   96           99

We'd notice that the most optimal zspage configuration for this class is
when it consists of 5 physical pages, but currently we never let zspages
to consists of more than 4 pages. A 5 page class #96 configuration would
store 13 objects of size 1568 in a single zspage, allocating 5 physical
pages, as opposed to 6 physical pages that class #100 will allocate.

A higher order zspage for class #96 also changes its key characteristics:
pages per-zspage and objects per-zspage. As a result classes #96 and #100
are not merged anymore, which gives us more compact zsmalloc.

Of course the described effect does not apply only to size classes #96 and
We still merge classes, but less often so. In other words classes are grouped
in a more compact way, which decreases memory wastage:

zspage order               # unique size classes
     2                                69
     3                               123
     4                               191

Let's take a closer look at the bottom of /sys/kernel/debug/zsmalloc/zram0/classes:

class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
...
  202  3264           0            0             0          0          0                4        0
  254  4096           0            0             0          0          0                1        0
...

For exactly same reason - maximum 4 pages per zspage - the last non-huge
size class is #202, which stores objects of size 3264 bytes. Any object
larger than 3264 bytes, hence, is considered to be huge and lands in size
class #254, which uses a whole physical page to store every object. To put
it slightly differently - objects in huge classes don't share physical pages.

3264 bytes is too low of a watermark and we have too many huge classes:
classes from #203 to #254. Similarly to class size #96 above, higher order
zspages change key characteristics for some of those huge size classes and
thus those classes become normal classes, where stored objects share physical
pages.

Hence yet another consequence of higher order zspages: we move the huge
size class watermark with higher order zspages, have less huge classes and
store large objects in a more compact way.

For order 3, huge class watermark becomes 3632 bytes:

class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
...
  202  3264           0            0             0          0          0                4        0
  211  3408           0            0             0          0          0                5        0
  217  3504           0            0             0          0          0                6        0
  222  3584           0            0             0          0          0                7        0
  225  3632           0            0             0          0          0                8        0
  254  4096           0            0             0          0          0                1        0
...

For order 4, huge class watermark becomes 3840 bytes:

class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
...
  202  3264           0            0             0          0          0                4        0
  206  3328           0            0             0          0          0               13        0
  207  3344           0            0             0          0          0                9        0
  208  3360           0            0             0          0          0               14        0
  211  3408           0            0             0          0          0                5        0
  212  3424           0            0             0          0          0               16        0
  214  3456           0            0             0          0          0               11        0
  217  3504           0            0             0          0          0                6        0
  219  3536           0            0             0          0          0               13        0
  222  3584           0            0             0          0          0                7        0
  223  3600           0            0             0          0          0               15        0
  225  3632           0            0             0          0          0                8        0
  228  3680           0            0             0          0          0                9        0
  230  3712           0            0             0          0          0               10        0
  232  3744           0            0             0          0          0               11        0
  234  3776           0            0             0          0          0               12        0
  235  3792           0            0             0          0          0               13        0
  236  3808           0            0             0          0          0               14        0
  238  3840           0            0             0          0          0               15        0
  254  4096           0            0             0          0          0                1        0
...

TESTS
=====

1) ChromeOS memory pressure test
=============================================================================

Our standard memory pressure test, that is designed with reproducibility
in mind.

zram is configured as a swap device, lzo-rle compression algorithm.
We captured /sys/block/zram0/mm_stat after every test and rebooted
device.

Columns per (Documentation/admin-guide/blockdev/zram.rst)

orig_data_size        mem_used_total      mem_used_max         pages_compacted
          compr_data_size         mem_limit           same_pages          huge_pages

ORDER 2 (BASE) zspage

10353639424 2981711944 3166896128        0 3543158784   579494   825135   123707
10168573952 2932288347 3106541568        0 3499085824   565187   853137   126153
9950461952 2815911234 3035693056        0 3441090560   586696   748054   122103
9892335616 2779566152 2943459328        0 3514736640   591541   650696   119621
9993949184 2814279212 3021357056        0 3336421376   582488   711744   121273
9953226752 2856382009 3025649664        0 3512893440   564559   787861   123034
9838448640 2785481728 2997575680        0 3367219200   573282   777099   122739

ORDER 3 zspage

9509138432 2706941227 2823393280        0 3389587456   535856  1011472    90223
10105245696 2882368370 3013095424        0 3296165888   563896  1059033    94808
9531236352 2666125512 2867650560        0 3396173824   567117  1126396    88807
9561812992 2714536764 2956652544        0 3310505984   548223   827322    90992
9807470592 2790315707 2908053504        0 3378315264   563670  1020933    93725
10178371584 2948838782 3071209472        0 3329548288   548533   954546    90730
9925165056 2849839413 2958274560        0 3336978432   551464  1058302    89381

ORDER 4 zspage

9444515840 2613362645 2668232704        0 3396759552   573735  1162207    83475
10129108992 2925888488 3038351360        0 3499597824   555634  1231542    84525
9876594688 2786692282 2897006592        0 3469463552   584835  1290535    84133
10012909568 2649711847 2801512448        0 3171323904   675405   750728    80424
10120966144 2866742402 2978639872        0 3257815040   587435  1093981    83587
9578790912 2671245225 2802270208        0 3376353280   545548  1047930    80895
10108588032 2888433523 2983960576        0 3316641792   571445  1290640    81402

First, we establish that order 3 and 4 don't cause any statistically
significant change in `orig_data_size` (number of bytes we store during
the test), in other words larger zspages don't cause regressions.

T-test for order 3:

x order-2-stored
+ order-3-stored
+-----------------------------------------------------------------------------+
|+ +  +                     +  x   x  +  x   x         +    x+               x|
| |________________________AM__|_________M_____A____|__________|              |
+-----------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x   7 9.8384486e+09 1.0353639e+10 9.9532268e+09 1.0021519e+10 1.7916718e+08
+   7 9.5091384e+09 1.0178372e+10 9.8074706e+09 9.8026344e+09 2.7856206e+08
No difference proven at 95.0% confidence

T-test for order 4:

x order-2-stored
+ order-4-stored
+-----------------------------------------------------------------------------+
|                                                         +                   |
|+          +                     x  +x    xx  x +       ++   x              x|
|              |__________________|____A____M____M____________|_|             |
+-----------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x   7 9.8384486e+09 1.0353639e+10 9.9532268e+09 1.0021519e+10 1.7916718e+08
+   7 9.4445158e+09 1.0129109e+10  1.001291e+10 9.8959249e+09 2.7947784e+08
No difference proven at 95.0% confidence

Next we establish that there is a statistically significant improvement
in `mem_used_total` metrics.

T-test for order 3:

x order-2-usedmem
+ order-3-usedmem
+-----------------------------------------------------------------------------+
|+         +        +       x ++        x  + xx x       +       x            x|
|        |_________________A__M__|____________|__A________________|           |
+-----------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x   7 2.9434593e+09 3.1668961e+09 3.0256497e+09 3.0424532e+09      73235062
+   7 2.8233933e+09 3.0712095e+09 2.9566525e+09 2.9426185e+09      84630851
Difference at 95.0% confidence
	-9.98347e+07 +/- 9.21744e+07
	-3.28139% +/- 3.02961%
	(Student's t, pooled s = 7.91383e+07)

T-test for order 4:

x order-2-usedmem
+ order-4-usedmem
+-----------------------------------------------------------------------------+
|                    +                                 x                      |
|+                   +              +      x    ++ x   x *          x        x|
|             |__________________A__M__________|_____|_M__A__________|        |
+-----------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x   7 2.9434593e+09 3.1668961e+09 3.0256497e+09 3.0424532e+09      73235062
+   7 2.6682327e+09 3.0383514e+09 2.8970066e+09 2.8814248e+09 1.3098053e+08
Difference at 95.0% confidence
	-1.61028e+08 +/- 1.23591e+08
	-5.29272% +/- 4.0622%
	(Student's t, pooled s = 1.06111e+08)

Order 3 zspages also show statistically significant improvement in
`mem_used_max` metrics.

T-test for order 3:

x order-2-maxmem
+ order-3-maxmem
+-----------------------------------------------------------------------------+
|+   +     + x+        x  +   + +             x                x    x        x|
|    |________M__A_________|_|_____________________A___________M____________| |
+-----------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x   7 3.3364214e+09 3.5431588e+09 3.4990858e+09 3.4592294e+09      80073158
+   7 3.2961659e+09 3.3961738e+09 3.3369784e+09 3.3481822e+09      39840377
Difference at 95.0% confidence
	-1.11047e+08 +/- 7.36589e+07
	-3.21017% +/- 2.12934%
	(Student's t, pooled s = 6.32415e+07)

Order 4 zspages, on the other hand, do not show any statistically significant
improvement in `mem_used_max` metrics.

T-test for order 4:

x order-2-maxmem
+ order-4-maxmem
+-----------------------------------------------------------------------------+
|+                 +           +   x     x +   +        x     +     *  x     x|
|              |_______________________A___M________________A_|_____M_______| |
+-----------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x   7 3.3364214e+09 3.5431588e+09 3.4990858e+09 3.4592294e+09      80073158
+   7 3.1713239e+09 3.4995978e+09 3.3763533e+09 3.3554221e+09 1.1609062e+08
No difference proven at 95.0% confidence

Overall, with sufficient level of confidence, order 3 zspages appear to be
beneficial for these particular use-case and data patterns.

Rather expectedly we also observed lower numbers of huge-pages when zsmalloc
is configured with order 3 and order 4 zspages, for the reason already
explained.

2) Synthetic test
=============================================================================

Test untars linux-6.0.tar.xz and compiles the kernel.

zram is configured as a block device with ext4 file system, lzo-rle
compression algorithm. We captured /sys/block/zram0/mm_stat after
every test and rebooted the VM.

orig_data_size       mem_used_total     mem_used_max       pages_compacted
          compr_data_size         mem_limit         same_pages       huge_pages

ORDER 2 (BASE) zspage

1691791360 628086729 655171584        0 655171584       60        0    34043
1691787264 628089196 655175680        0 655175680       60        0    34046
1691803648 628098840 655187968        0 655187968       59        0    34047
1691795456 628091503 655183872        0 655183872       60        0    34044
1691799552 628086877 655183872        0 655183872       60        0    34047

ORDER 3 zspage

1691803648 627792993 641794048        0 641794048       60        0    33591
1691787264 627779342 641708032        0 641708032       59        0    33591
1691811840 627786616 641769472        0 641769472       60        0    33591
1691803648 627794468 641818624        0 641818624       59        0    33592
1691783168 627780882 641794048        0 641794048       61        0    33591

ORDER 4 zspage

1691803648 627726635 639655936        0 639655936       60        0    33435
1691811840 627733348 639643648        0 639643648       61        0    33434
1691795456 627726290 639614976        0 639614976       60        0    33435
1691803648 627730458 639688704        0 639688704       60        0    33434
1691811840 627727771 639688704        0 639688704       60        0    33434

Order 3 and order 4 show statistically significant improvement in
`mem_used_max` metrics.

T-test for order 3:

x order-2-maxmem
+ order-3-maxmem
+--------------------------------------------------------------------------+
|+                                                                        x|
|+                                                                        x|
|+                                                                        x|
|++                                                                       x|
|A|                                                                       A|
+--------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x   5 6.5517158e+08 6.5518797e+08 6.5518387e+08  6.551806e+08     6730.4157
+   5 6.4170803e+08 6.4181862e+08 6.4179405e+08 6.4177684e+08     42210.666
Difference at 95.0% confidence
	-1.34038e+07 +/- 44080.7
	-2.04581% +/- 0.00672802%
	(Student's t, pooled s = 30224.5)

T-test for order 4:

x order-2-maxmem
+ order-4-maxmem
+--------------------------------------------------------------------------+
|+                                                                        x|
|+                                                                        x|
|+                                                                        x|
|+                                                                        x|
|+                                                                        x|
|A                                                                        A|
+--------------------------------------------------------------------------+
    N           Min           Max        Median           Avg        Stddev
x   5 6.5517158e+08 6.5518797e+08 6.5518387e+08  6.551806e+08     6730.4157
+   5 6.3961498e+08  6.396887e+08 6.3965594e+08 6.3965839e+08     31408.602
Difference at 95.0% confidence
	-1.55222e+07 +/- 33126.2
	-2.36915% +/- 0.00505604%
	(Student's t, pooled s = 22713.4)

This test tends to benefit more from order 4 zspages, due to test's data
patterns.

zsmalloc object distribution analysis
=============================================================================

Order 2 (4 pages per zspage) tends to put many objects in size class 2048,
which is merged with size classes #112-#125:

class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
...
    71  1168           0            0          6146       6146       1756                2        0
    74  1216           0            1          4560       4552       1368                3        0
    76  1248           0            1          2938       2934        904                4        0
    83  1360           0            0         10971      10971       3657                1        0
    91  1488           0            0         16126      16126       5864                4        0
    94  1536           0            1          5912       5908       2217                3        0
   100  1632           0            0         11990      11990       4796                2        0
   107  1744           0            1         15771      15768       6759                3        0
   111  1808           0            1         10386      10380       4616                4        0
   126  2048           0            0         45444      45444      22722                1        0
   144  2336           0            0         47446      47446      27112                4        0
   151  2448           1            0         10760      10759       6456                3        0
   168  2720           0            0         10173      10173       6782                2        0
   190  3072           0            1          1700       1697       1275                3        0
   202  3264           0            1           290        286        232                4        0
   254  4096           0            0         34051      34051      34051                1        0

Order 3 (8 pages per zspage) changed pool characteristics and unmerged
some of the size classes, which resulted in less objects being put into
size class 2048, because there are lower size classes are now available
for more compact object storage:

class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
...
    71  1168           0            1          2996       2994        856                2        0
    72  1184           0            1          1632       1609        476                7        0
    73  1200           1            0          1445       1442        425                5        0
    74  1216           0            0          1510       1510        453                3        0
    75  1232           0            1          1495       1479        455                7        0
    76  1248           0            1          1456       1451        448                4        0
    78  1280           0            1          3040       3033        950                5        0
    79  1296           0            1          1584       1571        504                7        0
    83  1360           0            0          6375       6375       2125                1        0
    84  1376           0            1          1817       1796        632                8        0
    87  1424           0            1          6020       6006       2107                7        0
    88  1440           0            1          2108       2101        744                6        0
    89  1456           0            1          2072       2064        740                5        0
    91  1488           0            1          4169       4159       1516                4        0
    92  1504           0            1          2014       2007        742                7        0
    94  1536           0            1          3904       3900       1464                3        0
    95  1552           0            1          1890       1873        720                8        0
    96  1568           0            1          1963       1958        755                5        0
    97  1584           0            1          1980       1974        770                7        0
   100  1632           0            1          6190       6187       2476                2        0
   103  1680           0            0          6477       6477       2667                7        0
   104  1696           0            1          2256       2253        940                5        0
   105  1712           0            1          2356       2340        992                8        0
   107  1744           1            0          4697       4696       2013                3        0
   110  1792           0            1          7744       7734       3388                7        0
   111  1808           0            1          2655       2649       1180                4        0
   114  1856           0            1          8371       8365       3805                5        0
   116  1888           1            0          5863       5862       2706                6        0
   117  1904           0            1          2955       2942       1379                7        0
   118  1920           0            1          3009       2997       1416                8        0
   126  2048           0            0         25276      25276      12638                1        0
   128  2080           0            1          6060       6052       3232                8        0
   129  2096           1            0          3081       3080       1659                7        0
   134  2176           0            1         14835      14830       7912                8        0
   135  2192           0            1          2769       2758       1491                7        0
   137  2224           0            1          5082       5077       2772                6        0
   140  2272           0            1          7236       7232       4020                5        0
   144  2336           0            1          8428       8423       4816                4        0
   147  2384           0            1          5316       5313       3101                7        0
   151  2448           0            1          5445       5443       3267                3        0
   155  2512           0            0          4121       4121       2536                8        0
   158  2560           0            1          2208       2205       1380                5        0
   160  2592           0            0          1133       1133        721                7        0
   168  2720           0            0          2712       2712       1808                2        0
   177  2864           1            0          1100       1098        770                7        0
   180  2912           0            1           189        183        135                5        0
   184  2976           0            1           176        166        128                8        0
   190  3072           0            0           252        252        189                3        0
   197  3184           0            1           198        192        154                7        0
   202  3264           0            1           100         96         80                4        0
   211  3408           0            1           210        208        175                5        0
   217  3504           0            1            98         94         84                6        0
   222  3584           0            0           104        104         91                7        0
   225  3632           0            1            54         50         48                8        0
   254  4096           0            0         33591      33591      33591                1        0

Note, the huge size watermark is above 3632 and there are a number of new
normal classes available that previously were merged with the huge class.
For instance, size class #211 holds 210 objects of size 3408 and uses 175
physical pages, while previously for those objects we would have used 210
physical pages.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/zsmalloc.h | 12 +++++++
 mm/zsmalloc.c            | 75 +++++++++++++++++++++++-----------------
 2 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index a48cd0ffe57d..6cd1d95b928a 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -33,6 +33,18 @@ enum zs_mapmode {
 	 */
 };
 
+#define ZS_PAGE_ORDER_2		2
+#define ZS_PAGE_ORDER_4		4
+
+/*
+ * A single 'zspage' is composed of up to 2^N discontiguous 0-order (single)
+ * pages. ZS_MAX_PAGE_ORDER defines upper limit on N, ZS_MIN_PAGE_ORDER
+ * defines lower limit on N. ZS_DEFAULT_PAGE_ORDER is recommended value.
+ */
+#define ZS_MIN_PAGE_ORDER	ZS_PAGE_ORDER_2
+#define ZS_MAX_PAGE_ORDER	ZS_PAGE_ORDER_4
+#define ZS_DEFAULT_PAGE_ORDER	ZS_PAGE_ORDER_2
+
 struct zs_pool_stats {
 	/* How many pages were migrated (freed) */
 	atomic_long_t pages_compacted;
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 065744b7e9d8..bc377e5d3417 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -74,12 +74,7 @@
  */
 #define ZS_ALIGN		8
 
-/*
- * A single 'zspage' is composed of up to 2^N discontiguous 0-order (single)
- * pages. ZS_MAX_ZSPAGE_ORDER defines upper limit on N.
- */
-#define ZS_MAX_ZSPAGE_ORDER 2
-#define ZS_MAX_PAGES_PER_ZSPAGE (_AC(1, UL) << ZS_MAX_ZSPAGE_ORDER)
+#define ZS_MAX_PAGES_PER_ZSPAGE	(_AC(1, UL) << ZS_MAX_PAGE_ORDER)
 
 #define ZS_HANDLE_SIZE (sizeof(unsigned long))
 
@@ -124,10 +119,8 @@
 #define ISOLATED_BITS	3
 #define MAGIC_VAL_BITS	8
 
-#define MAX(a, b) ((a) >= (b) ? (a) : (b))
-/* ZS_MIN_ALLOC_SIZE must be multiple of ZS_ALIGN */
-#define ZS_MIN_ALLOC_SIZE \
-	MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
+#define ZS_MIN_ALLOC_SIZE	32U
+
 /* each chunk includes extra space to keep handle */
 #define ZS_MAX_ALLOC_SIZE	PAGE_SIZE
 
@@ -141,12 +134,10 @@
  *    determined). NOTE: all those class sizes must be set as multiple of
  *    ZS_ALIGN to make sure link_free itself never has to span 2 pages.
  *
- *  ZS_MIN_ALLOC_SIZE and ZS_SIZE_CLASS_DELTA must be multiple of ZS_ALIGN
- *  (reason above)
+ *  pool->min_alloc_size (ZS_MIN_ALLOC_SIZE) and ZS_SIZE_CLASS_DELTA must
+ *  be multiple of ZS_ALIGN (reason above)
  */
 #define ZS_SIZE_CLASS_DELTA	(PAGE_SIZE >> CLASS_BITS)
-#define ZS_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
-				      ZS_SIZE_CLASS_DELTA) + 1)
 
 enum fullness_group {
 	ZS_EMPTY,
@@ -230,12 +221,15 @@ struct link_free {
 struct zs_pool {
 	const char *name;
 
-	struct size_class *size_class[ZS_SIZE_CLASSES];
+	struct size_class **size_class;
 	struct kmem_cache *handle_cachep;
 	struct kmem_cache *zspage_cachep;
 
 	atomic_long_t pages_allocated;
 
+	u32 num_size_classes;
+	u32 min_alloc_size;
+
 	struct zs_pool_stats stats;
 
 	/* Compact classes */
@@ -523,15 +517,15 @@ static void set_zspage_mapping(struct zspage *zspage,
  * classes depending on its size. This function returns index of the
  * size class which has chunk size big enough to hold the given size.
  */
-static int get_size_class_index(int size)
+static int get_size_class_index(struct zs_pool *pool, int size)
 {
 	int idx = 0;
 
-	if (likely(size > ZS_MIN_ALLOC_SIZE))
-		idx = DIV_ROUND_UP(size - ZS_MIN_ALLOC_SIZE,
+	if (likely(size > pool->min_alloc_size))
+		idx = DIV_ROUND_UP(size - pool->min_alloc_size,
 				ZS_SIZE_CLASS_DELTA);
 
-	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
+	return min_t(int, pool->num_size_classes - 1, idx);
 }
 
 /* type can be of enum type class_stat_type or fullness_group */
@@ -591,7 +585,7 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 			"obj_allocated", "obj_used", "pages_used",
 			"pages_per_zspage", "freeable");
 
-	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
+	for (i = 0; i < pool->num_size_classes; i++) {
 		class = pool->size_class[i];
 
 		if (class->index != i)
@@ -777,13 +771,13 @@ static enum fullness_group fix_fullness_group(struct size_class *class,
  * link together 3 PAGE_SIZE sized pages to form a zspage
  * since then we can perfectly fit in 8 such objects.
  */
-static int get_pages_per_zspage(int class_size)
+static int get_pages_per_zspage(u32 class_size, u32 max_pages_per_zspage)
 {
 	int i, max_usedpc = 0;
 	/* zspage order which gives maximum used size per KB */
 	int max_usedpc_order = 1;
 
-	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
+	for (i = 1; i <= max_pages_per_zspage; i++) {
 		int zspage_size;
 		int waste, usedpc;
 
@@ -1220,7 +1214,7 @@ unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size)
 {
 	struct size_class *class;
 
-	class = pool->size_class[get_size_class_index(size)];
+	class = pool->size_class[get_size_class_index(pool, size)];
 
 	return class->index;
 }
@@ -1431,7 +1425,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 
 	/* extra space in chunk to keep the handle */
 	size += ZS_HANDLE_SIZE;
-	class = pool->size_class[get_size_class_index(size)];
+	class = pool->size_class[get_size_class_index(pool, size)];
 
 	/* class->lock effectively protects the zpage migration */
 	spin_lock(&class->lock);
@@ -1980,7 +1974,7 @@ static void async_free_zspage(struct work_struct *work)
 	struct zs_pool *pool = container_of(work, struct zs_pool,
 					free_work);
 
-	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
+	for (i = 0; i < pool->num_size_classes; i++) {
 		class = pool->size_class[i];
 		if (class->index != i)
 			continue;
@@ -2129,7 +2123,7 @@ unsigned long zs_compact(struct zs_pool *pool)
 	struct size_class *class;
 	unsigned long pages_freed = 0;
 
-	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
+	for (i = pool->num_size_classes - 1; i >= 0; i--) {
 		class = pool->size_class[i];
 		if (class->index != i)
 			continue;
@@ -2173,7 +2167,7 @@ static unsigned long zs_shrinker_count(struct shrinker *shrinker,
 	struct zs_pool *pool = container_of(shrinker, struct zs_pool,
 			shrinker);
 
-	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
+	for (i = pool->num_size_classes - 1; i >= 0; i--) {
 		class = pool->size_class[i];
 		if (class->index != i)
 			continue;
@@ -2215,11 +2209,28 @@ struct zs_pool *zs_create_pool(const char *name)
 	int i;
 	struct zs_pool *pool;
 	struct size_class *prev_class = NULL;
+	u32 max_pages_per_zspage;
 
 	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
 	if (!pool)
 		return NULL;
 
+	max_pages_per_zspage = 1U << ZS_DEFAULT_PAGE_ORDER;
+	/* min_alloc_size must be multiple of ZS_ALIGN */
+	pool->min_alloc_size = (max_pages_per_zspage << PAGE_SHIFT) >>
+		OBJ_INDEX_BITS;
+	pool->min_alloc_size = max(pool->min_alloc_size, ZS_MIN_ALLOC_SIZE);
+
+	pool->num_size_classes =
+		DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - pool->min_alloc_size,
+			     ZS_SIZE_CLASS_DELTA) + 1;
+
+	pool->size_class = kmalloc_array(pool->num_size_classes,
+					 sizeof(struct size_class *),
+					 GFP_KERNEL | __GFP_ZERO);
+	if (!pool->size_class)
+		goto err;
+
 	init_deferred_free(pool);
 	rwlock_init(&pool->migrate_lock);
 
@@ -2234,17 +2245,18 @@ struct zs_pool *zs_create_pool(const char *name)
 	 * Iterate reversely, because, size of size_class that we want to use
 	 * for merging should be larger or equal to current size.
 	 */
-	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
+	for (i = pool->num_size_classes - 1; i >= 0; i--) {
 		int size;
 		int pages_per_zspage;
 		int objs_per_zspage;
 		struct size_class *class;
 		int fullness = 0;
 
-		size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
+		size = pool->min_alloc_size + i * ZS_SIZE_CLASS_DELTA;
 		if (size > ZS_MAX_ALLOC_SIZE)
 			size = ZS_MAX_ALLOC_SIZE;
-		pages_per_zspage = get_pages_per_zspage(size);
+		pages_per_zspage = get_pages_per_zspage(size,
+							max_pages_per_zspage);
 		objs_per_zspage = pages_per_zspage * PAGE_SIZE / size;
 
 		/*
@@ -2328,7 +2340,7 @@ void zs_destroy_pool(struct zs_pool *pool)
 	zs_flush_migration(pool);
 	zs_pool_stat_destroy(pool);
 
-	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
+	for (i = 0; i < pool->num_size_classes; i++) {
 		int fg;
 		struct size_class *class = pool->size_class[i];
 
@@ -2348,6 +2360,7 @@ void zs_destroy_pool(struct zs_pool *pool)
 	}
 
 	destroy_cache(pool);
+	kfree(pool->size_class);
 	kfree(pool->name);
 	kfree(pool);
 }
-- 
2.38.0.135.g90850a2211-goog

