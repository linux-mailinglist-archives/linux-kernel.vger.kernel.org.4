Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF22E636E38
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKWXOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiKWXOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:14:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11019D14E8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:14:19 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669245256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qJ3iGikvuTukQn/cCJfO+65/fD4hTu0WWCBxLF08iQ=;
        b=qFG7KOKPIOGPVQw4I4QTVM52nnmpM91ysQ6T70Acjrw1gpl0mSL1hKuzjaYH3IyrBdHtv6
        oh/j557mygD9WK7tfw/fKTKt1veJRrSPK/tfHkUVK2/aD1rCsP9TA24uV7U6CwgM+UnHK3
        33M0kpa68PuW0Ut2XgbpCvlM5j5RRdPeszmPqkKCBPHHmvZTE/TT/ad9TN6LxRbxPV5DUv
        WpwG0pluX/88uGy/c12JMEfAt+cQjzIfzZQ3Qg2oVIXdDCmxYEh75Xm/C23581Dg3PZEZw
        Cc1NwxIkCOATcuq59S94MuFyyppOkXrb0C0tO/A08yqCqgTUkZ/Ci6ANn0QXGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669245256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qJ3iGikvuTukQn/cCJfO+65/fD4hTu0WWCBxLF08iQ=;
        b=SDLoP6aDtGO+Fh77Cy+vmar1/O+F8pe4MEZi8b2SuHvnnXV3AVCXOa3UDf8N3bIdogk61N
        B3dJyH5e3wquaECg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 7/7] printk: Handle dropped message smarter
Date:   Thu, 24 Nov 2022 00:20:00 +0106
Message-Id: <20221123231400.614679-8-john.ogness@linutronix.de>
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

If a 'dropped message' is to be printed, move the record text to be
directly appended to the 'dropped message' and let console->write()
output it in one go.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 125 +++++++++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 43 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dd1d8599ce5a..c4b148a7d114 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2007,31 +2007,6 @@ static int console_trylock_spinning(void)
 	return 1;
 }
 
-#if DROPPED_TEXT_MAX > CONSOLE_EXT_LOG_MAX
-#error "DROPPED_TEXT_MAX too large for console_buffers->ext_text"
-#endif
-
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
@@ -2412,10 +2387,6 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
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
@@ -2741,6 +2712,60 @@ static void __console_unlock(void)
 	up_console_sem();
 }
 
+/*
+ * A maximum dropped message together with a maximum regular message
+ * must be able to fit within console_buffers->ext_text.
+ */
+#if DROPPED_TEXT_MAX > (CONSOLE_EXT_LOG_MAX - CONSOLE_LOG_MAX)
+#error "DROPPED_TEXT_MAX too large for console_buffers->ext_text"
+#endif
+
+/**
+ * msg_print_dropped - Prepend a "dropped message" if required
+ * @desc:	Pointer to the output descriptor
+ * @dropped:	The number of dropped messages to report
+ *
+ * Inserts the "dropped message" into the output buffer if @dropped is
+ * not 0 and the regular format is requested. Extended format does not
+ * need this message because it prints the sequence numbers.
+ *
+ * In regular format, the extended message buffer is not in use. So
+ * string-print the dropped message there and move the record text to be
+ * appended to the dropped message. The extended message buffer is much
+ * larger and can accommodate both messages.
+ *
+ * In case a dropped message is needed, this returns with @desc->outbuf
+ * and @desc->len updated. The caller is responsible for tracking and
+ * resetting the dropped count. If no dropped message is required then
+ * @desc is not modified.
+ */
+static void msg_print_dropped(struct console_message *cmsg, unsigned long dropped)
+{
+	struct console_buffers *cbufs = cmsg->cbufs;
+	char *ext_text = &cbufs->ext_text[0];
+	size_t len;
+
+	if (!dropped || cmsg->is_extmsg)
+		return;
+
+	if (WARN_ON_ONCE(cmsg->outbuf != &cbufs->text[0]))
+		return;
+
+	/* Print it into ext_text, which is unused. */
+	len = snprintf(ext_text, DROPPED_TEXT_MAX,
+		       "** %lu printk messages dropped **\n", dropped);
+
+	/*
+	 * Append the record text to the dropped message so that it
+	 * goes out with one write.
+	 */
+	memcpy(ext_text + len, &cbufs->text[0], cmsg->outbuf_len);
+
+	/* Update the output buffer descriptor. */
+	cmsg->outbuf = ext_text;
+	cmsg->outbuf_len += len;
+}
+
 /**
  * console_get_next_message - Fill the output buffer with the next record
  * @con:	The console to print on
@@ -2796,13 +2821,32 @@ static bool console_get_next_message(struct console *con, struct console_message
 		len = info_print_ext_header(write_text, write_text_size, r.info);
 		len += msg_print_ext_body(write_text + len, write_text_size - len,
 					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
+
+		cmsg->outbuf = write_text;
+		cmsg->outbuf_len = len;
+
+		/*
+		 * Extended consoles do not print "dropped messages"
+		 * as that can be seen from the sequence number.
+		 */
 	} else {
-		write_text = &cbufs->text[0];
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
+
+		cmsg->outbuf = &cbufs->text[0];
+		cmsg->outbuf_len = len;
+
+		if (con->dropped) {
+			/*
+			 * It is expected that @outbuf and @outbuf_len are
+			 * already set. They will be updated after inserting
+			 * the "dropped message".
+			 */
+			msg_print_dropped(cmsg, con->dropped);
+
+			con->dropped = 0;
+		}
 	}
 
-	cmsg->outbuf = write_text;
-	cmsg->outbuf_len = len;
 	return true;
 }
 
@@ -2831,7 +2875,6 @@ static bool console_emit_next_record(struct console *con, struct console_buffers
 		.is_extmsg	= console_srcu_read_flags(con) & CON_EXTENDED,
 	};
 	unsigned long flags;
-	char *dropped_text;
 
 	*handover = false;
 
@@ -2844,14 +2887,6 @@ static bool console_emit_next_record(struct console *con, struct console_buffers
 		goto skip;
 	}
 
-	if (cmsg.is_extmsg) {
-		/* Extended consoles do not print "dropped messages". */
-		dropped_text = NULL;
-	} else {
-		/* @ext_text is unused. Use it for "dropped messages". */
-		dropped_text = &cbufs->ext_text[0];
-	}
-
 	/*
 	 * While actively printing out messages, if another printk()
 	 * were to occur on another CPU, it may wait for this one to
@@ -2865,8 +2900,12 @@ static bool console_emit_next_record(struct console *con, struct console_buffers
 	printk_safe_enter_irqsave(flags);
 	console_lock_spinning_enable();
 
-	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, cmsg.outbuf, cmsg.outbuf_len, dropped_text);
+	/* Do not trace print latency. */
+	stop_critical_timings();
+
+	/* Write everything out to the hardware. */
+	con->write(con, cmsg.outbuf, cmsg.outbuf_len);
+
 	start_critical_timings();
 
 	con->seq++;
-- 
2.30.2

