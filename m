Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19FB65E925
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjAEKjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbjAEKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:38:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F9D3F100
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:38:18 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672915097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFngVp9MQgIEtplZg2ethuU38QZaV6s9fRh+JEWhx2k=;
        b=wE2fq0ItOYe/T63jHnr6N1j++OFCPzFcALhGwI/EE9JbgRzDtO3PTPJuBp8atCCQ0UxD3m
        8EYGIZni4kWumz0580TFQX5hWUeQANCq0c4STJoFbWI7uKtuiIqtaOHRxsGLvy9wLzvblA
        lLZVIoCBeyog7iW9ojMXBn4DRrQJTp6TD/25/wMj6NfodF4EgQ0tJCG4M4OZMZRq3ZPcEK
        9yKPqC80FTgepLyFscb5ChwmfH4uTeET9SoaRd1LHl/TrE6MELzpaCUaQ1eVIweGvcgOev
        Efs9GTblMD5yM4cfrDxDoeAJFR5rIDJPfC8hGyw4XAxJuUCaiQGbse4BYmW56A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672915097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFngVp9MQgIEtplZg2ethuU38QZaV6s9fRh+JEWhx2k=;
        b=NwCHHW9SBE74wrBVwYMTUb/6Ahvf0gJUnQM7cIa7NMnMmIUiEFoxu596f84Op59if2f6hB
        SoATAqxLlcgzqmCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 7/8] printk: use printk_buffers for devkmsg
Date:   Thu,  5 Jan 2023 11:43:34 +0106
Message-Id: <20230105103735.880956-8-john.ogness@linutronix.de>
In-Reply-To: <20230105103735.880956-1-john.ogness@linutronix.de>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
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

Replace the individual @text_buf and @buf buffers in struct
devkmsg_user with a struct printk_buffers. This reduces the number
of buffers to keep track of. Also, since @text_buf is only used for
ringbuffer reading and @buf is only used for output, it maps
perfectly to the purpose and fields of struct printk_buffers.

As a side-effect, @text_buf was 8kB large, even though it only
needed to be the max size of a ringbuffer record. By switching to
struct printk_buffers, ~7kB less memory is allocated when opening
/dev/kmsg.

And since struct printk_buffers will be used now, reduce duplicate
code by calling printk_get_next_message() to handle the record
reading and formatting.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4fb7d29fb05d..e28a3736a399 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -695,15 +695,16 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
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
 
+	struct printk_buffers pbufs;
 	struct printk_info info;
-	char text_buf[CONSOLE_EXT_LOG_MAX];
 	struct printk_record record;
 };
 
@@ -787,7 +788,10 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 {
 	struct devkmsg_user *user = file->private_data;
 	struct printk_record *r = &user->record;
-	size_t len;
+	char *outbuf = &user->pbufs.outbuf[0];
+	struct printk_message pmsg = {
+		.pbufs = &user->pbufs,
+	};
 	ssize_t ret;
 
 	if (!user)
@@ -797,7 +801,7 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 
-	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
+	if (!printk_get_next_message(&pmsg, atomic64_read(&user->seq), true)) {
 		if (file->f_flags & O_NONBLOCK) {
 			ret = -EAGAIN;
 			goto out;
@@ -820,30 +824,25 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
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
@@ -937,9 +936,6 @@ static int devkmsg_open(struct inode *inode, struct file *file)
 
 	mutex_init(&user->lock);
 
-	prb_rec_init_rd(&user->record, &user->info,
-			&user->text_buf[0], sizeof(user->text_buf));
-
 	atomic64_set(&user->seq, prb_first_valid_seq(prb));
 
 	file->private_data = user;
-- 
2.30.2

