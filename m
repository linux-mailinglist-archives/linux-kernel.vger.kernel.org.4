Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48735691651
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBJBmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjBJBmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:42:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254BD5EF8B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 17:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675993357; x=1707529357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0vWdaRA3I6pRFfk58mBMWBVnNs42iOinDcDzB200ag4=;
  b=MKHbVJZnrZJd4IoIkM4Qno09IdW3teDdnezDZC5n4hAjKprHGAgbVSCp
   VnTLuatr9MOjh4t1Nh7uUR6RqVH1gcQYZf2vSPmgTu9VFeKoWO03sX2z2
   nFB1Kw4j8I3c7yxWAaOO8FOxLKHgOWfIB2+41sBxBX5MJoEKQTlNio553
   IoDr0QuUjgsjBCZptW55oY3N8ZDxwEs9yvhDOCpqC732Dq8Yi+TGrhjWR
   ZoPeXqutKIsDlT1WJjmXRSBzd8FZXMiFFtz8YIFYK7Xc7gt5uSWUlK/Sb
   xzQLiek849PKKlpgm8VVoAk8xfPEr4tLEtrqQmu01VZMGXlR6Q7T3umO/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="392706243"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="392706243"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 17:42:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="791805779"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="791805779"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 09 Feb 2023 17:42:35 -0800
Date:   Thu, 9 Feb 2023 17:52:18 -0800
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 04/10] sched/fair: Let low-priority cores help
 high-priority busy SMT cores
Message-ID: <20230210015218.GB6166@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtB_YR8e6fcx3Un0vTeJR4EJS9sOXG=wLb8rZeM5Ub4yyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB_YR8e6fcx3Un0vTeJR4EJS9sOXG=wLb8rZeM5Ub4yyA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 08:56:32AM +0100, Vincent Guittot wrote:
> On Tue, 7 Feb 2023 at 05:50, Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > Using asym_packing priorities within an SMT core is straightforward. Just
> > follow the priorities that hardware indicates.
> >
> > When balancing load from an SMT core, also consider the idle of its
> > siblings. Priorities do not reflect that an SMT core divides its throughput
> > among all its busy siblings. They only makes sense when exactly one sibling
> > is busy.
> >
> > Indicate that active balance is needed if the destination CPU has lower
> > priority than the source CPU but the latter has busy SMT siblings.
> >
> > Make find_busiest_queue() not skip higher-priority SMT cores with more than
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
> >  * Introduced this patch.
> >
> > Changes since v1:
> >  * N/A
> > ---
> >  kernel/sched/fair.c | 31 ++++++++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 80c86462c6f6..c9d0ddfd11f2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10436,11 +10436,20 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> >                     nr_running == 1)
> >                         continue;
> >
> > -               /* Make sure we only pull tasks from a CPU of lower priority */
> > +               /*
> > +                * Make sure we only pull tasks from a CPU of lower priority
> > +                * when balancing between SMT siblings.
> > +                *
> > +                * If balancing between cores, let lower priority CPUs help
> > +                * SMT cores with more than one busy sibling.
> > +                */
> >                 if ((env->sd->flags & SD_ASYM_PACKING) &&
> >                     sched_asym_prefer(i, env->dst_cpu) &&
> > -                   nr_running == 1)
> > -                       continue;
> > +                   nr_running == 1) {
> > +                       if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> > +                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && is_core_idle(i)))
> 
> This 2nd if could be merged with the upper one
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10518,11 +10518,10 @@ static struct rq *find_busiest_queue(struct
> lb_env *env,
>                  */
>                 if ((env->sd->flags & SD_ASYM_PACKING) &&
>                     sched_asym_prefer(i, env->dst_cpu) &&
> -                   nr_running == 1) {
> -                       if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> -                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY)
> && is_core_idle(i)))
> +                   (nr_running == 1) &&
> +                   (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> +                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY)
> && is_core_idle(i))))
>                                 continue;
> -               }
> 
>                 switch (env->migration_type) {
>                 case migrate_load:
> ---
> 
> AFAICT, you can even remove one env->sd->flags & SD_SHARE_CPUCAPACITY
> test with the below but this make the condition far less obvious
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a6021af9de11..7dfa30c45327 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10518,11 +10518,10 @@ static struct rq *find_busiest_queue(struct
> lb_env *env,
>                  */
>                 if ((env->sd->flags & SD_ASYM_PACKING) &&
>                     sched_asym_prefer(i, env->dst_cpu) &&
> -                   nr_running == 1) {
> -                       if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> -                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY)
> && is_core_idle(i)))
> +                   (nr_running == 1) &&
> +                   !(!(env->sd->flags & SD_SHARE_CPUCAPACITY) &&
> +                       !is_core_idle(i)))
>                                 continue;

I agree. This expression is equivalent to what I proposed. It is less
obvious but the comment above clarifies what is going on. I will take
your suggestion.

Thanks and BR,
Ricardo
