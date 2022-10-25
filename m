Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E7460D546
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiJYUMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJYULj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:11:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2267A774
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ttT6NbRi8PNEZh+vmTM7YkYkKivgXBYrKgPGhOWejO8=; b=CCp5CtY4T2ASXO7NOuGpEDuCUr
        D6t4vGtY4Jh7x11ri+mThqWYX9jTtY9HLfICzpS4f012b0R/vJMwUK0dvPo8jdUI3zbjrekgkGyDd
        1wj7UY+UC1G4hOubbmL1R7N9O+Cf/Z3v2vz4w89B5NXDn9Pk9I5tXmz0gCauho/WDdQLBqP31sMeA
        Eaa5jOAOsz3YdrjHdvt1LTxCrE7vUUoWy1Osae/6CMuOaKXAqDVvvqPw8wimINajbonMTePqD2vMt
        Xu7TxQV5MJrXT3uMz/z6IXdMWjhH6bPzi2DCP3LfZbjkATjOHXFqU2B0AUJKXQp62fMPct8jpVcbY
        OfM9pnBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onQGh-006OK5-Sv; Tue, 25 Oct 2022 20:11:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A678630020C;
        Tue, 25 Oct 2022 22:11:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8E23B2C4502EB; Tue, 25 Oct 2022 22:11:22 +0200 (CEST)
Message-ID: <20221025201057.816175235@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 25 Oct 2022 22:06:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, rostedt@goodmis.org,
        dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        keescook@chromium.org, seanjc@google.com
Subject: [PATCH 2/5] x86/mm: Use mm_alloc() in poking_init()
References: <20221025200656.951281799@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of duplicating init_mm, allocate a fresh mm. The advantage is
that mm_alloc() has much simpler dependencies. Additionally it makes
more conceptual sense, init_mm has no (and must not have) user state
to duplicate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/init.c         |    2 +-
 include/linux/sched/task.h |    1 -
 kernel/fork.c              |    5 -----
 3 files changed, 1 insertion(+), 7 deletions(-)

--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -801,7 +801,7 @@ void __init poking_init(void)
 	spinlock_t *ptl;
 	pte_t *ptep;
 
-	poking_mm = copy_init_mm();
+	poking_mm = mm_alloc();
 	BUG_ON(!poking_mm);
 
 	/*
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -91,7 +91,6 @@ extern void exit_itimers(struct task_str
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
-struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2592,11 +2592,6 @@ struct task_struct * __init fork_idle(in
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


