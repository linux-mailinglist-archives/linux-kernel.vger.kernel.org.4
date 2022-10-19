Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2118B604A99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJSPH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiJSPFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F823220FF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:28 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dg+eirxPEtXsZsT+nvxwn7klIpJXP2S7/lYWcLQsq5o=;
        b=MPYjmlBAQJxd8Rggng1mxW4di7b7xYOCjLNGRWpjRItXh3zWEx5mIiT5FQKnOr3++nqdFC
        pe86OdsADSBSH5eHo+UuSujM5JBEBpxz4EqDYayBdbpNcMLU9lC9OlX+CxEuViL3w0XxBH
        xw8pxjWFvUNr5Edl/oW9ZbygohqM9mxtghTUvuuRVvuUhF+m9H0bWLFljDXTwz8k7NuXOO
        sCTinHr3ebMbna/ZdTfsspODBgffQYwaNnL2PKRKsQR5J7KHns5Ztl30N8PQHMgTWj18rj
        6HnkVcBl5OkAIL3PZyV8kgLNYcAjsfCjNaihlBxF2F8vGFgwMhFh9yuFifCIOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dg+eirxPEtXsZsT+nvxwn7klIpJXP2S7/lYWcLQsq5o=;
        b=EtIY4tyi7hLpay8rDK+lcQKRKX8CIAg4otKaMkH3lPH6wnLHsrvZ4XcHsVGirSMNMsusC9
        780jjF0WOKRvUkDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 27/38] printk: console_flush_all: use srcu console list iterator
Date:   Wed, 19 Oct 2022 17:01:49 +0206
Message-Id: <20221019145600.1282823-28-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
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

Guarantee safe iteration of the console list by using SRCU.

Note that in the case of a handover, the SRCU read lock is also
released. This is documented in the function description and as
comments in the code. It is a bit tricky, but this preserves the
lockdep lock ordering for the context handing over the
console_lock:

  console_lock()
  | mutex_acquire(&console_lock_dep_map)       <-- console lock
  |
  console_unlock()
  | console_flush_all()
  | | srcu_read_lock(&console_srcu)            <-- srcu lock
  | | console_emit_next_record()
  | | | console_lock_spinning_disable_and_check()
  | | | | srcu_read_unlock(&console_srcu)      <-- srcu unlock
  | | | | mutex_release(&console_lock_dep_map) <-- console unlock

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7ff2fc75fc3b..c4d5d58b5977 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1851,7 +1851,7 @@ static void console_lock_spinning_enable(void)
  *
  * Return: 1 if the lock rights were passed, 0 otherwise.
  */
-static int console_lock_spinning_disable_and_check(void)
+static int console_lock_spinning_disable_and_check(int cookie)
 {
 	int waiter;
 
@@ -1870,6 +1870,12 @@ static int console_lock_spinning_disable_and_check(void)
 
 	spin_release(&console_owner_dep_map, _THIS_IP_);
 
+	/*
+	 * Preserve lockdep lock ordering. Release the SRCU read lock before
+	 * releasing the console_lock.
+	 */
+	console_srcu_read_unlock(cookie);
+
 	/*
 	 * Hand off console_lock to waiter. The waiter will perform
 	 * the up(). After this, the waiter is the console_lock owner.
@@ -2353,7 +2359,7 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  char *text, size_t text_len,
 				  struct dev_printk_info *dev_info) { return 0; }
 static void console_lock_spinning_enable(void) { }
-static int console_lock_spinning_disable_and_check(void) { return 0; }
+static int console_lock_spinning_disable_and_check(int cookie) { return 0; }
 static void call_console_driver(struct console *con, const char *text, size_t len,
 				char *dropped_text)
 {
@@ -2695,8 +2701,8 @@ static void __console_unlock(void)
  * DROPPED_TEXT_MAX. Otherwise @dropped_text must be NULL.
  *
  * @handover will be set to true if a printk waiter has taken over the
- * console_lock, in which case the caller is no longer holding the
- * console_lock. Otherwise it is set to false.
+ * console_lock, in which case the caller is no longer holding both the
+ * console_lock and the SRCU read lock. Otherwise it is set to false.
  *
  * Returns false if the given console has no next record to print, otherwise
  * true.
@@ -2704,7 +2710,7 @@ static void __console_unlock(void)
  * Requires the console_lock.
  */
 static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
-				     char *dropped_text, bool *handover)
+				     char *dropped_text, bool *handover, int cookie)
 {
 	static int panic_console_dropped;
 	struct printk_info info;
@@ -2764,7 +2770,7 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 
 	con->seq++;
 
-	*handover = console_lock_spinning_disable_and_check();
+	*handover = console_lock_spinning_disable_and_check(cookie);
 	printk_safe_exit_irqrestore(flags);
 skip:
 	return true;
@@ -2801,6 +2807,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	bool any_usable = false;
 	struct console *con;
 	bool any_progress;
+	int cookie;
 
 	*next_seq = 0;
 	*handover = false;
@@ -2808,7 +2815,8 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	do {
 		any_progress = false;
 
-		for_each_console(con) {
+		cookie = console_srcu_read_lock();
+		for_each_console_srcu(con) {
 			bool progress;
 
 			if (!console_is_usable(con))
@@ -2819,12 +2827,17 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 				/* Extended consoles do not print "dropped messages". */
 				progress = console_emit_next_record(con, &text[0],
 								    &ext_text[0], NULL,
-								    handover);
+								    handover, cookie);
 			} else {
 				progress = console_emit_next_record(con, &text[0],
 								    NULL, &dropped_text[0],
-								    handover);
+								    handover, cookie);
 			}
+
+			/*
+			 * If a handover has occurred, the SRCU read lock
+			 * is already released.
+			 */
 			if (*handover)
 				return false;
 
@@ -2838,14 +2851,19 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 			/* Allow panic_cpu to take over the consoles safely. */
 			if (abandon_console_lock_in_panic())
-				return false;
+				goto abandon;
 
 			if (do_cond_resched)
 				cond_resched();
 		}
+		console_srcu_read_unlock(cookie);
 	} while (any_progress);
 
 	return any_usable;
+
+abandon:
+	console_srcu_read_unlock(cookie);
+	return false;
 }
 
 /**
-- 
2.30.2

