Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEDD682F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjAaOWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjAaOWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:22:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7583A23859;
        Tue, 31 Jan 2023 06:22:29 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675174948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4G14+ekvYO/NDmGQDCsXbInmS4RuIIXCyfANPWDSrZo=;
        b=ghOX4mzm0u5V1S4z0OfFH5oDJvy9fE3p81cKvJyMm6lZBgu5SNQrjiwGnEEkmIJigadGl+
        2RWjn1TSP8dPpAdkA/fuWZIkszk+wzQHT5fDuwBiz942p4xEnCUM32y+uJEpJrZXVD+YJs
        6PxUHEenVBBbIUXaD+8uPfyv/T4CAIPmDteE3b/JVwFrl4qNpp10iJhodPRD8yycLExVvB
        8qezO9axACPR3hLkUWrdCyand3vd4kzJn9a7iQoSNpeg19WrdKinOnlUCA3q/WdiqAvnzN
        4UIZH3t5ojrtBv3E+KhaXcyHTml//mFEuuFeLjpfyLhf6+BoL56wCIJNFGwlOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675174948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4G14+ekvYO/NDmGQDCsXbInmS4RuIIXCyfANPWDSrZo=;
        b=yLgFMGkrIzmHztStfG+5SqphdiVilHhZAMS6SpQ6ogzdUILoD/BKM/9UwOBbKoJmWd/Aht
        xJmjEYrVv4COq4Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/atomics: Always inline arch_atomic64*()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230126151323.585115019@infradead.org>
References: <20230126151323.585115019@infradead.org>
MIME-Version: 1.0
Message-ID: <167517494778.4906.7689889716452581880.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7aab7aa4b4bed2b9030fcdd207e0f3a5d257bda0
Gitweb:        https://git.kernel.org/tip/7aab7aa4b4bed2b9030fcdd207e0f3a5d257bda0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Jan 2023 16:08:34 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 31 Jan 2023 15:01:46 +01:00

x86/atomics: Always inline arch_atomic64*()

As already done for regular arch_atomic*(), always inline arch_atomic64*().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230126151323.585115019@infradead.org
---
 arch/x86/include/asm/atomic64_32.h | 44 ++++++++++++++---------------
 arch/x86/include/asm/atomic64_64.h | 36 ++++++++++++------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 5efd01b..808b4ee 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -71,7 +71,7 @@ ATOMIC64_DECL(add_unless);
  * the old value.
  */
 
-static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
+static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	return arch_cmpxchg64(&v->counter, o, n);
 }
@@ -85,7 +85,7 @@ static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
  * Atomically xchgs the value of @v to @n and returns
  * the old value.
  */
