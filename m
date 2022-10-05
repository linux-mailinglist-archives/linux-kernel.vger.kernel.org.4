Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B501A5F5067
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJEHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJEHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:37:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7A765553;
        Wed,  5 Oct 2022 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XqDfzIvXSelkrbDlyQ1vmQ7mysva9wlo/4eb4beEi2g=; b=EMpd1ufPRAOsfT1ah5BoXGz2Cg
        eIHO9uAwNy3J2XnPnxRY9KJu0lHq/IYjP+ozMmP83o56X/wnTgjHp1cTM/y8lvBYH5f/AR5qem4Ga
        AoJSimUkFJQ6ihrxs2QNFKeKRwpk6LsLSA0ikelVILgLnDYPGsV8MfRA5xYTDmi5yD6fztkg1KW+g
        AE97vNKJW4cnR+Px+XQPpjfSVaa3r5FLMrZdXhPZwksehaAdlMqsR0qMNVAqVN1jeLU1gK7ec1SFQ
        ejO8bLXYbrs5VdCZsx512XlIOCc7ckgh8LrWivhTZNrKvLkQrNnv3iaTJGOmZmrpBe8sgURH17uG+
        D0D+4gmA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ofyxq-000CCB-H4; Wed, 05 Oct 2022 07:37:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E45D3001CE;
        Wed,  5 Oct 2022 09:37:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A04520181465; Wed,  5 Oct 2022 09:37:06 +0200 (CEST)
Date:   Wed, 5 Oct 2022 09:37:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs due to pending_disable abuse
Message-ID: <Yz00IjTZjlsKlNvy@hirez.programming.kicks-ass.net>
References: <20220927121322.1236730-1-elver@google.com>
 <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
 <YzNu5bgASbuVi0S3@elver.google.com>
 <YzQcqe9p9C5ZbjZ1@elver.google.com>
 <YzRgcnMXWuUZ4rlt@elver.google.com>
 <Yzxou9HB/1XjMXWI@hirez.programming.kicks-ass.net>
 <CANpmjNPwiL279B5id5dPF821aXYdTUqsfDNAtB4q7jXX+41Qgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPwiL279B5id5dPF821aXYdTUqsfDNAtB4q7jXX+41Qgg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 07:33:55PM +0200, Marco Elver wrote:
> It looks reasonable, but obviously needs to pass tests. :-)

Ikr :-)

