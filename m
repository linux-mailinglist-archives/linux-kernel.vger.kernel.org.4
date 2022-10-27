Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32DF60FB61
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiJ0PJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiJ0PJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:09:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458A618F251
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0717B826AA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C9BC433D7;
        Thu, 27 Oct 2022 15:09:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oo4VZ-00BvS7-1L;
        Thu, 27 Oct 2022 11:09:25 -0400
Message-ID: <20221027150925.248421571@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:05:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC][PATCH v2 01/31] timers: Add del_timer_shutdown() to be called before freeing timers
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

We are hitting a common bug were a timer is being triggered after it is
freed. This causes a corruption in the timer link list and crashes the
kernel. Unfortunately it is not easy to know what timer it was that was
freed. Looking at the code, it appears that there are several cases that
del_timer() is used when del_timer_sync() should have been.

Add a del_timer_shutdown() that not only does a del_timer_sync() but will mark
the timer as terminated in case it gets rearmed, it will trigger a WARN_ON. The
del_timer_shutdown() is more likely to be used by developers that are about to
free a timer, then using del_timer_sync() as the latter is not as obvious
to being needed for freeing. Having the word "shutdown" in the name of the
function will hopefully help developers know that that function needs to
be called before freeing.

The added bonus is the marking of the timer as being freed such that it
will trigger a warning if it gets rearmed. At least that way if the system
crashes on a freed timer, at least we may see which timer it was that was
freed.

This code is taken from Thomas Gleixner's "untested" version from my
original patch and modified after testing and with some other comments
from Linus addressed. As well as some extra comments added.

Link: https://lore.kernel.org/all/87pmlrkgi3.ffs@tglx/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../RCU/Design/Requirements/Requirements.rst  |  2 +-
 Documentation/core-api/local_ops.rst          |  2 +-
 Documentation/kernel-hacking/locking.rst      |  4 ++
 include/linux/timer.h                         | 27 +++++++++---
 kernel/time/timer.c                           | 43 +++++++++++--------
 5 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index a0f8164c8513..5c27f94a4fc2 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any attempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding mod_timer() must be dealt
-with via del_timer_sync() or similar.
+with via del_timer_shutdown().
 
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke call_rcu(), the callback function is eventually going to be
diff --git a/Documentation/core-api/local_ops.rst b/Documentation/core-api/local_ops.rst
index 2ac3f9f29845..a3a63cd57006 100644
--- a/Documentation/core-api/local_ops.rst
+++ b/Documentation/core-api/local_ops.rst
@@ -191,7 +191,7 @@ Here is a sample module which implements a basic per cpu counter using
 
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            del_timer_shutdown(&test_timer);
     }
 
     module_init(test_init);
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 6805ae6e86e6..c8b852ab8214 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1009,6 +1009,10 @@ use del_timer_sync() (``include/linux/timer.h``) to
 handle this case. It returns the number of times the timer had to be
 deleted before we finally stopped it from adding itself back in.
 
+Before freeing a timer, del_timer_shutdown() shoud be called which will keep
+it from being rearmed, although if it is rearmed, it will produce a warning.
+
+
 Locking Speed
 =============
 
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 648f00105f58..daccfe33da42 100644
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
+ * del_timer_shutdown - called before freeing the timer
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
+static inline int del_timer_shutdown(struct timer_list *timer)
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
