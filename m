Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5084C64D325
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLNXQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiLNXQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:16:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FFF249B5A;
        Wed, 14 Dec 2022 15:16:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00A69FEC;
        Wed, 14 Dec 2022 15:17:22 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.1.196.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2F8A3F5A1;
        Wed, 14 Dec 2022 15:16:40 -0800 (PST)
Date:   Wed, 14 Dec 2022 23:16:39 +0000
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
Message-ID: <Y5pZV0txyK2Fkkg6@arm.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-10-ricardo.neri-calderon@linux.intel.com>
 <Y5Gld+cThNOPFvgX@arm.com>
 <20221214003243.GC30234@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214003243.GC30234@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Tuesday 13 Dec 2022 at 16:32:43 (-0800), Ricardo Neri wrote:
[..]
> > >  /**
> > > @@ -10419,8 +10442,8 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > >  {
> > >  	struct rq *busiest = NULL, *rq;
> > >  	unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
> > > +	int i, busiest_ipcc_delta = INT_MIN;
> > >  	unsigned int busiest_nr = 0;
> > > -	int i;
> > >  
> > >  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
> > >  		unsigned long capacity, load, util;
> > > @@ -10526,8 +10549,37 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > >  
> > >  		case migrate_task:
> > >  			if (busiest_nr < nr_running) {
> > > +				struct task_struct *curr;
> > > +
> > >  				busiest_nr = nr_running;
> > >  				busiest = rq;
> > > +
> > > +				/*
> > > +				 * Remember the IPC score delta of busiest::curr.
> > > +				 * We may need it to break a tie with other queues
> > > +				 * with equal nr_running.
> > > +				 */
> > > +				curr = rcu_dereference(busiest->curr);
> > > +				busiest_ipcc_delta = ipcc_score_delta(curr,
> > > +								      env->dst_cpu);
> > > +			/*
> > > +			 * If rq and busiest have the same number of running
> > > +			 * tasks, pick rq if doing so would give rq::curr a
> > > +			 * bigger IPC boost on dst_cpu.
> > > +			 */
> > > +			} else if (sched_ipcc_enabled() &&
> > > +				   busiest_nr == nr_running) {
> > > +				struct task_struct *curr;
> > > +				int delta;
> > > +
> > > +				curr = rcu_dereference(rq->curr);
> > > +				delta = ipcc_score_delta(curr, env->dst_cpu);
> > > +
> > > +				if (busiest_ipcc_delta < delta) {
> > > +					busiest_ipcc_delta = delta;
> > > +					busiest_nr = nr_running;
> > > +					busiest = rq;
> > > +				}
> > >  			}
> > >  			break;
> > >  
> > 
> > While in the commit message you describe this as breaking a tie for
> > asym_packing,
> 
> Are you referring to the overall series or this specific patch? I checked
> commit message and I do not see references to asym_packing.

Sorry, my bad, I was thinking about the cover letter, not the commit
message. It's under "+++ Balancing load using classes of tasks. Theory
of operation".

> 
> > the code here does not only affect asym_packing. If
> > another architecture would have sched_ipcc_enabled() it would use this
> > as generic policy, and that might not be desired.
> 
> Indeed, the patchset implements support to use IPCC classes for asym_packing,
> but it is not limited to it.
> 

So is your current intention to support IPC classes only for asym_packing
for now? What would be the impact on you if you were to limit the
functionality in this patch to asym_packing only?

> It is true that I don't check here for asym_packing, but it should not be a
> problem, IMO. I compare two runqueues with equal nr_running, either runqueue
> is a good choice. This tie breaker is an overall improvement, no?
> 

It could be, but equally there could be other better policies as well -
other ways to consider IPC class information to break the tie.

If other architectures start having sched_ipcc_enabled() they would
automatically use the policy you've decided on here. If other policies
are better for those architectures this generic policy would be difficult
to modify to ensure there are no regressions for all other architectures
that use it, or it would be difficult to work around it.

For this and for future support of IPC classes I am just wondering if we
can better design how we enable different architectures to have different
policies.

Thanks,
Ionela.

> Thanks and BR,
> Ricardo
