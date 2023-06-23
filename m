Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B93A73C45A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjFWW4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjFWW4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:56:12 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B0272C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:55:38 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-19fa4346498so972115fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687560937; x=1690152937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1t8K4z72yZRYWSkZLR5CJTJ/xmjTVHKNdyx/pQkrmM=;
        b=MRdk8HnLfuJdykO+ryiKWiAwgn2CxWTStVczZvMNRx+0qk3mWXzOkMR4klyU7tRS9A
         7g5TgacdyoLPCxzqe871bg1/jnsooYJ5VG4ExdRpKrPm/WBBzampZOSfcps0CZs5T5c3
         9iTAEIG+SkQQdEZxruqWpDoLBuvzkyPm6oMHe+o35997i3x6c9EB4gbCk6lfyHc5G4oQ
         J8Yudzwqa6lzMuNdwGP4OWUxdD9p8f/NbQzV2Kzm1ruzP6w+FXY7MVon09/IUtS2abda
         B5bE3l9kL9/mXT7ds0SGkOrttL6csR/f22gbPWf+TaEH6AUGCssKwng1mPYHCtY3BXj8
         vVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687560937; x=1690152937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1t8K4z72yZRYWSkZLR5CJTJ/xmjTVHKNdyx/pQkrmM=;
        b=FqA5/Bo/qa96xNndJS+leZxQQEGSIphfTAcl7jk3U7w+H5zw6+4d9FIuu1bPYZM36g
         kkldDgPlyhwSZ18DSe91S4TxmA/o/0Q5BG+hoIXL2OuIigcj59iBsvE5+26XMpNsws3h
         FNrOWDrWtk9BrlKY51gRr4KVgWuFToMgbV3unf0c9x/q6dKA2DAGeM5s+9lgXM0Ecbfj
         hgdkgssQXSlpTcVROkW/ycCfdsNWAse9LnUzgoQsFAj4Im5P/NbbRbAmd2EZXclksh/g
         eIftgXJw4hZkT3lhy0E2kP/xiJ9+Lqk7kTpuZkvk0L+xHf7Dhb9uTUL2fc/5WkZCKnGv
         Tzjw==
X-Gm-Message-State: AC+VfDwQUYuwaTB/5psDMOEGjrN6N6Nkc3Wqf5YtvP4/HdtoGXu1vOxO
        b6GLiudWRYxt0BBZCUSZZxrKRMp8cA==
X-Google-Smtp-Source: ACHHUZ6bZJkRudjnsHxp8p1pU8C2AmjMB86J033BH3J4sVxy9k4e2u/y1g9BPWQj01/w1of6jsZbmQ==
X-Received: by 2002:a05:6870:44c1:b0:1a9:b19f:7a4 with SMTP id t1-20020a05687044c100b001a9b19f07a4mr18947212oai.10.1687560937270;
        Fri, 23 Jun 2023 15:55:37 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id b21-20020a9d5d15000000b006af9d8af435sm267479oti.50.2023.06.23.15.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:55:36 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        alyssa.milburn@linux.intel.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 2/2] x86: Rewrite ret_from_fork() in C
Date:   Fri, 23 Jun 2023 18:55:29 -0400
Message-ID: <20230623225529.34590-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623225529.34590-1-brgerst@gmail.com>
References: <20230623225529.34590-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kCFI is enabled, special handling is needed for the indirect call
to the kernel thread function.  Rewrite the ret_from_fork() function in
C so that the compiler can properly handle the indirect call.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/entry_32.S        | 30 ++++++++---------------------
 arch/x86/entry/entry_64.S        | 33 ++++++++------------------------
 arch/x86/include/asm/switch_to.h |  4 +++-
 arch/x86/kernel/process.c        | 22 ++++++++++++++++++++-
 4 files changed, 40 insertions(+), 49 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index e56123f03a79..6e6af42e044a 100644
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
index f31e286c2977..91f6818884fa 100644
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
index 5c91305d09d2..f42dbf17f52b 100644
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
index cc7a642f8c9d..001e6dad9a48 100644
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
@@ -136,6 +137,25 @@ static int set_new_tls(struct task_struct *p, unsigned long tls)
 		return do_set_thread_area_64(p, ARCH_SET_FS, tls);
 }
 
+__visible noinstr void ret_from_fork(struct task_struct *prev, struct pt_regs *regs,
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
@@ -152,7 +172,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame = &fork_frame->frame;
 
 	frame->bp = encode_frame_pointer(childregs);
-	frame->ret_addr = (unsigned long) ret_from_fork;
+	frame->ret_addr = (unsigned long) ret_from_fork_asm;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
 	p->thread.iopl_warn = 0;
-- 
2.41.0

