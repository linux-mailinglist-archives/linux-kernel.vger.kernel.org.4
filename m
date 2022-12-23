Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34304654FED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiLWL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiLWL7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:59:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3AE2A26F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:58:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so3365244wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFykJKkljHq1zxipWJqyItHeh9wp3t9C/FpL2hqjeNU=;
        b=n1lL47ELUa+Z5B1hqY/hjwds8D2IPotIHP9ED2v4Wvkftga55K1fcG5tBDxKaD+pyj
         OAhCwevJh6TZLg04cUJ/agzoMMvfGpGYo3vxdG0OzTcSrJMScwSjzL13ENYQ4XFRB1Id
         tCgsAhuw4rcJIXr9bCxumqkKKTLEOvDJL7VKbFYTiQh12Rhq48G5dDsHwkn5NufxgYb/
         XDRpJZR0+LOVDd9lWW7cyxod9ROv7AN9FCSRTdbZVQQNXZMKpd/nRq+l76xDqsqUL/4Z
         tcR/9Be+QOsa/97NtRc5yjLPVbr4UCLPv5iDHjtYwDe+hgnzQw0VamMNcErg3TDHj14u
         1fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFykJKkljHq1zxipWJqyItHeh9wp3t9C/FpL2hqjeNU=;
        b=UN73p+0YSH5IqFDr8bGzqjDVgI/LR9Vz9mAdABIwnbJa+oGZ2KYD5VNjWf/scJQ8cb
         eAaDaNnD0GAFc6A+Q7NCBuHg9wR5sh6eo8PqyexraXm6jCnXkV0SxNQTFBgCq+BMH4Jx
         BnRMCOlciJn5gMJju1YOV5M/dWY+/+bd/t6BuS8udyoB2aYwajlTZxNo9Aic991N934s
         8ZhGAtxFHQi5uSxgDsaDOSW4MTBCxYwHJrmtIJfMvIHI391YjFc/0AR5BqufTIWsvCkM
         wle4K+h0BMiogE3xfGxsmHv/8LrzzV1hc0LcHby1J+CWfywWQUFBqM+c2Eq01WdciHYV
         GosQ==
X-Gm-Message-State: AFqh2kpc3UiEwuPfMaZ+BBgFUJEhG2roY9XiPxu0yfBNvy7gk28p6sIx
        V6wc5KEr//SxZngkNFqq+MMtPQ==
X-Google-Smtp-Source: AMrXdXuFoZiL9IoX+ZUDUHjMbjVOQNlJbEaazrmrno8sfJtdfs4uoZXcoWDzE9SvGsZUdpxEjKtJ0A==
X-Received: by 2002:a05:600c:34cf:b0:3d0:7415:c5a9 with SMTP id d15-20020a05600c34cf00b003d07415c5a9mr6889777wmq.21.1671796728010;
        Fri, 23 Dec 2022 03:58:48 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b003a3442f1229sm10347035wmb.29.2022.12.23.03.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 03:58:47 -0800 (PST)
Date:   Fri, 23 Dec 2022 11:58:45 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
Message-ID: <20221223115845.3azncwqlyo4zx262@airbuntu>
References: <20221203143323.w32boxa6asqvvdnp@airbuntu>
 <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu>
 <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
 <20221208140526.vvmjxlz6akgqyoma@airbuntu>
 <20221209164739.GA24368@vingu-book>
 <20221212184317.sntxy3h6k44oz4mo@airbuntu>
 <CAKfTPtBX0ugM87CEjAXUbVhnTZTwAAnjXu2fRfc6ezHE8=aC6w@mail.gmail.com>
 <20221220123254.to6tzznxloxq725q@airbuntu>
 <20221220135034.GA12359@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221220135034.GA12359@vingu-book>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/22 14:50, Vincent Guittot wrote:

Thanks for the patch!

> Hereafter is what I came with in order to decouple misfit task with cpu
> overutilized. We keep using util_fits_cpu but with 3 values so we can keep
> using it with cpu_overutilized but exclude the case of misfit task
> because uclmap_min. Also select_idle_capacity() and feec() keep selecting the
> big cpu even if it doesn't fit only because of uclamp_min
> 
> 
> Subject: [PATCH] sched/fair: unlink misfit task from cpu overutilized
> 
> By taking into account uclamp_min, the 1:1 relation between task misfit and
> cpu overutilized is no more true as a task with a util_avg of 20as an
> example may not fit a 1024 capacity cpu because of a uclamp_min constraint.
> 
> Add a new state in util_fits_cpu() to reflect the case that task would fit
> a CPU except for the uclamp_min hint which is a bandwidth requriement.

nit: mixing uclamp with bandwidth has been a source of a lot of confusion when
discussing uclamp. Can we use performance requirement instead please?

