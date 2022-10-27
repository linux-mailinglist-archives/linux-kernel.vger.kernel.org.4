Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD260FB8D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiJ0PMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbiJ0PJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:09:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9454918F24A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D54AB826A9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8C6C433D7;
        Thu, 27 Oct 2022 15:09:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oo4Vf-00Bviz-0n;
        Thu, 27 Oct 2022 11:09:31 -0400
Message-ID: <20221027150931.071195430@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:05:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        John Stultz <jstultz@google.com>
Subject: [RFC][PATCH v2 31/31] timers: Expand DEBUG_OBJECTS_TIMER to check if it ever was used
References: <20221027150525.753064657@goodmis.org>
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

Now that del_timer_shutdown() is to be called before freeing, move the
checks of DEBUG_OBJECTS_TIMER to if it ever gets armed to where
del_timer_shutdown() is called. If there's a case where a timer is armed,
and then freed without calling del_timer_shutdown() DEBUG_OBJECTS_TIMER
will now trigger on it.

This catches cases that are potential issues instead of just catching
when the race condition occurs.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/timer.h | 20 ++++++++++++++++++--
 kernel/time/timer.c   | 16 +++++++++++-----
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index daccfe33da42..d4d90149d015 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -18,6 +18,9 @@ struct timer_list {
 	void			(*function)(struct timer_list *);
 	u32			flags;
 
+#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
+	u32			enabled;
+#endif
 #ifdef CONFIG_LOCKDEP
 	struct lockdep_map	lockdep_map;
 #endif
@@ -128,6 +131,19 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 	init_timer_on_stack_key((_timer), (_fn), (_flags), NULL, NULL)
 #endif
 
+#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
+#define __init_timer_debug(_timer, _fn, _flags)				\
+	do {								\
+		(_timer)->enabled = 0;					\
+		__init_timer((_timer), (_fn), (_flags));		\
+	} while (0)
+#else
+#define __init_timer_debug(_timer, _fn, _flags)				\
+	do {								\
+		__init_timer((_timer), (_fn), (_flags));		\
+	} while (0)
+#endif
+
 /**
  * timer_setup - prepare a timer for first use
  * @timer: the timer in question
@@ -139,7 +155,7 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
  * be used and must be balanced with a call to destroy_timer_on_stack().
  */
 #define timer_setup(timer, callback, flags)			\
-	__init_timer((timer), (callback), (flags))
+	__init_timer_debug((timer), (callback), (flags))
 
 #define timer_setup_on_stack(timer, callback, flags)		\
 	__init_timer_on_stack((timer), (callback), (flags))
@@ -207,7 +223,7 @@ static inline int del_timer_shutdown(struct timer_list *timer)
 	return __del_timer_sync(timer, true);
 }
 
-#define del_singleshot_timer_sync(t) del_timer_sync(t)
+#define del_singleshot_timer_sync(t) del_timer_shutdown(t)
 
 extern void init_timers(void);
 struct hrtimer;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 111a3550b3f2..1d17552b3ede 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -774,17 +774,22 @@ static const struct debug_obj_descr timer_debug_descr = {
 
 static inline void debug_timer_init(struct timer_list *timer)
 {
-	debug_object_init(timer, &timer_debug_descr);
+	if (!timer->enabled)
+		debug_object_init(timer, &timer_debug_descr);
 }
 
 static inline void debug_timer_activate(struct timer_list *timer)
 {
-	debug_object_activate(timer, &timer_debug_descr);
+	if (!timer->enabled) {
+		timer->enabled = 1;
+		debug_object_activate(timer, &timer_debug_descr);
+	}
 }
 
 static inline void debug_timer_deactivate(struct timer_list *timer)
 {
-	debug_object_deactivate(timer, &timer_debug_descr);
+	if (timer->enabled)
+		debug_object_deactivate(timer, &timer_debug_descr);
 }
 
 static inline void debug_timer_assert_init(struct timer_list *timer)
@@ -828,7 +833,6 @@ static inline void debug_init(struct timer_list *timer)
 
 static inline void debug_deactivate(struct timer_list *timer)
 {
-	debug_timer_deactivate(timer);
 	trace_timer_cancel(timer);
 }
 
@@ -1281,8 +1285,10 @@ static int __try_to_del_timer_sync(struct timer_list *timer, bool free)
 
 	if (base->running_timer != timer)
 		ret = detach_if_pending(timer, base, true);
-	if (free)
+	if (free) {
 		timer->function = NULL;
+		debug_timer_deactivate(timer);
+	}
 
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 
-- 
2.35.1
