Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37FD662288
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjAIKJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbjAIKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:08:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F3E30A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:08:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673258925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+zAiTv6Y/GvERKIP0KzA27T536AAHA/aopD1bxgvwI=;
        b=JNT8gIFPAJYoUvQtxs/ab1HfVD7saQv3/plRyYi3APGD2uT/8YbOI9IOKcHWcjk2joFtoU
        ZXADH03yQMgsh3JU1bHNTwcvfonLlPTHmiiPsVz5/Rcgh2gvqrMtNRl4sgiAkrAT0Mi0Fh
        Kz3hKq71iqfcEuFYSFrow4tII6i3FgO30AmMuqBw6Sq6N00tbyy7ycLqzXNp67b7CmfrR6
        2YASPZ3JfTxXqKwfWGGFKbAyKpU2mb9OX18HEZx7myTjENtPqQcuyk0ebF9glVSCy+Q0xW
        bkwKp2EQJgnjhsBMqudsBUkCX/eHDSRgm8noxa610/+HG/BcAgWEUpHecztJ4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673258925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+zAiTv6Y/GvERKIP0KzA27T536AAHA/aopD1bxgvwI=;
        b=Eu92xff/Ilhy02SZlS7FGKobrMXp5lfXIXz0jn7wQzBzjwMPELXDyqjMvmUEB5HtIOZtsQ
        nDo1TB0y3nq8olDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 4/8] printk: introduce struct printk_buffers
Date:   Mon,  9 Jan 2023 11:13:56 +0106
Message-Id: <20230109100800.1085541-5-john.ogness@linutronix.de>
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

Introduce a new struct printk_buffers to contain all the buffers
needed to read and format a printk message for output. Putting the
buffers inside a struct reduces the number of buffer pointers that
need to be tracked. Also, it allows usage of the sizeof() macro for
the buffer sizes, rather than expecting certain sized buffers being
passed in.

Note that since the output buffer for normal consoles is now
CONSOLE_EXT_LOG_MAX instead of CONSOLE_LOG_MAX, multi-line
messages that may have been previously truncated will now be
printed in full. This should be considered a feature and not a bug
since the CONSOLE_LOG_MAX restriction was about limiting static
buffer usage rather than limiting printed text.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h | 10 +++++++
 kernel/printk/printk.c   | 57 ++++++++++++++++++----------------------
 2 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index f394332410c9..6080d289a342 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -82,3 +82,13 @@ u16 printk_parse_prefix(const char *text, int *level,
 
 static inline bool printk_percpu_data_ready(void) { return false; }
 #endif /* CONFIG_PRINTK */
+
+/**
+ * struct printk_buffers - Buffers to read/format/output printk messages.
+ * @outbuf:	After formatting, contains text to output.
+ * @scratchbuf:	Used as temporary ringbuffer reading and string-print space.
+ */
+struct printk_buffers {
+	char	outbuf[CONSOLE_EXT_LOG_MAX];
+	char	scratchbuf[LOG_LINE_MAX];
+};
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 55bb065de65f..bc5d4574c459 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2728,14 +2728,6 @@ static void __console_unlock(void)
  * Print one record for the given console. The record printed is whatever
  * record is the next available record for the given console.
  *
- * @text is a buffer of size CONSOLE_LOG_MAX.
- *
- * If extended messages should be printed, @ext_text is a buffer of size
- * CONSOLE_EXT_LOG_MAX. Otherwise @ext_text must be NULL.
- *
- * If dropped messages should be printed, @dropped_text is a buffer of size
- * DROPPED_TEXT_MAX. Otherwise @dropped_text must be NULL.
- *
  * @handover will be set to true if a printk waiter has taken over the
  * console_lock, in which case the caller is no longer holding both the
  * console_lock and the SRCU read lock. Otherwise it is set to false.
@@ -2747,17 +2739,33 @@ static void __console_unlock(void)
  *
  * Requires the console_lock and the SRCU read lock.
  */
-static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
-				     char *dropped_text, bool *handover, int cookie)
+static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
 {
+	static char dropped_text[DROPPED_TEXT_MAX];
+	static struct printk_buffers pbufs;
 	static int panic_console_dropped;
+
+	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
+	const size_t scratchbuf_sz = sizeof(pbufs.scratchbuf);
+	const size_t outbuf_sz = sizeof(pbufs.outbuf);
+	char *scratchbuf = &pbufs.scratchbuf[0];
+	char *outbuf = &pbufs.outbuf[0];
 	struct printk_info info;
 	struct printk_record r;
 	unsigned long flags;
-	char *write_text;
 	size_t len;
 
-	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
+	/*
+	 * Formatting extended messages requires a separate buffer, so use the
+	 * scratch buffer to read in the ringbuffer text.
+	 *
+	 * Formatting normal messages is done in-place, so read the ringbuffer
+	 * text directly into the output buffer.
+	 */
+	if (is_extended)
+		prb_rec_init_rd(&r, &info, scratchbuf, scratchbuf_sz);
+	else
+		prb_rec_init_rd(&r, &info, outbuf, outbuf_sz);
 
 	*handover = false;
 
@@ -2779,13 +2787,11 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 		goto skip;
 	}
 
-	if (ext_text) {
-		write_text = ext_text;
-		len = info_print_ext_header(ext_text, CONSOLE_EXT_LOG_MAX, r.info);
-		len += msg_print_ext_body(ext_text + len, CONSOLE_EXT_LOG_MAX - len,
+	if (is_extended) {
+		len = info_print_ext_header(outbuf, outbuf_sz, r.info);
+		len += msg_print_ext_body(outbuf + len, outbuf_sz - len,
 					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
 	} else {
-		write_text = text;
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 	}
 
@@ -2803,7 +2809,8 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 	console_lock_spinning_enable();
 
 	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, write_text, len, dropped_text);
+	call_console_driver(con, outbuf, len,
+			    is_extended ? NULL : dropped_text);
 	start_critical_timings();
 
 	con->seq++;
@@ -2839,9 +2846,6 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
-	static char dropped_text[DROPPED_TEXT_MAX];
-	static char ext_text[CONSOLE_EXT_LOG_MAX];
-	static char text[CONSOLE_LOG_MAX];
 	bool any_usable = false;
 	struct console *con;
 	bool any_progress;
@@ -2861,16 +2865,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 				continue;
 			any_usable = true;
 
-			if (console_srcu_read_flags(con) & CON_EXTENDED) {
-				/* Extended consoles do not print "dropped messages". */
-				progress = console_emit_next_record(con, &text[0],
-								    &ext_text[0], NULL,
-								    handover, cookie);
-			} else {
-				progress = console_emit_next_record(con, &text[0],
-								    NULL, &dropped_text[0],
-								    handover, cookie);
-			}
+			progress = console_emit_next_record(con, handover, cookie);
 
 			/*
 			 * If a handover has occurred, the SRCU read lock
-- 
2.30.2