> 
> Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> can use this new value to take additional action to select the best cpu
> that doesn't match uclamp_min.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 73 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 49 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4423681baf15..705335d6af65 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4578,8 +4578,7 @@ static inline int util_fits_cpu(unsigned long util,
>  	 *     2. The system is being saturated when we're operating near
>  	 *        max capacity, it doesn't make sense to block overutilized.
>  	 */
> -	uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> -	uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
> +	uclamp_max_fits = (uclamp_max <= capacity_orig) || (capacity_orig == SCHED_CAPACITY_SCALE);
>  	fits = fits || uclamp_max_fits;
>  
>  	/*
> @@ -4614,8 +4613,8 @@ static inline int util_fits_cpu(unsigned long util,
>  	 * handle the case uclamp_min > uclamp_max.
>  	 */
>  	uclamp_min = min(uclamp_min, uclamp_max);
> -	if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> -		fits = fits && (uclamp_min <= capacity_orig_thermal);
> +	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> +		return -1;
>  
>  	return fits;

nit: return !!fits?

We check explicitly == 1 below and I'm not sure all the boolean check above
will guarantee we will end up return 1 for true on all combination of
compilerls/archs.

>  }
> @@ -4625,7 +4624,7 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
>  	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
>  	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
>  	unsigned long util = task_util_est(p);
> -	return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
> +	return (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) == 1);

Or make this >  0?

>  }
>  
>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> @@ -6064,7 +6063,10 @@ static inline void hrtick_update(struct rq *rq)
>  #ifdef CONFIG_SMP
>  static inline bool cpu_overutilized(int cpu)
>  {
> -	return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
> +	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> +	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> +
> +	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>  }
>  
>  static inline void update_overutilized_status(struct rq *rq)
> @@ -6857,6 +6859,7 @@ static int
>  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>  	unsigned long task_util, util_min, util_max, best_cap = 0;
> +	int fits, best_fits = -1;
>  	int cpu, best_cpu = -1;
>  	struct cpumask *cpus;
>  
> @@ -6872,12 +6875,24 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>  
>  		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
>  			continue;
> -		if (util_fits_cpu(task_util, util_min, util_max, cpu))
> +
> +		fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> +
> +		/* This cpu fits with all capacity requirements */

nit: s#capacity#capacity & performance#?

> +		if (fits > 0)
>  			return cpu;
> +		/*
> +		 * Only the min bandwidth (i.e. uclamp_min) doesn't fit. Look
> +		 * for the cpu with highest bandwidth capacity.
> +		 */

s/bandwidth/performance/?

> +		else if (fits < 0)
> +			cpu_cap = capacity_of(cpu) - thermal_load_avg(cpu_rq(cpu));

Hmm. Isn't capacity_of() already takes into account thermal_load_avg()?

Did you mean capacity_orig_of()?

>  
> -		if (cpu_cap > best_cap) {
> +		if ((fits > best_fits) ||
> +		    ((fits == best_fits) && (cpu_cap > best_cap))) {
>  			best_cap = cpu_cap;
>  			best_cpu = cpu;
> +			best_fits = fits;

I'm not sure if this logic is correct. It's a bit of a mind  bender.

	@iter#0

		fits <= 0
		best_fits <= -1

		if (fits > best_fits) // 0 > -1 => True
			...	// update best_cap if larger
			best_fits <= 0

	@iter#1

		fits <= -1
		best_fits <= 0

		if (fits > best_fits) // -1 > 0 => False

		if (fits == best_fits) // -1 == 0 => False

		// We will never update best_cap for all fits = -1 after
		// encountering the first fits = 0

I think we should reverse the initial values and split the conditions

	int fits, best_fits = 0;

		if ((fits < best_fits)) {
			/* Reset best_cap for first "fits_but" */
			best_cap = cpu_cap;
			best_cpu = cpu;
			best_fits = fits;
		} else if ((fits == best_fits) && (cpu_cap > best_cap))) {
			best_cap = cpu_cap;
			best_cpu = cpu;
		}

Which give us

	@iter#0

		fits <= 0
		best_fits <= 0

		if (fits < best_fits) // 0 < 0 => False

		if (fits == best_fits) // 0 == 0 => True
			...	// update best_cap if larger

	@iter#1

		fits <= -1
		best_fits <= 0

		if (fits < best_fits) // -1 < 0 => True
			...	// reset best_cap to first "fits_but" hit
			best_fits <= -1

	@iter#2

		fits <= 0
		best_fits <= -1

		if (fits < best_fits) // 0 < -1 => False

		if (fits == best_fits) // 0 == -1 => False

		// We should never update best_cap for all fits == 0 now

	@iter#3

		fits <= -1
		best_fits <= -1

		if (fits < best_fits) // -1 < -1 => False

		if (fits == best_fits) // -1 == -1 => True
			...	// update best_cap if larger

		// Only fits = -1 will update best_cap if larger now

Of course any hit with fits = 1 will return the cpu immediately.


>  		}
>  	}
>  
> @@ -6890,7 +6905,7 @@ static inline bool asym_fits_cpu(unsigned long util,
>  				 int cpu)
>  {
>  	if (sched_asym_cpucap_active())
> -		return util_fits_cpu(util, util_min, util_max, cpu);
> +		return (util_fits_cpu(util, util_min, util_max, cpu) > 0);
>  
>  	return true;
>  }
> @@ -7257,6 +7272,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
>  	struct root_domain *rd = this_rq()->rd;
>  	int cpu, best_energy_cpu, target = -1;
> +	int prev_fits = -1, best_fits = -1;
>  	struct sched_domain *sd;
>  	struct perf_domain *pd;
>  	struct energy_env eenv;
> @@ -7288,10 +7304,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		unsigned long cpu_cap, cpu_thermal_cap, util;
>  		unsigned long cur_delta, max_spare_cap = 0;
>  		unsigned long rq_util_min, rq_util_max;
> -		unsigned long util_min, util_max;
> +		unsigned long util_min = 0, util_max = 1024;

