Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8902761F562
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiKGOSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbiKGOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9D41CFFE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TCVppZa0E2AuHd0nGaCpwvvOyi1zDUsbUnYVLs1Wys=;
        b=q0O+msnTIqJDVliJS2mLPmiTeN1bT4M4lS4vv1ta4Iles3swgem1QVh35gabpuNYnUkW9o
        kumUOwPGqpUFtE9uIVqJVyyJusic9EbpwXtVXM/DphHFhu7j/llHcsOvNhdoXOvKW8MwAQ
        J78ruFn8rKOWjEbg/78XMS7uTzmJ0ui6PHsH4xVdm6WM1flZAoz4X6TCt3/2V92m0+iDBx
        sC+yKZCWx+xbCVsF7NxRyQDNHLlA6cBfu2CHxYQN0D53Mjjz9COGM9xALCiHtPORtU1PtI
        8M97XR5at4c2Z232jKNiAH5yZuym/gYqEsz5toH1Kq4UKFF4sVPpB5fzAj40Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5TCVppZa0E2AuHd0nGaCpwvvOyi1zDUsbUnYVLs1Wys=;
        b=yzRUX7qMIVq9AxG/h9VUumLt/k5928UDKof4oMa1D5IebwjjtNBshv84ecqWvcCu5r9Fi1
        i2W2BEAaV5h3zaDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 07/40] console: introduce console_is_enabled() wrapper
Date:   Mon,  7 Nov 2022 15:22:05 +0106
Message-Id: <20221107141638.3790965-8-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After switching to SRCU for console list iteration, some readers
will begin readings console->flags as a data race. Locklessly
reading console->flags provides a consistent value because there
is at most one CPU modifying console->flags and that CPU is
using only read-modify-write operations.

The primary reason for readers to access console->flags is to
check if the console is enabled. Introduce console_is_enabled()
to mark such access as a data race.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 27 +++++++++++++++++++++++++++
 kernel/printk/printk.c  | 10 +++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index f4f0c9523835..d9c636011364 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -172,6 +172,33 @@ extern void console_srcu_read_unlock(int cookie);
 
 extern struct hlist_head console_list;
 
+/**
+ * console_is_enabled - Locklessly check if the console is enabled
+ * @con:	struct console pointer of console to check
+ *
+ * Unless the caller is explicitly synchronizing against the console
+ * register/unregister/stop/start functions, this function should be
+ * used instead of manually readings console->flags and testing for
+ * the CON_ENABLED bit.
+ *
+ * This function provides the necessary READ_ONCE() and data_race()
+ * notation for locklessly reading the console flags. The READ_ONCE()
+ * in this function matches the WRITE_ONCE() when @flags are modified
+ * for registered consoles.
+ *
+ * Context: Any context.
+ */
+static inline bool console_is_enabled(const struct console *con)
+{
+	/*
+	 * Locklessly reading console->flags provides a consistent
+	 * read value because there is at most one CPU modifying
+	 * console->flags and that CPU is using only read-modify-write
+	 * operations to do so.
+	 */
+	return (data_race(READ_ONCE(con->flags)) & CON_ENABLED);
+}
+
 /**
  * for_each_console_srcu() - Iterator over registered consoles
  * @con:	struct console pointer used as loop cursor
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8974523f3107..79811984da34 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3021,7 +3021,7 @@ void console_stop(struct console *console)
 {
 	__pr_flush(console, 1000, true);
 	console_lock();
-	console->flags &= ~CON_ENABLED;
+	WRITE_ONCE(console->flags, console->flags & ~CON_ENABLED);
 	console_unlock();
 
 	/*
@@ -3037,7 +3037,7 @@ EXPORT_SYMBOL(console_stop);
 void console_start(struct console *console)
 {
 	console_lock();
-	console->flags |= CON_ENABLED;
+	WRITE_ONCE(console->flags, console->flags | CON_ENABLED);
 	console_unlock();
 	__pr_flush(console, 1000, true);
 }
@@ -3256,7 +3256,7 @@ void register_console(struct console *newcon)
 
 	} else if (newcon->flags & CON_CONSDEV) {
 		/* Only the new head can have CON_CONSDEV set. */
-		console_first()->flags &= ~CON_CONSDEV;
+		WRITE_ONCE(console_first()->flags, console_first()->flags & ~CON_CONSDEV);
 		hlist_add_head_rcu(&newcon->node, &console_list);
 
 	} else {
@@ -3308,7 +3308,7 @@ int unregister_console(struct console *console)
 	console_lock();
 
 	/* Disable it unconditionally */
-	console->flags &= ~CON_ENABLED;
+	WRITE_ONCE(console->flags, console->flags & ~CON_ENABLED);
 
 	if (hlist_unhashed(&console->node)) {
 		console_unlock();
@@ -3327,7 +3327,7 @@ int unregister_console(struct console *console)
 	 * console has any device attached. Oh well....
 	 */
 	if (!hlist_empty(&console_list) && console->flags & CON_CONSDEV)
-		console_first()->flags |= CON_CONSDEV;
+		WRITE_ONCE(console_first()->flags, console_first()->flags | CON_CONSDEV);
 
 	console_unlock();
 
-- 
2.30.2

