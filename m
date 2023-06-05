Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B90721FEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjFEHnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFEHmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:42:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2295AD;
        Mon,  5 Jun 2023 00:42:53 -0700 (PDT)
Date:   Mon, 05 Jun 2023 07:42:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685950971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uj0xbsOHyzLfh7csStl6yFOlGczfA8KkFmm1JOHIvsM=;
        b=h4AGF8S0mLVOZI1I/EDf47IhgH4vuJrpGURGas/xN9FYhswEkCTdfnC1uEs9muq7zi1I+g
        26vCpbX2hb+zd7G0JmoI37im0gD0kK3XRocHUD1YAeWnYWp+59Wj8caY/sMqtrr1fFpXHw
        wBe7hj4d+fUEeqNwFqRv9dYFg9TEZaugs941sor57meZZp0Rn5YYAbHonGebgTy43TJPRw
        znT/5wzuLFLPRbijLf20u3ZYLPfFJ6Hs6ivEiabM7ytSG4XsTsFY5f+sVEn4Fh1jviqt7F
        Gam+vRntjeT55o+RgK5/fHfde63aRVDOo4bz3TA+xZDYZavp2H2KHX39UULQug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685950971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uj0xbsOHyzLfh7csStl6yFOlGczfA8KkFmm1JOHIvsM=;
        b=dmBdln+f67w9mqfHUfuQn8DWc6rHqMM9Alke94nzYyuPPAKaTEBPLs73xGWNXqt8FpMkjw
        VMByfK1Y3ecMaaAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] percpu: Wire up cmpxchg128
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531132323.654945124@infradead.org>
References: <20230531132323.654945124@infradead.org>
MIME-Version: 1.0
Message-ID: <168595097107.404.9390866406095033152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6d12c8d308e68b9b0fa98ca2df4f83db4b4c965d
Gitweb:        https://git.kernel.org/tip/6d12c8d308e68b9b0fa98ca2df4f83db4b4c965d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 15:08:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:36:37 +02:00

percpu: Wire up cmpxchg128

In order to replace cmpxchg_double() with the newly minted
cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230531132323.654945124@infradead.org
---
 arch/arm64/include/asm/percpu.h | 20 +++++++++-
 arch/s390/include/asm/percpu.h  | 16 +++++++-
 arch/x86/include/asm/percpu.h   | 74 +++++++++++++++++++++++++++++---
 arch/x86/lib/Makefile           |  3 +-
 arch/x86/lib/cmpxchg16b_emu.S   | 43 +++++++++++--------
 arch/x86/lib/cmpxchg8b_emu.S    | 67 ++++++++++++++++++++++-------
 include/asm-generic/percpu.h    | 56 ++++++++++++++++++++++++-
 7 files changed, 240 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index b9ba19d..2549829 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -140,6 +140,10 @@ PERCPU_RET_OP(add, add, ldadd)
  * re-enabling preemption for preemptible kernels, but doing that in a way
  * which builds inside a module would mean messing directly with the preempt
  * count. If you do this, peterz and tglx will hunt you down.
+ *
+ * Not to mention it'll break the actual preemption model for missing a
+ * preemption point when TIF_NEED_RESCHED gets set while preemption is
+ * disabled.
  */
 #define this_cpu_cmpxchg_double_8(ptr1, ptr2, o1, o2, n1, n2)		\
 ({									\
@@ -240,6 +244,22 @@ PERCPU_RET_OP(add, add, ldadd)
 #define this_cpu_cmpxchg_8(pcp, o, n)	\
 	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
 
+#define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
+
+#define this_cpu_cmpxchg128(pcp, o, n)					\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	u128 old__, new__, ret__;					\
+	pcp_op_T__ *ptr__;						\
+	old__ = o;							\
+	new__ = n;							\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	ret__ = cmpxchg128_local((void *)ptr__, old__, new__);		\
+	preempt_enable_notrace();					\
+	ret__;								\
+})
+
 #ifdef __KVM_NVHE_HYPERVISOR__
 extern unsigned long __hyp_per_cpu_offset(unsigned int cpu);
 #define __per_cpu_offset
diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 081837b..5603402 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -148,6 +148,22 @@
 #define this_cpu_cmpxchg_4(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 
+#define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
+
+#define this_cpu_cmpxchg128(pcp, oval, nval)				\
+({									\
+	typedef typeof(pcp) pcp_op_T__;					\
+	u128 old__, new__, ret__;					\
+	pcp_op_T__ *ptr__;						\
+	old__ = oval;							\
+	new__ = nval;							\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	ret__ = cmpxchg128((void *)ptr__, old__, new__);		\
+	preempt_enable_notrace();					\
+	ret__;								\
+})
+
 #define arch_this_cpu_xchg(pcp, nval)					\
 ({									\
 	typeof(pcp) *ptr__;						\
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 13c0d63..4232fb2 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -210,6 +210,67 @@ do {									\
 	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
+#if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
+#define percpu_cmpxchg64_op(size, qual, _var, _oval, _nval)		\
+({									\
+	union {								\
+		u64 var;						\
+		struct {						\
+			u32 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = _oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual (ALTERNATIVE("leal %P[var], %%esi; call this_cpu_cmpxchg8b_emu", \
+			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
+		  : [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory", "esi");					\
+									\
+	old__.var;							\
+})
+
+#define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8,         , pcp, oval, nval)
+#define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
+#endif
+
+#ifdef CONFIG_X86_64
+#define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8,         , pcp, oval, nval);
+#define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval);
+
+#define percpu_cmpxchg128_op(size, qual, _var, _oval, _nval)		\
+({									\
+	union {								\
+		u128 var;						\
+		struct {						\
+			u64 low, high;					\
+		};							\
+	} old__, new__;							\
+									\
+	old__.var = _oval;						\
+	new__.var = _nval;						\
+									\
+	asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call this_cpu_cmpxchg16b_emu", \
+			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
+		  : [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory", "rsi");					\
+									\
+	old__.var;							\
+})
+
+#define raw_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16,         , pcp, oval, nval)
+#define this_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16, volatile, pcp, oval, nval)
+#endif
+
 /*
  * this_cpu_read() makes gcc load the percpu variable every time it is
  * accessed while this_cpu_read_stable() allows the value to be cached.
@@ -341,12 +402,13 @@ do {									\
 	bool __ret;							\
 	typeof(pcp1) __o1 = (o1), __n1 = (n1);				\
 	typeof(pcp2) __o2 = (o2), __n2 = (n2);				\
-	alternative_io("leaq %P1,%%rsi\n\tcall this_cpu_cmpxchg16b_emu\n\t", \
-		       "cmpxchg16b " __percpu_arg(1) "\n\tsetz %0\n\t",	\
-		       X86_FEATURE_CX16,				\
-		       ASM_OUTPUT2("=a" (__ret), "+m" (pcp1),		\
-				   "+m" (pcp2), "+d" (__o2)),		\
-		       "b" (__n1), "c" (__n2), "a" (__o1) : "rsi");	\
+	asm volatile (ALTERNATIVE("leaq %P1, %%rsi; call this_cpu_cmpxchg16b_emu", \
+				  "cmpxchg16b " __percpu_arg(1), X86_FEATURE_CX16) \
+			     "setz %0"					\
+			     : "=a" (__ret), "+m" (pcp1)		\
+			     : "b" (__n1), "c" (__n2),			\
+			       "a" (__o1), "d" (__o2)			\
+			     : "memory", "rsi");			\
 	__ret;								\
 })
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 01932af..ea3a28e 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -61,8 +61,9 @@ ifeq ($(CONFIG_X86_32),y)
         lib-y += strstr_32.o
         lib-y += string_32.o
         lib-y += memmove_32.o
+        lib-y += cmpxchg8b_emu.o
 ifneq ($(CONFIG_X86_CMPXCHG64),y)
-        lib-y += cmpxchg8b_emu.o atomic64_386_32.o
+        lib-y += atomic64_386_32.o
 endif
 else
         obj-y += iomap_copy_64.o
diff --git a/arch/x86/lib/cmpxchg16b_emu.S b/arch/x86/lib/cmpxchg16b_emu.S
index 33c70c0..6962df3 100644
--- a/arch/x86/lib/cmpxchg16b_emu.S
+++ b/arch/x86/lib/cmpxchg16b_emu.S
@@ -1,47 +1,54 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #include <linux/linkage.h>
 #include <asm/percpu.h>
+#include <asm/processor-flags.h>
 
 .text
 
 /*
+ * Emulate 'cmpxchg16b %gs:(%rsi)'
+ *
  * Inputs:
  * %rsi : memory location to compare
  * %rax : low 64 bits of old value
  * %rdx : high 64 bits of old value
  * %rbx : low 64 bits of new value
  * %rcx : high 64 bits of new value
- * %al  : Operation successful
+ *
+ * Notably this is not LOCK prefixed and is not safe against NMIs
  */
 SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
 
-#
-# Emulate 'cmpxchg16b %gs:(%rsi)' except we return the result in %al not
-# via the ZF.  Caller will access %al to get result.
-#
-# Note that this is only useful for a cpuops operation.  Meaning that we
-# do *not* have a fully atomic operation but just an operation that is
-# *atomic* on a single cpu (as provided by the this_cpu_xx class of
-# macros).
-#
 	pushfq
 	cli
 
-	cmpq PER_CPU_VAR((%rsi)), %rax
-	jne .Lnot_same
-	cmpq PER_CPU_VAR(8(%rsi)), %rdx
-	jne .Lnot_same
+	/* if (*ptr == old) */
+	cmpq	PER_CPU_VAR(0(%rsi)), %rax
+	jne	.Lnot_same
+	cmpq	PER_CPU_VAR(8(%rsi)), %rdx
+	jne	.Lnot_same
 
-	movq %rbx, PER_CPU_VAR((%rsi))
-	movq %rcx, PER_CPU_VAR(8(%rsi))
+	/* *ptr = new */
+	movq	%rbx, PER_CPU_VAR(0(%rsi))
+	movq	%rcx, PER_CPU_VAR(8(%rsi))
+
+	/* set ZF in EFLAGS to indicate success */
+	orl	$X86_EFLAGS_ZF, (%rsp)
 
 	popfq
-	mov $1, %al
 	RET
 
 .Lnot_same:
+	/* *ptr != old */
+
+	/* old = *ptr */
+	movq	PER_CPU_VAR(0(%rsi)), %rax
+	movq	PER_CPU_VAR(8(%rsi)), %rdx
+
+	/* clear ZF in EFLAGS to indicate failure */
+	andl	$(~X86_EFLAGS_ZF), (%rsp)
+
 	popfq
-	xor %al,%al
 	RET
 
 SYM_FUNC_END(this_cpu_cmpxchg16b_emu)
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index 6a912d5..4980525 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -2,10 +2,16 @@
 
 #include <linux/linkage.h>
 #include <asm/export.h>
+#include <asm/percpu.h>
+#include <asm/processor-flags.h>
 
 .text
 
+#ifndef CONFIG_X86_CMPXCHG64
+
 /*
+ * Emulate 'cmpxchg8b (%esi)' on UP
+ *
  * Inputs:
  * %esi : memory location to compare
  * %eax : low 32 bits of old value
@@ -15,32 +21,65 @@
  */
 SYM_FUNC_START(cmpxchg8b_emu)
 
-#
-# Emulate 'cmpxchg8b (%esi)' on UP except we don't
-# set the whole ZF thing (caller will just compare
-# eax:edx with the expected value)
-#
 	pushfl
 	cli
 
-	cmpl  (%esi), %eax
-	jne .Lnot_same
-	cmpl 4(%esi), %edx
-	jne .Lhalf_same
+	cmpl	0(%esi), %eax
+	jne	.Lnot_same
+	cmpl	4(%esi), %edx
+	jne	.Lnot_same
+
+	movl	%ebx, 0(%esi)
+	movl	%ecx, 4(%esi)
 
-	movl %ebx,  (%esi)
-	movl %ecx, 4(%esi)
+	orl	$X86_EFLAGS_ZF, (%esp)
 
 	popfl
 	RET
 
 .Lnot_same:
-	movl  (%esi), %eax
-.Lhalf_same:
-	movl 4(%esi), %edx
+	movl	0(%esi), %eax
+	movl	4(%esi), %edx
+
+	andl	$(~X86_EFLAGS_ZF), (%esp)
 
 	popfl
 	RET
 
 SYM_FUNC_END(cmpxchg8b_emu)
 EXPORT_SYMBOL(cmpxchg8b_emu)
+
+#endif
+
+#ifndef CONFIG_UML
+
+SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
+
+	pushfl
+	cli
+
+	cmpl	PER_CPU_VAR(0(%esi)), %eax
+	jne	.Lnot_same2
+	cmpl	PER_CPU_VAR(4(%esi)), %edx
+	jne	.Lnot_same2
+
+	movl	%ebx, PER_CPU_VAR(0(%esi))
+	movl	%ecx, PER_CPU_VAR(4(%esi))
+
+	orl	$X86_EFLAGS_ZF, (%esp)
+
+	popfl
+	RET
+
+.Lnot_same2:
+	movl	PER_CPU_VAR(0(%esi)), %eax
+	movl	PER_CPU_VAR(4(%esi)), %edx
+
+	andl	$(~X86_EFLAGS_ZF), (%esp)
+
+	popfl
+	RET
+
+SYM_FUNC_END(this_cpu_cmpxchg8b_emu)
+
+#endif
diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 96af32c..5c66e44 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -350,6 +350,25 @@ do {									\
 #endif
 #endif
 
+#ifndef raw_cpu_try_cmpxchg64
+#ifdef raw_cpu_cmpxchg64
+#define raw_cpu_try_cmpxchg64(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg64)
+#else
+#define raw_cpu_try_cmpxchg64(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef raw_cpu_try_cmpxchg128
+#ifdef raw_cpu_cmpxchg128
+#define raw_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, raw_cpu_cmpxchg128)
+#else
+#define raw_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+
 #ifndef raw_cpu_cmpxchg_1
 #define raw_cpu_cmpxchg_1(pcp, oval, nval) \
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
@@ -367,6 +386,15 @@ do {									\
 	raw_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
+#ifndef raw_cpu_cmpxchg64
+#define raw_cpu_cmpxchg64(pcp, oval, nval) \
+	raw_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+#ifndef raw_cpu_cmpxchg128
+#define raw_cpu_cmpxchg128(pcp, oval, nval) \
+	raw_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+
 #ifndef raw_cpu_cmpxchg_double_1
 #define raw_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
@@ -512,6 +540,25 @@ do {									\
 #endif
 #endif
 
+#ifndef this_cpu_try_cmpxchg64
+#ifdef this_cpu_cmpxchg64
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg64)
+#else
+#define this_cpu_try_cmpxchg64(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+#ifndef this_cpu_try_cmpxchg128
+#ifdef this_cpu_cmpxchg128
+#define this_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	__cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg128)
+#else
+#define this_cpu_try_cmpxchg128(pcp, ovalp, nval) \
+	this_cpu_generic_try_cmpxchg(pcp, ovalp, nval)
+#endif
+#endif
+
 #ifndef this_cpu_cmpxchg_1
 #define this_cpu_cmpxchg_1(pcp, oval, nval) \
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
@@ -529,6 +576,15 @@ do {									\
 	this_cpu_generic_cmpxchg(pcp, oval, nval)
 #endif
 
+#ifndef this_cpu_cmpxchg64
+#define this_cpu_cmpxchg64(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+#ifndef this_cpu_cmpxchg128
+#define this_cpu_cmpxchg128(pcp, oval, nval) \
+	this_cpu_generic_cmpxchg(pcp, oval, nval)
+#endif
+
 #ifndef this_cpu_cmpxchg_double_1
 #define this_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 	this_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2)
