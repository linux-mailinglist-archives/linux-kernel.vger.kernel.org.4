Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71733616D98
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKBTOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiKBTNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6551093
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667416356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oG73sr0tgN0FOFIU5VbItTzL5MpyEbutOOG4W8LKcXk=;
        b=WiMUIpD+cB27FwHWFC2Xa3pqG+FmIU9LYX2Lvgaxgjfnu/De2IHwK95eH8D2afXKPf6UTW
        pYXP/qrawjgSMSJPEutnXwIOIP5iSP03TirxQLbkvQdjg95rNphWT5EiwNtFEkAj3iFNeZ
        13kHO3ap9eiV/jKZ9SbJeMYHKaBw+UU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-vwTG6ALHNO6hlVtNI3mpWw-1; Wed, 02 Nov 2022 15:12:35 -0400
X-MC-Unique: vwTG6ALHNO6hlVtNI3mpWw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAA6D101A54E;
        Wed,  2 Nov 2022 19:12:34 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.192.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D12049BB60;
        Wed,  2 Nov 2022 19:12:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Chinner <david@fromorbit.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v1 5/6] mm: remove unused savedwrite infrastructure
Date:   Wed,  2 Nov 2022 20:12:08 +0100
Message-Id: <20221102191209.289237-6-david@redhat.com>
In-Reply-To: <20221102191209.289237-1-david@redhat.com>
References: <20221102191209.289237-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA hinting no longer uses savedwrite, let's rip it out.

... and while at it, drop __pte_write() and __pmd_write() on ppc64.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 80 +-------------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c          |  2 +-
 include/linux/pgtable.h                      | 24 ------
 mm/debug_vm_pgtable.c                        | 32 --------
 4 files changed, 5 insertions(+), 133 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c436d8422654..cb4c67bf45d7 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -401,35 +401,9 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
 #define pmdp_clear_flush_young pmdp_test_and_clear_young
 
-static inline int __pte_write(pte_t pte)
-{
-	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_WRITE));
-}
-
-#ifdef CONFIG_NUMA_BALANCING
-#define pte_savedwrite pte_savedwrite
-static inline bool pte_savedwrite(pte_t pte)
-{
-	/*
-	 * Saved write ptes are prot none ptes that doesn't have
-	 * privileged bit sit. We mark prot none as one which has
-	 * present and pviliged bit set and RWX cleared. To mark
-	 * protnone which used to have _PAGE_WRITE set we clear
-	 * the privileged bit.
-	 */
-	return !(pte_raw(pte) & cpu_to_be64(_PAGE_RWX | _PAGE_PRIVILEGED));
-}
-#else
-#define pte_savedwrite pte_savedwrite
-static inline bool pte_savedwrite(pte_t pte)
-{
-	return false;
-}
-#endif
-
 static inline int pte_write(pte_t pte)
 {
-	return __pte_write(pte) || pte_savedwrite(pte);
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_WRITE));
 }
 
 static inline int pte_read(pte_t pte)
@@ -441,24 +415,16 @@ static inline int pte_read(pte_t pte)
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-	if (__pte_write(*ptep))
+	if (pte_write(*ptep))
 		pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 0);
-	else if (unlikely(pte_savedwrite(*ptep)))
-		pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 0);
 }
 
 #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	/*
-	 * We should not find protnone for hugetlb, but this complete the
-	 * interface.
-	 */
-	if (__pte_write(*ptep))
+	if (pte_write(*ptep))
 		pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 1);
-	else if (unlikely(pte_savedwrite(*ptep)))
-		pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 1);
 }
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
@@ -535,36 +501,6 @@ static inline int pte_protnone(pte_t pte)
 	return (pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_PTE | _PAGE_RWX)) ==
 		cpu_to_be64(_PAGE_PRESENT | _PAGE_PTE);
 }
-
-#define pte_mk_savedwrite pte_mk_savedwrite
-static inline pte_t pte_mk_savedwrite(pte_t pte)
-{
-	/*
-	 * Used by Autonuma subsystem to preserve the write bit
-	 * while marking the pte PROT_NONE. Only allow this
-	 * on PROT_NONE pte
-	 */
-	VM_BUG_ON((pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_RWX | _PAGE_PRIVILEGED)) !=
-		  cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED));
-	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_PRIVILEGED));
-}
-
-#define pte_clear_savedwrite pte_clear_savedwrite
-static inline pte_t pte_clear_savedwrite(pte_t pte)
-{
-	/*
-	 * Used by KSM subsystem to make a protnone pte readonly.
-	 */
-	VM_BUG_ON(!pte_protnone(pte));
-	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_PRIVILEGED));
-}
-#else
-#define pte_clear_savedwrite pte_clear_savedwrite
-static inline pte_t pte_clear_savedwrite(pte_t pte)
-{
-	VM_WARN_ON(1);
-	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_WRITE));
-}
 #endif /* CONFIG_NUMA_BALANCING */
 
 static inline bool pte_hw_valid(pte_t pte)
