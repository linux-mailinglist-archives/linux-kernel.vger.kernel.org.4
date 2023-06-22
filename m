Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E855673A08B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjFVMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjFVMIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:08:14 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABAF1738
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:08:13 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39e86b3da52so376905b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687435692; x=1690027692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u5k9RkjfB1np1uF6E7roc0yGr1eDTahGUfYZTjoif4=;
        b=Ia9qeKstOLpE48XFGX95pefMjR9STvZk/Y6o5znK8lW9U2LbNXTV7YknuobZ9MObXi
         5s36ysx0ZrS8BDMx4APp0XEcSjidTeeoaqUDAYMjH0W4Lgt3pFiRqkEOpOtNjTmFp8C5
         rb0H5V31tZCLVSxZhUx5OxFEUkfak3Yrx7xQY6qwYe+avcgKQWVnTHa8w07g4z7xnhU0
         G6T1HMbmo6v+T3WEDyIi22qixGaBhmlfoBVqRK/R+hX9BzBgken16kw6cQSPahE/X0nC
         My3iUQqzbtGOc3Ohwqn3howkCY2fRxo/ITa5CinHEojilnJ/x1VY+ERcqgGYvKbnNjWj
         ygsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435692; x=1690027692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u5k9RkjfB1np1uF6E7roc0yGr1eDTahGUfYZTjoif4=;
        b=dl8Ans6H/cad/5kWG5NHB3GFyl1AfyaL5JdVjQ1FB2352uRfhJBF5YwU/wf12yMDaW
         8wQLLAnQqdQC2AjdBfKLcS9eyu/i/pW2m8bHnQ7hZSkRtP7z6p3/hA/uELdcH90B0Q3r
         hqIcI7q5eYVhjcPG82q5uXG4Nqx1gqOVKM3+9eDDVdTkl0qUg44VS7fPu4wexczdt4Vu
         bhKhywmwhUutqy6ALwx+2E6zdzAF3WoL8Lcw8lZvnIhYKEjMObU1UIchzslEHWcOLrto
         tgShP1P+aFe6UnvMnOWQaO/ko3ASnksepzaL2fz/PxTlD2opCnQRfMwwxnkIUGRABRV4
         fdmg==
X-Gm-Message-State: AC+VfDw+fV53MPzDSwXK93Ajg8DYO4yFRFRfxcUfkgqyM1AbzOEkojqN
        9aUUSviWOtzJcAzxBpNew3x7OYDaNg==
X-Google-Smtp-Source: ACHHUZ7D33dV1Pzm1UZMLElMUDdUONI28f65wwopTHvlCYrjOSNz120DkV19fUdfAyCabIl1KZaG3A==
X-Received: by 2002:a05:6808:1884:b0:3a0:415c:98bb with SMTP id bi4-20020a056808188400b003a0415c98bbmr3925680oib.27.1687435691641;
        Thu, 22 Jun 2023 05:08:11 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id m2-20020a4ae842000000b0054f85f67f31sm2705773oom.46.2023.06.22.05.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:08:10 -0700 (PDT)
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
Subject: [PATCH 2/2] x86: Rewrite ret_from_fork() in C
Date:   Thu, 22 Jun 2023 08:07:50 -0400
Message-ID: <20230622120750.5549-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622120750.5549-1-brgerst@gmail.com>
References: <20230622120750.5549-1-brgerst@gmail.com>
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
 arch/x86/entry/entry_32.S        | 30 +++++++--------------------
 arch/x86/entry/entry_64.S        | 35 +++++++++-----------------------
 arch/x86/include/asm/switch_to.h |  4 +++-
 arch/x86/kernel/process.c        | 22 +++++++++++++++++++-
 4 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 6c1ee76adc11..7932c14199fb 100644
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f31e286c2977..5ee32e7e29e8 100644
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
-
-	testq	%rbx, %rbx			/* from kernel_thread? */
-	jnz	1f				/* kernel threads are uncommon */
 
-2:
-	UNWIND_HINT_REGS
-	movq	%rsp, %rdi
-	call	syscall_exit_to_user_mode	/* returns with IRQs disabled */
-	jmp	swapgs_restore_regs_and_return_to_usermode
+	/* return address for the stack unwinder */
+	pushq	$swapgs_restore_regs_and_return_to_usermode
+	UNWIND_HINT_FUNC
 
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
index dac41a0072ea..f5dbfebac076 100644
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
@@ -149,7 +169,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame = &fork_frame->frame;
 
 	frame->bp = encode_frame_pointer(childregs);
-	frame->ret_addr = (unsigned long) ret_from_fork;
+	frame->ret_addr = (unsigned long) ret_from_fork_asm;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
 	p->thread.iopl_warn = 0;
-- 
2.41.0

