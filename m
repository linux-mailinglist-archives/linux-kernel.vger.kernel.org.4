Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A2638043
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKXUkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXUkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:40:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED4D6F0F5;
        Thu, 24 Nov 2022 12:40:46 -0800 (PST)
Date:   Thu, 24 Nov 2022 20:40:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669322444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYG49PSPlxxLE3bpM8tow3auxyHfwIOIpCuluhpcqv8=;
        b=QWAdg4Q0W/s3K4xj5vJAlrfdg9BVXJ5bB4xsSXLOM3U2SXGpwTN/0D7Gb2yF2dZk1ZFgeJ
        TOswjdgB+ISiA1GmC6Sv3E8l0UKSTYspCQoj9SqH35QigUmAuJRkUPA+eHn59yZ8HujO7q
        Nr70sODXY11T7g199lGa8NqtBF9f6AhMy5oB4QOBLaFLZ/6k6VazSNMEJJ9OT3j7P/jUln
        ZGNV5hk+VrNchGKEz2HbapJRGhJp3kKHGOkHJsa2+OM58OiJUBTLjP8lbDowvc7WcWNOYP
        qSdRNlgrYrazAhgwArq0+GkXiBPBM21v8VSYVnBsU8PBj7tzjQNEMfPKK9wIWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669322444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYG49PSPlxxLE3bpM8tow3auxyHfwIOIpCuluhpcqv8=;
        b=edXkFgbrT8UU11RLczG0flRNO5pZD1qP9PV9zxcTooR73+nUr2hqxL3RkREoWUbyzPYg97
        dwD6Oy8jchKyZqCw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/paravirt: Use common macro for creating simple
 asm paravirt functions
Cc:     Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221109134418.6516-1-jgross@suse.com>
References: <20221109134418.6516-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166932244203.4906.1166372602072715258.tip-bot2@tip-bot2>
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

Commit-ID:     f1a033cc6b9eb6d80322008422df3c87aa5d47a0
Gitweb:        https://git.kernel.org/tip/f1a033cc6b9eb6d80322008422df3c87aa5d47a0
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 09 Nov 2022 14:44:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 13:56:44 +01:00

x86/paravirt: Use common macro for creating simple asm paravirt functions

There are some paravirt assembler functions which are sharing a common
pattern. Introduce a macro DEFINE_PARAVIRT_ASM() for creating them.

Note that this macro is including explicit alignment of the generated
functions, leading to __raw_callee_save___kvm_vcpu_is_preempted(),
_paravirt_nop() and paravirt_ret0() to be aligned at 4 byte boundaries
now.

The explicit _paravirt_nop() prototype in paravirt.c isn't needed, as
it is included in paravirt_types.h already.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Link: https://lkml.kernel.org/r/20221109134418.6516-1-jgross@suse.com
---
 arch/x86/include/asm/paravirt.h           | 12 ++++++-
 arch/x86/include/asm/qspinlock_paravirt.h | 47 +++++++++-------------
 arch/x86/kernel/kvm.c                     | 19 ++-------
 arch/x86/kernel/paravirt.c                | 23 +-----------
 4 files changed, 40 insertions(+), 61 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 2851bc2..73e9522 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -731,6 +731,18 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #undef PVOP_VCALL4
 #undef PVOP_CALL4
 
+#define DEFINE_PARAVIRT_ASM(func, instr, sec)		\
+	asm (".pushsection " #sec ", \"ax\"\n"		\
+	     ".global " #func "\n\t"			\
+	     ".type " #func ", @function\n\t"		\
+	     ASM_FUNC_ALIGN "\n"			\
+	     #func ":\n\t"				\
+	     ASM_ENDBR					\
+	     instr "\n\t"				\
+	     ASM_RET					\
+	     ".size " #func ", . - " #func "\n\t"	\
+	     ".popsection")
+
 extern void default_banner(void);
 
 #else  /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index d861127..42b17cf 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -14,8 +14,6 @@
 
 __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
 #define __pv_queued_spin_unlock	__pv_queued_spin_unlock
-#define PV_UNLOCK		"__raw_callee_save___pv_queued_spin_unlock"
-#define PV_UNLOCK_SLOWPATH	"__raw_callee_save___pv_queued_spin_unlock_slowpath"
 
 /*
  * Optimized assembly version of __raw_callee_save___pv_queued_spin_unlock
@@ -37,32 +35,27 @@ __PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
  *   rsi = lockval           (second argument)
  *   rdx = internal variable (set to 0)
  */
