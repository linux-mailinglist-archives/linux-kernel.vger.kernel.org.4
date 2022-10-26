Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCF60DA08
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiJZDu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJZDuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:50:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719492C655
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666756224; x=1698292224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zpOnBzO9Dt/i35i05ALyGW186mCLBguTKOsU6bl712c=;
  b=RyEA7JTjSSXj5hoQpNYg2icOp50pwKXyCxEWBj9UUiLbZo2dFDDtJi54
   nKOIz0NOTpzvINGQg7p4QiRZRqLVCe8Z+Ee08TfCYL+ctjhevUnrzQf4n
   qKscy50QkbIy7Y6eRfFXxo3QCYYNZLFTZ+uSrsHWDWSxpu9tyxTiC/fM7
   eT/1rHGTxFU4uykaV1XQMTHQ27/wRuavE8IPO4qCKqgwBL02CAh/6fkwq
   bzcBWXrixsbDX/9eNaNdYlfrrO9cBnIX/5nefkxgRrAklB0AXQrNu3S/9
   JZHHj6lJece90IH/NEpPZQ9JSuS7Q9nf6adJYN673Kxm4Qsvpys/C3Qdr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="309542247"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="309542247"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 20:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="631870334"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="631870334"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 25 Oct 2022 20:50:20 -0700
Date:   Tue, 25 Oct 2022 20:57:24 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 08/23] sched/fair: Compute task-class performance
 scores for load balancing
Message-ID: <20221026035724.GA21523@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-9-ricardo.neri-calderon@linux.intel.com>
 <YzK/QisKmix6hrKG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzK/QisKmix6hrKG@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:15:46AM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:11:50PM -0700, Ricardo Neri wrote:
