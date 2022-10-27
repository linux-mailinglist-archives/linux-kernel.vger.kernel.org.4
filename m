Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19BD60EE7F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 05:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiJ0DXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 23:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJ0DXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 23:23:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E288E9AE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 20:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666841013; x=1698377013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fy/o4xvFpv2SkDdrIsM8F6V3bOLrYpjKio8j7Xpz9rg=;
  b=c4pXhFsQB/3lRrjAJ9awQYUjV15uKbP6pvHiSuVbdH7KZNocObd2lW24
   hw40T4JTuz7XqoYMovakoyvV3bFP0QXq31kur6xv6m5fDhtSwAGUxjqQV
   Eg1seqUfg6zcuCkiYvXGE/a/r48Ty6Z9JfNToYdHftt9PNWLABX4UMWOC
   aL5TMFgKhRbzxb6mL/qK9gjZ+a2T6YmBGUGMLb/bM7/yv7H98V+VdcLy7
   l5MCO40/AVhQSWEvb0yYQ2F54IBUpAaElWwHJ/FfJhDjplPkt3I4jg67R
   7dZtfSCHYFr22ndrJHlon0l4cwH17explrw8TJpkiXh1wCbar8rgzKTjX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="291422436"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="291422436"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 20:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="632253410"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="632253410"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 26 Oct 2022 20:23:32 -0700
Date:   Wed, 26 Oct 2022 20:30:37 -0700
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
Message-ID: <20221027033037.GA9946@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-9-ricardo.neri-calderon@linux.intel.com>
 <YzK/QisKmix6hrKG@hirez.programming.kicks-ass.net>
 <20221026035724.GA21523@ranerica-svr.sc.intel.com>
 <Y1j170UQc5DJPYgR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1j170UQc5DJPYgR@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 10:55:11AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 25, 2022 at 08:57:24PM -0700, Ricardo Neri wrote:
> 
> > Do you want me to add your Signed-off-by and Co-developed-by tags?
> 
> Nah; who cares ;-)
> 
> 
> > > @@ -8749,32 +8747,18 @@ static void compute_ilb_sg_task_class_sc
> > >  	if (!busy_cpus)
> > >  		return;
> > >  
> > > -	score_on_dst_cpu = arch_get_task_class_score(class_sgs->p_min_score->class,
> > > -						     dst_cpu);
> > > +	score_on_dst_cpu = arch_get_task_class_score(sgcs->min_class, dst_cpu);
> > >  
> > > -	/*
> > > -	 * The simpest case. The single busy CPU in the current group will
> > > -	 * become idle after pulling its current task. The destination CPU is
> > > -	 * idle.
> > > -	 */
> > > -	if (busy_cpus == 1) {
> > > -		sgs->task_class_score_before = class_sgs->sum_score;
> > > -		sgs->task_class_score_after = score_on_dst_cpu;
> > > -		return;
> > > -	}
> > > +	before = sgcs->sum_score
> > > +	after  = before - sgcs->min_score + score_on_dst_cpu;
> > 
> > This works when the sched group being evaluated has only one busy CPU
> > because it will become idle if the destination CPU (which was idle) pulls
> > the current task.
> > 
> > >  
> > > -	/*
> > > -	 * Now compute the group score with and without the task with the
> > > -	 * lowest score. We assume that the tasks that remain in the group share
> > > -	 * the CPU resources equally.
> > > -	 */
> > > -	group_score = class_sgs->sum_score / busy_cpus;
> > > -
> > > -	group_score_without =  (class_sgs->sum_score - class_sgs->min_score) /
> > > -			       (busy_cpus - 1);
> > > +	if (busy_cpus > 1) {
> > > +		before /= busy_cpus;
> > > +		after  /= busy_cpus;
> > 
> > 
> > However, I don't think this works when the sched group has more than one
> > busy CPU. 'before' and 'after' reflect the total throughput score of both
> > the sched group *and* the destination CPU.
> > 
> > One of the CPUs in the sched group will become idle after the balance.
> > 
> > Also, at this point we have already added score_on_dst_cpu. We are incorrectly
> > scaling it by the number of busy CPUs in the sched group.
> > 
> > We instead must scale 'after' by busy_cpus - 1 and then add score_on_dst_cpu.
> 
> So none of that makes sense.
> 
> 'x/n + y' != '(x+y)/(n+1)'
> 
> IOW:
> 
> > > +	}
> > >  
> > > -	sgs->task_class_score_after = group_score_without + score_on_dst_cpu;
> > > -	sgs->task_class_score_before = group_score;
> > > +	sgs->task_class_score_before = before;
> > > +	sgs->task_class_score_after  = after;
> 
> your task_class_score_after is a sum value for 2 cpus worth not a value
> for a single cpu,

Agreed.

> while your task_class_score_before is a single cpu
> average.

Agreed. You can also regard task_class_score_before as a value for 2 CPUs
worth, only that the contribution to throughput of dst_cpu is 0.

> You can't compare these numbers and have a sensible outcome.
> 
> If you have a number of values: x_1....x_n, their average is
> Sum(x_1...x_n) / n, which is a single value again.
> 
> If you want to update one of the x's, say x_i->x'_i, then the average
> changes like:
> 
> 	Sum(x_1...x_n-x_i+x'_i) / n
> 
> If you want to remove one of the x's, then you get:
> 
> 	Sum(x_1...x_n-x_i) / (n-1) ; 0<i<n
> 
> if you want to add an x:
> 
> 	Sum(x_1...x_n+i_i) / (n+1) ; i>n
> 
> Nowhere would you ever get:
> 
> 	Sum(x_1...x_n) / n + x_i
> 
> That's just straight up nonsense.

But we are not computing the average throughput. We are computing the
*total* throughput of two CPUs. Hence, what we need is the sum of the
throughput score of both CPUs.

We may be here because the sched group of sgcs is composed of SMT
siblings. Hence, we divide by busy_cpus assuming that all busy siblings
share the core resources evenly. (For non-SMT sched groups, busy_cpus is 1
at most).

> 
> So I might buy an argument for:
> 
> 	if (busy_cpus > 1) {
> 		before /= (busy_cpus-1);
> 		after  /= (busy_cpus+1);
> 	}
> 
> Or something along those lines (where you remove an entry from before
> and add it to after), but not this.

The entry that we remove from before will go to after. The entry will be
placed in the local group. This group has a different busy_cpus: all of its
SMT siblings, if any, idle (otherwise, we would not be here). It will
become 1 after the balance.
