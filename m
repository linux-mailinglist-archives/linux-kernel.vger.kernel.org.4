Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAD25ECF72
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiI0VpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiI0VpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:45:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D235FAC9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:45:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lh5so23394770ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=OE70BMzWV5KkigIfgdUJ3KWiPY5Ag5voOlsKOHSQbIc=;
        b=QS5Fct4Oc/1CNXeKITZAVQY51SFQvlrrX2n3T7CKhkQ2M3+6EInGDZrHWo1e8ZXSLv
         jpbmx031U63feeaZn3r1b0HY09dgn1IsWDCIH3argyKHxobu5ASEuwBkYhAx36ui/dEq
         ts/S6dcqCfP8KTfpuhK3jNk11QZJY70qPAlU4KLL35xactmbVgpd8azi+kdKfgTsuk/4
         bPLQEx2cyuzaXF/SNspzvlkoFSosIht2k8+k9bUiSLodcvzWN4Qd/0h8MThQ4QqbrLaY
         bt/eHMLwWkYbENKTMUj5LaCx7LCa+HtRKjTFBS4S3pZ5KSfKdU3+PuFLdVMwQGZDwJnc
         W2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OE70BMzWV5KkigIfgdUJ3KWiPY5Ag5voOlsKOHSQbIc=;
        b=pVPATEOd/bOWDV4llCn7Msl/6DQmZr3xO+gjCiBeSK76Mrk92NluBlldYPDP9hOG8o
         PC1Fo5LcRsZoHlxrNztm0hV0YnphpTVn2aNOq6jwIrCIHkWbT5TUYZjRpBQh/SJ6lv8J
         4VtURDdpySWAeqNxG0xAAdACXeRGS0nY4lUGArnsPsl/A/e4BYKtK75t6OwiJxCff3R0
         hp0nAEwq+gHHfjiNiUCQKYdwx2G2oio5BpTSGXBdGu/koXuMhWqQ2LIk3thXlOqOnQ0P
         i2FP8Idvv1ElkRQbLqScy7nQK4SaIRdNRA2LjCAyC26kG7UbRKB3oMZInoLx5XjqhAiZ
         USMA==
X-Gm-Message-State: ACrzQf2YopADk6ZSdMU4RGvG+LSwj/2joHZNhqx8Lj9oUvnoqDfC7+y9
        hBEmgWvpLOul14/cc/G5HjEcMQ==
X-Google-Smtp-Source: AMsMyM5wifDtgnSI24VSW2N0xQH47iV/m4NVjRR075WnxDkiDC9QnFBhzY9d1kBubCNqDlIayzzORg==
X-Received: by 2002:a17:906:4ac1:b0:780:3448:ff06 with SMTP id u1-20020a1709064ac100b007803448ff06mr24753758ejt.403.1664315116881;
        Tue, 27 Sep 2022 14:45:16 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:dbbc:9ea2:a5f7:571e])
        by smtp.gmail.com with ESMTPSA id h1-20020a056402094100b00457e20cb2e4sm232518edz.48.2022.09.27.14.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:45:16 -0700 (PDT)
Date:   Tue, 27 Sep 2022 23:45:09 +0200
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
Message-ID: <YzNu5bgASbuVi0S3@elver.google.com>
References: <20220927121322.1236730-1-elver@google.com>
 <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
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

