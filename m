Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8786CF8EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjC3B4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC3B4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:56:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149349F;
        Wed, 29 Mar 2023 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680141401; x=1711677401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DlS8VNXCfCNdNw5AUNR+1YnHEP1yI2ingqSLwM+LA9w=;
  b=DDgzbNanPw8yfkqrPjUse5JYW6WCHYcgHSSnfWsDUadNpwTUmErk2LHZ
   AxUiLCGqZAxpqTgM5Fp796MVFKbLBDgo4dIEFgVfDdex16871pk3H/TuG
   nv++CA+yvOi+MfdK4wLLVgEIvsqRaS3t27MqWbVk9VmSL+XJ+dvb4G8NZ
   zcGV19SmN/SyCvsiuDMyCci9cMDV5XBoKZ24FEGL1Yr0trBYIdQ0PPUQB
   ps3Ex6Kh4tvGp9oKLqjTqECB9jaOzEq5VldZc0e7ob77aHTeSytFKVv9Q
   n5ax3A6BLNOBHbYAJOyjf9ItVDkouPQq8Eeep1CFYxyw9VmKJgwa6y68Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="341065081"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="341065081"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 18:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="687050433"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="687050433"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2023 18:56:40 -0700
Date:   Wed, 29 Mar 2023 19:07:24 -0700
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
Subject: Re: [PATCH v3 07/24] sched/fair: Compute IPC class scores for load
 balancing
Message-ID: <20230330020724.GA26315@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-8-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtB_jZ6q0+9cWxjNZD9gLi-Ts_o_HfBZdiebZz89rHA6iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB_jZ6q0+9cWxjNZD9gLi-Ts_o_HfBZdiebZz89rHA6iw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:00:58PM +0200, Vincent Guittot wrote:
> On Tue, 7 Feb 2023 at 06:01, Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > Compute the joint total (both current and prospective) IPC class score of
> > a scheduling group and the local scheduling group.
> >
> > These IPCC statistics are used during idle load balancing. The candidate
> > scheduling group will have one fewer busy CPU after load balancing. This
> > observation is important for cores with SMT support.
> >
> > The IPCC score of scheduling groups composed of SMT siblings needs to
> > consider that the siblings share CPU resources. When computing the total
> > IPCC score of the scheduling group, divide score of each sibling by the
> > number of busy siblings.
> >
> > Collect IPCC statistics for asym_packing and fully_busy scheduling groups.
> 
> IPCC statistics collect scores of current tasks, so they are
> meaningful only when trying to migrate one of those running tasks.
> Using such score when pulling other tasks is just meaningless. And I
> don't see how you ensure such correct use of ipcc score

Thank you very much for your feedback Vincent!

It is true that the task that is current when collecting statistics may be
different from the task that is current when we are ready to pluck tasks.

Using IPCC scores for load balancing benefits large, long-running tasks
the most. For these tasks, the current task is likely to remain the same
at the two mentioned points in time.

My patchset proposes to use IPCC clases to break ties between otherwise
identical sched groups in update_sd_pick_busiest(). Its use is limited to
asym_packing and fully_busy types. For these types, it is likely that there
will not be tasks wanting to run other than current. need_active_balance()
will return true and we will migrate the current task.

You are correct, by only looking at the current tasks we risk overlooking
other tasks in the queue and the statistics becoming meaningless. A fully
correct solution would need to keep track of the the types of tasks in
all runqueues as they come and go. IMO, the increased complexity of such
approach does not justify the benefit. We give the load balancer extra
information to decide between otherwise identical sched groups using the
IPCC statistics of big tasks.

> 
> > When picking a busiest group, they are used to break ties between otherwise
> > identical groups.
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
> >  * Also collect IPCC stats for fully_busy sched groups.
> 
> Why have you added fully_busy case ? it's worth explaining the
> rational because there is a lot of change to use the ipcc score of the
> wrong task to take the decision

When deciding between two fully_busy sched groups, update_sd_pick_busiest()
unconditionally selects the given candidate @sg as busiest. With IPCC
scores, what is running a scheduling group becomes important. We now have
extra information to select either of the fully_busy groups. This is done
in patch 9.

(Also note that in [1] I tweak the logic to select fully_busy SMT cores vs
fully_busy non-SMT cores).

