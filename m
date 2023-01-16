Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5354766B9E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjAPJJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjAPJJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:09:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0DAC1632A;
        Mon, 16 Jan 2023 01:07:18 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E378AD7;
        Mon, 16 Jan 2023 01:08:00 -0800 (PST)
Received: from [10.12.3.201] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D35B3F67D;
        Mon, 16 Jan 2023 01:07:14 -0800 (PST)
Message-ID: <78bf2d91-0076-f748-7c6a-530dad466787@arm.com>
Date:   Mon, 16 Jan 2023 09:07:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        peterz@infradead.org, qyousef@layalina.io, rafael@kernel.org,
        viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
References: <20230113134056.257691-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230113134056.257691-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 14:40, Vincent Guittot wrote:
> By taking into account uclamp_min, the 1:1 relation between task misfit
> and cpu overutilized is no more true as a task with a small util_avg of

of ?

> may not fit a high capacity cpu because of uclamp_min constraint.
> 
> Add a new state in util_fits_cpu() to reflect the case that task would fit
> a CPU except for the uclamp_min hint which is a performance requirement.
> 
> Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> can use this new value to take additional action to select the best CPU
> that doesn't match uclamp_min hint.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> Change since v2:
> - fix a condition in feec()
> - add comments
> 
>  kernel/sched/fair.c | 108 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 83 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e9d906a9bba9..29adb9e27b3d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4525,8 +4525,7 @@ static inline int util_fits_cpu(unsigned long util,
>  	 *     2. The system is being saturated when we're operating near
>  	 *        max capacity, it doesn't make sense to block overutilized.
>  	 */
> -	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> -	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> +	uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);

Isn't `uclamp_max <= capacity_orig` always true for `capacity_orig ==
SCHED_CAPACITY_SCALE`?

uclamp_max = [0..SCHED_CAPACITY_SCALE] , capacity_orig =
SCHED_CAPACITY_SCALE

>  	fits = fits || uclamp_max_fits;

Like Qais I don't understand this change. I read the previous discussion
from https://lkml.kernel.org/r/20221208140526.vvmjxlz6akgqyoma@airbuntu
("Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
capacity inversion").

I assume Qais wanted to force `uclamp_max_fits = 0` for a big CPU
(`capacity_orig = 1024`) and a `uclamp_max = 1024` to not lift `fits`
from 0 to 1.

>  	/*
> @@ -4561,8 +4560,8 @@ static inline int util_fits_cpu(unsigned long util,
>  	 * handle the case uclamp_min > uclamp_max.
>  	 */
>  	uclamp_min = min(uclamp_min, uclamp_max);
> -	if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> -		fits = fits && (uclamp_min <= capacity_orig_thermal);
> +	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> +		return -1;
>  	return fits;
>  }
> @@ -4572,7 +4571,11 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
>  	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
>  	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
>  	unsigned long util = task_util_est(p);
> -	return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
> +	/*
> +	 * Return true only if the cpu fully fits the task requirements, which
> +	 * include the utilization but also the performance.

Not sure if people get what `performance requirements` mean here? I know
we want to use `performance` rather `bandwidth hint` to describe what
uclamp is. So shouldn't we use `utilization but also uclamp`?

> +	 */
> +	return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0);
>  }
>  
>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> @@ -6132,6 +6135,7 @@ static inline bool cpu_overutilized(int cpu)
>  	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
>  	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
>  
> +	/* Return true only if the utlization doesn't fit its capacity */

s/utlization/utilization
s/its/CPU ?

>  	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>  }

cpu_overutilized() is the only place where we now only test for
!util_fits_cpu(). The new comment says we only care about utilization
not fitting CPU capacity.

Does this mean the rq uclamp values are not important here and we could
go back to use fits_capacity()?

Not sure since util_fits_cpu() is still coded differently:

  fits = fits_capacity(util, capacity)

  fits = fits || uclamp_max_fits  <-- uclamp_max_fits can turn fits from
                                      0 into 1, so util doesn't fit but
                                      we don't return 1?

That said, I don't understand the current 'uclamp_max_fits = (uclamp_max
<= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE)' in
util_fits_cpu(), like already mentioned.

> @@ -6925,6 +6929,7 @@ static int
>  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	unsigned long task_util, util_min, util_max, best_cap = 0;
> +	int fits, best_fits = 0;
>  	int cpu, best_cpu = -1;
>  	struct cpumask *cpus;
>  
> @@ -6940,12 +6945,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>  
>  		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
>  			continue;
> -		if (util_fits_cpu(task_util, util_min, util_max, cpu))
> +
> +		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> +
> +		/* This CPU fits with all capacity and performance requirements */

In task_fits_cpu() `utilization and performance (better uclamp)
requirements` term was used. I assume it's the same thing here?

> +		if (fits > 0)
>  			return cpu;
> +		/*
> +		 * Only the min performance (i.e. uclamp_min) doesn't fit. Look
> +		 * for the CPU with highest performance capacity.
                                            ^^^^^^^^^^^^^^^^^^^^

Do we use a new CPU capacity value `performance capacity (1)` here?

Which I guess is `capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu)`.

I'm asking since util_fits_cpu() still uses: `capacity_orig_thermal (2)
= capacity_orig - arch_scale_thermal_pressure()` when checking whether
to return -1. Shouldn't (1) and (2) be the same?

> +		 */
> +		else if (fits < 0)
> +			cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
>  
> -		if (cpu_cap > best_cap) {
> +		/*
> +		 * First, select cpu which fits better (-1 being better than 0).
> +		 * Then, select the one with largest capacity at same level.
> +		 */
> +		if ((fits < best_fits) ||
> +		    ((fits == best_fits) && (cpu_cap > best_cap))) {
>  			best_cap = cpu_cap;
>  			best_cpu = cpu;
> +			best_fits = fits;
>  		}
>  	}
>  

[...]

> @@ -7446,26 +7480,50 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			if (prev_delta < base_energy)
>  				goto unlock;
>  			prev_delta -= base_energy;
> +			prev_thermal_cap = cpu_thermal_cap;
>  			best_delta = min(best_delta, prev_delta);
>  		}
>  
>  		/* Evaluate the energy impact of using max_spare_cap_cpu. */
>  		if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
> +			/* Current best energy cpu fits better */
> +			if (max_fits < best_fits)
> +				continue;
> +
> +			/*
> +			 * Both don't fit performance (i.e. uclamp_min) but
> +			 * best energy cpu has better performance.

IMHO, `performance` stands for `cpu_thermal_cap` which is
`cpu_capacity_orig - thermal pressure`.

I assume `performance` is equal to `performance capacity` used in
select_idle_capacity which uses thermal_load_avg() and not thermal
pressure. Why this difference?

[...]
