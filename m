Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1831D5EDF45
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiI1O4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiI1Oz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:55:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911679685
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:55:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc7so27786179ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jD41RBwsQAO8F9W6wPajIDr+uexC/n3UBb3DBn/vWVE=;
        b=bHTJmWYvcRRdH0i/juwduIH+xTiu9sOZPJauSbF3vLNtZDQ9uCaGEkbU8430f4UqbB
         0Xg7t8ftYcLNU4Vy7gbgoxn5qOyo5StVeTKBVINSMiAwYDZHJ3/faRwRRU2SsqBk9rhQ
         apO5SQE79H200Q3Us0+XMkuQMjoWuRyQ6k4ySLe4dLjh3pXDwc5ppq470sLFBYAM+NND
         8MbVl30YEivl6xubcwenZQ95ZZzI5/oNquvIHBUqKbaCyXXLg6nkKrrbbmsbO97qJ8XX
         Vp0g93imNhsUBGyP1KFunUxlNYFBWtpgLJRKCNG4ZgM1xtcaTrdRaiZBhkp34aWSNEr/
         SSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jD41RBwsQAO8F9W6wPajIDr+uexC/n3UBb3DBn/vWVE=;
        b=cU8QRuITeN9p3JBFj62yzC738O4hz5f996YnjvZOkwOK5WYS166MZCCa0rxSmPuHXC
         +pYhUhxxKkCPNZQxP7xh9DbizwDKJlldahhcPmopj119s4DEqjCjnh40+LTj0cjaKB16
         riLrC6Gf0rHVEx6vZJsHr1dzwWnSC3B7LxsvGy4BVnANlYHpUXHQQ1WDQwjEKim2BAG0
         tbwV9vvj6xDV9Zf0LvXeh5T/aYRJw25DfHNFngtiMV1VG2TGqM1K/ZxB2JiYFwfbnVA3
         FKePWiJFdOPxM9yN6Q5S4VIzhLDKDDz19+RlPIJwCUN09yCV7/7hz36YSDAyiO2Ck1t2
         6/aA==
X-Gm-Message-State: ACrzQf2DxlW47fYtZM0zMDVC+HYNyMECLC+p3wCdLcZr8GW6WJroQLvz
        kSYgbZkNvi0W78haXPnkhfKNKQ==
X-Google-Smtp-Source: AMsMyM4dc2ncpWtwN/VZTFZcFysrAI3y/1gSVH4Ea47ve1DqpmcoVMvziFOO4z0n45Tn1fVqfq9EoA==
X-Received: by 2002:a17:906:9749:b0:782:287f:d217 with SMTP id o9-20020a170906974900b00782287fd217mr27395588ejy.259.1664376954293;
        Wed, 28 Sep 2022 07:55:54 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:dbbc:9ea2:a5f7:571e])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906219200b0073de0506745sm2489691eju.197.2022.09.28.07.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:55:53 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:55:46 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs due to pending_disable abuse
Message-ID: <YzRgcnMXWuUZ4rlt@elver.google.com>
References: <20220927121322.1236730-1-elver@google.com>
 <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
 <YzNu5bgASbuVi0S3@elver.google.com>
 <YzQcqe9p9C5ZbjZ1@elver.google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bwaiqnhq9mMzxU4e"
Content-Disposition: inline
In-Reply-To: <YzQcqe9p9C5ZbjZ1@elver.google.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bwaiqnhq9mMzxU4e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 28, 2022 at 12:06PM +0200, Marco Elver wrote:

> My second idea about introducing something like irq_work_raw_sync().
> Maybe it's not that crazy if it is actually safe. I expect this case
> where we need the irq_work_raw_sync() to be very very rare.

The previous irq_work_raw_sync() forgot about irq_work_queue_on(). Alas,
I might still be missing something obvious, because "it's never that
easy". ;-)

And for completeness, the full perf patch of what it would look like
together with irq_work_raw_sync() (consider it v1.5). It's already
survived some shorter stress tests and fuzzing.

Thanks,
-- Marco

--bwaiqnhq9mMzxU4e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-irq_work-Introduce-irq_work_raw_sync.patch"

From 5fcc38d87b2cd8c05c5306c0140ccc076c5bf963 Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Wed, 28 Sep 2022 16:33:27 +0200
Subject: [PATCH 1/2] irq_work: Introduce irq_work_raw_sync()

