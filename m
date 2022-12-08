Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0649F646B08
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLHIvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLHIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:51:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0761CDC;
        Thu,  8 Dec 2022 00:51:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67575D6E;
        Thu,  8 Dec 2022 00:51:12 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4806B3F73D;
        Thu,  8 Dec 2022 00:51:05 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:51:03 +0000
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
Subject: Re: [PATCH v2 09/22] sched/fair: Use IPC class score to select a
 busiest runqueue
Message-ID: <Y5Gld+cThNOPFvgX@arm.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-10-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128132100.30253-10-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 28 Nov 2022 at 05:20:47 (-0800), Ricardo Neri wrote:
> For two runqueues of equal priority and equal number of running of tasks,
> select the one whose current task would have the highest IPC class score
> if placed on the destination CPU.
> 
[..]
> +static int ipcc_score_delta(struct task_struct *p, int alt_cpu)
> +{
> +	unsigned long ipcc = p->ipcc;
> +
> +	if (!sched_ipcc_enabled())
> +		return INT_MIN;
> +
> +	return arch_get_ipcc_score(ipcc, alt_cpu) -
> +	       arch_get_ipcc_score(ipcc, task_cpu(p));

Nit: arch_get_ipcc_score() return values are never checked for error.

> +}
> +
>  #else /* CONFIG_IPC_CLASSES */
>  static void update_sg_lb_ipcc_stats(struct sg_lb_ipcc_stats *sgcs,
>  				    struct rq *rq)
> @@ -9258,6 +9276,11 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
>  	return false;
>  }
>  
> +static int ipcc_score_delta(struct task_struct *p, int alt_cpu)
> +{
> +	return INT_MIN;
> +}
> +
>  #endif /* CONFIG_IPC_CLASSES */
>  
>  /**
> @@ -10419,8 +10442,8 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  {
>  	struct rq *busiest = NULL, *rq;
>  	unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
> +	int i, busiest_ipcc_delta = INT_MIN;
>  	unsigned int busiest_nr = 0;
> -	int i;
>  
>  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>  		unsigned long capacity, load, util;
> @@ -10526,8 +10549,37 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  
>  		case migrate_task:
>  			if (busiest_nr < nr_running) {
> +				struct task_struct *curr;
> +
>  				busiest_nr = nr_running;
>  				busiest = rq;
> +
> +				/*
> +				 * Remember the IPC score delta of busiest::curr.
> +				 * We may need it to break a tie with other queues
> +				 * with equal nr_running.
> +				 */
> +				curr = rcu_dereference(busiest->curr);
> +				busiest_ipcc_delta = ipcc_score_delta(curr,
> +								      env->dst_cpu);
> +			/*
> +			 * If rq and busiest have the same number of running
> +			 * tasks, pick rq if doing so would give rq::curr a
> +			 * bigger IPC boost on dst_cpu.
> +			 */
> +			} else if (sched_ipcc_enabled() &&
> +				   busiest_nr == nr_running) {
> +				struct task_struct *curr;
> +				int delta;
> +
> +				curr = rcu_dereference(rq->curr);
> +				delta = ipcc_score_delta(curr, env->dst_cpu);
> +
> +				if (busiest_ipcc_delta < delta) {
> +					busiest_ipcc_delta = delta;
> +					busiest_nr = nr_running;
> +					busiest = rq;
> +				}
>  			}
>  			break;
>  

While in the commit message you describe this as breaking a tie for
asym_packing, the code here does not only affect asym_packing. If
another architecture would have sched_ipcc_enabled() it would use this
as generic policy, and that might not be desired.

Hope it helps,
Ionela.

> -- 
> 2.25.1
> 
> 
