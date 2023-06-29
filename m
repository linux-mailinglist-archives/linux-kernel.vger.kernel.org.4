Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCF0741D67
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjF2Ayp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjF2Ayk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA12117
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 17:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688000030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xzZHhIzDDuackwUVlvpBeapF4XcO6szZYosiE5wGDwM=;
        b=ffA65hFWlXy8jb4hAAdwuZ3fTEOd/oy3mGOA0Ab/3ZAdfSTuksZyTWEwhynWKgRz3E8rDC
        PEdU5bySkjK9YSVyQHSO8IK0fsRUzz3ri82EqDafZywt0VY5fTasGrNYZdAediOiUyvMmZ
        16ddEUah0Ke4mxHrA152lxs/UYA4NOw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-1tWZ0C-HNQ6LNvr3pFuuIA-1; Wed, 28 Jun 2023 20:53:46 -0400
X-MC-Unique: 1tWZ0C-HNQ6LNvr3pFuuIA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BCDB2814250;
        Thu, 29 Jun 2023 00:53:45 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.17.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEC02F5CE4;
        Thu, 29 Jun 2023 00:53:44 +0000 (UTC)
Date:   Wed, 28 Jun 2023 20:53:42 -0400
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
Subject: Re: [PATCH v2] Sched/fair: Block nohz tick_stop when cfs bandwidth
 in use
Message-ID: <20230629005342.GB8069@lorien.usersys.redhat.com>
References: <20230627191201.344110-1-pauld@redhat.com>
 <xm26jzvn8ds7.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26jzvn8ds7.fsf@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 02:42:16PM -0700 Benjamin Segall wrote:
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
> >
> > v2:  Ben pointed out that the bit could get cleared in the dequeue path
> > if we migrate a newly enqueued task without preempting curr. Added a 
> > check for that edge case to sched_can_stop_tick. Removed the call to 
> > sched_can_stop_tick from sched_fair_update_stop_tick since it was 
> > redundant.
> >
> >  kernel/sched/core.c     | 12 +++++++++++
> >  kernel/sched/fair.c     | 45 +++++++++++++++++++++++++++++++++++++++++
> >  kernel/sched/features.h |  2 ++
> >  3 files changed, 59 insertions(+)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a68d1276bab0..646f60bfc7e7 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1194,6 +1194,8 @@ static void nohz_csd_func(void *info)
> >  #endif /* CONFIG_NO_HZ_COMMON */
> >  
> >  #ifdef CONFIG_NO_HZ_FULL
> > +extern bool sched_cfs_bandwidth_active(struct cfs_rq *cfs_rq);
> > +
> >  bool sched_can_stop_tick(struct rq *rq)
> >  {
> >  	int fifo_nr_running;
> > @@ -1229,6 +1231,16 @@ bool sched_can_stop_tick(struct rq *rq)
> >  	if (rq->nr_running > 1)
> >  		return false;
> >  
> > +	/*
> > +	 * If there is one task and it has CFS runtime bandwidth constraints
> > +	 * and it's on the cpu now we don't want to stop the tick.
> > +	 */
> > +	if (sched_feat(HZ_BW) && rq->nr_running == 1 && rq->curr
> > +	    && rq->curr->sched_class == &fair_sched_class && task_on_rq_queued(rq->curr)) {
> > +		if (sched_cfs_bandwidth_active(task_cfs_rq(rq->curr)))
> 
> Actually, something I should have noticed earlier is that this should
> probably be hierarchical, right? You need to check every ancestor
> cfs_rq, not just the immediate parent. And at that point it probably
> makes sense to have sched_cfs_bandwidth_active take a task_struct.
> 

Are you saying a child cfs_rq with a parent that has runtime_enabled could
itself not have runtime_enabled?   I may be missing something but I don't
see how that works.

account_cfs_rq_runtime() for example just looks at the immediate cfs_rq of
curr and bails if it does not have runtime_enabled. How could that task get
throttled if it exceeds some parent's limit?

Confused :)

Cheers,
Phil


-- 

