Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EC6658947
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 04:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiL2Dv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 22:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2Dv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 22:51:26 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE18E95
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 19:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672285885; x=1703821885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=59i36TC3qVB7r4xcr2ZX3sAZi9oelqMTs+Bwmm1RP7M=;
  b=QJwtQBS3fMC1Zo0ZQHoh6ZFDGIOeOdN9MoRpIdVCk0kHZx0gRq21sx1p
   2YqrvDO/iLKc1sbwgghsAjzSZkNFVwzQj7g3RNJ9Bi7rSZP24YoJLQOXK
   tx8CUHwhplmZpahbgsJ7JRKhZUmHT0mgf32Tt4dAnm2klduE9aoexcm2/
   RF0Bx2WyOQY3TY+xeUuoIdBmC5hLrCUH4e3HqmB5hpDktIl0cwqwrEzmu
   ul5eSMIMZcqyitPutU5oiAHfhKvcTW7PNOlbKZYDgn73BN6fPd5wXNmz+
   P6hGMUAkrzEXWg3zX3C5kaSYbIJjNYWHkduA0kj9u5eTpL/Yj/IZlD88L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="383274425"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="383274425"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 19:51:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="716803442"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="716803442"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 28 Dec 2022 19:51:24 -0800
Date:   Wed, 28 Dec 2022 20:00:03 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Valentin Schneider <vschneid@redhat.com>
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
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 1/7] sched/fair: Generalize asym_packing logic for SMT
 local sched group
Message-ID: <20221229040003.GA11497@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
 <xhsmhv8m3e5sx.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhv8m3e5sx.mognet@vschneid.remote.csb>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 04:55:58PM +0000, Valentin Schneider wrote:
> On 22/11/22 12:35, Ricardo Neri wrote:
> > @@ -8926,25 +8924,16 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> >               return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> >       }
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
> >       /*
> > -	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
> > -	 * up with more than one busy SMT sibling and only pull tasks if there
> > -	 * are not busy CPUs (i.e., no CPU has running tasks).
> > +	 * @dst_cpu has SMT siblings. Do asym_packing load balancing only if
> > +	 * all its siblings are idle (moving tasks between physical cores in
> > +	 * which some SMT siblings are busy results in the same throughput).
> > +	 *
> > +	 * If the difference in the number of busy CPUs is two or more, let
> > +	 * find_busiest_group() take care of it. We only care if @sg has
> > +	 * exactly one busy CPU. This covers SMT and non-SMT sched groups.
> >        */
> > -	if (!sds->local_stat.sum_nr_running)
> > +	if (sg_busy_cpus == 1 && !sds->local_stat.sum_nr_running)
> >               return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> >
> 
> Some of this is new to me - I had missed the original series introducing
> this. However ISTM that this is conflating two concepts: SMT occupancy
> balancing, and asym packing.
> 
> Take the !local_is_smt :: sg_busy_cpus >= 2 :: return true; path. It does
> not involve asym packing priorities at all. This can end up in an
> ASYM_PACKING load balance,

Yes, this the desired result: an idle low-priority CPU should help a high-
priority core with more than one busy SMT sibling. But yes, it does not
relate to priorities and can be implemented differently.

> which per calculate_imbalance() tries to move
> *all* tasks to the higher priority CPU - in the case of SMT balancing,
> we don't want to totally empty the core, just its siblings.

But it will not empty the core, only one of its SMT siblings. A single
sibling will be selected in find_busiest_queue(). The other siblings will
be unaffected.

> 
> Is there an ITMT/big.LITTLE (or however x86 calls it) case that invalidates
> the above?

Please see below.

> 
> Say, what's not sufficient with the below? AFAICT the only thing that isn't
> covered is the sg_busy_cpus >= 2 thing, but IMO that's SMT balancing, not
> asym packing - if the current calculate_imbalance() doesn't do it, it
> should be fixed to do it.

Agreed.

>Looking at the
> 
>   local->group_type == group_has_spare
> 
> case, it looks like it should DTRT.

I had tried (and failed) to have find_busiest_group() handle the
!local_is_smt :: sg_busy_cpus >= 2 case. Now I think I made it work.