> 
> > +static void compute_ilb_sg_task_class_scores(struct sg_lb_task_class_stats *class_sgs,
> > +					     struct sg_lb_stats *sgs,
> > +					     int dst_cpu)
> > +{
> > +	int group_score, group_score_without, score_on_dst_cpu;
> > +	int busy_cpus = sgs->group_weight - sgs->idle_cpus;
> > +
> > +	if (!sched_task_classes_enabled())
> > +		return;
> > +
> > +	/* No busy CPUs in the group. No tasks to move. */
> > +	if (!busy_cpus)
> > +		return;
> > +
> > +	score_on_dst_cpu = arch_get_task_class_score(class_sgs->p_min_score->class,
> > +						     dst_cpu);
> > +
> > +	/*
> > +	 * The simpest case. The single busy CPU in the current group will
> > +	 * become idle after pulling its current task. The destination CPU is
> > +	 * idle.
> > +	 */
> > +	if (busy_cpus == 1) {
> > +		sgs->task_class_score_before = class_sgs->sum_score;
> > +		sgs->task_class_score_after = score_on_dst_cpu;
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Now compute the group score with and without the task with the
> > +	 * lowest score. We assume that the tasks that remain in the group share
> > +	 * the CPU resources equally.
> > +	 */
> > +	group_score = class_sgs->sum_score / busy_cpus;
> > +
> > +	group_score_without =  (class_sgs->sum_score - class_sgs->min_score) /
> > +			       (busy_cpus - 1);
> > +
> > +	sgs->task_class_score_after = group_score_without + score_on_dst_cpu;
> > +	sgs->task_class_score_before = group_score;
> > +}

(I am sorry Peter, I just found that several emails were sitting on my drafts
directory).

> 
> That's just plain broken; also lots of cleanups done...

Thank you very much for your suggestions. They make sense to me. I only
have a comment...

Do you want me to add your Signed-off-by and Co-developed-by tags?

> 
> ---
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8405,12 +8405,14 @@ struct sg_lb_stats {
>  	enum group_type group_type;
>  	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
>  	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
> -	long task_class_score_after; /* Prospective task-class score after load balancing */
> -	long task_class_score_before; /* Task-class score before load balancing */
>  #ifdef CONFIG_NUMA_BALANCING
>  	unsigned int nr_numa_running;
>  	unsigned int nr_preferred_running;
>  #endif
> +#ifdef CONFIG_SCHED_TASK_CLASSES
> +	long task_class_score_after;  /* Prospective task-class score after load balancing */
> +	long task_class_score_before; /* Task-class score before load balancing */
> +#endif
>  };
>  
>  /*
> @@ -8689,58 +8691,54 @@ group_type group_classify(unsigned int i
>  }
>  
>  struct sg_lb_task_class_stats {
> -	/*
> -	 * Score of the task with lowest score among the current tasks (i.e.,
> -	 * runqueue::curr) of all runqueues in the scheduling group.
> -	 */
> -	int min_score;
> -	/*
> -	 * Sum of the scores of the current tasks of all runqueues in the
> -	 * scheduling group.
> -	 */
> -	long sum_score;
> -	/* The task with score equal to @min_score */
> -	struct task_struct *p_min_score;
> +	int min_score;                   /* Min(rq->curr->score) */
> +	int min_class;
> +	long sum_score;                  /* Sum(rq->curr->score) */
>  };
>  
>  #ifdef CONFIG_SCHED_TASK_CLASSES
> -static void init_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs)
> +static void init_sg_lb_task_class_stats(struct sg_lb_task_class_stats *sgcs)
>  {
> -	class_sgs->min_score = INT_MAX;
> -	class_sgs->sum_score = 0;
> -	class_sgs->p_min_score = NULL;
> +	*sgcs = (struct sg_lb_task_class_stats){
> +		.min_score = INT_MAX,
> +	};
>  }
>  
>  /** Called only if cpu_of(@rq) is not idle and has tasks running. */
> -static void update_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs,
> -					 struct rq *rq)
> +static void update_sg_lb_task_class_stats(struct sg_lb_task_class_stats *sgcs,
> +					  struct rq *rq)
>  {
> -	int score;
> +	struct task_struct *curr;
> +	int class, score;
>  
>  	if (!sched_task_classes_enabled())
>  		return;
>  
> +	curr = rcu_dereference(rq->curr);
> +	if (!curr || (curr->flags & PF_EXITING) || is_idle_task(curr))
> +		return;
> +
>  	/*
>  	 * TODO: if nr_running > 1 we may want go through all the tasks behind
>  	 * rq->curr.
>  	 */
> -	score = arch_get_task_class_score(rq->curr->class, cpu_of(rq));
> -
> -	class_sgs->sum_score += score;
> +	class = curr->class;
> +	score = arch_get_task_class_score(class, cpu_of(rq));
>  
> -	if (score >= class_sgs->min_score)
> -		return;
> +	sgcs->sum_score += score;
>  
> -	class_sgs->min_score = score;
> -	class_sgs->p_min_score = rq->curr;
> +	if (score < sgcs->min_score) {
> +		sgcs->min_score = score;
> +		sgcs->min_class = class;
> +	}
>  }
>  
> -static void compute_ilb_sg_task_class_scores(struct sg_lb_task_class_stats *class_sgs,
> -					     struct sg_lb_stats *sgs,
> -					     int dst_cpu)
> +static void update_sg_lb_stats_scores(struct sg_lb_task_class_stats *sgcs,
> +				      struct sg_lb_stats *sgs,
> +				      int dst_cpu)
>  {
> -	int group_score, group_score_without, score_on_dst_cpu;
>  	int busy_cpus = sgs->group_weight - sgs->idle_cpus;
> +	long before, after;
>  
>  	if (!sched_task_classes_enabled())
>  		return;
> @@ -8749,32 +8747,18 @@ static void compute_ilb_sg_task_class_sc
>  	if (!busy_cpus)
>  		return;
>  
> -	score_on_dst_cpu = arch_get_task_class_score(class_sgs->p_min_score->class,
> -						     dst_cpu);
> +	score_on_dst_cpu = arch_get_task_class_score(sgcs->min_class, dst_cpu);
>  
> -	/*
> -	 * The simpest case. The single busy CPU in the current group will
> -	 * become idle after pulling its current task. The destination CPU is
> -	 * idle.
> -	 */
> -	if (busy_cpus == 1) {
> -		sgs->task_class_score_before = class_sgs->sum_score;
> -		sgs->task_class_score_after = score_on_dst_cpu;
> -		return;
> -	}
> +	before = sgcs->sum_score
> +	after  = before - sgcs->min_score + score_on_dst_cpu;

This works when the sched group being evaluated has only one busy CPU
because it will become idle if the destination CPU (which was idle) pulls
the current task.

>  
> -	/*
> -	 * Now compute the group score with and without the task with the
> -	 * lowest score. We assume that the tasks that remain in the group share
> -	 * the CPU resources equally.
> -	 */
> -	group_score = class_sgs->sum_score / busy_cpus;
> -
> -	group_score_without =  (class_sgs->sum_score - class_sgs->min_score) /
> -			       (busy_cpus - 1);
> +	if (busy_cpus > 1) {
> +		before /= busy_cpus;
> +		after  /= busy_cpus;


However, I don't think this works when the sched group has more than one
busy CPU. 'before' and 'after' reflect the total throughput score of both
the sched group *and* the destination CPU.

One of the CPUs in the sched group will become idle after the balance.

Also, at this point we have already added score_on_dst_cpu. We are incorrectly
scaling it by the number of busy CPUs in the sched group.

We instead must scale 'after' by busy_cpus - 1 and then add score_on_dst_cpu.

> +	}
>  
> -	sgs->task_class_score_after = group_score_without + score_on_dst_cpu;
> -	sgs->task_class_score_before = group_score;
> +	sgs->task_class_score_before = before;
> +	sgs->task_class_score_after  = after;
>  

Thanks and BR,
Ricardo
>  
