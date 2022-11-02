Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B924B615F30
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiKBJNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKBJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:12:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F2A27FD5;
        Wed,  2 Nov 2022 02:12:37 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qNGxcMkuceJqA/3wmgxw7BIsF0Ziwr52CUQOIxGLBOY=;
        b=3cglp646GSLwCquPiPaAyBj7czbUOoEwImB/SjZJeuhj3K5+YuzYlI0UCZj8++SqsWkbbC
        6UTZEhEzwj+r6G8AoB49SfcHYXKNx8O4oqjh1mIP+3bQrbWdQ+tLZ+FZYApBxwu6SF8eM/
        kJb4dx7qVfRY/MEyFhvtdRWVKdayHQNX6crZiY37eikMSedsZDBr0aUXdFA9z0dkJGYM0r
        pq+ox+Xmnly5e5f8kRcqMYii7L/MAq7k8v1XVb4JD8x1CHD6uz9gcRBe9nXd6wyQtzLR6f
        s0wpqJ2gXuerQIehsZWaRrcjpzC0a6YWyIvsLsD/zNgz1o5CFqxKfi0YaZF6tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qNGxcMkuceJqA/3wmgxw7BIsF0Ziwr52CUQOIxGLBOY=;
        b=Unr1sL0HUfwpheHXbrpNXzdM3Omws0xtgPeyVYRcWL8oROd2QNIimreL57nGIFVI2Z593c
        1rLXbzUuL1vcXcAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pae: Get rid of set_64bit()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738035405.7716.9700132748007887635.tip-bot2@tip-bot2>
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

Commit-ID:     bf7e50599a05933abf9e8f69789d888955d15567
Gitweb:        https://git.kernel.org/tip/bf7e50599a05933abf9e8f69789d888955d15567
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 21 Oct 2022 13:36:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:04 +01:00

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
