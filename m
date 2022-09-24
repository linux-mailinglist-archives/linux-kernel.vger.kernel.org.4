Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C145E868D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiIXAG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiIXAFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164B4109512
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:05:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvlJ13+bxfsEO2TjTOyMfmjGv2moKuWTyvjwKl7xhmU=;
        b=kCD0/dKQVs2h8YRmwAm5XdNlXlLkxQNzC09V2CkWaWUAGZ/YCcbcxazVjpahQaeLy1K0m8
        JtwMh8pZ6dywhyR3F83oX/u4jAypstKQ655kgNMwexSCgvSWk7PBg1NsUNV1WT90e0lJQl
        VfHDzCVVbpy3UZpoYkTn43yo7PkKoKL2q/25pQAPutcsmJmkZnPfwVasBli8RTjy34wOSh
        1uTPfuUBd7e8Fggqv9UBGUk9Hvu1tsMjCDkWks/Glh15FQz7JJXon68ohyFF/51+LzHo+F
        ybFJA02D+SlIxYAqqGV1cK3R5HfXUrSG/ZXQSoOctVNt8MAmlnd5+J6E7dGioA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvlJ13+bxfsEO2TjTOyMfmjGv2moKuWTyvjwKl7xhmU=;
        b=x7qBz4LVF7T7QL7ous/E392mWz8ageWoy86Cuo3KZF3stG9lQnLKeaRiKse2MxVDrGOkBp
        X4bf6QQIPMbuvxBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk 18/18] printk: Handle dropped message smarter
Date:   Sat, 24 Sep 2022 02:10:54 +0206
Message-Id: <20220924000454.3319186-19-john.ogness@linutronix.de>
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

No need for an extra buffer type. Regular formatting which needs the '$N
messages dropped' printout can sprintf() it into the unused extended text
buffer.

As a further simplification move the 'dropped' message right in front of
the actual record text and let the write function output it in one go.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 12 +++---
 kernel/printk/printk.c  | 86 +++++++++++++++++++++++++++--------------
 2 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 590ab62c01d9..83563694cc82 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -176,28 +176,26 @@ enum cons_flags {
 /**
  * struct cons_text_buf - console output text buffer
  * @ext_text:		Buffer for extended log format text
- * @dropped_text:	Buffer for dropped text
  * @text:		Buffer for ringbuffer text
  */
 struct cons_text_buf {
-	union {
-		char	ext_text[CONSOLE_EXT_LOG_MAX];
-		char	dropped_text[DROPPED_TEXT_MAX];
-	};
-	char		text[CONSOLE_LOG_MAX];
-};
+	char	ext_text[CONSOLE_EXT_LOG_MAX];
+	char	text[CONSOLE_LOG_MAX];
+} __no_randomize_layout;
 
 /**
  * struct cons_outbuf_desc - console output buffer descriptor
  * @txtbuf:		Pointer to buffer for storing the text
  * @outbuf:		Pointer to the position in @buffer for
  *			writing it out to the device
+ * @dropped:		The dropped count
  * @len:		Message length
  * @extmsg:		Select extended format printing
  */
 struct cons_outbuf_desc {
 	struct cons_text_buf	*txtbuf;
 	char			*outbuf;
+	unsigned long		dropped;
 	unsigned int		len;
 	bool			extmsg;
 };
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c9207d81b90c..14ddd5c9363f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1961,27 +1961,6 @@ static int console_trylock_spinning(void)
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
@@ -2361,10 +2340,6 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  struct dev_printk_info *dev_info) { return 0; }
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
-static void call_console_driver(struct console *con, const char *text, size_t len,
-				char *dropped_text)
-{
-}
 static bool suppress_message_printing(int level) { return false; }
 static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
@@ -2689,6 +2664,46 @@ static void __console_unlock(void)
 	up_console_sem();
 }
 
+/**
+ * cons_print_dropped - Print 'dropped' message if required
+ * @desc:	Pointer to the output descriptor
+ *
+ * Prints the 'dropped' message info the output buffer if @desc->dropped is
+ * not 0 and the regular format is requested. Extended format does not
+ * need this message because it prints the sequence numbers.
+ *
+ * In regular format the extended message buffer is not in use.
+ * So print into it at the beginning and move the resulting string
+ * just in front of the regular text buffer so that the message can
+ * be printed in one go.
+ *
+ * In case of a message this returns with @desc->outbuf and @desc->len
+ * updated. If no message is required then @desc is not modified.
+ */
+static void cons_print_dropped(struct cons_outbuf_desc *desc)
+{
+	struct cons_text_buf *txtbuf = desc->txtbuf;
+	size_t len;
+
+	if (!desc->dropped || desc->extmsg)
+		return;
+
+	if (WARN_ON_ONCE(desc->outbuf != txtbuf->text))
+		return;
+
+	/* Print it into ext_text which is unused */
+	len = snprintf(txtbuf->ext_text, DROPPED_TEXT_MAX,
+		       "** %lu printk messages dropped **\n", desc->dropped);
+	desc->dropped = 0;
+
+	/* Copy it just below text so it goes out with one write */
+	memcpy(txtbuf->text - len, txtbuf->ext_text, len);
+
+	/* Update the descriptor */
+	desc->len += len;
+	desc->outbuf -= len;
+}
+
 
 /**
  * cons_fill_outbuf - Fill the output buffer with the next record
@@ -2742,17 +2757,26 @@ static bool cons_fill_outbuf(struct console *con, struct cons_outbuf_desc *desc)
 	}
 
 	if (desc->extmsg) {
+		/*
+		 * Extended messages do not require "dropped" message
+		 * as that can be seen from the sequence number
+		 */
 		write_text = txtbuf->ext_text;
 		len = info_print_ext_header(write_text, CONSOLE_EXT_LOG_MAX, r.info);
 		len += msg_print_ext_body(write_text + len, CONSOLE_EXT_LOG_MAX - len,
 					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
+		desc->len = len;
+		desc->outbuf = write_text;
 	} else {
-		write_text = txtbuf->text;
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
+
+		desc->len = len;
+		desc->outbuf = txtbuf->text;
+		desc->dropped = con->dropped;
+		cons_print_dropped(desc);
+		con->dropped = desc->dropped;
 	}
 
-	desc->len = len;
-	desc->outbuf = write_text;
 	return true;
 }
 
@@ -2805,8 +2829,10 @@ static bool console_emit_next_record(struct console *con, struct cons_text_buf *
 	printk_safe_enter_irqsave(flags);
 	console_lock_spinning_enable();
 
-	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, desc.outbuf, desc.len, extmsg ? NULL : txtbuf->dropped_text);
+	/* don't trace print latency */
+	stop_critical_timings();
+	/* Write everything out to the hardware */
+	con->write(con, desc.outbuf, desc.len);
 	start_critical_timings();
 
 	con->seq++;
-- 
2.30.2

