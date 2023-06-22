Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84C5739C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjFVJLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjFVJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:10:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C65E95FE2;
        Thu, 22 Jun 2023 02:01:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 460231042;
        Thu, 22 Jun 2023 02:02:34 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.78.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2BCF3F663;
        Thu, 22 Jun 2023 02:01:49 -0700 (PDT)
Date:   Thu, 22 Jun 2023 10:01:48 +0100
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
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH v4 06/24] sched/fair: Collect load-balancing stats for
 IPC classes
Message-ID: <ZJQN/KIwCUmzYoiN@arm.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
 <20230613042422.5344-7-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613042422.5344-7-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Monday 12 Jun 2023 at 21:24:04 (-0700), Ricardo Neri wrote:
> When selecting the busiest scheduling group between two otherwise identical
> groups of types asym_packing or fully_busy, IPC classes can be used to
> break the tie.
> 
> Compute the IPC class performance score for a scheduling group. It is
> defined as the sum of the IPC scores of the tasks at the back of each
> runqueue in the group. Load balancing starts by pulling tasks from the back
> of the runqueue first, making this tiebreaker more useful.
> 
> Also, track the IPC class with the lowest score in the scheduling group. A
> task of this class will be pulled when the destination CPU has lower
> priority than the fully_busy busiest group.
> 
> These two metrics will be used during idle load balancing to compute the
> current and the potential IPC class score of a scheduling group in a
> subsequent changeset.
> 
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Perry Yuan <Perry.Yuan@amd.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v3:
>  * Do not compute the IPCC stats using the current tasks of runqueues.
>    Instead, use the tasks at the back of the queue. These are the tasks
>    that will be pulled first during load balance. (Vincent)
> 
> Changes since v2:
>  * Also excluded deadline and realtime tasks from IPCC stats. (Dietmar)
>  * Also excluded tasks that cannot run on the destination CPU from the
>    IPCC stats.
>  * Folded struct sg_lb_ipcc_stats into struct sg_lb_stats. (Dietmar)
>  * Reworded description sg_lb_stats::min_ipcc. (Ionela)
>  * Handle errors of arch_get_ipcc_score(). (Ionela)
> 
> Changes since v1:
>  * Implemented cleanups and reworks from PeterZ. Thanks!
>  * Used the new interface names.
> ---
>  kernel/sched/fair.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6189d1a45635..c0cab5e501b6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9110,6 +9110,11 @@ struct sg_lb_stats {
>  	unsigned int nr_numa_running;
>  	unsigned int nr_preferred_running;
>  #endif
> +#ifdef CONFIG_IPC_CLASSES
> +	unsigned long min_score; /* Min(score(rq->curr->ipcc)) */
                                              ^^^^^^^^^^^^^^
> +	unsigned short min_ipcc; /* Class of the task with the minimum IPCC score in the rq */
> +	unsigned long sum_score; /* Sum(score(rq->curr->ipcc)) */
                                              ^^^^^^^^^^^^^^
These no longer apply. It might be easier to describe them all in a
comment just above their declaration. Something like:

"The sum, min and its class of the IPC scores of the tasks at the back of each
runqueue in the group."

> +#endif
>  };
>  
>  /*
> @@ -9387,6 +9392,77 @@ group_type group_classify(unsigned int imbalance_pct,
>  	return group_has_spare;
>  }
>  
> +#ifdef CONFIG_IPC_CLASSES
> +static void init_rq_ipcc_stats(struct sg_lb_stats *sgs)
> +{
> +	/* All IPCC stats have been set to zero in update_sg_lb_stats(). */
> +	sgs->min_score = ULONG_MAX;
> +}
> +
> +static int rq_last_task_ipcc(int dst_cpu, struct rq *rq, unsigned short *ipcc)
> +{
> +	struct list_head *tasks = &rq->cfs_tasks;
> +	struct task_struct *p;
> +	struct rq_flags rf;
> +	int ret = -EINVAL;
> +

It's more typical of ret to be initialised to 0 and changed to an error
value when there's an error case.

> +	rq_lock_irqsave(rq, &rf);
> +	if (list_empty(tasks))
> +		goto out;
> +
> +	p = list_last_entry(tasks, struct task_struct, se.group_node);
> +	if (p->flags & PF_EXITING || is_idle_task(p) ||
> +	    !cpumask_test_cpu(dst_cpu, p->cpus_ptr))
> +		goto out;
> +
> +	ret = 0;
> +	*ipcc = p->ipcc;
> +out:
> +	rq_unlock(rq, &rf);
> +	return ret;
> +}
> +
> +/* Called only if cpu_of(@rq) is not idle and has tasks running. */
> +static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
> +				    struct rq *rq)
> +{
> +	unsigned short ipcc;
> +	unsigned long score;
> +
> +	if (!sched_ipcc_enabled())
> +		return;
> +
> +	if (rq_last_task_ipcc(dst_cpu, rq, &ipcc))
> +		return;
> +
> +	score = arch_get_ipcc_score(ipcc, cpu_of(rq));
> +
> +	/*
> +	 * Ignore tasks with invalid scores. When finding the busiest group, we
> +	 * prefer those with higher sum_score. This group will not be selected.
> +	 */

nit: the comment is unnecessary, and a bit misleading, IMO.

The comment says "This group will not be selected." but the only way to
guarantee that here is to reset the sum_score to 0 when you find an
invalid score, which I don't believe is your intention.

Also the use of sum_score is captured in later functions, so I don't
believe there's a need for additional comments here.

Hope it helps,
Ionela.

> +	if (IS_ERR_VALUE(score))
> +		return;
> +
> +	sgs->sum_score += score;
> +
> +	if (score < sgs->min_score) {
> +		sgs->min_score = score;
> +		sgs->min_ipcc = ipcc;
> +	}
> +}
> +
> +#else /* CONFIG_IPC_CLASSES */
> +static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
> +				    struct rq *rq)
> +{
> +}
> +
> +static void init_rq_ipcc_stats(struct sg_lb_stats *sgs)
> +{
> +}
> +#endif /* CONFIG_IPC_CLASSES */
> +
>  /**
>   * sched_use_asym_prio - Check whether asym_packing priority must be used
>   * @sd:		The scheduling domain of the load balancing
> @@ -9477,6 +9553,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	int i, nr_running, local_group;
>  
>  	memset(sgs, 0, sizeof(*sgs));
> +	init_rq_ipcc_stats(sgs);
>  
>  	local_group = group == sds->local;
>  
> @@ -9526,6 +9603,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  			if (sgs->group_misfit_task_load < load)
>  				sgs->group_misfit_task_load = load;
>  		}
> +
> +		update_sg_lb_ipcc_stats(env->dst_cpu, sgs, rq);
>  	}
>  
>  	sgs->group_capacity = group->sgc->capacity;
> -- 
> 2.25.1
> 
