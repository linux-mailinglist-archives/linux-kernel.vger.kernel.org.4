Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9237E74D80D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjGJNpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjGJNpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:45:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D9CEB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:45:29 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688996728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XsZWA8451BPr7/Ud83/6VPIROKIK25FqP0KDzoKAhWM=;
        b=Mw3dc/a9jAPsfBXa5qx/sQ5RoWbHUyxm3PcE/jk9l4Jo81VrtkX8XspuI6hcpszFAEY5IT
        uWaMvEh8eMn+5FyYnmuWegEPDM0S1yEO72QKpIg68GB5/MpCav+/158g+K8s4LCqh71bYm
        BM+8Xzl+2M/ir2jlCOGc1nCwz/YvZOT73up0J2r7Opkeloi4xQJn/AYMBzKyaA3z3ycdXg
        JiI0uQftmXA3T79fPU3qrC4zpi/2GOjsfc4ckoFXbfCKUkQq8fWj5ZJheGPmCM2zQK25wB
        Z8GzftlQYR46pfqzfPYmvChFata0f8Kmq0ccCZMYUUUGhIxWfktCuuZwJGneaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688996728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XsZWA8451BPr7/Ud83/6VPIROKIK25FqP0KDzoKAhWM=;
        b=V0iW5iYy+XU5xZIBorpzPgtN6zAAFRNG4EASSrDUuRkWb1hfOTqfOQfkfXGyvTCLM8mU9h
        RriOhxkUWRIefXDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 2/5] printk: Add NMI safety to console_flush_on_panic() and console_unblank()
Date:   Mon, 10 Jul 2023 15:51:21 +0206
Message-Id: <20230710134524.25232-3-john.ogness@linutronix.de>
In-Reply-To: <20230710134524.25232-1-john.ogness@linutronix.de>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk path is NMI safe because it only adds content to the
buffer and then triggers the delayed output via irq_work. If the
console is flushed or unblanked on panic (from NMI context) then it
can deadlock in down_trylock_console_sem() because the semaphore is
not NMI safe.

Avoid taking the console lock when flushing in panic. To prevent
other CPUs from taking the console lock while flushing, have
console_lock() block and console_trylock() fail for non-panic CPUs
during panic.

Skip unblanking in panic if the current context is NMI.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 77 +++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9644f6e5bf15..8a6c917dc081 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2583,6 +2583,25 @@ static int console_cpu_notify(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * Return true when this CPU should unlock console_sem without pushing all
+ * messages to the console. This reduces the chance that the console is
+ * locked when the panic CPU tries to use it.
+ */
+static bool abandon_console_lock_in_panic(void)
+{
+	if (!panic_in_progress())
+		return false;
+
+	/*
+	 * We can use raw_smp_processor_id() here because it is impossible for
+	 * the task to be migrated to the panic_cpu, or away from it. If
+	 * panic_cpu has already been set, and we're not currently executing on
+	 * that CPU, then we never will be.
+	 */
+	return atomic_read(&panic_cpu) != raw_smp_processor_id();
+}
+
 /**
  * console_lock - block the console subsystem from printing
  *
@@ -2595,6 +2614,10 @@ void console_lock(void)
 {
 	might_sleep();
 
+	/* On panic, the console_lock must be left to the panic cpu. */
+	while (abandon_console_lock_in_panic())
+		msleep(1000);
+
 	down_console_sem();
 	if (console_suspended)
 		return;
@@ -2613,6 +2636,9 @@ EXPORT_SYMBOL(console_lock);
  */
 int console_trylock(void)
 {
+	/* On panic, the console_lock must be left to the panic cpu. */
+	if (abandon_console_lock_in_panic())
+		return 0;
 	if (down_trylock_console_sem())
 		return 0;
 	if (console_suspended) {
@@ -2631,25 +2657,6 @@ int is_console_locked(void)
 }
 EXPORT_SYMBOL(is_console_locked);
 
-/*
- * Return true when this CPU should unlock console_sem without pushing all
- * messages to the console. This reduces the chance that the console is
- * locked when the panic CPU tries to use it.
- */
-static bool abandon_console_lock_in_panic(void)
-{
-	if (!panic_in_progress())
-		return false;
-
-	/*
-	 * We can use raw_smp_processor_id() here because it is impossible for
-	 * the task to be migrated to the panic_cpu, or away from it. If
-	 * panic_cpu has already been set, and we're not currently executing on
-	 * that CPU, then we never will be.
-	 */
-	return atomic_read(&panic_cpu) != raw_smp_processor_id();
-}
-
 /*
  * Check if the given console is currently capable and allowed to print
  * records.
@@ -3054,6 +3061,10 @@ void console_unblank(void)
 	 * In that case, attempt a trylock as best-effort.
 	 */
 	if (oops_in_progress) {
+		/* Semaphores are not NMI-safe. */
+		if (in_nmi())
+			return;
+
 		if (down_trylock_console_sem() != 0)
 			return;
 	} else
@@ -3083,14 +3094,24 @@ void console_unblank(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	bool handover;
+	u64 next_seq;
+
 	/*
-	 * If someone else is holding the console lock, trylock will fail
-	 * and may_schedule may be set.  Ignore and proceed to unlock so
-	 * that messages are flushed out.  As this can be called from any
-	 * context and we don't want to get preempted while flushing,
-	 * ensure may_schedule is cleared.
+	 * Ignore the console lock and flush out the messages. Attempting a
+	 * trylock would not be useful because:
+	 *
+	 *   - if it is contended, it must be ignored anyway
+	 *   - console_lock() and console_trylock() block and fail
+	 *     respectively in panic for non-panic CPUs
+	 *   - semaphores are not NMI-safe
+	 */
+
+	/*
+	 * If another context is holding the console lock,
+	 * @console_may_schedule might be set. Clear it so that
+	 * this context does not call cond_resched() while flushing.
 	 */
-	console_trylock();
 	console_may_schedule = 0;
 
 	if (mode == CONSOLE_REPLAY_ALL) {
@@ -3103,15 +3124,15 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
 			/*
-			 * If the above console_trylock() failed, this is an
-			 * unsynchronized assignment. But in that case, the
+			 * This is an unsynchronized assignment, but the
 			 * kernel is in "hope and pray" mode anyway.
 			 */
 			c->seq = seq;
 		}
 		console_srcu_read_unlock(cookie);
 	}
-	console_unlock();
+
+	console_flush_all(false, &next_seq, &handover);
 }
 
 /*
-- 
2.30.2

