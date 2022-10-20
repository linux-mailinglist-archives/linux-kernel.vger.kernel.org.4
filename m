Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9BE6054FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiJTB1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJTB1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:27:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06D71BD5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666229221; x=1697765221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1uyks/ayh0C2K0MTN2JFP5jnIfzUMTgo/Qewd1r4ze8=;
  b=HEk6PfNzGBcdKUJjqJkeWC2453doB806Nxo7dSjF2pfaWp9Z3XInsK6O
   olismwhquCcx7jVdJS5BnwJ1/DLkQAI00VT7iuOw8zn+KYt0ADCvBnHor
   6JO1b1DQhnRH8QxneUPrIfBMe0BI3JodhYNnUkhHXbR1TSGat2IWQ2KQV
   ouiCm0epDryZRV6vpHx/Lo+Fslm9D4vvefEAhsSo8guKCCKkEMYGxdfyi
   TbMQtLcZBEGjWdgDrKVWT5WXdMbWNvb63wACqG1vREhAO0RUf7f4mHM7F
   TTFy9tCtpORAsQWXAB8ewsFHGGpLwEzwSjrzo/tKVqzSVgwqcCiYBnWAD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="286292620"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="286292620"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 18:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="754843707"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="754843707"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2022 18:18:13 -0700
Date:   Wed, 19 Oct 2022 18:25:02 -0700
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
Subject: Re: [PATCH 1/4] sched/fair: Simplify asym_packing logic for SMT
 sched groups
Message-ID: <20221020012502.GA20255@ranerica-svr.sc.intel.com>
References: <20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com>
 <20220825225529.26465-2-ricardo.neri-calderon@linux.intel.com>
 <Y05zDJ7ecDJphdFS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y05zDJ7ecDJphdFS@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:34:04AM +0200, Peter Zijlstra wrote:
> On Thu, Aug 25, 2022 at 03:55:26PM -0700, Ricardo Neri wrote:
> > When the destination CPU is an SMT sibling and idle, it can only help the
> > busiest group if all of its other SMT siblings are also idle. Otherwise,
> > there is not increase in throughput.
> > 
> > It does not matter whether the busiest group has SMT siblings. Simply
> > check if there are any tasks running on the local group before proceeding.
> 
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  kernel/sched/fair.c | 29 +++++++++--------------------
> >  1 file changed, 9 insertions(+), 20 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 77b2048a9326..91f271ea02d2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8603,12 +8603,10 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> >  				    struct sched_group *sg)
> >  {
> >  #ifdef CONFIG_SCHED_SMT
> > -	bool local_is_smt, sg_is_smt;
> > +	bool local_is_smt;
> >  	int sg_busy_cpus;
> >  
> >  	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
> > -	sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
> > -
> >  	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
> >  
> >  	if (!local_is_smt) {
> > @@ -8629,25 +8627,16 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> >  		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> >  	}
> >  
> > -	/* @dst_cpu has SMT siblings. */
> > -
> > -	if (sg_is_smt) {
> > -		int local_busy_cpus = sds->local->group_weight -
> > -				      sds->local_stat.idle_cpus;
> > -		int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
> > -
> > -		if (busy_cpus_delta == 1)
> > -			return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> > -
> > -		return false;
> > -	}
> > -
> >  	/*
> > -	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
> > -	 * up with more than one busy SMT sibling and only pull tasks if there
> > -	 * are not busy CPUs (i.e., no CPU has running tasks).
> > +	 * @dst_cpu has SMT siblings. When both @dst_cpu and the busiest core
> > +	 * have one or more busy siblings, moving tasks between them results
> > +	 * in the same throughput. Only if all the siblings of @dst_cpu are
> > +	 * idle throughput can increase.
> > +	 *
> > +	 * If the difference in the number of busy CPUs is two or more, let
> > +	 * find_busiest_group() take care of it.
> >  	 */
> > -	if (!sds->local_stat.sum_nr_running)
> > +	if (sg_busy_cpus == 1 && !sds->local_stat.sum_nr_running)
> >  		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> >  
> 
> I can't follow this logic; doesn't this hard assume SMT2 at the very
> least? The case for Power7 with SMT8 is that SMT1 is faster than SMT2 is
> faster than SMT4, only once you have more than 4 threads active it no
> longer matters.

Now that I look at this again, the comment is correct but it is
implemented at wrong sched domain.

Consider in the "MC" level, two sched groups composed of SMT siblings.
Both sched group have one or more busy siblings and the difference
between busy siblings is exactly one. Pulling tasks to the sched group
with higher asym_prefer_cpu makes no difference in throughput. The
totality of CPU resources continue being share among the same number of
tasks. This is true for both SMT2 and SMT8, no?

Only when all the siblings of an SMT core are idle new CPU resources are
used.

The "MC" domain does not have the flag SD_SHARE_CPUCAPACITY. My patch
should check for this flag in the child domain.

At the "SMT" domain, yes, I agree that siblings with different priorities
should be accommodated.
