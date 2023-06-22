Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4873ABAF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjFVViV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFVViS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656091FEF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687469854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ac6TALMjp+oI3nV9xAMyrOCGIlDYL7HgOvl9g+nuZj4=;
        b=gxaVPgI+YkbtezhJ7GkaCXPIYeTdo21gX48z/L7H77+J80rkKoL0nS2oMDLLp3pdgGi6tZ
        NUAC5cyiOmpkNc73NLkQxOVS0TnbSk/MNNXWiwqxf66rCnb7wQsP/llozdq759JuKCeDTn
        coDA97kX02Q9trH+HBnLPin3DHvSTFE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-mfON8RQlPb-ZwavZaOn7VQ-1; Thu, 22 Jun 2023 17:37:33 -0400
X-MC-Unique: mfON8RQlPb-ZwavZaOn7VQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B602E2834760;
        Thu, 22 Jun 2023 21:37:32 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E5ED492C13;
        Thu, 22 Jun 2023 21:37:32 +0000 (UTC)
Date:   Thu, 22 Jun 2023 17:37:30 -0400
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
Subject: Re: [PATCH] Sched/fair: Block nohz tick_stop when cfs bandwidth in
 use
Message-ID: <20230622213730.GE727646@lorien.usersys.redhat.com>
References: <20230622132751.2900081-1-pauld@redhat.com>
 <xm26zg4r8bnz.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26zg4r8bnz.fsf@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 01:49:52PM -0700 Benjamin Segall wrote:
> Phil Auld <pauld@redhat.com> writes:
> 
> > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> > can easily run well past their quotas before a remote tick does
> > accounting.  This leads to long, multi-period stalls before such
> > tasks can run again. Currentlyi, when presented with these conflicting
> > requirements the scheduler is favoring nohz_full and letting the tick
> > be stopped. However, nohz tick stopping is already best-effort, there
> > are a number of conditions that can prevent it, whereas cfs runtime
> > bandwidth is expected to be enforced.
> >
> > Make the scheduler favor bandwidth over stopping the tick by setting
> > TICK_DEP_BIT_SCHED when the only running task is a cfs task with
> > runtime limit enabled.
> >
> > Add sched_feat HZ_BW (off by default) to control this behavior.
> >
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Ben Segall <bsegall@google.com>
> > ---
> >  kernel/sched/fair.c     | 33 ++++++++++++++++++++++++++++++++-
> >  kernel/sched/features.h |  2 ++
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 373ff5f55884..880eadfac330 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6139,6 +6139,33 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
> >  	rcu_read_unlock();
> >  }
> >  
> > +#ifdef CONFIG_NO_HZ_FULL
> > +/* called from pick_next_task_fair() */
> > +static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
> > +{
> > +	struct cfs_rq *cfs_rq = task_cfs_rq(p);
> > +	int cpu = cpu_of(rq);
> > +
> > +	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
> > +		return;
> > +
> > +	if (!tick_nohz_full_cpu(cpu))
> > +		return;
> > +
> > +	if (rq->nr_running != 1 || !sched_can_stop_tick(rq))
> > +		return;
> > +
> > +	/*
> > +	 *  We know there is only one task runnable and we've just picked it. The
> > +	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
> > +	 *  be otherwise able to stop the tick. Just need to check if we are using
> > +	 *  bandwidth control.
> > +	 */
> > +	if (cfs_rq->runtime_enabled)
> > +		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
> > +}
> > +#endif
> 
> So from a CFS_BANDWIDTH pov runtime_enabled && nr_running == 1 seems
> fine. But working around sched_can_stop_tick instead of with it seems
> sketchy in general, and in an edge case like "migrate a task onto the
> cpu and then off again" you'd get sched_update_tick_dependency resetting
> the TICK_DEP_BIT and then not call PNT (ie a task wakes up onto this cpu
> without preempting, and then another cpu goes idle and pulls it, causing
> this cpu to go into nohz_full).
> 

The information to make these tests is not available in sched_can_stop_tick.
I did start there. When that is called, and we are likely to go nohz_full,
curr is null so it's hard to find the right cfs_rq to make that
runtime_enabled test against.  We could, maybe, plumb the task being enqueued
in but it would not be valid for the dequeue path and would be a bit messy.

But yes, I suppose you could end up in a state that is just as bad as today.

Maybe I could add a redundant check in sched_can_stop_tick for when
nr_running == 1 and curr is not null and make sure the bit does not get
cleared. I'll look into that.


Thanks,
Phil

-- 

