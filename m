Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CD361E06D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 06:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKFFqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 01:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKFFqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 01:46:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611A47670
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 22:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E30B0B8098D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 05:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843C3C43149;
        Sun,  6 Nov 2022 05:46:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1orYUb-007nCi-0G;
        Sun, 06 Nov 2022 01:46:49 -0400
Message-ID: <20221106054648.917593743@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 06 Nov 2022 01:45:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5a 4/5] timers: Add timer_shutdown_sync() and timer_shutdown() to be called
 before freeing timers
References: <20221106054535.709068702@goodmis.org>
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
Link: https://lore.kernel.org/all/20221105060024.598488967@goodmis.org/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../RCU/Design/Requirements/Requirements.rst  |  2 +-
 Documentation/core-api/local_ops.rst          |  2 +-
 Documentation/kernel-hacking/locking.rst      |  5 ++
 include/linux/timer.h                         | 62 ++++++++++++++++--
 kernel/time/timer.c                           | 64 ++++++++++---------
 5 files changed, 97 insertions(+), 38 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index a0f8164c8513..ec6de88846b9 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any attempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding mod_timer() must be dealt
-with via del_timer_sync() or similar.
+with via timer_shutdown_sync().
 
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke call_rcu(), the callback function is eventually going to be
diff --git a/Documentation/core-api/local_ops.rst b/Documentation/core-api/local_ops.rst
index 2ac3f9f29845..0b42ceaaf3c4 100644
--- a/Documentation/core-api/local_ops.rst
+++ b/Documentation/core-api/local_ops.rst
@@ -191,7 +191,7 @@ Here is a sample module which implements a basic per cpu counter using
 
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            timer_shutdown_sync(&test_timer);
     }
 
     module_init(test_init);
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 6805ae6e86e6..eb341b69fd15 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1009,6 +1009,11 @@ use del_timer_sync() (``include/linux/timer.h``) to
 handle this case. It returns the number of times the timer had to be
 deleted before we finally stopped it from adding itself back in.
 
+Before freeing a timer, timer_shutdown() or timer_shutdown_sync() should be
+called which will keep it from being rearmed, although if it is rearmed, it
+will produce a warning.
+
+
 Locking Speed
 =============
 
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 648f00105f58..0b959b52d0db 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -168,12 +168,45 @@ static inline int timer_pending(const struct timer_list * timer)
 	return !hlist_unhashed_lockless(&timer->entry);
 }
 
+extern int __del_timer(struct timer_list * timer, bool free);
+
 extern void add_timer_on(struct timer_list *timer, int cpu);
-extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
 extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 
+/**
+ * del_timer - deactivate a timer.
+ * @timer: the timer to be deactivated
+ *
+ * del_timer() deactivates a timer - this works on both active and inactive
+ * timers.
+ *
+ * The function returns whether it has deactivated a pending timer or not.
+ * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
+ * active timer returns 1.)
+ */
+static inline int del_timer(struct timer_list *timer)
+{
+	return __del_timer(timer, false);
+}
+
+/**
+ * timer_shutdown - deactivate a timer and shut it down
+ * @timer: the timer to be deactivated
+ *
+ * timer_shutdown() deactivates a timer - this works on both active
+ * and inactive timers, and will prevent it from being rearmed.
+ *
+ * The function returns whether it has deactivated a pending timer or not.
+ * (ie. timer_shutdown() of an inactive timer returns 0,
+ *   timer_shutdown() of an active timer returns 1.)
+ */
+static inline int timer_shutdown(struct timer_list *timer)
+{
+	return __del_timer(timer, true);
+}
+
 /*
  * The jiffies value which is added to now, when there is no timer
  * in the timer wheel:
@@ -183,12 +216,29 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
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
index 717fcb9fb14a..7c224766065e 100644
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
 
@@ -1237,18 +1240,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
 
-/**
- * del_timer - deactivate a timer.
- * @timer: the timer to be deactivated
- *
- * del_timer() deactivates a timer - this works on both active and inactive
- * timers.
- *
- * The function returns whether it has deactivated a pending timer or not.
- * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
- * active timer returns 1.)
- */
-int del_timer(struct timer_list *timer)
+int __del_timer(struct timer_list *timer, bool free)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1259,21 +1251,20 @@ int del_timer(struct timer_list *timer)
 	if (timer_pending(timer)) {
 		base = lock_timer_base(timer, &flags);
 		ret = detach_if_pending(timer, base, true);
+		if (free)
+			timer->function = NULL;
+		raw_spin_unlock_irqrestore(&base->lock, flags);
+	} else if (free) {
+		base = lock_timer_base(timer, &flags);
+		timer->function = NULL;
 		raw_spin_unlock_irqrestore(&base->lock, flags);
 	}
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer);
+EXPORT_SYMBOL(__del_timer);
 
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
@@ -1285,11 +1276,25 @@ int try_to_del_timer_sync(struct timer_list *timer)
 
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
@@ -1365,10 +1370,10 @@ static inline void timer_sync_wait_running(struct timer_base *base) { }
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
@@ -1402,7 +1407,7 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
  *
  * The function returns whether it has deactivated a pending timer or not.
  */
-int del_timer_sync(struct timer_list *timer)
+int __del_timer_sync(struct timer_list *timer, bool free)
 {
 	int ret;
 
@@ -1432,7 +1437,7 @@ int del_timer_sync(struct timer_list *timer)
 		lockdep_assert_preemption_enabled();
 
 	do {
-		ret = try_to_del_timer_sync(timer);
+		ret = __try_to_del_timer_sync(timer, free);
 
 		if (unlikely(ret < 0)) {
 			del_timer_wait_running(timer);
@@ -1442,8 +1447,7 @@ int del_timer_sync(struct timer_list *timer)
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer_sync);
-#endif
+EXPORT_SYMBOL(__del_timer_sync);
 
 static void call_timer_fn(struct timer_list *timer,
 			  void (*fn)(struct timer_list *),
-- 
2.35.1
