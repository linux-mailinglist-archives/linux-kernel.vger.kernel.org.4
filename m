Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5197267598A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjATQI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjATQIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:08:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40EB49CB88;
        Fri, 20 Jan 2023 08:08:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93AC914BF;
        Fri, 20 Jan 2023 08:09:33 -0800 (PST)
Received: from e126311.manchester.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 811503F67D;
        Fri, 20 Jan 2023 08:08:48 -0800 (PST)
Date:   Fri, 20 Jan 2023 16:08:35 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        peterz@infradead.org, dietmar.eggemann@arm.com, rafael@kernel.org,
        viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com,
        kajetan.puchalski@arm.com
Subject: Re: [PATCH v2] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <Y8q8WywMscQDxOLA@e126311.manchester.arm.com>
References: <20221228165415.3436-1-vincent.guittot@linaro.org>
 <Y8FhfyVyUDZ98hKD@e126311.manchester.arm.com>
 <CAKfTPtCmDA8WPrhFc8YxFXSOPOKasvvNWA3iOmRYcC2VSyMMrw@mail.gmail.com>
 <20230114211854.nmvmhtd5yz5wgh2a@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114211854.nmvmhtd5yz5wgh2a@airbuntu>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 09:18:54PM +0000, Qais Yousef wrote:

[...]

> I remember there were tasks with uclamp_min=512 or something like that in the
> system. I wonder if they're making the difference here - they will steal time
> from bigger cores and increase energy too.
> 
> The big jump with Vincent patches is strange though. How many iterations do you
> run? How long do you wait between each iteration?

It's 3 iterations for GB5 and 10 for Jankbench, all back to back after
keeping the phone in a fridge for an hour. This methodology has proven
to give pretty consistent results so far.

> The original behavior of overutilized in regards to util_avg shouldn't have
> changed. It's worth digging a bit more into it.
> 
> I looked at my previous results and I was seeing ~57% on android12-5.10 kernel
> for both with and without the patch.

As you said in the v3 thread this is caused by the "no OU on big cores"
issue. I'll reply in the v4 thread once I have a more complete set of
numbers but safe to say removing that change fixed the drop in score.

+-----------------+-------------------------+--------+-----------+
|     metric      |         kernel          | value  | perc_diff |
+-----------------+-------------------------+--------+-----------+
| multicore_score |        baseline         | 2765.4 |   0.0%    |
| multicore_score |      baseline_ufc       | 2704.3 |  -2.21%   |
| multicore_score |     ufc_patched_v4      | 2839.8 |   2.69%   |
+-----------------+-------------------------+--------+-----------+

> > 
> > >
> > > 2. Jankbench (power usage regression)
> > >
> > > +--------+---------------+---------------------------------+-------+-----------+
> > > | metric |   variable    |             kernel              | value | perc_diff |
> > > +--------+---------------+---------------------------------+-------+-----------+
> > > | gmean  | mean_duration |          baseline_60hz          | 14.6  |   0.0%    |
> > > | gmean  | mean_duration |        baseline_ufc_60hz        | 15.2  |   3.83%   |
> > > | gmean  | mean_duration |        ufc_patched_60hz         | 14.0  |  -4.12%   |
> > > +--------+---------------+---------------------------------+-------+-----------+
> > >
> > > +--------+-----------+---------------------------------+-------+-----------+
> > > | metric | variable  |             kernel              | value | perc_diff |
> > > +--------+-----------+---------------------------------+-------+-----------+
> > > | gmean  | jank_perc |          baseline_60hz          |  1.9  |   0.0%    |
> > > | gmean  | jank_perc |        baseline_ufc_60hz        |  2.2  |  15.39%   |
> > > | gmean  | jank_perc |        ufc_patched_60hz         |  2.0  |   3.61%   |
> > > +--------+-----------+---------------------------------+-------+-----------+
> 
> How many iterations did you run? Do you think they could be within the noise
> region?

As mentioned, 10 iterations on a cooled down phone. The frame
durations/jank above could be vaguely within noise levels, yes. I'd read
it as "no major change". This is mainly included for contrast with the
power usage spike.

> > >
> > > +--------------+--------+---------------------------------+-------+-----------+
> > > |  chan_name   | metric |             kernel              | value | perc_diff |
> > > +--------------+--------+---------------------------------+-------+-----------+
> > > | total_power  | gmean  |          baseline_60hz          | 135.9 |   0.0%    |
> > > | total_power  | gmean  |        baseline_ufc_60hz        | 155.7 |  14.61%   | <-- !!!
> > > | total_power  | gmean  |        ufc_patched_60hz         | 157.1 |  15.63%   | <-- !!!
> > > +--------------+--------+---------------------------------+-------+-----------+
> > >
> > > With these patches while running Jankbench we use up ~15% more power
> > > just to achieve roughly the same results. Here I'm not sure where this
> > > issue is coming from exactly but all the results above are very consistent
> > > across different runs.
> 
> Have you tried to look at uclamp_min/max values of the tasks/cpus?
> 
> Do you know which cluster ended up using more energy? Have you looked at freq
> residency between the runs?

+--------------+--------+------------------------------+-------+-----------+
|  chan_name   | metric |            kernel            | value | perc_diff |
+--------------+--------+------------------------------+-------+-----------+
| little_power | gmean  |        baseline_60hz         | 69.8  |   0.0%    |
| little_power | gmean  |      baseline_ufc_60hz       | 74.2  |   6.29%   |
|  mid_power   | gmean  |        baseline_60hz         | 20.1  |   0.0%    |
|  mid_power   | gmean  |      baseline_ufc_60hz       | 22.6  |  12.73%   |
|  big_power   | gmean  |        baseline_60hz         | 45.9  |   0.0%    |
|  big_power   | gmean  |      baseline_ufc_60hz       | 58.7  |  27.68%   |
| total_power  | gmean  |        baseline_60hz         | 135.9 |   0.0%    |
| total_power  | gmean  |      baseline_ufc_60hz       | 155.7 |  14.61%   |
+--------------+--------+------------------------------+-------+-----------+

