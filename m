Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC706DD7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDKKQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjDKKQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:16:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F25BBB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1681208147; i=efault@gmx.de;
        bh=yhFuLFhIzIy0IHNzbU80Pm+61/3ZIOQHrMLNnC9swwY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=TBaBHBka+cHsPQUSaoPmwhhswrM9s+hxLBSYS9sO1tKChbsFQjmnizpbPZSb++B52
         SrThmzJPsUDqVBmWZDm12CTDC+4KzE4DMSNPrYdfU8lPcT87SkIMZDhRwLoX34NUfq
         1005VJHCNRbRyJJqfoKrt1GfKpfDe9DS2igOnTkWaplOHic/5q4bXAJm4FrS9I8TWY
         h0jzVWMffQXwHHyJeUQmVjFs2dTSNnXPNUzZK6UVTJYY+MItxQixNmTdrLG3f5Tkjk
         hkXSfvQbFd5tMXrvuLNGC/7V5idSrMa2a5T/U729bJEgAI93SdO4BnBGMJzZPPETQk
         xHsnoXW8nKyYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.218.64]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1qHdy5142E-00eJRQ; Tue, 11
 Apr 2023 12:15:47 +0200
Message-ID: <c66114c4b659fc0ef50c7df1769f3acadc08fd63.camel@gmx.de>
Subject: Re: [PATCH 00/17] sched: EEVDF using latency-nice
From:   Mike Galbraith <efault@gmx.de>
To:     Hillf Danton <hdanton@sina.com>, David Vernet <void@manifault.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, kprateek.nayak@amd.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Date:   Tue, 11 Apr 2023 12:15:41 +0200
In-Reply-To: <20230410082307.1327-1-hdanton@sina.com>
References: <20230328092622.062917921@infradead.org>
         <20230410082307.1327-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I2jnmxfsNv9ElEnOyY7amrX2Hf1+upfV9Ra5e9Djb+nKTFHO3pu
 yTkNX4/hRiW1fSFjjqKt1IWC05AoDy0PNKcJ4QEgKlkloJCcNSK4xKvozgyYmXi0GzMYmiV
 KpXcVbghkvj9VTFW0+mrx9VrY9ZVKwoy2D8AgLxhUddrsEWCowfBwq/ldlLChkepYNRKjWX
 1jH0QhKOeLdS045QZCQhA==
UI-OutboundReport: notjunk:1;M01:P0:RDAs93aRW3Q=;AJDrcqbGecrkesZ0ynQeOBfZ4ho
 kPng3442TIP0OVB0xLEQ9VgBkQndJtdmKPMn9G2dJrS8lGEL8f+wz8f5wF67PckGmQxXLKSQJ
 2J9s0VucmI8lPTjOCG008zL+lXQ3inKxPQDNN4mdOdsaSV42kOfeCtL2qWbfVbqkd98CrxdCr
 G/PtYbtsD98pPh+OR4/4bQzNYXwGcYP3C7fEPpW/+jqDwxr+o/vZGvesV2WQIPj1H8Y72f6UX
 x4HEozFGNZbb5eTcF5P8E+NlwF8ADNm412TM0k+8TOXK+NiHKVE1yWW5vWwADKJwNuJgaZ0ds
 utHFruRlMpCx2FnH5wVfpGb5Ky1P8/dDTTQzTg9qwkP3A/hrhVGkn+h6WJvgFHzpOMGN2R2hC
 a0LEjBXDn878eDbktKTxG+fPB733m5FjJ+QOyHSju6e0Dc/dePYF8hg6fWsK6LQpA75sykvo/
 l0m4v2hpgUItw6hJBrExL2y/KN23oyDUgd8momwug2OnzKXKnjPUaqxLM6akx1X5FGZft9ULx
 YDaGxp4EPxPL6YZXz/yMScKNCSwmFS0Qs1YDPTq9yocg+dRUL++ak2OrvIwC+E/sKyRbN+p08
 Sh1MijW5x6VMdl1IFGhY8XoA5JFFTE415SRLnQ/zeLaDpOrJlM2VEWyYRCyGYoiQLirAImzGu
 xI6uJj3VbLZMttKAtK6TYKhqBoDe6Mq8KE1XA+tlFyk8vnDM3jhX4wiyEOyqBwlpEak1IakG+
 8n2PM+I2OVRcwml6brF6vdSRZ214rGfYJAU2VvLin+wECeUBvAlVUTF89x2t+A03tBUoeAQvw
 QxlXHgH5SNw70lkAyldgVhkWRmiMNTaBtac5HWq9FnTlb+MXaV8fWk4XNrmo3SCkAs3XK7szh
 W4wnkz8sOIgpkNwg8u/inVB8MzU3nvWBQ7AyAd+805eLOoewLRPxFe2lAwEB6qDRQVfIywnMG
 LITNN08Yj3vBEQ0FPFkyy4PY1gU=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-10 at 16:23 +0800, Hillf Danton wrote:
