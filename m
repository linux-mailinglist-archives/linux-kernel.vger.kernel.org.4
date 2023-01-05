Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ADF65EA8A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjAEMRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjAEMRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:17:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9170CBC87
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:17:00 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672921016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Xh0ofBqr/gGj4H4UF96ZzPTChHhGf7far4SpDmNAdA=;
        b=LyFkvnan5JmFgaO9HtdeolaPWE1BRvcuxzyvr9aleZQaDG+WQFKvXHrisuhywbSyAypOV6
        jhiXPHr984EpDg8vBJCSiKJ5DlqDtv8929zFHuuju1OcPXOmSH9lytjwKgCN7KQxQEXq+L
        nqBtW34kEoFMHPO4MOKDOqcucJPU5Sm5RdrOREALOnso4NPW2P5o20GW/W1Cm7aPV81EWl
        KT73W+0IsA3EKe0dfhuqOopVR/llmSnmtphZamKk2zWvbwcgtvmWJgzjR9gah4UuymntGA
        6e0TBfTVpPbzowyLHom9dsPmZ4OAvq/qLgfckpnmc5U3ZL5IQf6D/B72Vnelrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672921016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Xh0ofBqr/gGj4H4UF96ZzPTChHhGf7far4SpDmNAdA=;
        b=VoUI18fQzb/C9y7fXtAxTfnVEjZK/2+EzjZysUpkX/Iz1kel5HN7qz9i2aFWqJ332LaLUf
        nnkyq9eI2u0fbVAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 7/8 v2] printk: use printk_buffers for devkmsg
In-Reply-To: <87fscpch67.fsf@jogness.linutronix.de>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <20230105103735.880956-8-john.ogness@linutronix.de>
 <87fscpch67.fsf@jogness.linutronix.de>
Date:   Thu, 05 Jan 2023 13:22:16 +0106
Message-ID: <87cz7tch2n.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
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
printk_buffers. This reduces the number of buffers to track.

As a side-effect, @text_buf was 8kB large, even though it only
needed to be the max size of a ringbuffer record. By switching to
struct printk_buffers, ~7kB less memory is allocated when opening
/dev/kmsg.

And since struct printk_buffers will be used now, reduce duplicate
code by calling printk_get_next_message() to handle the record
reading and formatting.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4fb7d29fb05d..32996b0c5d03 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -695,16 +695,14 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return len;
 }
 
+static bool printk_get_next_message(struct printk_message *pmsg, u64 seq, bool is_extended);
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
@@ -786,8 +784,10 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
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
@@ -797,7 +797,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
+	while (!printk_get_next_message(&pmsg, atomic64_read(&user->seq), true)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto out;
@@ -814,36 +814,31 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 		 * This pairs with __wake_up_klogd:A.
 		 */
 		ret = wait_event_interruptible(log_wait,
-				prb_read_valid(prb,
-					atomic64_read(&user->seq), r)); /* LMM(devkmsg_read:A) */
+					       prb_read_valid(prb, atomic64_read(&user->seq),
+							      NULL)); /* LMM(devkmsg_read:A) */
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
+	atomic64_set(&user->seq, pmsg.seq + 1);
 
-	atomic64_set(&user->seq, r->info->seq + 1);
-
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
@@ -937,9 +932,6 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 
 	mutex_init(&user->lock);
 
-	prb_rec_init_rd(&user->record, &user->info,
-			&user->text_buf[0], sizeof(user->text_buf));
-
 	atomic64_set(&user->seq, prb_first_valid_seq(prb));
 
 	file->private_data = user;
-- 
2.30.2
