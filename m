Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF843653794
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiLUU15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiLUU1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:27:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B525285
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:27:44 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671654457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q4Vu+r5yLKsl2SkQL/uUdW8OcACzMwITXivvlA5+0HQ=;
        b=OTUPHXXdCnU+pDU+UEMFpK3RkC7NxLKhaEygEeKyvIQaAikTHkvv9QvmqTWS4BinHKjJMo
        IuMcxRa+607MGRAY7STLJkEuyFm1R4bdij5vqPPQchPqWqxXVN0TrdMDw6DaeaRbpMj/YG
        KjrMMCTzU8tfteM2csoPoasbYIBXsMSfrwE+O6pf9pGhcFum2PdhtCKXzCCbAtr9ZZPzgj
        UN2HIwYKPp9q5mnWE0Gcg5F4XBwskP9zIbydNhXh3UYGVQjMG49lufvVO7/10YcrVXz5B9
        d6fyfp0kElPPTyTGhSv0U6hHx7B0WmdZhPXjq82RApL+2nEROkRIy3nX+TZEaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671654457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q4Vu+r5yLKsl2SkQL/uUdW8OcACzMwITXivvlA5+0HQ=;
        b=Sr6JyXQfqOGyyrp7Pj+dFRS4t5kkf2BdCWYEDDs3O35b2wFcoLPBsZHLNeuq1SbkMr1Ina
        l4Xt9lN7uuhgopAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 4/6] printk: introduce struct console_buffers
Date:   Wed, 21 Dec 2022 21:33:02 +0106
Message-Id: <20221221202704.857925-5-john.ogness@linutronix.de>
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

Introduce a new struct console_buffers to contain all the buffers
needed to read and format a printk message for console output.
Putting the buffers inside a struct reduces the number of buffer
pointers that need to be tracked. Also, it allows usage of the
sizeof() macro for the buffer sizes, rather than expecting certain
sized buffers being passed in.

Note that since the output buffer for normal consoles is now
CONSOLE_EXT_LOG_MAX instead of CONSOLE_LOG_MAX, multi-line
messages that may have been previously truncated will now be
printed in full. This should be considered a feature and not a bug
since the CONSOLE_LOG_MAX restriction was about limiting static
buffer usage rather than limiting printed text.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h | 10 +++++++
 kernel/printk/printk.c   | 56 ++++++++++++++++++----------------------
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 319bc7ee46f7..f5ebbd392fee 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -81,3 +81,13 @@ u16 printk_parse_prefix(const char *text, int *level,
 
 static inline bool printk_percpu_data_ready(void) { return false; }
 #endif /* CONFIG_PRINTK */
+
+/**
+ * console_buffers - Buffers to read/format/output printk messages.
+ * @outbuf:	After formatting, contains text to output.
+ * @scratchbuf:	Used as temporary ringbuffer reading and string-print space.
+ */
+struct console_buffers {
+	char	outbuf[CONSOLE_EXT_LOG_MAX];
+	char	scratchbuf[LOG_LINE_MAX];
+};
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 55bb065de65f..2e5e2eda1fa1 100644
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
@@ -2747,17 +2739,32 @@ static void __console_unlock(void)
  *
  * Requires the console_lock and the SRCU read lock.
  */
-static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
-				     char *dropped_text, bool *handover, int cookie)
+static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
 {
+	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
+	static char dropped_text[DROPPED_TEXT_MAX];
+	static struct console_buffers cbufs;
+	const size_t scratchbuf_sz = sizeof(cbufs.scratchbuf);
+	const size_t outbuf_sz = sizeof(cbufs.outbuf);
+	char *scratchbuf = &cbufs.scratchbuf[0];
+	char *outbuf = &cbufs.outbuf[0];
 	static int panic_console_dropped;
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
 
@@ -2779,13 +2786,11 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
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
 
@@ -2803,7 +2808,8 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 	console_lock_spinning_enable();
 
 	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, write_text, len, dropped_text);
+	call_console_driver(con, outbuf, len,
+			    is_extended ? NULL : dropped_text);
 	start_critical_timings();
 
 	con->seq++;
@@ -2839,9 +2845,6 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
-	static char dropped_text[DROPPED_TEXT_MAX];
-	static char ext_text[CONSOLE_EXT_LOG_MAX];
-	static char text[CONSOLE_LOG_MAX];
 	bool any_usable = false;
 	struct console *con;
 	bool any_progress;
@@ -2861,16 +2864,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
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

