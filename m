Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAE8662326
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbjAIKYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbjAIKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:08:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C661AFCE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:08:48 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673258926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqXNx4ZjO+PgrTp+dbVbR/nkqi+9jEGT8axvs9fFi6o=;
        b=TbZW1AYkzRXfnxhd4mnm5/MBNwDg+zBjuBLaqk2ckBDX4duSlhbORnYWJxluvCZXe6EswF
        pVvfP0M5dtKrAjn8LePECMYBrBEuH8xIpL4gqDZRerO1G7/qYoCxULZa4cTGIrOZnvecGP
        aI09mGTJc60+A/F6k81LaAKtltY0EVkRjt6GemNoeiUqlYq8fjsojutu3yh7DYTNh0kt0A
        hPVFZfFpi1THen3mghP3GnAhYsssHUB/n1X3m6hIMurswh+wnxoK9P5lN6Ta5nhVBr5EsM
        sUSAosd4ncVOjP+cm0VmTKoaFv4LpKWwvt6K3pUMkcRyGmePMRfDYsuiUrcwUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673258926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqXNx4ZjO+PgrTp+dbVbR/nkqi+9jEGT8axvs9fFi6o=;
        b=YqPYkPhjGtr67J2ezM9YMIYVa0hMdyes5jUxeEJMcU7Ya2rtU5Wt22YYfo5q7iADbunYS0
        KEauCMvd6AwCoFBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 5/8] printk: introduce printk_get_next_message() and printk_message
Date:   Mon,  9 Jan 2023 11:13:57 +0106
Message-Id: <20230109100800.1085541-6-john.ogness@linutronix.de>
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

Code for performing the console output is intermixed with code that
is formatting the output for that console. Introduce a new helper
function printk_get_next_message() to handle the reading and
formatting of the printk text. The helper does not require any
locking so that in the future it can be used for other printing
contexts as well.

This also introduces a new struct printk_message to wrap the struct
printk_buffers, adding metadata about its contents. This allows
users of printk_get_next_message() to receive all relevant
information about the message that was read and formatted.

Why is struct printk_message a wrapper struct?

It is intentional that a wrapper struct is introduced instead of
adding the metadata directly to struct printk_buffers. The upcoming
atomic consoles support multiple printing contexts per CPU. This
means that while a CPU is formatting a message, it can be
interrupted and the interrupting context may also format a (possibly
different) message. Since the printk buffers are rather large,
there will only be one struct printk_buffers per CPU and it must be
shared by the possible contexts of that CPU.

If the metadata was part of struct printk_buffers, interrupting
contexts would clobber the metadata being prepared by the
interrupted context. This could be handled by robustifying the
message formatting functions to cope with metadata unexpectedly
changing. However, this would require significant amounts of extra
data copying, also adding significant complexity to the code.

Instead, the metadata can live on the stack of the formatting
context and the message formatting functions do not need to be
concerned about the metadata changing underneath them.

Note that the message formatting functions can handle unexpected
text buffer changes. So it is perfectly OK if a shared text buffer
is clobbered by an interrupting context. The atomic console
implementation will recognize the interruption and avoid printing
the (probably garbage) text buffer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  16 ++++++
 kernel/printk/printk.c   | 115 +++++++++++++++++++++++++++------------
 2 files changed, 96 insertions(+), 35 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6080d289a342..c9bb0cd86372 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -92,3 +92,19 @@ struct printk_buffers {
 	char	outbuf[CONSOLE_EXT_LOG_MAX];
 	char	scratchbuf[LOG_LINE_MAX];
 };
+
+/**
+ * struct printk_message - Container for a prepared printk message.
+ * @pbufs:	printk buffers used to prepare the message.
+ * @outbuf_len:	The length of prepared text in @pbufs->outbuf to output. This
+ *		does not count the terminator. A value of 0 means there is
+ *		nothing to output and this record should be skipped.
+ * @seq:	The sequence number of the record used for @pbufs->outbuf.
+ * @dropped:	The number of dropped records from reading @seq.
+ */
+struct printk_message {
+	struct printk_buffers	*pbufs;
+	unsigned int		outbuf_len;
+	u64			seq;
+	unsigned long		dropped;
+};
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index bc5d4574c459..6e2a6d5548e9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2725,35 +2725,35 @@ static void __console_unlock(void)
 }
 
 /*
- * Print one record for the given console. The record printed is whatever
- * record is the next available record for the given console.
+ * Read and format the specified record (or a later record if the specified
+ * record is not available).
  *
- * @handover will be set to true if a printk waiter has taken over the
- * console_lock, in which case the caller is no longer holding both the
- * console_lock and the SRCU read lock. Otherwise it is set to false.
+ * @pmsg will contain the formatted result. @pmsg->pbufs must point to a
+ * struct printk_buffers.
  *
- * @cookie is the cookie from the SRCU read lock.
+ * @seq is the record to read and format. If it is not available, the next
+ * valid record is read.
  *
- * Returns false if the given console has no next record to print, otherwise
- * true.
+ * @is_extended specifies if the message should be formatted for extended
+ * console output.
  *
- * Requires the console_lock and the SRCU read lock.
+ * Returns false if no record is available. Otherwise true and all fields
+ * of @pmsg are valid. (See the documentation of struct printk_message
+ * for information about the @pmsg fields.)
  */
