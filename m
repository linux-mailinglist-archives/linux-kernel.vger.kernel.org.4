Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4673C4FA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFWX6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWX6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:58:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4962693;
        Fri, 23 Jun 2023 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687564715; x=1719100715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZCsiRNeHR6k4zhE+8+E+Geaf2iCs4rkKevkjniNjVEc=;
  b=JnkgoL7Mmi6LUgeyTKSj3UEWKNmVfNW78MD45VBApcNHl5jlMFU6vqW4
   tRTbgfJ8xixcnIUADoxTvXJ1JUo7ANwmcubvSLPR3rm6hzHqLwPs/JHZq
   SEWiC54vraoZ5oQqe4z9uWJKPUITdpEaDY8taFFSZL8B217YTAeF8FYi0
   FOiPQr5p9Tkbmpa7U/Bmk0e/1VmsUaYXot6QFpRZohpBSY3AcqVL3Qx8R
   3+7y+gmR0JSeJQAOMnHR4HzIcIe+XLIql9G+6xAkCrNbW9zc2mDXbpuv1
   OV9tI2eb9ZoJ1jmiOgflflALGX8ZTT5yD0t/BWjJc4QPW660fhzAppgI7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="360923334"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="360923334"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 16:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="718697989"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="718697989"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2023 16:58:34 -0700
Date:   Fri, 23 Jun 2023 17:01:21 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
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
Message-ID: <20230624000121.GA32639@ranerica-svr.sc.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
 <20230613042422.5344-7-ricardo.neri-calderon@linux.intel.com>
 <ZJQN/KIwCUmzYoiN@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJQN/KIwCUmzYoiN@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 10:01:48AM +0100, Ionela Voinescu wrote:
> Hi Ricardo,

Hi Ionela,

Thank you very much for reviewing the patches!

> 
> On Monday 12 Jun 2023 at 21:24:04 (-0700), Ricardo Neri wrote:
> > When selecting the busiest scheduling group between two otherwise identical
> > groups of types asym_packing or fully_busy, IPC classes can be used to
> > break the tie.
> > 
> > Compute the IPC class performance score for a scheduling group. It is
> > defined as the sum of the IPC scores of the tasks at the back of each
> > runqueue in the group. Load balancing starts by pulling tasks from the back
> > of the runqueue first, making this tiebreaker more useful.
> > 
> > Also, track the IPC class with the lowest score in the scheduling group. A
> > task of this class will be pulled when the destination CPU has lower
> > priority than the fully_busy busiest group.
> > 
> > These two metrics will be used during idle load balancing to compute the
> > current and the potential IPC class score of a scheduling group in a
> > subsequent changeset.
> > 
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Perry Yuan <Perry.Yuan@amd.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v3:
> >  * Do not compute the IPCC stats using the current tasks of runqueues.
> >    Instead, use the tasks at the back of the queue. These are the tasks
> >    that will be pulled first during load balance. (Vincent)
> > 
> > Changes since v2:
> >  * Also excluded deadline and realtime tasks from IPCC stats. (Dietmar)
> >  * Also excluded tasks that cannot run on the destination CPU from the
> >    IPCC stats.
> >  * Folded struct sg_lb_ipcc_stats into struct sg_lb_stats. (Dietmar)
> >  * Reworded description sg_lb_stats::min_ipcc. (Ionela)
> >  * Handle errors of arch_get_ipcc_score(). (Ionela)
> > 
> > Changes since v1:
> >  * Implemented cleanups and reworks from PeterZ. Thanks!
> >  * Used the new interface names.
> > ---
> >  kernel/sched/fair.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6189d1a45635..c0cab5e501b6 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9110,6 +9110,11 @@ struct sg_lb_stats {
> >  	unsigned int nr_numa_running;
> >  	unsigned int nr_preferred_running;
> >  #endif
> > +#ifdef CONFIG_IPC_CLASSES
> > +	unsigned long min_score; /* Min(score(rq->curr->ipcc)) */
>                                               ^^^^^^^^^^^^^^
> > +	unsigned short min_ipcc; /* Class of the task with the minimum IPCC score in the rq */
> > +	unsigned long sum_score; /* Sum(score(rq->curr->ipcc)) */
>                                               ^^^^^^^^^^^^^^
> These no longer apply.

Indeed, I missed this. I will update them in the next version.

> It might be easier to describe them all in a
> comment just above their declaration. Something like:
> 
> "The sum, min and its class of the IPC scores of the tasks at the back of each
> runqueue in the group."

I am hesitant to describe the three members in a single comment as it
would not comply with what Documentation/doc-guide/kernel-doc.rst
specifies.

Admittedly, the current format does not comply either. :) I would opt to
be consistent with the existing format.

