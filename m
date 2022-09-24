Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADD15E868C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiIXAGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiIXAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1645E109511
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:05:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0Yr9YW9TkpwabOV/sHvy2PFM1n82pdEktGbtb5murQ=;
        b=pRspcof7dev0g0OhwKuoPG86gDWlJ1ZEhtPbx6gyoLUo39VTSMywDrerPzLG6K/ItIx+Bv
        apeM5DVHv5ctqgLlpggdpnJSTlKiVA2FbAg43SwOoX611jCRp6EqXNo8m9tdaQU9Az7gvL
        0D4Htso+MATZ6pQ4ST4aEjS8cEFol1Huz4FhKswLxgzewkKNslm8hjMI9fYwlEfXt47Zci
        m3uGtkpSLq2hHTCyzBgkCflWaGN9NdyE6mOFhrwf7HeLKmcM/3uW8JxwNY9dR7snM7MAFh
        Q7w6xCOxhq6U2gc1rHvaD56bIh/dE3Tmqz41wffwmzMLSNVayOuczuug9UJ5Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0Yr9YW9TkpwabOV/sHvy2PFM1n82pdEktGbtb5murQ=;
        b=VpTag6ljA+TeusULrPuefsh0OY8EKJGqTb1bkBdw4OKmqq/skFEd8GfEGrWclajSyoI5RA
        1SmU1dq3YkrIsfDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk 16/18] printk: Use struct cons_text_buf
Date:   Sat, 24 Sep 2022 02:10:52 +0206
Message-Id: <20220924000454.3319186-17-john.ogness@linutronix.de>
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

Replace the separately allocated output buffers with a single instance of
struct cons_text_buf.

Note that the buffer size of devkmsg_user.text_buf, when replaced with
cons_text_buf.text, reduces from CONSOLE_EXT_LOG_MAX to CONSOLE_LOG_MAX.
However, the buffer is only used to read ringbuffer records, which have
a maximum size of LOG_LINE_MAX (CONSOLE_LOG_MAX - PREFIX_MAX).

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 50 ++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 65e9903d066f..9cbd44e9fc45 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -671,11 +671,9 @@ struct devkmsg_user {
 	atomic64_t seq;
 	struct ratelimit_state rs;
 	struct mutex lock;
-	char buf[CONSOLE_EXT_LOG_MAX];
-
 	struct printk_info info;
-	char text_buf[CONSOLE_EXT_LOG_MAX];
 	struct printk_record record;
+	struct cons_text_buf txtbuf;
 };
 
 static __printf(3, 4) __cold
@@ -758,6 +756,8 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 {
 	struct devkmsg_user *user = file->private_data;
 	struct printk_record *r = &user->record;
+	char *outbuf = user->txtbuf.ext_text;
+	const int maxlen = sizeof(user->txtbuf.ext_text);
 	size_t len;
 	ssize_t ret;
 
@@ -798,8 +798,8 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		goto out;
 	}
 
-	len = info_print_ext_header(user->buf, sizeof(user->buf), r->info);
-	len += msg_print_ext_body(user->buf + len, sizeof(user->buf) - len,
+	len = info_print_ext_header(outbuf, maxlen, r->info);
+	len += msg_print_ext_body(outbuf + len, maxlen - len,
 				  &r->text_buf[0], r->info->text_len,
 				  &r->info->dev_info);
 
@@ -810,7 +810,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		goto out;
 	}
 
-	if (copy_to_user(buf, user->buf, len)) {
+	if (copy_to_user(buf, outbuf, len)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -909,7 +909,8 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	mutex_init(&user->lock);
 
 	prb_rec_init_rd(&user->record, &user->info,
-			&user->text_buf[0], sizeof(user->text_buf));
+			user->txtbuf.text,
+			sizeof(user->txtbuf.text));
 
 	atomic64_set(&user->seq, prb_first_valid_seq(prb));
 
@@ -2709,8 +2710,8 @@ static void __console_unlock(void)
  *
  * Requires the console_lock.
  */
-static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
-				     char *dropped_text, bool *handover)
+static bool console_emit_next_record(struct console *con, struct cons_text_buf *txtbuf,
+				     bool *handover, bool extmsg)
 {
 	static int panic_console_dropped;
 	struct printk_info info;
@@ -2719,7 +2720,7 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 	char *write_text;
 	size_t len;
 
-	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
+	prb_rec_init_rd(&r, &info, txtbuf->text, CONSOLE_LOG_MAX);
 
 	*handover = false;
 
@@ -2741,13 +2742,13 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 		goto skip;
 	}
 
-	if (ext_text) {
-		write_text = ext_text;
-		len = info_print_ext_header(ext_text, CONSOLE_EXT_LOG_MAX, r.info);
-		len += msg_print_ext_body(ext_text + len, CONSOLE_EXT_LOG_MAX - len,
+	if (extmsg) {
+		write_text = txtbuf->ext_text;
+		len = info_print_ext_header(write_text, CONSOLE_EXT_LOG_MAX, r.info);
+		len += msg_print_ext_body(write_text + len, CONSOLE_EXT_LOG_MAX - len,
 					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
 	} else {
-		write_text = text;
+		write_text = txtbuf->text;
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 	}
 
@@ -2765,7 +2766,7 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 	console_lock_spinning_enable();
 
 	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, write_text, len, dropped_text);
+	call_console_driver(con, write_text, len, extmsg ? NULL : txtbuf->dropped_text);
 	start_critical_timings();
 
 	con->seq++;
@@ -2801,9 +2802,7 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
-	static char dropped_text[DROPPED_TEXT_MAX];
-	static char ext_text[CONSOLE_EXT_LOG_MAX];
-	static char text[CONSOLE_LOG_MAX];
+	static struct cons_text_buf txtbuf;
 	bool any_usable = false;
 	struct console *con;
 	bool any_progress;
@@ -2821,16 +2820,9 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 				continue;
 			any_usable = true;
 
-			if (con->flags & CON_EXTENDED) {
-				/* Extended consoles do not print "dropped messages". */
-				progress = console_emit_next_record(con, &text[0],
-								    &ext_text[0], NULL,
-								    handover);
-			} else {
-				progress = console_emit_next_record(con, &text[0],
-								    NULL, &dropped_text[0],
-								    handover);
-			}
+			progress = console_emit_next_record(con, &txtbuf, handover,
+							    con->flags & CON_EXTENDED);
+
 			if (*handover)
 				return false;
 
-- 
2.30.2