-static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
+static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+				    bool is_extended)
 {
-	static char dropped_text[DROPPED_TEXT_MAX];
-	static struct printk_buffers pbufs;
 	static int panic_console_dropped;
 
-	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
-	const size_t scratchbuf_sz = sizeof(pbufs.scratchbuf);
-	const size_t outbuf_sz = sizeof(pbufs.outbuf);
-	char *scratchbuf = &pbufs.scratchbuf[0];
-	char *outbuf = &pbufs.outbuf[0];
+	struct printk_buffers *pbufs = pmsg->pbufs;
+	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
+	const size_t outbuf_sz = sizeof(pbufs->outbuf);
+	char *scratchbuf = &pbufs->scratchbuf[0];
+	char *outbuf = &pbufs->outbuf[0];
 	struct printk_info info;
 	struct printk_record r;
-	unsigned long flags;
-	size_t len;
+	size_t len = 0;
 
 	/*
 	 * Formatting extended messages requires a separate buffer, so use the
@@ -2767,25 +2767,26 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 	else
 		prb_rec_init_rd(&r, &info, outbuf, outbuf_sz);
 
-	*handover = false;
-
-	if (!prb_read_valid(prb, con->seq, &r))
+	if (!prb_read_valid(prb, seq, &r))
 		return false;
 
-	if (con->seq != r.info->seq) {
-		con->dropped += r.info->seq - con->seq;
-		con->seq = r.info->seq;
-		if (panic_in_progress() && panic_console_dropped++ > 10) {
-			suppress_panic_printk = 1;
-			pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
-		}
+	pmsg->seq = r.info->seq;
+	pmsg->dropped = r.info->seq - seq;
+
+	/*
+	 * Check for dropped messages in panic here so that printk
+	 * suppression can occur as early as possible if necessary.
+	 */
+	if (pmsg->dropped &&
+	    panic_in_progress() &&
+	    panic_console_dropped++ > 10) {
+		suppress_panic_printk = 1;
+		pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
 	}
 
 	/* Skip record that has level above the console loglevel. */
-	if (suppress_message_printing(r.info->level)) {
-		con->seq++;
-		goto skip;
-	}
+	if (suppress_message_printing(r.info->level))
+		goto out;
 
 	if (is_extended) {
 		len = info_print_ext_header(outbuf, outbuf_sz, r.info);
@@ -2794,6 +2795,50 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 	} else {
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 	}
+out:
+	pmsg->outbuf_len = len;
+	return true;
+}
+
+/*
+ * Print one record for the given console. The record printed is whatever
+ * record is the next available record for the given console.
+ *
+ * @handover will be set to true if a printk waiter has taken over the
+ * console_lock, in which case the caller is no longer holding both the
+ * console_lock and the SRCU read lock. Otherwise it is set to false.
+ *
+ * @cookie is the cookie from the SRCU read lock.
+ *
+ * Returns false if the given console has no next record to print, otherwise
+ * true.
+ *
+ * Requires the console_lock and the SRCU read lock.
+ */
+static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
+{
+	static char dropped_text[DROPPED_TEXT_MAX];
+	static struct printk_buffers pbufs;
+
+	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
+	char *outbuf = &pbufs.outbuf[0];
+	struct printk_message pmsg = {
+		.pbufs = &pbufs,
+	};
+	unsigned long flags;
+
+	*handover = false;
+
+	if (!printk_get_next_message(&pmsg, con->seq, is_extended))
+		return false;
+
+	con->dropped += pmsg.dropped;
+
+	/* Skip messages of formatted length 0. */
+	if (pmsg.outbuf_len == 0) {
+		con->seq = pmsg.seq + 1;
+		goto skip;
+	}
 
 	/*
 	 * While actively printing out messages, if another printk()
@@ -2809,11 +2854,11 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 	console_lock_spinning_enable();
 
 	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, outbuf, len,
+	call_console_driver(con, outbuf, pmsg.outbuf_len,
 			    is_extended ? NULL : dropped_text);
 	start_critical_timings();
 
-	con->seq++;
+	con->seq = pmsg.seq + 1;
 
 	*handover = console_lock_spinning_disable_and_check(cookie);
 	printk_safe_exit_irqrestore(flags);
-- 
2.30.2

