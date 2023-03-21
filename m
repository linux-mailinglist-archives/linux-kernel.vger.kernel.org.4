Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B516C2FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCULGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCULGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:06:09 -0400
Received: from t03.bc.larksuite.com (t03.bc.larksuite.com [209.127.231.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EE23C7A7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lixiang-com.20200927.dkim.feishu.cn; t=1679396755;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=LsfOfG2jTXioJ152I4w9fmBsebpbv5bD0J3/k4BXOR8=;
 b=3c2uAQuVH1Rk43KdKd5lcYQmUdbfxeoQ6NXO156F1pZUQVfAtD+/tcsrIyk9Pj0PcO6eUv
 qDpNmRHjrAhNnw+DR+nyu70j/XoiQ7oFzLnr/G16iJOqZiVccP3mCLRCmPBsEY2D5gYXTo
 mvV0Dp+JbQtj7bmHOQUOIaCxOs+PUJJGL6Kkepka4rahuHu5ZFcz0OuNYw0XVB68SBc63R
 o7dUPZRvU7PxWfMBS7/6HgVtw7Xs21U3obijQHcLV34urcx5CMjNUdW0/RbqJYCqM9nWii
 HtZq78tCAvgzzvGI7FiTu4jMR/yzfdfu0zbxeevh5nA06gvr7WGH+inkmWYH3w==
Content-Type: multipart/alternative;
 boundary=ad961245aebc28a7ee441470c0a743cb2feae329a3f38362f75863a3ebd1
Date:   Tue, 21 Mar 2023 19:05:55 +0800
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20230317063246.1128219-1-zangchunxin@lixiang.com> <a32fe0a9986451d8713fced841df7d4b941f14f1.camel@gmx.de>
X-Lms-Return-Path: <lba+264198f93+0b7118+vger.kernel.org+zangchunxin@lixiang.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Cc:     "Namhyung Kim" <namhyung@kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Jerry Zhou" <zhouchunhua@lixiang.com>
In-Reply-To: <a32fe0a9986451d8713fced841df7d4b941f14f1.camel@gmx.de>
To:     "Mike Galbraith" <efault@gmx.de>
From:   "Chunxin Zang" <zangchunxin@lixiang.com>
Subject: Re: [PATCH v3] perf sched: Fix sched latency analysis incorrect
Message-Id: <FB8E4CD4-DBC8-4D6D-AD2C-E038924967BC@lixiang.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ad961245aebc28a7ee441470c0a743cb2feae329a3f38362f75863a3ebd1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

> On Mar 21, 2023, at 15:32, Mike Galbraith <efault@gmx.de> wrote:
>=20
> On Fri, 2023-03-17 at 14:32 +0800, Chunxin Zang wrote:
>> 'perf sched latency' is incorrect to get process schedule latency
>> when it used 'sched:sched_wakeup' to analysis perf.data.
>>=20
>> Because 'perf record' prefer use 'sched:sched_waking' to
>> 'sched:sched_wakeup' since commit d566a9c2d482 ("perf sched: Prefer
>> sched_waking event when it exists"). It's very reasonable to
>> evaluate process schedule latency.
>=20
> Yeah, that makes a.. not so tiny difference.  Thanks.
> (off to flush large pile of.. not data)
>=20
> su - mikeg -c 'google-chrome-stable https://www.youtube.com/watch?v=3Daqz=
-KE-bpKQ > /dev/null 2>&1'&
> massive_intr 8 9999&
> # allow time to select display size/res
> sleep 10
> perf sched record -a -- cyclictest -Smqi 1234 -d 0&
> sleep 300
> killall cyclictest
> sleep 1
> killall massive_intr chrome
>=20
> cyclictest output
> T: 0 (10255) P: 0 I:1234 C: 194367 Min:      4 Act:   55 Avg:  484 Max:  =
 22776
> T: 1 (10256) P: 0 I:1234 C: 194346 Min:      6 Act:   57 Avg:  480 Max:  =
 18589
> T: 2 (10257) P: 0 I:1234 C: 194034 Min:      5 Act: 5214 Avg:  482 Max:  =
 18530
> T: 3 (10258) P: 0 I:1234 C: 192263 Min:      5 Act:   54 Avg:  513 Max:  =
 19385
> T: 4 (10259) P: 0 I:1234 C: 193350 Min:      6 Act:  728 Avg:  492 Max:  =
 15951
> T: 5 (10260) P: 0 I:1234 C: 196233 Min:      6 Act:   56 Avg:  469 Max:  =
 17905
> T: 6 (10261) P: 0 I:1234 C: 194181 Min:      5 Act:   67 Avg:  482 Max:  =
 17997
> T: 7 (10262) P: 0 I:1234 C: 196756 Min:      7 Act:  284 Avg:  468 Max:  =
 16287
>=20
> cyclictest bits of perf sched lat -p output, sorted ala cyclictest (local=
 hackletlet sums delay)
> -------------------------------------------------------------------------=
----------------------------------
>  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
> -------------------------------------------------------------------------=
----------------------------------
>  cyclictest:10255      |   1280.359 ms |      294 | avg:   0.238 ms | max=
:   4.929 ms | sum:   69.921 ms |
>  cyclictest:10256      |   1293.976 ms |      163 | avg:   0.463 ms | max=
:   6.619 ms | sum:   75.497 ms |
>  cyclictest:10257      |   1259.701 ms |      206 | avg:   0.371 ms | max=
:   5.659 ms | sum:   76.453 ms |
>  cyclictest:10258      |   1299.337 ms |      171 | avg:   0.440 ms | max=
:   4.210 ms | sum:   75.267 ms |
>  cyclictest:10259      |   1436.543 ms |      181 | avg:   0.472 ms | max=
:   8.466 ms | sum:   85.473 ms |
>  cyclictest:10260      |   1401.824 ms |      210 | avg:   0.386 ms | max=
:   7.007 ms | sum:   81.036 ms |
>  cyclictest:10261      |   1336.621 ms |      190 | avg:   0.387 ms | max=
:   4.244 ms | sum:   73.593 ms |
>  cyclictest:10262      |   1393.249 ms |      283 | avg:   0.268 ms | max=
:   4.381 ms | sum:   75.778 ms |
> +patchlet
>  cyclictest:10252      |    218.546 ms |    28657 | avg:   0.437 ms | max=
:  12.616 ms | sum:12514.777 ms | <=3D=3D *poof*

I observed the different things is 'cyclictest:10252' data only exist in pa=
tchlet data.=20
So I run the 'perf sched record -a -- cyclictest -Smqi 1234 -d 0 ' try to f=
ind the reason.
I get the following data.

$: perf sched record -a -- ./cyclictest -Smqi 1234 -d 0

# /dev/cpu_dma_latency set to 0us
^C[ perf record: Woken up 41 times to write data ]
T: 0 (1188076) P: 0 I:1234 C:   5655 Min:      7 Act:   57 Avg:   57 Max:  =
  1394
T: 1 (1188077) P: 0 I:1234 C:   5656 Min:      7 Act:   57 Avg:   56 Max:  =
    86
T: 2 (1188078) P: 0 I:1234 C:   5654 Min:      6 Act:   57 Avg:   57 Max:  =
  1133
T: 3 (1188079) P: 0 I:1234 C:   5653 Min:      7 Act:   58 Avg:   57 Max:  =
   575
T: 4 (1188080) P: 0 I:1234 C:   5649 Min:      8 Act:   57 Avg:   57 Max:  =
  2878
T: 5 (1188081) P: 0 I:1234 C:   5650 Min:      9 Act:   57 Avg:   56 Max:  =
   420
T: 6 (1188082) P: 0 I:1234 C:   5642 Min:      8 Act:   57 Avg:   58 Max:  =
  7944
T: 7 (1188083) P: 0 I:1234 C:   5647 Min:      7 Act:   57 Avg:   56 Max:  =
    64
T: 8 (1188084) P: 0 I:1234 C:   5612 Min:      8 Act:   57 Avg:   66 Max:  =
 10684
T: 9 (1188085) P: 0 I:1234 C:   5644 Min:      8 Act:   57 Avg:   56 Max:  =
   127
T:10 (1188086) P: 0 I:1234 C:   5643 Min:      8 Act:   57 Avg:   56 Max:  =
   118
T:11 (1188087) P: 0 I:1234 C:   5642 Min:      7 Act:   57 Avg:   56 Max:  =
    64
T:12 (1188088) P: 0 I:1234 C:   5616 Min:      7 Act:   58 Avg:   65 Max:  =
  9961
T:13 (1188089) P: 0 I:1234 C:   5638 Min:      7 Act:   57 Avg:   56 Max:  =
  1545
T:14 (1188090) P: 0 I:1234 C:   5637 Min:      7 Act:   57 Avg:   57 Max:  =
  1394
T:15 (1188091) P: 0 I:1234 C:   5636 Min:      7 Act:   57 Avg:   56 Max:  =
    75
T:16 (1188092) P: 0 I:1234 C:   5634 Min:      5 Act:   55 Avg:   53 Max:  =
  1528
T:17 (1188093) P: 0 I:1234 C:   5633 Min:      4 Act:   54 Avg:   53 Max:  =
   315
T:18 (1188094) P: 0 I:1234 C:   5632 Min:      5 Act:   54 Avg:   53 Max:  =
    85
T:19 (1188095) P: 0 I:1234 C:   5630 Min:      6 Act:  138 Avg:   38 Max:  =
  1356
[ perf record: Captured and wrote 105.442 MB perf.data (923494 samples) ]

The old perf tools data.
$: perf sched latecy -p | grep cyclictest | sort
  cyclictest:1152095    |      3.343 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152097    |     25.832 ms |        4 | avg:   0.003 ms | max:=
   0.004 ms | max start: 7371180.979819 s | max end: 7371180.979823 s
  cyclictest:1152098    |     25.594 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152099    |     25.558 ms |        2 | avg:   0.003 ms | max:=
   0.006 ms | max start: 7371180.984052 s | max end: 7371180.984058 s
  cyclictest:1152100    |     15.465 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152101    |     26.697 ms |        2 | avg:   0.003 ms | max:=
   0.005 ms | max start: 7371180.988301 s | max end: 7371180.988306 s
  cyclictest:1152102    |     26.330 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152103    |     26.380 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152104    |     25.926 ms |        2 | avg:   0.003 ms | max:=
   0.006 ms | max start: 7371180.990549 s | max end: 7371180.990554 s
  cyclictest:1152105    |     27.589 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152106    |     26.510 ms |        2 | avg:   0.003 ms | max:=
   0.005 ms | max start: 7371180.995015 s | max end: 7371180.995020 s
  cyclictest:1152107    |     25.325 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152108    |     25.275 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152109    |     15.515 ms |        2 | avg:   0.002 ms | max:=
   0.004 ms | max start: 7371182.862877 s | max end: 7371182.862881 s
  cyclictest:1152110    |     26.835 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152111    |     25.849 ms |        2 | avg:   0.001 ms | max:=
   0.002 ms | max start: 7371180.977996 s | max end: 7371180.977998 s
  cyclictest:1152112    |     26.192 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152113    |     18.339 ms |        2 | avg:   0.002 ms | max:=
   0.005 ms | max start: 7371180.986046 s | max end: 7371180.986051 s
  cyclictest:1152114    |     18.341 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152115    |     17.949 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1152116    |     19.291 ms |        4 | avg:   0.003 ms | max:=
   0.005 ms | max start: 7371180.363769 s | max end: 7371180.363774 s
  cyclictest:1188074    |     38.122 ms |        1 | avg:   0.000 ms | max:=
   0.000 ms | max start:     0.000000 s | max end:     0.000000 s
  cyclictest:1188076    |     26.020 ms |        2 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371180.984074 s | max end: 7371180.984078 s
  cyclictest:1188077    |     25.949 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.884309 s | max end: 7371175.884313 s
  cyclictest:1188078    |     26.184 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.886010 s | max end: 7371175.886014 s
  cyclictest:1188079    |     28.886 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.887703 s | max end: 7371175.887707 s
  cyclictest:1188080    |     25.228 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.889413 s | max end: 7371175.889417 s
  cyclictest:1188081    |     25.239 ms |        3 | avg:   0.007 ms | max:=
   0.011 ms | max start: 7371180.965735 s | max end: 7371180.965746 s
  cyclictest:1188082    |     25.371 ms |        2 | avg:   0.005 ms | max:=
   0.006 ms | max start: 7371180.965845 s | max end: 7371180.965851 s
  cyclictest:1188083    |     26.238 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.894465 s | max end: 7371175.894469 s
  cyclictest:1188084    |     25.658 ms |        3 | avg:   0.005 ms | max:=
   0.005 ms | max start: 7371180.967776 s | max end: 7371180.967781 s
  cyclictest:1188085    |     26.492 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.897930 s | max end: 7371175.897934 s
  cyclictest:1188086    |     26.397 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.899613 s | max end: 7371175.899617 s
  cyclictest:1188087    |     26.481 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.901338 s | max end: 7371175.901342 s
  cyclictest:1188088    |     29.591 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.903018 s | max end: 7371175.903022 s
  cyclictest:1188089    |     25.619 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.904778 s | max end: 7371175.904782 s
  cyclictest:1188090    |     30.952 ms |        4 | avg:   0.015 ms | max:=
   0.050 ms | max start: 7371180.975854 s | max end: 7371180.975903 s
  cyclictest:1188091    |     26.220 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.908250 s | max end: 7371175.908254 s
  cyclictest:1188092    |     18.931 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.909970 s | max end: 7371175.909974 s
  cyclictest:1188093    |     19.135 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.911677 s | max end: 7371175.911681 s
  cyclictest:1188094    |     19.145 ms |        1 | avg:   0.004 ms | max:=
   0.004 ms | max start: 7371175.913420 s | max end: 7371175.913424 s
  cyclictest:1188095    |     19.193 ms |        1 | avg:   0.005 ms | max:=
   0.005 ms | max start: 7371175.915139 s | max end: 7371175.915144 s

The patchlet perf data.
$: /root/perf sched latency -i ./perf.data -p | grep cyclictest | sort
  cyclictest:1152095    |      3.343 ms |      694 | avg:   0.003 ms | max:=
   0.206 ms | max start: 7371181.289279 s | max end: 7371181.289486 s
  cyclictest:1152097    |     25.832 ms |     5663 | avg:   0.004 ms | max:=
   0.806 ms | max start: 7371180.245354 s | max end: 7371180.246160 s
  cyclictest:1152098    |     25.594 ms |     5659 | avg:   0.003 ms | max:=
   0.016 ms | max start: 7371180.466516 s | max end: 7371180.466532 s
  cyclictest:1152099    |     25.558 ms |     5660 | avg:   0.004 ms | max:=
   0.929 ms | max start: 7371180.962911 s | max end: 7371180.963840 s
  cyclictest:1152100    |     15.465 ms |     5659 | avg:   0.006 ms | max:=
   0.525 ms | max start: 7371180.979260 s | max end: 7371180.979785 s
  cyclictest:1152101    |     26.697 ms |     5659 | avg:   0.004 ms | max:=
   2.952 ms | max start: 7371180.250317 s | max end: 7371180.253269 s
  cyclictest:1152102    |     26.330 ms |     5659 | avg:   0.003 ms | max:=
   0.359 ms | max start: 7371180.977488 s | max end: 7371180.977847 s
  cyclictest:1152103    |     26.380 ms |     5652 | avg:   0.005 ms | max:=
   8.230 ms | max start: 7371180.227552 s | max end: 7371180.235782 s
  cyclictest:1152104    |     25.926 ms |     5660 | avg:   0.003 ms | max:=
   0.060 ms | max start: 7371180.990483 s | max end: 7371180.990543 s
  cyclictest:1152105    |     27.589 ms |     5620 | avg:   0.015 ms | max:=
  10.972 ms | max start: 7371180.804812 s | max end: 7371180.815785 s
  cyclictest:1152106    |     26.510 ms |     5660 | avg:   0.003 ms | max:=
   0.158 ms | max start: 7371180.994849 s | max end: 7371180.995007 s
  cyclictest:1152107    |     25.325 ms |     5659 | avg:   0.003 ms | max:=
   0.947 ms | max start: 7371180.986531 s | max end: 7371180.987478 s
  cyclictest:1152108    |     25.275 ms |     5659 | avg:   0.003 ms | max:=
   0.129 ms | max start: 7371176.369231 s | max end: 7371176.369360 s
  cyclictest:1152109    |     15.515 ms |     5627 | avg:   0.017 ms | max:=
   9.912 ms | max start: 7371180.228257 s | max end: 7371180.238169 s
  cyclictest:1152110    |     26.835 ms |     5658 | avg:   0.003 ms | max:=
   1.647 ms | max start: 7371180.258250 s | max end: 7371180.259897 s
  cyclictest:1152111    |     25.849 ms |     5659 | avg:   0.004 ms | max:=
   1.679 ms | max start: 7371180.242512 s | max end: 7371180.244191 s
  cyclictest:1152112    |     26.192 ms |     5659 | avg:   0.003 ms | max:=
   0.009 ms | max start: 7371177.911768 s | max end: 7371177.911778 s
  cyclictest:1152113    |     18.339 ms |     5660 | avg:   0.002 ms | max:=
   0.944 ms | max start: 7371180.246854 s | max end: 7371180.247797 s
  cyclictest:1152114    |     18.341 ms |     5659 | avg:   0.002 ms | max:=
   0.423 ms | max start: 7371180.248383 s | max end: 7371180.248806 s
  cyclictest:1152115    |     17.949 ms |     5659 | avg:   0.002 ms | max:=
   0.036 ms | max start: 7371175.960511 s | max end: 7371175.960548 s
  cyclictest:1152116    |     19.291 ms |     5661 | avg:   0.005 ms | max:=
   1.324 ms | max start: 7371180.257638 s | max end: 7371180.258961 s
  cyclictest:1188074    |     38.122 ms |      692 | avg:   0.003 ms | max:=
   0.010 ms | max start: 7371175.995600 s | max end: 7371175.995610 s
  cyclictest:1188076    |     26.020 ms |     5656 | avg:   0.004 ms | max:=
   1.341 ms | max start: 7371180.244813 s | max end: 7371180.246154 s
  cyclictest:1188077    |     25.949 ms |     5656 | avg:   0.003 ms | max:=
   0.033 ms | max start: 7371180.268781 s | max end: 7371180.268814 s
  cyclictest:1188078    |     26.184 ms |     5654 | avg:   0.003 ms | max:=
   1.079 ms | max start: 7371180.962756 s | max end: 7371180.963835 s
  cyclictest:1188079    |     28.886 ms |     5653 | avg:   0.004 ms | max:=
   0.521 ms | max start: 7371180.979258 s | max end: 7371180.979779 s
  cyclictest:1188080    |     25.228 ms |     5650 | avg:   0.003 ms | max:=
   2.824 ms | max start: 7371180.250439 s | max end: 7371180.253263 s
  cyclictest:1188081    |     25.239 ms |     5652 | avg:   0.003 ms | max:=
   0.349 ms | max start: 7371180.965380 s | max end: 7371180.965729 s
  cyclictest:1188082    |     25.371 ms |     5643 | avg:   0.005 ms | max:=
   7.891 ms | max start: 7371180.227887 s | max end: 7371180.235778 s
  cyclictest:1188083    |     26.238 ms |     5647 | avg:   0.003 ms | max:=
   0.010 ms | max start: 7371181.073635 s | max end: 7371181.073645 s
  cyclictest:1188084    |     25.658 ms |     5614 | avg:   0.013 ms | max:=
  10.631 ms | max start: 7371180.805141 s | max end: 7371180.815771 s
  cyclictest:1188085    |     26.492 ms |     5645 | avg:   0.003 ms | max:=
   0.073 ms | max start: 7371180.988249 s | max end: 7371180.988322 s
  cyclictest:1188086    |     26.397 ms |     5643 | avg:   0.003 ms | max:=
   0.064 ms | max start: 7371177.544604 s | max end: 7371177.544667 s
  cyclictest:1188087    |     26.481 ms |     5642 | avg:   0.003 ms | max:=
   0.011 ms | max start: 7371180.211768 s | max end: 7371180.211778 s
  cyclictest:1188088    |     29.591 ms |     5617 | avg:   0.012 ms | max:=
   9.908 ms | max start: 7371180.228256 s | max end: 7371180.238165 s
  cyclictest:1188089    |     25.619 ms |     5638 | avg:   0.003 ms | max:=
   1.490 ms | max start: 7371180.258401 s | max end: 7371180.259890 s
  cyclictest:1188090    |     30.952 ms |     5640 | avg:   0.004 ms | max:=
   1.339 ms | max start: 7371180.242847 s | max end: 7371180.244186 s
  cyclictest:1188091    |     26.220 ms |     5636 | avg:   0.003 ms | max:=
   0.022 ms | max start: 7371180.712279 s | max end: 7371180.712301 s
  cyclictest:1188092    |     18.931 ms |     5634 | avg:   0.002 ms | max:=
   1.473 ms | max start: 7371180.246318 s | max end: 7371180.247791 s
  cyclictest:1188093    |     19.135 ms |     5634 | avg:   0.002 ms | max:=
   0.259 ms | max start: 7371180.243086 s | max end: 7371180.243345 s
  cyclictest:1188094    |     19.145 ms |     5632 | avg:   0.002 ms | max:=
   0.031 ms | max start: 7371180.244828 s | max end: 7371180.244859 s
  cyclictest:1188095    |     19.193 ms |     5630 | avg:   0.003 ms | max:=
   1.314 ms | max start: 7371180.257641 s | max end: 7371180.258955 s

Obviously, there are some cases that are counted as zero in perf.data which=
 is generated
by old perf tools, such as 'cyclictest:1152098'.
I use 'perf script'  and get the following info.

         swapper     0 [001] 7371175.879738:       sched:sched_waking: comm=
=3Dcyclictest pid=3D1152098 prio=3D125 target_cpu=3D001
         swapper     0 [001] 7371175.879741:       sched:sched_switch: prev=
_comm=3Dswapper/1 prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D> next_=
comm=3Dcyclictest next_pid=3D1152098 next_prio=3D125
      cyclictest 1152098 [001] 7371175.879744: sched:sched_stat_runtime: co=
mm=3Dcyclictest pid=3D1152098 runtime=3D5279 [ns] vruntime=3D100770994135 [=
ns]
            perf 1187996 [015] 7371175.879744: sched:sched_stat_runtime: co=
mm=3Dperf pid=3D1187996 runtime=3D24807 [ns] vruntime=3D28338406886 [ns]
      cyclictest 1152098 [001] 7371175.879745:       sched:sched_switch: pr=
ev_comm=3Dcyclictest prev_pid=3D1152098 prev_prio=3D125 prev_state=3DS =3D=
=3D> next_comm=3Dswapper/1 next_pid=3D0 next_prio=3D120
            perf 1187996 [015] 7371175.879746:       sched:sched_waking: co=
mm=3Dmigration/15 pid=3D103 prio=3D0 target_cpu=3D015

	... ...

         swapper     0 [001] 7371175.880972:       sched:sched_waking: comm=
=3Dcyclictest pid=3D1152098 prio=3D125 target_cpu=3D001
         swapper     0 [001] 7371175.880975:       sched:sched_switch: prev=
_comm=3Dswapper/1 prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D> next_=
comm=3Dcyclictest next_pid=3D1152098 next_prio=3D125
      cyclictest 1152098 [001] 7371175.880978: sched:sched_stat_runtime: co=
mm=3Dcyclictest pid=3D1152098 runtime=3D5481 [ns] vruntime=3D100771010888 [=
ns]
      cyclictest 1152098 [001] 7371175.880979:       sched:sched_switch: pr=
ev_comm=3Dcyclictest prev_pid=3D1152098 prev_prio=3D125 prev_state=3DS =3D=
=3D> next_comm=3Dswapper/1 next_pid=3D0 next_prio=3D120

In fact, the 'cyclictest:1152098' was sched_waking at 7371175.880972, and s=
ched_switch
at 7371175.880975 in second context, so it's can't be zero.
The reason is the old perf tools  isn't use 'sched_waking' event to analysi=
s data,
and 'cyclictest:1152098' state is 'S' on previous sched_switch at 7371175.8=
79745,
the perf tools isn't find the beginning time of 'cyclictest:1152098' which =
was putted on runqueue in perf.data.=20

      cyclictest 1152097 [000] 7371180.979817:       sched:sched_waking: co=
mm=3Dkworker/0:2 pid=3D1074142 prio=3D120 target_cpu=3D000
             cut 1188136 [012] 7371180.979818: sched:sched_stat_runtime: co=
mm=3Dcut pid=3D1188136 runtime=3D2024 [ns] vruntime=3D232844433506260 [ns]
      cyclictest 1152097 [000] 7371180.979818: sched:sched_stat_runtime: co=
mm=3Dcyclictest pid=3D1152097 runtime=3D4303 [ns] vruntime=3D505223436640 [=
ns]
      cyclictest 1152097 [000] 7371180.979819:       sched:sched_switch: pr=
ev_comm=3Dcyclictest prev_pid=3D1152097 prev_prio=3D125 prev_state=3DR =3D=
=3D> next_comm=3Dkworker/0:2 next_pid=3D1074142 next_prio=3D120
             :-1    -1 [012] 7371180.979822:       sched:sched_waking: comm=
=3Dmigration/2 pid=3D25 prio=3D0 target_cpu=3D002
 kworker/0:2-eve 1074142 [000] 7371180.979822: sched:sched_stat_runtime: co=
mm=3Dkworker/0:2 pid=3D1074142 runtime=3D5032 [ns] vruntime=3D1136450599971=
14 [ns]
 kworker/0:2-eve 1074142 [000] 7371180.979823:       sched:sched_switch: pr=
ev_comm=3Dkworker/0:2 prev_pid=3D1074142 prev_prio=3D120 prev_state=3DI =3D=
=3D> next_comm=3Dcyclictest next_pid=3D1152097 next_prio=3D125
             :-1    -1 [012] 7371180.979823:       sched:sched_switch: prev=
_comm=3Dcut prev_pid=3D1188136 prev_prio=3D120 prev_state=3DX =3D=3D> next_=
comm=3Dswapper/12 next_pid=3D0 next_prio=3D120

The 'cyclictest:1152097' case is't counted as zero is because of it's state=
 is 'R'
in previous sched_switch at 7371180.979819, and old perf tools is find the =
beginning
time when it was putted on runqueue.

That's the issue which I want to fix.
And the reason may be makes you get the difference result in your context.=
=20

Best wishes
-Chunxin

>  cyclictest:10255      |   1280.359 ms |   194661 | avg:   0.431 ms | max=
:  22.722 ms | sum:83954.384 ms |
>  cyclictest:10256      |   1293.976 ms |   194509 | avg:   0.427 ms | max=
:  18.537 ms | sum:83115.895 ms |
>  cyclictest:10257      |   1259.701 ms |   194240 | avg:   0.429 ms | max=
:  18.509 ms | sum:83408.424 ms |
>  cyclictest:10258      |   1299.337 ms |   192434 | avg:   0.460 ms | max=
:  19.331 ms | sum:88555.775 ms |
>  cyclictest:10259      |   1436.543 ms |   193531 | avg:   0.439 ms | max=
:  15.897 ms | sum:84989.121 ms |
>  cyclictest:10260      |   1401.824 ms |   196443 | avg:   0.417 ms | max=
:  17.852 ms | sum:81818.898 ms |
>  cyclictest:10261      |   1336.621 ms |   194371 | avg:   0.429 ms | max=
:  17.944 ms | sum:83443.732 ms |
>  cyclictest:10262      |   1393.249 ms |   197039 | avg:   0.415 ms | max=
:  16.232 ms | sum:81752.473 ms |
>=20
>=20
> -Mike

=E5=A3=B0=E6=98=8E=EF=BC=9A=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E5=8F=AA=E5=
=85=81=E8=AE=B8=E6=96=87=E4=BB=B6=E6=8E=A5=E6=94=B6=E8=80=85=E9=98=85=E8=AF=
=BB=EF=BC=8C=E6=9C=89=E5=BE=88=E9=AB=98=E7=9A=84=E6=9C=BA=E5=AF=86=E6=80=A7=
=E8=A6=81=E6=B1=82=E3=80=82=E7=A6=81=E6=AD=A2=E5=85=B6=E4=BB=96=E4=BA=BA=E4=
=BD=BF=E7=94=A8=E3=80=81=E6=89=93=E5=BC=80=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=
=96=E8=BD=AC=E5=8F=91=E9=87=8C=E9=9D=A2=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=
=E5=AE=B9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E9=82=AE=E4=BB=B6=E9=94=99=E8=
=AF=AF=E5=9C=B0=E5=8F=91=E7=BB=99=E4=BA=86=E4=BD=A0=EF=BC=8C=E8=AF=B7=E8=81=
=94=E7=B3=BB=E9=82=AE=E4=BB=B6=E5=8F=91=E5=87=BA=E8=80=85=E5=B9=B6=E5=88=A0=
=E9=99=A4=E8=BF=99=E4=B8=AA=E6=96=87=E4=BB=B6=E3=80=82=E6=9C=BA=E5=AF=86=E5=
=8F=8A=E6=B3=95=E5=BE=8B=E7=9A=84=E7=89=B9=E6=9D=83=E5=B9=B6=E4=B8=8D=E5=9B=
=A0=E4=B8=BA=E8=AF=AF=E5=8F=91=E9=82=AE=E4=BB=B6=E8=80=8C=E6=94=BE=E5=BC=83=
=E6=88=96=E4=B8=A7=E5=A4=B1=E3=80=82=E4=BB=BB=E4=BD=95=E6=8F=90=E5=87=BA=E7=
=9A=84=E8=A7=82=E7=82=B9=E6=88=96=E6=84=8F=E8=A7=81=E5=8F=AA=E5=B1=9E=E4=BA=
=8E=E4=BD=9C=E8=80=85=E7=9A=84=E4=B8=AA=E4=BA=BA=E8=A7=81=E8=A7=A3=EF=BC=8C=
=E5=B9=B6=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=BB=A3=E8=A1=A8=E6=9C=AC=E5=85=AC=E5=
=8F=B8=E3=80=82
--ad961245aebc28a7ee441470c0a743cb2feae329a3f38362f75863a3ebd1--
