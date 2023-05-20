Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A8870A748
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjETKtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjETKtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:49:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15088E54;
        Sat, 20 May 2023 03:49:07 -0700 (PDT)
Date:   Sat, 20 May 2023 10:49:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684579743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/CYMaHe41OXFIYPcIF2+mDgE/e7EFfDTDmPw0LM0D4=;
        b=QKeuJd/whZotB+vV1/oGGVhVkPZUrcZbc4yhU4w74ufcmgfIim7JbcDk3YYYPkCn40mRFV
        AXQBMaYlGAJBCBbk0WaJHoe83qM8OjxiUmZy1DUXzxaMyD03PSFinRg36eN8hsxNFK1zJQ
        +/4SdY+tcZvl4FkXGQX2vIjX6HytXDHWOeCm06WKxVGHZ3cMGQUqHpVtp6VKpQmFEYnJyW
        d9H3eoxSzgXwEd5KasYtPSjezP9ICggNGkx1dUpYJITuysbbWL3IjFKDjyiN+70o81KBRM
        hEPWHunO1iQjz0J1Ix2k3Qh9308l+2J6N+WNOJg91k2Y01ZPLccHNSSUWpyD+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684579743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h/CYMaHe41OXFIYPcIF2+mDgE/e7EFfDTDmPw0LM0D4=;
        b=90Z7Ycl+Xpi2zuaAaqjru3h+9cjMGVV6BphQi5GhL9s/2Getltha4NaBtVQaPzmNemwfZK
        KaLje+yu6E1WfaBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] percpu: Wire up cmpxchg128
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515080554.248739380@infradead.org>
References: <20230515080554.248739380@infradead.org>
MIME-Version: 1.0
Message-ID: <168457974296.404.7434315965646266706.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     58e59a577359bd13d2219f5db064af41af68011e
Gitweb:        https://git.kernel.org/tip/58e59a577359bd13d2219f5db064af41af68011e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 May 2023 09:57:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 May 2023 12:35:13 +02:00

percpu: Wire up cmpxchg128

In order to replace cmpxchg_double() with the newly minted
cmpxchg128() family of functions, wire it up in this_cpu_cmpxchg().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20230515080554.248739380@infradead.org
---
 arch/arm64/include/asm/percpu.h | 20 +++++++++++-
 arch/s390/include/asm/percpu.h  | 16 +++++++++-
 arch/x86/include/asm/percpu.h   | 59 ++++++++++++++++++++++++++++++++-
 include/asm-generic/percpu.h    | 16 +++++++++-
 4 files changed, 111 insertions(+)

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
index 13c0d63..4d58b97 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -210,6 +210,65 @@ do {									\
 	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
+#if defined(CONFIG_X86_32) && defined(CONFIG_X86_CMPXCHG64)
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
+	asm qual ("cmpxchg8b " __percpu_arg([var])			\
+		  : [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory");						\
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
+	asm qual ("cmpxchg16b " __percpu_arg([var])			\
+		  : [var] "+m" (_var),					\
+		    "+a" (old__.low),					\
+		    "+d" (old__.high)					\
+		  : "b" (new__.low),					\
+		    "c" (new__.high)					\
+		  : "memory");						\
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
diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 6432a7f..53d933e 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -298,6 +298,14 @@ do {									\
 #define raw_cpu_cmpxchg_8(pcp, oval, nval) \
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
 
 #ifndef raw_cpu_cmpxchg_double_1
 #define raw_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
@@ -423,6 +431,14 @@ do {									\
 #define this_cpu_cmpxchg_8(pcp, oval, nval) \
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
 
 #ifndef this_cpu_cmpxchg_double_1
 #define this_cpu_cmpxchg_double_1(pcp1, pcp2, oval1, oval2, nval1, nval2) \
