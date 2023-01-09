Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC466228C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjAIKJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbjAIKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:08:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09CA10F6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:08:48 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673258926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KwtlRFi0ucYwgo8zAGimTYO9K8YK26MeFnNklCQOGzw=;
        b=3RoQA2aDLx7AlS6Co8IADuTW2f6qTEEXfGZJMrn/9nhav5yaGegA44eq414C5fFHD/ZM5J
        UrASxwb8wRezckEGyL5BqJ9U2C0Aiv2FCZE8lWEiRNkvD/kIUrf7anBZw/KT0owt0G0qKE
        h3jF2XIJtY5C5yPlgp9sFw5WMhKZCzcgE2ztl6Dxm2x3fEn83QDN5qYXxKd2ortCyo0krr
        mhj90TQJUeN7L2hxAtKssv7qIcH7uoBM2NSfiUBDAvYJM9Phdc+noOQUKgMton+VbqmD8b
        1/v6qd1y3rCVYJt/zxdIetZeT4abFjBboaTWZblVX8OuyJuF0IYlBPi3aftK1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673258926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KwtlRFi0ucYwgo8zAGimTYO9K8YK26MeFnNklCQOGzw=;
        b=IXpLv0+901H2N2U63t49w1Ie91aCWYX8F3HksNv9buCqUJQaEx1/MtDDNqdWEQKrLDpZHK
        Vwc5VVXkijc0hZCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 6/8] printk: introduce console_prepend_dropped() for dropped messages
Date:   Mon,  9 Jan 2023 11:13:58 +0106
Message-Id: <20230109100800.1085541-7-john.ogness@linutronix.de>
In-Reply-To: <20230109100800.1085541-1-john.ogness@linutronix.de>
References: <20230109100800.1085541-1-john.ogness@linutronix.de>
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
and then output everything in a single write() call.

Introduce a helper function console_prepend_dropped() to prepend
an existing message with a "dropped message". This simplifies
the code by allowing all message formatting to be handled
together and then only requires a single write() call to output
the full message. And since this helper does not require any
locking, it can be used in the future for other console printing
contexts as well.

Note that console_prepend_dropped() is defined as a NOP for
!CONFIG_PRINTK. Although the function will never be called for
!CONFIG_PRINTK, compiling the function can lead to warnings of
"always true" conditionals due to the size macro values used
in !CONFIG_PRINTK.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  4 --
 kernel/printk/printk.c   | 90 +++++++++++++++++++++++++++-------------
 2 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index c9bb0cd86372..72df730597f1 100644
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
 
@@ -69,7 +66,6 @@ u16 printk_parse_prefix(const char *text, int *level,
 #define PREFIX_MAX		0
 #define CONSOLE_LOG_MAX		0
 #define CONSOLE_EXT_LOG_MAX	0
-#define DROPPED_TEXT_MAX	0
 #define LOG_LINE_MAX		0
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6e2a6d5548e9..80a49ec6f42b 100644
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
@@ -2724,6 +2699,56 @@ static void __console_unlock(void)
 	up_console_sem();
 }
 
+/*
+ * Prepend the message in @pmsg->pbufs->outbuf with a "dropped message". This
+ * is achieved by shifting the existing message over and inserting the dropped
+ * message.
+ *
+ * @pmsg is the printk message to prepend.
+ *
+ * @dropped is the dropped count to report in the dropped message.
+ *
+ * If the message text in @pmsg->pbufs->outbuf does not have enough space for
+ * the dropped message, the message text will be sufficiently truncated.
+ *
+ * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
+ */
+#ifdef CONFIG_PRINTK
+static void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+{
+	struct printk_buffers *pbufs = pmsg->pbufs;
+	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
+	const size_t outbuf_sz = sizeof(pbufs->outbuf);
+	char *scratchbuf = &pbufs->scratchbuf[0];
+	char *outbuf = &pbufs->outbuf[0];
+	size_t len;
+
+	len = snprintf(scratchbuf, scratchbuf_sz,
+		       "** %lu printk messages dropped **\n", dropped);
+
+	/*
+	 * Make sure outbuf is sufficiently large before prepending.
+	 * Keep at least the prefix when the message must be truncated.
+	 * It is a rather theoretical problem when someone tries to
+	 * use a minimalist buffer.
+	 */
+	if (WARN_ON_ONCE(len + PREFIX_MAX >= outbuf_sz))
+		return;
+
+	if (pmsg->outbuf_len + len >= outbuf_sz) {
+		/* Truncate the message, but keep it terminated. */
+		pmsg->outbuf_len = outbuf_sz - (len + 1);
+		outbuf[pmsg->outbuf_len] = 0;
+	}
+
+	memmove(outbuf + len, outbuf, pmsg->outbuf_len + 1);
+	memcpy(outbuf, scratchbuf, len);
+	pmsg->outbuf_len += len;
+}
+#else
+#define console_prepend_dropped(pmsg, dropped)
+#endif /* CONFIG_PRINTK */
+
 /*
  * Read and format the specified record (or a later record if the specified
  * record is not available).
@@ -2817,7 +2842,6 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
  */
 static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
 {
-	static char dropped_text[DROPPED_TEXT_MAX];
 	static struct printk_buffers pbufs;
 
 	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
@@ -2840,6 +2864,11 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		goto skip;
 	}
 
+	if (con->dropped && !is_extended) {
+		console_prepend_dropped(&pmsg, con->dropped);
+		con->dropped = 0;
+	}
+
 	/*
 	 * While actively printing out messages, if another printk()
 	 * were to occur on another CPU, it may wait for this one to
@@ -2853,9 +2882,12 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 	printk_safe_enter_irqsave(flags);
 	console_lock_spinning_enable();
 
-	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, outbuf, pmsg.outbuf_len,
-			    is_extended ? NULL : dropped_text);
+	/* Do not trace print latency. */
+	stop_critical_timings();
+
+	/* Write everything out to the hardware. */
+	con->write(con, outbuf, pmsg.outbuf_len);
+
 	start_critical_timings();
 
 	con->seq = pmsg.seq + 1;
-- 
2.30.2

