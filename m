Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2476CD607
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjC2JMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjC2JL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:11:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D0E1FCC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680081033; i=efault@gmx.de;
        bh=MkXuNaDdTzeDhkon9ThvAyVzhJg4CJFvHqeU4r+hClA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=a+o02BcCs+wMV4fBzI+BhRQWlAi55YubLQvgJ2VmVFpbxmXLMG4D3I8DFrjZB40Fs
         2tKjRhJgPHVabZ2HtF/Er/5RWpoLraeQuogdPVGO3tsesgl4E6AbM0KAuDs0wWXRJt
         37cetG33qyOEeYSbN8f5/I6M4aw79T9iKgSbx+iRlEp2Cxy4XB+tJlTBtUFgr+7z/P
         o1kLd0/PtRw09njw7SMc3Rx5mqxoH/Tin4mR9q+6mSzpNjPa1C0Qai1++81JP6EIzz
         CxdepMYHhl9amJbkjrI+TsBy5SobVZHfeg3fFsP/8J6ZZlmkkTx5OnJOZqW/kA4JDa
         ZQckzxPAAizZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.248]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1pjvrU1dIP-002W8S; Wed, 29
 Mar 2023 11:10:33 +0200
Message-ID: <7577c8e361ee311d019f40b8921099f3e9aa2d23.camel@gmx.de>
Subject: Re: [PATCH 15/17] [RFC] sched/eevdf: Sleeper bonus
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
Date:   Wed, 29 Mar 2023 11:10:28 +0200
In-Reply-To: <20230328110354.641979416@infradead.org>
References: <20230328092622.062917921@infradead.org>
         <20230328110354.641979416@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8UqFTJsrcYhtrS49VQXp9NezjmUydinXlO8kKaaBo/sVhX9sb1P
 t2hgltS1kyBfzVqo8SOfrkvGDeg96tH5f8VlCU8PsIQXNKbPFJFoW4PHZfWrD9MLOPgcKuY
 yR9L1WDXuFR2HXPsgM9XG8+DSDbOdPEyTMNtFvwydtypNbrakHc/PGNXR1g7pEf31ya+UgO
 2O01jHNcuk4nQYTziTQiQ==
UI-OutboundReport: notjunk:1;M01:P0:KFsDQfFgc0k=;wZK8t2QfLzYRBkNytyj9JL7nHvX
 hxKOenhQ6nM2RBJ7lXycD2LlyG026MnF1ssJDuEYfyOD3i6D80J/n1wRborcH9rVA60D8BSmN
 2eVhsZuZ/UsIjl4aMu/CGSKXSuULFytarMEuxMxge8aeuv078U8Hy2Xa39qSveadUNhyp4sYN
 1TB1ZVmklhlPjSzI792GodxYXTUu900oeWB1vLDDjs0pv29ZyNPzI4qvJ0JRKjMtivU7YeeiW
 7uSWFG06RiSsMpmwdwSwNCbp97DBTNyCVlFPl1oa78iGzvfXwRLPXY1khukhqEwcaPDc5AEZa
 uRSJ8JQnMfwlQkJ4Ieonai6XjOb5/vBqPKoFZ0yZLPWH4LzbNNJLGWLPkuJCTpt50J7i0HI0H
 nxavLsdEaJ/CT4kO9Xst34g0w9v21LDKEiD2S97S78LFtx7Q9pjL1jj+98QLs+S1W1WiwUpRs
 eMW+J+UjzQZuXp6u45RKJoGsFwrLpgTY0c5Neu/YC03weH+xWJ2j+zjuLiHa8E9/raeqQeuMg
 VsNyPYpGtHbe4ylQPBrRfjTTuSne9NYsNxhSznFuolI5qMCjuUgFmN2p88EN8XJfx+gsn/v/s
 C9Ywb5a/+G3MAvR4+YpzpMZJZ/5jtjSOmxfmVr9BLvi8ug5CXAFZ1Xe9iskwC7hy81ekzIxfQ
 bSajOix+Ty8v08zQ75VSHjrlLo+b2gWw4pd+l3KydCKJEVcfDzQtUD+1ldyK36NafXAdVoFEA
 5nO2a+8/jCw92QeQ+wH3gsWpe1fl6dhBlMyzZ+caDtHVIt+CfH8XCr3mOHj6CK89pC/BL2w9T
 kLNzGo2srNSgo0EIUg//KkeO8C9a0meGnqqVc77FMOEsOHq+ToILaWryI60i4fjlDsnj90spc
 xNek4gbaiFJCIsT6cVSNuix7iA9A009jTkdK8U/A6RbgmZQttO8ugfHWYNBrk9dDz8dRggmek
 D5E8ln+yna4wzzLMxxdzd87bbQA=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-28 at 11:26 +0200, Peter Zijlstra wrote:
> Add a sleeper bonus hack, but keep it default disabled. This should
> allow easy testing if regressions are due to this.
>
> Specifically; this 'restores' performance for things like starve and
> stress-futex, stress-nanosleep that rely on sleeper bonus to compete
> against an always running parent (the fair 67%/33% split vs the
> 50%/50% bonus thing).
>
> OTOH this completely destroys latency and hackbench (as in 5x worse).