> 
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
> > index d773380a95b3..b6165aa8a376 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8901,6 +8901,8 @@ struct sg_lb_stats {
> >         unsigned long min_score; /* Min(score(rq->curr->ipcc)) */
> >         unsigned short min_ipcc; /* Class of the task with the minimum IPCC score in the rq */
> >         unsigned long sum_score; /* Sum(score(rq->curr->ipcc)) */
> > +       long ipcc_score_after; /* Prospective IPCC score after load balancing */
> > +       unsigned long ipcc_score_before; /* IPCC score before load balancing */
> >  #endif
> >  };
> >
> > @@ -9287,6 +9289,62 @@ static void update_sg_lb_ipcc_stats(int dst_cpu, struct sg_lb_stats *sgs,
> >         }
> >  }
> >
> > +static void update_sg_lb_stats_scores(struct sg_lb_stats *sgs,
> > +                                     struct sched_group *sg,
> > +                                     struct lb_env *env)
> > +{
> > +       unsigned long score_on_dst_cpu, before;
> > +       int busy_cpus;
> > +       long after;
> > +
> > +       if (!sched_ipcc_enabled())
> > +               return;
> > +
> > +       /*
> > +        * IPCC scores are only useful during idle load balancing. For now,
> > +        * only asym_packing uses IPCC scores.
> > +        */
> > +       if (!(env->sd->flags & SD_ASYM_PACKING) ||
> > +           env->idle == CPU_NOT_IDLE)
> > +               return;
> > +
> > +       /*
> > +        * IPCC scores are used to break ties only between these types of
> > +        * groups.
> > +        */
> > +       if (sgs->group_type != group_fully_busy &&
> > +           sgs->group_type != group_asym_packing)
> > +               return;
> > +
> > +       busy_cpus = sgs->group_weight - sgs->idle_cpus;
> > +
> > +       /* No busy CPUs in the group. No tasks to move. */
> > +       if (!busy_cpus)
> > +               return;
> > +
> > +       score_on_dst_cpu = arch_get_ipcc_score(sgs->min_ipcc, env->dst_cpu);
> > +
> > +       /*
> > +        * Do not use IPC scores. sgs::ipcc_score_{after, before} will be zero
> > +        * and not used.
> > +        */
> > +       if (IS_ERR_VALUE(score_on_dst_cpu))
> > +               return;
> > +
> > +       before = sgs->sum_score;
> > +       after = before - sgs->min_score;
> 
> IIUC, you assume that you will select the cpu with the min score.
> How do you ensure this ? otherwise all your comparisong are useless

This is relevant for SMT cores. A smaller idle core will help a fully_busy
SMT core by pulling low-IPC work, leaving the full core for high-IPC
work.

We ensure (or anticipate if you will) this because find_busiest_queue()
will select the queue whose current task gets the biggest IPC boost. When
done from big to small cores the IPC boost is negative.

> 
> > +
> > +       /* SMT siblings share throughput. */
> > +       if (busy_cpus > 1 && sg->flags & SD_SHARE_CPUCAPACITY) {
> > +               before /= busy_cpus;
> > +               /* One sibling will become idle after load balance. */
> > +               after /= busy_cpus - 1;
> > +       }
> > +
> > +       sgs->ipcc_score_after = after + score_on_dst_cpu;
> > +       sgs->ipcc_score_before = before;
> 
> I'm not sure to understand why you are computing the sum_score,
> ipcc_score_before and ipcc_score_after ?
> Why is it not sufficient to check if score_on_dst_cpu will be higher
> than current min_score ?

You are right. As the source core becomes idle after load balancing, it is
sufficient to look for the highest score_on_dst_cpu. However, we must also
handle SMT cores.

If the source sched group is a fully_busy SMT core, one of the siblings
will become idle after load balance (my patchset uses IPCC scores for
asym_packing and when balancing the number of idle CPUs from fully_busy).
The remaining non-idle siblings will benefit from the extra throughput.

We calculate ipcc_score_after to find the sched group that would benefit
the most. We calculate ipcc_score_before to break ties of two groups of
identical ipcc_score_after.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20230207045838.11243-6-ricardo.neri-calderon@linux.intel.com/