@@ -641,8 +577,6 @@ static inline unsigned long pte_pfn(pte_t pte)
 /* Generic modifiers for PTE bits */
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	if (unlikely(pte_savedwrite(pte)))
-		return pte_clear_savedwrite(pte);
 	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_WRITE));
 }
 
@@ -1139,8 +1073,6 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
-#define pmd_mk_savedwrite(pmd)	pte_pmd(pte_mk_savedwrite(pmd_pte(pmd)))
-#define pmd_clear_savedwrite(pmd)	pte_pmd(pte_clear_savedwrite(pmd_pte(pmd)))
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 #define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
@@ -1162,8 +1094,6 @@ static inline int pmd_protnone(pmd_t pmd)
 #endif /* CONFIG_NUMA_BALANCING */
 
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
-#define __pmd_write(pmd)	__pte_write(pmd_pte(pmd))
-#define pmd_savedwrite(pmd)	pte_savedwrite(pmd_pte(pmd))
 
 #define pmd_access_permitted pmd_access_permitted
 static inline bool pmd_access_permitted(pmd_t pmd, bool write)
@@ -1241,10 +1171,8 @@ static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pmd_t *pmdp)
 {
-	if (__pmd_write((*pmdp)))
+	if (pmd_write(*pmdp))
 		pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
-	else if (unlikely(pmd_savedwrite(*pmdp)))
-		pmd_hugepage_update(mm, addr, pmdp, 0, _PAGE_PRIVILEGED);
 }
 
 /*
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 5a05953ae13f..9182324dbef9 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -265,7 +265,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		}
 		pte = kvmppc_read_update_linux_pte(ptep, writing);
 		if (pte_present(pte) && !pte_protnone(pte)) {
-			if (writing && !__pte_write(pte))
+			if (writing && !pte_write(pte))
 				/* make the actual HPTE be read-only */
 				ptel = hpte_make_readonly(ptel);
 			is_ci = pte_ci(pte);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a108b60a6962..35c80f4f06ec 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -485,30 +485,6 @@ static inline pte_t pte_sw_mkyoung(pte_t pte)
 #define pte_sw_mkyoung	pte_sw_mkyoung
 #endif
 
-#ifndef pte_savedwrite
-#define pte_savedwrite pte_write
-#endif
-
-#ifndef pte_mk_savedwrite
-#define pte_mk_savedwrite pte_mkwrite
-#endif
-
-#ifndef pte_clear_savedwrite
-#define pte_clear_savedwrite pte_wrprotect
-#endif
-
-#ifndef pmd_savedwrite
-#define pmd_savedwrite pmd_write
-#endif
-
-#ifndef pmd_mk_savedwrite
-#define pmd_mk_savedwrite pmd_mkwrite
-#endif
-
-#ifndef pmd_clear_savedwrite
-#define pmd_clear_savedwrite pmd_wrprotect
-#endif
-
 #ifndef __HAVE_ARCH_PMDP_SET_WRPROTECT
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 2b61fde8c38c..c631ade3f1d2 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -171,18 +171,6 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
 	ptep_get_and_clear_full(args->mm, args->vaddr, args->ptep, 1);
 }
 
-static void __init pte_savedwrite_tests(struct pgtable_debug_args *args)
-{
-	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot_none);
-
-	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
-		return;
-
-	pr_debug("Validating PTE saved write\n");
-	WARN_ON(!pte_savedwrite(pte_mk_savedwrite(pte_clear_savedwrite(pte))));
-	WARN_ON(pte_savedwrite(pte_clear_savedwrite(pte_mk_savedwrite(pte))));
-}
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 {
@@ -302,22 +290,6 @@ static void __init pmd_leaf_tests(struct pgtable_debug_args *args)
 	WARN_ON(!pmd_leaf(pmd));
 }
 
-static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args)
-{
-	pmd_t pmd;
-
-	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
-		return;
-
-	if (!has_transparent_hugepage())
-		return;
-
-	pr_debug("Validating PMD saved write\n");
-	pmd = pfn_pmd(args->fixed_pmd_pfn, args->page_prot_none);
-	WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clear_savedwrite(pmd))));
-	WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk_savedwrite(pmd))));
-}
-
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx)
 {
@@ -451,7 +423,6 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args) { }
 static void __init pud_advanced_tests(struct pgtable_debug_args *args) { }
 static void __init pmd_leaf_tests(struct pgtable_debug_args *args) { }
 static void __init pud_leaf_tests(struct pgtable_debug_args *args) { }
-static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
@@ -1288,9 +1259,6 @@ static int __init debug_vm_pgtable(void)
 	pmd_leaf_tests(&args);
 	pud_leaf_tests(&args);
 
-	pte_savedwrite_tests(&args);
-	pmd_savedwrite_tests(&args);
-
 	pte_special_tests(&args);
 	pte_protnone_tests(&args);
 	pmd_protnone_tests(&args);
-- 
2.38.1

