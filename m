Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E3272807D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbjFHMw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFHMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871841734
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686228725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nc69llfZUQz+ezBpy5QzWJtvxMBTU5VVaWISrSoWrGo=;
        b=KTyGO8R6Ct7dttF2QZPKWLCdkFZLorsp5bcNafpsLEg7wKO7S/JkwVs8yuzE0V3JZK4dPz
        c6jgH/3Bhbc8ELSexg8bOj915dCIuLC5gxdH2sooS+BAnNbiPIjEXRHb/k22bZLZaY8awh
        S3ZtYB0qFZnOKIganK6cB+DQoGkw9ao=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-0yV8UM02P7adtlCfRRTERA-1; Thu, 08 Jun 2023 08:52:02 -0400
X-MC-Unique: 0yV8UM02P7adtlCfRRTERA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8366B3C01E1F;
        Thu,  8 Jun 2023 12:52:01 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.194.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5435C1603B;
        Thu,  8 Jun 2023 12:51:57 +0000 (UTC)
Date:   Thu, 8 Jun 2023 08:51:54 -0400
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
Message-ID: <20230608125154.GA441613@lorien.usersys.redhat.com>
References: <20230518132038.3534728-1-pauld@redhat.com>
 <xm26353twcpr.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26353twcpr.fsf@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

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
> It's not great that this implementation winds up going all the way
> through schedule() for each 5ms-default tick, though.O

I'll post my v2 shorly which adds a check to start the timer in
the account_cfs_runtime() path when more runtime is allocated. This
keeps the task running.

Since it takes a bit of time from the timer firing to acounting the
task gets throttled each time. This ends up with a really short
timer followed by a ~5ms one and repeating, due to the unthrottle code
giving a runtime of 1.

I have a different approach which I think may be better, which is to
prevent the tick_stop with a sched dependency when we have a single
bw limited task.  But I wanted to see what people think of this first
approach now that it is fixed.


Thanks for taking a look.


Cheers,
Phil


-- 

