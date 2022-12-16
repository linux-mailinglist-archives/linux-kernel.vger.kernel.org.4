Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB9564F4EA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiLPXRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiLPXQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:16:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47C663D3B;
        Fri, 16 Dec 2022 15:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671232576; x=1702768576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4TwMHbHcz5c58OOhZoR8gaykEMG0kQlgrEFXlEMBq9o=;
  b=E1Sz8i17m6dAu8GSgOCUtpO+5u961J6AI7yfYJiQW7dF9QfxKzLvQAIn
   59EvmvbTnbqMgLPu3nuNGJFKzLvZAfmMM3RdTHvfipZfXUxcrMtEjgpCu
   mOC5Nh5f/sBXZAoZu1ThwNYWcVGcPjejpGcC/twb+sQjddE8J/YAsgh/R
   tihOTLAyy4EqKYaRMkfCAUwHlaP/3DiUM6/F3FqF7HFy1ecVXh7aCka2Y
   WpNEXrw2gttQZy2gDVLlwM6BNmRehXWxTHtQoIKg4DsuiB6GjB3W62PyN
   WuSaTAN0jfO4L4DR6IkPe9IpB9osw43X8gLrlyrMNjDGF1JRevxf8dSsa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="302497732"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="302497732"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 15:16:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="643419690"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="643419690"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2022 15:15:47 -0800
Date:   Fri, 16 Dec 2022 15:24:06 -0800
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 09/22] sched/fair: Use IPC class score to select a
 busiest runqueue
Message-ID: <20221216232406.GA23530@ranerica-svr.sc.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-10-ricardo.neri-calderon@linux.intel.com>
 <Y5Gld+cThNOPFvgX@arm.com>
 <20221214003243.GC30234@ranerica-svr.sc.intel.com>
 <Y5pZV0txyK2Fkkg6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5pZV0txyK2Fkkg6@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:16:39PM +0000, Ionela Voinescu wrote:
> Hi Ricardo,
> 
> On Tuesday 13 Dec 2022 at 16:32:43 (-0800), Ricardo Neri wrote:
> [..]
> > > >  /**
> > > > @@ -10419,8 +10442,8 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > > >  {
> > > >  	struct rq *busiest = NULL, *rq;
> > > >  	unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
> > > > +	int i, busiest_ipcc_delta = INT_MIN;
> > > >  	unsigned int busiest_nr = 0;
> > > > -	int i;
> > > >  
> > > >  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
> > > >  		unsigned long capacity, load, util;
> > > > @@ -10526,8 +10549,37 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > > >  
> > > >  		case migrate_task:
> > > >  			if (busiest_nr < nr_running) {
> > > > +				struct task_struct *curr;
> > > > +
> > > >  				busiest_nr = nr_running;
> > > >  				busiest = rq;
> > > > +
> > > > +				/*
> > > > +				 * Remember the IPC score delta of busiest::curr.
> > > > +				 * We may need it to break a tie with other queues
> > > > +				 * with equal nr_running.
> > > > +				 */
> > > > +				curr = rcu_dereference(busiest->curr);
> > > > +				busiest_ipcc_delta = ipcc_score_delta(curr,
> > > > +								      env->dst_cpu);
> > > > +			/*
> > > > +			 * If rq and busiest have the same number of running
> > > > +			 * tasks, pick rq if doing so would give rq::curr a
> > > > +			 * bigger IPC boost on dst_cpu.
> > > > +			 */
> > > > +			} else if (sched_ipcc_enabled() &&
> > > > +				   busiest_nr == nr_running) {
> > > > +				struct task_struct *curr;
> > > > +				int delta;
> > > > +
> > > > +				curr = rcu_dereference(rq->curr);
> > > > +				delta = ipcc_score_delta(curr, env->dst_cpu);
> > > > +
> > > > +				if (busiest_ipcc_delta < delta) {
> > > > +					busiest_ipcc_delta = delta;
> > > > +					busiest_nr = nr_running;
> > > > +					busiest = rq;
> > > > +				}
> > > >  			}
> > > >  			break;
> > > >  
> > > 
> > > While in the commit message you describe this as breaking a tie for
> > > asym_packing,
> > 
> > Are you referring to the overall series or this specific patch? I checked
> > commit message and I do not see references to asym_packing.
> 
> Sorry, my bad, I was thinking about the cover letter, not the commit
> message. It's under "+++ Balancing load using classes of tasks. Theory
> of operation".
> 
> > 
> > > the code here does not only affect asym_packing. If
> > > another architecture would have sched_ipcc_enabled() it would use this
> > > as generic policy, and that might not be desired.
> > 
> > Indeed, the patchset implements support to use IPCC classes for asym_packing,
> > but it is not limited to it.
> > 
> 
> So is your current intention to support IPC classes only for asym_packing
> for now?

My intention is to introduce IPC classes in general and make it available
to other policies or architectures. I use asym_packing as use case.


> What would be the impact on you if you were to limit the
> functionality in this patch to asym_packing only?

There would not be any adverse impact.

> 
> > It is true that I don't check here for asym_packing, but it should not be a
> > problem, IMO. I compare two runqueues with equal nr_running, either runqueue
> > is a good choice. This tie breaker is an overall improvement, no?
> > 
> 
> It could be, but equally there could be other better policies as well -
> other ways to consider IPC class information to break the tie.
> 
> If other architectures start having sched_ipcc_enabled() they would
> automatically use the policy you've decided on here. If other policies
> are better for those architectures this generic policy would be difficult
> to modify to ensure there are no regressions for all other architectures
> that use it, or it would be difficult to work around it.
> 
> For this and for future support of IPC classes I am just wondering if we
> can better design how we enable different architectures to have different
> policies.

I see your point. I agree that other architectures may want to implement
policies differently. I'll add an extra check for env->sd & SD_ASYM_PACKING.

Thanks and BR,
Ricardo
