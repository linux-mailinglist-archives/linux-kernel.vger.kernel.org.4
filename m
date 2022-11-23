Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840CE636E37
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiKWXOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKWXOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:14:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739ABB8572
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:14:16 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669245254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpOUi4hZM07oyPRVgjxj+qDi5g9936QFYUmsuEbCZ8s=;
        b=QQn/XAVQEtN5GlT1O7T6LLtNJGecVagnIyP5bepPSTYdXmr9caQK312pU7kF61/zQHHcja
        SITbmNu+NfbGQzajqSW0KhBJija/Civf4YGMl9GMK7VGxFZ1UzOPUH6/3izLQesNK4nSKI
        cCH+i0f/CPc62Ly9Z1e0loHmoWj62+VehtwdI7nJJDD7USQGjTfdUHUI0A8ocwTd/Z4Syh
        CJvFUVqyqdBA9tosW41VhcW3AfHQ/Dt68t7tCnCKwQcOaQFaRJevGTway0B/IIFvdYYLA/
        vyZbj7BK2O69Ckaf6KBlEJTHvnrBMM52YAW1SSLCgGmGV1g8qRobFX2Gkd7yBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669245254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpOUi4hZM07oyPRVgjxj+qDi5g9936QFYUmsuEbCZ8s=;
        b=Nu0tMTfqSA6a0V+xGV40DqsroZQ5CWfNxABHcURW2PrGgPxY251ku8vWm9PNS0vXGjTjWE
        Z6CTBuVoFpRmZaCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 5/7] printk: Use struct console_buffers
Date:   Thu, 24 Nov 2022 00:19:58 +0106
Message-Id: <20221123231400.614679-6-john.ogness@linutronix.de>
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

Replace the separately allocated output buffers with a single
instance of struct console_buffers.

Note that the buffer size of devkmsg_user.text_buf, when replaced
with console_buffers.text, reduces from CONSOLE_EXT_LOG_MAX to
CONSOLE_LOG_MAX. However, the buffer is only used to read ringbuffer
records. These records have a maximum size of LOG_LINE_MAX, which
is defined as CONSOLE_LOG_MAX - PREFIX_MAX.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 68 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a4854a60e6d8..750559171e30 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -712,11 +712,9 @@ struct devkmsg_user {
 	atomic64_t seq;
 	struct ratelimit_state rs;
 	struct mutex lock;
-	char buf[CONSOLE_EXT_LOG_MAX];
-
 	struct printk_info info;
-	char text_buf[CONSOLE_EXT_LOG_MAX];
 	struct printk_record record;
+	struct console_buffers cbufs;
 };
 
 static __printf(3, 4) __cold
@@ -798,6 +796,8 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
 	struct devkmsg_user *user = file->private_data;
+	const int ext_text_size = sizeof(user->cbufs.ext_text);
+	char *ext_text = &user->cbufs.ext_text[0];
 	struct printk_record *r = &user->record;
 	size_t len;
 	ssize_t ret;
@@ -839,8 +839,8 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		goto out;
 	}
 
-	len = info_print_ext_header(user->buf, sizeof(user->buf), r->info);
-	len += msg_print_ext_body(user->buf + len, sizeof(user->buf) - len,
+	len = info_print_ext_header(ext_text, ext_text_size, r->info);
+	len += msg_print_ext_body(ext_text + len, ext_text_size - len,
 				  &r->text_buf[0], r->info->text_len,
 				  &r->info->dev_info);
 
@@ -851,7 +851,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		goto out;
 	}
 
-	if (copy_to_user(buf, user->buf, len)) {
+	if (copy_to_user(buf, ext_text, len)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -950,7 +950,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 	mutex_init(&user->lock);
 
 	prb_rec_init_rd(&user->record, &user->info,
-			&user->text_buf[0], sizeof(user->text_buf));
+			&user->cbufs.text[0], sizeof(user->cbufs.text));
 
 	atomic64_set(&user->seq, prb_first_valid_seq(prb));
 
@@ -2007,6 +2007,10 @@ static int console_trylock_spinning(void)
 	return 1;
 }
 
+#if DROPPED_TEXT_MAX > CONSOLE_EXT_LOG_MAX
+#error "DROPPED_TEXT_MAX too large for console_buffers->ext_text"
+#endif
+
 /*
  * Call the specified console driver, asking it to write out the specified
  * text and length. If @dropped_text is non-NULL and any records have been
@@ -2741,36 +2745,32 @@ static void __console_unlock(void)
  * Print one record for the given console. The record printed is whatever
  * record is the next available record for the given console.
  *
- * @text is a buffer of size CONSOLE_LOG_MAX.
+ * @cbufs is the console buffers used to string-print the formatted messages.
  *
- * If extended messages should be printed, @ext_text is a buffer of size
- * CONSOLE_EXT_LOG_MAX. Otherwise @ext_text must be NULL.
- *
- * If dropped messages should be printed, @dropped_text is a buffer of size
- * DROPPED_TEXT_MAX. Otherwise @dropped_text must be NULL.
+ * @cookie is the cookie from entering the SRCU read-side critical section.
  *
  * @handover will be set to true if a printk waiter has taken over the
  * console_lock, in which case the caller is no longer holding both the
  * console_lock and the SRCU read lock. Otherwise it is set to false.
  *
- * @cookie is the cookie from the SRCU read lock.
- *
  * Returns false if the given console has no next record to print, otherwise
  * true.
  *
  * Requires the console_lock and the SRCU read lock.
  */
-static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
-				     char *dropped_text, bool *handover, int cookie)
+static bool console_emit_next_record(struct console *con, struct console_buffers *cbufs,
+				     int cookie, bool *handover)
 {
 	static int panic_console_dropped;
 	struct printk_info info;
 	struct printk_record r;
+	size_t write_text_size;
 	unsigned long flags;
+	char *dropped_text;
 	char *write_text;
 	size_t len;
 
-	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
+	prb_rec_init_rd(&r, &info, &cbufs->text[0], sizeof(cbufs->text));
 
 	*handover = false;
 
@@ -2792,13 +2792,20 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
 		goto skip;
 	}
 
-	if (ext_text) {
-		write_text = ext_text;
-		len = info_print_ext_header(ext_text, CONSOLE_EXT_LOG_MAX, r.info);
-		len += msg_print_ext_body(ext_text + len, CONSOLE_EXT_LOG_MAX - len,
+	if (console_srcu_read_flags(con) & CON_EXTENDED) {
+		/* Extended consoles do not print "dropped messages". */
+		dropped_text = NULL;
+
+		write_text = &cbufs->ext_text[0];
+		write_text_size = sizeof(cbufs->ext_text);
+		len = info_print_ext_header(write_text, write_text_size, r.info);
+		len += msg_print_ext_body(write_text + len, write_text_size - len,
 					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
 	} else {
-		write_text = text;
+		/* @ext_text is unused. Use it for "dropped messages". */
+		dropped_text = &cbufs->ext_text[0];
+
+		write_text = &cbufs->text[0];
 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
 	}
 
@@ -2852,9 +2859,7 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
-	static char dropped_text[DROPPED_TEXT_MAX];
-	static char ext_text[CONSOLE_EXT_LOG_MAX];
-	static char text[CONSOLE_LOG_MAX];
+	static struct console_buffers cbufs;
 	bool any_usable = false;
 	struct console *con;
 	bool any_progress;
@@ -2874,16 +2879,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
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
+			progress = console_emit_next_record(con, &cbufs, cookie, handover);
 
 			/*
 			 * If a handover has occurred, the SRCU read lock
-- 
2.30.2

