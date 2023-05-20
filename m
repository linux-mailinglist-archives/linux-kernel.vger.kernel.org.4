Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74A270A74B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjETKth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 06:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjETKtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 06:49:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2990D1B5;
        Sat, 20 May 2023 03:49:07 -0700 (PDT)
Date:   Sat, 20 May 2023 10:49:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684579744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2A6eFh/3+2YwL0QgYX1GsfteLpgTzxkBYbhqgvbN5Po=;
        b=Zj6XWEIlw8tIDOqJ9lkAKtm4YYcgiWrqU+uK7zRigUm8M5p7fMyUWN5wqaSMeXGWDLZfjI
        5SXUv1Jdby/R8o6h90D5sMa61yOfpmu8JnPdUmYaCmFljabGtJ0FRFat2EPJKItJMY6jPY
        PSKPOr1tsTJRgY9M64tlulTK81wCDT4YqfzfyCTjU13vOfh2w/auiXqLn58+usM01hFvEj
        phCeZbRh+tFtvVYzLpKf6fEWWL15w3ECEfUhw3KJObnVvTb4cTRO/6sgCV070WMp1lC3eA
        2Czhsb0l7NkzOIgYV+kW2RfbtnH9BgjNwrA8GYd1bJrSWsCPsM68Xb3wHqqg1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684579744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2A6eFh/3+2YwL0QgYX1GsfteLpgTzxkBYbhqgvbN5Po=;
        b=rOcl92MPpE2UchCFyjZ8fCovztrPm6Ja/MNQ1rm7eYbnLIOPLtIeCyjau08kZCjzqFuKse
        pqonyvQT8M2VYoBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] arch: Introduce arch_{,try_}_cmpxchg128{,_local}()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230515080554.114813040@infradead.org>
References: <20230515080554.114813040@infradead.org>
MIME-Version: 1.0
Message-ID: <168457974406.404.16058329658158799365.tip-bot2@tip-bot2>
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

Commit-ID:     1bb3ba21c2c235f637f5ad6b7e56c2471a52716c
Gitweb:        https://git.kernel.org/tip/1bb3ba21c2c235f637f5ad6b7e56c2471a52716c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 May 2023 09:57:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 May 2023 12:35:11 +02:00

arch: Introduce arch_{,try_}_cmpxchg128{,_local}()

For all architectures that currently support cmpxchg_double()
implement the cmpxchg128() family of functions that is basically the
same but with a saner interface.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230515080554.114813040@infradead.org
---
 arch/arm64/include/asm/atomic_ll_sc.h | 41 +++++++++++++++++-
 arch/arm64/include/asm/atomic_lse.h   | 31 +++++++++++++-
 arch/arm64/include/asm/cmpxchg.h      | 26 +++++++++++-
 arch/s390/include/asm/cmpxchg.h       | 14 ++++++-
 arch/x86/include/asm/cmpxchg_32.h     |  3 +-
 arch/x86/include/asm/cmpxchg_64.h     | 64 +++++++++++++++++++++++++-
 6 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
index cbb3d96..b100a49 100644
--- a/arch/arm64/include/asm/atomic_ll_sc.h
+++ b/arch/arm64/include/asm/atomic_ll_sc.h
@@ -326,6 +326,47 @@ __CMPXCHG_DBL(   ,        ,  ,         )
 __CMPXCHG_DBL(_mb, dmb ish, l, "memory")
 
 #undef __CMPXCHG_DBL
