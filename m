Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455B664D133
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiLNU2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiLNU2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:28:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572F863C9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671048939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xuWbRlu0A4fv1LOtBTJbD3K+c6vvdenfz7MWVW00HF0=;
        b=LAh2Z+651bE8wV5yz9rzsFJUFAw8ZbRw8ZnIynqkIRY23KAUI5pajuiLPcBu5t5tq5O7z1
        WTWfHpvFo31yl8CeVQ7IzI6L+0F+2LO9XA8MU9gpgC3//paioOHt8z+4H+9vXgzwhwquG4
        oIZk4eZqskYXOF28mHFUOTKA8ehHmj0=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-224-ESDmVfuUOcmhOVUq4rghdQ-1; Wed, 14 Dec 2022 15:15:37 -0500
X-MC-Unique: ESDmVfuUOcmhOVUq4rghdQ-1
Received: by mail-ua1-f72.google.com with SMTP id f16-20020ab014d0000000b00419c9d3424dso340454uae.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuWbRlu0A4fv1LOtBTJbD3K+c6vvdenfz7MWVW00HF0=;
        b=txcKULZZieqTHTbAEU/SsBkNShNBINZgAkBo9cK5D54J1UGO3n4fqzJEyAE56K/bsB
         vnjMtvHCV7dhVnr62JWHbQAA9Ze5H2O2MoT1INQk4gWjJjEmfsmRnaXZxBNt9KPEaSjT
         Hq7FjEIiNezINYn914ljHirQqmEJSNPw6hT9Zag1HrMX10xtQ5J+HL8w1dtys25WSiOO
         iKovYfCTs1E0KqGegTlnl3PjWtmO4m8fE9EQSxRt7q3TEJu8h8WNM1hkDZJ2AcNtk5g+
         cCRhfWkXWIkegIe8Uxd/MVsh8d963jF+x2qTf4gJWTLd7KeoB20KfdVI2y0PiVTrvQzf
         9AcA==
X-Gm-Message-State: AFqh2kpH2PK4HpCD7luClH10Q3HTlRTtX72z03bFO580uptsnmGtk6xJ
        +Dpm4B+kQoFUTlDjZSquuk44z+RonjJ1PQXY93xltnJqel+6vwz+fBTjHMLUjLtI80jYDCiV3G3
        Waa8sln4fMZY0N99DDcOBqnIi
X-Received: by 2002:a1f:4186:0:b0:3c4:799f:7627 with SMTP id o128-20020a1f4186000000b003c4799f7627mr2884540vka.13.1671048936158;
        Wed, 14 Dec 2022 12:15:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvHXCW5HX/wRdv5LJX5FR/40WcdEXrBPmQsh0rU9l/f4xd4cihIPpW2nHxYW1GZSq2zDUFZ0Q==
X-Received: by 2002:a1f:4186:0:b0:3c4:799f:7627 with SMTP id o128-20020a1f4186000000b003c4799f7627mr2884516vka.13.1671048935865;
        Wed, 14 Dec 2022 12:15:35 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id ay42-20020a05620a17aa00b006ef1a8f1b81sm10583405qkb.5.2022.12.14.12.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:15:35 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ives van Hoorne <ives@codesandbox.io>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2] mm/uffd: Always wr-protect pte in pte|pmd_mkuffd_wp()
Date:   Wed, 14 Dec 2022 15:15:33 -0500
Message-Id: <20221214201533.1774616-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a cleanup to always wr-protect pte/pmd in mkuffd_wp paths.

The reasons I still think this patch is worthwhile, are:

  (1) It is a cleanup already; diffstat tells.

  (2) It just feels natural after I thought about this, if the pte is uffd
      protected, let's remove the write bit no matter what it was.

  (2) Since x86 is the only arch that supports uffd-wp, it also redefines
      pte|pmd_mkuffd_wp() in that it should always contain removals of
      write bits.  It means any future arch that want to implement uffd-wp
      should naturally follow this rule too.  It's good to make it a
      default, even if with vm_page_prot changes on VM_UFFD_WP.

  (3) It covers more than vm_page_prot.  So no chance of any potential
      future "accident" (like pte_mkdirty() sparc64 or loongarch, even
      though it just got its pte_mkdirty fixed <1 month ago).  It'll be
      fairly clear when reading the code too that we don't worry anything
      before a pte_mkuffd_wp() on uncertainty of the write bit.

