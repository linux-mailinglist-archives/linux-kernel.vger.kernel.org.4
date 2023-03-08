Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925A56B01B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCHIkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCHIkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:40:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6597010FF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678264765; i=efault@gmx.de;
        bh=bbK2UDnqbq5+/ffHtdJjZ5PXuOApAVyvHtt7EsD5S6o=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=X9pSN+W8G9wQ9OKNFfaq5oPRKq3AVMNblWmc9VJV2SvtWah7LfPj4UuVcdAuy5YGS
         h/LsoI/+OZCtvaJ7V6XDQJK9K8DQDfyWlItgXpSVPB/EoD56Vs7HFU1j7HPPAPiV8j
         E5QoqTeCfDSkxLhDDnvC6tt6SFZfhzKBMLT7x/2u4bmmN52CaxLF2G1x78BhbB6IOB
         ZEP6NT03yki7o8HIVie5tnXSTKuQz5qNXhJmZjEzDimDwl3TiGQ4+uXaR/zTVMcGxy
         C3XqWtAY7VL93AwWIycMVSy++mRDYpjVEJXx5mO+e4+mVzpRItB1yshHS0RtAhuYWs
         5Av5TL6XT4HuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.250]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6sn7-1qdfFK1ywB-018G2m; Wed, 08
 Mar 2023 09:39:25 +0100
Message-ID: <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
Subject: Re: [PATCH 10/10] sched/fair: Implement an EEVDF like policy
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Date:   Wed, 08 Mar 2023 09:39:21 +0100
In-Reply-To: <20230306141502.810909205@infradead.org>
References: <20230306132521.968182689@infradead.org>
         <20230306141502.810909205@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yWFLTaqNaEmxq+GQO4IcdJJ0iS0zFF0xuSOc7fJ75EWZGgUFzmx
 NT6UBH20NIoHAIlBRNdyLC2GJ5S24GBoqkeG19AXbvH4RYaFhbXX/VFpzrOJwRPdnO9IBc+
 90TJ4NkzALoDOE9t87tdIyh9eJluHfXRP0U0eRmn+sM8G+2CgVRLQQsNJYuNdrIThU+Q1nw
 8vRn4HPCQ7YmMQtammknw==
UI-OutboundReport: notjunk:1;M01:P0:LQul+FR0VZs=;/KMQmUhah75NkM3JAs+nxH037V8
 /uvXuWEFfxXrirombjLqxQX+Z3X3Q9EgDntOPh/BTq769LzJbKQFKKD8jPnsjNMN+Y08i0Lgy
 t/6C1AGXY34nHCta3/fPyi2QdqhMbashl/UfpOQFEDKIhk96/BZlSTtstecPVV7fTUMmP2uox
 dE9r6VIh1NFe9J8atsH3roY4aY/D9PzlTNn2jEI4/GodLa8HFrPNwy0/PRqNUZUG8H//qdGJK
 LMgKyjRogKeoSi9hIRGLiYjlj2iaABARTd7iCu2crGlriFm1E0IFxXttEBODXuOvv2z9MxiM3
 WT86QHLqKRPGuIuf8UT+GlKl0Kr4isZG7ED8iSlhpCbSQ1Uz363G+r3OdBzeeul4a3Vg4QY5H
 HmTirzIV9htE/7qqhbgdaxVVi5S7lYezdLlbQAueybPncQf/XPYT6m+PMuuLQgCpiG80q0gUj
 mzx9gAERgPh3xVMW5nFAfWAV2mZk87qaz2UxMqT95iQldz1KzzmKVp1BR45SX5gX1A/8usRnb
 mn7Pwzls7EcdwW9BDjtl+ZC6kt1pO+ETP+B8Q5XMRpJCdC5vFL05+7WpVjUjR1QJpooWpUNxD
 lzCx2B2vpJPK1gE++Qdd/LtwB9OPQ1Sk+qGxToKNcOdNCfm3yId3YdDkGnV9TuxhE08cwDOmA
 MJgv76f+nyRSEgT2dQKP9/bV0u/FXhTUYigFTnm1Z882goEnF0iycptuGTHPVbNwrb2ekRBQc
 TrulkEtXaPlbNONNUjSfoBO5pCDPyUQwNBkAmoU/D1F781J0fMq0K/NShPdE/9ay/378X6NfD
 216QkIOv5x7q7Nfn6nMuW9SB+Oc63qqf8tzEnCzyMWh6wLzsVKiGRdWZRqdLE0YoCQbbqHc3O
 Tjzhc84sEz2d7MOUgU8ZmkNE7lxSKqNw0pkYUAgvIHEft0Af/sqAOS1O36vVnZMuOQJVUXYAn
 peyis6wjND1IinKLxu8dWdaqSWc=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-06 at 14:25 +0100, Peter Zijlstra wrote:
