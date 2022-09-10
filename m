Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9AA5B4A91
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiIJW3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiIJW2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E5F43333
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:02 -0700 (PDT)
Message-ID: <20220910222301.422514421@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GORp14X0ZPsta6IucVBlmsXp9iduDN+zPIQ5DiLrn3I=;
        b=iMQNCn8ruP6Jx1Gh4WzWgOGiyi+3IGoUmLYw4P1Z5niRDBN4m60017dC1LeiV8lbh9N6pS
        V6I1RzY3iRGq/U/UwagFgVk+SI3pYhLPRkmVl3qkBrofWfVG63ydgghR1Qw1WM5CXfawxh
        MkN/CUdMlVmbnadOJz7UyEbHE6ZkmQLCFGO8lQ0AG0GrgRCe2mySkHFHn5z0Y5MMLBwgEn
        b/gIGoP5Zte0QjN0jSN0tzgzsx/PHMY61suwONVe7uRehoIK2i7YRNHwwjP4VTtmDd0lfE
        W/Q3hy8YqoLrtzvehknIHVpvx8YqD0yR9oiRVEdniup4gNeQuCGvzq51ijuLdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GORp14X0ZPsta6IucVBlmsXp9iduDN+zPIQ5DiLrn3I=;
        b=59bMwLuHY15oRwAWgcslNBmblSP4msdmhJTJnuUN6FzYZmokzKg6IUwUuaL4qA/e+i8XcH
        R9XwkH0jsSjGhABA==
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
Subject: [patch RFC 18/29] printk: Handle dropped message smarter
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:59 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for an extra buffer type. Regular formatting which needs the '$N
messages dropped' printout can sprintf() it into the unused extended text
buffer.

As a further simplification move the 'dropped' message right in front of
the actual record text and let the write function output it in one go.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h |   12 ++----
 kernel/printk/printk.c  |   86 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 61 insertions(+), 37 deletions(-)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -175,28 +175,26 @@ enum cons_flags {
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
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1957,27 +1957,6 @@ static int console_trylock_spinning(void
 }
 
 /*
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
-/*
  * Recursion is tracked separately on each CPU. If NMIs are supported, an
  * additional NMI context per CPU is also separately tracked. Until per-CPU
  * is available, a separate "early tracking" is performed.
@@ -2356,10 +2335,6 @@ static ssize_t msg_print_ext_body(char *
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
@@ -2684,6 +2659,46 @@ static void __console_unlock(void)
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
@@ -2737,17 +2752,26 @@ static bool cons_fill_outbuf(struct cons
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
 
@@ -2800,8 +2824,10 @@ static bool console_emit_next_record(str
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