-asm    (".pushsection .spinlock.text, \"ax\";"
-	".globl " PV_UNLOCK ";"
-	".type " PV_UNLOCK ", @function;"
-	ASM_FUNC_ALIGN
-	PV_UNLOCK ": "
-	ASM_ENDBR
-	FRAME_BEGIN
-	"push  %rdx;"
-	"mov   $0x1,%eax;"
-	"xor   %edx,%edx;"
-	LOCK_PREFIX "cmpxchg %dl,(%rdi);"
-	"cmp   $0x1,%al;"
-	"jne   .slowpath;"
-	"pop   %rdx;"
+#define PV_UNLOCK_ASM							\
+	FRAME_BEGIN							\
+	"push  %rdx\n\t"						\
+	"mov   $0x1,%eax\n\t"						\
+	"xor   %edx,%edx\n\t"						\
+	LOCK_PREFIX "cmpxchg %dl,(%rdi)\n\t"				\
+	"cmp   $0x1,%al\n\t"						\
+	"jne   .slowpath\n\t"						\
+	"pop   %rdx\n\t"						\
+	FRAME_END							\
+	ASM_RET								\
+	".slowpath:\n\t"						\
+	"push   %rsi\n\t"						\
+	"movzbl %al,%esi\n\t"						\
+	"call __raw_callee_save___pv_queued_spin_unlock_slowpath\n\t"	\
+	"pop    %rsi\n\t"						\
+	"pop    %rdx\n\t"						\
 	FRAME_END
-	ASM_RET
-	".slowpath: "
-	"push   %rsi;"
-	"movzbl %al,%esi;"
-	"call " PV_UNLOCK_SLOWPATH ";"
-	"pop    %rsi;"
-	"pop    %rdx;"
-	FRAME_END
-	ASM_RET
-	".size " PV_UNLOCK ", .-" PV_UNLOCK ";"
-	".popsection");
+
+DEFINE_PARAVIRT_ASM(__raw_callee_save___pv_queued_spin_unlock,
+		    PV_UNLOCK_ASM, .spinlock.text);
 
 #else /* CONFIG_64BIT */
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 95fb85b..4d053cb 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -798,20 +798,13 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
  * Hand-optimize version for x86-64 to avoid 8 64-bit register saving and
  * restoring to/from the stack.
  */
-asm(
-".pushsection .text;"
-".global __raw_callee_save___kvm_vcpu_is_preempted;"
-".type __raw_callee_save___kvm_vcpu_is_preempted, @function;"
-ASM_FUNC_ALIGN
-"__raw_callee_save___kvm_vcpu_is_preempted:"
-ASM_ENDBR
-"movq	__per_cpu_offset(,%rdi,8), %rax;"
-"cmpb	$0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax);"
-"setne	%al;"
-ASM_RET
-".size __raw_callee_save___kvm_vcpu_is_preempted, .-__raw_callee_save___kvm_vcpu_is_preempted;"
-".popsection");
+#define PV_VCPU_PREEMPTED_ASM						     \
+ "movq   __per_cpu_offset(,%rdi,8), %rax\n\t"				     \
+ "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax)\n\t" \
+ "setne  %al\n\t"
 
+DEFINE_PARAVIRT_ASM(__raw_callee_save___kvm_vcpu_is_preempted,
+		    PV_VCPU_PREEMPTED_ASM, .text);
 #endif
 
 static void __init kvm_guest_init(void)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index e244c49..327757a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -37,29 +37,10 @@
  * nop stub, which must not clobber anything *including the stack* to
  * avoid confusing the entry prologues.
  */
-extern void _paravirt_nop(void);
-asm (".pushsection .entry.text, \"ax\"\n"
-     ".global _paravirt_nop\n"
-     ASM_FUNC_ALIGN
-     "_paravirt_nop:\n\t"
-     ASM_ENDBR
-     ASM_RET
-     ".size _paravirt_nop, . - _paravirt_nop\n\t"
-     ".type _paravirt_nop, @function\n\t"
-     ".popsection");
+DEFINE_PARAVIRT_ASM(_paravirt_nop, "", .entry.text);
 
 /* stub always returning 0. */
-asm (".pushsection .entry.text, \"ax\"\n"
-     ".global paravirt_ret0\n"
-     ASM_FUNC_ALIGN
-     "paravirt_ret0:\n\t"
-     ASM_ENDBR
-     "xor %" _ASM_AX ", %" _ASM_AX ";\n\t"
-     ASM_RET
-     ".size paravirt_ret0, . - paravirt_ret0\n\t"
-     ".type paravirt_ret0, @function\n\t"
-     ".popsection");
-
+DEFINE_PARAVIRT_ASM(paravirt_ret0, "xor %eax,%eax", .entry.text);
 
 void __init default_banner(void)
 {
