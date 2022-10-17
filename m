Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD66011C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiJQOyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiJQOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AD8691B5;
        Mon, 17 Oct 2022 07:53:46 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4FWDFPOwZNjy8/OWvtHQ5aasrhd5F2oLRdahjDP+L0=;
        b=c6ryJB9N98ftFDvz2s4G9CtvoqAuyQH9hbVKXtu8c1PWxWIRGML1T6aOq1lcm2IfgTHC/M
        M1RDD8S9TWvw0kMqR6tZ8mS6tYZl+a7+3+T/DjA4GcYCo+D0hojYf96ddFNJ74RnzH34zo
        zy9xGZ/+tU53XYFtlnINY/+F6y/TmgkHRDk8PIPcjJ2TcXyVHQcr+cTJOeOUXdIn1ZNlrr
        CdH9XHkQi3MivhMtB65gLg0dsFiT1HS4ztwbNZGLnTWfOd9Two3l004UtJ5RuFR+HXQmLd
        CWJfNIayEfOyKtsOFBedqEJItoV95Q2vWMjdW3bEJUa29niuMPJ3p0zjgD+Czg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4FWDFPOwZNjy8/OWvtHQ5aasrhd5F2oLRdahjDP+L0=;
        b=M1y0qnqp7OnC2yNqo/4XKmk+7lvm5eZPLC8DBD10ZcP6bQU5YHF0IabM20hOjrKRwTSdU9
        iLS4DW0eDBvvsODQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/retbleed: Add SKL return thunk
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111147.890071690@infradead.org>
References: <20220915111147.890071690@infradead.org>
MIME-Version: 1.0
Message-ID: <166601842059.401.10253467345297714460.tip-bot2@tip-bot2>
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

Commit-ID:     5d8213864ade86b48fc492584ea86d65a62f892e
Gitweb:        https://git.kernel.org/tip/5d8213864ade86b48fc492584ea86d65a62f892e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:15 +02:00

x86/retbleed: Add SKL return thunk

To address the Intel SKL RSB underflow issue in software it's required to
do call depth tracking.

Provide a return thunk for call depth tracking on Intel SKL CPUs.

The tracking does not use a counter. It uses uses arithmetic shift
right on call entry and logical shift left on return.

The depth tracking variable is initialized to 0x8000.... when the call
depth is zero. The arithmetic shift right sign extends the MSB and
saturates after the 12th call. The shift count is 5 so the tracking covers
12 nested calls. On return the variable is shifted left logically so it
becomes zero again.

 CALL	 	   	RET
 0: 0x8000000000000000	0x0000000000000000
 1: 0xfc00000000000000	0xf000000000000000
...
11: 0xfffffffffffffff8	0xfffffffffffffc00
12: 0xffffffffffffffff	0xffffffffffffffe0

After a return buffer fill the depth is credited 12 calls before the next
stuffing has to take place.

There is a inaccuracy for situations like this:

   10 calls
    5 returns
    3 calls
    4 returns
    3 calls
    ....

The shift count might cause this to be off by one in either direction, but
there is still a cushion vs. the RSB depth. The algorithm does not claim to
be perfect, but it should obfuscate the problem enough to make exploitation
extremly difficult.

The theory behind this is:

RSB is a stack with depth 16 which is filled on every call. On the return
path speculation "pops" entries to speculate down the call chain. Once the
speculative RSB is empty it switches to other predictors, e.g. the Branch
History Buffer, which can be mistrained by user space and misguide the
speculation path to a gadget.

Call depth tracking is designed to break this speculation path by stuffing
speculation trap calls into the RSB which are never getting a corresponding
return executed. This stalls the prediction path until it gets resteered,

The assumption is that stuffing at the 12th return is sufficient to break
the speculation before it hits the underflow and the fallback to the other
predictors. Testing confirms that it works. Johannes, one of the retbleed
researchers. tried to attack this approach but failed.

There is obviously no scientific proof that this will withstand future
research progress, but all we can do right now is to speculate about it.

