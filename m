Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E385FDD1E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiJMPZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJMPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:24:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E512AE11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:24:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a6so2774977ljq.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EtWVG+efRGaFBgju2lEFvjwItPXUlntfhqE6HifvOvw=;
        b=AXM9ogvMoFUlGZecSJYSkHKWqiY4FXdlEueN0zLrJXdSgKyl+KtIsYm5s25UQFkyZs
         LOW1Ihvhcaa43/1WmTFXo0He4rdtrhFKGy43l7QEKW8+4DN4R96+1hpIotf9/52z0bOj
         uull963FjJQO0WDIz0Go0bNPmQAudmZvNu7axHtKFORRK95sSlXpOtMAYuxgXBAIyrRH
         yNVElZzNtdJmQd/LaGtat9IpR1Ndjl29nCD6vXnLaxxLXye8r/Lh67+PUzNgqfgLtnf7
         nBr18tIawFQabCKwcwO21FNqXziOqY979SCkysvtyaEV9bMsnKdw7Opnbb9RKwVjX4xU
         2oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtWVG+efRGaFBgju2lEFvjwItPXUlntfhqE6HifvOvw=;
        b=giOLIlVQ3fAyX0t0YFvL9YKMFviO5T9O87sD9Jr5D6NxG3zmKdaK2WLWqXM7xvXKcI
         ONoB1hASVmmnQrrssUpiflc0DVd1+aeeDUvq2wcN4xQgUQ/I/V0mE3c8Buo3gvNQJYcU
         6qXbtkksrE4zRwsFv+TQCQxjh378+e+MRqgO2xkMTGDa/QS0K3sw6PsqyAKnqs3R7FyN
         RaX0IHt00u7Fk5leasRg5Cbx6WBz3TQFvuX/8d3rK1/ZXd810Bxb5m0v/AfkwO9QGpxh
         iMr/OsavdX9bjm88TLWGF3eYYUA635g/Rb7zQU3TWNul9DV3HuN23Gf/NpI+F3v5Kx87
         JuPw==
X-Gm-Message-State: ACrzQf2HoZrK9uFCQPqc308bgYk1aNehvmQRJ7nbg3QyUm30/8XDvMmN
        lE3zOldXmU4KBNBvSmXFGN1/Mp5QPJcPYEEUU1JNGg==
X-Google-Smtp-Source: AMsMyM6b11Ok0EwRvcboEwihNB1AA4olI0nXAHV8U2NT0ewe6ck7JQTAzD7vYMTf/Y3j/wz9TXjiYgnlMmZdynvkklA=
X-Received: by 2002:a05:651c:1a0b:b0:26c:7a7d:55b2 with SMTP id
 by11-20020a05651c1a0b00b0026c7a7d55b2mr148904ljb.365.1665674689116; Thu, 13
 Oct 2022 08:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220925143908.10846-1-vincent.guittot@linaro.org> <cd48ebbb-9724-985f-28e3-e558dea07827@amd.com>
In-Reply-To: <cd48ebbb-9724-985f-28e3-e558dea07827@amd.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 13 Oct 2022 17:24:37 +0200
Message-ID: <CAKfTPtC-yMUNfnGa8a4HrT-Onf4SZfRHDKyQcDZYnzhpPOk=Xw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add latency priority for CFS class
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,

Thanks for testing the patchset on AMD and the test report below.

