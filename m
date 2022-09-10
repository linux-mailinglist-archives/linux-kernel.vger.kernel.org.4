Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9202B5B4A90
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiIJW3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiIJW2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D5D43E7F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:59 -0700 (PDT)
Message-ID: <20220910222301.310153421@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Q4EKtLdKBpGBLYI/18LY67PpRmzH0E6rK3cfFzsdadQ=;
        b=NG4Uzw1YXjlcA334ks/2vKNcR5dhcaFrdgFDuMepIGsO38GRgb8G0ZXrWBYjwXCcjq+peY
        drotznovja8BcO1DvycSzG+KBNEtF6ujE7MBUvq/7skG1NViJI8dlg57khxTkL+WMfgqko
        unwT+nsTl5P8kiujhofC3s+MYjCSwmH8FYrN2DiIGmUFNwIt0KQcl1cFSXnEmilc2nvqxt
        vnzAEG6ht4EmSyDhdxWQ59/bkY/EUrspUoVX8dWxpZR4zWg3v/zLADAiVVR2C3LEOqZoqv
        4zZfHQElfb+W2d2QcPC0cej6bKvQBHbYVeHw7J85zjGuxKEU376d8K9BL2ul+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Q4EKtLdKBpGBLYI/18LY67PpRmzH0E6rK3cfFzsdadQ=;
        b=K43vbXpQMewswxlD0ROcI9fs5ZnsPtTRbWvgs3WG1ThyCcVXiwlvDDmwInsrUeMWv+YZWQ
        WRbG5KgbLTjtsxCg==
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
Subject: [patch RFC 16/29] printk: Use struct cons_text_buf
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:56 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the seperately allocated output buffers with a single instance of
struct cons_text_buf.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/printk/printk.c |   50 ++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -666,11 +666,9 @@ struct devkmsg_user {
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
@@ -753,6 +751,8 @@ static ssize_t devkmsg_read(struct file
 {
 	struct devkmsg_user *user = file->private_data;
 	struct printk_record *r = &user->record;
+	char *outbuf = user->txtbuf.ext_text;
+	const int maxlen = sizeof(user->txtbuf.ext_text);
 	size_t len;
 	ssize_t ret;
 
@@ -793,8 +793,8 @@ static ssize_t devkmsg_read(struct file
 		goto out;
 	}
 
-	len = info_print_ext_header(user->buf, sizeof(user->buf), r->info);
-	len += msg_print_ext_body(user->buf + len, sizeof(user->buf) - len,
+	len = info_print_ext_header(outbuf, maxlen, r->info);
+	len += msg_print_ext_body(outbuf + len, maxlen - len,
 				  &r->text_buf[0], r->info->text_len,
 				  &r->info->dev_info);
 
@@ -805,7 +805,7 @@ static ssize_t devkmsg_read(struct file
 		goto out;
 	}
 
-	if (copy_to_user(buf, user->buf, len)) {
+	if (copy_to_user(buf, outbuf, len)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -904,7 +904,8 @@ static int devkmsg_open(struct inode *in
 	mutex_init(&user->lock);
 
 	prb_rec_init_rd(&user->record, &user->info,
-			&user->text_buf[0], sizeof(user->text_buf));
+			user->txtbuf.text,
+			sizeof(user->txtbuf.text));
 
 	atomic64_set(&user->seq, prb_first_valid_seq(prb));
 
@@ -2704,8 +2705,8 @@ static void __console_unlock(void)
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
@@ -2714,7 +2715,7 @@ static bool console_emit_next_record(str
 	char *write_text;
 	size_t len;
 
-	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
+	prb_rec_init_rd(&r, &info, txtbuf->text, CONSOLE_LOG_MAX);
 
 	*handover = false;
 
@@ -2736,13 +2737,13 @@ static bool console_emit_next_record(str
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
 
@@ -2760,7 +2761,7 @@ static bool console_emit_next_record(str
 	console_lock_spinning_enable();
 
 	stop_critical_timings();	/* don't trace print latency */
-	call_console_driver(con, write_text, len, dropped_text);
+	call_console_driver(con, write_text, len, extmsg ? NULL : txtbuf->dropped_text);
 	start_critical_timings();
 
 	con->seq++;
@@ -2796,9 +2797,7 @@ static bool console_emit_next_record(str
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
@@ -2816,16 +2815,9 @@ static bool console_flush_all(bool do_co
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
 

