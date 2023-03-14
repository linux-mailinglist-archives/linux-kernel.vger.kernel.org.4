Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3916BA3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjCNXoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjCNXoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:44:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE1B75E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678837441; x=1710373441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MBgoGSf4sE91ML1xNyQ6/AuGFsnKIeAmJxt14t1QRyY=;
  b=T2ub/6PitNLEQCtZMKUMZAV/wU7N5CZvrp5rlDnlEgGvUEBWY0cqSrEy
   Qmqa3xYgQzPz0A2Ix4bBoEURT2KIfmraf9oKj0k+z8xNgyVj+a5P5KDKQ
   x57fT9HFD4a0l8DSQ9gOeVmZ8DeQXQYqIpB+bDjs3DFDaPw7Tr6Zlrzv2
   pbwei+oXf89ATSIhW9RwpAVYaYWEGo5OOUeRYtDAXJRBC2nUFhOlQK0ve
   ryt7r/1646v8hIbTiQnzdDuXomx4KKReFYpBU6wscq8+Iww0ljetsY5eC
   mI9JaeRKhgHqARyD7OwowyDZ9axY3+It5x37bb6AZPtre3F/zTiJ17eAu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="336259078"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="336259078"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 16:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="672528045"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="672528045"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 14 Mar 2023 16:43:53 -0700
Date:   Tue, 14 Mar 2023 16:54:03 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
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
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 04/10] sched/fair: Let low-priority cores help
 high-priority busy SMT cores
Message-ID: <20230314235403.GB30287@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
 <9f3688d2d44ae766069487858bd28b5d49c19575.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f3688d2d44ae766069487858bd28b5d49c19575.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 04:51:35PM -0800, Tim Chen wrote:
> On Mon, 2023-02-06 at 20:58 -0800, Ricardo Neri wrote:
> > Using asym_packing priorities within an SMT core is straightforward.
> > Just
> > follow the priorities that hardware indicates.
> > 
> > When balancing load from an SMT core, also consider the idle of its
> > siblings. Priorities do not reflect that an SMT core divides its
> > throughput
> > among all its busy siblings. They only makes sense when exactly one
> > sibling
> > is busy.
> > 
> > Indicate that active balance is needed if the destination CPU has
> > lower
> > priority than the source CPU but the latter has busy SMT siblings.
> > 
> > Make find_busiest_queue() not skip higher-priority SMT cores with
> > more than
> > busy sibling.
> > 
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Suggested-by: Valentin Schneider <vschneid@redhat.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v2:
> >  * Introduced this patch.
> > 
> > Changes since v1:
> >  * N/A
> > ---
> >  kernel/sched/fair.c | 31 ++++++++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 80c86462c6f6..c9d0ddfd11f2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10436,11 +10436,20 @@ static struct rq *find_busiest_queue(struct
> > lb_env *env,
> >                     nr_running == 1)
> >                         continue;
> >  
> > -               /* Make sure we only pull tasks from a CPU of lower
> > priority */
> > +               /*
> > +                * Make sure we only pull tasks from a CPU of lower
> > priority
> > +                * when balancing between SMT siblings.
> > +                *
> > +                * If balancing between cores, let lower priority
> > CPUs help
> > +                * SMT cores with more than one busy sibling.
> > +                */
> >                 if ((env->sd->flags & SD_ASYM_PACKING) &&
> >                     sched_asym_prefer(i, env->dst_cpu) &&
> > -                   nr_running == 1)
> > -                       continue;
> > +                   nr_running == 1) {
> > +                       if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> > +                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY)
> > && is_core_idle(i)))
> > +                               continue;
> > +               }
> >  
> >                 switch (env->migration_type) {
> >                 case migrate_load:
> > @@ -10530,8 +10539,20 @@ asym_active_balance(struct lb_env *env)
> >          * lower priority CPUs in order to pack all tasks in the
> >          * highest priority CPUs.
> >          */
> > -       return env->idle != CPU_NOT_IDLE && (env->sd->flags &
> > SD_ASYM_PACKING) &&
> > -              sched_asym_prefer(env->dst_cpu, env->src_cpu);
> > +       if (env->idle != CPU_NOT_IDLE && (env->sd->flags &
> > SD_ASYM_PACKING)) {
> > +               /* Always obey priorities between SMT siblings. */
> > +               if (env->sd->flags & SD_SHARE_CPUCAPACITY)
> > +                       return sched_asym_prefer(env->dst_cpu, env-
> > >src_cpu);
> > +
> > +               /*
> > +                * A lower priority CPU can help an SMT core with
> > more than one
> > +                * busy sibling.
> > +                */
> > +               return sched_asym_prefer(env->dst_cpu, env->src_cpu)
> > ||
> > +                      !is_core_idle(env->src_cpu);
> > +       }
> 
> Suppose we have the Atom cores in a sched group (e.g. a cluster),
> this will pull the tasks from those core to a SMT thread even if
> its sibling thread is busy.  Suggest this change
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da1afa99cd55..b671cb0d7ab3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10473,9 +10473,11 @@ asym_active_balance(struct lb_env *env)
>                 /*
>                  * A lower priority CPU can help an SMT core with more than one
>                  * busy sibling.
> +                * Pull only if no SMT sibling busy.
>                  */
> -               return sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
> -                      !is_core_idle(env->src_cpu);
> +               if (is_core_idle(env->dst_cpu))
> +                       return sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
> +                              !is_core_idle(env->src_cpu);

Thank you Tim! Patch 3 does this check for asym_packing, but we could land
from other types of idle load balancing.

I wil integrate this change to the series.

Thanks and BR,
Ricardo
