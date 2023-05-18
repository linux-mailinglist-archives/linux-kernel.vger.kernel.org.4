Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D360F708B29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjERWCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjERWCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5F5E7
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684447289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OBIz8BPXt7G5B0IU4THBM/FvMX06qOOWNZyF8nh3G7I=;
        b=WpqDnNScReLzMbpeYXSyHF0Uttx7+T9z7ZC6p92ua8z0o5Xkfgr2WnUMWHhBJCoDhxJaAH
        PoJM5VBCfInubxpv+0dEFoKCjWh0+/I9PpYhwfVABFxXecKIdtJmDV7I0id4iw6E6RPzYS
        GF/tKyLFvf7HjiB25I9TC9j5VlnYhyM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-ExO7J6DTNfWoDQlKK9za4Q-1; Thu, 18 May 2023 18:01:25 -0400
X-MC-Unique: ExO7J6DTNfWoDQlKK9za4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0D8B1C05AFD;
        Thu, 18 May 2023 22:01:24 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7553A2026D16;
        Thu, 18 May 2023 22:01:24 +0000 (UTC)
Date:   Thu, 18 May 2023 18:01:22 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Benjamin Segall <bsegall@google.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH RESEND] sched/nohz: Add HRTICK_BW for using cfs bandwidth
 with nohz_full
Message-ID: <20230518220122.GB120739@lorien.usersys.redhat.com>
References: <20230518132038.3534728-1-pauld@redhat.com>
 <xm26353twcpr.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26353twcpr.fsf@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 02:29:04PM -0700 Benjamin Segall wrote:
> Phil Auld <pauld@redhat.com> writes:
> 
> > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> > can easily run well past their quotas before a remote tick does
> > accounting.  This leads to long, multi-period stalls before such
> > tasks can run again.  Use the hrtick mechanism to set a sched
> > tick to fire at remaining_runtime in the future if we are on
> > a nohz full cpu, if the task has quota and if we are likely to
> > disable the tick (nr_running == 1).  This allows for bandwidth
> > accounting before tasks go too far over quota.
> >
> > A number of container workloads use a dynamic number of real
> > nohz tasks but also have other work that is limited which ends
> > up running on the "spare" nohz cpus.  This is an artifact of
> > having to specify nohz_full cpus at boot. Adding this hrtick
> > resolves the issue of long stalls on these tasks.
> >
> > Add the sched_feat HRTICK_BW off by default to allow users to
> > enable this only when needed.
> >
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Suggested-by: Juri Lelli <jlelli@redhat.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Ben Segall <bsegall@google.com>
> > ---
> >
> > Resend with LKML address instead of rh list...
> >
> >  kernel/sched/core.c     |  2 +-
> >  kernel/sched/fair.c     | 20 ++++++++++++++++++++
> >  kernel/sched/features.h |  1 +
> >  kernel/sched/sched.h    | 12 ++++++++++++
> >  4 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a68d1276bab0..76425c377245 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6562,7 +6562,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
> >  
> >  	schedule_debug(prev, !!sched_mode);
> >  
> > -	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
> > +	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL) || sched_feat(HRTICK_BW))
> >  		hrtick_clear(rq);
> >  
> >  	local_irq_disable();
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 373ff5f55884..0dd1f6a874bc 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5309,6 +5309,22 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> >  	return ret;
> >  }
> >  
> > +#if defined(CONFIG_SCHED_HRTICK) && defined(CONFIG_NO_HZ_FULL)
> > +static void start_hrtick_cfs_bw(struct rq *rq, struct cfs_rq *cfs_rq)
> > +{
> > +	if (!tick_nohz_full_cpu(rq->cpu) || !cfs_bandwidth_used() || !cfs_rq->runtime_enabled)
> > +		return;
> > +
> > +	/* runtime_remaining should never be negative here but just in case */
> > +	if (rq->nr_running == 1 && cfs_rq->runtime_remaining > 0)
> > +		hrtick_start(rq, cfs_rq->runtime_remaining);
> > +}
> > +#else
> > +static void start_hrtick_cfs_bw(struct rq *rq, struct cfs_rq *cfs_rq)
> > +{
> > +}
> > +#endif
> > +
> >  static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
> >  {
> >  	/* dock delta_exec before expiring quota (as it could span periods) */
> > @@ -5481,6 +5497,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
> >  	 */
> >  	cfs_rq->throttled = 1;
> >  	cfs_rq->throttled_clock = rq_clock(rq);
> > +
> >  	return true;
> >  }
> >  
> > @@ -8096,6 +8113,9 @@ done: __maybe_unused;
> >  	if (hrtick_enabled_fair(rq))
> >  		hrtick_start_fair(rq, p);
> >  
> > +	if (hrtick_enabled_bw(rq))
> > +		start_hrtick_cfs_bw(rq, task_cfs_rq(p));
> > +
> >  	update_misfit_status(p, rq);
> 
> Implementation-wise this winds up with a tick of
> sysctl_sched_cfs_bandwidth_slice, which I suppose the admin could _also_
> configure depending on how much NOHZ benefit vs cfsb issues they want.
>

If the task is using all its bw then yes. Really though, by specifying
cfsb they are saying the nohz part is not that important it seems to me.

Short of doing the remote tick way more often you can't really
have both. The default setup favors nohz and lets the tasks run until
a remote tick gets them and then they are some ~5-10 periods in the hole.

I'm open to better solutions.

> It's not great that this implementation winds up going all the way
> through schedule() for each 5ms-default tick, though.
> 

Yeah. We initially had the start_hrtick in __account_cfs_runtime but that
was too late. It doesn't catch when we put the task on the cpu initially.
Now that you mention this I do think we need that as well so that we
get a new timer if the task gets more bandwidth and can stay on cpu.

Not stopping the tick looks better and better...

Thanks for taking a look.


Cheers,
Phil

-- 

