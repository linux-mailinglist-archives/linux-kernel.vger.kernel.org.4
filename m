Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1225EC226
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiI0MNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiI0MNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:13:37 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3741DADCCF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:13:33 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id j16-20020adfa550000000b0022cbdfcea2dso526865wrb.19
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=O1OHV9/ebX3PFCvVx/+I7boFWMH1Mc6xsGvoR42Opk4=;
        b=Js35UYBGTAeXuwE8muqAzkJM8QCiHIXXURyfDfD/vkaXuGuXPSUDlmVOITttFdf2+E
         2PLSOXWhBqFiuDAM8PlkSzPsdI3Nw2FAWDcldDUP13IXhVeiIJgNeIhVN4h8teDIUYt/
         vjUpBCXlbNh+7AN3gZzSXdY65KWsmW9A/zszdk17gqdL4c1TBzLTNoxh83o/gvO3tQ6L
         2FNHNNrvf47LfkFaAQW+WdqMxRmzvd7CGy65Pxaep8E3FLQ18yQ9Iz+XxhRrLo3fDIQG
         OqXZIuytSmr1QYizY6Tslphht4sADNc823panaDrz9G9IsacxwQiFyUCp2nh/mVACG5m
         E0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=O1OHV9/ebX3PFCvVx/+I7boFWMH1Mc6xsGvoR42Opk4=;
        b=HDqUsTiQdZn7Lyb9XT3xm5kEUOA4wi1dnP1yUnkHEL7EkEQ+rcuE0aQXDBq6E++470
         xctlDczYF3lQo1FX/zFlo/XFVud/I98TWptIHTCx+Ti04RCT7LV7TjxKvsvLFRhdwGJ3
         5nkMsIlSQUyPIB5NT4lpTV9VX5/2oH8IuaRdB87swRv9MlqanksDM/JFQnivas3+HH/F
         1+oqnYK6QJE75sCTGpFMlqC1ILNC5vif7FSM3nuQR+Avp/qghqK/Im0mmr+5/uqmpwgd
         tiMiwq8ElGgK0VOe5THiuwR1j4vEusgHACMTIp/mYL3mfgBo/AhMeYtcxF3vUVEjWwrX
         Aicw==
X-Gm-Message-State: ACrzQf1iJKd9Wmwvs8+l/xVSKt72l2zpvfQvQOV3gG/R5RVAJdsbdXuZ
        5PomJ0PqP9trDl1Ov2woRDNZ+GeIMA==
X-Google-Smtp-Source: AMsMyM4R5CYl3uhh4T40rm7q9oLfuLcZB+9ODGmYTnViNguYNk3SI4NV4VFqKvCex8lHPJl4pSElth/2HA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:693c:15a1:a531:bb4e])
 (user=elver job=sendgmr) by 2002:a5d:6d07:0:b0:22a:3f21:3b56 with SMTP id
 e7-20020a5d6d07000000b0022a3f213b56mr16261810wrq.679.1664280811693; Tue, 27
 Sep 2022 05:13:31 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:13:22 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927121322.1236730-1-elver@google.com>
Subject: [PATCH] perf: Fix missing SIGTRAPs due to pending_disable abuse
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 include/linux/perf_event.h |  2 +
 kernel/events/core.c       | 85 ++++++++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 12 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 907b0e3f1318..dff3430844a2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -740,8 +740,10 @@ struct perf_event {
 	int				pending_wakeup;
 	int				pending_kill;
 	int				pending_disable;
+	int				pending_sigtrap;
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending;
+	struct irq_work			pending_resched;
 
 	atomic_t			event_limit;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 75f5705b6892..df90777262bf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2527,6 +2527,14 @@ event_sched_in(struct perf_event *event,
 	if (event->attr.exclusive)
 		cpuctx->exclusive = 1;
 
+	if (event->pending_sigtrap) {
+		/*
+		 * The task and event might have been moved to another CPU:
+		 * queue another IRQ work. See perf_pending_event_sigtrap().
+		 */
+		WARN_ON_ONCE(!irq_work_queue(&event->pending_resched));
+	}
+
 out:
 	perf_pmu_enable(event->pmu);
 
@@ -4938,6 +4946,7 @@ static void perf_addr_filters_splice(struct perf_event *event,
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending);
+	irq_work_sync(&event->pending_resched);
 
 	unaccount_event(event);
 
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
@@ -6511,6 +6545,26 @@ static void perf_pending_event(struct irq_work *entry)
 		perf_swevent_put_recursion_context(rctx);
 }
 
+/*
+ * If handling of a pending action must occur before returning to user space,
+ * and it is possible to reschedule an event (to another CPU) with pending
+ * actions, where the moved-from CPU may not yet have run event->pending (and
+ * irq_work_queue() would fail on reuse), we'll use a separate IRQ work that
+ * runs perf_pending_event_resched().
+ */
+static void perf_pending_event_resched(struct irq_work *entry)
+{
+	struct perf_event *event = container_of(entry, struct perf_event, pending_resched);
+	int rctx;
+
+	rctx = perf_swevent_get_recursion_context();
+
+	perf_pending_event_sigtrap(event);
+
+	if (rctx >= 0)
+		perf_swevent_put_recursion_context(rctx);
+}
+
 #ifdef CONFIG_GUEST_PERF_EVENTS
 struct perf_guest_info_callbacks __rcu *perf_guest_cbs;
 
@@ -9209,11 +9263,20 @@ static int __perf_event_overflow(struct perf_event *event,
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
@@ -11536,6 +11599,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_waitqueue_head(&event->waitq);
 	event->pending_disable = -1;
 	init_irq_work(&event->pending, perf_pending_event);
+	init_irq_work(&event->pending_resched, perf_pending_event_resched);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
@@ -11557,9 +11621,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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