When the busiest group is not overloaded, find_busiest_group() and
local->group = group_has_spare during an idle load balance events the
number of *idle* CPUs. However, this does not work if the local and busiest
groups have different weights. In SMT2, for instance, if busiest has 2 busy
CPUs (i.e., 0 idle CPUs) and the destination CPU is idle, the difference in
the number of idle CPUs is 1. find_busiest_group() will incorrectly goto
out_balanced.

This issue very visible in Intel hybrid processors because the big cores
have SMT but the small cores do not. It can, however, be reproduced in non-
hybrid processors by offlining the SMT siblings of some cores.

The problem can be fixed by instead balancing the number of *busy* CPUs,
which is what in general we want, IMO. (When two groups have the same
weight, it is equivalent to balancing the number of idle CPUs).

This patch worked for me:

@@ -9787,14 +9787,18 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			lsub_positive(&nr_diff, local->sum_nr_running);
 			env->imbalance = nr_diff;
 		} else {
+			unsigned int busiest_busy_cpus, local_busy_cpus;
+
+			busiest_busy_cpus = busiest->group_weight - busiest->idle_cpus;
+			local_busy_cpus = local->group_weight - local->idle_cpus;
 
 			/*
 			 * If there is no overload, we just want to even the number of
-			 * idle cpus.
+			 * busy cpus.
 			 */
 			env->migration_type = migrate_task;
-			env->imbalance = max_t(long, 0,
-					       (local->idle_cpus - busiest->idle_cpus));
+			env->imbalance = max_t(long, 0 ,
+					       (busiest_busy_cpus -  local_busy_cpus));
 		}
 
 #ifdef CONFIG_NUMA
@@ -9981,18 +9985,24 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 			 */
 			goto out_balanced;
 
-		if (busiest->group_weight > 1 &&
-		    local->idle_cpus <= (busiest->idle_cpus + 1))
-			/*
-			 * If the busiest group is not overloaded
-			 * and there is no imbalance between this and busiest
-			 * group wrt idle CPUs, it is balanced. The imbalance
-			 * becomes significant if the diff is greater than 1
-			 * otherwise we might end up to just move the imbalance
-			 * on another group. Of course this applies only if
-			 * there is more than 1 CPU per group.
-			 */
-			goto out_balanced;
+		if (busiest->group_weight > 1) {
+			unsigned int local_busy_cpus, busiest_busy_cpus;
+
+			local_busy_cpus = local->group_weight - local->idle_cpus;
+			busiest_busy_cpus = busiest->group_weight - busiest->idle_cpus;
+
+			if (busiest_busy_cpus <= local_busy_cpus + 1)
+				/*
+				 * If the busiest group is not overloaded
+				 * and there is no imbalance between this and busiest
+				 * group wrt busy CPUs, it is balanced. The imbalance
+				 * becomes significant if the diff is greater than 1
+				 * otherwise we might end up to just move the imbalance
+				 * on another group. Of course this applies only if
+				 * there is more than 1 CPU per group.
+				 */
+				goto out_balanced;
+		}
 
 		if (busiest->sum_h_nr_running == 1)
 			/*

With this I can remove the sg_busy_cpus >=2 thing from asym_smt_can_pull_tasks().

> 
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 224107278471f..15eb2d3cff186 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9176,12 +9176,15 @@ static inline bool
>  sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
>  	   struct sched_group *group)
>  {
> -	/* Only do SMT checks if either local or candidate have SMT siblings */
> -	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
> -	    (group->flags & SD_SHARE_CPUCAPACITY))
> -		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
> +	/*
> +	 * For SMT, env->idle != CPU_NOT_IDLE isn't sufficient, we need to make
> +	 * sure the whole core is idle.
> +	 */
> +	if (((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
> +	     (group->flags & SD_SHARE_CPUCAPACITY)) &&
> +	    !test_idle_cores(env->dst_cpu))

But test_idle_cores() tests for *any* idle core in the highest domain with the
SD_SHARE_PKG_RESOURCES flag. Here we are only interested in the SMT siblings
of env->dst_cpu. If is_core_idle(env->dst_cpu) is used, then I agree with the
change.

Thanks and BR,
Ricardo
