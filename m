Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A875636E39
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiKWXOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiKWXOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:14:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEC8D14D9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:14:17 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669245255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+ga5EsQ4Q0dD6QKcBL7AASWXoGeU5dLsOdcdIgzrhs=;
        b=ENbn+NVeyH3goCHcBewID4TRhVV6TmCCFuuG2iQfD7h0paqLwG/rHRTVm1q9gCCJFpJTMa
        XC3fJbUgQO2BVeUKwUGj9GTVtD+kJFSTqMyoy1XQSk5gjLSInHpVDfPvw5Ov35XK3Efs07
        zhifff4+2qJBwOYPv/ciWdEXfB9Iw203sWEWg9MJ76MtDjfzINAoXuSXOa89Do2mohtUjI
        RdtdklCZXjOMAZ/S9BhnIMAxE+Rm1hhqKGRnb8+rPnBb0F1TksbGO2WGtn3fh90srC5fP0
        DkeAZjjbICwMpxJEpL4H/FvOu6bHKMJNjJ0aIQXQpL6Tx4NK06OFd3YIa2+m0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669245255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+ga5EsQ4Q0dD6QKcBL7AASWXoGeU5dLsOdcdIgzrhs=;
        b=mTgAe5Nxh1q4mgK3PfLQ6P+S/ViwtZ4ERFiuk8l/2jxdxCU6/uzf7eMa7aa4MvbCPqnN4m
        9o2HKk52WW56qzBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 6/7] printk: Use an output buffer descriptor struct for emit
Date:   Thu, 24 Nov 2022 00:19:59 +0106
Message-Id: <20221123231400.614679-7-john.ogness@linutronix.de>
In-Reply-To: <20221123231400.614679-1-john.ogness@linutronix.de>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

To prepare for a new console infrastructure that is independent of
the console BKL, wrap the output mode into a descriptor struct so
the new infrastructure can share the emit code that dumps the
ringbuffer record into the output text buffers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |  15 ++++++
 kernel/printk/printk.c  | 107 ++++++++++++++++++++++++++++------------
 2 files changed, 90 insertions(+), 32 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 641c1ca7fb67..32614011a950 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -188,6 +188,21 @@ struct console_buffers {
 	char	text[CONSOLE_LOG_MAX];
 };
 
+/**
+ * struct console_message - console output buffer descriptor
+ * @cbufs:		Pointer to console buffers storing the record text
+ * @outbuf:		Pointer to the text buffer to be used for writing out
+ *			to the device
+ * @outbuf_len:		Length of text at @outbuf
+ * @is_extmsg:		True if this is an extended format message
+ */
+struct console_message {
+	struct console_buffers	*cbufs;
+	char			*outbuf;
+	unsigned int		outbuf_len;
+	bool			is_extmsg;
+};
+
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 750559171e30..dd1d8599ce5a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2741,11 +2741,76 @@ static void __console_unlock(void)
 	up_console_sem();
 }
 
