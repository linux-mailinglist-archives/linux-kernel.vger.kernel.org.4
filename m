Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDDF5F480D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJDRJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJDRJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:09:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555EF19B;
        Tue,  4 Oct 2022 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HISWwRKFuRO/9DyL6LlzLd2PnC0+qLYEQ5vpRXdvxxs=; b=QIT+ry9z0NeFwQYlagP2UmOgLM
        31WtS7itVh/X+EZIv7YdWGzt6CcT11oZrClXmHlG5YMlGvSpWY1amZcpyuozcPtX9fDqmIzOmLZUM
        MieJR7+2ir7J3x5SayV4/vO15WBKYaCnqyz0DOvD0CprhJ6k1+xiki7UWszsTW3sZV/PXF/AD1qk1
        PdDT8sQx0eC0QxB1D5XG8DRw2d2eNg6DAvyuz/XmnJeaWh1QzlYLwgapQFjz7xocNOzUtQ5SSg8zJ
        aS5kn+mQNt6yJUoCSkGsDGrVNUF6sQotpu2KC6CkTOi9Aa3aiWCjLKD7NAA2Y7Yzgo0C3THpVDXt+
        B10m1Pnw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oflQ0-00HKVc-RF; Tue, 04 Oct 2022 17:09:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C80B43001CE;
        Tue,  4 Oct 2022 19:09:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BF5F209B80F8; Tue,  4 Oct 2022 19:09:15 +0200 (CEST)
Date:   Tue, 4 Oct 2022 19:09:15 +0200
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
Message-ID: <Yzxou9HB/1XjMXWI@hirez.programming.kicks-ass.net>
References: <20220927121322.1236730-1-elver@google.com>
 <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
 <YzNu5bgASbuVi0S3@elver.google.com>
 <YzQcqe9p9C5ZbjZ1@elver.google.com>
 <YzRgcnMXWuUZ4rlt@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzRgcnMXWuUZ4rlt@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 04:55:46PM +0200, Marco Elver wrote:
> On Wed, Sep 28, 2022 at 12:06PM +0200, Marco Elver wrote:
> 
> > My second idea about introducing something like irq_work_raw_sync().
> > Maybe it's not that crazy if it is actually safe. I expect this case
> > where we need the irq_work_raw_sync() to be very very rare.
> 
> The previous irq_work_raw_sync() forgot about irq_work_queue_on(). Alas,
> I might still be missing something obvious, because "it's never that
> easy". ;-)
> 
> And for completeness, the full perf patch of what it would look like
> together with irq_work_raw_sync() (consider it v1.5). It's already
> survived some shorter stress tests and fuzzing.

So.... I don't like it. But I cooked up the below, which _almost_ works :-/

For some raisin it sometimes fails with 14999 out of 15000 events
delivered and I've not yet figured out where it goes sideways. I'm
currently thinking it's that sigtrap clear on OFF.

Still, what do you think of the approach?

---
 include/linux/perf_event.h |  8 ++--
 kernel/events/core.c       | 92 +++++++++++++++++++++++++---------------------
 2 files changed, 55 insertions(+), 45 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ee8b9ecdc03b..c54161719d37 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -736,9 +736,11 @@ struct perf_event {
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
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..8e5dbe971d9e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2268,11 +2268,15 @@ event_sched_out(struct perf_event *event,
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
+	if (event->pending_sigtrap && state == PERF_EVENT_STATE_OFF)
+		event->pending_sigtrap = 0;
+
 	perf_event_set_state(event, state);
 
 	if (!is_software_event(event))
@@ -2463,8 +2467,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
 
 void perf_event_disable_inatomic(struct perf_event *event)
 {
-	WRITE_ONCE(event->pending_disable, smp_processor_id());
-	/* can fail, see perf_pending_event_disable() */
+	event->pending_disable = 1;
 	irq_work_queue(&event->pending);
 }
 
@@ -2527,6 +2530,9 @@ event_sched_in(struct perf_event *event,
 	if (event->attr.exclusive)
 		cpuctx->exclusive = 1;
 
+	if (event->pending_disable || event->pending_sigtrap)
+		irq_work_queue(&event->pending);
+
 out:
 	perf_pmu_enable(event->pmu);
 
@@ -6440,47 +6446,40 @@ static void perf_sigtrap(struct perf_event *event)
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
@@ -6488,19 +6487,23 @@ static void perf_pending_event(struct irq_work *entry)
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
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
 }
@@ -9203,11 +9206,20 @@ static int __perf_event_overflow(struct perf_event *event,
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
@@ -11528,7 +11540,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 
 	init_waitqueue_head(&event->waitq);
-	event->pending_disable = -1;
 	init_irq_work(&event->pending, perf_pending_event);
 
 	mutex_init(&event->mmap_mutex);
@@ -11551,9 +11562,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (parent_event)
 		event->event_caps = parent_event->event_caps;
 
-	if (event->attr.sigtrap)
-		atomic_set(&event->event_limit, 1);
-
 	if (task) {
 		event->attach_state = PERF_ATTACH_TASK;
 		/*
