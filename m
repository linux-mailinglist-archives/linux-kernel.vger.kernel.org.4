Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF056011A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJQOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiJQOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7345B68CC9;
        Mon, 17 Oct 2022 07:53:33 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AA8MmdjP2oUvLWa7hEJgEttdLNmLKuNlfs6o+7sYpj4=;
        b=WhPtTnm6ioni0BsWpIGelGfmgCeTZSSaH+95kF3egC9VEyrvHCT2h5BTMtE/VMXIBaq0oj
        ZOBIebJeRa8610OywflNSjziIuOUXiMxfbnheSFjSATYzfcheKId0tnexysMQqznzCGYCn
        yqnRs/5LDJnGokbH9WUzYb3PiOrr7WxA7sp1uqktN12TdbAQv08kTK3fyK+DPeuH1xkFPH
        S4EG094laau+LS72DQ54dNBRIfijpRrwTj8ToXcL2RH4IUgLKz0CDjikke4ONpP0wZwZuS
        YIarzZTT/5DMZx/cZ4Hnm5CKoouP83B8UveAZ6ZY+NpgzJykd08Kjj/0LeT8SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AA8MmdjP2oUvLWa7hEJgEttdLNmLKuNlfs6o+7sYpj4=;
        b=kD8CMgKBSyJEhzXqTV3MozFXtb7ucQNCKaTOIa3DIhaw2oFY5bfO08NIjx20tjWEB1lLxf
        Xp333xC+KgK5dGBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ftrace: Make it call depth tracking aware
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111148.927545073@infradead.org>
References: <20220915111148.927545073@infradead.org>
MIME-Version: 1.0
Message-ID: <166601840985.401.5974179613786388444.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ee3e2469b3463d28ca4cde20e0283319ac6a562d
Gitweb:        https://git.kernel.org/tip/ee3e2469b3463d28ca4cde20e0283319ac6a562d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 15 Sep 2022 13:11:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:19 +02:00

x86/ftrace: Make it call depth tracking aware

Since ftrace has trampolines, don't use thunks for the __fentry__ site
but instead require that every function called from there includes
accounting. This very much includes all the direct-call functions.

Additionally, ftrace uses ROP tricks in two places:

 - return_to_handler(), and
 - ftrace_regs_caller() when pt_regs->orig_ax is set by a direct-call.

return_to_handler() already uses a retpoline to replace an
indirect-jump to defeat IBT, since this is a jump-type retpoline, make
sure there is no accounting done and ALTERNATIVE the RET into a ret.

ftrace_regs_caller() does much the same and gets the same treatment.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111148.927545073@infradead.org
---
 arch/x86/include/asm/nospec-branch.h        |  9 ++++++++-
 arch/x86/kernel/callthunks.c                |  2 +-
 arch/x86/kernel/ftrace.c                    | 16 +++++++++++----
 arch/x86/kernel/ftrace_64.S                 | 22 ++++++++++++++++++--
 arch/x86/net/bpf_jit_comp.c                 |  6 +++++-
 kernel/trace/trace_selftest.c               |  9 +++++++-
 samples/ftrace/ftrace-direct-modify.c       |  3 +++-
 samples/ftrace/ftrace-direct-multi-modify.c |  3 +++-
 samples/ftrace/ftrace-direct-multi.c        |  2 ++-
 samples/ftrace/ftrace-direct-too.c          |  2 ++-
 samples/ftrace/ftrace-direct.c              |  2 ++-
 11 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 4771147..82580ad 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -343,6 +343,12 @@ static inline void x86_set_skl_return_thunk(void)
 {
 	x86_return_thunk = &__x86_return_skl;
 }
+
+#define CALL_DEPTH_ACCOUNT					\
+	ALTERNATIVE("",						\
+		    __stringify(INCREMENT_CALL_DEPTH),		\
+		    X86_FEATURE_CALL_DEPTH)
+
 #ifdef CONFIG_CALL_THUNKS_DEBUG
 DECLARE_PER_CPU(u64, __x86_call_count);
 DECLARE_PER_CPU(u64, __x86_ret_count);
@@ -351,6 +357,9 @@ DECLARE_PER_CPU(u64, __x86_ctxsw_count);
 #endif
 #else
 static inline void x86_set_skl_return_thunk(void) {}
+
+#define CALL_DEPTH_ACCOUNT ""
+
 #endif
 
 #ifdef CONFIG_RETPOLINE
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index a03d646..7d2c75e 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -316,7 +316,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *func)
 		return 0;
 
 	/* Is function call target a thunk? */
-	if (is_callthunk(func))
+	if (func && is_callthunk(func))
 		return 0;
 
 	memcpy(*pprog, tmpl, tmpl_size);
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 4ac6692..cf15ef5 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -69,6 +69,10 @@ static const char *ftrace_nop_replace(void)
 
 static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 {
+	/*
+	 * No need to translate into a callthunk. The trampoline does
+	 * the depth accounting itself.
+	 */
 	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
 }
 
@@ -317,7 +321,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned long size;
 	unsigned long *ptr;
 	void *trampoline;
-	void *ip;
+	void *ip, *dest;
 	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
 	unsigned const char retq[] = { RET_INSN_OPCODE, INT3_INSN_OPCODE };
@@ -404,10 +408,14 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	/* put in the call to the function */
 	mutex_lock(&text_mutex);
 	call_offset -= start_offset;