All 3 clusters end up using more power, numerically & proportionally the biggest
increase is on the big cores. If we're looking for anything specific I
can dig into freq residency, it's just 3 clusters * 10 runs * 40
different OPPs is quite a lot when it comes to trying to find a clear
trend..

> I think the system could dynamically boost some UI tasks. I'd expect their
> residency to increase on the medium/big cores compared to before the patch.
> Which could explain what you see.
> 
> Did you check your schedutil/rate_limit_us is not using the default 10ms? It
> should be 500us.

I do most tests with the mainline default of 10ms. I did a set of runs
with 500us just to compare what impacts it has and I got worse Jankbench
results (mean duration 15.2 -> 16.9 and jank% 2.2 -> 3.7) with roughly
the same power usage (155.7 -> 156.4).
It did help with the GB5 score decrease though it was still below the
original baseline.

+-----------------+-------------------------+--------+-----------+
|     metric      |         kernel          | value  | perc_diff |
+-----------------+-------------------------+--------+-----------+
| multicore_score |        baseline         | 2765.4 |   0.0%    |
| multicore_score |      baseline_ufc       | 2704.3 |  -2.21%   |
| multicore_score |   baseline_ufc_su500    | 2759.0 |  -0.23%   |
+-----------------+-------------------------+--------+-----------+

> I had another patch to set transition latency of the cpufreq driver to 500us
> instead of 5ms - but I doubt this actually was making any difference.
> 
> FWIW, I did compare my series against vanilla Pixel 6 kernel where I used
> geekbench, speedometer, pcmark all with and without heavy background activities
> to measure the impact of uclamp_max and nothing stood out then.

Maybe comparing it against device kernels could be causing some issues?
Wouldn't they be pretty far from mainline to begin with and then get
even further with vendor hooks etc? There could be plenty of side
effects and interactions that come out differently.

> I sadly lost my original setup now. I doubt I'll be able to recreate it to
> re-run these tests again anytime soon :/
> 
> Could you try removing all thermal handling from util_fits_cpu() so that my
> series behaves like v1 again and see if this makes a difference? It's highlight
> if subtle issues with thermal pressure handling are the culprit. Most obvious
> is using instantaneous thermal pressure in ufc().

This where the interesting stuff comes in, looks like it is the thermal
handling causing problems, yes.

+-----------------+-------------------------+--------+-----------+
|     metric      |         kernel          | value  | perc_diff |
+-----------------+-------------------------+--------+-----------+
| multicore_score |        baseline         | 2765.4 |   0.0%    |
| multicore_score |      baseline_ufc       | 2704.3 |  -2.21%   |
| multicore_score | baseline_ufc_no_thermal | 2870.8 |   3.81%   | <-- 170 pt difference
+-----------------+-------------------------+--------+-----------+

+--------------+--------+-------------------------+--------+-----------+
|  chan_name   | metric |         kernel          | value  | perc_diff |
+--------------+--------+-------------------------+--------+-----------+
| total_power  | gmean  |        baseline         | 2664.0 |   0.0%    |
| total_power  | gmean  |      baseline_ufc       | 2621.5 |   -1.6%   |
| total_power  | gmean  | baseline_ufc_no_thermal | 2710.0 |   1.73%   | <-- better PPW
+--------------+--------+-------------------------+--------+-----------+

The Jankbench frame numbers are just below the original baseline but
very much within the noise levels so I'd say "no change" for brevity.

+--------------+--------+------------------------------+-------+-----------+
|  chan_name   | metric |            kernel            | value | perc_diff |
+--------------+--------+------------------------------+-------+-----------+
| total_power  | gmean  |        baseline_60hz         | 135.9 |   0.0%    |
| total_power  | gmean  |      baseline_ufc_60hz       | 155.7 |  14.61%   |
| total_power  | gmean  | baseline_ufc_no_thermal_60hz | 134.5 |  -1.01%   | <-- power saving!
+--------------+--------+------------------------------+-------+-----------+

This is the diff I got the previous results from:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e5f7c48950f8..2b846a7e2ed3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4262,7 +4262,7 @@ static inline int util_fits_cpu(unsigned long util,
                                unsigned long uclamp_max,
                                int cpu)
 {
-       unsigned long capacity_orig, capacity_orig_thermal;
+       unsigned long capacity_orig;
        unsigned long capacity = capacity_of(cpu);
        bool fits, uclamp_max_fits;

@@ -4299,7 +4299,6 @@ static inline int util_fits_cpu(unsigned long util,
         * the time.
         */
        capacity_orig = capacity_orig_of(cpu);
-       capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);

        /*
         * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -4375,7 +4374,7 @@ static inline int util_fits_cpu(unsigned long util,
         */
        uclamp_min = min(uclamp_min, uclamp_max);
        if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
-               fits = fits && (uclamp_min <= capacity_orig_thermal);
+               fits = fits && (uclamp_min <= capacity_orig);

        return fits;
 }

All in all taking the thermal handling out gives us better scores,
better PPW and better power usage on the whole in Jankbench so there's
clearly some issue with it.

Since you wrote in the v3 thread that we can't use thermal_load_avg()
maybe we should just take this part out completely for the time being
until there's a better solution? I could send a patch with the above
diff.

---
Kajetan