On Wed, 12 Oct 2022 at 16:54, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> Sharing results from testing on dual socket Zen3 system (2 x 64C/128T)
>
> tl;dr
>
> o I don't see any regression when workloads are running with
>   DEFAULT_LATENCY_NICE
> o I can reproduce similar results as one reported in Patch 4 for
>   hackbench with latency nice 19 and hackbench and cyclictest
>   with various combination of latency nice values.
> o I can see improvements to tail latency for schbench with hackbench
>   running in the background.
> o There is an unexpected non-linear behavior observed for couple of
>   cases that I cannot explain yet. (Marked with "^" in detailed results)
>   I have not yet gotten to the bottom of it but if I've missed
>   something, please do let me know.
>
> Detailed results are shared below:
>
> On 9/25/2022 8:09 PM, Vincent Guittot wrote:
> > This patchset restarts the work about adding a latency priority to describe
> > the latency tolerance of cfs tasks.
> >
> > The patches [1-3] have been done by Parth:
> > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> >
> > I have just rebased and moved the set of latency priority outside the
> > priority update. I have removed the reviewed tag because the patches
> > are 2 years old.
> >
> > This aims to be a generic interface and the following patches is one use
> > of it to improve the scheduling latency of cfs tasks.
> >
> > The patch [4] uses latency nice priority to define a latency offset
> > and then decide if a cfs task can or should preempt the current
> > running task. The patch gives some tests results with cyclictests and
> > hackbench to highlight the benefit of latency priority for short
> > interactive task or long intensive tasks.
> >
> > Patch [5] adds the support of latency nice priority to task group by
> > adding a cpu.latency.nice field. The range is [-20:19] as for setting task
> > latency priority.
> >
> > Patch [6] makes sched_core taking into account the latency offset.
> >
> > Patch [7] adds a rb tree to cover some corner cases where the latency
> > sensitive task (priority < 0) is preempted by high priority task (RT/DL)
> > or fails to preempt them. This patch ensures that tasks will have at least
> > a slice of sched_min_granularity in priority at wakeup. The patch gives
> > results to show the benefit in addition to patch 4.
> >
> > I have also backported the patchset on a dragonboard RB3 with an android
> > mainline kernel based on v5.18 for a quick test. I have used the
> > TouchLatency app which is part of AOSP and described to be a very good
> > test to highlight jitter and jank frame sources of a system [1].
> > In addition to the app, I have added some short running tasks waking-up
> > regularly (to use the 8 cpus for 4 ms every 37777us) to stress the system
> > without overloading it (and disabling EAS). The 1st results shows that the
> > patchset helps to reduce the missed deadline frames from 5% to less than
> > 0.1% when the cpu.latency.nice of task group are set.
> >
> > I have also tested the patchset with the modified version of the alsa
> > latency test that has been shared by Tim. The test quickly xruns with
> > default latency nice priority 0 but is able to run without underuns with
> > a latency -20 and hackbench running simultaneously.
> >
> >
> > [1] https://source.android.com/docs/core/debug/eval_perf#touchlatency
>
> Following are the results from running standard benchmarks on a
> dual socket Zen3 (2 x 64C/128T) machine configured in different
> NPS modes.
>
> NPS Modes are used to logically divide single socket into
> multiple NUMA region.
> Following is the NUMA configuration for each NPS mode on the system:
>
> NPS1: Each socket is a NUMA node.
>     Total 2 NUMA nodes in the dual socket machine.
>
>     Node 0: 0-63,   128-191
>     Node 1: 64-127, 192-255
>
> NPS2: Each socket is further logically divided into 2 NUMA regions.
>     Total 4 NUMA nodes exist over 2 socket.
>
>     Node 0: 0-31,   128-159
>     Node 1: 32-63,  160-191
>     Node 2: 64-95,  192-223
>     Node 3: 96-127, 223-255
>
> NPS4: Each socket is logically divided into 4 NUMA regions.
>     Total 8 NUMA nodes exist over 2 socket.
>
>     Node 0: 0-15,    128-143
>     Node 1: 16-31,   144-159
>     Node 2: 32-47,   160-175
>     Node 3: 48-63,   176-191
>     Node 4: 64-79,   192-207
>     Node 5: 80-95,   208-223
>     Node 6: 96-111,  223-231
>     Node 7: 112-127, 232-255
>
> Benchmark Results:
>
> Kernel versions:
> - tip:          5.19.0 tip sched/core
> - latency_nice: 5.19.0 tip sched/core + this series
>
> When we started testing, the tip was at:
> commit 7e9518baed4c ("sched/fair: Move call to list_last_entry() in detach_tasks")
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~ hackbench - DEFAULT_LATENCY_NICE ~
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> NPS1
>
> Test:                   tip                 latency_nice
>  1-groups:         4.23 (0.00 pct)         4.06 (4.01 pct)
>  2-groups:         4.93 (0.00 pct)         4.89 (0.81 pct)
>  4-groups:         5.32 (0.00 pct)         5.31 (0.18 pct)
>  8-groups:         5.46 (0.00 pct)         5.54 (-1.46 pct)
> 16-groups:         7.31 (0.00 pct)         7.33 (-0.27 pct)
>
> NPS2
>
> Test:                   tip                 latency_nice
>  1-groups:         4.19 (0.00 pct)         4.12 (1.67 pct)
>  2-groups:         4.77 (0.00 pct)         4.82 (-1.04 pct)
>  4-groups:         5.15 (0.00 pct)         5.17 (-0.38 pct)
>  8-groups:         5.47 (0.00 pct)         5.48 (-0.18 pct)
> 16-groups:         6.63 (0.00 pct)         6.65 (-0.30 pct)
>
> NPS4
>
> Test:                   tip                  latency_nice
>  1-groups:         4.23 (0.00 pct)         4.31 (-1.89 pct)
>  2-groups:         4.78 (0.00 pct)         4.75 (0.62 pct)
>  4-groups:         5.17 (0.00 pct)         5.24 (-1.35 pct)
>  8-groups:         5.63 (0.00 pct)         5.59 (0.71 pct)
> 16-groups:         7.88 (0.00 pct)         7.09 (10.02 pct)
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~ schbench - DEFAULT_LATENCY_NICE ~
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> NPS1
>
> #workers:     tip                  latency_nice
>   1:      22.00 (0.00 pct)        21.00 (4.54 pct)
>   2:      34.00 (0.00 pct)        34.00 (0.00 pct)
>   4:      37.00 (0.00 pct)        40.00 (-8.10 pct)
>   8:      55.00 (0.00 pct)        49.00 (10.90 pct)
>  16:      69.00 (0.00 pct)        66.00 (4.34 pct)
>  32:     113.00 (0.00 pct)       117.00 (-3.53 pct)
>  64:     219.00 (0.00 pct)       242.00 (-10.50 pct) *
>  64:     219.00 (0.00 pct)       194.00 (11.41 pct)  [Verification Run]
> 128:     506.00 (0.00 pct)       513.00 (-1.38 pct)
> 256:     45440.00 (0.00 pct)     44992.00 (0.98 pct)
> 512:     76672.00 (0.00 pct)     83328.00 (-8.68 pct)
>
> NPS2
>
> #workers:     tip                   latency_nice
>   1:      31.00 (0.00 pct)        20.00 (35.48 pct)
>   2:      36.00 (0.00 pct)        28.00 (22.22 pct)
>   4:      45.00 (0.00 pct)        37.00 (17.77 pct)
>   8:      47.00 (0.00 pct)        51.00 (-8.51 pct)
>  16:      66.00 (0.00 pct)        69.00 (-4.54 pct)
>  32:     114.00 (0.00 pct)       113.00 (0.87 pct)
>  64:     215.00 (0.00 pct)       215.00 (0.00 pct)
> 128:     495.00 (0.00 pct)       529.00 (-6.86 pct)  *
> 128:     495.00 (0.00 pct)       416.00 (15.95  pct) [Verification Run]
> 256:     48576.00 (0.00 pct)     46912.00 (3.42 pct)
> 512:     79232.00 (0.00 pct)     82560.00 (-4.20 pct)
>
> NPS4
>
> #workers:     tip                   latency_nice
>   1:      30.00 (0.00 pct)        34.00 (-13.33 pct)
>   2:      34.00 (0.00 pct)        42.00 (-23.52 pct)
>   4:      41.00 (0.00 pct)        42.00 (-2.43 pct)
>   8:      60.00 (0.00 pct)        55.00 (8.33 pct)
>  16:      68.00 (0.00 pct)        69.00 (-1.47 pct)
>  32:     116.00 (0.00 pct)       115.00 (0.86 pct)
>  64:     224.00 (0.00 pct)       223.00 (0.44 pct)
> 128:     495.00 (0.00 pct)       677.00 (-36.76 pct) *
> 128:     495.00 (0.00 pct)       388.00 (21.61 pct)  [Verification Run]
> 256:     45888.00 (0.00 pct)     44608.00 (2.78 pct)
> 512:     78464.00 (0.00 pct)     81536.00 (-3.91 pct)
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~ tbench - DEFAULT_LATENCY_NICE ~
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> NPS1
>
> Clients:      tip                  latency_nice
>     1    550.66 (0.00 pct)       546.63 (-0.73 pct)
>     2    1009.69 (0.00 pct)      1016.40 (0.66 pct)
>     4    1795.32 (0.00 pct)      1773.95 (-1.19 pct)
>     8    2971.16 (0.00 pct)      2930.26 (-1.37 pct)
>    16    4627.98 (0.00 pct)      4727.82 (2.15 pct)
>    32    8065.15 (0.00 pct)      9019.11 (11.82 pct)
>    64    14994.32 (0.00 pct)     15100.22 (0.70 pct)
>   128    5175.73 (0.00 pct)      18223.69 (252.09 pct) *
>   128    20029.53 (0.00 pct)     20517.17 (2.43 pct)   [Verification Run]
>   256    48763.57 (0.00 pct)     44463.63 (-8.81 pct)
>   512    43780.78 (0.00 pct)     44170.21 (0.88 pct)
>  1024    40341.84 (0.00 pct)     40883.10 (1.34 pct)
>
> NPS2
>
> Clients:      tip                   latency_nice
>     1    551.06 (0.00 pct)       547.43 (-0.65 pct)
>     2    1000.76 (0.00 pct)      1014.83 (1.40 pct)
>     4    1737.02 (0.00 pct)      1742.30 (0.30 pct)
>     8    2992.31 (0.00 pct)      2951.59 (-1.36 pct)
>    16    4579.29 (0.00 pct)      4558.05 (-0.46 pct)
>    32    9120.73 (0.00 pct)      8122.06 (-10.94 pct) *
>    32    8814.62 (0.00 pct)      8965.54 (1.71 pct)   [Verification Run]
>    64    14918.58 (0.00 pct)     14890.93 (-0.18 pct)
>   128    20830.61 (0.00 pct)     20410.48 (-2.01 pct)
>   256    47708.18 (0.00 pct)     45312.84 (-5.02 pct) *
>   256    44941.88 (0.00 pct)     44555.92 (-0.85 pct) [Verification Run]
>   512    43721.79 (0.00 pct)     43653.43 (-0.15 pct)
>  1024    40920.49 (0.00 pct)     41162.17 (0.59 pct)
>
> NPS4
>
> Clients:      tip                   latency_nice
>     1    549.22 (0.00 pct)       539.81 (-1.71 pct)
>     2    1000.08 (0.00 pct)      1010.12 (1.00 pct)
>     4    1794.78 (0.00 pct)      1736.06 (-3.27 pct)
>     8    3008.50 (0.00 pct)      2952.68 (-1.85 pct)
>    16    4804.71 (0.00 pct)      4454.17 (-7.29 pct)  *
>    16    4391.10 (0.00 pct)      4497.43 (2.42 pct)   [Verification Run]
>    32    9156.57 (0.00 pct)      8820.05 (-3.67 pct)
>    64    14901.45 (0.00 pct)     14786.25 (-0.77 pct)
>   128    20771.20 (0.00 pct)     19955.11 (-3.92 pct)
>   256    47033.88 (0.00 pct)     44937.51 (-4.45 pct)
>   512    43429.01 (0.00 pct)     42638.81 (-1.81 pct)
>  1024    39271.27 (0.00 pct)     40044.17 (1.96 pct)
>
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~ stream - DEFAULT_LATENCY_NICE ~
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> NPS1
>
> 10 Runs:
>
> Test:           tip                     latency_nice
>  Copy:   336311.52 (0.00 pct)    326015.98 (-3.06 pct)
> Scale:   212955.82 (0.00 pct)    208667.27 (-2.01 pct)
>   Add:   251518.23 (0.00 pct)    237286.20 (-5.65 pct)
> Triad:   262077.88 (0.00 pct)    258949.80 (-1.19 pct)
>
> 100 Runs:
>
> Test:           tip                     latency_nice
>  Copy:   339533.83 (0.00 pct)    335126.73 (-1.29 pct)
> Scale:   194736.72 (0.00 pct)    221151.24 (13.56 pct)
>   Add:   218294.54 (0.00 pct)    251427.43 (15.17 pct)
> Triad:   262371.40 (0.00 pct)    260100.85 (-0.86 pct)
>
> NPS2
>
> 10 Runs:
>
> Test:           tip                     latency_nice
>  Copy:   335277.15 (0.00 pct)    339614.38 (1.29 pct)
> Scale:   220990.24 (0.00 pct)    221052.78 (0.02 pct)
>   Add:   264156.13 (0.00 pct)    263684.19 (-0.17 pct)
> Triad:   268707.53 (0.00 pct)    272610.96 (1.45 pct)
>
> 100 Runs:
>
> Test:           tip                     latency_nice
>  Copy:   334913.73 (0.00 pct)    339001.88 (1.22 pct)
> Scale:   230522.47 (0.00 pct)    229848.86 (-0.29 pct)
>   Add:   264567.28 (0.00 pct)    264288.34 (-0.10 pct)
> Triad:   272974.23 (0.00 pct)    272045.17 (-0.34 pct)
>
> NPS4
>
> 10 Runs:
>
> Test:           tip                     latency_nice
>  Copy:   299432.31 (0.00 pct)    307649.18 (2.74 pct)
> Scale:   217998.17 (0.00 pct)    205763.70 (-5.61 pct)
>   Add:   234305.46 (0.00 pct)    226381.75 (-3.38 pct)
> Triad:   244369.15 (0.00 pct)    254225.30 (4.03 pct)
>
> 100 Runs:
>
> Test:           tip                     latency_nice
>  Copy:   344421.25 (0.00 pct)    322189.81 (-6.45 pct)
> Scale:   237998.44 (0.00 pct)    227709.58 (-4.32 pct)
>   Add:   257501.82 (0.00 pct)    244009.58 (-5.23 pct)
> Triad:   267686.50 (0.00 pct)    251840.25 (-5.91 pct)
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~ Test cases for Latency Nice ~
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Note: Latency Nice might be referred to as LN in the data below. Latency Nice
> value was set using a wrapper script for all the workload threads during the
> testing.
> All the test results reported below are for NPS1 configuration.
>
> o Hackbench Pipes (100000 loops, threads)
>
> Test:                  tip                 Latency Nice: -20        Latency Nice: 0         Latency Nice: 19
>  1-groups:         4.23 (0.00 pct)          4.39 (-3.78 pct)        3.99 (5.67 pct)         3.88 (8.27 pct)
>  2-groups:         4.93 (0.00 pct)          4.91 (0.40 pct)         4.69 (4.86 pct)         4.59 (6.89 pct)
>  4-groups:         5.32 (0.00 pct)          5.37 (-0.93 pct)        5.19 (2.44 pct)         5.05 (5.07 pct)
>  8-groups:         5.46 (0.00 pct)          5.90 (-8.05 pct)        5.34 (2.19 pct)         5.17 (5.31 pct)
> 16-groups:         7.31 (0.00 pct)          7.99 (-9.30 pct)        6.96 (4.78 pct)         6.51 (10.94 pct)
>
> o Only Hackbench with different Latency Nice Values
>
> > Loops: 100000
>
> - Pipe (Process)
>
>   Test:            Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>  1-groups:         3.77 (0.00 pct)         4.23 (-12.20 pct)       3.83 (-1.59 pct)
>  2-groups:         4.39 (0.00 pct)         4.73 (-7.74 pct)        4.31 (1.82 pct)
>  4-groups:         4.80 (0.00 pct)         5.07 (-5.62 pct)        4.68 (2.50 pct)
>  8-groups:         4.95 (0.00 pct)         5.68 (-14.74 pct)       4.76 (3.83 pct)
> 16-groups:         6.47 (0.00 pct)         7.87 (-21.63 pct)       6.08 (6.02 pct)
>
> - Socket (Thread)
>
> Test:              Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>  1-groups:         6.08 (0.00 pct)         5.99 (1.48 pct)         6.08 (0.00 pct)
>  2-groups:         6.15 (0.00 pct)         6.25 (-1.62 pct)        6.14 (0.16 pct)
>  4-groups:         6.39 (0.00 pct)         6.42 (-0.46 pct)        6.44 (-0.78 pct)
>  8-groups:         8.51 (0.00 pct)         9.01 (-5.87 pct)        8.36 (1.76 pct)
> 16-groups:        12.48 (0.00 pct)        15.32 (-22.75 pct)      12.72 (-1.92 pct)
>
> - Socket (Process)
>
> Test:              Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>  1-groups:         6.44 (0.00 pct)         5.50 (14.59 pct)  ^     6.43 (0.15 pct)
>  2-groups:         6.55 (0.00 pct)         5.56 (15.11 pct)  ^     6.36 (2.90 pct)
>  4-groups:         6.74 (0.00 pct)         6.19 (8.16 pct)   ^     6.69 (0.74 pct)
>  8-groups:         8.03 (0.00 pct)         8.29 (-3.23 pct)        8.02 (0.12 pct)
> 16-groups:        12.25 (0.00 pct)        14.11 (-15.18 pct)      12.41 (-1.30 pct)