We may call pte_wrprotect() one more time in some paths (e.g. thp split),
but that should be fully local bitop instruction so the overhead should be
negligible.

Although this patch should logically also fix all the known issues on
uffd-wp too recently on page migration (not for numa hint recovery - that
may need another explcit pte_wrprotect), but this is not the plan for that
fix.  So no fixes, and stable doesn't need this.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- Fix commit message
- Added a-b
---
 arch/x86/include/asm/pgtable.h | 24 ++++++++++++------------
 include/asm-generic/hugetlb.h  | 16 ++++++++--------
 mm/huge_memory.c               |  8 +++-----
 mm/hugetlb.c                   |  4 ++--
 mm/memory.c                    |  8 +++-----
 mm/mprotect.c                  |  6 ++----
 mm/userfaultfd.c               | 18 ++----------------
 7 files changed, 32 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 0564edd24ffb..1c843395a8b3 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -289,6 +289,11 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
 	return native_make_pte(v & ~clear);
 }
 
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return pte_clear_flags(pte, _PAGE_RW);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
@@ -313,7 +318,7 @@ static inline int pte_uffd_wp(pte_t pte)
 
 static inline pte_t pte_mkuffd_wp(pte_t pte)
 {
-	return pte_set_flags(pte, _PAGE_UFFD_WP);
+	return pte_wrprotect(pte_set_flags(pte, _PAGE_UFFD_WP));
 }
 
 static inline pte_t pte_clear_uffd_wp(pte_t pte)
@@ -332,11 +337,6 @@ static inline pte_t pte_mkold(pte_t pte)
 	return pte_clear_flags(pte, _PAGE_ACCESSED);
 }
 
-static inline pte_t pte_wrprotect(pte_t pte)
-{
-	return pte_clear_flags(pte, _PAGE_RW);
-}
-
 static inline pte_t pte_mkexec(pte_t pte)
 {
 	return pte_clear_flags(pte, _PAGE_NX);
@@ -401,6 +401,11 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 	return native_make_pmd(v & ~clear);
 }
 
+static inline pmd_t pmd_wrprotect(pmd_t pmd)
+{
+	return pmd_clear_flags(pmd, _PAGE_RW);
+}
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pmd_uffd_wp(pmd_t pmd)
 {
@@ -409,7 +414,7 @@ static inline int pmd_uffd_wp(pmd_t pmd)
 
 static inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
 {
-	return pmd_set_flags(pmd, _PAGE_UFFD_WP);
+	return pmd_wrprotect(pmd_set_flags(pmd, _PAGE_UFFD_WP));
 }
 
 static inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
@@ -428,11 +433,6 @@ static inline pmd_t pmd_mkclean(pmd_t pmd)
 	return pmd_clear_flags(pmd, _PAGE_DIRTY);
 }
 
-static inline pmd_t pmd_wrprotect(pmd_t pmd)
-{
-	return pmd_clear_flags(pmd, _PAGE_RW);
-}
-
 static inline pmd_t pmd_mkdirty(pmd_t pmd)
 {
 	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index a57d667addd2..d7f6335d3999 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -25,6 +25,13 @@ static inline pte_t huge_pte_mkwrite(pte_t pte)
 	return pte_mkwrite(pte);
 }
 
+#ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
+static inline pte_t huge_pte_wrprotect(pte_t pte)
+{
+	return pte_wrprotect(pte);
+}
+#endif
+
 static inline pte_t huge_pte_mkdirty(pte_t pte)
 {
 	return pte_mkdirty(pte);
@@ -37,7 +44,7 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 
 static inline pte_t huge_pte_mkuffd_wp(pte_t pte)
 {
-	return pte_mkuffd_wp(pte);
+	return huge_pte_wrprotect(pte_mkuffd_wp(pte));
 }
 
 static inline pte_t huge_pte_clear_uffd_wp(pte_t pte)
@@ -104,13 +111,6 @@ static inline int huge_pte_none_mostly(pte_t pte)
 	return huge_pte_none(pte) || is_pte_marker(pte);
 }
 
-#ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-#endif
-
 #ifndef __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
 static inline int prepare_hugepage_range(struct file *file,
 		unsigned long addr, unsigned long len)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1d9ad909c87c..86f1ecb0f9b4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1913,17 +1913,15 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	oldpmd = pmdp_invalidate_ad(vma, addr, pmd);
 
 	entry = pmd_modify(oldpmd, newprot);
