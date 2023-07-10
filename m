Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A1E74CFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjGJIPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjGJIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:13:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3390E6;
        Mon, 10 Jul 2023 01:13:57 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:13:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688976836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHOquXvDo/NbVI+jWbbT/Z3wa7rPv0RwU+NsCgbI0W0=;
        b=zFtklZFjB+NXhFDpJrdysMCnMmsY5BYvZRk6vuYW4Cc545qaOhoqNKwpaWQjRysIMg5MyN
        Cuh0nXFa+nydYxqLik1gaG66P62c8E74C52uTDqLQ6mq/+jP6yi4QW2D4B6rGwnsoRGT7x
        l2DSbEkDmC9NgjnNNLnnnBwQiO1EVG7UoCuqdQS7qJIySeqTeaEip1mm33hHdlcw329fCt
        0FlRSTG6UaJ30XngsTCcC2TQBEbF1rRz8os3dI2z/gm16Wiwb0TxeWQfH5y6puNj/3rqsV
        XGj3EttEQFiygAIn77eLpTDTmGCAqr+iS50GEuSeLbu3Zks0VBeLJINy7eqLGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688976836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHOquXvDo/NbVI+jWbbT/Z3wa7rPv0RwU+NsCgbI0W0=;
        b=WnmV9lcB2BgK8R9EdoowaFLncM0aOgwUhok4IcQNIho8MM66yknJtjMiEIjn2pLK4bCpqG
        Kt/m1OQO5G/FcEDg==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86: Rewrite ret_from_fork() in C
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230623225529.34590-3-brgerst@gmail.com>
References: <20230623225529.34590-3-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <168897683581.404.7075614847525301300.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3aec4ecb3d1f313a8ab985df7cab07c4af81f478
Gitweb:        https://git.kernel.org/tip/3aec4ecb3d1f313a8ab985df7cab07c4af81f478
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 23 Jun 2023 18:55:29 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:25 +02:00

x86: Rewrite ret_from_fork() in C

When kCFI is enabled, special handling is needed for the indirect call
to the kernel thread function.  Rewrite the ret_from_fork() function in
C so that the compiler can properly handle the indirect call.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lkml.kernel.org/r/20230623225529.34590-3-brgerst@gmail.com
---
 arch/x86/entry/entry_32.S        | 30 +++++++---------------------
 arch/x86/entry/entry_64.S        | 33 +++++++------------------------
 arch/x86/include/asm/switch_to.h |  4 +++-
 arch/x86/kernel/process.c        | 22 ++++++++++++++++++++-
 4 files changed, 40 insertions(+), 49 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index e56123f..6e6af42 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -727,36 +727,22 @@ SYM_CODE_END(__switch_to_asm)
  * edi: kernel thread arg
  */
 .pushsection .text, "ax"
-SYM_CODE_START(ret_from_fork)
+SYM_CODE_START(ret_from_fork_asm)
+	movl	%esp, %edx	/* regs */
+
 	/* return address for the stack unwinder */
 	pushl	$.Lsyscall_32_done
 
 	FRAME_BEGIN
-	pushl	%eax
-	call	schedule_tail
+	/* prev already in EAX */
+	movl	%ebx, %ecx	/* fn */
+	pushl	%edi		/* fn_arg */
+	call	ret_from_fork
 	addl	$4, %esp
 	FRAME_END
 
-	testl	%ebx, %ebx
-	jnz	1f		/* kernel threads are uncommon */
-
-2:
-	/* When we fork, we trace the syscall return in the child, too. */
-	leal    4(%esp), %eax
-	call    syscall_exit_to_user_mode
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f31e286..91f6818 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -284,36 +284,19 @@ SYM_FUNC_END(__switch_to_asm)
  * r12: kernel thread arg
  */
 .pushsection .text, "ax"
-	__FUNC_ALIGN
-SYM_CODE_START_NOALIGN(ret_from_fork)
-	UNWIND_HINT_END_OF_STACK
+SYM_CODE_START(ret_from_fork_asm)
+	UNWIND_HINT_REGS
 	ANNOTATE_NOENDBR // copy_thread
 	CALL_DEPTH_ACCOUNT
-	movq	%rax, %rdi
-	call	schedule_tail			/* rdi: 'prev' task parameter */
 
-	testq	%rbx, %rbx			/* from kernel_thread? */
-	jnz	1f				/* kernel threads are uncommon */
+	movq	%rax, %rdi		/* prev */
+	movq	%rsp, %rsi		/* regs */
+	movq	%rbx, %rdx		/* fn */
+	movq	%r12, %rcx		/* fn_arg */
+	call	ret_from_fork
 
-2:
-	UNWIND_HINT_REGS
-	movq	%rsp, %rdi
-	call	syscall_exit_to_user_mode	/* returns with IRQs disabled */
 	jmp	swapgs_restore_regs_and_return_to_usermode
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
+SYM_CODE_END(ret_from_fork_asm)
 .popsection
 
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 5c91305..f42dbf1 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -12,7 +12,9 @@ struct task_struct *__switch_to_asm(struct task_struct *prev,
 __visible struct task_struct *__switch_to(struct task_struct *prev,
 					  struct task_struct *next);
 
-asmlinkage void ret_from_fork(void);
+asmlinkage void ret_from_fork_asm(void);
+__visible void ret_from_fork(struct task_struct *prev, struct pt_regs *regs,
+			     int (*fn)(void *), void *fn_arg);
 
 /*
  * This is the structure pointed to by thread.sp for an inactive task.  The
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ff9b80a..72015db 100644
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
@@ -134,6 +135,25 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
 		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
 }
 
+__visible void ret_from_fork(struct task_struct *prev, struct pt_regs *regs,
+				     int (*fn)(void *), void *fn_arg)
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
@@ -149,7 +169,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame = &fork_frame->frame;
 
 	frame->bp = encode_frame_pointer(childregs);
-	frame->ret_addr = (unsigned long) ret_from_fork;
+	frame->ret_addr = (unsigned long) ret_from_fork_asm;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
 	p->thread.iopl_warn = 0;
