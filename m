Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959D85E868E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiIXAGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiIXAFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C909DFAB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:05:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78lWKQLJRfdW9hexh7XAr98bJYw2kzBvk5KGdMnrw6M=;
        b=H1F61iegmWvk2aynS76wM7c/ppzek30gCbggDPvqxy9jWDyTWbBZ9Zn+SLglw37vgtUpcl
        H6N8gT5d+Tg94ugyLxfhyrpKwftkPgA5JJZjHiLxZPuAxUKngNtuEJpnjZz64DrpASZiw5
        iApAv/6rFAmeMSTVXm17XSQklmgN64PLyLqKHIj/lhuLQ7P0V9XfY/oOBOWyUCRPvhD/9T
        8Y4rtHL8fPVM4if/o7tJWv9/qHOYOdKaQiF524IgNepwCTQwQto1XMu1Tv9rh959PDcWCe
        zY3hadxb/+pMlcOUt6FRCAB4kxEl9C8hbyFlHTL2eAGgIa3LZadeRRs91kAJjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78lWKQLJRfdW9hexh7XAr98bJYw2kzBvk5KGdMnrw6M=;
        b=OLc7JapXHMP6Nx403kcO39avxOt27MZgw8hmcHEvSPKl1yMmPGy6gLx7QYZZYTuXJJSuqK
        CRKkJaPSKJ2DhGDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk 17/18] printk: Use an output descriptor struct for emit
Date:   Sat, 24 Sep 2022 02:10:53 +0206
Message-Id: <20220924000454.3319186-18-john.ogness@linutronix.de>
In-Reply-To: <20220924000454.3319186-1-john.ogness@linutronix.de>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
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

To prepare for a new console infrastructure that is independent of the
console BKL, wrap the output mode into a descriptor struct so the new
infrastrucure can share the emit code that dumps the ringbuffer record
into the output text buffers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 15 +++++++
 kernel/printk/printk.c  | 88 ++++++++++++++++++++++++++++++-----------
 2 files changed, 79 insertions(+), 24 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 05c7325e98f9..590ab62c01d9 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -187,6 +187,21 @@ struct cons_text_buf {
 	char		text[CONSOLE_LOG_MAX];
 };
 
+/**
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
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9cbd44e9fc45..c9207d81b90c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2689,40 +2689,39 @@ static void __console_unlock(void)
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
+
+/**
+ * cons_fill_outbuf - Fill the output buffer with the next record
+ * @con:	The console to print on
+ * @desc:	Pointer to the output descriptor
  *
- * If dropped messages should be printed, @dropped_text is a buffer of size
- * DROPPED_TEXT_MAX. Otherwise @dropped_text must be NULL.
+ * The output descriptor contains all information which is necessary
+ * to print (buffer pointer, extended format selector...).
  *
- * @handover will be set to true if a printk waiter has taken over the
- * console_lock, in which case the caller is no longer holding the
- * console_lock. Otherwise it is set to false.
+ * Returns: False if there is no pending record in the ringbuffer
+ *	    True if there is a pending record in the ringbuffer.
  *
- * Returns false if the given console has no next record to print, otherwise
- * true.
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
@@ -2739,10 +2738,10 @@ static bool console_emit_next_record(struct console *con, struct cons_text_buf *
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
@@ -2752,6 +2751,47 @@ static bool console_emit_next_record(struct console *con, struct cons_text_buf *
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
@@ -2766,7 +2806,7 @@ static bool console_emit_next_record(struct console *con, struct cons_text_buf *
 	console_lock_spinning_enable();
 
 	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, write_text, len, extmsg ? NULL : txtbuf->dropped_text);
+	call_console_driver(con, desc.outbuf, desc.len, extmsg ? NULL : txtbuf->dropped_text);
 	start_critical_timings();
 
 	con->seq++;
-- 
2.30.2

