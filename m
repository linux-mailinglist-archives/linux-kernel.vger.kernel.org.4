Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C946228C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiKIKnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiKIKmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:42:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D64EA275FB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:42:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAEC01FB;
        Wed,  9 Nov 2022 02:42:44 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB2FF3F534;
        Wed,  9 Nov 2022 02:42:36 -0800 (PST)
Message-ID: <68f22089-b3bb-f1da-1fd8-d8a1be34654a@arm.com>
Date:   Wed, 9 Nov 2022 11:42:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 8/9] sched/fair: Detect capacity inversion
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>
Cc:     linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-9-qais.yousef@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220804143609.515789-9-qais.yousef@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Qais Yousef <qais.yousef@arm.com>
+ Qais Yousef <qyousef@layalina.io>

On 04/08/2022 16:36, Qais Yousef wrote:

I was surprised to see these capacity inversion patches in v2. They were
not part of v1 so I never review them (even internally).

> Check each performance domain to see if thermal pressure is causing its

I guess that's `PELT thermal pressure` instead of `instantaneous thermal
pressure`. IMHO an important detail here to understand the patch.

> capacity to be lower than another performance domain.
                            ^^^^^^^
s/another/next lower (CPU capacity) level/ ?

I assume that is the definition of `capacity inversion`? IMHO it
appeared the first time in your discussion with Xuewen and Lukasz:

https://lkml.kernel.org/r/20220503144352.lxduzhl6jq6xdhw2@airbuntu

> We assume that each performance domain has CPUs with the same
> capacities, which is similar to an assumption made in energy_model.c
> 
> We also assume that thermal pressure impacts all CPUs in a performance
> domain equally.
> 
> If there're multiple performance domains with the same capacity_orig, we

Not aware of such a system. At least it wouldn't make much sense. Not
sure if EAS would correctly work on such a system.

> will trigger a capacity inversion if the domain is under thermal
> pressure.
> 
> The new cpu_in_capacity_inversion() should help users to know when
> information about capacity_orig are not reliable and can opt in to use
> the inverted capacity as the 'actual' capacity_orig.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/fair.c  | 63 +++++++++++++++++++++++++++++++++++++++++---
>  kernel/sched/sched.h | 19 +++++++++++++
>  2 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 59ba7106ddc6..cb32dc9a057f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8659,16 +8659,73 @@ static unsigned long scale_rt_capacity(int cpu)
>  
>  static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>  {
> +	unsigned long capacity_orig = arch_scale_cpu_capacity(cpu);
>  	unsigned long capacity = scale_rt_capacity(cpu);
>  	struct sched_group *sdg = sd->groups;
> +	struct rq *rq = cpu_rq(cpu);
>  
> -	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
> +	rq->cpu_capacity_orig = capacity_orig;
>  
>  	if (!capacity)
>  		capacity = 1;
>  
> -	cpu_rq(cpu)->cpu_capacity = capacity;
> -	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
> +	rq->cpu_capacity = capacity;
> +
> +	/*
> +	 * Detect if the performance domain is in capacity inversion state.
> +	 *
> +	 * Capacity inversion happens when another perf domain with equal or
> +	 * lower capacity_orig_of() ends up having higher capacity than this
> +	 * domain after subtracting thermal pressure.
> +	 *
> +	 * We only take into account thermal pressure in this detection as it's
> +	 * the only metric that actually results in *real* reduction of
> +	 * capacity due to performance points (OPPs) being dropped/become
> +	 * unreachable due to thermal throttling.
> +	 *
> +	 * We assume:
> +	 *   * That all cpus in a perf domain have the same capacity_orig
> +	 *     (same uArch).
> +	 *   * Thermal pressure will impact all cpus in this perf domain
> +	 *     equally.
> +	 */
> +	if (static_branch_unlikely(&sched_asym_cpucapacity)) {

This should be sched_energy_enabled(). Performance Domains (PDs) are an
EAS thing.

> +		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);

rcu_read_lock()

> +		struct perf_domain *pd = rcu_dereference(rq->rd->pd);

rcu_read_unlock()

It's called from build_sched_domains() too. I assume
static_branch_unlikely(&sched_asym_cpucapacity) hides this issue so far.

> +
> +		rq->cpu_capacity_inverted = 0;
> +
> +		for (; pd; pd = pd->next) {
> +			struct cpumask *pd_span = perf_domain_span(pd);
> +			unsigned long pd_cap_orig, pd_cap;
> +
> +			cpu = cpumask_any(pd_span);
> +			pd_cap_orig = arch_scale_cpu_capacity(cpu);
> +
> +			if (capacity_orig < pd_cap_orig)
> +				continue;
> +
> +			/*
> +			 * handle the case of multiple perf domains have the
> +			 * same capacity_orig but one of them is under higher

Like I said above, I'm not aware of such an EAS system.

> +			 * thermal pressure. We record it as capacity
> +			 * inversion.
> +			 */
> +			if (capacity_orig == pd_cap_orig) {
> +				pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
> +
> +				if (pd_cap > inv_cap) {
> +					rq->cpu_capacity_inverted = inv_cap;
> +					break;
> +				}

In case `capacity_orig == pd_cap_orig` and cpumask_test_cpu(cpu_of(rq),
pd_span) the code can set rq->cpu_capacity_inverted = inv_cap
erroneously since thermal_load_avg(rq) can return different values for
inv_cap and pd_cap.

So even on a classical big little system, this condition can set
rq->cpu_capacity_inverted for a CPU in the little or big cluster.

thermal_load_avg(rq) would have to stay constant for all CPUs within the
PD to avoid this.

This is one example of the `thermal pressure` is per PD (or Frequency
Domain) in Thermal but per-CPU in the task scheduler.



> +			} else if (pd_cap_orig > inv_cap) {
> +				rq->cpu_capacity_inverted = inv_cap;
> +				break;
> +			}
> +		}
> +	}
> +
> +	trace_sched_cpu_capacity_tp(rq);
>  
>  	sdg->sgc->capacity = capacity;
>  	sdg->sgc->min_capacity = capacity;

[...]
