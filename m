Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488E2619070
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiKDFuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiKDFsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:48:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786DF28E11
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 22:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF63F620D4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:48:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8837EC43144;
        Fri,  4 Nov 2022 05:48:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oqpZu-0071GP-0E;
        Fri, 04 Nov 2022 01:49:18 -0400
Message-ID: <20221104054917.915205356@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 04 Nov 2022 01:41:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <jstultz@google.com>
Subject: [RFC][PATCH v3 33/33] timers: Expand DEBUG_OBJECTS_TIMER to check if it ever was used
References: <20221104054053.431922658@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There's been too many bugs happening where a timer is removed, either by
del_timer() or even del_timer_sync() but get's re-armed again by a
workqueue or some other task. Then the timer is freed while it's still
queued to go off. When the timer eventually goes off, as its content no
longer exists, it causes a crash in the timer code.

This is very hard to debug because all evidence of who added the timer is
gone.

Currently, DEBUG_OBJECTS_TIMER will trigger if this happens, but as this
only happens rarely (but in the field, thousands of times) and may depend
on performing various tasks (USB unplug, CPU hotplug, suspend and resume),
not to mention that enabling DEBUG_OBJECTS_TIMER has too much overhead to
run in the field, it seldom catches these types of bugs.

Now that timer_shutdown_sync() is to be called before freeing, move the
checks of DEBUG_OBJECTS_TIMER to if it ever gets armed to where
timer_shutdown_sync() is called. If there's a case where a timer is armed,
and then freed without calling timer_shutdown_sync() DEBUG_OBJECTS_TIMER
will now trigger on it.

This catches cases that are potential issues instead of just catching
when the race condition occurs.

Note, due to delayed workqueues that use timers but they themselves do not
supply a shutdown method, there's no way to be able to call
timer_shutdown() on delayed work timers correctly. Because of this, the
delayed work timers will add a state to inform the DEBUG_OBJECTS_TIMER
code that its a timer for a delayed work. The delayed work timers will be
treated the old way of only trigging an issue if its timer is active when
freed, but does not need to be shutdown first.

Work may be needed to make workqueue code also have a shutdown state.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/timer.h     | 36 +++++++++++++++++++++++++++++-
 include/linux/workqueue.h |  4 ++--
 kernel/time/timer.c       | 46 +++++++++++++++++++++++++++++++++------
 3 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 0758b447afd7..ab6148db289e 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -8,6 +8,12 @@
 #include <linux/debugobjects.h>
 #include <linux/stringify.h>
 