+
+union __u128_halves {
+	u128 full;
+	struct {
+		u64 low, high;
+	};
+};
+
+#define __CMPXCHG128(name, mb, rel, cl...)                             \
+static __always_inline u128						\
+__ll_sc__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)	\
+{									\
+	union __u128_halves r, o = { .full = (old) },			\
+			       n = { .full = (new) };			\
+       unsigned int tmp;                                               \
+									\
+	asm volatile("// __cmpxchg128" #name "\n"			\
+       "       prfm    pstl1strm, %[v]\n"                              \
+       "1:     ldxp    %[rl], %[rh], %[v]\n"                           \
+       "       cmp     %[rl], %[ol]\n"                                 \
+       "       ccmp    %[rh], %[oh], 0, eq\n"                          \
+       "       b.ne    2f\n"                                           \
+       "       st" #rel "xp    %w[tmp], %[nl], %[nh], %[v]\n"          \
+       "       cbnz    %w[tmp], 1b\n"                                  \
+	"	" #mb "\n"						\
+	"2:"								\
+       : [v] "+Q" (*(u128 *)ptr),                                      \
+         [rl] "=&r" (r.low), [rh] "=&r" (r.high),                      \
+         [tmp] "=&r" (tmp)                                             \
+       : [ol] "r" (o.low), [oh] "r" (o.high),                          \
+         [nl] "r" (n.low), [nh] "r" (n.high)                           \
+       : "cc", ##cl);                                                  \
+									\
+	return r.full;							\
+}
+
+__CMPXCHG128(   ,        ,  )
+__CMPXCHG128(_mb, dmb ish, l, "memory")
+
+#undef __CMPXCHG128
+
 #undef K
 
 #endif	/* __ASM_ATOMIC_LL_SC_H */
diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
index 319958b..c781281 100644
--- a/arch/arm64/include/asm/atomic_lse.h
+++ b/arch/arm64/include/asm/atomic_lse.h
@@ -317,4 +317,35 @@ __CMPXCHG_DBL(_mb, al, "memory")
 
 #undef __CMPXCHG_DBL
 
+#define __CMPXCHG128(name, mb, cl...)					\
+static __always_inline u128						\
+__lse__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)		\
+{									\
+	union __u128_halves r, o = { .full = (old) },			\
+			       n = { .full = (new) };			\
+	register unsigned long x0 asm ("x0") = o.low;			\
+	register unsigned long x1 asm ("x1") = o.high;			\
+	register unsigned long x2 asm ("x2") = n.low;			\
+	register unsigned long x3 asm ("x3") = n.high;			\
+	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
+									\
+	asm volatile(							\
+	__LSE_PREAMBLE							\
+	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
+	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
+	  [v] "+Q" (*(u128 *)ptr)					\
+	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
+	  [oldval1] "r" (o.low), [oldval2] "r" (o.high)			\
+	: cl);								\
+									\
+	r.low = x0; r.high = x1;					\
+									\
+	return r.full;							\
+}
+
+__CMPXCHG128(   ,   )
+__CMPXCHG128(_mb, al, "memory")
+
+#undef __CMPXCHG128
+
 #endif	/* __ASM_ATOMIC_LSE_H */
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index c6bc5d8..097b832 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -146,6 +146,19 @@ __CMPXCHG_DBL(_mb)
 
 #undef __CMPXCHG_DBL
 
+#define __CMPXCHG128(name)						\
+static inline u128 __cmpxchg128##name(volatile u128 *ptr,		\
+				      u128 old, u128 new)		\
+{									\
+	return __lse_ll_sc_body(_cmpxchg128##name,			\
+				ptr, old, new);				\
+}
+
+__CMPXCHG128(   )
+__CMPXCHG128(_mb)
+
+#undef __CMPXCHG128
+
 #define __CMPXCHG_GEN(sfx)						\
 static __always_inline unsigned long __cmpxchg##sfx(volatile void *ptr,	\
 					   unsigned long old,		\
@@ -228,6 +241,19 @@ __CMPXCHG_GEN(_mb)
 	__ret;									\
 })
 
+/* cmpxchg128 */
+#define system_has_cmpxchg128()		1
+
+#define arch_cmpxchg128(ptr, o, n)						\
+({										\
+	__cmpxchg128_mb((ptr), (o), (n));					\
+})
+
+#define arch_cmpxchg128_local(ptr, o, n)					\
+({										\
+	__cmpxchg128((ptr), (o), (n));						\
+})
+
 #define __CMPWAIT_CASE(w, sfx, sz)					\
 static inline void __cmpwait_case_##sz(volatile void *ptr,		\
 				       unsigned long val)		\