I profiled that again, but numbers were still.. not so lovely.

Point of this post is the sleeper/hog split business anyway.  I've been
running your patches on my desktop box and cute as button little rpi4b
since they appeared, and poking at them looking for any desktop deltas
and have noticed jack diddly spit.

A lot of benchmarks will notice both distribution and ctx deltas, but
humans.. the numbers I've seen so far say that's highly unlikely.

A couple perf sched lat summaries below for insomniacs.

Load is chrome playing BigBuckBunny (for the zillionth time), which on
this box as I set resolution/size wants ~35% of the box vs 8ms run 1ms
sleep massive_intr, 1 thread per CPU (profiles at ~91%), as a hog-ish
but not absurdly so competitor.

perf.data.stable.full sort=3Dmax - top 10 summary
 -------------------------------------------------------------------------=
----------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
----------------------------------
  chrome:(7)            |   6274.683 ms |    63604 | avg:   0.172 ms | max=
:  41.796 ms | sum:10930.150 ms |
  massive_intr:(8)      |1673597.295 ms |   762617 | avg:   0.709 ms | max=
:  40.383 ms | sum:540374.853 ms |
  X:2476                |  86498.438 ms |   129657 | avg:   0.259 ms | max=
:  36.157 ms | sum:33588.933 ms |
  dav1d-worker:(8)      | 162369.504 ms |   411962 | avg:   0.682 ms | max=
:  30.648 ms | sum:280864.249 ms |
  ThreadPoolForeg:(13)  |  21177.187 ms |    60907 | avg:   0.401 ms | max=
:  30.424 ms | sum:24412.770 ms |
  gmain:(3)             |     95.617 ms |     3552 | avg:   0.755 ms | max=
:  26.365 ms | sum: 2680.738 ms |
  llvmpipe-0:(2)        |  24602.666 ms |    30828 | avg:   1.278 ms | max=
:  23.590 ms | sum:39408.811 ms |
  llvmpipe-2:(2)        |  27707.699 ms |    29226 | avg:   1.236 ms | max=
:  23.579 ms | sum:36126.717 ms |
  llvmpipe-7:(2)        |  34437.755 ms |    27017 | avg:   1.097 ms | max=
:  23.545 ms | sum:29634.448 ms |
  llvmpipe-5:(2)        |  24533.947 ms |    28503 | avg:   1.375 ms | max=
:  22.995 ms | sum:39191.132 ms |
 -------------------------------------------------------------------------=
----------------------------------
  TOTAL:                |2314609.811 ms |  2473891 | 96.4% util, 27.7% GUI=
   41.796 ms |   1361629.825 ms |
 -------------------------------------------------------------------------=
----------------------------------

perf.data.eevdf.full sort=3Dmax - top 10 summary
 -------------------------------------------------------------------------=
----------------------------------
  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max=
 delay ms    | Sum delay ms     |
 -------------------------------------------------------------------------=
----------------------------------
  chrome:(8)            |   6329.996 ms |    80080 | avg:   0.193 ms | max=
:  28.835 ms | sum:15432.012 ms |
  ThreadPoolForeg:(20)  |  20477.539 ms |   158457 | avg:   0.265 ms | max=
:  25.708 ms | sum:42003.063 ms |
  dav1d-worker:(8)      | 168022.569 ms |  1090719 | avg:   0.366 ms | max=
:  24.786 ms | sum:398971.023 ms |
  massive_intr:(8)      |1736052.944 ms |   721103 | avg:   0.658 ms | max=
:  23.427 ms | sum:474493.391 ms |
  llvmpipe-5:(2)        |  22970.555 ms |    31184 | avg:   1.448 ms | max=
:  22.465 ms | sum:45148.667 ms |
  llvmpipe-3:(2)        |  22803.121 ms |    31688 | avg:   1.436 ms | max=
:  22.076 ms | sum:45516.196 ms |
  llvmpipe-0:(2)        |  22050.612 ms |    33580 | avg:   1.397 ms | max=
:  22.007 ms | sum:46898.028 ms |
  VizCompositorTh:5538  |  90856.230 ms |    91865 | avg:   0.605 ms | max=
:  21.702 ms | sum:55542.418 ms |
  llvmpipe-1:(2)        |  22866.426 ms |    32870 | avg:   1.390 ms | max=
:  20.732 ms | sum:45690.066 ms |
  llvmpipe-2:(2)        |  22672.646 ms |    32319 | avg:   1.415 ms | max=
:  20.647 ms | sum:45731.838 ms |
 -------------------------------------------------------------------------=
----------------------------------
  TOTAL:                |2332092.393 ms |  3449563 | 97.1% util, 25.6% GUI=
   28.835 ms |   1570459.986 ms |
 -------------------------------------------------------------------------=
----------------------------------
 vs stable                                    1.394  distribution delta.. =
meaningless            1.153



