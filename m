Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6FB637B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiKXOQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiKXOQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:16:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C42AFAE95;
        Thu, 24 Nov 2022 06:16:10 -0800 (PST)
Date:   Thu, 24 Nov 2022 14:16:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669299369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKe3v4JszgCQ32pHwFuEInMTWfs+D+9U/NSl7wN3OH0=;
        b=t+cjCLfBaVCwZEGPC+VYrmDgIEod64heVUR8p4uihLj4uOZTf61DVqgbWvSDP+l5kCdNpY
        N0N6QRBmwNodPObpaL8z5P4uKwuIUvNa713eLRLKUSpJ26lsRUEmqkqYW8l4OSV+BAe+9/
        NujHmEbmnF1j7QHkDPA47W48AuZWI1WwZ4SZcYAH0PmmFDqy9YTRr9vFtS6ideX5Kq24Ex
        kuihaof0GfXtN8LLgUav7yVv2+GxlnwFwBfa1vWYzSI982QYpHbV1EW3ugMQ+DlmhXvR1j
        uKGpH2VJrbIWki5/R4Xncx3VxsfUmSNeTN8656G7O5YKzQxO+e/Ebht7aKiDSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669299369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKe3v4JszgCQ32pHwFuEInMTWfs+D+9U/NSl7wN3OH0=;
        b=SEDoo0zrwXSQVuU11b40qbdRI5ph57LpaMSzU43ILszkb6oTuu12CeHfFYT6vFLznixKL1
        RwCkFh7wGX2UGgDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Rename del_timer() to timer_delete()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221123201625.015535022@linutronix.de>
References: <20221123201625.015535022@linutronix.de>
MIME-Version: 1.0
Message-ID: <166929936781.4906.3245899515108947174.tip-bot2@tip-bot2>
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

Commit-ID:     bb663f0f3c396c6d05f6c5eeeea96ced20ff112e
Gitweb:        https://git.kernel.org/tip/bb663f0f3c396c6d05f6c5eeeea96ced20ff112e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Nov 2022 21:18:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Nov 2022 15:09:11 +01:00

timers: Rename del_timer() to timer_delete()

The timer related functions do not have a strict timer_ prefixed namespace
which is really annoying.

Rename del_timer() to timer_delete() and provide del_timer()
as a wrapper. Document that del_timer() is not for new code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201625.015535022@linutronix.de

---
 include/linux/timer.h | 15 ++++++++++++++-
 kernel/time/timer.c   |  6 +++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 551fa46..e338e17 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -169,7 +169,6 @@ static inline int timer_pending(const struct timer_list * timer)
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
-extern int del_timer(struct timer_list * timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
 extern int timer_reduce(struct timer_list *timer, unsigned long expires);
@@ -184,6 +183,7 @@ extern void add_timer(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
+extern int timer_delete(struct timer_list *timer);
 
 /**
  * del_timer_sync - Delete a pending timer and wait for a running callback
@@ -198,6 +198,19 @@ static inline int del_timer_sync(struct timer_list *timer)
 	return timer_delete_sync(timer);
 }
 
+/**
+ * del_timer - Delete a pending timer
+ * @timer:	The timer to be deleted
+ *
+ * See timer_delete() for detailed explanation.
+ *
+ * Do not use in new code. Use timer_delete() instead.
+ */
+static inline int del_timer(struct timer_list *timer)
+{
+	return timer_delete(timer);
+}
+
 extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 60e538b..2b5e8c2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1257,7 +1257,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 EXPORT_SYMBOL_GPL(add_timer_on);
 
 /**
- * del_timer - Deactivate a timer.
+ * timer_delete - Deactivate a timer
  * @timer:	The timer to be deactivated
  *
  * The function only deactivates a pending timer, but contrary to
@@ -1270,7 +1270,7 @@ EXPORT_SYMBOL_GPL(add_timer_on);
  * * %0 - The timer was not pending
  * * %1 - The timer was pending and deactivated
  */
-int del_timer(struct timer_list *timer)
+int timer_delete(struct timer_list *timer)
 {
 	struct timer_base *base;
 	unsigned long flags;
@@ -1286,7 +1286,7 @@ int del_timer(struct timer_list *timer)
 
 	return ret;
 }
-EXPORT_SYMBOL(del_timer);
+EXPORT_SYMBOL(timer_delete);
 
 /**
  * try_to_del_timer_sync - Try to deactivate a timer
