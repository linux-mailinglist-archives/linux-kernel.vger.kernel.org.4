Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED26637B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKXOQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKXOQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:16:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808B3E1BFE;
        Thu, 24 Nov 2022 06:16:04 -0800 (PST)
Date:   Thu, 24 Nov 2022 14:16:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669299362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jstBFKJYrlKM5IBe+Kd8tSZGsiZAFSxp+NsE8vYs0tc=;
        b=gurjz5rYkmkxuGvV5rRuPbS/ebQTOw6pNJruzcV1BofU8UzcfxwEJ8sGmde4VSEzyFvcn1
        RUdSCB6yAx60u3YD3bz1f/9ZqrqI9M7DYswS7apdXzUs1DwQf+xK+OE1jYV9XEI3Y3vQCg
        bG+KnyT/Xd9yOa0lImaHJARwjpsnRhMeaY70yJ8VPNMRT6yR0fkllsxL5NZ9o4n2wOFPaq
        q24uPh6DkDKSdJ1AnDAqDYkt/S1LdJSG8uj0h6E6s/O9MPv/wQuvj6jSwhsLJHoixvzmQK
        tZicrfRQUJjgRYrVNnSoT7SXUvFVpuj6R8z9ZCeH18e/iQ2Tnc1CPQ/KhAuX0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669299362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jstBFKJYrlKM5IBe+Kd8tSZGsiZAFSxp+NsE8vYs0tc=;
        b=4p6Rxp5QwfACcyPwxwZANRvsExcBvJy82+Z0tsVf44VwGuMSui3Qehh8818iuGvk/XEu70
        bPewQ0iA5eQ0jOCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Provide timer_shutdown[_sync]()
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220407161745.7d6754b3@gandalf.local.home>
References: <20220407161745.7d6754b3@gandalf.local.home>
MIME-Version: 1.0
Message-ID: <166929936145.4906.16764857196527632817.tip-bot2@tip-bot2>
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

Commit-ID:     f571faf6e443b6011ccb585d57866177af1f643c
Gitweb:        https://git.kernel.org/tip/f571faf6e443b6011ccb585d57866177af1f643c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Nov 2022 21:18:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Nov 2022 15:09:12 +01:00

timers: Provide timer_shutdown[_sync]()

Tearing down timers which have circular dependencies to other
functionality, e.g. workqueues, where the timer can schedule work and work
can arm timers, is not trivial.

In those cases it is desired to shutdown the timer in a way which prevents
rearming of the timer. The mechanism to do so is to set timer->function to
NULL and use this as an indicator for the timer arming functions to ignore
the (re)arm request.

Expose new interfaces for this: timer_shutdown_sync() and timer_shutdown().

timer_shutdown_sync() has the same functionality as timer_delete_sync()
plus the NULL-ification of the timer function.

timer_shutdown() has the same functionality as timer_delete() plus the
NULL-ification of the timer function.

In both cases the rearming of the timer is prevented by silently discarding
rearm attempts due to timer->function being NULL.

Co-developed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home
Link: https://lore.kernel.org/all/20221110064101.429013735@goodmis.org
Link: https://lore.kernel.org/r/20221123201625.314230270@linutronix.de

---
 include/linux/timer.h |  2 +-
 kernel/time/timer.c   | 66 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index e338e17..9162f27 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -184,6 +184,8 @@ extern void add_timer(struct timer_list *timer);
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
 extern int timer_delete(struct timer_list *timer);
+extern int timer_shutdown_sync(struct timer_list *timer);
+extern int timer_shutdown(struct timer_list *timer);
 
 /**
  * del_timer_sync - Delete a pending timer and wait for a running callback
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 167e43c..63a8ce7 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1363,6 +1363,27 @@ int timer_delete(struct timer_list *timer)
 EXPORT_SYMBOL(timer_delete);
 
 /**
+ * timer_shutdown - Deactivate a timer and prevent rearming
+ * @timer:	The timer to be deactivated
+ *
+ * The function does not wait for an eventually running timer callback on a
+ * different CPU but it prevents rearming of the timer. Any attempt to arm
+ * @timer after this function returns will be silently ignored.
+ *
+ * This function is useful for teardown code and should only be used when
+ * timer_shutdown_sync() cannot be invoked due to locking or context constraints.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending
+ */
+int timer_shutdown(struct timer_list *timer)
+{
+	return __timer_delete(timer, true);
+}
+EXPORT_SYMBOL_GPL(timer_shutdown);
+
+/**
  * __try_to_del_timer_sync - Internal function: Try to deactivate a timer
  * @timer:	Timer to deactivate
  * @shutdown:	If true, this indicates that the timer is about to be
@@ -1595,6 +1616,9 @@ static int __timer_delete_sync(struct timer_list *timer, bool shutdown)
  * lock. If there is the possibility of a concurrent rearm then the return
  * value of the function is meaningless.
  *
+ * If such a guarantee is needed, e.g. for teardown situations then use
+ * timer_shutdown_sync() instead.
+ *
  * Return:
  * * %0	- The timer was not pending
  * * %1	- The timer was pending and deactivated
@@ -1605,6 +1629,48 @@ int timer_delete_sync(struct timer_list *timer)
 }
 EXPORT_SYMBOL(timer_delete_sync);
 
+/**
+ * timer_shutdown_sync - Shutdown a timer and prevent rearming
+ * @timer: The timer to be shutdown
+ *
+ * When the function returns it is guaranteed that:
+ *   - @timer is not queued
+ *   - The callback function of @timer is not running
+ *   - @timer cannot be enqueued again. Any attempt to rearm
+ *     @timer is silently ignored.
+ *
+ * See timer_delete_sync() for synchronization rules.
+ *
+ * This function is useful for final teardown of an infrastructure where
+ * the timer is subject to a circular dependency problem.
+ *
+ * A common pattern for this is a timer and a workqueue where the timer can
+ * schedule work and work can arm the timer. On shutdown the workqueue must
+ * be destroyed and the timer must be prevented from rearming. Unless the
+ * code has conditionals like 'if (mything->in_shutdown)' to prevent that
+ * there is no way to get this correct with timer_delete_sync().
+ *
+ * timer_shutdown_sync() is solving the problem. The correct ordering of
+ * calls in this case is:
+ *
+ *	timer_shutdown_sync(&mything->timer);
+ *	workqueue_destroy(&mything->workqueue);
+ *
+ * After this 'mything' can be safely freed.
+ *
+ * This obviously implies that the timer is not required to be functional
+ * for the rest of the shutdown operation.
+ *
+ * Return:
+ * * %0 - The timer was not pending
+ * * %1 - The timer was pending
+ */
+int timer_shutdown_sync(struct timer_list *timer)
+{
+	return __timer_delete_sync(timer, true);
+}
+EXPORT_SYMBOL_GPL(timer_shutdown_sync);
+
 static void call_timer_fn(struct timer_list *timer,
 			  void (*fn)(struct timer_list *),
 			  unsigned long baseclk)
