Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851D474FAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGKWXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKWXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1295310F1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689114149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PQ2+rDjcjMB3Qu7cGr9+SsEPr1twMRHj94h2nff+OLA=;
        b=NwwZaIFPu5qZmBi61QjgxGHB3REhXoDY/YfW53yK2Nz0WDDRVemqOAdqFMWThpGSlPzH92
        3yCBv4SIvdSa3f4Z8M8lIBkDo43itsWEK/rEs8gstnhkEdwpEfoqpP3R32oudcVrlfAArl
        +obU3787Xj2aSvpwMr6c4k1HZYU1ScU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-h2BfI1zsPrWm3d_MtO_K-w-1; Tue, 11 Jul 2023 18:22:24 -0400
X-MC-Unique: h2BfI1zsPrWm3d_MtO_K-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32F173C100A1;
        Tue, 11 Jul 2023 22:22:24 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.17.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7508B200AD6E;
        Tue, 11 Jul 2023 22:22:23 +0000 (UTC)
Date:   Tue, 11 Jul 2023 18:22:21 -0400
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
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 2/2] Sched/fair: Block nohz tick_stop when cfs
 bandwidth in use
Message-ID: <20230711222221.GD150804@lorien.usersys.redhat.com>
References: <20230707195748.2918490-1-pauld@redhat.com>
 <20230707195748.2918490-3-pauld@redhat.com>
 <xm26lefnfhkd.fsf@google.com>
 <20230711131024.GA150804@lorien.usersys.redhat.com>
 <20230711141210.GC150804@lorien.usersys.redhat.com>
 <xm26cz0yf6gf.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26cz0yf6gf.fsf@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:07:12PM -0700 Benjamin Segall wrote:
> Phil Auld <pauld@redhat.com> writes:
> 
> > On Tue, Jul 11, 2023 at 09:10:24AM -0400 Phil Auld wrote:
> >> On Mon, Jul 10, 2023 at 04:54:58PM -0700 Benjamin Segall wrote:
> >> > Phil Auld <pauld@redhat.com> writes:
> >> > 
> >> > > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> >> > > can easily run well past their quotas before a remote tick does
> >> > > accounting.  This leads to long, multi-period stalls before such
> >> > > tasks can run again. Currently, when presented with these conflicting
> >> > > requirements the scheduler is favoring nohz_full and letting the tick
> >> > > be stopped. However, nohz tick stopping is already best-effort, there
> >> > > are a number of conditions that can prevent it, whereas cfs runtime
> >> > > bandwidth is expected to be enforced.
> >> > >
> >> > > Make the scheduler favor bandwidth over stopping the tick by setting
> >> > > TICK_DEP_BIT_SCHED when the only running task is a cfs task with
> >> > > runtime limit enabled. We use cfs_b->hierarchical_quota to
> >> > > determine if the task requires the tick.
> >> > >
> >> > > Add check in pick_next_task_fair() as well since that is where
> >> > > we have a handle on the task that is actually going to be running.
> >> > >
> >> > > Add check in sched_can_stop_tick() to cover some edge cases such 
> >> > > as nr_running going from 2->1 and the 1 remains the running task.
> >> > >
> >> > > Add sched_feat HZ_BW (off by default) to control the tick_stop
> >> > > behavior.
> >> > >
> >> > > Signed-off-by: Phil Auld <pauld@redhat.com>
> >> > > Cc: Ingo Molnar <mingo@redhat.com>
> >> > > Cc: Peter Zijlstra <peterz@infradead.org>
> >> > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >> > > Cc: Juri Lelli <juri.lelli@redhat.com>
> >> > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> > > Cc: Valentin Schneider <vschneid@redhat.com>
> >> > > Cc: Ben Segall <bsegall@google.com>
> >> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> >> > > ---
> >> > >  kernel/sched/core.c     | 12 ++++++++++
> >> > >  kernel/sched/fair.c     | 49 +++++++++++++++++++++++++++++++++++++++++
> >> > >  kernel/sched/features.h |  2 ++
> >> > >  kernel/sched/sched.h    |  1 +
> >> > >  4 files changed, 64 insertions(+)
> >> > >
> >> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> > > index 1b214e10c25d..4b8534abdf4f 100644
> >> > > --- a/kernel/sched/core.c
> >> > > +++ b/kernel/sched/core.c
> >> > > @@ -1229,6 +1229,18 @@ bool sched_can_stop_tick(struct rq *rq)
> >> > >  	if (rq->nr_running > 1)
> >> > >  		return false;
> >> > >  
> >> > > +	/*
> >> > > +	 * If there is one task and it has CFS runtime bandwidth constraints
> >> > > +	 * and it's on the cpu now we don't want to stop the tick.
> >> > > +	 * This check prevents clearing the bit if a newly enqueued task here is
> >> > > +	 * dequeued by migrating while the constrained task continues to run.
> >> > > +	 * E.g. going from 2->1 without going through pick_next_task().
> >> > > +	 */
> >> > > +	if (sched_feat(HZ_BW) && rq->nr_running == 1 && task_on_rq_queued(rq->curr)) {
> >> > > +		if (cfs_task_bw_constrained(rq->curr))
> >> > > +			return false;
> >> > > +	}
> >> > > +
> >> > 
> >> > I think we still need the fair_sched_class check with the bit being on
> >> > cfs_rq/tg rather than task.
> >> > 
> >> 
> >> Is there a way a non-fair_sched_class task will be in a cfs_rq with
> >> cfs_rq->runtime_enabled and/or cfs_b->hierarchical_quota set to non
> >> RUNTIME_INF?  I suppose if they are stale and it's had its class changed?
> >> 
> >> That makes the condition pretty ugly but I can add that back if needed.
> >> 
> >
> > Sigh, yeah. I took that out when I had the bit in the task. I'll put it
> > back in...
> >
> 
> Yeah, cfs_rq (and rt_rq) are set unconditionally, and a cgroup can have
> a mix of fair and RT tasks (whether or not that's a good idea from a
> sysadmin perspective).
> 

Thanks. I think I'll try the condition as a single-use static inline function.
The generated code seems the same but it is a bit nicer to read.


Cheers,
Phil


-- 