Introduce a non-sleeping spinning variant of irq_work_sync(), called
irq_work_raw_sync(). Its usage is limited to contexts where interrupts
are disabled, and unlike irq_work_sync(), may fail if the work is
pending in the current CPU.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 include/linux/irq_work.h |  1 +
 kernel/irq_work.c        | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 8cd11a223260..490adecbb4be 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -59,6 +59,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu);
 
 void irq_work_tick(void);
 void irq_work_sync(struct irq_work *work);
+bool irq_work_raw_sync(struct irq_work *work);
 
 #ifdef CONFIG_IRQ_WORK
 #include <asm/irq_work.h>
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc4..b251b3437db1 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -290,6 +290,47 @@ void irq_work_sync(struct irq_work *work)
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
 
+/*
+ * Synchronize against the irq_work @work, ensuring the entry is not currently
+ * in use after returning true; returns false if it's impossible to synchronize
+ * due to being queued on the current CPU. Requires that interrupts are already
+ * disabled (prefer irq_work_sync() in all other cases).
+ */
+bool irq_work_raw_sync(struct irq_work *work)
+{
+	struct llist_node *head;
+	struct irq_work *entry;
+
+	/*
+	 * Interrupts should be disabled, so that we can be sure the current
+	 * CPU's work queues aren't concurrently run, cleared, and potentially
+	 * some of its entries becoming invalid in the below iterations.
+	 */
+	lockdep_assert_irqs_disabled();
+
+	while (irq_work_is_busy(work)) {
+		/*
+		 * It is only safe to wait if the work is not on this CPU's work
+		 * queues. Also beware of concurrent irq_work_queue_on(), so we
+		 * need to keep re-checking this CPU's queues in this busy loop.
+		 */
+		head = READ_ONCE(this_cpu_ptr(&raised_list)->first);
+		llist_for_each_entry(entry, head, node.llist) {
+			if (entry == work)
+				return false;
+		}
+		head = READ_ONCE(this_cpu_ptr(&lazy_list)->first);
+		llist_for_each_entry(entry, head, node.llist) {
+			if (entry == work)
+				return false;
+		}
+		cpu_relax();
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(irq_work_raw_sync);
+
 static void run_irq_workd(unsigned int cpu)
 {
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
-- 
2.37.3.998.g577e59143f-goog


--bwaiqnhq9mMzxU4e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-perf-Fix-missing-SIGTRAPs-due-to-pending_disable-abu.patch"

From 4467a6520c8f59065220a651167c4cd8da7a6e9b Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Fri, 23 Sep 2022 16:43:19 +0200
Subject: [PATCH 2/2] perf: Fix missing SIGTRAPs due to pending_disable abuse

Due to the implementation of how SIGTRAP are delivered if
perf_event_attr::sigtrap is set, we've noticed 3 issues:

	1. Missing SIGTRAP due to a race with event_sched_out() (more
	   details below).

	2. Hardware PMU events being disabled due to returning 1 from
	   perf_event_overflow(). The only way to re-enable the event is
	   for user space to first "properly" disable the event and then
	   re-enable it.

	3. The inability to automatically disable an event after a
	   specified number of overflows via PERF_EVENT_IOC_REFRESH.

The worst of the 3 issues is problem (1), which occurs when a
pending_disable is "consumed" by a racing event_sched_out(), observed as
follows:

		CPU0			| 	CPU1
	--------------------------------+---------------------------
	__perf_event_overflow()		|
	 perf_event_disable_inatomic()	|
	  pending_disable = CPU0	| ...
	  				| _perf_event_enable()
					|  event_function_call()
					|   task_function_call()
					|    /* sends IPI to CPU0 */
	<IPI>				| ...
	 __perf_event_enable()		+---------------------------
	  ctx_resched()
	   task_ctx_sched_out()
	    ctx_sched_out()
	     group_sched_out()
	      event_sched_out()
	       pending_disable = -1
	</IPI>
	<IRQ-work>
	 perf_pending_event()
	  perf_pending_event_disable()
	   /* Fails to send SIGTRAP because no pending_disable! */
	</IRQ-work>

In the above case, not only is that particular SIGTRAP missed, but also
all future SIGTRAPs because 'event_limit' is not reset back to 1.

To fix, rework pending delivery of SIGTRAP via IRQ-work by introduction
of a separate 'pending_sigtrap', no longer using 'event_limit' and
'pending_disable' for its delivery.

During testing, this also revealed several more possible races between
reschedules and pending IRQ work; see code comments for details.

Doing so makes it possible to use 'event_limit' normally (thereby
enabling use of PERF_EVENT_IOC_REFRESH), perf_event_overflow() no longer
returns 1 on SIGTRAP causing disabling of hardware PMUs, and finally the
race is no longer possible due to event_sched_out() not consuming
'pending_disable'.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Debugged-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Use irq_work_raw_sync().
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 64 +++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 907b0e3f1318..c119fa7b70d6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -740,6 +740,7 @@ struct perf_event {
 	int				pending_wakeup;
 	int				pending_kill;
 	int				pending_disable;
+	int				pending_sigtrap;
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c37ba0909078..6ba02a1b5c5d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2527,6 +2527,15 @@ event_sched_in(struct perf_event *event,
 	if (event->attr.exclusive)
 		cpuctx->exclusive = 1;
 
+	if (event->pending_sigtrap) {
+		/*
+		 * The task and event might have been moved to another CPU:
+		 * queue another IRQ work. See perf_pending_event_sigtrap().
+		 */
+		irq_work_raw_sync(&event->pending); /* Syncs if pending on other CPU. */
+		irq_work_queue(&event->pending);
+	}
+
 out:
 	perf_pmu_enable(event->pmu);
 
@@ -6446,6 +6455,37 @@ static void perf_sigtrap(struct perf_event *event)
 		      event->attr.type, event->attr.sig_data);
 }
 
+static void perf_pending_event_sigtrap(struct perf_event *event)
+{
+	if (!event->pending_sigtrap)
+		return;
+
+	/*
+	 * If we're racing with disabling of the event, consume pending_sigtrap
+	 * and don't send the SIGTRAP. This avoids potentially delaying a signal
+	 * indefinitely (oncpu mismatch) until the event is enabled again, which
+	 * could happen after already returning to user space; in that case the
+	 * signal would erroneously become asynchronous.
+	 */
+	if (event->state == PERF_EVENT_STATE_OFF) {
+		event->pending_sigtrap = 0;
+		return;
+	}
+
+	/*
+	 * Only process this pending SIGTRAP if this IRQ work is running on the
+	 * right CPU: the scheduler is able to run before the IRQ work, which
+	 * moved the task to another CPU. In event_sched_in() another IRQ work
+	 * is scheduled, so that the signal is not lost; given the kernel has
+	 * not yet returned to user space, the signal remains synchronous.
+	 */
+	if (READ_ONCE(event->oncpu) != smp_processor_id())
+		return;
+
+	event->pending_sigtrap = 0;
+	perf_sigtrap(event);
+}
+
 static void perf_pending_event_disable(struct perf_event *event)
 {
 	int cpu = READ_ONCE(event->pending_disable);
@@ -6455,13 +6495,6 @@ static void perf_pending_event_disable(struct perf_event *event)
 
 	if (cpu == smp_processor_id()) {
 		WRITE_ONCE(event->pending_disable, -1);
-
-		if (event->attr.sigtrap) {
-			perf_sigtrap(event);
-			atomic_set_release(&event->event_limit, 1); /* rearm event */
-			return;
-		}
-
 		perf_event_disable_local(event);
 		return;
 	}
@@ -6500,6 +6533,7 @@ static void perf_pending_event(struct irq_work *entry)
 	 * and we won't recurse 'further'.
 	 */
 
+	perf_pending_event_sigtrap(event);
 	perf_pending_event_disable(event);
 
 	if (event->pending_wakeup) {
@@ -9209,11 +9243,20 @@ static int __perf_event_overflow(struct perf_event *event,
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
@@ -11557,9 +11600,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (parent_event)
 		event->event_caps = parent_event->event_caps;
 
-	if (event->attr.sigtrap)
-		atomic_set(&event->event_limit, 1);
-
 	if (task) {
 		event->attach_state = PERF_ATTACH_TASK;
 		/*
-- 
2.37.3.998.g577e59143f-goog


--bwaiqnhq9mMzxU4e--
