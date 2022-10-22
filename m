Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECEB608CF7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJVLtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJVLsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4922505E0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vmo888klJOYTK6NXdYxj1ylLTVw6+U7xUyde2QpBL2o=; b=bYr1reyz4HyDuluM2y+c4SgJM0
        PBJN8uYkZxEcRHT3GePK91yBuUwfsfegkY9kOgusA3DzeACZX107P9rwRsGS+B5vmcl2jCFpRqPPq
        dY+JhH8JW06eGjLRNrjQfsUO/3WvAUW0Mnr0U8/5MItJ1KB06PnuMLz9AKqkVjcZ+3ImKa4B4PPbx
        MXfbYcCiAe9q7O28LJ1ssPhDG1tuqtRmAMRil+8BvHeMkUevTn5g569pTJJaTks3FEbOAnHuEgDx5
        13zre+JP7+tEWJSrresAW1tKhUL7Mnjcjod2QJFzkI1sVeA4Id2JzSbvBWj8QCFumXkoCwc6YQj9L
        ka4hjhhw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzR-00Dtgv-LC; Sat, 22 Oct 2022 11:48:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA46F303106;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 46C8E28B8E519; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114425.233481884@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 12/13] x86/mm/pae: Get rid of set_64bit()
References: <20221022111403.531902164@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recognise that set_64bit() is a special case of our previously
introduced pxx_xchg64(), so use that and get rid of set_64bit().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cmpxchg_32.h     |   28 ----------------------------
 arch/x86/include/asm/pgtable-3level.h |   23 ++++++++++++-----------
 2 files changed, 12 insertions(+), 39 deletions(-)

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
@@ -34,12 +42,12 @@ static inline void native_set_pte(pte_t
 
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
@@ -47,7 +55,7 @@ static inline void native_set_pud(pud_t
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	pud.p4d.pgd = pti_set_user_pgtbl(&pudp->p4d.pgd, pud.p4d.pgd);
 #endif
-	set_64bit((unsigned long long *)(pudp), native_pud_val(pud));
+	pxx_xchg64(pud, pudp, native_pud_val(pud));
 }
 
 /*
@@ -91,13 +99,6 @@ static inline void pud_clear(pud_t *pudp
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


