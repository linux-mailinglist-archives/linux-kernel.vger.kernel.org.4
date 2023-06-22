Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2373A396
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjFVOul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjFVOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:50:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C68E7E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=MiQXciH6QFUFwWGYzaBS9NluMPpHBbDeC6AdeQsFuMU=; b=PtHif4EwoZQlLcVEpXtJWFpyNU
        GdRXNWxLm1HEbFx6U8QdziOOM12seJlecoI+n0+mMvvz+/ztcAigWigR+dwcmRxzZck1qORCqq8sT
        q9LWokguxzNnDdk1UiG+CModRKKD0c4DKPlJaFTWzm0C7l8IHM6hisuT5OhYEdnDwAXkW9f17rvQy
        mAu1O26d9XVgA8jeuPMbkBDAH+tKiaHWJLB1ejxjnjq2fbgxHbC/WyILXuGZu5R/oWOTCNeJ50V4x
        JeDs/HkDewn8XeSyWsT/9xXKCO8zkVNfxVgYDAq4vLVGHbgUSgZ5QalZci7uTz6TTRu6jQRYTgYgs
        UHklGcLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCLdh-001CzU-36;
        Thu, 22 Jun 2023 14:50:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 771CB300794;
        Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 24D9B209D8B3C; Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Message-ID: <20230622144321.629918727@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Jun 2023 16:42:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, alyssa.milburn@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        samitolvanen@google.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com, brgerst@gmail.com
Subject: [PATCH v2 5/6] x86: Rewrite ret_from_fork() in C
References: <20230622144218.860926475@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst <brgerst@gmail.com>

When kCFI is enabled, special handling is needed for the indirect call
to the kernel thread function.  Rewrite the ret_from_fork() function in
C so that the compiler can properly handle the indirect call.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230622120750.5549-3-brgerst@gmail.com
---
 arch/x86/entry/entry_32.S        |   30 +++++++-----------------------
 arch/x86/entry/entry_64.S        |   35 ++++++++++-------------------------
 arch/x86/include/asm/switch_to.h |    4 +++-
 arch/x86/kernel/process.c        |   22 +++++++++++++++++++++-
 4 files changed, 41 insertions(+), 50 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -727,37 +727,21 @@ SYM_CODE_END(__switch_to_asm)
  * edi: kernel thread arg
  */
 .pushsection .text, "ax"
-SYM_CODE_START(ret_from_fork)
+SYM_CODE_START(ret_from_fork_asm)
 	/* return address for the stack unwinder */
 	pushl	$.Lsyscall_32_done
 	FRAME_BEGIN
 
-	pushl	%eax
-	call	schedule_tail
+	/* prev already in EAX */
+	movl	%esp, %edx	/* regs */
+	movl	%ebx, %ecx	/* fn */
+	pushl	%edi		/* fn_arg */
+	call	ret_from_fork
 	addl	$4, %esp
 
-	testl	%ebx, %ebx
-	jnz	1f		/* kernel threads are uncommon */
-
-2:
-	/* When we fork, we trace the syscall return in the child, too. */
-	movl    %esp, %eax
-	call    syscall_exit_to_user_mode
-
 	FRAME_END
 	RET
-
-	/* kernel thread */
-1:	movl	%edi, %eax
-	CALL_NOSPEC ebx
-	/*
-	 * A kernel thread is allowed to return here after successfully
-	 * calling kernel_execve().  Exit to userspace to complete the execve()
-	 * syscall.
-	 */
-	movl	$0, PT_EAX(%esp)
-	jmp	2b
-SYM_CODE_END(ret_from_fork)
+SYM_CODE_END(ret_from_fork_asm)
 .popsection
 
 SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -284,36 +284,21 @@ SYM_FUNC_END(__switch_to_asm)
  * r12: kernel thread arg
  */
 .pushsection .text, "ax"
-	__FUNC_ALIGN
-SYM_CODE_START_NOALIGN(ret_from_fork)
+SYM_CODE_START(ret_from_fork_asm)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR // copy_thread
 	CALL_DEPTH_ACCOUNT
-	movq	%rax, %rdi
-	call	schedule_tail			/* rdi: 'prev' task parameter */
 
-	testq	%rbx, %rbx			/* from kernel_thread? */
-	jnz	1f				/* kernel threads are uncommon */
+	/* return address for the stack unwinder */
+	pushq	$swapgs_restore_regs_and_return_to_usermode
+	UNWIND_HINT_FUNC
 
-2:
-	UNWIND_HINT_REGS
-	movq	%rsp, %rdi
-	call	syscall_exit_to_user_mode	/* returns with IRQs disabled */
-	jmp	swapgs_restore_regs_and_return_to_usermode
-
-1:
-	/* kernel thread */
-	UNWIND_HINT_END_OF_STACK
-	movq	%r12, %rdi
-	CALL_NOSPEC rbx
-	/*
-	 * A kernel thread is allowed to return here after successfully
-	 * calling kernel_execve().  Exit to userspace to complete the execve()
-	 * syscall.
-	 */
-	movq	$0, RAX(%rsp)
-	jmp	2b
-SYM_CODE_END(ret_from_fork)
+	movq	%rax, %rdi		/* prev */
+	movq	%rsp, %rsi		/* regs */
+	movq	%rbx, %rdx		/* fn */
+	movq	%r12, %rcx		/* fn_arg */
+	jmp	ret_from_fork
+SYM_CODE_END(ret_from_fork_asm)
 .popsection
 
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -12,7 +12,9 @@ struct task_struct *__switch_to_asm(stru
 __visible struct task_struct *__switch_to(struct task_struct *prev,
 					  struct task_struct *next);
 
-asmlinkage void ret_from_fork(void);
+asmlinkage void ret_from_fork_asm(void);
+__visible void ret_from_fork(struct task_struct *prev, struct pt_regs *regs,
+			     int (*fn)(void *), void *fn_arg);
 
 /*
  * This is the structure pointed to by thread.sp for an inactive task.  The
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -28,6 +28,7 @@
 #include <linux/static_call.h>
 #include <trace/events/power.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/entry-common.h>
 #include <asm/cpu.h>
 #include <asm/apic.h>
 #include <linux/uaccess.h>
@@ -134,6 +135,25 @@ static int set_new_tls(struct task_struc
 		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
 }
 
+__visible void ret_from_fork(struct task_struct *prev, struct pt_regs *regs,
+			     int (*fn)(void *), void *fn_arg)
+{
+	schedule_tail(prev);
+
+	/* Is this a kernel thread? */
+	if (unlikely(fn)) {
+		fn(fn_arg);
+		/*
+		 * A kernel thread is allowed to return here after successfully
+		 * calling kernel_execve().  Exit to userspace to complete the
+		 * execve() syscall.
+		 */
+		regs->ax = 0;
+	}
+
+	syscall_exit_to_user_mode(regs);
+}
+
 int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 {
 	unsigned long clone_flags = args->flags;
@@ -149,7 +169,7 @@ int copy_thread(struct task_struct *p, c
 	frame = &fork_frame->frame;
 
 	frame->bp = encode_frame_pointer(childregs);
-	frame->ret_addr = (unsigned long) ret_from_fork;
+	frame->ret_addr = (unsigned long) ret_from_fork_asm;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
 	p->thread.iopl_warn = 0;


