Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD78E73C521
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjFXAWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 20:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjFXAWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:22:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F7C2955;
        Fri, 23 Jun 2023 17:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687566140; x=1719102140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U3MH7PP2TmV76figY0FD+MbRvRpBUufkqRIDmfyNmTc=;
  b=Nrqo22uN8gi9cfbFUNzlXemD9nP+hcyo2jRwCNsSR2PGd5+tnAmbHdBM
   LwrOpX6u5OFlEO67HpohfdjDMVcKxYIjPqpCGxLDVqUgQkidVIhG0cjQ9
   ROVIB/j8S1TFoBR5T3C2klMZA5t7y2qGPon6EFrn6YCxHRWZqqoYUpGmG
   6RL/I59XLsSBN3HijKm88V6ihH30Imtk4YpbxVx0NXrJwCNB6b5rb2pDj
   AUOEEhMFEzSOpGSEjfC5x8aooPbPqclH2DLEnxv9xmx6UmkfBy8xM02Zs
   vXiYdjtEhz1MwX++B973TTD9IS8niMyn6rIX7vQdiqH8Hx+AKYAc/jOhu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="447270509"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="447270509"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 17:22:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="715490601"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="715490601"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2023 17:22:18 -0700
Date:   Fri, 23 Jun 2023 17:25:05 -0700
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
Subject: Re: [PATCH v4 10/24] sched/fair: Use IPCC scores to select a busiest
 runqueue
Message-ID: <20230624002505.GB32639@ranerica-svr.sc.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
 <20230613042422.5344-11-ricardo.neri-calderon@linux.intel.com>
 <ZJQOVUcFrqNReP1o@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJQOVUcFrqNReP1o@arm.com>
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

On Thu, Jun 22, 2023 at 10:03:17AM +0100, Ionela Voinescu wrote:
> On Monday 12 Jun 2023 at 21:24:08 (-0700), Ricardo Neri wrote:
> > Use IPCC scores to break a tie between two runqueues with the same priority
> > and number of running tasks: select the runqueue of which the task enqueued
> > last would get a higher IPC boost when migrated to the destination CPU.
> > (These tasks are migrated first during load balance.)
> > 
> > For now, restrict the utilization of IPCC scores to scheduling domains
> > marked with the SD_ASYM_PACKING flag.
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
> >  * Only use IPCC scores to break ties if the sched domain uses
> >    asym_packing. (Ionela)
> >  * Handle errors of arch_get_ipcc_score(). (Ionela)
> > 
> > Changes since v1:
> >  * Fixed a bug when selecting a busiest runqueue: when comparing two
> >    runqueues with equal nr_running, we must compute the IPCC score delta
> >    of both.
> >  * Renamed local variables to improve the layout of the code block.
> >    (PeterZ)
> >  * Used the new interface names.
> > ---
> >  kernel/sched/fair.c | 61 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fcec791ede4f..da3e009eef42 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9564,6 +9564,41 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
> >  	return sched_asym_ipcc_prefer(a_stats, b_stats);
> >  }
> >  
> > +/**
> > + * ipcc_score_delta - Get the IPCC score delta wrt the load balance's dst_cpu
> > + * @rq:		A runqueue
> > + * @env:	Load balancing environment
> > + *
> > + * Returns: The IPCC score delta that the last task enqueued in @rq would get
> > + * if placed in the destination CPU of @env. LONG_MIN to indicate that the
> > + * delta should not be used.
> > + */
> > +static long ipcc_score_delta(struct rq *rq, struct lb_env *env)
> > +{
> > +	unsigned long score_src, score_dst;
> > +	unsigned short ipcc;
> > +
> > +	if (!sched_ipcc_enabled())
> > +		return LONG_MIN;
> > +
> > +	/* Only asym_packing uses IPCC scores at the moment. */
> > +	if (!(env->sd->flags & SD_ASYM_PACKING))
> > +		return LONG_MIN;
> > +
> > +	if (rq_last_task_ipcc(env->dst_cpu, rq, &ipcc))
> > +		return LONG_MIN;
> > +
> > +	score_dst = arch_get_ipcc_score(ipcc, env->dst_cpu);
> > +	if (IS_ERR_VALUE(score_dst))
> > +		return LONG_MIN;
> > +
> > +	score_src = arch_get_ipcc_score(ipcc, cpu_of(rq));
> > +	if (IS_ERR_VALUE(score_src))
> > +		return LONG_MIN;
> > +
> > +	return score_dst - score_src;
> > +}
> > +
> >  #else /* CONFIG_IPC_CLASSES */
> >  static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
> >  				    struct rq *rq)
> > @@ -9594,6 +9629,11 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
> >  	return false;
> >  }
> >  
> > +static long ipcc_score_delta(struct rq *rq, struct lb_env *env)
> > +{
> > +	return LONG_MIN;
> > +}
> > +
> >  #endif /* CONFIG_IPC_CLASSES */
> >  
> >  /**
> > @@ -10769,6 +10809,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >  {
> >  	struct rq *busiest = NULL, *rq;
> >  	unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
> > +	long busiest_ipcc_delta = LONG_MIN;
> >  	unsigned int busiest_nr = 0;
> >  	int i;
> >  
> > @@ -10885,6 +10926,26 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >  			if (busiest_nr < nr_running) {
> >  				busiest_nr = nr_running;
> >  				busiest = rq;
> > +
> > +				/*
> > +				 * Remember the IPCC score of the busiest
> > +				 * runqueue. We may need it to break a tie with
> > +				 * other queues with equal nr_running.
> > +				 */
> > +				busiest_ipcc_delta = ipcc_score_delta(busiest, env);
> > +			/*
> > +			 * For ties, select @rq if doing would give its last
> > +			 * queued task a bigger IPC boost when migrated to
> > +			 * dst_cpu.
> > +			 */
> > +			} else if (busiest_nr == nr_running) {
> > +				long delta = ipcc_score_delta(rq, env);
> > +
> > +				if (busiest_ipcc_delta < delta) {
> > +					busiest_ipcc_delta = delta;
> > +					busiest_nr = nr_running;
> 
> nit: there's no need as busiest_nr is already equal to nr_running.

True! I will remove this pointless assignment.

Thanks and BR,
Ricardo