diff --git a/arch/s390/include/asm/cmpxchg.h b/arch/s390/include/asm/cmpxchg.h
index 06e0e42..7517376 100644
--- a/arch/s390/include/asm/cmpxchg.h
+++ b/arch/s390/include/asm/cmpxchg.h
@@ -224,4 +224,18 @@ static __always_inline int __cmpxchg_double(unsigned long p1, unsigned long p2,
 			 (unsigned long)(n1), (unsigned long)(n2));	\
 })
 
+#define system_has_cmpxchg128()		1
+
+static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
+{
+	asm volatile(
+		"	cdsg	%[old],%[new],%[ptr]\n"
+		: [old] "+d" (old), [ptr] "+QS" (*ptr)
+		: [new] "d" (new)
+		: "memory", "cc");
+	return old;
+}
+
+#define arch_cmpxchg128		arch_cmpxchg128
+
 #endif /* __ASM_CMPXCHG_H */
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 6ba80ce..d12f9ed 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -103,6 +103,7 @@ static inline bool __try_cmpxchg64(volatile u64 *ptr, u64 *pold, u64 new)
 
 #endif
 
-#define system_has_cmpxchg_double() boot_cpu_has(X86_FEATURE_CX8)
+#define system_has_cmpxchg_double()	boot_cpu_has(X86_FEATURE_CX8)
+#define system_has_cmpxchg64()		boot_cpu_has(X86_FEATURE_CX8)
 
 #endif /* _ASM_X86_CMPXCHG_32_H */
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 0d3beb2..fe29107 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -20,6 +20,68 @@
 	arch_try_cmpxchg((ptr), (po), (n));				\
 })
 
-#define system_has_cmpxchg_double() boot_cpu_has(X86_FEATURE_CX16)
+union __u128_halves {
+	u128 full;
+	struct {
+		u64 low, high;
+	};
+};
+
+#define __arch_cmpxchg128(_ptr, _old, _new, _lock)			\
+({									\
+	union __u128_halves o = { .full = (_old), },			\
+			    n = { .full = (_new), };			\
+									\
+	asm volatile(_lock "cmpxchg16b %[ptr]"				\
+		     : [ptr] "+m" (*(_ptr)),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high)			\
+		     : "memory");					\
+									\
+	o.full;								\
+})
+
+static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
+{
+	return __arch_cmpxchg128(ptr, old, new, LOCK_PREFIX);
+}
+
+static __always_inline u128 arch_cmpxchg128_local(volatile u128 *ptr, u128 old, u128 new)
+{
+	return __arch_cmpxchg128(ptr, old, new,);
+}
+
+#define __arch_try_cmpxchg128(_ptr, _oldp, _new, _lock)			\
+({									\
+	union __u128_halves o = { .full = *(_oldp), },			\
+			    n = { .full = (_new), };			\
+	bool ret;							\
+									\
+	asm volatile(_lock "cmpxchg16b %[ptr]"				\
+		     CC_SET(e)						\
+		     : CC_OUT(e) (ret),					\
+		       [ptr] "+m" (*ptr),				\
+		       "+a" (o.low), "+d" (o.high)			\
+		     : "b" (n.low), "c" (n.high)			\
+		     : "memory");					\
+									\
+	if (unlikely(!ret))						\
+		*(_oldp) = o.full;					\
+									\
+	likely(ret);							\
+})
+
+static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *oldp, u128 new)
+{
+	return __arch_try_cmpxchg128(ptr, oldp, new, LOCK_PREFIX);
+}
+
+static __always_inline bool arch_try_cmpxchg128_local(volatile u128 *ptr, u128 *oldp, u128 new)
+{
+	return __arch_try_cmpxchg128(ptr, oldp, new,);
+}
+
+#define system_has_cmpxchg_double()	boot_cpu_has(X86_FEATURE_CX16)
+#define system_has_cmpxchg128()		boot_cpu_has(X86_FEATURE_CX16)
 
 #endif /* _ASM_X86_CMPXCHG_64_H */
