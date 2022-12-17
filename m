Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CCA64FBDF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiLQS4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiLQSzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E310FCA;
        Sat, 17 Dec 2022 10:55:36 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/DXzkQVHXsXFFQGhcGJkM2pr/WpSWQJKwqVtglGJv2c=;
        b=DmbTL+Vhx4GZyfW72NGc8SRrnOa20ipOD81wKQGK18Rk358/mxA7c6NkTo5Cg8DkPe0EIT
        c1QbAgb3YIb973GzPxOzXoYqGro64slwm7IasHbcogZ1b1mrf2ttrJduQpguLKj3NH2K9O
        2m8I17CuolzVPTtvgerxyInDBzZl7uP31MgbDH3l+Afw8Bo+eetnu93edkKslJ0T/96uoj
        DaclF/T9GsQSGTIBjiglJgoYsFmnRrSTza6gkpCPBl2CCbRV92l1EqztQ/AnXm7eQ5eMx7
        x6jn82nW4THT3BxfpOb73Et8sT1Ai7UO/p8rq74JlW8P3qvHCixKXhQryXE8TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/DXzkQVHXsXFFQGhcGJkM2pr/WpSWQJKwqVtglGJv2c=;
        b=P0KXSAqixfHPHt5eJrlXpOURWg9nrAKlfqMFX33j3BugeLzQxYUExkTnj9auElRuA/XvZz
        JEyyBYFeDoW76NBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pae: Get rid of set_64bit()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333199.4906.16686068094656515587.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     d4a72e7fe61a1ea9ad4accf3532411ca685eaead
Gitweb:        https://git.kernel.org/tip/d4a72e7fe61a1ea9ad4accf3532411ca685eaead
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 21 Oct 2022 13:36:24 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:27 -08:00

x86/mm/pae: Get rid of set_64bit()

Recognise that set_64bit() is a special case of our previously
introduced pxx_xchg64(), so use that and get rid of set_64bit().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114425.233481884%40infradead.org
---
 arch/x86/include/asm/cmpxchg_32.h     | 28 +--------------------------
 arch/x86/include/asm/pgtable-3level.h | 23 ++++++++++-----------
 2 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 215f5a6..6ba80ce 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -7,34 +7,6 @@
  *       you need to test for the feature in boot_cpu_data.
  */
 
-/*
- * CMPXCHG8B only writes to the target if we had the previous
- * value in registers, otherwise it acts as a read and gives us the
- * "new previous" value.  That is why there is a loop.  Preloading
- * EDX:EAX is a performance optimization: in the common case it means
- * we need only one locked operation.
- *
- * A SIMD/3DNOW!/MMX/FPU 64-bit store here would require at the very
- * least an FPU save and/or %cr0.ts manipulation.
- *
- * cmpxchg8b must be used with the lock prefix here to allow the
- * instruction to be executed atomically.  We need to have the reader
- * side to see the coherent 64bit value.
- */
-static inline void set_64bit(volatile u64 *ptr, u64 value)
-{
-	u32 low  = value;
-	u32 high = value >> 32;
-	u64 prev = *ptr;
-
-	asm volatile("\n1:\t"
-		     LOCK_PREFIX "cmpxchg8b %0\n\t"
-		     "jnz 1b"
-		     : "=m" (*ptr), "+A" (prev)
-		     : "b" (low), "c" (high)
-		     : "memory");
-}
-
 #ifdef CONFIG_X86_CMPXCHG64
 #define arch_cmpxchg64(ptr, o, n)					\
 	((__typeof__(*(ptr)))__cmpxchg64((ptr), (unsigned long long)(o), \
diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 93c82c6..967b135 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -19,7 +19,15 @@
 	pr_err("%s:%d: bad pgd %p(%016Lx)\n",				\
 	       __FILE__, __LINE__, &(e), pgd_val(e))
 
-/* Rules for using set_pte: the pte being assigned *must* be
+#define pxx_xchg64(_pxx, _ptr, _val) ({					\
+	_pxx##val_t *_p = (_pxx##val_t *)_ptr;				\
+	_pxx##val_t _o = *_p;						\
+	do { } while (!try_cmpxchg64(_p, &_o, (_val)));			\
+	native_make_##_pxx(_o);						\
+})
+
+/*
+ * Rules for using set_pte: the pte being assigned *must* be
  * either not present or in a state where the hardware will
  * not attempt to update the pte.  In places where this is
  * not possible, use pte_get_and_clear to obtain the old pte
@@ -34,12 +42,12 @@ static inline void native_set_pte(pte_t *ptep, pte_t pte)
 
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
 {
-	set_64bit((unsigned long long *)(ptep), native_pte_val(pte));
+	pxx_xchg64(pte, ptep, native_pte_val(pte));
 }
 
 static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-	set_64bit((unsigned long long *)(pmdp), native_pmd_val(pmd));
+	pxx_xchg64(pmd, pmdp, native_pmd_val(pmd));
 }
 
 static inline void native_set_pud(pud_t *pudp, pud_t pud)
@@ -47,7 +55,7 @@ static inline void native_set_pud(pud_t *pudp, pud_t pud)
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	pud.p4d.pgd = pti_set_user_pgtbl(&pudp->p4d.pgd, pud.p4d.pgd);
 #endif
-	set_64bit((unsigned long long *)(pudp), native_pud_val(pud));
+	pxx_xchg64(pud, pudp, native_pud_val(pud));
 }
 
 /*
@@ -91,13 +99,6 @@ static inline void pud_clear(pud_t *pudp)
 }
 
 
-#define pxx_xchg64(_pxx, _ptr, _val) ({					\
-	_pxx##val_t *_p = (_pxx##val_t *)_ptr;				\
-	_pxx##val_t _o = *_p;						\
-	do { } while (!try_cmpxchg64(_p, &_o, (_val)));			\
-	native_make_##_pxx(_o);						\
-})
-
 #ifdef CONFIG_SMP
 static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
 {
