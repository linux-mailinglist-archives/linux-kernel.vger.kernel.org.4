Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCEF73D38A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjFYUJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYUJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:09:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615BB12B;
        Sun, 25 Jun 2023 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687723751; x=1719259751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8vbFi8C3UhrauUoUcMrhi5Q92b4US4VObe9G4fZZdKQ=;
  b=K6EALgwIjPMgtbBgFhRGMIa0oBvmoGkbvHhZ8TyxhoRNdVnf3nCB2TDo
   GXm9jptqkTA2+mTAa2T44opc1VXlHTrZONNHzOlKSKaCuDncFACY7+fss
   SR7qscCNuJlAbx+qPZVNktpHci34pONt7FukRc/Vws/bvuPwYL+evGTsn
   VPm7dRXReSRXZtVuQGJwF0OX9FIHKxX7OsGnzBlgUiR6At8GXT2sCWhIX
   TUpXmYUxcqYJNPtkVyJiY+VXoJK6AcS4yDfsGQzahWbcKeInbUvBN02UI
   vJ7AkGF+i1HVrX7wQlx4qABR7KyYdnLXP5fN8oGNfwj8u4Zp6PdmH/bHn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="361148668"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="361148668"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 13:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="693245280"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="693245280"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 25 Jun 2023 13:09:08 -0700
Date:   Sun, 25 Jun 2023 13:11:55 -0700
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
Subject: Re: [PATCH v4 07/24] sched/fair: Compute IPC class scores for load
 balancing
Message-ID: <20230625201155.GA3902@ranerica-svr.sc.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
 <20230613042422.5344-8-ricardo.neri-calderon@linux.intel.com>
 <ZJQONIinvSengWa8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJQONIinvSengWa8@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 10:02:44AM +0100, Ionela Voinescu wrote:
> On Monday 12 Jun 2023 at 21:24:05 (-0700), Ricardo Neri wrote:
> > When using IPCC scores to break ties between two scheduling groups, it is
> > necessary to consider both the current score and the score that would
> > result after load balancing.
> > 
> > Compute the combined IPC class score of a scheduling group and the local
> > scheduling group. Compute both the current score and the prospective score.
> > 
> > Collect IPCC statistics only for asym_packing and fully_busy scheduling
> > groups. These are the only cases that use IPCC scores.
> > 
> > These IPCC statistics are used during idle load balancing. The candidate
> > scheduling group will have one fewer busy CPU after load balancing. This
> > observation is important for cores with SMT support.
> > 
> > The IPCC score of scheduling groups composed of SMT siblings needs to
> > consider that the siblings share CPU resources. When computing the total
> > IPCC score of the scheduling group, divide the score of each sibling by
> > the number of busy siblings.
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
> >  * None
> > 
> > Changes since v2:
> >  * Also collect IPCC stats for fully_busy sched groups.
> >  * Restrict use of IPCC stats to SD_ASYM_PACKING. (Ionela)
> >  * Handle errors of arch_get_ipcc_score(). (Ionela)
> > 
> > Changes since v1:
> >  * Implemented cleanups and reworks from PeterZ. I took all his
> >    suggestions, except the computation of the  IPC score before and after
> >    load balancing. We are computing not the average score, but the *total*.
> >  * Check for the SD_SHARE_CPUCAPACITY to compute the throughput of the SMT
> >    siblings of a physical core.
> >  * Used the new interface names.
> >  * Reworded commit message for clarity.
> > ---
> >  kernel/sched/fair.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c0cab5e501b6..a51c65c9335f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9114,6 +9114,8 @@ struct sg_lb_stats {
> >  	unsigned long min_score; /* Min(score(rq->curr->ipcc)) */
> >  	unsigned short min_ipcc; /* Class of the task with the minimum IPCC score in the rq */
> >  	unsigned long sum_score; /* Sum(score(rq->curr->ipcc)) */
> > +	long ipcc_score_after; /* Prospective IPCC score after load balancing */
> > +	unsigned long ipcc_score_before; /* IPCC score before load balancing */
> >  #endif
> >  };
> >  
> > @@ -9452,6 +9454,62 @@ static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
> >  	}
> >  }
> >  
> > +static void update_sg_lb_stats_scores(struct sg_lb_stats *sgs,
> > +				      struct sched_group *sg,
> > +				      struct lb_env *env)
> > +{
> > +	unsigned long score_on_dst_cpu, before;
> > +	int busy_cpus;
> > +	long after;
> > +
> > +	if (!sched_ipcc_enabled())
> > +		return;
> > +
> > +	/*
> > +	 * IPCC scores are only useful during idle load balancing. For now,
> > +	 * only asym_packing uses IPCC scores.
> > +	 */
> > +	if (!(env->sd->flags & SD_ASYM_PACKING) ||
> > +	    env->idle == CPU_NOT_IDLE)
> > +		return;
> > +
> > +	/*
> > +	 * IPCC scores are used to break ties only between these types of
> > +	 * groups.
> > +	 */
> > +	if (sgs->group_type != group_fully_busy &&
> > +	    sgs->group_type != group_asym_packing)
> > +		return;
> > +
> > +	busy_cpus = sgs->group_weight - sgs->idle_cpus;
> > +
> > +	/* No busy CPUs in the group. No tasks to move. */
> > +	if (!busy_cpus)
> > +		return;
> > +
> > +	score_on_dst_cpu = arch_get_ipcc_score(sgs->min_ipcc, env->dst_cpu);
> > +
> > +	/*
> > +	 * Do not use IPC scores. sgs::ipcc_score_{after, before} will be zero
> > +	 * and not used.
> > +	 */
> > +	if (IS_ERR_VALUE(score_on_dst_cpu))
> > +		return;
> > +
> > +	before = sgs->sum_score;
> > +	after = before - sgs->min_score;
> 
> I don't believe this can end up being negative as the sum of all
> scores should be higher or equal to the min score, right?

Yes, I agree. `after` cannot be negative.

> 
> I'm just wondering if ipcc_score_after can be made unsigned long as well,
> just for consistency.

Sure. I can make it of type unsigned long as well.

> 
> > +
> > +	/* SMT siblings share throughput. */
> > +	if (busy_cpus > 1 && sg->flags & SD_SHARE_CPUCAPACITY) {
> > +		before /= busy_cpus;
> > +		/* One sibling will become idle after load balance. */
> > +		after /= busy_cpus - 1;
> > +	}
> > +
> > +	sgs->ipcc_score_after = after + score_on_dst_cpu;
> > +	sgs->ipcc_score_before = before;
> 
> Shouldn't the score_on_dst_cpu be added to "after" before being divided
> between the SMT siblings?

No, because ipcc_score_after represents the joint score of the busiest
core and the destination core after load balance has taken place. The
destination core was previously idle and now contributes to the joint
score.

Thanks and BR,
Ricardo