The SAR/SHL usage was suggested by Andi Kleen.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111147.890071690@infradead.org
---
 arch/x86/entry/entry_64.S            |  10 +-
 arch/x86/include/asm/current.h       |   3 +-
 arch/x86/include/asm/nospec-branch.h | 121 ++++++++++++++++++++++++--
 arch/x86/kernel/asm-offsets.c        |   3 +-
 arch/x86/kvm/svm/vmenter.S           |   1 +-
 arch/x86/lib/retpoline.S             |  31 +++++++-
 6 files changed, 159 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4cc0125..15739a2 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -288,6 +288,7 @@ SYM_FUNC_END(__switch_to_asm)
 SYM_CODE_START_NOALIGN(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR // copy_thread
+	CALL_DEPTH_ACCOUNT
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
 
@@ -332,7 +333,7 @@ SYM_CODE_START(xen_error_entry)
 	UNWIND_HINT_FUNC
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 	RET
 SYM_CODE_END(xen_error_entry)
 
@@ -977,7 +978,7 @@ SYM_CODE_START(paranoid_entry)
 	 * CR3 above, keep the old value in a callee saved register.
 	 */
 	IBRS_ENTER save_reg=%r15
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 
 	RET
 SYM_CODE_END(paranoid_entry)
@@ -1062,7 +1063,7 @@ SYM_CODE_START(error_entry)
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	IBRS_ENTER
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 	/* Put us onto the real thread stack. */
@@ -1097,6 +1098,7 @@ SYM_CODE_START(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+	CALL_DEPTH_ACCOUNT
 	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	ANNOTATE_UNRET_END
 	RET
@@ -1115,7 +1117,7 @@ SYM_CODE_START(error_entry)
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	IBRS_ENTER
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 
 	/*
 	 * Pretend that the exception came from user mode: set up pt_regs
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index b89aba0..a1168e7 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -17,6 +17,9 @@ struct pcpu_hot {
 			struct task_struct	*current_task;
 			int			preempt_count;
 			int			cpu_number;
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+			u64			call_depth;
+#endif
 			unsigned long		top_of_stack;
 			void			*hardirq_stack_ptr;
 			u16			softirq_pending;
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f10ca33..d4be826 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -12,8 +12,83 @@
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
 #include <asm/percpu.h>
+#include <asm/current.h>
 
-#define RETPOLINE_THUNK_SIZE	32
+/*
+ * Call depth tracking for Intel SKL CPUs to address the RSB underflow
+ * issue in software.
+ *
+ * The tracking does not use a counter. It uses uses arithmetic shift
+ * right on call entry and logical shift left on return.
+ *
+ * The depth tracking variable is initialized to 0x8000.... when the call
+ * depth is zero. The arithmetic shift right sign extends the MSB and
+ * saturates after the 12th call. The shift count is 5 for both directions
+ * so the tracking covers 12 nested calls.
+ *
+ *  Call
+ *  0: 0x8000000000000000	0x0000000000000000
+ *  1: 0xfc00000000000000	0xf000000000000000
+ * ...
+ * 11: 0xfffffffffffffff8	0xfffffffffffffc00
+ * 12: 0xffffffffffffffff	0xffffffffffffffe0
+ *
+ * After a return buffer fill the depth is credited 12 calls before the
+ * next stuffing has to take place.
+ *
+ * There is a inaccuracy for situations like this:
+ *
+ *  10 calls
+ *   5 returns
+ *   3 calls
+ *   4 returns
+ *   3 calls
+ *   ....
+ *
+ * The shift count might cause this to be off by one in either direction,
+ * but there is still a cushion vs. the RSB depth. The algorithm does not
+ * claim to be perfect and it can be speculated around by the CPU, but it
+ * is considered that it obfuscates the problem enough to make exploitation
+ * extremly difficult.
+ */
+#define RET_DEPTH_SHIFT			5
+#define RSB_RET_STUFF_LOOPS		16
+#define RET_DEPTH_INIT			0x8000000000000000ULL
+#define RET_DEPTH_INIT_FROM_CALL	0xfc00000000000000ULL
+#define RET_DEPTH_CREDIT		0xffffffffffffffffULL
+
+#if defined(CONFIG_CALL_DEPTH_TRACKING) && !defined(COMPILE_OFFSETS)
+
+#include <asm/asm-offsets.h>
+
+#define CREDIT_CALL_DEPTH					\
+	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+
+#define ASM_CREDIT_CALL_DEPTH					\
+	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+
+#define RESET_CALL_DEPTH					\
+	mov	$0x80, %rax;					\
+	shl	$56, %rax;					\
+	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+
+#define RESET_CALL_DEPTH_FROM_CALL				\
+	mov	$0xfc, %rax;					\
+	shl	$56, %rax;					\
+	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+
+#define INCREMENT_CALL_DEPTH					\
+	sarq	$5, %gs:pcpu_hot + X86_call_depth;
+
+#define ASM_INCREMENT_CALL_DEPTH				\
+	sarq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+
+#else
+#define CREDIT_CALL_DEPTH
+#define RESET_CALL_DEPTH
+#define INCREMENT_CALL_DEPTH
+#define RESET_CALL_DEPTH_FROM_CALL
+#endif
 
 /*
  * Fill the CPU return stack buffer.
@@ -32,6 +107,7 @@
  * from C via asm(".include <asm/nospec-branch.h>") but let's not go there.
  */
 
+#define RETPOLINE_THUNK_SIZE	32
 #define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
 
 /*
@@ -60,7 +136,8 @@
 	dec	reg;					\
 	jnz	771b;					\
 	/* barrier for jnz misprediction */		\
-	lfence;
+	lfence;						\
+	ASM_CREDIT_CALL_DEPTH
 #else
 /*
  * i386 doesn't unconditionally have LFENCE, as such it can't
@@ -185,11 +262,32 @@
  * where we have a stack but before any RET instruction.
  */
 .macro UNTRAIN_RET
-#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY)
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
+	defined(CONFIG_X86_FEATURE_CALL_DEPTH)
 	ANNOTATE_UNRET_END
-	ALTERNATIVE_2 "",						\
-	              CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB
+	ALTERNATIVE_3 "",						\
+		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
+		      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
+#endif
+.endm
+
+.macro UNTRAIN_RET_FROM_CALL
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
+	defined(CONFIG_X86_FEATURE_CALL_DEPTH)
+	ANNOTATE_UNRET_END
+	ALTERNATIVE_3 "",						\
+		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
+		      __stringify(RESET_CALL_DEPTH_FROM_CALL), X86_FEATURE_CALL_DEPTH
+#endif
+.endm
+
+
+.macro CALL_DEPTH_ACCOUNT
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+	ALTERNATIVE "",							\
+		    __stringify(ASM_INCREMENT_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
 #endif
 .endm
 
@@ -214,6 +312,17 @@ extern void (*x86_return_thunk)(void);
 #define x86_return_thunk	(&__x86_return_thunk)
 #endif
 
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+extern void __x86_return_skl(void);
+
+static inline void x86_set_skl_return_thunk(void)
+{
+	x86_return_thunk = &__x86_return_skl;
+}
+#else
+static inline void x86_set_skl_return_thunk(void) {}
+#endif
+
 #ifdef CONFIG_RETPOLINE
 
 #define GEN(reg) \
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index a982431..13afdbb 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -110,6 +110,9 @@ static void __used common(void)
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 
 	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+	OFFSET(X86_call_depth, pcpu_hot, call_depth);
+#endif
 
 	if (IS_ENABLED(CONFIG_KVM_INTEL)) {
 		BLANK();
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 723f853..09eacf1 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/linkage.h>
 #include <asm/asm.h>
+#include <asm/asm-offsets.h>
 #include <asm/bitsperlong.h>
 #include <asm/kvm_vcpu_regs.h>
 #include <asm/nospec-branch.h>
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 073289a..1e79ecc 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -5,9 +5,11 @@
 #include <asm/dwarf2.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
+#include <asm/asm-offsets.h>
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
+#include <asm/percpu.h>
 #include <asm/frame.h>
 
 	.section .text.__x86.indirect_thunk
@@ -140,3 +142,32 @@ __EXPORT_THUNK(zen_untrain_ret)
 EXPORT_SYMBOL(__x86_return_thunk)
 
 #endif /* CONFIG_RETHUNK */
+
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+
+	.align 64
+SYM_FUNC_START(__x86_return_skl)
+	ANNOTATE_NOENDBR
+	/* Keep the hotpath in a 16byte I-fetch */
+	shlq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth)
+	jz	1f
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+1:
+	.rept	16
+	ANNOTATE_INTRA_FUNCTION_CALL
+	call	2f
+	int3
+2:
+	.endr
+	add	$(8*16), %rsp
+
+	CREDIT_CALL_DEPTH
+
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_FUNC_END(__x86_return_skl)
+
+#endif /* CONFIG_CALL_DEPTH_TRACKING */
