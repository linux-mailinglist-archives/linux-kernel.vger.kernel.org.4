Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BED743EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjF3PcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjF3Pbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A942449F8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uF9XydFTEoRStyeXxlW9KZB1BG0toGAk1St1nW9MPdM=;
        b=d7MKPslPpf/jt2Ukz6drLQuDkTqoRNZLHFAcSsgw3RdGc00+5iNH4HCJ8TuHmHHkmdl99G
        ovg2dF0bNXgS+gd1tRgTZCRSw/eUwoZDISV0ca971i31wl4PtSCGvGSWBNplN+U9u44pdG
        VvmhgYv3GfalkPq9EcaFEoBQh44k9Xc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-_tNpv5MwOcue8ZqbwpOg_Q-1; Fri, 30 Jun 2023 11:28:30 -0400
X-MC-Unique: _tNpv5MwOcue8ZqbwpOg_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D6F338117FD;
        Fri, 30 Jun 2023 15:28:27 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC9321121314;
        Fri, 30 Jun 2023 15:28:26 +0000 (UTC)
Date:   Fri, 30 Jun 2023 11:28:24 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4] Sched/fair: Block nohz tick_stop when cfs bandwidth
 in use
Message-ID: <20230630152824.GC43299@lorien.usersys.redhat.com>
References: <20230630135714.1018434-1-pauld@redhat.com>
 <20230630150641.GH2533791@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630150641.GH2533791@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Jun 30, 2023 at 05:06:41PM +0200 Peter Zijlstra wrote:
> On Fri, Jun 30, 2023 at 09:57:14AM -0400, Phil Auld wrote:
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a68d1276bab0..2685373e12f1 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1229,6 +1229,16 @@ bool sched_can_stop_tick(struct rq *rq)
> >  	if (rq->nr_running > 1)
> >  		return false;
> >  
> > +	/*
> > +	 * If there is one task and it has CFS runtime bandwidth constraints
> > +	 * and it's on the cpu now we don't want to stop the tick.
> > +	 */
> > +	if (sched_feat(HZ_BW) && rq->nr_running == 1 && rq->curr
> > +	    && rq->curr->sched_class == &fair_sched_class && task_on_rq_queued(rq->curr)) {
> 
> && goes at the end of the previous line
> 
> rq->curr is never NULL
> 
> But surely you can find a saner way to write this?
>

Okay, I'll try to clean that up.


> > +		if (sched_cfs_bandwidth_active(rq->curr))
> > +			return false;
> > +	}
> > +
> >  	return true;
> >  }
> >  #endif /* CONFIG_NO_HZ_FULL */
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 373ff5f55884..125b1ec4476f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6139,6 +6139,50 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
> >  	rcu_read_unlock();
> >  }
> >  
> > +#ifdef CONFIG_NO_HZ_FULL
> > +static inline bool cfs_se_bandwidth_enabled(struct sched_entity *se)
> > +{
> > +	int ret = 0;
> > +
> > +	for_each_sched_entity(se)
> > +		ret += cfs_rq_of(se)->runtime_enabled;
> > +
> > +	return ret != 0;
> > +}
> > +
> > +bool sched_cfs_bandwidth_active(struct task_struct *p)
> > +{
> > +	if (cfs_bandwidth_used() && cfs_se_bandwidth_enabled(&p->se))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +/* called from pick_next_task_fair() */
> > +static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
> > +{
> > +	int cpu = cpu_of(rq);
> > +
> > +	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
> > +		return;
> > +
> > +	if (!tick_nohz_full_cpu(cpu))
> > +		return;
> > +
> > +	if (rq->nr_running != 1)
> > +		return;
> > +
> > +	/*
> > +	 *  We know there is only one task runnable and we've just picked it. The
> > +	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
> > +	 *  be otherwise able to stop the tick. Just need to check if we are using
> > +	 *  bandwidth control.
> > +	 */
> > +	if (cfs_se_bandwidth_enabled(&p->se))
> > +		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
> > +}
> 
> Yeah, I think not; pick_next_task_fair() just walked the cgroup
> hierarchy and now you do it again.
> 
> Also, why does this code exist at all? Both enqueue/dequeue already end
> up in sched_update_tick_depenency() and should be able to handle the
> nr_running==1 with bandwidth crap, no?
> 

No. Or at least not without plumbing the enqueued/dequeued task all the way
through.  I can do it that way if you prefer but that seemed a lot more
intrusive. When we are in sched_can_stop_tick() we don't have access to the
cfs task which will end up running. Curr is idle in that case.  We'd have to
essential run pick_next_task_fair() to find the task to check which seemed
wrong. Maybe there is a better way? 

The code in sched_can_stop_tick() was added to catch the edge case
of waking a second task and having it migrated before it runs so we don't
clear the dependency of the running bandwidth enabled task by the dequeue
of the transient waking task.


Thanks for taking a look. This is better than "OMG" :)


Cheers,
Phil

-- 

