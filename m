Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77E73A362
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjFVOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjFVOn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:43:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 465A22705
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:43:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22AEF1515;
        Thu, 22 Jun 2023 07:43:43 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 925DC3F663;
        Thu, 22 Jun 2023 07:42:56 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 11/14] arm64/mm: Wire up PTE_CONT for user mappings
Date:   Thu, 22 Jun 2023 15:42:06 +0100
Message-Id: <20230622144210.2623299-12-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622144210.2623299-1-ryan.roberts@arm.com>
References: <20230622144210.2623299-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the ptep API sufficiently refactored, we can now introduce a new
"contpte" API layer, which transparently manages the PTE_CONT bit for
user mappings. Whenever it detects a set of PTEs that meet the
requirements for a contiguous range, the PTEs are re-painted with the
PTE_CONT bit.

This initial change provides a baseline that can be optimized in future
commits. That said, fold/unfold operations (which imply tlb
invalidation) are avoided where possible with a few tricks for
access/dirty bit management.

Write-enable and write-protect modifications are likely non-optimal and
likely incure a regression in fork() performance. This will be addressed
separately.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 137 ++++++++++++-
 arch/arm64/mm/Makefile           |   3 +-
 arch/arm64/mm/contpte.c          | 334 +++++++++++++++++++++++++++++++
 3 files changed, 466 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/mm/contpte.c

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 31df4d73f9ac..17ea534bc5b0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1115,6 +1115,71 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
 				    unsigned long addr, pte_t *ptep,
 				    pte_t old_pte, pte_t new_pte);
 
+/*
+ * The contpte APIs are used to transparently manage the contiguous bit in ptes
+ * where it is possible and makes sense to do so. The PTE_CONT bit is considered
+ * a private implementation detail of the public ptep API (see below).
+ */
+extern void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte);
+extern void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte);
+extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
+extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
+extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte, unsigned int nr);
+extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
+				unsigned long addr, pte_t *ptep);
+extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
+				unsigned long addr, pte_t *ptep);
+extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
+				unsigned long addr, pte_t *ptep,
+				pte_t entry, int dirty);
+
+static inline pte_t *contpte_align_down(pte_t *ptep)
+{
+	return (pte_t *)(ALIGN_DOWN((unsigned long)ptep >> 3, CONT_PTES) << 3);
+}
+
+static inline bool contpte_is_enabled(struct mm_struct *mm)
+{
+	/*
+	 * Don't attempt to apply the contig bit to kernel mappings, because
+	 * dynamically adding/removing the contig bit can cause page faults.
+	 * These racing faults are ok for user space, since they get serialized
+	 * on the PTL. But kernel mappings can't tolerate faults.
+	 */
+
+	return mm != &init_mm;
+}
+
+static inline void contpte_try_fold(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, pte_t pte)
+{
+	/*
+	 * Only bother trying if both the virtual and physical addresses are
+	 * aligned and correspond to the last entry in a contig range. The core
+	 * code mostly modifies ranges from low to high, so this is the likely
+	 * the last modification in the contig range, so a good time to fold.
+	 */
+
+	bool valign = ((unsigned long)ptep >> 3) % CONT_PTES == CONT_PTES - 1;
+	bool palign = pte_pfn(pte) % CONT_PTES == CONT_PTES - 1;
+
+	if (contpte_is_enabled(mm) &&
+	    pte_present(pte) && !pte_cont(pte) &&
+	    valign && palign)
+		__contpte_try_fold(mm, addr, ptep, pte);
+}
+
+static inline void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, pte_t pte)
+{
+	if (contpte_is_enabled(mm) &&
+	    pte_present(pte) && pte_cont(pte))
+		__contpte_try_unfold(mm, addr, ptep, pte);
+}
+
 /*
  * The below functions constitute the public API that arm64 presents to the
  * core-mm to manipulate PTE entries within the their page tables (or at least
@@ -1122,30 +1187,68 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
  * versions will automatically and transparently apply the contiguous bit where
  * it makes sense to do so. Therefore any users that are contig-aware (e.g.
  * hugetlb, kernel mapper) should NOT use these APIs, but instead use the
- * private versions, which are prefixed with double underscore.
+ * private versions, which are prefixed with double underscore. All of these
+ * APIs except for ptep_get_lockless() are expected to be called with the PTL
+ * held.
  */
 
 #define ptep_get ptep_get
 static inline pte_t ptep_get(pte_t *ptep)
 {
-	return __ptep_get(ptep);
+	pte_t pte = __ptep_get(ptep);
+
+	if (!pte_present(pte) || !pte_cont(pte))
+		return pte;
+
+	return contpte_ptep_get(ptep, pte);
+}
+
+#define ptep_get_lockless ptep_get_lockless
+static inline pte_t ptep_get_lockless(pte_t *ptep)
+{
+	pte_t pte = __ptep_get(ptep);
+
+	if (!pte_present(pte) || !pte_cont(pte))
+		return pte;
+
+	return contpte_ptep_get_lockless(ptep);
 }
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
-	__set_pte(ptep, pte);
+	/*
+	 * We don't have the mm or vaddr so cannot unfold or fold contig entries
+	 * (since it requires tlb maintenance). set_pte() is not used in core
+	 * code, so this should never even be called. Regardless do our best to
+	 * service any call and emit a warning if there is any attempt to set a
+	 * pte on top of an existing contig range.
+	 */
+	pte_t orig_pte = __ptep_get(ptep);
+
+	WARN_ON_ONCE(pte_present(orig_pte) && pte_cont(orig_pte));
+	__set_pte(ptep, pte_mknoncont(pte));
 }
 
 #define set_ptes set_ptes
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	__set_ptes(mm, addr, ptep, pte, nr);
+	pte = pte_mknoncont(pte);
+
+	if (!contpte_is_enabled(mm))
+		__set_ptes(mm, addr, ptep, pte, nr);
+	else if (nr == 1) {
+		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+		__set_ptes(mm, addr, ptep, pte, nr);
+		contpte_try_fold(mm, addr, ptep, pte);
+	} else
+		contpte_set_ptes(mm, addr, ptep, pte, nr);
 }
 
 static inline void pte_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
 {
+	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
 	__pte_clear(mm, addr, ptep);
 }
 