I don't see any improvement with LN:-20 but only for LN:19

How many iterations do you run ? Could it be that the results vary
between iterations ? For some configuration I have a stddev of 10-20%
for LN:0 and LN:-20

>
> > Loops: 2160 (Same as in testing)
>
> - Pipe (Thread)
>
> Test:              Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>  1-groups:         0.10 (0.00 pct)         0.12 (-20.00 pct)       0.10 (0.00 pct)
>  2-groups:         0.12 (0.00 pct)         0.15 (-25.00 pct)       0.11 (8.33 pct)
>  4-groups:         0.14 (0.00 pct)         0.18 (-28.57 pct)       0.15 (-7.14 pct)
>  8-groups:         0.17 (0.00 pct)         0.24 (-41.17 pct)       0.17 (0.00 pct)
> 16-groups:         0.26 (0.00 pct)         0.33 (-26.92 pct)       0.21 (19.23 pct)
>
> - Pipe (Process)
>
> Test:              Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>  1-groups:         0.10 (0.00 pct)         0.12 (-20.00 pct)       0.10 (0.00 pct)
>  2-groups:         0.12 (0.00 pct)         0.16 (-33.33 pct)       0.12 (0.00 pct)
>  4-groups:         0.14 (0.00 pct)         0.17 (-21.42 pct)       0.13 (7.14 pct)
>  8-groups:         0.16 (0.00 pct)         0.24 (-50.00 pct)       0.16 (0.00 pct)
> 16-groups:         0.23 (0.00 pct)         0.33 (-43.47 pct)       0.19 (17.39 pct)
>
> - Socket (Thread)
>
> Test:              Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>  1-groups:         0.19 (0.00 pct)         0.18 (5.26 pct)         0.18 (5.26 pct)
>  2-groups:         0.21 (0.00 pct)         0.21 (0.00 pct)         0.20 (4.76 pct)
>  4-groups:         0.22 (0.00 pct)         0.25 (-13.63 pct)       0.22 (0.00 pct)
>  8-groups:         0.27 (0.00 pct)         0.36 (-33.33 pct)       0.27 (0.00 pct)
> 16-groups:         0.42 (0.00 pct)         0.55 (-30.95 pct)       0.40 (4.76 pct)
>
> - Socket (Process)
>
> Test:              Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>  1-groups:         0.17 (0.00 pct)         0.17 (0.00 pct)         0.17 (0.00 pct)
>  2-groups:         0.19 (0.00 pct)         0.20 (-5.26 pct)        0.19 (0.00 pct)
>  4-groups:         0.20 (0.00 pct)         0.22 (-10.00 pct)       0.20 (0.00 pct)
>  8-groups:         0.25 (0.00 pct)         0.32 (-28.00 pct)       0.25 (0.00 pct)
> 16-groups:         0.40 (0.00 pct)         0.51 (-27.50 pct)       0.39 (2.50 pct)
>
> o Hackbench and Cyclictest in NPS1 configuration
>
> perf bench sched messaging -p -t -l 100000 -g 16&
> cyclictest --policy other -D 5 -q -n -H 20000
>
> -----------------------------------------------------------------------------------------------------------------
> |Hackbench     |      Cyclictest LN = 19        |         Cyclictest LN = 0       |      Cyclictest LN = -20    |
> |LN            |--------------------------------|---------------------------------|-----------------------------|
> |v             |   Min  |   Avg   |  Max        |     Min  |   Avg   |  Max       |     Min  |   Avg   |  Max   |
> |--------------|--------|---------|-------------|----------|---------|------------|----------|---------|--------|
> |0             |  54.00 |  117.00 | 3021.67     |    53.67 |  65.33  | 133.00     |    53.67 |  65.00  | 201.33 |  ^
> |19            |  50.00 |  100.67 | 3099.33     |    41.00 |  64.33  | 1014.33    |    54.00 |  63.67  | 213.33 |
> |-20           |  53.00 |  169.00 | 11661.67    |    53.67 |  217.33 | 14313.67   |    46.00 |  61.33  | 236.00 |  ^
> -----------------------------------------------------------------------------------------------------------------

