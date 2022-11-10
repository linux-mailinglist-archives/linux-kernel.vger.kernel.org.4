Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A3623C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiKJGl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiKJGl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:41:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B812E2EF72
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 22:41:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A102B820DF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7C9C43147;
        Thu, 10 Nov 2022 06:41:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1ot1Fz-009EfT-1e;
        Thu, 10 Nov 2022 01:41:47 -0500
Message-ID: <20221110064147.343514404@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Nov 2022 01:41:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called before freeing timers
References: <20221110064101.429013735@goodmis.org>
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

We are hitting a common bug were a timer is being triggered after it is
freed. This causes a corruption in the timer link list and crashes the
kernel. Unfortunately it is not easy to know what timer it was that was
freed. Looking at the code, it appears that there are several cases that
del_timer() is used when del_timer_sync() should have been.

Add a timer_shutdown_sync() that not only does a del_timer_sync() but will mark
the timer as terminated in case it gets rearmed, it will trigger a WARN_ON. The
timer_shutdown_sync() is more likely to be used by developers that are about to
free a timer, then using del_timer_sync() as the latter is not as obvious
to being needed for freeing. Having the word "shutdown" in the name of the
function will hopefully help developers know that that function needs to
be called before freeing.

The added bonus is the marking of the timer as being freed such that it
will trigger a warning if it gets rearmed. At least that way if the system
crashes on a freed timer, at least we may see which timer it was that was
freed.

There's some situations that already know that the timer is shutdown and
does not need to perform the synchronization (or can not due to its
context). For these locations there's timer_shutdown() that only shuts
down the timer (prevents it from being rearmed) but does not add checks if
the timer is currently running.

This code is taken from Thomas Gleixner's "untested" version from my
original patch and modified after testing and with some other comments
from Linus addressed. As well as some extra comments added.

Link: https://lore.kernel.org/all/87pmlrkgi3.ffs@tglx/
Link: https://lkml.kernel.org/r/20221106212702.363575800@goodmis.org
Link: https://lore.kernel.org/all/20221105060024.598488967@goodmis.org/

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/timer.h | 27 ++++++++++++++++++++++-----
 kernel/time/timer.c   | 43 ++++++++++++++++++++++++++-----------------
 2 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 648f00105f58..4d56e20613eb 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -183,12 +183,29 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 extern void add_timer(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
+extern int __del_timer_sync(struct timer_list *timer, bool free);
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
-  extern int del_timer_sync(struct timer_list *timer);
-#else
-# define del_timer_sync(t)		del_timer(t)
-#endif
+static inline int del_timer_sync(struct timer_list *timer)
+{
+	return __del_timer_sync(timer, false);
+}
+
+/**
+ * timer_shutdown_sync - called before freeing the timer
+ * @timer: The timer to be freed
+ *
+ * Shutdown the timer before freeing. This will return when all pending timers
+ * have finished and it is safe to free the timer.
+ *
+ * Note, after calling this, if the timer is added back to the queue
+ * it will fail to be added and a WARNING will be triggered.
+ *
+ * Returns if it deactivated a pending timer or not.
+ */
+static inline int timer_shutdown_sync(struct timer_list *timer)
+{
+	return __del_timer_sync(timer, true);
+}
 
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14a..111a3550b3f2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1017,7 +1017,8 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	unsigned int idx = UINT_MAX;
 	int ret = 0;
 
-	BUG_ON(!timer->function);
+	if (WARN_ON_ONCE(!timer->function))
+		return -EINVAL;
 
 	/*
 	 * This is a common optimization triggered by the networking code - if
@@ -1193,7 +1194,8 @@ EXPORT_SYMBOL(timer_reduce);
  */
 void add_timer(struct timer_list *timer)
 {
-	BUG_ON(timer_pending(timer));
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
 	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
 }
 EXPORT_SYMBOL(add_timer);
@@ -1210,7 +1212,8 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	struct timer_base *new_base, *base;
 	unsigned long flags;
 
-	BUG_ON(timer_pending(timer) || !timer->function);
+	if (WARN_ON_ONCE(timer_pending(timer) || !timer->function))
+		return;
 
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
@@ -1266,14 +1269,7 @@ int del_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(del_timer);
 
-/**
- * try_to_del_timer_sync - Try to deactivate a timer
- * @timer: timer to delete
- *
- * This function tries to deactivate a timer. Upon successful (ret >= 0)
- * exit the timer is not queued and the handler is not running on any CPU.
- */
-int try_to_del_timer_sync(struct timer_list *timer)
+static int __try_to_del_timer_sync(struct timer_list *timer, bool free)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1285,11 +1281,25 @@ int try_to_del_timer_sync(struct timer_list *timer)
 
 	if (base->running_timer != timer)
 		ret = detach_if_pending(timer, base, true);
+	if (free)
+		timer->function = NULL;
 
 	raw_spin_unlock_irqrestore(&base->lock, flags);
 
 	return ret;
 }
+
+/**
+ * try_to_del_timer_sync - Try to deactivate a timer
+ * @timer: timer to delete
+ *
+ * This function tries to deactivate a timer. Upon successful (ret >= 0)
+ * exit the timer is not queued and the handler is not running on any CPU.
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
+{
+	return __try_to_del_timer_sync(timer, false);
+}
 EXPORT_SYMBOL(try_to_del_timer_sync);
 
 #ifdef CONFIG_PREEMPT_RT
@@ -1365,10 +1375,10 @@ static inline void timer_sync_wait_running(struct timer_base *base) { }
 static inline void del_timer_wait_running(struct timer_list *timer) { }
 #endif
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /**
- * del_timer_sync - deactivate a timer and wait for the handler to finish.
+ * __del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
+ * @free: Set to true if the timer is about to be freed
  *
  * This function only differs from del_timer() on SMP: besides deactivating
  * the timer it also makes sure the handler has finished executing on other
@@ -1402,7 +1412,7 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
  *
  * The function returns whether it has deactivated a pending timer or not.
  */
-int del_timer_sync(struct timer_list *timer)
+int __del_timer_sync(struct timer_list *timer, bool free)
 {
 	int ret;
 
@@ -1432,7 +1442,7 @@ int del_timer_sync(struct timer_list *timer)
 		lockdep_assert_preemption_enabled();
 
 	do {
-		ret = try_to_del_timer_sync(timer);
+		ret = __try_to_del_timer_sync(timer, free);
 
 		if (unlikely(ret < 0)) {
 			del_timer_wait_running(timer);
@@ -1442,8 +1452,7 @@ int del_timer_sync(struct timer_list *timer)
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer_sync);
-#endif
+EXPORT_SYMBOL(__del_timer_sync);
 
 static void call_timer_fn(struct timer_list *timer,
 			  void (*fn)(struct timer_list *),
-- 
2.35.1