-static inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
+static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 {
 	s64 o;
 	unsigned high = (unsigned)(n >> 32);
@@ -104,7 +104,7 @@ static inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
  *
  * Atomically sets the value of @v to @n.
  */
-static inline void arch_atomic64_set(atomic64_t *v, s64 i)
+static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned high = (unsigned)(i >> 32);
 	unsigned low = (unsigned)i;
@@ -119,7 +119,7 @@ static inline void arch_atomic64_set(atomic64_t *v, s64 i)
  *
  * Atomically reads the value of @v and returns it.
  */
-static inline s64 arch_atomic64_read(const atomic64_t *v)
+static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 r;
 	alternative_atomic64(read, "=&A" (r), "c" (v) : "memory");
@@ -133,7 +133,7 @@ static inline s64 arch_atomic64_read(const atomic64_t *v)
  *
  * Atomically adds @i to @v and returns @i + *@v
  */
-static inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(add_return,
 			     ASM_OUTPUT2("+A" (i), "+c" (v)),
@@ -145,7 +145,7 @@ static inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 /*
  * Other variants with different arithmetic operators:
  */
-static inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(sub_return,
 			     ASM_OUTPUT2("+A" (i), "+c" (v)),
@@ -154,7 +154,7 @@ static inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_sub_return arch_atomic64_sub_return
 
-static inline s64 arch_atomic64_inc_return(atomic64_t *v)
+static __always_inline s64 arch_atomic64_inc_return(atomic64_t *v)
 {
 	s64 a;
 	alternative_atomic64(inc_return, "=&A" (a),
@@ -163,7 +163,7 @@ static inline s64 arch_atomic64_inc_return(atomic64_t *v)
 }
 #define arch_atomic64_inc_return arch_atomic64_inc_return
 
-static inline s64 arch_atomic64_dec_return(atomic64_t *v)
+static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
 {
 	s64 a;
 	alternative_atomic64(dec_return, "=&A" (a),
@@ -179,7 +179,7 @@ static inline s64 arch_atomic64_dec_return(atomic64_t *v)
  *
  * Atomically adds @i to @v.
  */
-static inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(add, add_return,
 			       ASM_OUTPUT2("+A" (i), "+c" (v)),
@@ -194,7 +194,7 @@ static inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
  *
  * Atomically subtracts @i from @v.
  */
-static inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(sub, sub_return,
 			       ASM_OUTPUT2("+A" (i), "+c" (v)),
@@ -208,7 +208,7 @@ static inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
  *
  * Atomically increments @v by 1.
  */
-static inline void arch_atomic64_inc(atomic64_t *v)
+static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	__alternative_atomic64(inc, inc_return, /* no output */,
 			       "S" (v) : "memory", "eax", "ecx", "edx");
@@ -221,7 +221,7 @@ static inline void arch_atomic64_inc(atomic64_t *v)
  *
  * Atomically decrements @v by 1.
  */
-static inline void arch_atomic64_dec(atomic64_t *v)
+static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	__alternative_atomic64(dec, dec_return, /* no output */,
 			       "S" (v) : "memory", "eax", "ecx", "edx");
@@ -237,7 +237,7 @@ static inline void arch_atomic64_dec(atomic64_t *v)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns non-zero if the add was done, zero otherwise.
  */
-static inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+static __always_inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	unsigned low = (unsigned)u;
 	unsigned high = (unsigned)(u >> 32);
@@ -248,7 +248,7 @@ static inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 }
 #define arch_atomic64_add_unless arch_atomic64_add_unless
 
-static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
+static __always_inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
 	int r;
 	alternative_atomic64(inc_not_zero, "=&a" (r),
@@ -257,7 +257,7 @@ static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 }
 #define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
 
-static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
+static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 r;
 	alternative_atomic64(dec_if_positive, "=&A" (r),
@@ -269,7 +269,7 @@ static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 #undef alternative_atomic64
 #undef __alternative_atomic64
 
-static inline void arch_atomic64_and(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -277,7 +277,7 @@ static inline void arch_atomic64_and(s64 i, atomic64_t *v)
 		c = old;
 }
 
-static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -288,7 +288,7 @@ static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
-static inline void arch_atomic64_or(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -296,7 +296,7 @@ static inline void arch_atomic64_or(s64 i, atomic64_t *v)
 		c = old;
 }
 
-static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -307,7 +307,7 @@ static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
-static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -315,7 +315,7 @@ static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 		c = old;
 }
 
-static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -326,7 +326,7 @@ static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
 
-static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 7886d05..c496595 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -17,7 +17,7 @@
  * Atomically reads the value of @v.
  * Doesn't imply a read memory barrier.
  */
-static inline s64 arch_atomic64_read(const atomic64_t *v)
+static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	return __READ_ONCE((v)->counter);
 }
@@ -29,7 +29,7 @@ static inline s64 arch_atomic64_read(const atomic64_t *v)
  *
  * Atomically sets the value of @v to @i.
  */
-static inline void arch_atomic64_set(atomic64_t *v, s64 i)
+static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	__WRITE_ONCE(v->counter, i);
 }
@@ -55,7 +55,7 @@ static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
  *
  * Atomically subtracts @i from @v.
  */
-static inline void arch_atomic64_sub(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "subq %1,%0"
 		     : "=m" (v->counter)
@@ -71,7 +71,7 @@ static inline void arch_atomic64_sub(s64 i, atomic64_t *v)
  * true if the result is zero, or false for all
  * other cases.
  */
-static inline bool arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
+static __always_inline bool arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "subq", v->counter, e, "er", i);
 }
@@ -113,7 +113,7 @@ static __always_inline void arch_atomic64_dec(atomic64_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
-static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
+static __always_inline bool arch_atomic64_dec_and_test(atomic64_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, e);
 }
@@ -127,7 +127,7 @@ static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
+static __always_inline bool arch_atomic64_inc_and_test(atomic64_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, e);
 }
@@ -142,7 +142,7 @@ static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static inline bool arch_atomic64_add_negative(s64 i, atomic64_t *v)
+static __always_inline bool arch_atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, s, "er", i);
 }
@@ -161,25 +161,25 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
 
-static inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	return arch_atomic64_add_return(-i, v);
 }
 #define arch_atomic64_sub_return arch_atomic64_sub_return
 
-static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	return xadd(&v->counter, i);
 }
 #define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
-static inline s64 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	return xadd(&v->counter, -i);
 }
 #define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
 
-static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	return arch_cmpxchg(&v->counter, old, new);
 }
@@ -191,13 +191,13 @@ static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s
 }
 #define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 
-static inline s64 arch_atomic64_xchg(atomic64_t *v, s64 new)
+static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 new)
 {
 	return arch_xchg(&v->counter, new);
 }
 #define arch_atomic64_xchg arch_atomic64_xchg
 
-static inline void arch_atomic64_and(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "andq %1,%0"
 			: "+m" (v->counter)
@@ -205,7 +205,7 @@ static inline void arch_atomic64_and(s64 i, atomic64_t *v)
 			: "memory");
 }
 
-static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	s64 val = arch_atomic64_read(v);
 
@@ -215,7 +215,7 @@ static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
-static inline void arch_atomic64_or(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "orq %1,%0"
 			: "+m" (v->counter)
@@ -223,7 +223,7 @@ static inline void arch_atomic64_or(s64 i, atomic64_t *v)
 			: "memory");
 }
 
-static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	s64 val = arch_atomic64_read(v);
 
@@ -233,7 +233,7 @@ static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 }
 #define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
-static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "xorq %1,%0"
 			: "+m" (v->counter)
@@ -241,7 +241,7 @@ static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 			: "memory");
 }
 
-static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	s64 val = arch_atomic64_read(v);
 