+enum timer_debug_state {
+	TIMER_DEBUG_DISABLED,
+	TIMER_DEBUG_ENABLED,
+	TIMER_DEBUG_WORK,
+};
+
 struct timer_list {
 	/*
 	 * All fields that change during normal runtime grouped to the
@@ -18,6 +24,9 @@ struct timer_list {
 	void			(*function)(struct timer_list *);
 	u32			flags;
 
+#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
+	enum timer_debug_state	enabled;
+#endif
 #ifdef CONFIG_LOCKDEP
 	struct lockdep_map	lockdep_map;
 #endif
@@ -128,6 +137,31 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 	init_timer_on_stack_key((_timer), (_fn), (_flags), NULL, NULL)
 #endif
 
+#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
+#define __init_timer_debug(_timer, _fn, _flags)				\
+	do {								\
+		(_timer)->enabled = TIMER_DEBUG_DISABLED;		\
+		__init_timer((_timer), (_fn), (_flags));		\
+	} while (0)
+#define __init_timer_work(_timer, _fn, _flags)				\
+	do {								\
+		(_timer)->enabled = TIMER_DEBUG_WORK;			\
+		__init_timer((_timer), (_fn), (_flags));		\
+	} while (0)
+#define __init_timer_work_on_stack(_timer, _fn, _flags)				\
+	do {								\
+		(_timer)->enabled = TIMER_DEBUG_WORK;			\
+		__init_timer_on_stack((_timer), (_fn), (_flags));	\
+	} while (0)
+#else
+#define __init_timer_debug(_timer, _fn, _flags)				\
+	__init_timer((_timer), (_fn), (_flags))
+#define __init_timer_work(_timer, _fn, _flags)				\
+	__init_timer((_timer), (_fn), (_flags))
+#define __init_timer_work_on_stack(_timer, _fn, _flags)			\
+	__init_timer_on_stack((_timer), (_fn), (_flags))
+#endif
+
 /**
  * timer_setup - prepare a timer for first use
  * @timer: the timer in question
@@ -139,7 +173,7 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
  * be used and must be balanced with a call to destroy_timer_on_stack().
  */
 #define timer_setup(timer, callback, flags)			\
-	__init_timer((timer), (callback), (flags))
+	__init_timer_debug((timer), (callback), (flags))
 
 #define timer_setup_on_stack(timer, callback, flags)		\
 	__init_timer_on_stack((timer), (callback), (flags))
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a0143dd24430..290c96429ce1 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -250,7 +250,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 #define __INIT_DELAYED_WORK(_work, _func, _tflags)			\
 	do {								\
 		INIT_WORK(&(_work)->work, (_func));			\
-		__init_timer(&(_work)->timer,				\
+		__init_timer_work(&(_work)->timer,			\
 			     delayed_work_timer_fn,			\
 			     (_tflags) | TIMER_IRQSAFE);		\
 	} while (0)
@@ -258,7 +258,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 #define __INIT_DELAYED_WORK_ONSTACK(_work, _func, _tflags)		\
 	do {								\
 		INIT_WORK_ONSTACK(&(_work)->work, (_func));		\
-		__init_timer_on_stack(&(_work)->timer,			\
+		__init_timer_work_on_stack(&(_work)->timer,		\
 				      delayed_work_timer_fn,		\
 				      (_tflags) | TIMER_IRQSAFE);	\
 	} while (0)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 7c224766065e..7596396ce1f6 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -691,7 +691,10 @@ static bool timer_fixup_init(void *addr, enum debug_obj_state state)
 
 	switch (state) {
 	case ODEBUG_STATE_ACTIVE:
-		del_timer_sync(timer);
+		/* Force the debug deactivate code */
+		if (timer->enabled != TIMER_DEBUG_WORK)
+			timer->enabled = TIMER_DEBUG_ENABLED;
+		timer_shutdown_sync(timer);
 		debug_object_init(timer, &timer_debug_descr);
 		return true;
 	default:
@@ -737,7 +740,7 @@ static bool timer_fixup_free(void *addr, enum debug_obj_state state)
 
 	switch (state) {
 	case ODEBUG_STATE_ACTIVE:
-		del_timer_sync(timer);
+		timer_shutdown_sync(timer);
 		debug_object_free(timer, &timer_debug_descr);
 		return true;
 	default:
@@ -774,16 +777,40 @@ static const struct debug_obj_descr timer_debug_descr = {
 
 static inline void debug_timer_init(struct timer_list *timer)
 {
+	/* Only need to call debug_object_init once if not a work timer */
+	if (timer->enabled == TIMER_DEBUG_ENABLED)
+		return;
+
 	debug_object_init(timer, &timer_debug_descr);
 }
 
 static inline void debug_timer_activate(struct timer_list *timer)
 {
+	/* Only call debug_timer_activate once if not a work timer */
+	if (timer->enabled == TIMER_DEBUG_ENABLED)
+		return;
+
+	if (timer->enabled == TIMER_DEBUG_DISABLED)
+		timer->enabled = TIMER_DEBUG_ENABLED;
+
 	debug_object_activate(timer, &timer_debug_descr);
 }
 
-static inline void debug_timer_deactivate(struct timer_list *timer)
+static inline void debug_timer_deactivate(struct timer_list *timer, bool free)
 {
+	switch (timer->enabled) {
+	case TIMER_DEBUG_DISABLED:
+		/* Already disabled, nothing to do */
+		return;
+	case TIMER_DEBUG_ENABLED:
+		/* free is true when shutting down the timer */
+		if (!free)
+			return;
+		timer->enabled = TIMER_DEBUG_DISABLED;
+		break;
+	case TIMER_DEBUG_WORK:
+		break;
+	}
 	debug_object_deactivate(timer, &timer_debug_descr);
 }
 
@@ -816,7 +843,7 @@ EXPORT_SYMBOL_GPL(destroy_timer_on_stack);
 #else
 static inline void debug_timer_init(struct timer_list *timer) { }
 static inline void debug_timer_activate(struct timer_list *timer) { }
-static inline void debug_timer_deactivate(struct timer_list *timer) { }
+static inline void debug_timer_deactivate(struct timer_list *timer, bool free) { }
 static inline void debug_timer_assert_init(struct timer_list *timer) { }
 #endif
 
@@ -828,7 +855,7 @@ static inline void debug_init(struct timer_list *timer)
 
 static inline void debug_deactivate(struct timer_list *timer)
 {
-	debug_timer_deactivate(timer);
+	debug_timer_deactivate(timer, false);
 	trace_timer_cancel(timer);
 }
 
@@ -1251,12 +1278,15 @@ int __del_timer(struct timer_list *timer, bool free)
 	if (timer_pending(timer)) {
 		base = lock_timer_base(timer, &flags);
 		ret = detach_if_pending(timer, base, true);
-		if (free)
+		if (free) {
 			timer->function = NULL;
+			debug_timer_deactivate(timer, true);
+		}
 		raw_spin_unlock_irqrestore(&base->lock, flags);
 	} else if (free) {
 		base = lock_timer_base(timer, &flags);
 		timer->function = NULL;
+		debug_timer_deactivate(timer, true);
 		raw_spin_unlock_irqrestore(&base->lock, flags);
 	}
 
@@ -1276,8 +1306,10 @@ static int __try_to_del_timer_sync(struct timer_list *timer, bool free)
 
 	if (base->running_timer != timer)
 		ret = detach_if_pending(timer, base, true);
-	if (free)
+	if (free) {
 		timer->function = NULL;
+		debug_timer_deactivate(timer, true);
+	}
 
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 
-- 
2.35.1
