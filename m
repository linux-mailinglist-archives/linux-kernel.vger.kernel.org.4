Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943E65B4A98
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIJW3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiIJW2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1317944562
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:01 -0700 (PDT)
Message-ID: <20220910222301.366236279@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7h7DFq7DlMY8WzXRmdGz2plVQFhZnaozFR9FGyxDljo=;
        b=x/3ERXFx93KQf63lpOzkDVa73BmTwMDTxjJ6zoimc5QsGGE8W89awKZ6Qc0a/ubYEwpaBO
        IBoj40/rUogU28+Uhvy5ca40+ssoiBWqNyBgjRCxl4do/8nUOPE7aFJHNW9kCj8xRoJr++
        GoocjZLn6Rb8vWZC2pRtWG/zKx2UqDXperdBQ/zOxvJbGySrWVZUVA4TtxH0uS1pVNBqb2
        JXNvg60Mrnj0EBqC4eRxnulF9yHRR94vWr5wpbBAEATIXlb9hG3iyiuimOJQ0JxYXPZxEG
        KwCueJ33yS5MEZMM1BPZbqX952NfGjgQV2TV1McDELBWieUb19gmxZkxRU+U6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=7h7DFq7DlMY8WzXRmdGz2plVQFhZnaozFR9FGyxDljo=;
        b=aY+++WRDc0UvwblV/17pD6tW6n1oN4ouvFQPQ3gKvM1VX7+Q6QLqQtl911Re1hGCgqBUlz
        1MZV+l5Q5goUaUCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [patch RFC 17/29] printk: Use an output descriptor struct for emit
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:58 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for a new console infrastructure which is independent of the
console BKL wrap the output mode into a descriptor struct so the new
infrastrucure can share the emit code which dumps the ringbuffer record
into the output text buffers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h |   15 +++++++
 kernel/printk/printk.c  |   94 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 82 insertions(+), 27 deletions(-)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -187,6 +187,21 @@ struct cons_text_buf {
 };
 
 /**
+ * struct cons_outbuf_desc - console output buffer descriptor
+ * @txtbuf:		Pointer to buffer for storing the text
+ * @outbuf:		Pointer to the position in @buffer for
+ *			writing it out to the device
+ * @len:		Message length
+ * @extmsg:		Select extended format printing
+ */
+struct cons_outbuf_desc {
+	struct cons_text_buf	*txtbuf;
+	char			*outbuf;
+	unsigned int		len;
+	bool			extmsg;
+};
+
+/**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
  * @write:		Write callback to output messages (Optional)
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2684,40 +2684,39 @@ static void __console_unlock(void)
 	up_console_sem();
 }
 
-/*
- * Print one record for the given console. The record printed is whatever
- * record is the next available record for the given console.
- *
- * @text is a buffer of size CONSOLE_LOG_MAX.
- *
- * If extended messages should be printed, @ext_text is a buffer of size
- * CONSOLE_EXT_LOG_MAX. Otherwise @ext_text must be NULL.
- *
- * If dropped messages should be printed, @dropped_text is a buffer of size
- * DROPPED_TEXT_MAX. Otherwise @dropped_text must be NULL.
- *
- * @handover will be set to true if a printk waiter has taken over the
- * console_lock, in which case the caller is no longer holding the
- * console_lock. Otherwise it is set to false.
- *
- * Returns false if the given console has no next record to print, otherwise
- * true.
+
+/**
+ * cons_fill_outbuf - Fill the output buffer with the next record
+ * @con:	The console to print on
+ * @desc:	Pointer to the output descriptor
+ *
+ * The output descriptor contains all information which is necessary
+ * to print (buffer pointer, extended format selector...).
+ *
+ * Returns: False if there is no pending record in the ringbuffer
+ *	    True if there is a pending record in the ringbuffer.
+ *
+ * When the return value is true, then the caller has to check
+ * @desc->outbuf. If not NULL it points to the first character to write to
+ * the device and @desc->len contains the length of the message.
  *
- * Requires the console_lock.
+ * If it is NULL then records have been dropped or skipped and con->seq
+ * has been forwarded so the caller can try to print the next record.
  */
-static bool console_emit_next_record(struct console *con, struct cons_text_buf *txtbuf,
-				     bool *handover, bool extmsg)
+static bool cons_fill_outbuf(struct console *con, struct cons_outbuf_desc *desc)
 {
 	static int panic_console_dropped;
+
+	struct cons_text_buf *txtbuf = desc->txtbuf;
 	struct printk_info info;
 	struct printk_record r;
-	unsigned long flags;
 	char *write_text;
 	size_t len;
 
-	prb_rec_init_rd(&r, &info, txtbuf->text, CONSOLE_LOG_MAX);
+	desc->outbuf = NULL;
+	desc->len = 0;
 
-	*handover = false;
+	prb_rec_init_rd(&r, &info, txtbuf->text, CONSOLE_LOG_MAX);
 
 	if (!prb_read_valid(prb, con->seq, &r))
 		return false;
@@ -2734,10 +2733,10 @@ static bool console_emit_next_record(str
 	/* Skip record that has level above the console loglevel. */
 	if (suppress_message_printing(r.info->level)) {
 		con->seq++;
-		goto skip;
+		return true;
 	}
 
-	if (extmsg) {
+	if (desc->extmsg) {
 		write_text = txtbuf->ext_text;
 		len = info_print_ext_header(write_text, CONSOLE_EXT_LOG_MAX, r.info);
 		len += msg_print_ext_body(write_text + len, CONSOLE_EXT_LOG_MAX - len,
@@ -2747,6 +2746,47 @@ static bool console_emit_next_record(str
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 	}
 
+	desc->len = len;
+	desc->outbuf = write_text;
+	return true;
+}
+
+/**
+ * console_emit_next_record - Print one record for the given console
+ * @con:	The console to print on
+ * @txtbuf:	Pointer to the output buffer
+ * @handover:	Pointer to Handover handshake storage
+ * @extmsg:	Selects extended message format
+ *
+ * The record printed is whatever record is the next available record for
+ * the given console.
+ *
+ * @handover will be set to true if a printk waiter has taken over the
+ * console_lock, in which case the caller is no longer holding the
+ * console_lock. Otherwise it is set to false.
+ *
+ * Returns false if the given console has no next record to print, otherwise
+ * true.
+ *
+ * Requires the console_lock.
+ */
+static bool console_emit_next_record(struct console *con, struct cons_text_buf *txtbuf,
+				     bool *handover, bool extmsg)
+{
+	struct cons_outbuf_desc desc = {
+		.txtbuf	= txtbuf,
+		.extmsg = extmsg,
+	};
+	unsigned long flags;
+
+	*handover = false;
+
+	if (!cons_fill_outbuf(con, &desc))
+		return false;
+
+	if (!desc.outbuf)
+		goto skip;
+
 	/*
 	 * While actively printing out messages, if another printk()
 	 * were to occur on another CPU, it may wait for this one to
@@ -2761,7 +2801,7 @@ static bool console_emit_next_record(str
 	console_lock_spinning_enable();
 
 	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, write_text, len, extmsg ? NULL : txtbuf->dropped_text);
+	call_console_driver(con, desc.outbuf, desc.len, extmsg ? NULL : txtbuf->dropped_text);
 	start_critical_timings();
 
 	con->seq++;