On Tue, Sep 27, 2022 at 08:20PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 27, 2022 at 02:13:22PM +0200, Marco Elver wrote:
> > Due to the implementation of how SIGTRAP are delivered if
> > perf_event_attr::sigtrap is set, we've noticed 3 issues:
> > 
> > 	1. Missing SIGTRAP due to a race with event_sched_out() (more
> > 	   details below).
> > 
> > 	2. Hardware PMU events being disabled due to returning 1 from
> > 	   perf_event_overflow(). The only way to re-enable the event is
> > 	   for user space to first "properly" disable the event and then
> > 	   re-enable it.
> > 
> > 	3. The inability to automatically disable an event after a
> > 	   specified number of overflows via PERF_EVENT_IOC_REFRESH.
> > 
> > The worst of the 3 issues is problem (1), which occurs when a
> > pending_disable is "consumed" by a racing event_sched_out(), observed as
> > follows:
> > 
> > 		CPU0			| 	CPU1
> > 	--------------------------------+---------------------------
> > 	__perf_event_overflow()		|
> > 	 perf_event_disable_inatomic()	|
> > 	  pending_disable = CPU0	| ...
> > 	  				| _perf_event_enable()
> > 					|  event_function_call()
> > 					|   task_function_call()
> > 					|    /* sends IPI to CPU0 */
> > 	<IPI>				| ...
> > 	 __perf_event_enable()		+---------------------------
> > 	  ctx_resched()
> > 	   task_ctx_sched_out()
> > 	    ctx_sched_out()
> > 	     group_sched_out()
> > 	      event_sched_out()
> > 	       pending_disable = -1
> > 	</IPI>
> > 	<IRQ-work>
> > 	 perf_pending_event()
> > 	  perf_pending_event_disable()
> > 	   /* Fails to send SIGTRAP because no pending_disable! */
> > 	</IRQ-work>
> > 
> > In the above case, not only is that particular SIGTRAP missed, but also
> > all future SIGTRAPs because 'event_limit' is not reset back to 1.
> > 
> > To fix, rework pending delivery of SIGTRAP via IRQ-work by introduction
> > of a separate 'pending_sigtrap', no longer using 'event_limit' and
> > 'pending_disable' for its delivery.
> > 
> > During testing, this also revealed several more possible races between
> > reschedules and pending IRQ work; see code comments for details.
> 
> Perhaps use task_work_add() for this case? That runs on the
> return-to-user path, so then it doesn't matter how many reschedules
> happen in between.

Hmm, I tried the below (on top of this patch), but then all the tests
fail (including tools/testing/selftests/perf_events/sigtrap_threads.c)
because of lots of missing SIGTRAP. (The missing SIGTRAP happen with or
without the kernel/entry/ change.)

So something is wrong with task_work, and the irq_work solution thus far
is more robust (ran many hours of tests and fuzzing without failure).

Thoughts?

------ >8 ------

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index dff3430844a2..928fb9e2b655 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -743,7 +743,7 @@ struct perf_event {
 	int				pending_sigtrap;
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending;
-	struct irq_work			pending_resched;
+	struct callback_head		pending_twork;
 
 	atomic_t			event_limit;
 
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 063068a9ea9b..7cacaefc97fe 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -162,12 +162,12 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & _TIF_PATCH_PENDING)
 			klp_update_patch_state(current);
 
-		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
-			arch_do_signal_or_restart(regs);
-
 		if (ti_work & _TIF_NOTIFY_RESUME)
 			resume_user_mode_work(regs);
 
+		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+			arch_do_signal_or_restart(regs);
+
 		/* Architecture specific TIF work */
 		arch_exit_to_user_mode_work(regs, ti_work);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 007a87c1599c..7f93dd91d572 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -17,6 +17,7 @@
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/hash.h>
+#include <linux/task_work.h>
 #include <linux/tick.h>
 #include <linux/sysfs.h>
 #include <linux/dcache.h>
@@ -2527,14 +2528,6 @@ event_sched_in(struct perf_event *event,
 	if (event->attr.exclusive)
 		cpuctx->exclusive = 1;
 
-	if (event->pending_sigtrap) {
-		/*
-		 * The task and event might have been moved to another CPU:
-		 * queue another IRQ work. See perf_pending_event_sigtrap().
-		 */
-		WARN_ON_ONCE(!irq_work_queue(&event->pending_resched));
-	}
-
 out:
 	perf_pmu_enable(event->pmu);
 
@@ -4942,11 +4935,13 @@ static bool exclusive_event_installable(struct perf_event *event,
 
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
+static void perf_pending_event_task_work(struct callback_head *work);
 
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending);
-	irq_work_sync(&event->pending_resched);
+	if (event->hw.target)
+		task_work_cancel(event->hw.target, perf_pending_event_task_work);
 
 	unaccount_event(event);
 
@@ -6438,15 +6433,7 @@ void perf_event_wakeup(struct perf_event *event)
 static void perf_sigtrap(struct perf_event *event)
 {
 	/*
-	 * We'd expect this to only occur if the irq_work is delayed and either
-	 * ctx->task or current has changed in the meantime. This can be the
-	 * case on architectures that do not implement arch_irq_work_raise().
-	 */
-	if (WARN_ON_ONCE(event->ctx->task != current))
-		return;
-
-	/*
-	 * perf_pending_event() can race with the task exiting.
+	 * Can be called while the task is exiting.
 	 */
 	if (current->flags & PF_EXITING)
 		return;
@@ -6455,35 +6442,22 @@ static void perf_sigtrap(struct perf_event *event)
 		      event->attr.type, event->attr.sig_data);
 }
 