@@ -1153,6 +1256,7 @@ static inline void pte_clear(struct mm_struct *mm,
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
 {
+	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
 	return __ptep_get_and_clear(mm, addr, ptep);
 }
 
@@ -1160,21 +1264,33 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep)
 {
-	return __ptep_test_and_clear_young(vma, addr, ptep);
+	pte_t orig_pte = __ptep_get(ptep);
+
+	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
+		return __ptep_test_and_clear_young(vma, addr, ptep);
+
+	return contpte_ptep_test_and_clear_young(vma, addr, ptep);
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep)
 {
-	return __ptep_clear_flush_young(vma, addr, ptep);
+	pte_t orig_pte = __ptep_get(ptep);
+
+	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
+		return __ptep_clear_flush_young(vma, addr, ptep);
+
+	return contpte_ptep_clear_flush_young(vma, addr, ptep);
 }
 
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
 {
+	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
 	__ptep_set_wrprotect(mm, addr, ptep);
+	contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
 }
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
@@ -1182,7 +1298,14 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				pte_t entry, int dirty)
 {
-	return __ptep_set_access_flags(vma, addr, ptep, entry, dirty);
+	pte_t orig_pte = __ptep_get(ptep);
+
+	entry = pte_mknoncont(entry);
+
+	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
+		return __ptep_set_access_flags(vma, addr, ptep, entry, dirty);
+
+	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
 }
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index dbd1bc95967d..70b6aba09b5d 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -2,7 +2,8 @@
 obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   cache.o copypage.o flush.o \
 				   ioremap.o mmap.o pgd.o mmu.o \
-				   context.o proc.o pageattr.o fixmap.o
+				   context.o proc.o pageattr.o fixmap.o \
+				   contpte.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE)	+= ptdump.o
 obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
