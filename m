Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F167637B41
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKXOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiKXOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:16:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275DFFCDE5;
        Thu, 24 Nov 2022 06:16:12 -0800 (PST)
Date:   Thu, 24 Nov 2022 14:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669299370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0klFvZRzkAzJUNjtkCTAHP2fEhMgrrwQ/1ZeGmyjOro=;
        b=Yjh4QClkCK0amkkUBzueVtbJDNV5U3SzjCCPDLcL7ZfEbs3iZgt4QmNnDSuYn5QR6NOxr2
        9BOK3qVTB23eMsKZODfbgmv4p7w1PYT25CvChLoZJ2+Tc5nU0y4r2tGxG4UO5lIU5UaJIb
        6EEse4d3qSB8lBzDs59qMLLw7ATOEqA0GqM+bDAs2kNu+Kps8KkR75YG7yNGIHvPqPukPi
        W5CUJkPbr63o/DqQNHPNfuMYvZ4yhcvpePEJrnhYy0rwRd0zeAZrO9wzPEE6ob6AkYyEQ7
        c491EEXvi2+o44gAWBiOBDWj1zMVEVXC+MK4/rR+ci0GPOGRR0KBKd2DqaVuPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669299370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0klFvZRzkAzJUNjtkCTAHP2fEhMgrrwQ/1ZeGmyjOro=;
        b=3YT4sSUs42u34OkMJSWEWL8oQIq4+V5EbcHdTIVyyOYDyZNJLNiMAbsRlX/z1xoTlx3MUf
        BfNsk3C0QxcicMDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Rename del_timer_sync() to timer_delete_sync()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221123201624.954785441@linutronix.de>
References: <20221123201624.954785441@linutronix.de>
MIME-Version: 1.0
Message-ID: <166929936893.4906.6484824433900031971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9b13df3fb64ee95e2397585404e442afee2c7d4f
Gitweb:        https://git.kernel.org/tip/9b13df3fb64ee95e2397585404e442afee2c7d4f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Nov 2022 21:18:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Nov 2022 15:09:11 +01:00

timers: Rename del_timer_sync() to timer_delete_sync()

The timer related functions do not have a strict timer_ prefixed namespace
which is really annoying.

Rename del_timer_sync() to timer_delete_sync() and provide del_timer_sync()
as a wrapper. Document that del_timer_sync() is not for new code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201624.954785441@linutronix.de

---
 include/linux/timer.h | 15 ++++++++++++++-
 kernel/time/timer.c   | 18 +++++++++---------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 31b8b60..551fa46 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -183,7 +183,20 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 extern void add_timer(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
-extern int del_timer_sync(struct timer_list *timer);
+extern int timer_delete_sync(struct timer_list *timer);
+
+/**
+ * del_timer_sync - Delete a pending timer and wait for a running callback
+ * @timer:	The timer to be deleted
+ *
+ * See timer_delete_sync() for detailed explanation.
+ *
+ * Do not use in new code. Use timer_delete_sync() instead.
+ */
+static inline int del_timer_sync(struct timer_list *timer)
+{
+	return timer_delete_sync(timer);
+}
 
 extern void init_timers(void);
 struct hrtimer;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 550f0df..60e538b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1083,7 +1083,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 		/*
 		 * We are trying to schedule the timer on the new base.
 		 * However we can't change timer's base while it is running,
-		 * otherwise del_timer_sync() can't detect that the timer's
+		 * otherwise timer_delete_sync() can't detect that the timer's
 		 * handler yet has not finished. This also guarantees that the
 		 * timer is serialized wrt itself.
 		 */
@@ -1261,7 +1261,7 @@ EXPORT_SYMBOL_GPL(add_timer_on);
  * @timer:	The timer to be deactivated
  *
  * The function only deactivates a pending timer, but contrary to
- * del_timer_sync() it does not take into account whether the timer's
+ * timer_delete_sync() it does not take into account whether the timer's
  * callback function is concurrently executed on a different CPU or not.
  * It neither prevents rearming of the timer. If @timer can be rearmed
  * concurrently then the return value of this function is meaningless.
@@ -1397,7 +1397,7 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
 #endif
 
 /**
- * del_timer_sync - Deactivate a timer and wait for the handler to finish.
+ * timer_delete_sync - Deactivate a timer and wait for the handler to finish.
  * @timer:	The timer to be deactivated
  *
  * Synchronization rules: Callers must prevent restarting of the timer,
@@ -1419,10 +1419,10 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
  *    spin_lock_irq(somelock);
  *                                     <IRQ>
  *                                        spin_lock(somelock);
- *    del_timer_sync(mytimer);
+ *    timer_delete_sync(mytimer);
  *    while (base->running_timer == mytimer);
  *
- * Now del_timer_sync() will never return and never release somelock.
+ * Now timer_delete_sync() will never return and never release somelock.
  * The interrupt on the other CPU is waiting to grab somelock but it has
  * interrupted the softirq that CPU0 is waiting to finish.
  *
@@ -1435,7 +1435,7 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
  * * %0	- The timer was not pending
  * * %1	- The timer was pending and deactivated
  */
-int del_timer_sync(struct timer_list *timer)
+int timer_delete_sync(struct timer_list *timer)
 {
 	int ret;
 
@@ -1475,7 +1475,7 @@ int del_timer_sync(struct timer_list *timer)
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer_sync);
+EXPORT_SYMBOL(timer_delete_sync);
 
 static void call_timer_fn(struct timer_list *timer,
 			  void (*fn)(struct timer_list *),
@@ -1497,8 +1497,8 @@ static void call_timer_fn(struct timer_list *timer,
 #endif
 	/*
 	 * Couple the lock chain with the lock chain at
-	 * del_timer_sync() by acquiring the lock_map around the fn()
-	 * call here and in del_timer_sync().
+	 * timer_delete_sync() by acquiring the lock_map around the fn()
+	 * call here and in timer_delete_sync().
 	 */
 	lock_map_acquire(&lockdep_map);
 
