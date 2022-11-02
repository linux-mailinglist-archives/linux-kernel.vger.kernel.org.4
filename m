Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29173615F52
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiKBJO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiKBJNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:13:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F10F2935B;
        Wed,  2 Nov 2022 02:12:55 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBGb15kTgZTC7LVKUgw7F/Ft/+M/1NqTiaauPnWiM6A=;
        b=n4SrdBuILriDh71DF6zX5KTeg1RrX6uOwHjQJEqXSJlcDmR/vDqtBU6aRCvygAeE6P9ngA
        3loIOS4KAPxPt2jNZmz3/v0V3Bcmx+U8G1HJsFJkteAIjAymUepcT7UfDei1M/TVhQ1f1L
        tqv78Hoa7M30ASJo6Hh8yd5CeJbtBHyPs7IoRB7F7lvA70E/ylGkLPNiqjyorp0xyik6xj
        XfKoxoIaBZuhdjDh27pSDLFhwhZ6XyqMHKzAuRD4wAzfzLrsk2VyHJYCULSwNxkjLJ3nTs
        nxlovx1QHVzvL2T+41c04R9invFV5qixfHrCHyED+xmXWryhUKeaMDJgUMIg1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBGb15kTgZTC7LVKUgw7F/Ft/+M/1NqTiaauPnWiM6A=;
        b=VzzbJVcGoVnWOG+f3D4AbeYFwn1tqq70rL+JUGpF2e4GE1jMX62aCxsVsG9RyHvO5s9vCV
        qAJJCn5lUB4GqCCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Use mm_alloc() in poking_init()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221025201057.816175235@infradead.org>
References: <20221025201057.816175235@infradead.org>
MIME-Version: 1.0
Message-ID: <166738037248.7716.549727763487721317.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     107b6828a7cde2de0bb293588a59892831cef78b
Gitweb:        https://git.kernel.org/tip/107b6828a7cde2de0bb293588a59892831cef78b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 Oct 2022 21:38:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:43:57 +01:00

x86/mm: Use mm_alloc() in poking_init()

Instead of duplicating init_mm, allocate a fresh mm. The advantage is
that mm_alloc() has much simpler dependencies. Additionally it makes
more conceptual sense, init_mm has no (and must not have) user state
to duplicate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221025201057.816175235@infradead.org
---
 arch/x86/mm/init.c         | 2 +-
 include/linux/sched/task.h | 1 -
 kernel/fork.c              | 5 -----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 9121bc1..d398735 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -801,7 +801,7 @@ void __init poking_init(void)
 	spinlock_t *ptl;
 	pte_t *ptep;
 
-	poking_mm = copy_init_mm();
+	poking_mm = mm_alloc();
 	BUG_ON(!poking_mm);
 
 	/*
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 8431558..357e006 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -91,7 +91,6 @@ extern void exit_itimers(struct task_struct *);
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
-struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
diff --git a/kernel/fork.c b/kernel/fork.c
index 451ce80..6142c58 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2592,11 +2592,6 @@ struct task_struct * __init fork_idle(int cpu)
 	return task;
 }
 
-struct mm_struct *copy_init_mm(void)
-{
-	return dup_mm(NULL, &init_mm);
-}
-
 /*
  * This is like kernel_clone(), but shaved down and tailored to just
  * creating io_uring workers. It returns a created task, or an error pointer.
