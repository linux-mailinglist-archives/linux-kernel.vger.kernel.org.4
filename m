Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3DA653798
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiLUU2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiLUU1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:27:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6AF24F2A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:27:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671654457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpYeAsldPGyAqY4hxNmOiSJNyyD2urN7p0Yg2vrAx2c=;
        b=xvp7nfVsG/2UWcrRmq3FP1izPmpSS3nfNf7XsM8DFLHTcMaQKxlclgn3vj4MF63Y2fcwRB
        lBDcqnwdJZBDF59ZDVhf+2HYn3JfWiy0lNmDgPnE9ZVyXpvw/IlL/75BOhmoEMNGWueya0
        Rvw5/VFvniQVej7shM7uckephlcKPYeOv9gaMPZzV9++d9/QXX9li5MbSP5eghwdlYkGfo
        +zEXfni+jHD8JSYOmDYZUqsEN+D0/COC1ulAeKTmA8RfpmkaNIQo/Rlj80v4UMnhtMNE1k
        aES5ugP0q1uaf4M5xESKztPeACzNwAh7M/4Vynjf3UweI/T4nVWTYQztxOlQpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671654457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpYeAsldPGyAqY4hxNmOiSJNyyD2urN7p0Yg2vrAx2c=;
        b=7PXG36TiyDcN4uGOntSv9FbBRnVA5iWktYsRZnRDlIT9BhKnjJqTQeMz8TLJG5LZ37LEEA
        992Ssau2EPqDRdCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 5/6] printk: introduce console_get_next_message() and console_message
Date:   Wed, 21 Dec 2022 21:33:03 +0106
Message-Id: <20221221202704.857925-6-john.ogness@linutronix.de>
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

Code for performing the console output is intermixed with code
that is formatting the output for that console. Introduce a new
helper function console_get_next_message() to handle the reading
and formatting of the console text. The helper does not require
any locking so that in the future it can be used for other console
printing contexts as well.

This also introduces a new struct console_message to wrap the
struct console_buffers adding meta-data about its contents. This
allows users of console_get_next_message() to receive all relevant
information about the message that was read and formatted.

The reason a wrapper struct is introduced instead of adding the
meta-data to struct console_buffers is because the upcoming atomic
consoles will need per-cpu and per-context console_buffers. It
would not make sense to make the meta-data also per-cpu and
per-context as that data can be easily stored on the stack of the
console printing context.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  16 ++++++
 kernel/printk/printk.c   | 118 +++++++++++++++++++++++++++------------
 2 files changed, 97 insertions(+), 37 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index f5ebbd392fee..4f2eb8c470bc 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -91,3 +91,19 @@ struct console_buffers {
 	char	outbuf[CONSOLE_EXT_LOG_MAX];
 	char	scratchbuf[LOG_LINE_MAX];
 };
+
+/**
+ * console_message - Container for a prepared console message.
+ * @cbufs:	Console buffers used to prepare the message.
+ * @outbuf_len:	The length of prepared text in @cbufs->outbuf to output. This
+ *		does not count the terminator. A value of 0 means there is
+ *		nothing to output and this record should be skipped.
+ * @outbuf_seq:	The sequence number of the record used for @cbufs->outbuf.
+ * @dropped:	The number of dropped records from reading @outbuf_seq.
+ */
+struct console_message {
+	struct console_buffers	*cbufs;
+	unsigned int		outbuf_len;
+	u64			outbuf_seq;
+	unsigned long		dropped;
+};
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2e5e2eda1fa1..7cac636600f8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2725,34 +2725,34 @@ static void __console_unlock(void)
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
+ * @cmsg will contain the formatted result. @cmsg->cbufs must point to a
+ * struct console_buffers.
  *
- * @cookie is the cookie from the SRCU read lock.
+ * @seq is the record to read and format. If it is not available, the next
+ * valid record is read.
  *
- * Returns false if the given console has no next record to print, otherwise
- * true.
+ * @is_extended specifies the message should be formatted for extended
+ * console output.
  *
- * Requires the console_lock and the SRCU read lock.
+ * Returns false if no record is available. Otherwise true and all fields
+ * of @cmsg are valid. (See the documentation of struct console_message
+ * for information about the @cmsg fields.)
  */
-static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
-{
-	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
-	static char dropped_text[DROPPED_TEXT_MAX];
-	static struct console_buffers cbufs;
-	const size_t scratchbuf_sz = sizeof(cbufs.scratchbuf);
-	const size_t outbuf_sz = sizeof(cbufs.outbuf);
-	char *scratchbuf = &cbufs.scratchbuf[0];
-	char *outbuf = &cbufs.outbuf[0];
+static bool console_get_next_message(struct console_message *cmsg, u64 seq,
+				     bool is_extended)
+{
+	struct console_buffers *cbufs = cmsg->cbufs;
+	const size_t scratchbuf_sz = sizeof(cbufs->scratchbuf);
+	const size_t outbuf_sz = sizeof(cbufs->outbuf);
+	char *scratchbuf = &cbufs->scratchbuf[0];
+	char *outbuf = &cbufs->outbuf[0];
 	static int panic_console_dropped;
 	struct printk_info info;
 	struct printk_record r;
-	unsigned long flags;
-	size_t len;
+	size_t len = 0;
 
 	/*
 	 * Formatting extended messages requires a separate buffer, so use the
@@ -2766,33 +2766,77 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
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
+	cmsg->outbuf_seq = r.info->seq;
+	cmsg->dropped = r.info->seq - seq;
+
+	/*
+	 * Check for dropped messages in panic here so that printk
+	 * suppression can occur as early as possible if necessary.
+	 */
+	if (cmsg->dropped &&
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
 		len += msg_print_ext_body(outbuf + len, outbuf_sz - len,
-					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
+					  r.text_buf, r.info->text_len, &r.info->dev_info);
 	} else {
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 	}
+out:
+	cmsg->outbuf_len = len;
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
+	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
+	static char dropped_text[DROPPED_TEXT_MAX];
+	static struct console_buffers cbufs;
+	static struct console_message cmsg = {
+		.cbufs = &cbufs,
+	};
+	char *outbuf = &cbufs.outbuf[0];
+	unsigned long flags;
+
+	*handover = false;
+
+	if (!console_get_next_message(&cmsg, con->seq, is_extended))
+		return false;
+
+	con->dropped += cmsg.dropped;
+
+	/* Skip messages of formatted length 0. */
+	if (cmsg.outbuf_len == 0) {
+		con->seq = cmsg.outbuf_seq + 1;
+		goto skip;
+	}
 
 	/*
 	 * While actively printing out messages, if another printk()
@@ -2808,11 +2852,11 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 	console_lock_spinning_enable();
 
 	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, outbuf, len,
+	call_console_driver(con, outbuf, cmsg.outbuf_len,
 			    is_extended ? NULL : dropped_text);
 	start_critical_timings();
 
-	con->seq++;
+	con->seq = cmsg.outbuf_seq + 1;
 
 	*handover = console_lock_spinning_disable_and_check(cookie);
 	printk_safe_exit_irqrestore(flags);
-- 
2.30.2

