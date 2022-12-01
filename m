Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B630363FAB7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiLAWkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiLAWkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:40:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBE6AC4CCD;
        Thu,  1 Dec 2022 14:39:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DCB82B;
        Thu,  1 Dec 2022 14:40:00 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A228E3F73D;
        Thu,  1 Dec 2022 14:39:51 -0800 (PST)
Message-ID: <f06321f0-def6-6f9d-b72f-f700e7e9a60a@arm.com>
Date:   Thu, 1 Dec 2022 23:39:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] sched/fair: Fixes for capacity inversion detection
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
References: <20221127141742.1644023-1-qyousef@layalina.io>
 <20221127141742.1644023-3-qyousef@layalina.io>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221127141742.1644023-3-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 15:17, Qais Yousef wrote:
> Traversing the Perf Domains requires rcu_read_lock() to be held and is
> conditional on sched_energy_enabled(). rcu_read_lock() is held while in
> load_balance(), add an assert to ensure this is always the case.
> 
> Also skip capacity inversion detection for our own pd; which was an
> error.
> 
> Fixes: 44c7b80bffc3 ("sched/fair: Detect capacity inversion")
> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 89dadaafc1ec..7c0dd57e562a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8856,16 +8856,22 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>  	 *   * Thermal pressure will impact all cpus in this perf domain
>  	 *     equally.
>  	 */
> -	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> +	if (sched_energy_enabled()) {
>  		unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
>  		struct perf_domain *pd = rcu_dereference(rq->rd->pd);
>  
>  		rq->cpu_capacity_inverted = 0;
>  
> +		SCHED_WARN_ON(!rcu_read_lock_held());

This will trigger in CPU hotplug via build_sched_domains() ->
update_group_capacity() -> update_cpu_capacity() on an EAS system.

> +
>  		for (; pd; pd = pd->next) {
>  			struct cpumask *pd_span = perf_domain_span(pd);
>  			unsigned long pd_cap_orig, pd_cap;
>  
> +			/* We can't be inverted against our own pd */
> +			if (cpumask_test_cpu(cpu_of(rq), pd_span))
> +				continue;
> +

This should fix the issue with `cpu` function parameter in its own PD.

>  			cpu = cpumask_any(pd_span);
>  			pd_cap_orig = arch_scale_cpu_capacity(cpu);
>  

I still don't get the benefit of the CPU capacity inversion patches in
tip/sched/core which should be fixed by this patch:

aa69c36f31aa - sched/fair: Consider capacity inversion in
               util_fits_cpu()
44c7b80bffc3 - sched/fair: Detect capacity inversion

I have to ask again. Why should we use thermal_load_avg() instead of
arch_scale_thermal_pressure() for a CPUx in `CPU capacity inversion
state` (i.e. w/ higher `CPU capacity orig` but lower `CPU capacity` than
CPUy?