-static void perf_pending_event_sigtrap(struct perf_event *event)
+static void perf_pending_event_task_work(struct callback_head *work)
 {
-	if (!event->pending_sigtrap)
-		return;
+	struct perf_event *event = container_of(work, struct perf_event, pending_twork);
+	int rctx;
 
-	/*
-	 * If we're racing with disabling of the event, consume pending_sigtrap
-	 * and don't send the SIGTRAP. This avoids potentially delaying a signal
-	 * indefinitely (oncpu mismatch) until the event is enabled again, which
-	 * could happen after already returning to user space; in that case the
-	 * signal would erroneously become asynchronous.
-	 */
-	if (event->state == PERF_EVENT_STATE_OFF) {
+	preempt_disable_notrace();
+	rctx = perf_swevent_get_recursion_context();
+
+	if (event->pending_sigtrap) {
 		event->pending_sigtrap = 0;
-		return;
+		perf_sigtrap(event);
 	}
 
-	/*
-	 * Only process this pending SIGTRAP if this IRQ work is running on the
-	 * right CPU: the scheduler is able to run before the IRQ work, which
-	 * moved the task to another CPU. In event_sched_in() another IRQ work
-	 * is scheduled, so that the signal is not lost; given the kernel has
-	 * not yet returned to user space, the signal remains synchronous.
-	 */
-	if (READ_ONCE(event->oncpu) != smp_processor_id())
-		return;
-
-	event->pending_sigtrap = 0;
-	perf_sigtrap(event);
+	if (rctx >= 0)
+		perf_swevent_put_recursion_context(rctx);
+	preempt_enable_notrace();
 }
 
 static void perf_pending_event_disable(struct perf_event *event)
@@ -6533,7 +6507,6 @@ static void perf_pending_event(struct irq_work *entry)
 	 * and we won't recurse 'further'.
 	 */
 
-	perf_pending_event_sigtrap(event);
 	perf_pending_event_disable(event);
 
 	if (event->pending_wakeup) {
@@ -6545,26 +6518,6 @@ static void perf_pending_event(struct irq_work *entry)
 		perf_swevent_put_recursion_context(rctx);
 }
 
-/*
- * If handling of a pending action must occur before returning to user space,
- * and it is possible to reschedule an event (to another CPU) with pending
- * actions, where the moved-from CPU may not yet have run event->pending (and
- * irq_work_queue() would fail on reuse), we'll use a separate IRQ work that
- * runs perf_pending_event_resched().
- */
-static void perf_pending_event_resched(struct irq_work *entry)
-{
-	struct perf_event *event = container_of(entry, struct perf_event, pending_resched);
-	int rctx;
-
-	rctx = perf_swevent_get_recursion_context();
-
-	perf_pending_event_sigtrap(event);
-
-	if (rctx >= 0)
-		perf_swevent_put_recursion_context(rctx);
-}
-
 #ifdef CONFIG_GUEST_PERF_EVENTS
 struct perf_guest_info_callbacks __rcu *perf_guest_cbs;
 
@@ -9274,7 +9227,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		WARN_ON_ONCE(event->pending_sigtrap && event->attr.exclude_kernel);
 		event->pending_sigtrap = 1;
 		event->pending_addr = data->addr;
-		irq_work_queue(&event->pending);
+		task_work_add(current, &event->pending_twork, TWA_RESUME);
 	}
 
 	READ_ONCE(event->overflow_handler)(event, data, regs);
@@ -11599,7 +11552,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_waitqueue_head(&event->waitq);
 	event->pending_disable = -1;
 	init_irq_work(&event->pending, perf_pending_event);
-	init_irq_work(&event->pending_resched, perf_pending_event_resched);
+	init_task_work(&event->pending_twork, perf_pending_event_task_work);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
