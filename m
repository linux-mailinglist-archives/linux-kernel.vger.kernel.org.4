Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343855FD826
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJMLMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMLMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:12:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE39111E45A;
        Thu, 13 Oct 2022 04:12:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF46315A1;
        Thu, 13 Oct 2022 04:12:50 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.65.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F9463F792;
        Thu, 13 Oct 2022 04:12:42 -0700 (PDT)
Date:   Thu, 13 Oct 2022 12:12:25 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        kajetan.puchalski@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional
 util-awareness
Message-ID: <Y0fymW5LOoIHstE2@e126311.manchester.arm.com>
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 08:50:39PM +0200, Rafael J. Wysocki wrote:
> On Mon, Oct 3, 2022 at 4:50 PM Kajetan Puchalski
> <kajetan.puchalski@arm.com> wrote:
> >
> > Hi,
> >
> > At the moment, all the available idle governors operate mainly based on their own past performance
> 
> Not true, at least for the menu and teo governors that use the
> information on the distribution of CPU wakeups that is available to
> them and try to predict the next idle duration with the help of it.
> This has a little to do with their performance.

You're right of course, I should have written "their own past
correctness" as that's what I was referring to. I just meant that for
instance with TEO the initial timer-based choice is only adjusted using
the governor's own metrics and not any information from anywhere else in
the system.

> > without taking into account any scheduling information. Especially on interactive systems, this
> > results in them frequently selecting a deeper idle state and then waking up before its target
> > residency is hit, thus leading to increased wakeup latency and lower performance with no power
> > saving. For 'menu' while web browsing on Android for instance, those types of wakeups ('too deep')
> > account for over 24% of all wakeups.
> 
> How is this measured?

Using the cpu_idle_miss trace event. Over the course of a benchmark run
I collect all cpu_idle and cpu_idle_miss trace events. Then I divide the
number of too deep misses by the total number of cpu_idle wakeup events
which gives me the percentage. Those are the percentages described as
'gmean too deep %' in the tables included in the cover letter. Gmean
because I run the benchmarks for many iterations and then take an
average of those percentages to account for outliers.
PCMark Web Browsing is a 'benchmark' that just amounts to browsing the
web on Android, hence I can use data from it to talk about what the
system behaviour under normal usage would be.

> > At the same time, on some platforms C0 can be power efficient enough to warrant wanting to prefer
> > it over C1.
> 
> Well, energy-efficiency is relative, so strictly speaking it is
> invalid to say "power efficient enough".

Yes, by 'enough' I meant that the power savings of C0 vs C1 on arm are
fairly comparable as opposed to other platforms. From Doug's data
collected on an Intel CPU, the power usage difference of only-C0
compared to only-C1 was over 20-fold ie 46w vs 2.6w. With only C0
enabled on Pixel 6 that difference is closer to something like 4%. It's
just fundamentally different hardware. With 4% being your ceiling you
can talk about performance/latency tradeoffs etc, if you're talking
about potential over 1700% increases, not so much.

> Also, as far as idle CPUs are concerned, we are talking about the
> situation in which no useful work is done at all, so the state drawing
> less power is always more energy-efficient than the one drawing more
> power.

Yes, assuming the CPU is woken up after the target residency of the
state has been met. If the wakeup happens too early then for that
situation C0 would've been more power efficient than C1 even though C1
technically draws less power, right? That's what we're trying to fix
here, we just noticed that for mobile interactive workloads at least
we're getting this situation way too often.

The result being that this util-aware TEO variant while using much less
C1 and decreasing the percentage of too deep sleeps from ~24% to ~3% in
PCMark Web Browsing also uses almost 2% less power. Clearly the power is
being wasted on not hitting C1 residency over and over.

> You may argue that predicting idle durations that are too long too
> often leads to both excessive task wakeup latency and excessive energy
> usage at the same time, but this may very well mean that the target
> residency value for C1 is too low.

We get residency values from DT and they're meant to be the descriptions
of each CPU's hardware so I don't think tweaking them to get better
results would be a good idea. Unless I'm misunderstanding what you mean?

> > Currently the best available governor under this metric is TEO which on average results in less than
> > half the percentage of too deep sleeps compared to 'menu', getting much better wakeup latencies and
> > increased performance in the process.
> 
> Well, good to hear that, but some numbers in support of that claim
> would be nice to have too.

Those are the numbers I included in the cover letter for the two
benchmarks, they've been very consistent in terms of the pattern
across all the runs and workloads I've seen. For too deep % for
instance in GB5 we had on average menu 16.6%, TEO 9.6%, TEO+util 4.19%.
For PCMark Web Browsing menu 24.15%, TEO 10.32%, TEO+util 3.2%. The
values differ per-workload but every dataset I've seen had that same
'staircase' pattern.

> > This proposed optional extension to TEO would specifically tune it for minimising too deep
> > sleeps and minimising latency to achieve better performance. To this end, before selecting the next
> > idle state it uses the avg_util signal of a CPU's runqueue in order to determine to what extent the
> > CPU is being utilized.
> 
> Which has no bearing on what the CPU idle time governors have to do
> which is (1) to predict the next idle duration as precisely as
> reasonably possible and (2) to minimise the cost in terms of task
> wakeup latencies associated with using deep idle states.
> 
> The avg_util value tells us nothing about how much the CPU is going to
> be idle this time and it also tells us nothing about the
> latency-sensitivity of the workload.
> 
> Yes, it tells us how much idle time there was on the given CPU in the
> past, on the average, but there is zero information about the
> distribution of that idle time in it.
> 
> So in the first place please tell me why it fundamentally makes sense
> to use avg_util in CPU idle time management at all.

Right, the idea here is slightly similar to that of temporal locality.
We obviously can't predict the future which is sort of what an idle
governor tries to achieve. Focusing on timer events makes a lot of sense
and is probably close to as good as it gets in estimating future
behaviour.

The observation we're relying on here is simply that if the
CPU was doing enough work in the recent past for its avg_util to still
be raised while going into idle, it is very likely that the same CPU
might be needed again soon. From my tests that assumption tends to be
correct quite often. In those situations, when avg_util is high and the
next timer event is far enough for C1 to be selected, a lot of the time
the CPU does actually get woken up before the residency is hit leading
to all the issues described above.

I don't think using avg_util as the *only* input for idle management
would be a good idea at all. The way I see it, it serves as a very good hint
to determine if we are likely to get a wakeup between now and the next
timer event and provides an additional dimension for decision making.
While the current metrics only adjust themselves after making a certain
number of mistakes and are a "trailing" adjusting mechanism, using
avg_util this way provides a "leading" mechanism that potentially lets
us not make those mistakes in the first place. It's not just theory
either, it very clearly works and gets results, at least on the
platforms/workloads we've been looking at.


On the Intel & power usage angle you might have seen in the discussion,
Doug sent me some interesting data privately. As far as I can tell the
main issue there is that C0 on Intel doesn't actually do power saving so
moving the state selection down to it is a pretty bad idea because C1
could be very close in terms of latency and save much more power.

A potential solution could be altering the v2 to only decrease the state
selection by 1 if it's above 1, ie 2->1 but not 1->0. It's fine for us
because arm systems with 2 states use the early exit path anyway. It'd
just amount to changing this hunk:

+       if (cpu_data->utilized && idx > 0 && !dev->states_usage[idx-1].disable)
+               idx--;

to:

+       if (cpu_data->utilized && idx > 1 && !dev->states_usage[idx-1].disable)
+               idx--;

What would you think about that? Should make it much less intense for
Intel systems.

Thanks a lot for your interest,
Kajetan