> Also, see comment below (I think you're still turning signals
> asynchronous, which we shouldn't do).

Indeed so; I tried fixing that this morning, but so far that doesn't
seem to want to actually cure things :/ I'll need to stomp on this
harder.

Current hackery below. The main difference is that instead of trying to
restart the irq_work on sched_in, sched_out will now queue a task-work.

The event scheduling is done from 'regular' IRQ context and as such
there should be a return-to-userspace for the relevant task in the
immediate future (either directly or after scheduling).

Alas, something still isn't right...

---
 include/linux/perf_event.h |   9 ++--
 kernel/events/core.c       | 115 ++++++++++++++++++++++++++++-----------------
 2 files changed, 79 insertions(+), 45 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 853f64b6c8c2..f15726a6c127 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -756,11 +756,14 @@ struct perf_event {
 	struct fasync_struct		*fasync;
 
 	/* delayed work for NMIs and such */
-	int				pending_wakeup;
-	int				pending_kill;
-	int				pending_disable;
+	unsigned int			pending_wakeup	:1;
+	unsigned int			pending_disable	:1;
+	unsigned int			pending_sigtrap	:1;
+	unsigned int			pending_kill	:3;
+
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending;
+	struct callback_head		pending_sig;
 
 	atomic_t			event_limit;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b981b879bcd8..e28257fb6f00 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -54,6 +54,7 @@
 #include <linux/highmem.h>
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
+#include <linux/task_work.h>
 
 #include "internal.h"
 
@@ -2276,11 +2277,19 @@ event_sched_out(struct perf_event *event,
 	event->pmu->del(event, 0);
 	event->oncpu = -1;
 
-	if (READ_ONCE(event->pending_disable) >= 0) {
-		WRITE_ONCE(event->pending_disable, -1);
+	if (event->pending_disable) {
+		event->pending_disable = 0;
 		perf_cgroup_event_disable(event, ctx);
 		state = PERF_EVENT_STATE_OFF;
 	}
+
+	if (event->pending_sigtrap) {
+		if (state != PERF_EVENT_STATE_OFF)
+			task_work_add(current, &event->pending_sig, TWA_NONE);
+		else
+			event->pending_sigtrap = 0;
+	}
+
 	perf_event_set_state(event, state);
 
 	if (!is_software_event(event))
@@ -2471,8 +2480,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
 
 void perf_event_disable_inatomic(struct perf_event *event)
 {
-	WRITE_ONCE(event->pending_disable, smp_processor_id());
-	/* can fail, see perf_pending_event_disable() */
+	event->pending_disable = 1;
 	irq_work_queue(&event->pending);
 }
 
@@ -6448,47 +6456,40 @@ static void perf_sigtrap(struct perf_event *event)
 		      event->attr.type, event->attr.sig_data);
 }
 
-static void perf_pending_event_disable(struct perf_event *event)
+/*
+ * Deliver the pending work in-event-context or follow the context.
+ */
+static void __perf_pending_event(struct perf_event *event)
 {
-	int cpu = READ_ONCE(event->pending_disable);
+	int cpu = READ_ONCE(event->oncpu);
 
+	/* 
+	 * If the event isn't running; we done. event_sched_in() will restart
+	 * the irq_work when needed.
+	 */
 	if (cpu < 0)
 		return;
 
+	/*
+	 * Yay, we hit home and are in the context of the event.
+	 */
 	if (cpu == smp_processor_id()) {
-		WRITE_ONCE(event->pending_disable, -1);
-
-		if (event->attr.sigtrap) {
+		if (event->pending_sigtrap) {
+			event->pending_sigtrap = 0;
 			perf_sigtrap(event);
-			atomic_set_release(&event->event_limit, 1); /* rearm event */
-			return;
 		}
-
-		perf_event_disable_local(event);
-		return;
+		if (event->pending_disable) {
+			event->pending_disable = 0;
+			perf_event_disable_local(event);
+		}
 	}
 
 	/*
-	 *  CPU-A			CPU-B
-	 *
-	 *  perf_event_disable_inatomic()
-	 *    @pending_disable = CPU-A;
-	 *    irq_work_queue();
-	 *
-	 *  sched-out
-	 *    @pending_disable = -1;
-	 *
-	 *				sched-in
-	 *				perf_event_disable_inatomic()
-	 *				  @pending_disable = CPU-B;
-	 *				  irq_work_queue(); // FAILS
-	 *
-	 *  irq_work_run()
-	 *    perf_pending_event()
-	 *
-	 * But the event runs on CPU-B and wants disabling there.
+	 * Requeue if there's still any pending work left, make sure to follow
+	 * where the event went.
 	 */
-	irq_work_queue_on(&event->pending, cpu);
+	if (event->pending_disable || event->pending_sigtrap)
+		irq_work_queue_on(&event->pending, cpu);
 }
 
 static void perf_pending_event(struct irq_work *entry)
@@ -6496,19 +6497,43 @@ static void perf_pending_event(struct irq_work *entry)
 	struct perf_event *event = container_of(entry, struct perf_event, pending);
 	int rctx;
 
-	rctx = perf_swevent_get_recursion_context();
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
 	 */
+	rctx = perf_swevent_get_recursion_context();
 
-	perf_pending_event_disable(event);
-
+	/*
+	 * The wakeup isn't bound to the context of the event -- it can happen
+	 * irrespective of where the event is.
+	 */
 	if (event->pending_wakeup) {
 		event->pending_wakeup = 0;
 		perf_event_wakeup(event);
 	}
 
+	__perf_pending_event(event);
+
+	if (rctx >= 0)
+		perf_swevent_put_recursion_context(rctx);
+}
+
+static void perf_pending_sig(struct callback_head *head)
+{
+	struct perf_event *event = container_of(head, struct perf_event, pending_sig);
+	int rctx;
+
+	/*
+	 * If we 'fail' here, that's OK, it means recursion is already disabled
+	 * and we won't recurse 'further'.
+	 */
+	rctx = perf_swevent_get_recursion_context();
+
+	if (event->pending_sigtrap) {
+		event->pending_sigtrap = 0;
+		perf_sigtrap(event);
+	}
+
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
 }
@@ -9227,11 +9252,20 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (events && atomic_dec_and_test(&event->event_limit)) {
 		ret = 1;
 		event->pending_kill = POLL_HUP;
-		event->pending_addr = data->addr;
-
 		perf_event_disable_inatomic(event);
 	}
 
+	if (event->attr.sigtrap) {
+		/*
+		 * Should not be able to return to user space without processing
+		 * pending_sigtrap (kernel events can overflow multiple times).
+		 */
+		WARN_ON_ONCE(event->pending_sigtrap && event->attr.exclude_kernel);
+		event->pending_sigtrap = 1;
+		event->pending_addr = data->addr;
+		irq_work_queue(&event->pending);
+	}
+
 	READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
@@ -11560,8 +11594,8 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 
 	init_waitqueue_head(&event->waitq);
-	event->pending_disable = -1;
 	init_irq_work(&event->pending, perf_pending_event);
+	init_task_work(&event->pending_sig, perf_pending_sig);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
@@ -11583,9 +11617,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (parent_event)
 		event->event_caps = parent_event->event_caps;
 
-	if (event->attr.sigtrap)
-		atomic_set(&event->event_limit, 1);
-
 	if (task) {
 		event->attach_state = PERF_ATTACH_TASK;
 		/*
