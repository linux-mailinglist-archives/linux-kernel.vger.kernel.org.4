Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD3664C120
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiLNAY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbiLNAYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:24:53 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B1EB1C1;
        Tue, 13 Dec 2022 16:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670977492; x=1702513492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BLlZbzmH6uKjXZKh08qdpfS+kNsRZLagHkkibALfGyw=;
  b=TqrHchrU3qe9u0L4dS+RC6jYUM/sze7vQrXMsumMwZby8EpmThFzPanx
   5Zwj5f9TF3eBCZXl8nocL6uPaGSbiCqm6wARwe5f+6CNGEWG3jgwj2fLf
   3715nXtSO/LvSBHAgQPBoUSiBEO2X4R09VONegEFwjBUiY/8p0zbdvG8B
   MBWXXIEI6Axzu2J7yfnGUfOOoC1SqEqE1kw4jybauJwdmnRwgYVv4+kl6
   aBWSSVyXBfpfgyXhz4H9NEWwMWINpSXXl1BepGtpUIOv6m9I+ocTGzVmQ
   2plF6SVf2Kdh4iGljkPX7oqmPmj2Xu6gmxduduUrLvHAAwR7xzP4qqLUe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="298619820"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="298619820"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 16:24:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="977619192"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="977619192"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP; 13 Dec 2022 16:24:32 -0800
Date:   Tue, 13 Dec 2022 16:32:43 -0800
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
Message-ID: <20221214003243.GC30234@ranerica-svr.sc.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
 <20221128132100.30253-10-ricardo.neri-calderon@linux.intel.com>
 <Y5Gld+cThNOPFvgX@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5Gld+cThNOPFvgX@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 08:51:03AM +0000, Ionela Voinescu wrote:
> Hi,
> 
> On Monday 28 Nov 2022 at 05:20:47 (-0800), Ricardo Neri wrote:
> > For two runqueues of equal priority and equal number of running of tasks,
> > select the one whose current task would have the highest IPC class score
> > if placed on the destination CPU.
> > 
> [..]
> > +static int ipcc_score_delta(struct task_struct *p, int alt_cpu)
> > +{
> > +	unsigned long ipcc = p->ipcc;
> > +
> > +	if (!sched_ipcc_enabled())
> > +		return INT_MIN;
> > +
> > +	return arch_get_ipcc_score(ipcc, alt_cpu) -
> > +	       arch_get_ipcc_score(ipcc, task_cpu(p));
> 
> Nit: arch_get_ipcc_score() return values are never checked for error.

Fair point. I will handle error values.

> 
> > +}
> > +
> >  #else /* CONFIG_IPC_CLASSES */
> >  static void update_sg_lb_ipcc_stats(struct sg_lb_ipcc_stats *sgcs,
> >  				    struct rq *rq)
> > @@ -9258,6 +9276,11 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
> >  	return false;
> >  }
> >  
> > +static int ipcc_score_delta(struct task_struct *p, int alt_cpu)
> > +{
> > +	return INT_MIN;
> > +}
> > +
> >  #endif /* CONFIG_IPC_CLASSES */
> >  
> >  /**
> > @@ -10419,8 +10442,8 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >  {
> >  	struct rq *busiest = NULL, *rq;
> >  	unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
> > +	int i, busiest_ipcc_delta = INT_MIN;
> >  	unsigned int busiest_nr = 0;
> > -	int i;
> >  
> >  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
> >  		unsigned long capacity, load, util;
> > @@ -10526,8 +10549,37 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >  
> >  		case migrate_task:
> >  			if (busiest_nr < nr_running) {
> > +				struct task_struct *curr;
> > +
> >  				busiest_nr = nr_running;
> >  				busiest = rq;
> > +
> > +				/*
> > +				 * Remember the IPC score delta of busiest::curr.
> > +				 * We may need it to break a tie with other queues
> > +				 * with equal nr_running.
> > +				 */
> > +				curr = rcu_dereference(busiest->curr);
> > +				busiest_ipcc_delta = ipcc_score_delta(curr,
> > +								      env->dst_cpu);
> > +			/*
> > +			 * If rq and busiest have the same number of running
> > +			 * tasks, pick rq if doing so would give rq::curr a
> > +			 * bigger IPC boost on dst_cpu.
> > +			 */
> > +			} else if (sched_ipcc_enabled() &&
> > +				   busiest_nr == nr_running) {
> > +				struct task_struct *curr;
> > +				int delta;
> > +
> > +				curr = rcu_dereference(rq->curr);
> > +				delta = ipcc_score_delta(curr, env->dst_cpu);
> > +
> > +				if (busiest_ipcc_delta < delta) {
> > +					busiest_ipcc_delta = delta;
> > +					busiest_nr = nr_running;
> > +					busiest = rq;
> > +				}
> >  			}
> >  			break;
> >  
> 
> While in the commit message you describe this as breaking a tie for
> asym_packing,

Are you referring to the overall series or this specific patch? I checked
commit message and I do not see references to asym_packing.

> the code here does not only affect asym_packing. If
> another architecture would have sched_ipcc_enabled() it would use this
> as generic policy, and that might not be desired.

Indeed, the patchset implements support to use IPCC classes for asym_packing,
but it is not limited to it.

It is true that I don't check here for asym_packing, but it should not be a
problem, IMO. I compare two runqueues with equal nr_running, either runqueue
is a good choice. This tie breaker is an overall improvement, no?

Thanks and BR,
Ricardo
