Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FE1608CF8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJVLto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJVLs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FDB251D59
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=WrWjWAdXlYrZgI+2wdU5TCD9SMPt4h2Vfa3Cvok7+uU=; b=nwDkzw3R5O12iesOP1q8VwET/4
        ZsL/dWqBoN6o0f0YpYhXVZ3YijSmTavj8IkPaWHQEqvefhwtLf1jemo/PGf5ldXjjwMRsIjSqacpe
        xst/jckJF8WzaoFNFKMklCC16WgqrSaV6BVJBi3IWWzqOi4gfDwqytHzaZmw3wjdmpWGiFZle50zi
        kPQ/2PGDg0ljw0gZjsm4HzQ5CICs1p+mnrJeR7VDEtP9QHcoJ/+q3IFu0klABPRfnUhNCxm6hhtrI
        gWNG3kd08LexHBzRJStQuirx3jBgrbnqxgJjQsfmcJzsW/K5l6IAmX2YsavdKyVGhUNAtUCo6j/TI
        v8um1bAQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzL-005XdD-G3; Sat, 22 Oct 2022 11:48:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E33D300BBA;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2841228B8E50F; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114424.711181252@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 04/13] mm: Fix pmd_read_atomic()
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

AFAICT there's no reason to do anything different than what we do for
PTEs. Make it so (also affects SH).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable-3level.h |   56 ----------------------------------
 include/linux/pgtable.h               |   49 +++++++++++++++++++++++------
 2 files changed, 39 insertions(+), 66 deletions(-)

--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -34,62 +34,6 @@ static inline void native_set_pte(pte_t
 	ptep->pte_low = pte.pte_low;
 }
 
-#define pmd_read_atomic pmd_read_atomic
-/*
- * pte_offset_map_lock() on 32-bit PAE kernels was reading the pmd_t with
- * a "*pmdp" dereference done by GCC. Problem is, in certain places
- * where pte_offset_map_lock() is called, concurrent page faults are
- * allowed, if the mmap_lock is hold for reading. An example is mincore
- * vs page faults vs MADV_DONTNEED. On the page fault side
- * pmd_populate() rightfully does a set_64bit(), but if we're reading the
- * pmd_t with a "*pmdp" on the mincore side, a SMP race can happen
- * because GCC will not read the 64-bit value of the pmd atomically.
- *
- * To fix this all places running pte_offset_map_lock() while holding the
- * mmap_lock in read mode, shall read the pmdp pointer using this
- * function to know if the pmd is null or not, and in turn to know if
- * they can run pte_offset_map_lock() or pmd_trans_huge() or other pmd
- * operations.
- *
- * Without THP if the mmap_lock is held for reading, the pmd can only
- * transition from null to not null while pmd_read_atomic() runs. So
- * we can always return atomic pmd values with this function.
- *
- * With THP if the mmap_lock is held for reading, the pmd can become
- * trans_huge or none or point to a pte (and in turn become "stable")
- * at any time under pmd_read_atomic(). We could read it truly
- * atomically here with an atomic64_read() for the THP enabled case (and
- * it would be a whole lot simpler), but to avoid using cmpxchg8b we
- * only return an atomic pmdval if the low part of the pmdval is later
- * found to be stable (i.e. pointing to a pte). We are also returning a
- * 'none' (zero) pmdval if the low part of the pmd is zero.
- *
- * In some cases the high and low part of the pmdval returned may not be
- * consistent if THP is enabled (the low part may point to previously
- * mapped hugepage, while the high part may point to a more recently
- * mapped hugepage), but pmd_none_or_trans_huge_or_clear_bad() only
- * needs the low part of the pmd to be read atomically to decide if the
- * pmd is unstable or not, with the only exception when the low part
- * of the pmd is zero, in which case we return a 'none' pmd.
- */
-static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
-{
-	pmdval_t ret;
-	u32 *tmp = (u32 *)pmdp;
-
-	ret = (pmdval_t) (*tmp);
-	if (ret) {
-		/*
-		 * If the low part is null, we must not read the high part
-		 * or we can end up with a partial pmd.
-		 */
-		smp_rmb();
-		ret |= ((pmdval_t)*(tmp + 1)) << 32;
-	}
-
-	return (pmd_t) { .pmd = ret };
-}
-
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
 {
 	set_64bit((unsigned long long *)(ptep), native_pte_val(pte));
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -258,6 +258,13 @@ static inline pte_t ptep_get(pte_t *ptep
 }
 #endif
 
+#ifndef __HAVE_ARCH_PMDP_GET
+static inline pmd_t pmdp_get(pmd_t *pmdp)
+{
+	return READ_ONCE(*pmdp);
+}
+#endif
+
 #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
 /*
  * For walking the pagetables without holding any locks.  Some architectures
@@ -302,15 +309,42 @@ static inline pte_t ptep_get_lockless(pt
 
 	return pte;
 }
-#else /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+#define ptep_get_lockless ptep_get_lockless
+
+#if CONFIG_PGTABLE_LEVELS > 2
+static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
+{
+	pmd_t pmd;
+
+	do {
+		pmd.pmd_low = pmdp->pmd_low;
+		smp_rmb();
+		pmd.pmd_high = pmdp->pmd_high;
+		smp_rmb();
+	} while (unlikely(pmd.pmd_low != pmdp->pmd_low));
+
+	return pmd;
+}
+#define pmdp_get_lockless pmdp_get_lockless
+#endif /* CONFIG_PGTABLE_LEVELS > 2 */
+#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+
 /*
  * We require that the PTE can be read atomically.
  */
+#ifndef ptep_get_lockless
 static inline pte_t ptep_get_lockless(pte_t *ptep)
 {
 	return ptep_get(ptep);
 }
-#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+#endif
+
+#ifndef pmdp_get_lockless
+static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
+{
+	return pmdp_get(pmdp);
+}
+#endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
@@ -1211,17 +1247,10 @@ static inline int pud_trans_unstable(pud
 #endif
 }
 
-#ifndef pmd_read_atomic
 static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 {
-	/*
-	 * Depend on compiler for an atomic pmd read. NOTE: this is
-	 * only going to work, if the pmdval_t isn't larger than
-	 * an unsigned long.
-	 */
-	return *pmdp;
+	return pmdp_get_lockless(pmdp);
 }
-#endif
 
 #ifndef arch_needs_pgtable_deposit
 #define arch_needs_pgtable_deposit() (false)


