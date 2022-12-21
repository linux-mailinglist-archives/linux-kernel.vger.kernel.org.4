Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC01C653797
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiLUU2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiLUU1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:27:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855BB24F1C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:27:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671654457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QVOOi+FhBYdbpRctUmJiqLD3QlodKxzJcuWxQBTUUXw=;
        b=r73NfUunzkfx2+18tfEaTjjMkO/lYXl9EnpwhC4IAixPJ9o0okDb2iDIULdUR1TrdhsGg0
        Av1hYoWooGLoahdtEmA27zcwgBpFM2FROFHKX5pbhz+T6/9NcEo+sr+wqFSmnw6ugf35vy
        ULaBODZZjRkZFFVSdH/HJHmk87gR7PZj4LPKs+gwDWYKYT7UPkeDybjaOXmxBkABp7/0OV
        o/pTAgTMUtXMAyx04Juo7T9Ewot2F3Awxt/6PR4gRu/1PaP3AApxQV405Y2lUIwKOEEbxm
        td85zd46y9/k/ad10yxlPd+8drtfidk0p3e+7KAzGnReEVK4pqFXBjmXlLxmiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671654457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QVOOi+FhBYdbpRctUmJiqLD3QlodKxzJcuWxQBTUUXw=;
        b=H7Dvp85tv9KqH4VKY7PBVrsZtA2fm9FZ6EVL3lCe5Oklk6j8Zhm7XQw0IPmhf8JoEhxt9k
        1YYTQ2FM2uZoKYCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 6/6] printk: introduce console_prepend_dropped() for dropped messages
Date:   Wed, 21 Dec 2022 21:33:04 +0106
Message-Id: <20221221202704.857925-7-john.ogness@linutronix.de>
In-Reply-To: <20221221202704.857925-1-john.ogness@linutronix.de>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
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

Currently "dropped messages" are separately printed immediately
before printing the printk message. Since normal consoles are
now using an output buffer that is much larger than previously,
the "dropped message" could be prepended to the printk message
and output in a single call.

Introduce a helper function console_prepend_dropped() to prepend
an existing message with a "dropped message". This simplifies
the code by allowing all message formatting to be handled
together and then only requires a single write() call to output
the full message. And since this helper does not require any
locking, it can be used in the future for other console printing
contexts as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  4 --
 kernel/printk/printk.c   | 84 ++++++++++++++++++++++++++--------------
 2 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 4f2eb8c470bc..b0ca59e6edad 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -26,9 +26,6 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 /* the maximum size of a formatted extended record */
 #define CONSOLE_EXT_LOG_MAX	8192
 
-/* the maximum size for a dropped text message */
-#define DROPPED_TEXT_MAX	64
-
 /* the maximum size allowed to be reserved for a record */
 #define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
 
@@ -68,7 +65,6 @@ u16 printk_parse_prefix(const char *text, int *level,
 
 #define CONSOLE_LOG_MAX		0
 #define CONSOLE_EXT_LOG_MAX	0
-#define DROPPED_TEXT_MAX	0
 #define LOG_LINE_MAX		0
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 7cac636600f8..f0d9c88e434f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1995,27 +1995,6 @@ static int console_trylock_spinning(void)
 	return 1;
 }
 
-/*
- * Call the specified console driver, asking it to write out the specified
- * text and length. If @dropped_text is non-NULL and any records have been
- * dropped, a dropped message will be written out first.
- */
-static void call_console_driver(struct console *con, const char *text, size_t len,
-				char *dropped_text)
-{
-	size_t dropped_len;
-
-	if (con->dropped && dropped_text) {
-		dropped_len = snprintf(dropped_text, DROPPED_TEXT_MAX,
-				       "** %lu printk messages dropped **\n",
-				       con->dropped);
-		con->dropped = 0;
-		con->write(con, dropped_text, dropped_len);
-	}
-
-	con->write(con, text, len);
-}
-
 /*
  * Recursion is tracked separately on each CPU. If NMIs are supported, an
  * additional NMI context per CPU is also separately tracked. Until per-CPU
@@ -2395,10 +2374,6 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  struct dev_printk_info *dev_info) { return 0; }
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(int cookie) { return 0; }
-static void call_console_driver(struct console *con, const char *text, size_t len,
-				char *dropped_text)
-{
-}
 static bool suppress_message_printing(int level) { return false; }
 static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
@@ -2724,6 +2699,50 @@ static void __console_unlock(void)
 	up_console_sem();
 }
 
+/*
+ * Prepend the message in @cmsg->cbufs->outbuf with a "dropped message". This
+ * is achieved by shifting the existing message over and inserting the dropped
+ * message.
+ *
+ * @cmsg is the console message to prepend.
+ *
+ * @dropped is the dropped count to report in the dropped message.
+ *
+ * If the message text in @cmsg->cbufs->outbuf does not have enough space for
+ * the dropped message, the message text will be sufficiently truncated.
+ *
+ * If @cmsg->cbufs->outbuf is modified, @cmsg->outbuf_len is updated.
+ */
+static void console_prepend_dropped(struct console_message *cmsg, unsigned long dropped)
+{
+	struct console_buffers *cbufs = cmsg->cbufs;
+	const size_t scratchbuf_sz = sizeof(cbufs->scratchbuf);
+	const size_t outbuf_sz = sizeof(cbufs->outbuf);
+	char *scratchbuf = &cbufs->scratchbuf[0];
+	char *outbuf = &cbufs->outbuf[0];
+	size_t len;
+
+	len = snprintf(scratchbuf, scratchbuf_sz,
+		       "** %lu printk messages dropped **\n", dropped);
+
+	/*
+	 * Make sure outbuf is sufficiently large before prepending. Space
+	 * for a terminator is also counted in case truncation occurs.
+	 */
+	if (WARN_ON_ONCE(len + 1 >= outbuf_sz))
+		return;
+
+	if (cmsg->outbuf_len + len >= outbuf_sz) {
+		/* Truncate the message, but keep it terminated. */
+		cmsg->outbuf_len = outbuf_sz - (len + 1);
+		outbuf[cmsg->outbuf_len] = 0;
+	}
+
+	memmove(outbuf + len, outbuf, cmsg->outbuf_len + 1);
+	memcpy(outbuf, scratchbuf, len);
+	cmsg->outbuf_len += len;
+}
+
 /*
  * Read and format the specified record (or a later record if the specified
  * record is not available).
@@ -2817,7 +2836,6 @@ static bool console_get_next_message(struct console_message *cmsg, u64 seq,
 static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
 {
 	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
-	static char dropped_text[DROPPED_TEXT_MAX];
 	static struct console_buffers cbufs;
 	static struct console_message cmsg = {
 		.cbufs = &cbufs,
@@ -2838,6 +2856,11 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		goto skip;
 	}
 
+	if (con->dropped && !is_extended) {
+		console_prepend_dropped(&cmsg, con->dropped);
+		con->dropped = 0;
+	}
+
 	/*
 	 * While actively printing out messages, if another printk()
 	 * were to occur on another CPU, it may wait for this one to
@@ -2851,9 +2874,12 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 	printk_safe_enter_irqsave(flags);
 	console_lock_spinning_enable();
 
-	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, outbuf, cmsg.outbuf_len,
-			    is_extended ? NULL : dropped_text);
+	/* Do not trace print latency. */
+	stop_critical_timings();
+
+	/* Write everything out to the hardware. */
+	con->write(con, outbuf, cmsg.outbuf_len);
+
 	start_critical_timings();
 
 	con->seq = cmsg.outbuf_seq + 1;
-- 
2.30.2

