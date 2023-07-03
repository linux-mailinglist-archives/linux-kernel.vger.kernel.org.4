Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B00B745FC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjGCPZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjGCPZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0D5E62
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688397895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFg0SW/Ml+QzpZbtGhGaAsAD9yjqCyWD3c3Go1nt0PM=;
        b=QEh6sv+U3Y0vsHFFkXj5PJr/iTUqa9wSydwjQEG8pH55drMGO3JmYlyVzzOBEaD+8oMXO/
        ncZqAcIss8KHu0Gsf4oz/id+hM+efd+caUtvOZmuk4BlHyDfSlqC3oiM+YCq8WSBNXntmu
        HdgPtcNXfc8y6iLB42A44NzwgSprBoY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-29YVQJo1MLm4wvNiQIdEQg-1; Mon, 03 Jul 2023 11:24:49 -0400
X-MC-Unique: 29YVQJo1MLm4wvNiQIdEQg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DE73185A78B;
        Mon,  3 Jul 2023 15:24:48 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.194.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57266492B01;
        Mon,  3 Jul 2023 15:24:44 +0000 (UTC)
Date:   Mon, 3 Jul 2023 11:24:40 -0400
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
Message-ID: <20230703152440.GC67396@lorien.usersys.redhat.com>
References: <20230630135714.1018434-1-pauld@redhat.com>
 <20230630150641.GH2533791@hirez.programming.kicks-ass.net>
 <20230630152824.GC43299@lorien.usersys.redhat.com>
 <20230630160534.GA2534344@hirez.programming.kicks-ass.net>
 <20230630162910.GD43299@lorien.usersys.redhat.com>
 <20230703121009.GH4253@hirez.programming.kicks-ass.net>
 <20230703141056.GA67396@lorien.usersys.redhat.com>
 <20230703143257.GY83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703143257.GY83892@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 04:32:57PM +0200 Peter Zijlstra wrote:
> On Mon, Jul 03, 2023 at 10:10:56AM -0400, Phil Auld wrote:
> > On Mon, Jul 03, 2023 at 02:10:09PM +0200 Peter Zijlstra wrote:
> > > On Fri, Jun 30, 2023 at 12:29:10PM -0400, Phil Auld wrote:
> > > 
> > > > I think you are agreeing that I need the pick next code but need to remove
> > > > the hierarchy walks, right?
> > > 
> > > Yeah, the dequeue case makes we have to care about pick, not sure we
> > > then also need to care about sched_update_tick_dependency() though.
> > > There is indeed a window where these two will 'race', but afaict it is
> > > benign.
> > > 
> > 
> > Hm, that's confusing.
> > 
> > As I see it it's the enqueue case (0->1 mostly) where we need the check
> > in pick.  At that point in enqueue we only have a handle on ->curr which
> > is the idle thread.
> 
> Well, the 0->1 case is trivial, we'll run the task that's enqueued, and
> as such everything can DTRT and be simple.
>

Right, but we have to do it (check for bw_constraint and set the TICK_DEP bit)
in pick because we don't have a handle on the task that's enqueued in
sched_update_tick_dependency(). Simple :)

> > For the dequeue case (2->1) we need the check in the
> > sched_update_tick_dependency() path because if the 1 is the task on the
> > cpu (and is staying there) then we'd otherwise clear the bit when we
> > shouldn't (since we aren't going to go back through pick).
> 
> The 2->1 case OTOH is tricky, because then we'll end up running a task
> we've not recently seen. sub_nr_running() will hit the ==1 case and
> clear TICK_DEP_BIT_SCHED.
> 
> But then pick will come and set it again, no harm done, right?
> 
> .oO Ah!, You're worried about the case where a task is already running,
> a second task comes in, (1->2) and then quickly leaves again (2->1)
> without passing through schedule(). And you don't want to disable the
> tick if that running task needs it.
> 
> Mooo :-(
>

Yeah, Ben pointed that out and then I was able to rt-app a way to hit it
reliably.

> > I'm thinking that I'll try to set the bit in pick since we only care about
> > it when it's the task on the cpu.  That, I think, will simplify the
> > code needed to update the bit when the quota is changed (to or from
> > RUNTIME_INF).
> > 
> > Setting the bit in enqueue/dequeue means updating it on all the queued
> > task if it changes. Although I may clear it in dequeue just to not leave
> > it around stale.
> 
> Hmm, no you have to set on enqueue (1->2), otherwise the running task
> doesn't get preempted when it runs out of slice.

Sorry, I'm not sure I'm following. I meant the bw_constrained bit in the
task not the actual TICK_DEP bit. 

So in this case we don't go through pick because we may be preempting
from say a wakeup? If we stay at 2 none of this matters because
the existing tick_dependency stuff will work (nr_running > 1)

That's why I wanted to clarify which bit I was talking about where.

Ah... If we go from 1->2 via a wakeup and preempt rather than pick_next
then the task would not get the bw_constrained bit set if we
then drop from 2->1.  Right, okay. Will need to set it in enqueue
and update all queued tasks if bandwidth changes. Or also update it
in pick, maybe. I.e. make sure task::bw_constrained is still right when
we actually land on the cpu because the only place we really care about
it is when we are ->curr.

> 
> And I don't suppose you want to delay clearing to the first tick after,
> because NOHZ_FULL doesn't want spurious ticks :/

Here you mean clearing the TICK_DEP yes?

>
> What a mess.
> 
> Please document all these stupid cases in a comment, otherwise we'll go
> bananas trying to make sense of the code later on.
> 

Will do. 

Thanks for your input.


Cheers,
Phil


-- 