new file mode 100644
index 000000000000..e8e4a298fd53
--- /dev/null
+++ b/arch/arm64/mm/contpte.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 ARM Ltd.
+ */
+
+#include <linux/mm.h>
+#include <asm/tlbflush.h>
+
+static void ptep_clear_flush_range(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, int nr)
+{
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	unsigned long start_addr = addr;
+	int i;
+
+	for (i = 0; i < nr; i++, ptep++, addr += PAGE_SIZE)
+		__pte_clear(mm, addr, ptep);
+
+	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
+}
+
+static bool ptep_any_present(pte_t *ptep, int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++, ptep++) {
+		if (pte_present(__ptep_get(ptep)))
+			return true;
+	}
+
+	return false;
+}
+
+static void contpte_fold(struct mm_struct *mm, unsigned long addr,
+			pte_t *ptep, pte_t pte, bool fold)
+{
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	unsigned long start_addr;
+	pte_t *start_ptep;
+	int i;
+
+	start_ptep = ptep = contpte_align_down(ptep);
+	start_addr = addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
+	pte = pfn_pte(ALIGN_DOWN(pte_pfn(pte), CONT_PTES), pte_pgprot(pte));
+	pte = fold ? pte_mkcont(pte) : pte_mknoncont(pte);
+
+	for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE) {
+		pte_t ptent = __ptep_get_and_clear(mm, addr, ptep);
+
+		if (pte_dirty(ptent))
+			pte = pte_mkdirty(pte);
+
+		if (pte_young(ptent))
+			pte = pte_mkyoung(pte);
+	}
+
+	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
+
+	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
+}
+
+void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
+			pte_t *ptep, pte_t pte)
+{
+	/*
+	 * We have already checked that the virtual and pysical addresses are
+	 * correctly aligned for a contig mapping in contpte_try_fold() so the
+	 * remaining checks are to ensure that the contig range is fully covered
+	 * by a single folio, and ensure that all the ptes are present with
+	 * contiguous PFNs and matching prots.
+	 */
+
+	struct page *page = pte_page(pte);
+	struct folio *folio = page_folio(page);
+	unsigned long folio_saddr = addr - (page - &folio->page) * PAGE_SIZE;
+	unsigned long folio_eaddr = folio_saddr + folio_nr_pages(folio) * PAGE_SIZE;
+	unsigned long cont_saddr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
+	unsigned long cont_eaddr = cont_saddr + CONT_PTE_SIZE;
+	unsigned long pfn;
+	pgprot_t prot;
+	pte_t subpte;
+	pte_t *orig_ptep;
+	int i;
+
+	if (folio_saddr > cont_saddr || folio_eaddr < cont_eaddr)
+		return;
+
+	pfn = pte_pfn(pte) - ((addr - cont_saddr) >> PAGE_SHIFT);
+	prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
+	orig_ptep = ptep;
+	ptep = contpte_align_down(ptep);
+
+	for (i = 0; i < CONT_PTES; i++, ptep++, pfn++) {
+		subpte = __ptep_get(ptep);
+		subpte = pte_mkold(pte_mkclean(subpte));
+
+		if (!pte_present(subpte) ||
+		    pte_pfn(subpte) != pfn ||
+		    pgprot_val(pte_pgprot(subpte)) != pgprot_val(prot))
+			return;
+	}
+
+	contpte_fold(mm, addr, orig_ptep, pte, true);
+}
+
+void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
+			pte_t *ptep, pte_t pte)
+{
+	/*
+	 * We have already checked that the ptes are contiguous in
+	 * contpte_try_unfold(), so we can unfold unconditionally here.
+	 */
+
+	contpte_fold(mm, addr, ptep, pte, false);
+}
+
+pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
+{
+	/*
+	 * Gather access/dirty bits, which may be populated in any of the ptes
+	 * of the contig range. We are guarranteed to be holding the PTL, so any
+	 * contiguous range cannot be unfolded or otherwise modified under our
+	 * feet.
+	 */
+
+	pte_t pte;
+	int i;
+
+	ptep = contpte_align_down(ptep);
+
+	for (i = 0; i < CONT_PTES; i++, ptep++) {
+		pte = __ptep_get(ptep);
+
+		/*
+		 * Deal with the partial contpte_ptep_get_and_clear_full() case,
+		 * where some of the ptes in the range may be cleared but others
+		 * are still to do. See contpte_ptep_get_and_clear_full().
+		 */
+		if (pte_val(pte) == 0)
+			continue;
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+
+	return orig_pte;
+}
+
+pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
+{
+	/*
+	 * Gather access/dirty bits, which may be populated in any of the ptes
+	 * of the contig range. We may not be holding the PTL, so any contiguous
+	 * range may be unfolded/modified/refolded under our feet.
+	 */
+
+	pte_t orig_pte;
+	pgprot_t orig_prot;
+	pte_t *ptep;
+	unsigned long pfn;
+	pte_t pte;
+	pgprot_t prot;
+	int i;
+
+retry:
+	orig_pte = __ptep_get(orig_ptep);
+
+	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
+		return orig_pte;
+
+	orig_prot = pte_pgprot(pte_mkold(pte_mkclean(orig_pte)));
+	ptep = contpte_align_down(orig_ptep);
+	pfn = pte_pfn(orig_pte) - (orig_ptep - ptep);
+
+	for (i = 0; i < CONT_PTES; i++, ptep++, pfn++) {
+		pte = __ptep_get(ptep);
+		prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
+
+		if (!pte_present(pte) || !pte_cont(pte) ||
+		   pte_pfn(pte) != pfn ||
+		   pgprot_val(prot) != pgprot_val(orig_prot))
+			goto retry;
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+
+	return orig_pte;
+}
+
+void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	unsigned long next;
+	unsigned long end = addr + (nr << PAGE_SHIFT);
+	unsigned long pfn = pte_pfn(pte);
+	pgprot_t prot = pte_pgprot(pte);
+	pte_t orig_pte;
+
+	do {
+		next = pte_cont_addr_end(addr, end);
+		nr = (next - addr) >> PAGE_SHIFT;
+		pte = pfn_pte(pfn, prot);
+
+		if (((addr | next | (pfn << PAGE_SHIFT)) & ~CONT_PTE_MASK) == 0)
+			pte = pte_mkcont(pte);
+		else
+			pte = pte_mknoncont(pte);
+
+		/*
+		 * If operating on a partial contiguous range then we must first
+		 * unfold the contiguous range if it was previously folded.
+		 * Otherwise we could end up with overlapping tlb entries.
+		 */
+		if (nr != CONT_PTES)
+			contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+
+		/*
+		 * If we are replacing ptes that were contiguous or if the new
+		 * ptes are contiguous and any of the ptes being replaced are
+		 * present, we need to clear and flush the range to prevent
+		 * overlapping tlb entries.
+		 */
+		orig_pte = __ptep_get(ptep);
+		if ((pte_present(orig_pte) && pte_cont(orig_pte)) ||
+		    (pte_cont(pte) && ptep_any_present(ptep, nr)))
+			ptep_clear_flush_range(mm, addr, ptep, nr);
+
+		__set_ptes(mm, addr, ptep, pte, nr);
+
+		addr = next;
+		ptep += nr;
+		pfn += nr;
+
+	} while (addr != end);
+}
+
+int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
+					unsigned long addr, pte_t *ptep)
+{
+	/*
+	 * ptep_clear_flush_young() technically requires us to clear the access
+	 * flag for a _single_ pte. However, the core-mm code actually tracks
+	 * access/dirty per folio, not per page. And since we only create a
+	 * contig range when the range is covered by a single folio, we can get
+	 * away with clearing young for the whole contig range here, so we avoid
+	 * having to unfold.
+	 */
+
+	int i;
+	int young = 0;
+
+	ptep = contpte_align_down(ptep);
+	addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
+
+	for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
+		young |= __ptep_test_and_clear_young(vma, addr, ptep);
+
+	return young;
+}
+
+int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
+					unsigned long addr, pte_t *ptep)
+{
+	int young;
+
+	young = contpte_ptep_test_and_clear_young(vma, addr, ptep);
+	addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
+
+	if (young) {
+		/*
+		 * See comment in __ptep_clear_flush_young(); same rationale for
+		 * eliding the trailing DSB applies here.
+		 */
+		__flush_tlb_range_nosync(vma, addr, addr + CONT_PTE_SIZE,
+					 PAGE_SIZE, true, 3);
+	}
+
+	return young;
+}
+
+int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
+					unsigned long addr, pte_t *ptep,
+					pte_t entry, int dirty)
+{
+	pte_t orig_pte;
+	int i;
+
+	/*
+	 * Gather the access/dirty bits for the contiguous range. If nothing has
+	 * changed, its a noop.
+	 */
+	orig_pte = ptep_get(ptep);
+	if (pte_val(orig_pte) == pte_val(entry))
+		return 0;
+
+	/*
+	 * We can fix up access/dirty bits without having to unfold/fold the
+	 * contig range. But if the write bit is changing, we need to go through
+	 * the full unfold/fold cycle.
+	 */
+	if (pte_write(orig_pte) == pte_write(entry)) {
+		/*
+		 * No need to flush here; This is always "more permissive" so we
+		 * can only be _adding_ the access or dirty bit. And since the
+		 * tlb can't cache an entry without the AF set and the dirty bit
+		 * is a SW bit, there can be no confusion. For HW access
+		 * management, we technically only need to update the flag on a
+		 * single pte in the range. But for SW access management, we
+		 * need to update all the ptes to prevent extra faults.
+		 */
+		ptep = contpte_align_down(ptep);
+		addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
+
+		for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
+			__ptep_set_access_flags(vma, addr, ptep, entry, 0);
+	} else {
+		/*
+		 * No need to flush in __ptep_set_access_flags() because we just
+		 * flushed the whole range in __contpte_try_unfold().
+		 */
+		__contpte_try_unfold(vma->vm_mm, addr, ptep, orig_pte);
+		__ptep_set_access_flags(vma, addr, ptep, entry, 0);
+		contpte_try_fold(vma->vm_mm, addr, ptep, entry);
+	}
+
+	return 1;
+}
-- 
2.25.1

