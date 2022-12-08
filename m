Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A0F646AFE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiLHItY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiLHItH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:49:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B0BFC1E;
        Thu,  8 Dec 2022 00:48:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BD5823A;
        Thu,  8 Dec 2022 00:48:55 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 496253F73D;
        Thu,  8 Dec 2022 00:48:48 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:48:46 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 02/22] sched: Add interfaces for IPC classes
Message-ID: <Y5Gf9wGB5nFa4EDv@arm.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-3-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128132100.30253-3-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 28 Nov 2022 at 05:20:40 (-0800), Ricardo Neri wrote:
[..]
> +#ifndef arch_has_ipc_classes
> +/**
> + * arch_has_ipc_classes() - Check whether hardware supports IPC classes of tasks
> + *
> + * Returns: true of IPC classes of tasks are supported.
> + */
> +static __always_inline
> +bool arch_has_ipc_classes(void)
> +{
> +	return false;
> +}
> +#endif
> +
> +#ifndef arch_update_ipcc
> +/**
> + * arch_update_ipcc() - Update the IPC class of the current task
> + * @curr:		The current task
> + *
> + * Request that the IPC classification of @curr is updated.
> + *
> + * Returns: none
> + */
> +static __always_inline
> +void arch_update_ipcc(struct task_struct *curr)
> +{
> +}
> +#endif
> +
> +#ifndef arch_get_ipcc_score
> +/**
> + * arch_get_ipcc_score() - Get the IPC score of a class of task
> + * @ipcc:	The IPC class
> + * @cpu:	A CPU number
> + *
> + * Returns the performance score of an IPC class when running on @cpu.
> + * Error when either @class or @cpu are invalid.
> + */
> +static __always_inline
> +int arch_get_ipcc_score(unsigned short ipcc, int cpu)
> +{
> +	return 1;
> +}
> +#endif

The interface looks mostly alright but this arch_get_ipcc_score() leaves
unclear what are the characteristics of the returned value.

Does it have a meaning as an absolute value or is it a value on an
abstract scale? If it should be interpreted as instructions per cycle,
if I wanted to have a proper comparison between the ability of two CPUs
to handle this class of tasks then I would need to take into consideration
the maximum frequency of each CPU. If it's a performance value on an
abstract scale (more likely), similar cu capacity, then it might be good
to better define this abstract scale. That would help with the default
implementation where possibly the best choice for a return value would
be the maximum value on the scale, suggesting equal/maximum performance
for different CPUs handling the class of tasks.

I suppose you avoided returning 0 for the default implementation as you
intend that to mean the inability of the CPU to handle that class of
tasks? It would be good to document this.

> +#else /* CONFIG_IPC_CLASSES */
> +
> +#define arch_get_ipcc_score(ipcc, cpu) (-EINVAL)
> +#define arch_update_ipcc(curr)
> +
> +static inline bool sched_ipcc_enabled(void) { return false; }
> +
> +#endif /* CONFIG_IPC_CLASSES */
> +
>  #ifndef arch_scale_freq_capacity
>  /**
>   * arch_scale_freq_capacity - get the frequency scale factor of a given CPU.
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8154ef590b9f..eb1654b64df7 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -669,6 +669,9 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
> +#ifdef CONFIG_IPC_CLASSES
> +DEFINE_STATIC_KEY_FALSE(sched_ipcc);
> +#endif
>  
>  static void update_top_cache_domain(int cpu)
>  {
> @@ -2388,6 +2391,11 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  	if (has_asym)
>  		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
>  
> +#ifdef CONFIG_IPC_CLASSES
> +	if (arch_has_ipc_classes())
> +		static_branch_enable_cpuslocked(&sched_ipcc);
> +#endif

Wouldn't this be better placed directly in sched_init_smp()?
It's not gated by and it does not need any sched domains information.

Hope it helps,
Ionela.

> +
>  	if (rq && sched_debug_verbose) {
>  		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
>  			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
> -- 
> 2.25.1
> 
> 