>
> In order to only narrow down the poor performance reported, make a trade=
off
> between runtime and latency simply by restoring sysctl_sched_min_granula=
rity
> at tick preempt, given the known order on the runqueue.

Tick preemption isn't the primary contributor to the scheduling delta,
it's wakeup preemption. If you look at the perf summaries of 5 minute
recordings on my little 8 rq box below, you'll see that the delta is
more than twice what a 250Hz tick could inflict.  You could also just
turn off WAKEUP_PREEMPTION and watch the delta instantly peg negative.

Anyway...

Given we know preemption is markedly up, and as always a source of pain
(as well as gain), perhaps we can try to tamp it down a little without
inserting old constraints into the shiny new scheduler.

The dirt simple tweak below puts a dent in the sting by merely sticking
with whatever decision EEVDF last made until it itself invalidates that
decision. It still selects via the same math, just does so the tiniest
bit less frenetically.

=2D--
 kernel/sched/fair.c     |    3 +++
 kernel/sched/features.h |    6 ++++++
 2 files changed, 9 insertions(+)

=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -950,6 +950,9 @@ static struct sched_entity *pick_eevdf(s
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr =3D NULL;

+	if (sched_feat(GENTLE_EEVDF) && curr)
+		return curr;
+
 	while (node) {
 		struct sched_entity *se =3D __node_2_se(node);

=2D-- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -14,6 +14,12 @@ SCHED_FEAT(MINIMAL_VA, false)
 SCHED_FEAT(VALIDATE_QUEUE, false)

 /*
+ * Don't be quite so damn twitchy, once you select a champion let the
+ * poor bastard carry the baton until no longer eligible to do so.
+ */
+SCHED_FEAT(GENTLE_EEVDF, true)
+
+/*
  * Prefer to schedule the task we woke last (assuming it failed
  * wakeup-preemption), since its likely going to consume data we
  * touched, increases cache locality.

perf.data.cfs
 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(8)      |1665786.092 ms |   529819 | avg:   1.046 ms | max=
:  33.639 ms | sum:554226.960 ms |
  dav1d-worker:(8)      | 187982.593 ms |   448022 | avg:   0.881 ms | max=
:  35.806 ms | sum:394546.442 ms |
  X:2503                | 102533.714 ms |    89729 | avg:   0.071 ms | max=
:   9.448 ms | sum: 6372.383 ms |
  VizCompositorTh:5235  |  38717.241 ms |    76743 | avg:   0.632 ms | max=
:  24.308 ms | sum:48502.097 ms |
  llvmpipe-0:(2)        |  32520.412 ms |    42390 | avg:   1.041 ms | max=
:  19.804 ms | sum:44116.653 ms |
  llvmpipe-1:(2)        |  32374.548 ms |    35557 | avg:   1.247 ms | max=
:  17.439 ms | sum:44347.573 ms |
  llvmpipe-2:(2)        |  31579.168 ms |    34292 | avg:   1.312 ms | max=
:  16.775 ms | sum:45005.225 ms |
  llvmpipe-3:(2)        |  30478.664 ms |    33659 | avg:   1.375 ms | max=
:  16.863 ms | sum:46268.417 ms |
  llvmpipe-7:(2)        |  29778.002 ms |    30684 | avg:   1.543 ms | max=
:  17.384 ms | sum:47338.420 ms |
  llvmpipe-4:(2)        |  29741.774 ms |    32832 | avg:   1.433 ms | max=
:  18.571 ms | sum:47062.280 ms |
  llvmpipe-5:(2)        |  29462.794 ms |    32641 | avg:   1.455 ms | max=
:  19.802 ms | sum:47497.195 ms |
  llvmpipe-6:(2)        |  28367.114 ms |    32132 | avg:   1.514 ms | max=
:  16.562 ms | sum:48646.738 ms |
  ThreadPoolForeg:(16)  |  22238.667 ms |    66355 | avg:   0.353 ms | max=
:  46.477 ms | sum:23409.474 ms |
  VideoFrameCompo:5243  |  17071.755 ms |    75223 | avg:   0.288 ms | max=
:  33.358 ms | sum:21650.918 ms |
  chrome:(8)            |   6478.351 ms |    47110 | avg:   0.486 ms | max=
:  28.018 ms | sum:22910.980 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |2317066.420 ms |  2221889 |                 |    =
   46.477 ms |   1629736.515 ms |
 -------------------------------------------------------------------------=
---------------------------------

perf.data.eevdf
 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(8)      |1673379.930 ms |   743590 | avg:   0.745 ms | max=
:  28.003 ms | sum:554041.093 ms |
  dav1d-worker:(8)      | 197647.514 ms |  1139053 | avg:   0.434 ms | max=
:  22.357 ms | sum:494377.980 ms |
  X:2495                | 100741.946 ms |   114808 | avg:   0.191 ms | max=
:   8.583 ms | sum:21945.360 ms |
  VizCompositorTh:6571  |  37705.863 ms |    74900 | avg:   0.479 ms | max=
:  16.464 ms | sum:35843.010 ms |
  llvmpipe-6:(2)        |  30757.126 ms |    38941 | avg:   1.448 ms | max=
:  18.529 ms | sum:56371.507 ms |
  llvmpipe-3:(2)        |  30658.127 ms |    40296 | avg:   1.405 ms | max=
:  24.791 ms | sum:56601.212 ms |
  llvmpipe-4:(2)        |  30456.388 ms |    40011 | avg:   1.419 ms | max=
:  23.840 ms | sum:56793.272 ms |
  llvmpipe-2:(2)        |  30395.971 ms |    40828 | avg:   1.394 ms | max=
:  19.195 ms | sum:56897.961 ms |
  llvmpipe-5:(2)        |  30346.432 ms |    39393 | avg:   1.445 ms | max=
:  21.747 ms | sum:56917.495 ms |
  llvmpipe-1:(2)        |  30275.694 ms |    41349 | avg:   1.378 ms | max=
:  20.765 ms | sum:56989.923 ms |
  llvmpipe-7:(2)        |  29768.515 ms |    37626 | avg:   1.532 ms | max=
:  20.649 ms | sum:57639.337 ms |
  llvmpipe-0:(2)        |  28931.905 ms |    42568 | avg:   1.378 ms | max=
:  20.942 ms | sum:58667.379 ms |
  ThreadPoolForeg:(60)  |  22598.216 ms |   131514 | avg:   0.342 ms | max=
:  36.105 ms | sum:44927.149 ms |
  VideoFrameCompo:6587  |  16966.649 ms |    90751 | avg:   0.357 ms | max=
:  18.199 ms | sum:32379.045 ms |
  chrome:(25)           |   8862.695 ms |    75923 | avg:   0.308 ms | max=
:  30.821 ms | sum:23347.992 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |2331946.838 ms |  3471615 |                 |    =
   36.105 ms |   1808071.407 ms |
 -------------------------------------------------------------------------=
---------------------------------

perf.data.eevdf+tweak
 -------------------------------------------------------------------------=
---------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
---------------------------------
  massive_intr:(8)      |1687121.317 ms |   695518 | avg:   0.760 ms | max=
:  24.098 ms | sum:528302.626 ms |
  dav1d-worker:(8)      | 183514.008 ms |   922884 | avg:   0.489 ms | max=
:  32.093 ms | sum:451319.787 ms |
  X:2489                |  99164.486 ms |   101585 | avg:   0.239 ms | max=
:   8.896 ms | sum:24295.253 ms |
  VizCompositorTh:17881 |  37911.007 ms |    71122 | avg:   0.499 ms | max=
:  16.743 ms | sum:35460.994 ms |
  llvmpipe-1:(2)        |  29946.625 ms |    40320 | avg:   1.394 ms | max=
:  23.036 ms | sum:56222.367 ms |
  llvmpipe-2:(2)        |  29910.414 ms |    39677 | avg:   1.412 ms | max=
:  24.187 ms | sum:56011.791 ms |
  llvmpipe-6:(2)        |  29742.389 ms |    37822 | avg:   1.484 ms | max=
:  18.228 ms | sum:56109.947 ms |
  llvmpipe-3:(2)        |  29644.994 ms |    39155 | avg:   1.435 ms | max=
:  21.191 ms | sum:56202.636 ms |
  llvmpipe-5:(2)        |  29520.006 ms |    38037 | avg:   1.482 ms | max=
:  21.698 ms | sum:56373.679 ms |
  llvmpipe-4:(2)        |  29460.485 ms |    38562 | avg:   1.462 ms | max=
:  26.308 ms | sum:56389.022 ms |
  llvmpipe-7:(2)        |  29449.959 ms |    36308 | avg:   1.557 ms | max=
:  21.617 ms | sum:56547.129 ms |
  llvmpipe-0:(2)        |  29041.903 ms |    41207 | avg:   1.389 ms | max=
:  26.322 ms | sum:57239.666 ms |
  ThreadPoolForeg:(16)  |  22490.094 ms |   112591 | avg:   0.377 ms | max=
:  27.027 ms | sum:42414.618 ms |
  VideoFrameCompo:17888 |  17385.895 ms |    86651 | avg:   0.367 ms | max=
:  19.350 ms | sum:31767.043 ms |
  chrome:(8)            |   6826.127 ms |    61487 | avg:   0.306 ms | max=
:  20.000 ms | sum:18835.879 ms |
 -------------------------------------------------------------------------=
---------------------------------
  TOTAL:                |2326181.115 ms |  3081183 |                 |    =
   32.093 ms |   1737425.434 ms |
 -------------------------------------------------------------------------=
---------------------------------


