Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248445F5D40
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJEXcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJEXcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:32:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B211E1F2F9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665012734; x=1696548734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=91qVlIFziYga16vsHFmmUqSlEGvN2rzt64LQa0EMhAE=;
  b=mztQYnpuP+xCZtKUdDtAFenThBavWfKRxu9eLh3OPEPWAg5JXU4/9o9J
   E58QkL2NTkPhPfh8SJzMe6311aZJOLGWSAM3MlLJvaI60QkuIf1n3zCbN
   abMqqNBkSY5uBbTrtRvWBRgmJ9fDt5iPnNVrF6B4RMand31MbctBE3wK0
   TnmTa16GWcu9k5iavQe0yLnkzjK5YExJMdJ39kANAFkyWBKv1HeiFQJam
   BZSWWvj+SVsiPsP6Lg/f/1n4NGBhvu0a+cvjk+V5dB2cg92j6lOYM3U0a
   GTq8mYhkTsHBYpwzq96mKS8QeGzuai8c2mF6wztToNDr+UVNMUGUJ9PUv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="303275438"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="303275438"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 16:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="624516596"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="624516596"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2022 16:32:13 -0700
Date:   Wed, 5 Oct 2022 16:38:41 -0700
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
Subject: Re: [RFC PATCH 09/23] sched/fair: Use task-class performance score
 to pick the busiest group
Message-ID: <20221005233841.GA29251@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-10-ricardo.neri-calderon@linux.intel.com>
 <YzLYDPU+upHeUG65@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLYDPU+upHeUG65@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:01:32PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:11:51PM -0700, Ricardo Neri wrote:
> > update_sd_pick_busiest() keeps on selecting as the busiest group scheduling
> > groups of identical priority. Since both groups have the same priority,
> > either group is a good choice. The classes of tasks in the scheduling
> > groups can break this tie.
> > 
> > Pick as busiest the scheduling group that yields a higher task-class
> > performance score after load balancing.
> 
> > +/**
> > + * sched_asym_class_pick - Select a sched group based on classes of tasks
> > + * @a:		A scheduling group
> > + * @b:		A second scheduling group
> > + * @a_stats:	Load balancing statistics of @a
> > + * @b_stats:	Load balancing statistics of @b
> > + *
> > + * Returns: true if @a has the same priority and @a has classes of tasks that
> > + * yield higher overall throughput after load balance. Returns false otherwise.
> > + */
> > +static bool sched_asym_class_pick(struct sched_group *a,
> > +				  struct sched_group *b,
> > +				  struct sg_lb_stats *a_stats,
> > +				  struct sg_lb_stats *b_stats)
> > +{
> > +	/*
> > +	 * Only use the class-specific preference selection if both sched
> > +	 * groups have the same priority.
> > +	 */
> > +	if (arch_asym_cpu_priority(a->asym_prefer_cpu) !=
> > +	    arch_asym_cpu_priority(b->asym_prefer_cpu))
> > +		return false;
> > +
> > +	return sched_asym_class_prefer(a_stats, b_stats);
> > +}
> > +
> >  #else /* CONFIG_SCHED_TASK_CLASSES */
> >  static void update_rq_task_classes_stats(struct sg_lb_task_class_stats *class_sgs,
> >  					 struct rq *rq)
> 
> > @@ -9049,6 +9111,12 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >  		/* Prefer to move from lowest priority CPU's work */
> >  		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> >  			return false;
> > +
> > +		/* @sg and @sds::busiest have the same priority. */
> > +		if (sched_asym_class_pick(sds->busiest, sg, &sds->busiest_stat, sgs))
> > +			return false;
> > +
> > +		/* @sg has lower priority than @sds::busiest. */
> >  		break;
> >  
> >  	case group_misfit_task:
> 
> So why does only this one instance of asym_prefer() require tie
> breaking?

This is the only place in which two sched groups with running tasks and of
equal priority are compared.

In all other places sched_asym_prefer() is used to compare the destination
CPU with others. Since asym_packing is done only when the destination CPU is
idle, there is no need to break this tie.

> 
> I must also re-iterate how much I hate having two different means of
> dealing with big-little topologies.

Yes, that is true. We discussed the challenges of using EAS on x86 during
this year's Linux Plumbers Conference. For the discussion at hand, I think
that the most relevant part is the difficulty to assess CPU capacity
on Intel processors given the presence of SMT, a large range of turbo
frequencies and hardware-controlled frequency scaling.

We are looking into these challenges.

This patchset focuses mainly on the infrastructure to support IPC classes of
tasks in the scheduler. We use it on this tie break when using asym_packing,
but it could be used in capacity computations.

> 
> And while looking through this, I must ask about the comment that goes
> with sched_set_itmt_core_prio() vs the sg->asym_prefer_cpu assignment in
> init_sched_groups_capacity(), what-up ?!

Are you referring to this comment?

	"No need to rebuild sched domain after updating
	 the CPU priorities. The sched domains have no
	 dependency on CPU priorities"

If yes, then it looks wrong to me. Sched domains are rebuilt after updating
priorities.

Thanks and BR,
Ricardo
