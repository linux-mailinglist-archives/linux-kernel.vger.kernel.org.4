Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E4D60C9D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiJYKUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiJYKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:20:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC22844C8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DjXepxNPJZM9WeGFGyCk7tecJIj7w8MriInuhabblEA=; b=I6f/zNdLkRb8I28PTdlQgqxwR3
        EaRX7br506XeDYlHd7Sjwn+U/tsd/r4cPM2qHUuqGXrUyQ5R0y9sKIh1drHUQPJPqnSkyMqEDnX+/
        P9meHwTvxToWxkr8sYUr1SG+PSP5O4plqeQLSqaBVOQkVpChJqJjqo58CqZfluvoPbvtIqJUQLQjm
        CZOxH7kHpxY/71ihEJEQhRDcYY4R91cZZ5y0HgWHUv5ubap3m8jLwARrU/Tnfyko+eVHOSY+Z4kdW
        pOvPjH6gB7KgbY0hzdLC1HaZHumAh8Q7+JgAUs2/n2azumqm4BvNHT6BFz5H5xZ5obWYAu1it1TBL
        nFnbn64A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onGzJ-00GArq-I5; Tue, 25 Oct 2022 10:16:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A0E8330017D;
        Tue, 25 Oct 2022 12:16:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81DE02C431FA7; Tue, 25 Oct 2022 12:16:43 +0200 (CEST)
Date:   Tue, 25 Oct 2022 12:16:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/mm: Do not verify W^X at boot up
Message-ID: <Y1e3i3RJRxOHTcJS@hirez.programming.kicks-ass.net>
References: <20221024114536.44686c83@gandalf.local.home>
 <CAHk-=wj9xBsbeoiFCBLrr3y_CdMOzNh=fD3rr_kcxYwL6vV0Jw@mail.gmail.com>
 <20221024145250.08cfc147@gandalf.local.home>
 <CAHk-=wjRpCS3oAJHVfByDoaj0-tAhV5a5YKV7QssUdMOAm8bAg@mail.gmail.com>
 <Y1eu2wFVp1zcLg5b@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1eu2wFVp1zcLg5b@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:39:39AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 24, 2022 at 12:08:49PM -0700, Linus Torvalds wrote:
> > I suspect it would be fixed by just moving 'poking_init()' earlier. In
> > many ways I suspect it would make most sense as part of 'mm_init()',
> > not as a random call fairly late in start_kernel().
> 
> dup_mm() doesn't work until after proc_caches_init() at the very least.
> 
> Let me see if I can untangle some of this..

This seems to boot...

---
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 19221d77dc27..ac341df0e22c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1756,11 +1756,6 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
 {
 	struct text_poke_loc *tp;
 
-	if (unlikely(system_state == SYSTEM_BOOTING)) {
-		text_poke_early(addr, opcode, len);
-		return;
-	}
-
 	text_poke_flush(addr);
 
 	tp = &tp_vec[tp_vec_nr++];
@@ -1782,11 +1777,6 @@ void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *
 {
 	struct text_poke_loc tp;
 
-	if (unlikely(system_state == SYSTEM_BOOTING)) {
-		text_poke_early(addr, opcode, len);
-		return;
-	}
-
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index cf15ef5aecff..7ea412f7b9da 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -421,8 +421,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
-	if (likely(system_state != SYSTEM_BOOTING))
-		set_memory_ro((unsigned long)trampoline, npages);
+	set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
 	return (unsigned long)trampoline;
 fail:
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 9121bc1b9453..d18c45e5d6d7 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -792,6 +792,8 @@ void __init init_mem_mapping(void)
 	early_memtest(0, max_pfn_mapped << PAGE_SHIFT);
 }
 
+static struct mm_struct __poking_mm;
+
 /*
  * Initialize an mm_struct to be used during poking and a pointer to be used
  * during patching.
@@ -801,8 +803,9 @@ void __init poking_init(void)
 	spinlock_t *ptl;
 	pte_t *ptep;
 
-	poking_mm = copy_init_mm();
-	BUG_ON(!poking_mm);
+	__poking_mm = init_mm;
+	mm_init(&__poking_mm, NULL, __poking_mm.user_ns);
+	poking_mm = &__poking_mm;
 
 	/*
 	 * Randomize the poking address, but make sure that the following page
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index d6c48163c6de..8b099a70f291 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -90,7 +90,7 @@ extern void exit_itimers(struct task_struct *);
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
-struct mm_struct *copy_init_mm(void);
+struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p, struct user_namespace *user_ns);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
diff --git a/init/main.c b/init/main.c
index aa21add5f7c5..da5f1c1afc12 100644
--- a/init/main.c
+++ b/init/main.c
@@ -995,6 +995,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	sort_main_extable();
 	trap_init();
 	mm_init();
+	poking_init();
 
 	ftrace_init();
 
@@ -1134,7 +1135,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	taskstats_init_early();
 	delayacct_init();
 
-	poking_init();
 	check_bugs();
 
 	acpi_subsystem_init();
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d..7a3e8819d95a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1104,7 +1104,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 #endif
 }
 
-static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
+struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
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
