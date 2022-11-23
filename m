Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098666365C8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiKWQ1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239077AbiKWQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:27:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FB7199
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+MO230V2uSEAZN82Bjjz0xKGbZ01cjeSXSNQ7xc90/8=; b=gKQE79TZU/7BTRiEAqpH7Fn4MH
        6hCFhmVpXcAcQRziHoLP32PXM7mKG7BwsU4a1FguLkA2QJYKpuWIEDK1px43otKbKNAavoY7GcKDw
        u/h8F20VsbwreeiVuSEmGbsQ+/XlvJyp+e+5eSCYvMr2Pq2/kjzHPL01AZTvz/NVvvjZPMVFijAuG
        0l74iTMD2Yz9qhARJibwno38N97zjJdu7msczWXkyq3RdoI5nh2ltfb7C6rHIyVuJWRMjMqLF5zCQ
        af8NW8hRkk+qGUkUb5vXlFdlHNgo5rRUTh2WcrtmzcdZwTVwf9XwSuRGx2eGv0UFl7eO5Y6g/V+7c
        Nlj+UeyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxsap-007oGF-UT; Wed, 23 Nov 2022 16:27:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E0E1300322;
        Wed, 23 Nov 2022 17:27:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BE2F2011C62B; Wed, 23 Nov 2022 17:27:16 +0100 (CET)
Date:   Wed, 23 Nov 2022 17:27:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in task_work_run (2)
Message-ID: <Y35J4383T5rAjSjO@hirez.programming.kicks-ass.net>
References: <000000000000e7513905ebf4346f@google.com>
 <20221027030304.3017-1-hdanton@sina.com>
 <CANpmjNM-FNsMn4FR2murHHKt6jsVUDCO=ETmNQe-f+jrQ+4nHg@mail.gmail.com>
 <Y340Y2iwy3YubOk1@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y340Y2iwy3YubOk1@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 03:55:31PM +0100, Marco Elver wrote:

> > > --- x/kernel/events/core.c
> > > +++ c/kernel/events/core.c
> > > @@ -2291,6 +2291,7 @@ event_sched_out(struct perf_event *event
> > >                     !event->pending_work) {
> > >                         event->pending_work = 1;
> > >                         dec = false;
> > > +                       atomic_long_inc(&event->refcount);
> > >                         task_work_add(current, &event->pending_task, TWA_RESUME);
> > >                 }
> > >                 if (dec)
> > > @@ -6561,6 +6562,8 @@ static void perf_pending_task(struct cal
> > >         struct perf_event *event = container_of(head, struct perf_event, pending_task);
> > >         int rctx;
> > >
> > > +       if (event->state == PERF_EVENT_STATE_DEAD)
> > > +               goto out;
> > >         /*
> > >          * If we 'fail' here, that's OK, it means recursion is already disabled
> > >          * and we won't recurse 'further'.
> > > @@ -6577,6 +6580,8 @@ static void perf_pending_task(struct cal
> > >         if (rctx >= 0)
> > >                 perf_swevent_put_recursion_context(rctx);
> > >         preempt_enable_notrace();
> > > +out:
> > > +       put_event(event);
> > >  }
> > >
> > >  #ifdef CONFIG_GUEST_PERF_EVENTS

This is broken and will corrupt ctx->nr_pending.


> My guess is that the __fput task work is in the same task as the perf
> task work, and so if we tried to cancel the task work from within
> __fput, it won't actually cancel it if task_work_run() already exchanged
> the 'task_works' list.

That seems very likely indeed.

> So it looks like prolonging the perf events lifetime is the only option
> right now?

Depends a bit on how complicated all this is; at the very least
perf_event_release_kernel() will schedule out the event if it still
running. It does this before switching the state to DEAD (it has to)
which means it can raise perf_pending_task() at this point in time, even
though we're tearing down the event.

This can be avoided by a patch like this...

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9ab0eb073bd5..e9ad1ff7a9f8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2287,6 +2287,7 @@ group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
 
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
+#define DETACH_DEAD	0x04UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2308,12 +2309,20 @@ __perf_remove_from_context(struct perf_event *event,
 		update_cgrp_time_from_cpuctx(cpuctx, false);
 	}
 
+	/*
+	 * Ensure event_sched_out() switches to OFF, at the very least
+	 * this avoids raising perf_pending_task() at this time.
+	 */
+	if (flags & DETACH_DEAD)
+		event->pending_disable = 1;
 	event_sched_out(event, ctx);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
+	if (flags & DETACH_DEAD)
+		event->state = PERF_EVENT_STATE_DEAD;
 
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
@@ -5299,9 +5308,7 @@ int perf_event_release_kernel(struct perf_event *event)
 
 	ctx = perf_event_ctx_lock(event);
 	WARN_ON_ONCE(ctx->parent_ctx);
-	perf_remove_from_context(event, DETACH_GROUP);
 
-	raw_spin_lock_irq(&ctx->lock);
 	/*
 	 * Mark this event as STATE_DEAD, there is no external reference to it
 	 * anymore.
@@ -5313,8 +5320,7 @@ int perf_event_release_kernel(struct perf_event *event)
 	 * Thus this guarantees that we will in fact observe and kill _ALL_
 	 * child events.
 	 */
-	event->state = PERF_EVENT_STATE_DEAD;
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_remove_from_context(event, DETACH_GROUP|DETACH_DEAD);
 
 	perf_event_ctx_unlock(event, ctx);
 
---

However; I don't think that actually helps, because in this case the new
task_work would actually still be on the ->task_works list and
task_work_cancel() should've worked.

The other possibility seems to be that the sample happens and we
schedule before close() can terminate the event, which means we've
already got perf_pending_task() queued by the time we get to
perf_remove_from_context().

This means the perf_pending_task() queue happened before the fput()
queue, and it is thus ran later (due to FILO ordering -- also see commit
c82199061009 ("task_work: remove fifo ordering guarantee")).

And I can't really see a way out of that other than doing refcount games
indeed.

There is the straight forward way, similar to what Hillf attempted, and
a really nasty one that avoids the atomics in the common case and is
really only targeted at this case -- given the overhead of signals I'm
thinking simple is better.

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9ab0eb073bd5..0228ea090b98 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2248,6 +2248,7 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 		    !event->pending_work) {
 			event->pending_work = 1;
 			dec = false;
+			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
 			task_work_add(current, &event->pending_task, TWA_RESUME);
 		}
 		if (dec)
@@ -6755,6 +6762,8 @@ static void perf_pending_task(struct callback_head *head)
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
 	preempt_enable_notrace();
+
+	put_event(event);
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS


So perhaps both the above..

Does that actually work?