+/**
+ * console_get_next_message - Fill the output buffer with the next record
+ * @con:	The console to print on
+ * @cmsg:	Pointer to the output buffer descriptor
+ *
+ * Return: False if there is no pending record in the ringbuffer.
+ *	   True if there is a pending record in the ringbuffer.
+ *
+ * When the return value is true, then the caller must check
+ * @cmsg->outbuf. If not NULL it points to the first character to write
+ * to the device and @cmsg->outbuf_len contains the length of the message.
+ * If it is NULL then the record will be skipped.
+ */
+static bool console_get_next_message(struct console *con, struct console_message *cmsg)
+{
+	struct console_buffers *cbufs = cmsg->cbufs;
+	static int panic_console_dropped;
+	struct printk_info info;
+	struct printk_record r;
+	size_t write_text_size;
+	char *write_text;
+	size_t len;
+
+	cmsg->outbuf = NULL;
+	cmsg->outbuf_len = 0;
+
+	prb_rec_init_rd(&r, &info, &cbufs->text[0], sizeof(cbufs->text));
+
+	if (!prb_read_valid(prb, con->seq, &r))
+		return false;
+
+	if (con->seq != r.info->seq) {
+		con->dropped += r.info->seq - con->seq;
+		con->seq = r.info->seq;
+		if (panic_in_progress() && panic_console_dropped++ > 10) {
+			suppress_panic_printk = 1;
+			pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
+		}
+	}
+
+	/*
+	 * Skip record that has level above the console loglevel.
+	 * Return true so the caller knows a record exists and
+	 * leave cmsg->outbuf NULL so the caller knows the record
+	 * is being skipped.
+	 */
+	if (suppress_message_printing(r.info->level))
+		return true;
+
+	if (cmsg->is_extmsg) {
+		write_text = &cbufs->ext_text[0];
+		write_text_size = sizeof(cbufs->ext_text);
+		len = info_print_ext_header(write_text, write_text_size, r.info);
+		len += msg_print_ext_body(write_text + len, write_text_size - len,
+					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
+	} else {
+		write_text = &cbufs->text[0];
+		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
+	}
+
+	cmsg->outbuf = write_text;
+	cmsg->outbuf_len = len;
+	return true;
+}
+
 /*
  * Print one record for the given console. The record printed is whatever
  * record is the next available record for the given console.
  *
- * @cbufs is the console buffers used to string-print the formatted messages.
+ * @cbufs is the console buffers to use for string-printing the message.
  *
  * @cookie is the cookie from entering the SRCU read-side critical section.
  *
@@ -2761,52 +2826,30 @@ static void __console_unlock(void)
 static bool console_emit_next_record(struct console *con, struct console_buffers *cbufs,
 				     int cookie, bool *handover)
 {
-	static int panic_console_dropped;
-	struct printk_info info;
-	struct printk_record r;
-	size_t write_text_size;
+	struct console_message cmsg = {
+		.cbufs		= cbufs,
+		.is_extmsg	= console_srcu_read_flags(con) & CON_EXTENDED,
+	};
 	unsigned long flags;
 	char *dropped_text;
-	char *write_text;
-	size_t len;
-
-	prb_rec_init_rd(&r, &info, &cbufs->text[0], sizeof(cbufs->text));
 
 	*handover = false;
 
-	if (!prb_read_valid(prb, con->seq, &r))
+	if (!console_get_next_message(con, &cmsg))
 		return false;
 
-	if (con->seq != r.info->seq) {
-		con->dropped += r.info->seq - con->seq;
-		con->seq = r.info->seq;
-		if (panic_in_progress() && panic_console_dropped++ > 10) {
-			suppress_panic_printk = 1;
-			pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
-		}
-	}
-
-	/* Skip record that has level above the console loglevel. */
-	if (suppress_message_printing(r.info->level)) {
+	if (!cmsg.outbuf) {
+		/* Skipping this record. */
 		con->seq++;
 		goto skip;
 	}
 
-	if (console_srcu_read_flags(con) & CON_EXTENDED) {
+	if (cmsg.is_extmsg) {
 		/* Extended consoles do not print "dropped messages". */
 		dropped_text = NULL;
-
-		write_text = &cbufs->ext_text[0];
-		write_text_size = sizeof(cbufs->ext_text);
-		len = info_print_ext_header(write_text, write_text_size, r.info);
-		len += msg_print_ext_body(write_text + len, write_text_size - len,
-					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
 	} else {
 		/* @ext_text is unused. Use it for "dropped messages". */
 		dropped_text = &cbufs->ext_text[0];
-
-		write_text = &cbufs->text[0];
-		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 	}
 
 	/*
@@ -2823,7 +2866,7 @@ static bool console_emit_next_record(struct console *con, struct console_buffers
 	console_lock_spinning_enable();
 
 	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, write_text, len, dropped_text);
+	call_console_driver(con, cmsg.outbuf, cmsg.outbuf_len, dropped_text);
 	start_critical_timings();
 
 	con->seq++;
-- 
2.30.2