+	/*
+	 * No need to translate into a callthunk. The trampoline does
+	 * the depth accounting before the call already.
+	 */
+	dest = ftrace_ops_get_func(ops);
 	memcpy(trampoline + call_offset,
-	       text_gen_insn(CALL_INSN_OPCODE,
-			     trampoline + call_offset,
-			     ftrace_ops_get_func(ops)), CALL_INSN_SIZE);
+	       text_gen_insn(CALL_INSN_OPCODE, trampoline + call_offset, dest),
+	       CALL_INSN_SIZE);
 	mutex_unlock(&text_mutex);
 
 	/* ALLOC_TRAMP flags lets us know we created it */
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index b5b54f5..6a7e6d6 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -4,6 +4,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/ftrace.h>
 #include <asm/export.h>
@@ -132,6 +133,7 @@
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 SYM_FUNC_START(__fentry__)
+	CALL_DEPTH_ACCOUNT
 	RET
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
@@ -140,6 +142,8 @@ SYM_FUNC_START(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
 	save_mcount_regs
 
+	CALL_DEPTH_ACCOUNT
+
 	/* Stack - skipping return address of ftrace_caller */
 	leaq MCOUNT_REG_SIZE+8(%rsp), %rcx
 	movq %rcx, RSP(%rsp)
@@ -155,6 +159,9 @@ SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 	/* Only ops with REGS flag set should have CS register set */
 	movq $0, CS(%rsp)
 
+	/* Account for the function call below */
+	CALL_DEPTH_ACCOUNT
+
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
@@ -189,6 +196,8 @@ SYM_FUNC_START(ftrace_regs_caller)
 	save_mcount_regs 8
 	/* save_mcount_regs fills in first two parameters */
 
+	CALL_DEPTH_ACCOUNT
+
 SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
@@ -219,6 +228,9 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	/* regs go into 4th parameter */
 	leaq (%rsp), %rcx
 
+	/* Account for the function call below */
+	CALL_DEPTH_ACCOUNT
+
 SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	call ftrace_stub
@@ -282,7 +294,9 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	int3
 .Ldo_rebalance:
 	add $8, %rsp
-	RET
+	ALTERNATIVE __stringify(RET), \
+		    __stringify(ANNOTATE_UNRET_SAFE; ret; int3), \
+		    X86_FEATURE_CALL_DEPTH
 
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
@@ -291,6 +305,8 @@ STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
 SYM_FUNC_START(__fentry__)
+	CALL_DEPTH_ACCOUNT
+
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
 
@@ -347,6 +363,8 @@ SYM_CODE_START(return_to_handler)
 	int3
 .Ldo_rop:
 	mov %rdi, (%rsp)
-	RET
+	ALTERNATIVE __stringify(RET), \
+		    __stringify(ANNOTATE_UNRET_SAFE; ret; int3), \
+		    X86_FEATURE_CALL_DEPTH
 SYM_CODE_END(return_to_handler)
 #endif
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a6b4674..f46b620 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -12,6 +12,7 @@
 #include <linux/memory.h>
 #include <linux/sort.h>
 #include <asm/extable.h>
+#include <asm/ftrace.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/text-patching.h>
@@ -2135,6 +2136,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	prog = image;
 
 	EMIT_ENDBR();
+	/*
+	 * This is the direct-call trampoline, as such it needs accounting
+	 * for the __fentry__ call.
+	 */
+	x86_call_depth_emit_accounting(&prog, NULL);
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
 	EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index a2d301f..ff0536c 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -785,7 +785,14 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-noinline __noclone static void trace_direct_tramp(void) { }
+#ifndef CALL_DEPTH_ACCOUNT
+#define CALL_DEPTH_ACCOUNT ""
+#endif
+
+noinline __noclone static void trace_direct_tramp(void)
+{
+	asm(CALL_DEPTH_ACCOUNT);
+}
 #endif
 
 /*
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 39146fa..de5a0f6 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -3,6 +3,7 @@
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-branch.h>
 
 extern void my_direct_func1(void);
 extern void my_direct_func2(void);
@@ -34,6 +35,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	call my_direct_func1\n"
 "	leave\n"
 "	.size		my_tramp1, .-my_tramp1\n"
@@ -45,6 +47,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	call my_direct_func2\n"
 "	leave\n"
 	ASM_RET
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 65aa94d..d52370c 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -3,6 +3,7 @@
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-branch.h>
 
 extern void my_direct_func1(unsigned long ip);
 extern void my_direct_func2(unsigned long ip);
@@ -32,6 +33,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func1\n"
@@ -46,6 +48,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func2\n"
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 41ded7c..ec10889 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -5,6 +5,7 @@
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-branch.h>
 
 extern void my_direct_func(unsigned long ip);
 
@@ -27,6 +28,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	movq 8(%rbp), %rdi\n"
 "	call my_direct_func\n"
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 6690468..e13fb59 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -4,6 +4,7 @@
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-branch.h>
 
 extern void my_direct_func(struct vm_area_struct *vma,
 			   unsigned long address, unsigned int flags);
@@ -29,6 +30,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index e8f1e44..1f769d0 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -4,6 +4,7 @@
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-branch.h>
 
 extern void my_direct_func(struct task_struct *p);
 
@@ -26,6 +27,7 @@ asm (
 	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
+	CALL_DEPTH_ACCOUNT
 "	pushq %rdi\n"
 "	call my_direct_func\n"
 "	popq %rdi\n"