> 
> > +#endif
> >  };
> >  
> >  /*
> > @@ -9387,6 +9392,77 @@ group_type group_classify(unsigned int imbalance_pct,
> >  	return group_has_spare;
> >  }
> >  
> > +#ifdef CONFIG_IPC_CLASSES
> > +static void init_rq_ipcc_stats(struct sg_lb_stats *sgs)
> > +{
> > +	/* All IPCC stats have been set to zero in update_sg_lb_stats(). */
> > +	sgs->min_score = ULONG_MAX;
> > +}
> > +
> > +static int rq_last_task_ipcc(int dst_cpu, struct rq *rq, unsigned short *ipcc)
> > +{
> > +	struct list_head *tasks = &rq->cfs_tasks;
> > +	struct task_struct *p;
> > +	struct rq_flags rf;
> > +	int ret = -EINVAL;
> > +
> 
> It's more typical of ret to be initialised to 0 and changed to an error
> value when there's an error case.

My intention was to save lines of code. I would need to set the error
value and then goto out. I am ok with your suggestion if it improves
readability.

> 
> > +	rq_lock_irqsave(rq, &rf);
> > +	if (list_empty(tasks))
> > +		goto out;
> > +
> > +	p = list_last_entry(tasks, struct task_struct, se.group_node);
> > +	if (p->flags & PF_EXITING || is_idle_task(p) ||
> > +	    !cpumask_test_cpu(dst_cpu, p->cpus_ptr))
> > +		goto out;
> > +
> > +	ret = 0;
> > +	*ipcc = p->ipcc;
> > +out:
> > +	rq_unlock(rq, &rf);
> > +	return ret;
> > +}
> > +
> > +/* Called only if cpu_of(@rq) is not idle and has tasks running. */
> > +static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
> > +				    struct rq *rq)
> > +{
> > +	unsigned short ipcc;
> > +	unsigned long score;
> > +
> > +	if (!sched_ipcc_enabled())
> > +		return;
> > +
> > +	if (rq_last_task_ipcc(dst_cpu, rq, &ipcc))
> > +		return;
> > +
> > +	score = arch_get_ipcc_score(ipcc, cpu_of(rq));
> > +
> > +	/*
> > +	 * Ignore tasks with invalid scores. When finding the busiest group, we
> > +	 * prefer those with higher sum_score. This group will not be selected.
> > +	 */
> 
> nit: the comment is unnecessary, and a bit misleading, IMO.
> 
> The comment says "This group will not be selected." but the only way to
> guarantee that here is to reset the sum_score to 0 when you find an
> invalid score, which I don't believe is your intention.

You raise an interesting point. We will call this function for each rq
in the sched group. Thus, if we encounter an error, the scores would be
incomplete. Therefore, I think that the scores should be discarded and
reset to 0 so that they are not used, IMO.

> 
> Also the use of sum_score is captured in later functions, so I don't
> believe there's a need for additional comments here.

Sure, I can remove the comment. Or maybe rephrase it as per my previous
comment?

> 
> Hope it helps,

It does! Thanks again for taking the time.

BR,
Ricardo
