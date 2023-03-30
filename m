Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7266CF8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjC3CDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjC3CDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:03:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043746AD;
        Wed, 29 Mar 2023 19:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680141828; x=1711677828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DUfcEOTcu0w4ZobAcyJXJiQ/3g/wHNqcV+kd77b0KSE=;
  b=ch310qPTBAi2ap/h4ZwhhViXu0seclw4d9WD9p0cTNt5NGDCr37ixYOx
   w8bfXk95GpiCc5xf2El5mup1jpd3+RdbKU+nRImIZUxzE0EY/TFYKsVqd
   a094EVf+ooxu3VSWebYQje54yymEM2upXMJny79AFfSvIs4Hk6a0fC+GY
   WlPSkQ8mAJgywtoyWTqXQWbNsmA4XFXTPNd/vCGm1fETVM2PteYzgeK1A
   1maTZY+mA/lIzeS10wobP9NIzwlB/sUj46Xol/joz8Ctwrl0DG8ykpjVg
   32kfzjCsE/N3Ed0/qOItWlW5+ZM312FBOaGEaXanAl1Wehf049oJhDbDP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="321433159"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="321433159"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 19:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="858725279"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="858725279"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2023 19:03:47 -0700
Date:   Wed, 29 Mar 2023 19:14:31 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 10/24] sched/fair: Use IPCC scores to select a busiest
 runqueue
Message-ID: <20230330021431.GB26315@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-11-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtAciJr-ZQWcJN3bHZHyHmjmSOuDYZz9UwfK2EnMVPX6aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAciJr-ZQWcJN3bHZHyHmjmSOuDYZz9UwfK2EnMVPX6aQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:03:58PM +0200, Vincent Guittot wrote:
> On Tue, 7 Feb 2023 at 06:01, Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > For two runqueues of equal priority and equal number of running of tasks,
> > select the one whose current task would have the highest IPC class score
> > if placed on the destination CPU.
> 
> You failed to explain why it make sense to compare current task score
> whereas we will most probably not pull this task at the end

Thank you for your feedback Vincent! Please kindly refer to my reply to
your feedback in patch 7.

> >
> > For now, use IPCC scores only for scheduling domains with the
> > SD_ASYM_PACKING flag.
> >
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: x86@kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
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
> >  kernel/sched/fair.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 72d88270b320..d3c22dc145f7 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9399,6 +9399,37 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
> >         return sched_asym_ipcc_prefer(a_stats, b_stats);
> >  }
> >
> > +/**
> > + * ipcc_score_delta - Get the IPCC score delta wrt the load balance's dst_cpu
> > + * @p:         A task
> > + * @env:       Load balancing environment
> > + *
> > + * Returns: The IPCC score delta that @p would get if placed in the destination
> > + * CPU of @env. LONG_MIN to indicate that the delta should not be used.
> > + */
> > +static long ipcc_score_delta(struct task_struct *p, struct lb_env *env)
> > +{
> > +       unsigned long score_src, score_dst;
> > +       unsigned short ipcc = p->ipcc;
> > +
> > +       if (!sched_ipcc_enabled())
> > +               return LONG_MIN;
> > +
> > +       /* Only asym_packing uses IPCC scores at the moment. */
> > +       if (!(env->sd->flags & SD_ASYM_PACKING))
> > +               return LONG_MIN;
> > +
> > +       score_dst = arch_get_ipcc_score(ipcc, env->dst_cpu);
> > +       if (IS_ERR_VALUE(score_dst))
> > +               return LONG_MIN;
> > +
> > +       score_src = arch_get_ipcc_score(ipcc, task_cpu(p));
> > +       if (IS_ERR_VALUE(score_src))
> > +               return LONG_MIN;
> > +
> > +       return score_dst - score_src;
> > +}
> > +
> >  #else /* CONFIG_IPC_CLASSES */
> >  static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
> >                                     struct rq *rq)
> > @@ -9429,6 +9460,11 @@ static bool sched_asym_ipcc_pick(struct sched_group *a,
> >         return false;
> >  }
> >
> > +static long ipcc_score_delta(struct task_struct *p, struct lb_env *env)
> > +{
> > +       return LONG_MIN;
> > +}
> > +
> >  #endif /* CONFIG_IPC_CLASSES */
> >
> >  /**
> > @@ -10589,6 +10625,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >  {
> >         struct rq *busiest = NULL, *rq;
> >         unsigned long busiest_util = 0, busiest_load = 0, busiest_capacity = 1;
> > +       long busiest_ipcc_delta = LONG_MIN;
> >         unsigned int busiest_nr = 0;
> >         int i;
> >
> > @@ -10705,8 +10742,35 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >
> >                 case migrate_task:
> >                         if (busiest_nr < nr_running) {
> > +                               struct task_struct *curr;
> > +
> >                                 busiest_nr = nr_running;
> >                                 busiest = rq;
> > +
> > +                               /*
> > +                                * Remember the IPCC score delta of busiest::curr.
> > +                                * We may need it to break a tie with other queues
> > +                                * with equal nr_running.
> > +                                */
> > +                               curr = rcu_dereference(busiest->curr);
> > +                               busiest_ipcc_delta = ipcc_score_delta(curr, env);
> 
> Hmm, i don't like this at all
> 
> Also, curr is the least probable task to be pulled which means that
> all this his useless

but when doing asym_packing balancing nr_running = 1, need_active_balance()
returns true and we will pull the current task, no? This is also true for
fully_busy groups with one task per CPU. These are the only two cases that
currently use IPCC scores.

If there are more than one tasks in the runqueue, the group will be
classified as overloaded and we will not use IPCC scores nor active
balance.

Thanks and BR,
Ricardo
