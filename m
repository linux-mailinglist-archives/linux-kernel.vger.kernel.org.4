Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE91695486
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjBMXNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBMXNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:13:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F169C1EFEF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676330012; x=1707866012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6tvq+BOuk38zeNN0hmdoPLf3V+BGZZvkpvGaQlGVS0I=;
  b=TCO37ct3v6IJA+u3c+XwTYZc8knuueT9vD8ckJE0hNqNLAUh3fuZcyzQ
   Auz+t7F4SFwjU4Hya0rExT+Fn5o5YvML6Xj0PKUNFm8C4K+JQRr7F1r3e
   rLarj7ZJEM0F726CuPUQ14AilonMiuDyZtoDBprXcA9i6YdKcPOWboEnS
   dAxv7RWr9rqyI1g3HD4bGJrO/Qxa/CwU7Y2Mzq4iX2nAPfTkMn3a+RSyC
   /Z3i78agG9MHx3O4br3iU2mlSdPHKx7yAv2h+Fn9ga1qFXWzsN9f3pt4H
   h+iq/WmRzPELDYPmikZJ30ka2O0CjBYu5qH12WyISAIPKmye7s4mPBBJ2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="358429440"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="358429440"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 15:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668956882"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668956882"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 15:13:31 -0800
Date:   Mon, 13 Feb 2023 15:23:24 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 04/10] sched/fair: Let low-priority cores help
 high-priority busy SMT cores
Message-ID: <20230213232324.GB6164@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
 <3a41995b-c39c-7346-e04b-7f13433b51c2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a41995b-c39c-7346-e04b-7f13433b51c2@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 02:40:24PM +0100, Dietmar Eggemann wrote:
> On 07/02/2023 05:58, Ricardo Neri wrote:
> 
> [...]
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 80c86462c6f6..c9d0ddfd11f2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10436,11 +10436,20 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >  		    nr_running == 1)
> >  			continue;
> >  
> > -		/* Make sure we only pull tasks from a CPU of lower priority */
> > +		/*
> > +		 * Make sure we only pull tasks from a CPU of lower priority
> > +		 * when balancing between SMT siblings.
> > +		 *
> > +		 * If balancing between cores, let lower priority CPUs help
> > +		 * SMT cores with more than one busy sibling.
> > +		 */
> >  		if ((env->sd->flags & SD_ASYM_PACKING) &&
> >  		    sched_asym_prefer(i, env->dst_cpu) &&
> > -		    nr_running == 1)
> > -			continue;
> > +		    nr_running == 1) {
> > +			if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> > +			    (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && is_core_idle(i)))
> > +				continue;
> 
> is_core_idle(i) returns true for !CONFIG_SCHED_SMP. So far it was always
> guarded by `flags & SD_SHARE_CPUCAPACITY` which is only set for
> CONFIG_SCHED_SMP.
> 
> Here it's different but still depends on `flags & SD_ASYM_PACKING`.
> 
> Can we have SD_ASYM_PACKING w/o CONFIG_SCHED_SMP? The comment just says
> `If balancing between cores (MC), let lower priority CPUs help SMT cores
> with more than one busy sibling.`

We cannot have SD_ASYM_PACKING w/o CONFIG_SCHED_SMP. We may have it without
CONFIG_SCHED_SMT. In the latter case we want is_core_idle() to return true
as there are no SMT siblings competing for core throughput and CPU priority 
is meaningful. I can add an extra comment clarifying the !CONFIG_SCHED_SMT /

> 
> So this only mentions your specific asymmetric e-cores w/o SMT and
> p-cores w/ SMT case.
> 
> I'm asking since numa_idle_core(), the only user of is_core_idle() so
> far has an extra `!static_branch_likely(&sched_smt_present)` condition
> before calling it.

That is a good point. Calling is_core_idle() is pointless if
!static_branch_likely(&sched_smt_present).

As per feedback from Vincent and Peter, I have put this logic in a helper
function. I'll add an extra check for this static key.

> 
> > +		}
> >  
> >  		switch (env->migration_type) {
> >  		case migrate_load:
> > @@ -10530,8 +10539,20 @@ asym_active_balance(struct lb_env *env)
> >  	 * lower priority CPUs in order to pack all tasks in the
> >  	 * highest priority CPUs.
> >  	 */
> > -	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> > -	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
> > +	if (env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING)) {
> > +		/* Always obey priorities between SMT siblings. */
> > +		if (env->sd->flags & SD_SHARE_CPUCAPACITY)
> > +			return sched_asym_prefer(env->dst_cpu, env->src_cpu);
> > +
> > +		/*
> > +		 * A lower priority CPU can help an SMT core with more than one
> > +		 * busy sibling.
> > +		 */
> > +		return sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
> > +		       !is_core_idle(env->src_cpu);
> 
> Here it is similar.

I will use my helper function here as well.

Thanks and BR,
Ricardo
