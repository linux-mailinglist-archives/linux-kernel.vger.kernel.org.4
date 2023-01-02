Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1A265B47A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbjABPx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjABPxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:53:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3809AB82;
        Mon,  2 Jan 2023 07:53:24 -0800 (PST)
Date:   Mon, 02 Jan 2023 15:53:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672674801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3P5pISwMYBYCrQ8Yr86Uym3gj8BN/L8IIlaMxfkhy08=;
        b=WDIaj39zarkxIy3RcXAEsQNsau423KjE7KQGAePWyn2aHanx9EtNzS9QA/UuUQq7qwccw7
        zbvJ3sYAi4ReSi1N+H3FOs+IAyQo97tSiIkkNz8wtGdinUMWLFRWxGuq1b5DDSGpfUbCQW
        kFaVmDr39u610okCyxBAKADRvr6VS7khx2vYx5SU/tTS1orbO/QKjbV0DHkpPd+KBvDxeW
        aFMf66M+Mq0US/F/6+GR7INgIMoFzP5wlyLNbRoyYANMt+u+TvJFXhws8VZl2ZmejV1DEL
        DOMX6XAgG8CQZGlgvhmopnzgEJAzbBzwROZZSpTIzoIlOgMarV//96i9wekTxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672674801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3P5pISwMYBYCrQ8Yr86Uym3gj8BN/L8IIlaMxfkhy08=;
        b=lXFeWHI9Gp0KHaqnUtDDEMeHEE750GwMn4AA+3SZWgZVPNAov8+TElRUZJGJyihCOvdXq6
        8anhNCCiB1WxDABQ==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rseq: Fix concurrency ID handling of
 usermodehelper kthreads
Cc:     kernel test robot <yujie.liu@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <202212301353.5c959d72-yujie.liu@intel.com>
References: <202212301353.5c959d72-yujie.liu@intel.com>
MIME-Version: 1.0
Message-ID: <167267480086.4906.14665352998737768536.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bbd0b031509b880b4e9a880bb27ca2a30ad081ab
Gitweb:        https://git.kernel.org/tip/bbd0b031509b880b4e9a880bb27ca2a30ad081ab
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 02 Jan 2023 10:12:16 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Jan 2023 16:34:12 +01:00

sched/rseq: Fix concurrency ID handling of usermodehelper kthreads

sched_mm_cid_after_execve() does not expect NULL t->mm, but it may happen
if a usermodehelper kthread fails when attempting to execute a binary.

sched_mm_cid_fork() can be issued from a usermodehelper kthread, which
has t->flags PF_KTHREAD set.

Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
Reported-by: kernel test robot <yujie.liu@intel.com>
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/oe-lkp/202212301353.5c959d72-yujie.liu@intel.com
---
 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 048ec24..f99ee69 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11343,8 +11343,8 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 	struct mm_struct *mm = t->mm;
 	unsigned long flags;
 
-	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm);
-
+	if (!mm)
+		return;
 	local_irq_save(flags);
 	t->mm_cid = mm_cid_get(mm);
 	t->mm_cid_active = 1;
@@ -11354,7 +11354,7 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 
 void sched_mm_cid_fork(struct task_struct *t)
 {
-	WARN_ON_ONCE((t->flags & PF_KTHREAD) || !t->mm || t->mm_cid != -1);
+	WARN_ON_ONCE(!t->mm || t->mm_cid != -1);
 	t->mm_cid_active = 1;
 }
 #endif
