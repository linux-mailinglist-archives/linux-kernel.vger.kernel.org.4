Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E6D73A360
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjFVOnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjFVOnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:43:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFAFC2690
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:42:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E9EB14BF;
        Thu, 22 Jun 2023 07:43:37 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4A133F663;
        Thu, 22 Jun 2023 07:42:50 -0700 (PDT)
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
Subject: [PATCH v1 09/14] arm64/mm: ptep_get(): New layer to manage contig bit
Date:   Thu, 22 Jun 2023 15:42:04 +0100
Message-Id: <20230622144210.2623299-10-ryan.roberts@arm.com>
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

Create a new layer for the in-table PTE manipulation APIs. For now, The
existing API is prefixed with double underscore to become the
arch-private API and the public API is just a simple wrapper that calls
the private API.

The public API implementation will subsequently be used to transparently
manipulate the contiguous bit where appropriate. But since there are
already some contig-aware users (e.g. hugetlb, kernel mapper), we must
first ensure those users use the private API directly so that the future
contig-bit manipulations in the public API do not interfere with those
existing uses.

arm64 did not previously define an arch-specific ptep_get(), so override
the default version in the arch code, and also define the private
__ptep_get() version. Currently they both do the same thing that the
default version does (READ_ONCE()). Some arch users (hugetlb) were
already using ptep_get() so convert those to the private API. While
other callsites were doing direct READ_ONCE(), so convert those to use
the appropriate (public/private) API too.

There are some core kernel locations that directly dereference the ptep,
so these will need to be updated separately.

No behavioural changes intended.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 19 +++++++++++++++----
 arch/arm64/kernel/efi.c          |  2 +-
 arch/arm64/mm/fault.c            |  4 ++--
 arch/arm64/mm/hugetlbpage.c      | 18 +++++++++---------
 arch/arm64/mm/kasan_init.c       |  2 +-
 arch/arm64/mm/mmu.c              | 12 ++++++------
 arch/arm64/mm/pageattr.c         |  4 ++--
 arch/arm64/mm/trans_pgd.c        |  2 +-
 8 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index ff79578fd806..31df4d73f9ac 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -275,6 +275,11 @@ static inline void __set_pte(pte_t *ptep, pte_t pte)
 	}
 }
 
+static inline pte_t __ptep_get(pte_t *ptep)
+{
+	return READ_ONCE(*ptep);
+}
+
 extern void __sync_icache_dcache(pte_t pteval);
 bool pgattr_change_is_safe(u64 old, u64 new);
 
