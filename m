Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D2D6CCC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjC1Vq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjC1Vq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:46:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCD6B1712
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 14:46:55 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id E93B120FDA86;
        Tue, 28 Mar 2023 14:46:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E93B120FDA86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680040015;
        bh=5B2i+VHjiu+ubqKoN1kwXRD7hgJa5VH8yOvgkhGgb4o=;
        h=Subject:From:Cc:Date:From;
        b=bVJy7siypq98zpsZ4UGlciijsRdOt02pMb0+1UGTYnBeNPJjOKZcj6De5nKHMKSbb
         kMsSfT15YbCSdocn+371A517/9UGdM0vGS1YFLUPO9zyx2tUvjC7Fqpu1TjRMuXPW8
         O7RPTDaweZIwHJXxcn4cvJAi0mxioF+qFB0FFfXg=
Subject: [PATCH] printk: Remove obsoleted check for non-existent "user" object
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Mon, 20 Mar 2023 00:02:01 -0700
Message-ID: <167929571877.2810.9926967619100618792.stgit@skinsburskii.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.6 required=5.0 tests=DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        MISSING_HEADERS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>

The original check for non-null "user" object was introduced by commit
e11fea92e13f ("kmsg: export printk records to the /dev/kmsg interface") when
"user" could be NULL if /dev/ksmg was opened for writing.

Subsequent change 750afe7babd1 ("printk: add kernel parameter to control
writes to /dev/kmsg") made "user" context required for files opened for write,
but didn't remove now redundant checks for it to be non-NULL.

This patch removes the dead code while preserving the current logic.

Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburski@gmail.com>
CC: Petr Mladek <pmladek@suse.com>
CC: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: John Ogness <john.ogness@linutronix.de>
CC: linux-kernel@vger.kernel.org
---
 kernel/printk/printk.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fd0c9f913940..9644f6e5bf15 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -730,7 +730,7 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 	size_t len = iov_iter_count(from);
 	ssize_t ret = len;
 
-	if (!user || len > PRINTKRB_RECORD_MAX)
+	if (len > PRINTKRB_RECORD_MAX)
 		return -EINVAL;
 
 	/* Ignore when user logging is disabled. */
@@ -792,9 +792,6 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
 	};
 	ssize_t ret;
 
-	if (!user)
-		return -EBADF;
-
 	ret = mutex_lock_interruptible(&user->lock);
 	if (ret)
 		return ret;
@@ -859,8 +856,6 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 	struct devkmsg_user *user = file->private_data;
 	loff_t ret = 0;
 
-	if (!user)
-		return -EBADF;
 	if (offset)
 		return -ESPIPE;
 
@@ -893,9 +888,6 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
 	struct printk_info info;
 	__poll_t ret = 0;
 
-	if (!user)
-		return EPOLLERR|EPOLLNVAL;
-
 	poll_wait(file, &log_wait, wait);
 
 	if (prb_read_valid_info(prb, atomic64_read(&user->seq), &info, NULL)) {
@@ -944,9 +936,6 @@ static int devkmsg_release(struct inode *inode, struct file *file)
 {
 	struct devkmsg_user *user = file->private_data;
 
-	if (!user)
-		return 0;
-
 	ratelimit_state_exit(&user->rs);
 
 	mutex_destroy(&user->lock);


