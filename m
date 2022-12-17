Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2B64FBF5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiLQS6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiLQSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521141122;
        Sat, 17 Dec 2022 10:55:40 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsb0Jky4Qbbe8cnWUN8Cl6XFdmY6ZEPk8sT8k7OCHro=;
        b=VN5BLetsCRuETKO1ufW94UeZ28u1GLfSAxvECKynD1gnBwZHRxarQIKdWyNkgE7ifarx6a
        fVLKvPG5tQNHC+49YpPVMS+RKD2vuZYRzWY/LnbP7o9eSh1Q8Y7PrfxBkuyp4o7Zau1NEJ
        tXcT6IRRTSO6dd81046MOaOoKiKYp6ABg70wucApSS6p1sl3/7uMGyP4J0MNmf7naVOn9k
        6RV6SFAkoHiKIVPDpCXbBwsRRTDXb5rwamL9EEUZzIKKub/cPynGTlyQEq458G6XHuN0sW
        Kl8Rv/fdZkcBWZ4SfEKIhIfLZKBddEkXc3bR1GDCuqashhKziQL/61BJSB3zgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsb0Jky4Qbbe8cnWUN8Cl6XFdmY6ZEPk8sT8k7OCHro=;
        b=iyj2VDJO8dFPaA5iQY4v0exTbC3QaP7dsbQrr8fkKobX72Pj896WAXuWaK4FWsvQuEG3SS
        uaiZ7PtK/Gy5kuCA==
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
Message-ID: <167130333552.4906.17400654465838216645.tip-bot2@tip-bot2>
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

Commit-ID:     3f4c8211d982099be693be9aa7d6fc4607dff290
Gitweb:        https://git.kernel.org/tip/3f4c8211d982099be693be9aa7d6fc4607dff290
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 Oct 2022 21:38:21 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:26 -08:00

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