Why this change? Are you hitting the same warning reported by Dan?

>  		unsigned long prev_spare_cap = 0;
>  		int max_spare_cap_cpu = -1;
>  		unsigned long base_energy;
> +		int fits, max_fits = -1;
>  
>  		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
>  
> @@ -7344,7 +7361,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  					util_max = max(rq_util_max, p_util_max);
>  				}
>  			}
> -			if (!util_fits_cpu(util, util_min, util_max, cpu))
> +
> +			fits = util_fits_cpu(util, util_min, util_max, cpu);
> +			if (!fits)
>  				continue;
>  
>  			lsub_positive(&cpu_cap, util);
> @@ -7352,7 +7371,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			if (cpu == prev_cpu) {
>  				/* Always use prev_cpu as a candidate. */
>  				prev_spare_cap = cpu_cap;
> -			} else if (cpu_cap > max_spare_cap) {
> +				prev_fits = fits;
> +			} else if ((fits > max_fits) ||
> +				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
>  				/*
>  				 * Find the CPU with the maximum spare capacity
>  				 * among the remaining CPUs in the performance
> @@ -7360,6 +7381,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  				 */
>  				max_spare_cap = cpu_cap;
>  				max_spare_cap_cpu = cpu;
> +				max_fits = fits;

Should we reset best_delta here?

Because we update max_fits here..

>  			}
>  		}
>  
> @@ -7389,15 +7411,18 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			if (cur_delta < base_energy)
>  				goto unlock;
>  			cur_delta -= base_energy;
> -			if (cur_delta < best_delta) {
> +			if ((fits > max_fits) ||
> +			    ((fits == max_fits) && (cur_delta < best_delta))) {

.. on first first transitions from -1 to 1; this condition will be
skipped if cur_delta is lower than best delta. best_delta here could be the
previous -1 fitting cpu.

We should reset best_delta on first transition then look if we encounter
something with a better delta?


Thanks!

--
Qais Yousef

>  				best_delta = cur_delta;
>  				best_energy_cpu = max_spare_cap_cpu;
> +				best_fits = max_fits;
>  			}
>  		}
>  	}
>  	rcu_read_unlock();
>  
> -	if (best_delta < prev_delta)
> +	if ((best_fits > prev_fits) ||
> +	    ((best_fits == prev_fits) && (best_delta < prev_delta)))
>  		target = best_energy_cpu;
>  
>  	return target;
> @@ -10164,24 +10189,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	 */
>  	update_sd_lb_stats(env, &sds);
>  
> -	if (sched_energy_enabled()) {
> -		struct root_domain *rd = env->dst_rq->rd;
> -
> -		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> -			goto out_balanced;
> -	}
> -
> -	local = &sds.local_stat;
> -	busiest = &sds.busiest_stat;
> -
>  	/* There is no busy sibling group to pull tasks from */
>  	if (!sds.busiest)
>  		goto out_balanced;
>  
> +	busiest = &sds.busiest_stat;
> +
>  	/* Misfit tasks should be dealt with regardless of the avg load */
>  	if (busiest->group_type == group_misfit_task)
>  		goto force_balance;
>  
> +	if (sched_energy_enabled()) {
> +		struct root_domain *rd = env->dst_rq->rd;
> +
> +		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> +			goto out_balanced;
> +	}
> +
>  	/* ASYM feature bypasses nice load balance check */
>  	if (busiest->group_type == group_asym_packing)
>  		goto force_balance;
> @@ -10194,6 +10218,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	if (busiest->group_type == group_imbalanced)
>  		goto force_balance;
>  
> +	local = &sds.local_stat;
>  	/*
>  	 * If the local group is busier than the selected busiest group
>  	 * don't try and pull any tasks.
> -- 
> 2.17.1
> 
> 
> 
> > 
> > 
> > Thanks!!
> > 
> > --
> > Qais Yousef