The latency results look good with Cyclictest LN:0 and hackbench LN:0.
133us max latency. This suggests that your system is not overloaded
and cyclictest doesn't really compete with others to run.

>
> o Hackbench and schbench in NPS1 configuration
>
> perf bench sched messaging -p -t -l 1000000 -g 16&
> schebcnh -m 1 -t 64 -s 30s
>
> ------------------------------------------------------------------------------------------------------------
> |Hackbench     |   schbench LN = 19         |        schbench LN = 0         |       schbench LN = -20     |
> |LN            |----------------------------|--------------------------------|-----------------------------|
> |v             |  90th  |  95th  |  99th    |   90th  |  95th   |  99th      |   90th  |   95th   | 99th   |
> |--------------|--------|--------|----------|---------|---------|------------|---------|----------|--------|
> |0             |  4264  |  6744  |  15664   |   17952 |  32672  |  55488     |   15088 |   25312  | 50112  |
> |19            |  288   |  613   |  2332    |   274   |  1015   |  3628      |   374   |   1394   | 4424   |
> |-20           |  35904 |  47680 |  79744   |   87168 |  113536 |  176896    |   13008 |   21216  | 42560  |   ^
> ------------------------------------------------------------------------------------------------------------

For the schbench, your test is 30 seconds long which is longer than
the duration of perf bench sched messaging -p -t -l 1000000 -g 16&

The duration of the latter varies depending of latency nice value so
schbench is disturb more time in some cases
>
> o SpecJBB Multi-JVM
>
> ---------------------------------------------
> | Latency Nice  |         0  |           19 |
> ---------------------------------------------
> | max-jOPS      |      100%  |      109.92% |
> | critical-jOPS |      100%  |      153.70% |
> ---------------------------------------------
>
> In most cases, latency nice delivers what it promises.
> Some cases marked with "^" have shown anomalies or non-linear behavior
> that is yet to be root caused. If you've seen something similar during
> your testing, I would love to know what could lead to such a behavior.

I haven't seen anything like the results that you tagged with ^. As a
side note, the numbers of groups (g1 g4 g8 g1) that I used with
hackbench, have been chosen according to my 8 cores system. Your
system is much larger and hackbench may not overload it with such a
small number of groups. Maybe you could try with g32 g64 g128 g256 ?



>
> If you would like more details on the benchmarks results reported above
> or if there is any specific workload you would like me to test on the
> Zen3 machine, please do let me know.
>
> >
> > [..snip..]
> >
>
> --
> Thanks and Regards,
> Prateek
> --
> --
> Thanks and Regards,
> Prateek