@@ -302,7 +307,7 @@ static inline void __check_safe_pte_update(struct mm_struct *mm, pte_t *ptep,
 	if (!IS_ENABLED(CONFIG_DEBUG_VM))
 		return;
 
-	old_pte = READ_ONCE(*ptep);
+	old_pte = __ptep_get(ptep);
 
 	if (!pte_valid(old_pte) || !pte_valid(pte))
 		return;
@@ -339,7 +344,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 */
 	if (system_supports_mte() && pte_access_permitted(pte, false) &&
 	    !pte_special(pte)) {
-		pte_t old_pte = READ_ONCE(*ptep);
+		pte_t old_pte = __ptep_get(ptep);
 		/*
 		 * We only need to synchronise if the new PTE has tags enabled
 		 * or if swapping in (in which case another mapping may have
@@ -893,7 +898,7 @@ static inline int __ptep_test_and_clear_young(struct vm_area_struct *vma,
 {
 	pte_t old_pte, pte;
 
-	pte = READ_ONCE(*ptep);
+	pte = __ptep_get(ptep);
 	do {
 		old_pte = pte;
 		pte = pte_mkold(pte);
@@ -966,7 +971,7 @@ static inline void __ptep_set_wrprotect(struct mm_struct *mm,
 {
 	pte_t old_pte, pte;
 
-	pte = READ_ONCE(*ptep);
+	pte = __ptep_get(ptep);
 	do {
 		old_pte = pte;
 		pte = pte_wrprotect(pte);
@@ -1120,6 +1125,12 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
  * private versions, which are prefixed with double underscore.
  */
 
+#define ptep_get ptep_get
+static inline pte_t ptep_get(pte_t *ptep)
+{
+	return __ptep_get(ptep);
+}
+
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	__set_pte(ptep, pte);
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 7a28b6a08a82..9536fbce77a2 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -106,7 +106,7 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct set_perm_data *spd = data;
 	const efi_memory_desc_t *md = spd->md;
-	pte_t pte = READ_ONCE(*ptep);
+	pte_t pte = __ptep_get(ptep);
 
 	if (md->attribute & EFI_MEMORY_RO)
 		pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f5a7a5ff6814..3193526b226d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -177,7 +177,7 @@ static void show_pte(unsigned long addr)
 			break;
 
 		ptep = pte_offset_map(pmdp, addr);
-		pte = READ_ONCE(*ptep);
+		pte = __ptep_get(ptep);
 		pr_cont(", pte=%016llx", pte_val(pte));
 		pte_unmap(ptep);
 	} while(0);
@@ -200,7 +200,7 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
 			    pte_t entry, int dirty)
 {
 	pteval_t old_pteval, pteval;
-	pte_t pte = READ_ONCE(*ptep);
+	pte_t pte = __ptep_get(ptep);
 
 	if (pte_same(pte, entry))
 		return 0;
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 9a87b1c5661a..82b2036dbe2f 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -152,14 +152,14 @@ pte_t huge_ptep_get(pte_t *ptep)
 {
 	int ncontig, i;
 	size_t pgsize;
-	pte_t orig_pte = ptep_get(ptep);
+	pte_t orig_pte = __ptep_get(ptep);
 
 	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
 		return orig_pte;
 
 	ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);
 	for (i = 0; i < ncontig; i++, ptep++) {
-		pte_t pte = ptep_get(ptep);
+		pte_t pte = __ptep_get(ptep);
 
 		if (pte_dirty(pte))
 			orig_pte = pte_mkdirty(orig_pte);
@@ -184,7 +184,7 @@ static pte_t get_clear_contig(struct mm_struct *mm,
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	pte_t orig_pte = ptep_get(ptep);
+	pte_t orig_pte = __ptep_get(ptep);
 	unsigned long i;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
@@ -426,7 +426,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 {
 	int ncontig;
 	size_t pgsize;
-	pte_t orig_pte = ptep_get(ptep);
+	pte_t orig_pte = __ptep_get(ptep);
 
 	if (!pte_cont(orig_pte))
 		return __ptep_get_and_clear(mm, addr, ptep);
@@ -449,11 +449,11 @@ static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
 {
 	int i;
 
-	if (pte_write(pte) != pte_write(ptep_get(ptep)))
+	if (pte_write(pte) != pte_write(__ptep_get(ptep)))
 		return 1;
 
 	for (i = 0; i < ncontig; i++) {
-		pte_t orig_pte = ptep_get(ptep + i);
+		pte_t orig_pte = __ptep_get(ptep + i);
 
 		if (pte_dirty(pte) != pte_dirty(orig_pte))
 			return 1;
@@ -510,7 +510,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	size_t pgsize;
 	pte_t pte;
 
-	if (!pte_cont(READ_ONCE(*ptep))) {
+	if (!pte_cont(__ptep_get(ptep))) {
 		__ptep_set_wrprotect(mm, addr, ptep);
 		return;
 	}
@@ -535,7 +535,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	size_t pgsize;
 	int ncontig;
 
-	if (!pte_cont(READ_ONCE(*ptep)))
+	if (!pte_cont(__ptep_get(ptep)))
 		return ptep_clear_flush(vma, addr, ptep);
 
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
@@ -569,7 +569,7 @@ pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr
 		 * when the permission changes from executable to non-executable
 		 * in cases where cpu is affected with errata #2645198.
 		 */
-		if (pte_user_exec(READ_ONCE(*ptep)))
+		if (pte_user_exec(__ptep_get(ptep)))
 			return huge_ptep_clear_flush(vma, addr, ptep);
 	}
 	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 40125b217195..65074cf7f3a3 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -113,7 +113,7 @@ static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
 			memset(__va(page_phys), KASAN_SHADOW_INIT, PAGE_SIZE);
 		next = addr + PAGE_SIZE;
 		__set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
-	} while (ptep++, addr = next, addr != end && pte_none(READ_ONCE(*ptep)));
+	} while (ptep++, addr = next, addr != end && pte_none(__ptep_get(ptep)));
 }
 
 static void __init kasan_pmd_populate(pud_t *pudp, unsigned long addr,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 085a7e3eec98..d5dc36ff3827 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -176,7 +176,7 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 	ptep = pte_set_fixmap_offset(pmdp, addr);
 	do {
-		pte_t old_pte = READ_ONCE(*ptep);
+		pte_t old_pte = __ptep_get(ptep);
 
 		__set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
 
@@ -185,7 +185,7 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		 * only allow updates to the permission attributes.
 		 */
 		BUG_ON(!pgattr_change_is_safe(pte_val(old_pte),
-					      READ_ONCE(pte_val(*ptep))));
+					      pte_val(__ptep_get(ptep))));
 
 		phys += PAGE_SIZE;
 	} while (ptep++, addr += PAGE_SIZE, addr != end);
@@ -848,7 +848,7 @@ static void unmap_hotplug_pte_range(pmd_t *pmdp, unsigned long addr,
 
 	do {
 		ptep = pte_offset_kernel(pmdp, addr);
-		pte = READ_ONCE(*ptep);
+		pte = __ptep_get(ptep);
 		if (pte_none(pte))
 			continue;
 
@@ -981,7 +981,7 @@ static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
 
 	do {
 		ptep = pte_offset_kernel(pmdp, addr);
-		pte = READ_ONCE(*ptep);
+		pte = __ptep_get(ptep);
 
 		/*
 		 * This is just a sanity check here which verifies that
@@ -1000,7 +1000,7 @@ static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
 	 */
 	ptep = pte_offset_kernel(pmdp, 0UL);
 	for (i = 0; i < PTRS_PER_PTE; i++) {
-		if (!pte_none(READ_ONCE(ptep[i])))
+		if (!pte_none(__ptep_get(ptep++)))
 			return;
 	}
 
@@ -1470,7 +1470,7 @@ pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte
 		 * when the permission changes from executable to non-executable
 		 * in cases where cpu is affected with errata #2645198.
 		 */
-		if (pte_user_exec(READ_ONCE(*ptep)))
+		if (pte_user_exec(ptep_get(ptep)))
 			return ptep_clear_flush(vma, addr, ptep);
 	}
 	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 057097acf9e0..624b0b0982e3 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -36,7 +36,7 @@ bool can_set_direct_map(void)
 static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct page_change_data *cdata = data;
-	pte_t pte = READ_ONCE(*ptep);
+	pte_t pte = __ptep_get(ptep);
 
 	pte = clear_pte_bit(pte, cdata->clear_mask);
 	pte = set_pte_bit(pte, cdata->set_mask);
@@ -246,5 +246,5 @@ bool kernel_page_present(struct page *page)
 		return true;
 
 	ptep = pte_offset_kernel(pmdp, addr);
-	return pte_valid(READ_ONCE(*ptep));
+	return pte_valid(__ptep_get(ptep));
 }
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index f9997b226614..b130a65092c1 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -32,7 +32,7 @@ static void *trans_alloc(struct trans_pgd_info *info)
 
 static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 {
-	pte_t pte = READ_ONCE(*src_ptep);
+	pte_t pte = __ptep_get(src_ptep);
 
 	if (pte_valid(pte)) {
 		/*
-- 
2.25.1

