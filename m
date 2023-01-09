Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED48366228B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjAIKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbjAIKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:08:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B3B1C1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:08:49 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673258926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJqnYxHgAm5zPWQPXQ8w2S1sD7jcnMKX3VIFczAZH38=;
        b=1EByRzQzhb8tbRlrbFCbzD5+nrEU7ae34iNdqti1AKJsCvff+F8EJIdQKnShLXRjNtCyMk
        pzFgLfbQe4s268Hu/bbClmRcSoW2mxIet/PgIqMGHRJUDKPe7xwiMgRgtDCXo93ugKUoCA
        x4U2kVPQ/Yhzu6YHEmMl+cr7mv+TGcQmzIynuOic3tuyJtS7hX+mrEmZUAIvW2kCPTi6x8
        cYSC2gWk61+8r8gddLm9JBPOQtbuqkdoEzNt2WE5uWfXqnl5h+ibCj00NQLwk94J8Ueb+I
        gvB37aNHy802lVSChD96146Ln3NCZcd+MdfejcBvRTU9HfaIZd0yOa6KGW3vBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673258926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PJqnYxHgAm5zPWQPXQ8w2S1sD7jcnMKX3VIFczAZH38=;
        b=IAQ1RJhglgrijsFvOo0DaKvloLt3um1/8neEecwhxvE1oNmhiHOEx7HpZl4r7r/RwkrLS3
        jZivOpfaIOa5lyCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 7/8] printk: use printk_buffers for devkmsg
Date:   Mon,  9 Jan 2023 11:13:59 +0106
Message-Id: <20230109100800.1085541-8-john.ogness@linutronix.de>
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

Replace the buffers in struct devkmsg_user with a struct
printk_buffers. This reduces the number of buffers to keep track of.

As a side-effect, @text_buf was 8kB large, even though it only
needed to be the max size of a ringbuffer record. By switching to
struct printk_buffers, ~7kB less memory is allocated when opening
/dev/kmsg.

And since struct printk_buffers will be used now, reduce duplicate
code by calling printk_get_next_message() to handle the record
reading and formatting.

Note that since /dev/kmsg never suppresses records based on
loglevel, printk_get_next_message() is extended with an extra
bool argument to specify if suppression is allowed.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 49 +++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 80a49ec6f42b..a72904890a5f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -695,16 +695,15 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return len;
 }
 
+static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+				    bool is_extended, bool may_supress);
+
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	atomic64_t seq;
 	struct ratelimit_state rs;
 	struct mutex lock;
-	char buf[CONSOLE_EXT_LOG_MAX];
-
-	struct printk_info info;
-	char text_buf[CONSOLE_EXT_LOG_MAX];
-	struct printk_record record;
+	struct printk_buffers pbufs;
 };
 
 static __printf(3, 4) __cold
@@ -786,8 +785,10 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *ppos)
 {
 	struct devkmsg_user *user = file->private_data;
-	struct printk_record *r = &user->record;
-	size_t len;
+	char *outbuf = &user->pbufs.outbuf[0];
+	struct printk_message pmsg = {
+		.pbufs = &user->pbufs,
+	};
 	ssize_t ret;
 
 	if (!user)
@@ -797,7 +798,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
+	if (!printk_get_next_message(&pmsg, atomic64_read(&user->seq), true, false)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto out;
@@ -814,36 +815,31 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		 * This pairs with __wake_up_klogd:A.
 		 */
 		ret = wait_event_interruptible(log_wait,
-				prb_read_valid(prb,
-					atomic64_read(&user->seq), r)); /* LMM(devkmsg_read:A) */
+				printk_get_next_message(&pmsg, atomic64_read(&user->seq), true,
+							false)); /* LMM(devkmsg_read:A) */
 		if (ret)
 			goto out;
 	}
 
-	if (r->info->seq != atomic64_read(&user->seq)) {
+	if (pmsg.dropped) {
 		/* our last seen message is gone, return error and reset */
-		atomic64_set(&user->seq, r->info->seq);
+		atomic64_set(&user->seq, pmsg.seq);
 		ret = -EPIPE;
 		goto out;
 	}
 
-	len = info_print_ext_header(user->buf, sizeof(user->buf), r->info);
-	len += msg_print_ext_body(user->buf + len, sizeof(user->buf) - len,
-				  &r->text_buf[0], r->info->text_len,
-				  &r->info->dev_info);
-
-	atomic64_set(&user->seq, r->info->seq + 1);
+	atomic64_set(&user->seq, pmsg.seq + 1);
 
-	if (len > count) {
+	if (pmsg.outbuf_len > count) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (copy_to_user(buf, user->buf, len)) {
+	if (copy_to_user(buf, outbuf, pmsg.outbuf_len)) {
 		ret = -EFAULT;
 		goto out;
 	}
-	ret = len;
+	ret = pmsg.outbuf_len;
 out:
 	mutex_unlock(&user->lock);
 	return ret;
@@ -937,9 +933,6 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 
 	mutex_init(&user->lock);
 
-	prb_rec_init_rd(&user->record, &user->info,
-			&user->text_buf[0], sizeof(user->text_buf));
-
 	atomic64_set(&user->seq, prb_first_valid_seq(prb));
 
 	file->private_data = user;
@@ -2762,12 +2755,14 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
  * @is_extended specifies if the message should be formatted for extended
  * console output.
  *
+ * @may_supress specifies if records may be skipped based on loglevel.
+ *
  * Returns false if no record is available. Otherwise true and all fields
  * of @pmsg are valid. (See the documentation of struct printk_message
  * for information about the @pmsg fields.)
  */
 static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-				    bool is_extended)
+				    bool is_extended, bool may_suppress)
 {
 	static int panic_console_dropped;
 
@@ -2810,7 +2805,7 @@ static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	}
 
 	/* Skip record that has level above the console loglevel. */
-	if (suppress_message_printing(r.info->level))
+	if (may_suppress && suppress_message_printing(r.info->level))
 		goto out;
 
 	if (is_extended) {
@@ -2853,7 +2848,7 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 
 	*handover = false;
 
-	if (!printk_get_next_message(&pmsg, con->seq, is_extended))
+	if (!printk_get_next_message(&pmsg, con->seq, is_extended, true))
 		return false;
 
 	con->dropped += pmsg.dropped;
-- 
2.30.2

