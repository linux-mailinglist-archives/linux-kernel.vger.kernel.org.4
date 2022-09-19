Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F905BCBFB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiISMig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiISMiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:38:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887C2DA89;
        Mon, 19 Sep 2022 05:38:00 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:37:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663591079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1fUnSqjiKEKylqvXJR33ALXJM27V881K6ijRj4ZLbs=;
        b=xJXAuF0Me3ndB+hLeqEFKzyDkECh2iO5Hg3L7fLfOioCjkNhHI8PGVg/HRDj/Y8qnOxHv2
        NmehyhfhybqgFyupxpvypqaxBzc2TaxB/qYKTEbG+uhcp7NHK5d6VSMWo+z/ZAeuNTuQz6
        uUuBHtdTPLIkfblO7E8UX9wUPKOXvnwmHrQInTvcFSfcgk4W9UPEJZft4tIA2CW9y3yiNY
        HgXfyt5JNyFokyBnzTJWYcAgeirUWjoulk3WMJ/FWZvwjqVOEZOxcuxIoddvVgC/utV3Yn
        4RSp11p7dUbPiU7P7018yukbFG+AoL7i1fBheVC1O3taBA44csHexBIfS7VAxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663591079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1fUnSqjiKEKylqvXJR33ALXJM27V881K6ijRj4ZLbs=;
        b=mEnyV/Q4Q5kDLOw3wXWn0AS/9c1peRuMwALEReLz371S1KEe+kDr2110GUK/gM6Sywk8SV
        Qgb1cXxaMMyf0QDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] dentry: Use preempt_[dis|en]able_nested()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220825164131.402717-3-bigeasy@linutronix.de>
References: <20220825164131.402717-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359107791.401.1079842493025213678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     93f6d4e1893657f07ba3c9e2bfa74b355a0b32f9
Gitweb:        https://git.kernel.org/tip/93f6d4e1893657f07ba3c9e2bfa74b355a0b32f9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 25 Aug 2022 18:41:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 14:35:07 +02:00

dentry: Use preempt_[dis|en]able_nested()

Replace the open coded CONFIG_PREEMPT_RT conditional
preempt_disable/enable() with the new helper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Link: https://lore.kernel.org/r/20220825164131.402717-3-bigeasy@linutronix.de

---
 fs/dcache.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index bb0c4d0..2ee8636 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2597,15 +2597,7 @@ EXPORT_SYMBOL(d_rehash);
 
 static inline unsigned start_dir_add(struct inode *dir)
 {
-	/*
-	 * The caller holds a spinlock (dentry::d_lock). On !PREEMPT_RT
-	 * kernels spin_lock() implicitly disables preemption, but not on
-	 * PREEMPT_RT.  So for RT it has to be done explicitly to protect
-	 * the sequence count write side critical section against a reader
-	 * or another writer preempting, which would result in a live lock.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 	for (;;) {
 		unsigned n = dir->i_dir_seq;
 		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) == n)
@@ -2618,8 +2610,7 @@ static inline void end_dir_add(struct inode *dir, unsigned int n,
 			       wait_queue_head_t *d_wait)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 	wake_up_all(d_wait);
 }
 