-	if (uffd_wp) {
-		entry = pmd_wrprotect(entry);
+	if (uffd_wp)
 		entry = pmd_mkuffd_wp(entry);
-	} else if (uffd_wp_resolve) {
+	else if (uffd_wp_resolve)
 		/*
 		 * Leave the write bit to be handled by PF interrupt
 		 * handler, then things like COW could be properly
 		 * handled.
 		 */
 		entry = pmd_clear_uffd_wp(entry);
-	}
 
 	/* See change_pte_range(). */
 	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pmd_write(entry) &&
@@ -3267,7 +3265,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (is_writable_migration_entry(entry))
 		pmde = maybe_pmd_mkwrite(pmde, vma);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
-		pmde = pmd_wrprotect(pmd_mkuffd_wp(pmde));
+		pmde = pmd_mkuffd_wp(pmde);
 	if (!is_migration_entry_young(entry))
 		pmde = pmd_mkold(pmde);
 	/* NOTE: this may contain setting soft-dirty on some archs */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1088f2f41c88..a10cb7038a04 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5749,7 +5749,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * if populated.
 	 */
 	if (unlikely(pte_marker_uffd_wp(old_pte)))
-		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
+		new_pte = huge_pte_mkuffd_wp(new_pte);
 	set_huge_pte_at(mm, haddr, ptep, new_pte);
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
@@ -6550,7 +6550,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			pte = huge_pte_modify(old_pte, newprot);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (uffd_wp)
-				pte = huge_pte_mkuffd_wp(huge_pte_wrprotect(pte));
+				pte = huge_pte_mkuffd_wp(pte);
 			else if (uffd_wp_resolve)
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
diff --git a/mm/memory.c b/mm/memory.c
index aad226daf41b..1e2628bf8de1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -882,7 +882,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	pte = maybe_mkwrite(pte_mkdirty(pte), dst_vma);
 	if (userfaultfd_pte_wp(dst_vma, *src_pte))
 		/* Uffd-wp needs to be delivered to dest pte as well */
-		pte = pte_wrprotect(pte_mkuffd_wp(pte));
+		pte = pte_mkuffd_wp(pte);
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
 	return 0;
 }
@@ -3950,10 +3950,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	flush_icache_page(vma, page);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
 		pte = pte_mksoft_dirty(pte);
-	if (pte_swp_uffd_wp(vmf->orig_pte)) {
+	if (pte_swp_uffd_wp(vmf->orig_pte))
 		pte = pte_mkuffd_wp(pte);
-		pte = pte_wrprotect(pte);
-	}
 	vmf->orig_pte = pte;
 
 	/* ksm created a completely new copy */
@@ -4296,7 +4294,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	if (unlikely(uffd_wp))
-		entry = pte_mkuffd_wp(pte_wrprotect(entry));
+		entry = pte_mkuffd_wp(entry);
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 093cb50f2fc4..a816ec34c234 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -177,12 +177,10 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 			oldpte = ptep_modify_prot_start(vma, addr, pte);
 			ptent = pte_modify(oldpte, newprot);
 
-			if (uffd_wp) {
-				ptent = pte_wrprotect(ptent);
+			if (uffd_wp)
 				ptent = pte_mkuffd_wp(ptent);
-			} else if (uffd_wp_resolve) {
+			else if (uffd_wp_resolve)
 				ptent = pte_clear_uffd_wp(ptent);
-			}
 
 			/*
 			 * In some writable, shared mappings, we might want
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index b7a9479bece2..7d28f9f02892 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -74,24 +74,10 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	_dst_pte = pte_mkdirty(_dst_pte);
 	if (page_in_cache && !vm_shared)
 		writable = false;
-
-	/*
-	 * Always mark a PTE as write-protected when needed, regardless of
-	 * VM_WRITE, which the user might change.
-	 */
-	if (wp_copy) {
-		_dst_pte = pte_mkuffd_wp(_dst_pte);
-		writable = false;
-	}
-
 	if (writable)
 		_dst_pte = pte_mkwrite(_dst_pte);
-	else
-		/*
-		 * We need this to make sure write bit removed; as mk_pte()
-		 * could return a pte with write bit set.
-		 */
-		_dst_pte = pte_wrprotect(_dst_pte);
+	if (wp_copy)
+		_dst_pte = pte_mkuffd_wp(_dst_pte);
 
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
 
-- 
2.37.3