> Where CFS is currently a WFQ based scheduler with only a single knob,
> the weight. The addition of a second, latency oriented parameter,
> makes something like WF2Q or EEVDF based a much better fit.
>
> Specifically, EEVDF does EDF like scheduling in the left half of the
> tree -- those entities that are owed service. Except because this is a
> virtual time scheduler, the deadlines are in virtual time as well,
> which is what allows over-subscription.

Curiosity got the best of me, and I stuffed this series into master and
did a little light testing.  Unsurprisingly, the numbers move about as
they are wont to do when you diddle anything in sched-land, most
notable were the UDP_STREAM numbers which moved a LOT.

Another thing I found interesting was in the comparison of massive_intr
vs youtube clip load.  I was expecting less scheduling from +eevdf
tree, but got more in total and more total wait time.

Season to taste or just toss: I didn't start with a virgin tree, though
local hacks *should* be meaningless to tbench and netperf, and while
they reduce stacking, they make zero perceptible difference to the
desktop, and are common to both trees.

Some numbers:
box is old i4790 desktop box

30 sec tbench
6.3.0.g8ca09d5
Throughput 3655.33 MB/sec  8 clients  8 procs  max_latency=3D16.322 ms
Throughput 3651.73 MB/sec  8 clients  8 procs  max_latency=3D16.260 ms
Throughput 3627.60 MB/sec  8 clients  8 procs  max_latency=3D16.262 ms
6.3.0.g8ca09d5+eevdf
Throughput 3497.39 MB/sec  8 clients  8 procs  max_latency=3D12.380 ms
Throughput 3403.28 MB/sec  8 clients  8 procs  max_latency=3D12.296 ms
Throughput 3466.86 MB/sec  8 clients  8 procs  max_latency=3D12.349 ms
avg vs avg     .948


netperf                   cfs +eevdf  vs cfs
TCP_SENDFILE-1    Avg:  89258  92080   1.031
TCP_SENDFILE-2    Avg:  83271  83371   1.001
TCP_SENDFILE-4    Avg:  56395  53011    .939
TCP_SENDFILE-8    Avg:  26389  39470   1.495
TCP_SENDFILE-16   Avg:  10251  19590   1.911
TCP_STREAM-1      Avg:  72583  71276    .981
TCP_STREAM-2      Avg:  59627  54424    .912
TCP_STREAM-4      Avg:  33310  22717    .681
TCP_STREAM-8      Avg:   8062   7718    .957
TCP_STREAM-16     Avg:   5143   3726    .724
TCP_MAERTS-1      Avg:  72897  71052    .974
TCP_MAERTS-2      Avg:  55065  60022   1.090
TCP_MAERTS-4      Avg:  45525  26531    .582
TCP_MAERTS-8      Avg:  11435   7937    .694
TCP_MAERTS-16     Avg:    5437  3351    .616
TCP_RR-1          Avg: 192766 180505    .936
TCP_RR-2          Avg: 169043 164731    .974
TCP_RR-4          Avg: 115702 110938    .958
TCP_RR-8          Avg: 113085 111775    .988
TCP_RR-16         Avg:  55226  53439    .967
UDP_RR-1          Avg: 261076 242027    .927
UDP_RR-2          Avg: 224808 221913    .987
UDP_RR-4          Avg: 158232 155162    .980
UDP_RR-8          Avg: 152255 149527    .982
UDP_RR-16         Avg:  75148  72739    .967
UDP_STREAM-1      Avg: 102612 102728   1.001 hmm: UDP_STREAM deltas verifi=
ed repeatable
UDP_STREAM-2      Avg:  93774  93563    .997
UDP_STREAM-4      Avg:  54728  55702   1.017
UDP_STREAM-8      Avg:  30153  63329   2.100
UDP_STREAM-16     Avg:  12997  31644   2.434

