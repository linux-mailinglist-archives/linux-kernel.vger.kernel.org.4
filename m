Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7954A623C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiKJGmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiKJGl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:41:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD62180B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 22:41:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 653B2B820DE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A11C4314A;
        Thu, 10 Nov 2022 06:41:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1ot1Fz-009Eg1-2F;
        Thu, 10 Nov 2022 01:41:47 -0500
Message-ID: <20221110064147.529154710@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Nov 2022 01:41:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: [PATCH v6 5/6] timers: Add timer_shutdown() to be called before freeing timers
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

Before a timer is to be freed, it must be shutdown. But there are some
locations were timer_shutdown_sync() can not be called due to the context
the object that holds the timer is in when it is freed.

For cases where the logic should keep the timer from being re-armed but
still needs to be shutdown with a sync, a new API of timer_shutdown() is
available. This is the same as del_timer() except that after it is called,
the timer can not be re-armed. If it is, a WARN_ON_ONCE() will be
triggered.

The implementation of timer_shutdown() follows the timer_shutdown_sync()
method of using the same code as del_timer() but will pass in a boolean
that the timer is about to be freed, in which case the timer->function is
set to NULL, just like timer_shutdown_sync().

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/timer.h | 35 ++++++++++++++++++++++++++++++++++-
 kernel/time/timer.c   | 21 ++++++++-------------
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 4d56e20613eb..0b959b52d0db 100644
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
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 111a3550b3f2..7c224766065e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1240,18 +1240,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
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
@@ -1262,12 +1251,18 @@ int del_timer(struct timer_list *timer)
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
 
 static int __try_to_del_timer_sync(struct timer_list *timer, bool free)
 {
-- 
2.35.1
