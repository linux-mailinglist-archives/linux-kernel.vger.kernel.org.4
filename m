Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D8C62C42A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiKPQX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiKPQWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:22:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7EA326E8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:06 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVcIuv27uGLo38bBlF6a0snyz5C3DG9fbWr+xW+r2BY=;
        b=3ellLLMY/2Jf20hAsajoIK3yqG9lrmjthAmz0GvSIVxqA1zQwW2TEeb87Z1qKnl0koeAgD
        izST/3Dnj5JKGMrjJ7603fcRmOgxWvL8j+Zdar+kkbD/Szty0lmdXyu0Z8Tg2wSgiUAyr3
        m9gLne1gbI3VP/hoyUOVho4vnPVgSuTeDLoi0e5z7OoHVuCPjLrQMZUdJvcsLMjH4aa7bS
        8k9CLMRqJr7CFYxQcwpw+sj8VSozxEQOHGcbXN7GkY4i6tBzwM3aQvNJzJtniOdcBteQFb
        RNnJWhimMRrpwTyD1aKf2uCZwA5eHAmyEmKZX3Grd2OU+8l00iFDMUMtAqc6rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YVcIuv27uGLo38bBlF6a0snyz5C3DG9fbWr+xW+r2BY=;
        b=UChYZvgjqm0Zoiqmc+shyxCgeQ2G7GhTa5LqESdfoK3LeEySnsm/QJeIMoOmQmdn56wczq
        AvLZQP6PbGccdeDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 15/40] printk: console_flush_all: use srcu console list iterator
Date:   Wed, 16 Nov 2022 17:27:27 +0106
Message-Id: <20221116162152.193147-16-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 50 +++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 35018f18f5aa..3a7b1931b7c9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1893,13 +1893,13 @@ static void console_lock_spinning_enable(void)
  * safe to start busy waiting for the lock. Second, it checks if
  * there is a busy waiter and passes the lock rights to her.
  *
- * Important: Callers lose the lock if there was a busy waiter.
- *	They must not touch items synchronized by console_lock
- *	in this case.
+ * Important: Callers lose both the console_lock and the SRCU read lock if
+ *	there was a busy waiter. They must not touch items synchronized by
+ *	console_lock or SRCU read lock in this case.
  *
  * Return: 1 if the lock rights were passed, 0 otherwise.
  */
-static int console_lock_spinning_disable_and_check(void)
+static int console_lock_spinning_disable_and_check(int cookie)
 {
 	int waiter;
 
@@ -1918,6 +1918,12 @@ static int console_lock_spinning_disable_and_check(void)
 
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
@@ -2401,7 +2407,7 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  char *text, size_t text_len,
 				  struct dev_printk_info *dev_info) { return 0; }
 static void console_lock_spinning_enable(void) { }
-static int console_lock_spinning_disable_and_check(void) { return 0; }
+static int console_lock_spinning_disable_and_check(int cookie) { return 0; }
 static void call_console_driver(struct console *con, const char *text, size_t len,
 				char *dropped_text)
 {
@@ -2743,16 +2749,18 @@ static void __console_unlock(void)
  * DROPPED_TEXT_MAX. Otherwise @dropped_text must be NULL.
  *
  * @handover will be set to true if a printk waiter has taken over the
- * console_lock, in which case the caller is no longer holding the
- * console_lock. Otherwise it is set to false.
+ * console_lock, in which case the caller is no longer holding both the
+ * console_lock and the SRCU read lock. Otherwise it is set to false.
+ *
+ * @cookie is the cookie from the SRCU read lock.
  *
  * Returns false if the given console has no next record to print, otherwise
  * true.
  *
- * Requires the console_lock.
+ * Requires the console_lock and the SRCU read lock.
  */
 static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
-				     char *dropped_text, bool *handover)
+				     char *dropped_text, bool *handover, int cookie)
 {
 	static int panic_console_dropped;
 	struct printk_info info;
@@ -2812,7 +2820,7 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 
 	con->seq++;
 
-	*handover = console_lock_spinning_disable_and_check();
+	*handover = console_lock_spinning_disable_and_check(cookie);
 	printk_safe_exit_irqrestore(flags);
 skip:
 	return true;
@@ -2849,6 +2857,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	bool any_usable = false;
 	struct console *con;
 	bool any_progress;
+	int cookie;
 
 	*next_seq = 0;
 	*handover = false;
@@ -2856,23 +2865,29 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	do {
 		any_progress = false;
 
-		for_each_console(con) {
+		cookie = console_srcu_read_lock();
+		for_each_console_srcu(con) {
 			bool progress;
 
 			if (!console_is_usable(con))
 				continue;
 			any_usable = true;
 
-			if (con->flags & CON_EXTENDED) {
+			if (console_srcu_read_flags(con) & CON_EXTENDED) {
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
 
@@ -2886,14 +2901,19 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
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