(if your mailer don't do wide, this is gonna make a mess)

youtube BigBuckBunny vs 8 hogs (ancient 8ms run 1ms sleep cpu distribution=
 checker)
massive_intr 8 9999& perf sched record -- firefox https://www.youtube.com/=
watch?v=3Daqz-KE-bpKQ& sleep 300;killall massive_intr firefox
note: perf obviously twiddled to add 'Sum delay'.

6.3.0.g8ca09d5
 -------------------------------------------------------------------------=
--------------------------------------------------------------------------=
-----------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     | Max delay start           | Max delay en=
d          |
 -------------------------------------------------------------------------=
--------------------------------------------------------------------------=
-----------
  Renderer:5410         | 201867.875 ms |   106745 | avg:   0.468 ms | max=
:  22.465 ms | sum:49998.624 ms | max start:   100.880096 s | max end:   1=
00.902561 s
  SwComposite:5453      | 189304.441 ms |    73405 | avg:   0.595 ms | max=
:  23.934 ms | sum:43657.252 ms | max start:   155.074533 s | max end:   1=
55.098467 s
  massive_intr:5571     | 179445.480 ms |    79984 | avg:   0.705 ms | max=
:  22.822 ms | sum:56395.232 ms | max start:   289.707867 s | max end:   2=
89.730689 s
  massive_intr:5569     | 179337.834 ms |    80101 | avg:   0.711 ms | max=
:  25.517 ms | sum:56965.103 ms | max start:   103.652981 s | max end:   1=
03.678498 s
  massive_intr:5575     | 179190.634 ms |    79433 | avg:   0.720 ms | max=
:  18.873 ms | sum:57223.508 ms | max start:   223.520540 s | max end:   2=
23.539413 s
  massive_intr:5568     | 179081.476 ms |    77118 | avg:   0.742 ms | max=
:  21.715 ms | sum:57188.088 ms | max start:    90.071642 s | max end:    =
90.093358 s
  massive_intr:5574     | 179079.481 ms |    78924 | avg:   0.723 ms | max=
:  23.821 ms | sum:57024.111 ms | max start:   345.637059 s | max end:   3=
45.660881 s
  massive_intr:5570     | 178945.128 ms |    79466 | avg:   0.724 ms | max=
:  22.105 ms | sum:57554.610 ms | max start:    90.511319 s | max end:    =
90.533423 s
  massive_intr:5572     | 178867.227 ms |    80016 | avg:   0.717 ms | max=
:  25.140 ms | sum:57393.314 ms | max start:   193.801127 s | max end:   1=
93.826267 s
  massive_intr:5573     | 178560.808 ms |    79764 | avg:   0.719 ms | max=
:  40.232 ms | sum:57338.388 ms | max start:    87.446558 s | max end:    =
87.486790 s
  X:2492                |  86585.854 ms |    17924 | avg:   0.294 ms | max=
:  20.053 ms | sum: 5262.780 ms | max start:   106.798324 s | max end:   1=
06.818377 s
  llvmpipe-7:2870       |  36803.778 ms |     7268 | avg:   1.727 ms | max=
:  30.168 ms | sum:12548.310 ms | max start:    87.406812 s | max end:    =
87.436981 s
  llvmpipe-3:2866       |  35004.654 ms |     6161 | avg:   1.385 ms | max=
:  19.992 ms | sum: 8531.873 ms | max start:    87.410811 s | max end:    =
87.430803 s
  llvmpipe-1:2864       |  34615.309 ms |     6423 | avg:   1.238 ms | max=
:  21.740 ms | sum: 7954.871 ms | max start:    93.834245 s | max end:    =
93.855985 s
  llvmpipe-2:2865       |  34375.917 ms |     6205 | avg:   1.273 ms | max=
:  22.031 ms | sum: 7897.655 ms | max start:    87.414812 s | max end:    =
87.436843 s
  llvmpipe-0:2863       |  32479.993 ms |     8472 | avg:   0.906 ms | max=
:  18.145 ms | sum: 7674.587 ms | max start:   156.041479 s | max end:   1=
56.059624 s
  llvmpipe-5:2868       |  32284.589 ms |     5668 | avg:   1.271 ms | max=
:  21.562 ms | sum: 7203.223 ms | max start:    98.798222 s | max end:    =
98.819784 s
  llvmpipe-6:2869       |  31752.624 ms |     5689 | avg:   1.241 ms | max=
:  18.067 ms | sum: 7057.222 ms | max start:    87.422817 s | max end:    =
87.440885 s
  llvmpipe-4:2867       |  31621.552 ms |     5298 | avg:   1.327 ms | max=
:  21.903 ms | sum: 7029.350 ms | max start:    87.418812 s | max end:    =
87.440715 s
  MediaPD~oder #1:5910  |  24623.459 ms |     7900 | avg:   0.455 ms | max=
:  18.267 ms | sum: 3596.813 ms | max start:   143.181740 s | max end:   1=
43.200008 s
  MediaPD~oder #1:5908  |  24498.697 ms |     7698 | avg:   0.470 ms | max=
:  24.616 ms | sum: 3614.831 ms | max start:   222.568707 s | max end:   2=
22.593322 s
  MediaPD~oder #1:5909  |  24447.400 ms |     7744 | avg:   0.476 ms | max=
:  22.047 ms | sum: 3683.826 ms | max start:   234.216798 s | max end:   2=
34.238845 s
  MediaPD~oder #1:5907  |  24349.888 ms |     7819 | avg:   0.437 ms | max=
:  19.288 ms | sum: 3413.911 ms | max start:   131.920097 s | max end:   1=
31.939385 s
  Isolated Web Co:5457  |  10982.274 ms |     5768 | avg:   0.295 ms | max=
:  25.414 ms | sum: 1701.308 ms | max start:    91.801774 s | max end:    =
91.827188 s
...
 -------------------------------------------------------------------------=
-----------------------------------
  TOTAL:                |2370376.486 ms |  1189527 |                      =
               |    654188.153 ms |
 -------------------------------------------------------------------------=
-----------------------------------

6.3.0.g8ca09d5 +eevdf
 -------------------------------------------------------------------------=
--------------------------------------------------------------------------=
-----------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     | Max delay start           | Max delay en=
d          |
 -------------------------------------------------------------------------=
--------------------------------------------------------------------------=
-----------
  Renderer:5675         | 211250.021 ms |    84700 | avg:   0.546 ms | max=
:  20.503 ms | sum:46225.011 ms | max start:   317.446170 s | max end:   3=
17.466673 s
  SwComposite:5719      | 205804.660 ms |    66043 | avg:   0.685 ms | max=
:  19.871 ms | sum:45214.452 ms | max start:   119.470385 s | max end:   1=
19.490256 s
  massive_intr:5838     | 195285.673 ms |    75458 | avg:   0.885 ms | max=
:  18.171 ms | sum:66793.033 ms | max start:   177.270747 s | max end:   1=
77.288919 s
  massive_intr:5835     | 195217.246 ms |    75005 | avg:   0.884 ms | max=
:  18.211 ms | sum:66340.670 ms | max start:   340.966607 s | max end:   3=
40.984818 s
  massive_intr:5836     | 195148.073 ms |    74723 | avg:   0.891 ms | max=
:  22.868 ms | sum:66544.981 ms | max start:    92.619771 s | max end:    =
92.642639 s
  massive_intr:5840     | 195093.638 ms |    75229 | avg:   0.886 ms | max=
:  21.502 ms | sum:66630.906 ms | max start:    96.715761 s | max end:    =
96.737263 s
  massive_intr:5837     | 195081.767 ms |    74906 | avg:   0.890 ms | max=
:  18.384 ms | sum:66672.064 ms | max start:   157.736916 s | max end:   1=
57.755300 s
  massive_intr:5839     | 195067.653 ms |    74433 | avg:   0.892 ms | max=
:  17.731 ms | sum:66391.236 ms | max start:   327.225658 s | max end:   3=
27.243389 s
  massive_intr:5841     | 194947.303 ms |    75468 | avg:   0.890 ms | max=
:  19.250 ms | sum:67155.572 ms | max start:    94.936517 s | max end:    =
94.955767 s
  massive_intr:5834     | 194820.690 ms |    74531 | avg:   0.901 ms | max=
:  16.593 ms | sum:67172.443 ms | max start:    87.268034 s | max end:    =
87.284627 s
  X:2673                |  55537.286 ms |    24293 | avg:   0.624 ms | max=
:  19.071 ms | sum:15149.642 ms | max start:   130.940240 s | max end:   1=
30.959311 s
  MediaPD~oder #1:6190  |  24885.689 ms |    19835 | avg:   0.576 ms | max=
:  16.064 ms | sum:11424.368 ms | max start:   274.211226 s | max end:   2=
74.227290 s
  MediaPD~oder #1:6188  |  24802.432 ms |    19475 | avg:   0.589 ms | max=
:  24.496 ms | sum:11465.965 ms | max start:   255.251754 s | max end:   2=
55.276250 s
  MediaPD~oder #1:6189  |  24784.917 ms |    19684 | avg:   0.573 ms | max=
:  18.250 ms | sum:11277.622 ms | max start:   263.644372 s | max end:   2=
63.662622 s
  MediaPD~oder #1:6187  |  24660.751 ms |    19613 | avg:   0.572 ms | max=
:  19.865 ms | sum:11221.213 ms | max start:   172.852720 s | max end:   1=
72.872585 s
  llvmpipe-6:3047       |  18633.251 ms |     7545 | avg:   3.428 ms | max=
:  27.450 ms | sum:25864.293 ms | max start:   150.773081 s | max end:   1=
50.800531 s
  llvmpipe-7:3048       |  18414.068 ms |     8024 | avg:   3.880 ms | max=
:  23.249 ms | sum:31135.265 ms | max start:   150.776388 s | max end:   1=
50.799637 s
  llvmpipe-5:3046       |  17914.117 ms |     7336 | avg:   3.429 ms | max=
:  19.998 ms | sum:25155.781 ms | max start:   137.463848 s | max end:   1=
37.483845 s
  llvmpipe-3:3044       |  17669.019 ms |     7913 | avg:   3.329 ms | max=
:  21.280 ms | sum:26340.572 ms | max start:   232.804014 s | max end:   2=
32.825294 s
  llvmpipe-4:3045       |  17539.666 ms |     7438 | avg:   3.353 ms | max=
:  22.802 ms | sum:24936.398 ms | max start:    94.800014 s | max end:    =
94.822817 s
  llvmpipe-0:3041       |  17428.494 ms |     9445 | avg:   2.663 ms | max=
:  29.456 ms | sum:25153.007 ms | max start:    96.231519 s | max end:    =
96.260975 s
  llvmpipe-2:3043       |  17239.204 ms |     7962 | avg:   3.282 ms | max=
:  24.674 ms | sum:26133.925 ms | max start:   161.019506 s | max end:   1=
61.044179 s
  llvmpipe-1:3042       |  17143.242 ms |     8261 | avg:   3.118 ms | max=
:  22.086 ms | sum:25756.911 ms | max start:   379.521740 s | max end:   3=
79.543826 s
  Isolated Web Co:5723  |  11075.262 ms |    15573 | avg:   0.280 ms | max=
:  23.996 ms | sum: 4360.925 ms | max start:   230.161012 s | max end:   2=
30.185008 s
...
 -------------------------------------------------------------------------=
-----------------------------------
  TOTAL:                |2368428.034 ms |  2114759 |                      =
               |   1048388.278 ms |
 -------------------------------------------------------------------------=
-----------------------------------
vs 6.3.0.g8ca09d5               .999         1.777                        =
                         1.602

