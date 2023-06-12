Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A54172C995
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbjFLPQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbjFLPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:16:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45361E51
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:16:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E62A152B;
        Mon, 12 Jun 2023 08:17:02 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB7253F5A1;
        Mon, 12 Jun 2023 08:16:11 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 3/3] mm: ptep_get() conversion
Date:   Mon, 12 Jun 2023 16:15:45 +0100
Message-Id: <20230612151545.3317766-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230612151545.3317766-1-ryan.roberts@arm.com>
References: <20230612151545.3317766-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all instances of direct pte_t* dereferencing to instead use
ptep_get() helper. This means that by default, the accesses change from
a C dereference to a READ_ONCE(). This is technically the correct thing
to do since where pgtables are modified by HW (for access/dirty) they
are volatile and therefore we should always ensure READ_ONCE()
semantics.

But more importantly, by always using the helper, it can be overridden
by the architecture to fully encapsulate the contents of the pte. Arch
code is deliberately not converted, as the arch code knows best. It is
intended that arch code (arm64) will override the default with its own
implementation that can (e.g.) hide certain bits from the core code, or
determine young/dirty status by mixing in state from another source.

Conversion was done using Coccinelle:

----

// $ make coccicheck \
//          COCCI=ptepget.cocci \
//          SPFLAGS="--include-headers" \
//          MODE=patch

virtual patch

@ depends on patch @
pte_t *v;
@@

- *v
+ ptep_get(v)

----

Then reviewed and hand-edited to avoid multiple unnecessary calls to
ptep_get(), instead opting to store the result of a single call in a
variable, where it is correct to do so. This aims to negate any cost of
READ_ONCE() and will benefit arch-overrides that may be more complex.

Included is a fix for an issue in an earlier version of this patch that
was pointed out by kernel test robot. The issue arose because config
MMU=n elides definition of the ptep helper functions, including
ptep_get(). HUGETLB_PAGE=n configs still define a simple
huge_ptep_clear_flush() for linking purposes, which dereferences the
ptep. So when both configs are disabled, this caused a build error
because ptep_get() is not defined. Fix by continuing to do a direct
dereference when MMU=n. This is safe because for this config the arch
code cannot be trying to virtualize the ptes because none of the ptep
helpers are defined.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305120142.yXsNEo6H-lkp@intel.com/
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 .../drm/i915/gem/selftests/i915_gem_mman.c    |   8 +-
 drivers/misc/sgi-gru/grufault.c               |   2 +-
 drivers/vfio/vfio_iommu_type1.c               |   7 +-
 drivers/xen/privcmd.c                         |   2 +-
 fs/proc/task_mmu.c                            |  33 +++---
 fs/userfaultfd.c                              |   6 +-
 include/linux/hugetlb.h                       |   4 +
 include/linux/mm_inline.h                     |   2 +-
 include/linux/pgtable.h                       |   6 +-
 kernel/events/uprobes.c                       |   2 +-
 mm/damon/ops-common.c                         |   2 +-
 mm/damon/paddr.c                              |   2 +-
 mm/damon/vaddr.c                              |  10 +-
 mm/filemap.c                                  |   2 +-
 mm/gup.c                                      |  21 ++--
 mm/highmem.c                                  |  12 ++-
 mm/hmm.c                                      |   2 +-
 mm/huge_memory.c                              |   4 +-
 mm/hugetlb.c                                  |   2 +-
 mm/hugetlb_vmemmap.c                          |   6 +-
 mm/kasan/init.c                               |   9 +-
 mm/kasan/shadow.c                             |  10 +-
 mm/khugepaged.c                               |  22 ++--
 mm/ksm.c                                      |  22 ++--
 mm/madvise.c                                  |   6 +-
 mm/mapping_dirty_helpers.c                    |   4 +-
 mm/memcontrol.c                               |   4 +-
 mm/memory-failure.c                           |  26 ++---
 mm/memory.c                                   | 100 ++++++++++--------
 mm/mempolicy.c                                |   6 +-
 mm/migrate.c                                  |  14 +--
 mm/migrate_device.c                           |  15 +--
 mm/mincore.c                                  |   2 +-
 mm/mlock.c                                    |   6 +-
 mm/mprotect.c                                 |   8 +-
 mm/mremap.c                                   |   2 +-
 mm/page_table_check.c                         |   4 +-
 mm/page_vma_mapped.c                          |  27 +++--
 mm/pgtable-generic.c                          |   2 +-
 mm/rmap.c                                     |  34 +++---
 mm/sparse-vmemmap.c                           |   8 +-
 mm/swap_state.c                               |   8 +-
 mm/swapfile.c                                 |  20 ++--
 mm/userfaultfd.c                              |   4 +-
 mm/vmalloc.c                                  |   6 +-
 mm/vmscan.c                                   |  14 +--
 virt/kvm/kvm_main.c                           |  11 +-
 47 files changed, 301 insertions(+), 228 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index 56279908ed30..01e271b6ad21 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -1681,7 +1681,9 @@ static int igt_mmap_gpu(void *arg)
 
 static int check_present_pte(pte_t *pte, unsigned long addr, void *data)
 {
-	if (!pte_present(*pte) || pte_none(*pte)) {
+	pte_t ptent = ptep_get(pte);
+
+	if (!pte_present(ptent) || pte_none(ptent)) {
 		pr_err("missing PTE:%lx\n",
 		       (addr - (unsigned long)data) >> PAGE_SHIFT);
 		return -EINVAL;
@@ -1692,7 +1694,9 @@ static int check_present_pte(pte_t *pte, unsigned long addr, void *data)
 
 static int check_absent_pte(pte_t *pte, unsigned long addr, void *data)
 {
-	if (pte_present(*pte) && !pte_none(*pte)) {
+	pte_t ptent = ptep_get(pte);
+
+	if (pte_present(ptent) && !pte_none(ptent)) {
 		pr_err("present PTE:%lx; expected to be revoked\n",
 		       (addr - (unsigned long)data) >> PAGE_SHIFT);
 		return -EINVAL;
diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 378cf02a2aa1..629edb6486de 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -228,7 +228,7 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
 		goto err;
 #ifdef CONFIG_X86_64
 	if (unlikely(pmd_large(*pmdp)))
-		pte = *(pte_t *) pmdp;
+		pte = ptep_get((pte_t *)pmdp);
 	else
 #endif
 		pte = *pte_offset_kernel(pmdp, vaddr);
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 306e6f1d1c70..ebe0ad31d0b0 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -514,6 +514,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 			    bool write_fault)
 {
 	pte_t *ptep;
+	pte_t pte;
 	spinlock_t *ptl;
 	int ret;
 
@@ -536,10 +537,12 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 			return ret;
 	}
 
-	if (write_fault && !pte_write(*ptep))
+	pte = ptep_get(ptep);
+
+	if (write_fault && !pte_write(pte))
 		ret = -EFAULT;
 	else
-		*pfn = pte_pfn(*ptep);
+		*pfn = pte_pfn(pte);
 
 	pte_unmap_unlock(ptep, ptl);
 	return ret;
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index e2f580e30a86..f447cd37cc4c 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -949,7 +949,7 @@ static int privcmd_mmap(struct file *file, struct vm_area_struct *vma)
  */
 static int is_mapped_fn(pte_t *pte, unsigned long addr, void *data)
 {
-	return pte_none(*pte) ? 0 : -EBUSY;
+	return pte_none(ptep_get(pte)) ? 0 : -EBUSY;
 }
 
 static int privcmd_vma_range_is_mapped(
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 0d63b6a0f0d8..507cd4e59d07 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -538,13 +538,14 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
 	bool migration = false, young = false, dirty = false;
+	pte_t ptent = ptep_get(pte);
 
-	if (pte_present(*pte)) {
-		page = vm_normal_page(vma, addr, *pte);
-		young = pte_young(*pte);
-		dirty = pte_dirty(*pte);
-	} else if (is_swap_pte(*pte)) {
-		swp_entry_t swpent = pte_to_swp_entry(*pte);
+	if (pte_present(ptent)) {
+		page = vm_normal_page(vma, addr, ptent);
+		young = pte_young(ptent);
+		dirty = pte_dirty(ptent);
+	} else if (is_swap_pte(ptent)) {
+		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (!non_swap_entry(swpent)) {
 			int mapcount;
@@ -732,11 +733,12 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
 	struct page *page = NULL;
+	pte_t ptent = ptep_get(pte);
 
-	if (pte_present(*pte)) {
-		page = vm_normal_page(vma, addr, *pte);
-	} else if (is_swap_pte(*pte)) {
-		swp_entry_t swpent = pte_to_swp_entry(*pte);
+	if (pte_present(ptent)) {
+		page = vm_normal_page(vma, addr, ptent);
+	} else if (is_swap_pte(ptent)) {
+		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (is_pfn_swap_entry(swpent))
 			page = pfn_swap_entry_to_page(swpent);
@@ -1105,7 +1107,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 	 * Documentation/admin-guide/mm/soft-dirty.rst for full description
 	 * of how soft-dirty works.
 	 */
-	pte_t ptent = *pte;
+	pte_t ptent = ptep_get(pte);
 
 	if (pte_present(ptent)) {
 		pte_t old_pte;
@@ -1194,7 +1196,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
-		ptent = *pte;
+		ptent = ptep_get(pte);
 
 		if (cp->type == CLEAR_REFS_SOFT_DIRTY) {
 			clear_soft_dirty(vma, addr, pte);
@@ -1550,7 +1552,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
 		pagemap_entry_t pme;
 
-		pme = pte_to_pagemap_entry(pm, vma, addr, *pte);
+		pme = pte_to_pagemap_entry(pm, vma, addr, ptep_get(pte));
 		err = add_to_pagemap(addr, &pme, pm);
 		if (err)
 			break;
@@ -1893,10 +1895,11 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 	do {
-		struct page *page = can_gather_numa_stats(*pte, vma, addr);
+		pte_t ptent = ptep_get(pte);
+		struct page *page = can_gather_numa_stats(ptent, vma, addr);
 		if (!page)
 			continue;
-		gather_stats(page, md, pte_dirty(*pte), 1);
+		gather_stats(page, md, pte_dirty(ptent), 1);
 
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(orig_pte, ptl);
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index bbe5633b1b97..7cecd49e078b 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -335,6 +335,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pud_t *pud;
 	pmd_t *pmd, _pmd;
 	pte_t *pte;
+	pte_t ptent;
 	bool ret = true;
 
 	mmap_assert_locked(mm);
@@ -374,9 +375,10 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	 * changes under us.  PTE markers should be handled the same as none
 	 * ptes here.
 	 */
-	if (pte_none_mostly(*pte))
+	ptent = ptep_get(pte);
+	if (pte_none_mostly(ptent))
 		ret = true;
-	if (!pte_write(*pte) && (reason & VM_UFFD_WP))
+	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
 		ret = true;
 	pte_unmap(pte);
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 21f942025fec..beb7c63d2871 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1185,7 +1185,11 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
+#ifdef CONFIG_MMU
+	return ptep_get(ptep);
+#else
 	return *ptep;
+#endif
 }
 
 static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 0e1d239a882c..08c2bcefcb2b 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -555,7 +555,7 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 	bool arm_uffd_pte = false;
 
 	/* The current status of the pte should be "cleared" before calling */
-	WARN_ON_ONCE(!pte_none(*pte));
+	WARN_ON_ONCE(!pte_none(ptep_get(pte)));
 
 	/*
 	 * NOTE: userfaultfd_wp_unpopulated() doesn't need this whole
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index fc06f6419661..5063b482e34f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -231,7 +231,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 					    unsigned long address,
 					    pte_t *ptep)
 {
-	pte_t pte = *ptep;
+	pte_t pte = ptep_get(ptep);
 	int r = 1;
 	if (!pte_young(pte))
 		r = 0;
@@ -318,7 +318,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
 				       pte_t *ptep)
 {
-	pte_t pte = *ptep;
+	pte_t pte = ptep_get(ptep);
 	pte_clear(mm, address, ptep);
 	page_table_check_pte_clear(mm, address, pte);
 	return pte;
@@ -519,7 +519,7 @@ extern pud_t pudp_huge_clear_flush(struct vm_area_struct *vma,
 struct mm_struct;
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
 {
-	pte_t old_pte = *ptep;
+	pte_t old_pte = ptep_get(ptep);
 	set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
 }
 #endif
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 607d742caa61..f0ac5b874919 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -192,7 +192,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		inc_mm_counter(mm, MM_ANONPAGES);
 	}
 
-	flush_cache_page(vma, addr, pte_pfn(*pvmw.pte));
+	flush_cache_page(vma, addr, pte_pfn(ptep_get(pvmw.pte)));
 	ptep_clear_flush_notify(vma, addr, pvmw.pte);
 	if (new_page)
 		set_pte_at_notify(mm, addr, pvmw.pte,
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d4ab81229136..e940802a15a4 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -39,7 +39,7 @@ struct folio *damon_get_folio(unsigned long pfn)
 
 void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
 {
-	struct folio *folio = damon_get_folio(pte_pfn(*pte));
+	struct folio *folio = damon_get_folio(pte_pfn(ptep_get(pte)));
 
 	if (!folio)
 		return;
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5b3a3463d078..40801e38fcf0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -89,7 +89,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
-			*accessed = pte_young(*pvmw.pte) ||
+			*accessed = pte_young(ptep_get(pvmw.pte)) ||
 				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
 		} else {
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index e814f66dfc2e..2fcc9731528a 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -323,7 +323,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		walk->action = ACTION_AGAIN;
 		return 0;
 	}
-	if (!pte_present(*pte))
+	if (!pte_present(ptep_get(pte)))
 		goto out;
 	damon_ptep_mkold(pte, walk->vma, addr);
 out:
@@ -433,6 +433,7 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 		unsigned long next, struct mm_walk *walk)
 {
 	pte_t *pte;
+	pte_t ptent;
 	spinlock_t *ptl;
 	struct folio *folio;
 	struct damon_young_walk_private *priv = walk->private;
@@ -471,12 +472,13 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
 		walk->action = ACTION_AGAIN;
 		return 0;
 	}
-	if (!pte_present(*pte))
+	ptent = ptep_get(pte);
+	if (!pte_present(ptent))
 		goto out;
-	folio = damon_get_folio(pte_pfn(*pte));
+	folio = damon_get_folio(pte_pfn(ptent));
 	if (!folio)
 		goto out;
-	if (pte_young(*pte) || !folio_test_idle(folio) ||
+	if (pte_young(ptent) || !folio_test_idle(folio) ||
 			mmu_notifier_test_young(walk->mm, addr))
 		priv->young = true;
 	*priv->folio_sz = folio_size(folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index 5c2037cb29c8..4be20e82e4c3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3529,7 +3529,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		 * handled in the specific fault path, and it'll prohibit the
 		 * fault-around logic.
 		 */
-		if (!pte_none(*vmf->pte))
+		if (!pte_none(ptep_get(vmf->pte)))
 			goto unlock;
 
 		/* We're about to handle the fault */
diff --git a/mm/gup.c b/mm/gup.c
index 838db6c0bfc2..38986e522d34 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -477,13 +477,14 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 		pte_t *pte, unsigned int flags)
 {
 	if (flags & FOLL_TOUCH) {
-		pte_t entry = *pte;
+		pte_t orig_entry = ptep_get(pte);
+		pte_t entry = orig_entry;
 
 		if (flags & FOLL_WRITE)
 			entry = pte_mkdirty(entry);
 		entry = pte_mkyoung(entry);
 
-		if (!pte_same(*pte, entry)) {
+		if (!pte_same(orig_entry, entry)) {
 			set_pte_at(vma->vm_mm, address, pte, entry);
 			update_mmu_cache(vma, address, pte);
 		}
@@ -549,7 +550,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (!ptep)
 		return no_page_table(vma, flags);
-	pte = *ptep;
+	pte = ptep_get(ptep);
 	if (!pte_present(pte))
 		goto no_page;
 	if (pte_protnone(pte) && !gup_can_follow_protnone(flags))
@@ -821,6 +822,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	pte_t entry;
 	int ret = -EFAULT;
 
 	/* user gate pages are read-only */
@@ -844,16 +846,17 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 	pte = pte_offset_map(pmd, address);
 	if (!pte)
 		return -EFAULT;
-	if (pte_none(*pte))
+	entry = ptep_get(pte);
+	if (pte_none(entry))
 		goto unmap;
 	*vma = get_gate_vma(mm);
 	if (!page)
 		goto out;
-	*page = vm_normal_page(*vma, address, *pte);
+	*page = vm_normal_page(*vma, address, entry);
 	if (!*page) {
-		if ((gup_flags & FOLL_DUMP) || !is_zero_pfn(pte_pfn(*pte)))
+		if ((gup_flags & FOLL_DUMP) || !is_zero_pfn(pte_pfn(entry)))
 			goto unmap;
-		*page = pte_page(*pte);
+		*page = pte_page(entry);
 	}
 	ret = try_grab_page(*page, gup_flags);
 	if (unlikely(ret))
@@ -2496,7 +2499,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		}
 
 		if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
-		    unlikely(pte_val(pte) != pte_val(*ptep))) {
+		    unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
@@ -2693,7 +2696,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	if (!folio)
 		return 0;
 
-	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
+	if (unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
 	}
diff --git a/mm/highmem.c b/mm/highmem.c
index db251e77f98f..e19269093a93 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -161,7 +161,7 @@ struct page *__kmap_to_page(void *vaddr)
 	/* kmap() mappings */
 	if (WARN_ON_ONCE(addr >= PKMAP_ADDR(0) &&
 			 addr < PKMAP_ADDR(LAST_PKMAP)))
-		return pte_page(pkmap_page_table[PKMAP_NR(addr)]);
+		return pte_page(ptep_get(&pkmap_page_table[PKMAP_NR(addr)]));
 
 	/* kmap_local_page() mappings */
 	if (WARN_ON_ONCE(base >= __fix_to_virt(FIX_KMAP_END) &&
@@ -191,6 +191,7 @@ static void flush_all_zero_pkmaps(void)
 
 	for (i = 0; i < LAST_PKMAP; i++) {
 		struct page *page;
+		pte_t ptent;
 
 		/*
 		 * zero means we don't have anything to do,
@@ -203,7 +204,8 @@ static void flush_all_zero_pkmaps(void)
 		pkmap_count[i] = 0;
 
 		/* sanity check */
-		BUG_ON(pte_none(pkmap_page_table[i]));
+		ptent = ptep_get(&pkmap_page_table[i]);
+		BUG_ON(pte_none(ptent));
 
 		/*
 		 * Don't need an atomic fetch-and-clear op here;
@@ -212,7 +214,7 @@ static void flush_all_zero_pkmaps(void)
 		 * getting the kmap_lock (which is held here).
 		 * So no dangers, even with speculative execution.
 		 */
-		page = pte_page(pkmap_page_table[i]);
+		page = pte_page(ptent);
 		pte_clear(&init_mm, PKMAP_ADDR(i), &pkmap_page_table[i]);
 
 		set_page_address(page, NULL);
@@ -511,7 +513,7 @@ static inline bool kmap_high_unmap_local(unsigned long vaddr)
 {
 #ifdef ARCH_NEEDS_KMAP_HIGH_GET
 	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
-		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
+		kunmap_high(pte_page(ptep_get(&pkmap_page_table[PKMAP_NR(vaddr)])));
 		return true;
 	}
 #endif
@@ -548,7 +550,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 	idx = arch_kmap_local_map_idx(kmap_local_idx_push(), pfn);
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 	kmap_pte = kmap_get_pte(vaddr, idx);
-	BUG_ON(!pte_none(*kmap_pte));
+	BUG_ON(!pte_none(ptep_get(kmap_pte)));
 	pteval = pfn_pte(pfn, prot);
 	arch_kmap_local_set_pte(&init_mm, vaddr, kmap_pte, pteval);
 	arch_kmap_local_post_map(vaddr, pteval);
diff --git a/mm/hmm.c b/mm/hmm.c
index b1a9159d7c92..855e25e59d8f 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -228,7 +228,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned int required_fault;
 	unsigned long cpu_flags;
-	pte_t pte = *ptep;
+	pte_t pte = ptep_get(ptep);
 	uint64_t pfn_req_flags = *hmm_pfn;
 
 	if (pte_none_mostly(pte)) {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 31bc8fa768e3..94e94bc10a67 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2063,7 +2063,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 		entry = pte_mkspecial(entry);
 		if (pmd_uffd_wp(old_pmd))
 			entry = pte_mkuffd_wp(entry);
-		VM_BUG_ON(!pte_none(*pte));
+		VM_BUG_ON(!pte_none(ptep_get(pte)));
 		set_pte_at(mm, addr, pte, entry);
 		pte++;
 	}
@@ -2257,7 +2257,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_mkuffd_wp(entry);
 			page_add_anon_rmap(page + i, vma, addr, false);
 		}
-		VM_BUG_ON(!pte_none(*pte));
+		VM_BUG_ON(!pte_none(ptep_get(pte)));
 		set_pte_at(mm, addr, pte, entry);
 		pte++;
 	}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index de96cd936b12..03951cdb8f4e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7247,7 +7247,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 				pte = (pte_t *)pmd_alloc(mm, pud, addr);
 		}
 	}
-	BUG_ON(pte && pte_present(*pte) && !pte_huge(*pte));
+	BUG_ON(pte && pte_present(ptep_get(pte)) && !pte_huge(ptep_get(pte)));
 
 	return pte;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index f42079b73f82..c2007ef5e9b0 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -105,7 +105,7 @@ static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
 	 * remapping (which is calling @walk->remap_pte).
 	 */
 	if (!walk->reuse_page) {
-		walk->reuse_page = pte_page(*pte);
+		walk->reuse_page = pte_page(ptep_get(pte));
 		/*
 		 * Because the reuse address is part of the range that we are
 		 * walking, skip the reuse address range.
@@ -239,7 +239,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 	 * to the tail pages.
 	 */
 	pgprot_t pgprot = PAGE_KERNEL_RO;
-	struct page *page = pte_page(*pte);
+	struct page *page = pte_page(ptep_get(pte));
 	pte_t entry;
 
 	/* Remapping the head page requires r/w */
@@ -286,7 +286,7 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 	struct page *page;
 	void *to;
 
-	BUG_ON(pte_page(*pte) != walk->reuse_page);
+	BUG_ON(pte_page(ptep_get(pte)) != walk->reuse_page);
 
 	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
 	list_del(&page->lru);
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index cc64ed6858c6..dcfec277e839 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -286,7 +286,7 @@ static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
 
 	for (i = 0; i < PTRS_PER_PTE; i++) {
 		pte = pte_start + i;
-		if (!pte_none(*pte))
+		if (!pte_none(ptep_get(pte)))
 			return;
 	}
 
@@ -343,16 +343,19 @@ static void kasan_remove_pte_table(pte_t *pte, unsigned long addr,
 				unsigned long end)
 {
 	unsigned long next;
+	pte_t ptent;
 
 	for (; addr < end; addr = next, pte++) {
 		next = (addr + PAGE_SIZE) & PAGE_MASK;
 		if (next > end)
 			next = end;
 
-		if (!pte_present(*pte))
+		ptent = ptep_get(pte);
+
+		if (!pte_present(ptent))
 			continue;
 
-		if (WARN_ON(!kasan_early_shadow_page_entry(*pte)))
+		if (WARN_ON(!kasan_early_shadow_page_entry(ptent)))
 			continue;
 		pte_clear(&init_mm, addr, pte);
 	}
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 3e62728ae25d..dd772f9d0f08 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -226,7 +226,7 @@ static bool shadow_mapped(unsigned long addr)
 	if (pmd_bad(*pmd))
 		return true;
 	pte = pte_offset_kernel(pmd, addr);
-	return !pte_none(*pte);
+	return !pte_none(ptep_get(pte));
 }
 
 static int __meminit kasan_mem_notifier(struct notifier_block *nb,
@@ -317,7 +317,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	unsigned long page;
 	pte_t pte;
 
-	if (likely(!pte_none(*ptep)))
+	if (likely(!pte_none(ptep_get(ptep))))
 		return 0;
 
 	page = __get_free_page(GFP_KERNEL);
@@ -328,7 +328,7 @@ static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 	pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
 
 	spin_lock(&init_mm.page_table_lock);
-	if (likely(pte_none(*ptep))) {
+	if (likely(pte_none(ptep_get(ptep)))) {
 		set_pte_at(&init_mm, addr, ptep, pte);
 		page = 0;
 	}
@@ -418,11 +418,11 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
 {
 	unsigned long page;
 
-	page = (unsigned long)__va(pte_pfn(*ptep) << PAGE_SHIFT);
+	page = (unsigned long)__va(pte_pfn(ptep_get(ptep)) << PAGE_SHIFT);
 
 	spin_lock(&init_mm.page_table_lock);
 
-	if (likely(!pte_none(*ptep))) {
+	if (likely(!pte_none(ptep_get(ptep)))) {
 		pte_clear(&init_mm, addr, ptep);
 		free_page(page);
 	}
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0cf81fef0084..3dc680e94f59 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -511,7 +511,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 	struct folio *folio, *tmp;
 
 	while (--_pte >= pte) {
-		pte_t pteval = *_pte;
+		pte_t pteval = ptep_get(_pte);
 		unsigned long pfn;
 
 		if (pte_none(pteval))
@@ -555,7 +555,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 
 	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, address += PAGE_SIZE) {
-		pte_t pteval = *_pte;
+		pte_t pteval = ptep_get(_pte);
 		if (pte_none(pteval) || (pte_present(pteval) &&
 				is_zero_pfn(pte_pfn(pteval)))) {
 			++none_or_zero;
@@ -699,7 +699,7 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 
 	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, address += PAGE_SIZE) {
-		pteval = *_pte;
+		pteval = ptep_get(_pte);
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
 			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
 			if (is_zero_pfn(pte_pfn(pteval))) {
@@ -797,7 +797,7 @@ static int __collapse_huge_page_copy(pte_t *pte,
 	 */
 	for (_pte = pte, _address = address; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, page++, _address += PAGE_SIZE) {
-		pteval = *_pte;
+		pteval = ptep_get(_pte);
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
 			clear_user_highpage(page, _address);
 			continue;
@@ -1274,7 +1274,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 
 	for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, _address += PAGE_SIZE) {
-		pte_t pteval = *_pte;
+		pte_t pteval = ptep_get(_pte);
 		if (is_swap_pte(pteval)) {
 			++unmapped;
 			if (!cc->is_khugepaged ||
@@ -1650,18 +1650,19 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	for (i = 0, addr = haddr, pte = start_pte;
 	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
 		struct page *page;
+		pte_t ptent = ptep_get(pte);
 
 		/* empty pte, skip */
-		if (pte_none(*pte))
+		if (pte_none(ptent))
 			continue;
 
 		/* page swapped out, abort */
-		if (!pte_present(*pte)) {
+		if (!pte_present(ptent)) {
 			result = SCAN_PTE_NON_PRESENT;
 			goto abort;
 		}
 
-		page = vm_normal_page(vma, addr, *pte);
+		page = vm_normal_page(vma, addr, ptent);
 		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
 			page = NULL;
 		/*
@@ -1677,10 +1678,11 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	for (i = 0, addr = haddr, pte = start_pte;
 	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
 		struct page *page;
+		pte_t ptent = ptep_get(pte);
 
-		if (pte_none(*pte))
+		if (pte_none(ptent))
 			continue;
-		page = vm_normal_page(vma, addr, *pte);
+		page = vm_normal_page(vma, addr, ptent);
 		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
 			goto abort;
 		page_remove_rmap(page, vma, false);
diff --git a/mm/ksm.c b/mm/ksm.c
index 3dc15459dd20..d995779dc1fe 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -429,15 +429,17 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
 	struct page *page = NULL;
 	spinlock_t *ptl;
 	pte_t *pte;
+	pte_t ptent;
 	int ret;
 
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	if (!pte)
 		return 0;
-	if (pte_present(*pte)) {
-		page = vm_normal_page(walk->vma, addr, *pte);
-	} else if (!pte_none(*pte)) {
-		swp_entry_t entry = pte_to_swp_entry(*pte);
+	ptent = ptep_get(pte);
+	if (pte_present(ptent)) {
+		page = vm_normal_page(walk->vma, addr, ptent);
+	} else if (!pte_none(ptent)) {
+		swp_entry_t entry = pte_to_swp_entry(ptent);
 
 		/*
 		 * As KSM pages remain KSM pages until freed, no need to wait
@@ -1085,6 +1087,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 	int err = -EFAULT;
 	struct mmu_notifier_range range;
 	bool anon_exclusive;
+	pte_t entry;
 
 	pvmw.address = page_address_in_vma(page, vma);
 	if (pvmw.address == -EFAULT)
@@ -1102,10 +1105,9 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 		goto out_unlock;
 
 	anon_exclusive = PageAnonExclusive(page);
-	if (pte_write(*pvmw.pte) || pte_dirty(*pvmw.pte) ||
+	entry = ptep_get(pvmw.pte);
+	if (pte_write(entry) || pte_dirty(entry) ||
 	    anon_exclusive || mm_tlb_flush_pending(mm)) {
-		pte_t entry;
-
 		swapped = PageSwapCache(page);
 		flush_cache_page(vma, pvmw.address, page_to_pfn(page));
 		/*
@@ -1147,7 +1149,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 
 		set_pte_at_notify(mm, pvmw.address, pvmw.pte, entry);
 	}
-	*orig_pte = *pvmw.pte;
+	*orig_pte = entry;
 	err = 0;
 
 out_unlock:
@@ -1204,7 +1206,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	ptep = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	if (!ptep)
 		goto out_mn;
-	if (!pte_same(*ptep, orig_pte)) {
+	if (!pte_same(ptep_get(ptep), orig_pte)) {
 		pte_unmap_unlock(ptep, ptl);
 		goto out_mn;
 	}
@@ -1231,7 +1233,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
-	flush_cache_page(vma, addr, pte_pfn(*ptep));
+	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
 	/*
 	 * No need to notify as we are replacing a read only page with another
 	 * read only page with the same content.
diff --git a/mm/madvise.c b/mm/madvise.c
index dfcda58a6246..d9e7b421a93d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -207,7 +207,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 				break;
 		}
 
-		pte = *ptep;
+		pte = ptep_get(ptep);
 		if (!is_swap_pte(pte))
 			continue;
 		entry = pte_to_swp_entry(pte);
@@ -440,7 +440,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
-		ptent = *pte;
+		ptent = ptep_get(pte);
 
 		if (pte_none(ptent))
 			continue;
@@ -646,7 +646,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
-		ptent = *pte;
+		ptent = ptep_get(pte);
 
 		if (pte_none(ptent))
 			continue;
diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 87b4beeda4fa..a26dd8bcfcdb 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -35,7 +35,7 @@ static int wp_pte(pte_t *pte, unsigned long addr, unsigned long end,
 		  struct mm_walk *walk)
 {
 	struct wp_walk *wpwalk = walk->private;
-	pte_t ptent = *pte;
+	pte_t ptent = ptep_get(pte);
 
 	if (pte_write(ptent)) {
 		pte_t old_pte = ptep_modify_prot_start(walk->vma, addr, pte);
@@ -91,7 +91,7 @@ static int clean_record_pte(pte_t *pte, unsigned long addr,
 {
 	struct wp_walk *wpwalk = walk->private;
 	struct clean_walk *cwalk = to_clean_walk(wpwalk);
-	pte_t ptent = *pte;
+	pte_t ptent = ptep_get(pte);
 
 	if (pte_dirty(ptent)) {
 		pgoff_t pgoff = ((addr - walk->vma->vm_start) >> PAGE_SHIFT) +
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 77d8d2d14fcf..93056918e956 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6025,7 +6025,7 @@ static int mem_cgroup_count_precharge_pte_range(pmd_t *pmd,
 	if (!pte)
 		return 0;
 	for (; addr != end; pte++, addr += PAGE_SIZE)
-		if (get_mctgt_type(vma, addr, *pte, NULL))
+		if (get_mctgt_type(vma, addr, ptep_get(pte), NULL))
 			mc.precharge++;	/* increment precharge temporarily */
 	pte_unmap_unlock(pte - 1, ptl);
 	cond_resched();
@@ -6246,7 +6246,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	if (!pte)
 		return 0;
 	for (; addr != end; addr += PAGE_SIZE) {
-		pte_t ptent = *(pte++);
+		pte_t ptent = ptep_get(pte++);
 		bool device = false;
 		swp_entry_t ent;
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d5116f0eb1b6..e245191e6b04 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -6,16 +6,16 @@
  * High level machine check handler. Handles pages reported by the
  * hardware as being corrupted usually due to a multi-bit ECC memory or cache
  * failure.
- * 
+ *
  * In addition there is a "soft offline" entry point that allows stop using
  * not-yet-corrupted-by-suspicious pages without killing anything.
  *
  * Handles page cache pages in various states.	The tricky part
- * here is that we can access any page asynchronously in respect to 
- * other VM users, because memory failures could happen anytime and 
- * anywhere. This could violate some of their assumptions. This is why 
- * this code has to be extremely careful. Generally it tries to use 
- * normal locking rules, as in get the standard locks, even if that means 
+ * here is that we can access any page asynchronously in respect to
+ * other VM users, because memory failures could happen anytime and
+ * anywhere. This could violate some of their assumptions. This is why
+ * this code has to be extremely careful. Generally it tries to use
+ * normal locking rules, as in get the standard locks, even if that means
  * the error handling takes potentially a long time.
  *
  * It can be very tempting to add handling for obscure cases here.
@@ -25,12 +25,12 @@
  *   https://git.kernel.org/cgit/utils/cpu/mce/mce-test.git/
  * - The case actually shows up as a frequent (top 10) page state in
  *   tools/mm/page-types when running a real workload.
- * 
+ *
  * There are several operations here with exponential complexity because
- * of unsuitable VM data structures. For example the operation to map back 
- * from RMAP chains to processes has to walk the complete process list and 
+ * of unsuitable VM data structures. For example the operation to map back
+ * from RMAP chains to processes has to walk the complete process list and
  * has non linear complexity with the number. But since memory corruptions
- * are rare we hope to get away with this. This avoids impacting the core 
+ * are rare we hope to get away with this. This avoids impacting the core
  * VM.
  */
 
@@ -386,6 +386,7 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	pte_t ptent;
 
 	VM_BUG_ON_VMA(address == -EFAULT, vma);
 	pgd = pgd_offset(vma->vm_mm, address);
@@ -407,7 +408,8 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
 	pte = pte_offset_map(pmd, address);
 	if (!pte)
 		return 0;
-	if (pte_present(*pte) && pte_devmap(*pte))
+	ptent = ptep_get(pte);
+	if (pte_present(ptent) && pte_devmap(ptent))
 		ret = PAGE_SHIFT;
 	pte_unmap(pte);
 	return ret;
@@ -799,7 +801,7 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
 		goto out;
 
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
-		ret = check_hwpoisoned_entry(*ptep, addr, PAGE_SHIFT,
+		ret = check_hwpoisoned_entry(ptep_get(ptep), addr, PAGE_SHIFT,
 					     hwp->pfn, &hwp->tk);
 		if (ret == 1)
 			break;
diff --git a/mm/memory.c b/mm/memory.c
index 50710940d53f..15a6ac71c15f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -697,15 +697,17 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 				  struct page *page, unsigned long address,
 				  pte_t *ptep)
 {
+	pte_t orig_pte;
 	pte_t pte;
 	swp_entry_t entry;
 
+	orig_pte = ptep_get(ptep);
 	pte = pte_mkold(mk_pte(page, READ_ONCE(vma->vm_page_prot)));
-	if (pte_swp_soft_dirty(*ptep))
+	if (pte_swp_soft_dirty(orig_pte))
 		pte = pte_mksoft_dirty(pte);
 
-	entry = pte_to_swp_entry(*ptep);
-	if (pte_swp_uffd_wp(*ptep))
+	entry = pte_to_swp_entry(orig_pte);
+	if (pte_swp_uffd_wp(orig_pte))
 		pte = pte_mkuffd_wp(pte);
 	else if (is_writable_device_exclusive_entry(entry))
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
@@ -742,7 +744,7 @@ static int
 try_restore_exclusive_pte(pte_t *src_pte, struct vm_area_struct *vma,
 			unsigned long addr)
 {
-	swp_entry_t entry = pte_to_swp_entry(*src_pte);
+	swp_entry_t entry = pte_to_swp_entry(ptep_get(src_pte));
 	struct page *page = pfn_swap_entry_to_page(entry);
 
 	if (trylock_page(page)) {
@@ -766,9 +768,10 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		struct vm_area_struct *src_vma, unsigned long addr, int *rss)
 {
 	unsigned long vm_flags = dst_vma->vm_flags;
-	pte_t pte = *src_pte;
+	pte_t orig_pte = ptep_get(src_pte);
+	pte_t pte = orig_pte;
 	struct page *page;
-	swp_entry_t entry = pte_to_swp_entry(pte);
+	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 
 	if (likely(!non_swap_entry(entry))) {
 		if (swap_duplicate(entry) < 0)
@@ -783,8 +786,8 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			spin_unlock(&mmlist_lock);
 		}
 		/* Mark the swap entry as shared. */
-		if (pte_swp_exclusive(*src_pte)) {
-			pte = pte_swp_clear_exclusive(*src_pte);
+		if (pte_swp_exclusive(orig_pte)) {
+			pte = pte_swp_clear_exclusive(orig_pte);
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
 		rss[MM_SWAPENTS]++;
@@ -803,9 +806,9 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			entry = make_readable_migration_entry(
 							swp_offset(entry));
 			pte = swp_entry_to_pte(entry);
-			if (pte_swp_soft_dirty(*src_pte))
+			if (pte_swp_soft_dirty(orig_pte))
 				pte = pte_swp_mksoft_dirty(pte);
-			if (pte_swp_uffd_wp(*src_pte))
+			if (pte_swp_uffd_wp(orig_pte))
 				pte = pte_swp_mkuffd_wp(pte);
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
@@ -838,7 +841,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			entry = make_readable_device_private_entry(
 							swp_offset(entry));
 			pte = swp_entry_to_pte(entry);
-			if (pte_swp_uffd_wp(*src_pte))
+			if (pte_swp_uffd_wp(orig_pte))
 				pte = pte_swp_mkuffd_wp(pte);
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
@@ -902,7 +905,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	/* All done, just insert the new page copy in the child */
 	pte = mk_pte(&new_folio->page, dst_vma->vm_page_prot);
 	pte = maybe_mkwrite(pte_mkdirty(pte), dst_vma);
-	if (userfaultfd_pte_wp(dst_vma, *src_pte))
+	if (userfaultfd_pte_wp(dst_vma, ptep_get(src_pte)))
 		/* Uffd-wp needs to be delivered to dest pte as well */
 		pte = pte_mkuffd_wp(pte);
 	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
@@ -920,7 +923,7 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 {
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	unsigned long vm_flags = src_vma->vm_flags;
-	pte_t pte = *src_pte;
+	pte_t pte = ptep_get(src_pte);
 	struct page *page;
 	struct folio *folio;
 
@@ -1000,6 +1003,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	struct mm_struct *src_mm = src_vma->vm_mm;
 	pte_t *orig_src_pte, *orig_dst_pte;
 	pte_t *src_pte, *dst_pte;
+	pte_t ptent;
 	spinlock_t *src_ptl, *dst_ptl;
 	int progress, ret = 0;
 	int rss[NR_MM_COUNTERS];
@@ -1045,17 +1049,18 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 			    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
 				break;
 		}
-		if (pte_none(*src_pte)) {
+		ptent = ptep_get(src_pte);
+		if (pte_none(ptent)) {
 			progress++;
 			continue;
 		}
-		if (unlikely(!pte_present(*src_pte))) {
+		if (unlikely(!pte_present(ptent))) {
 			ret = copy_nonpresent_pte(dst_mm, src_mm,
 						  dst_pte, src_pte,
 						  dst_vma, src_vma,
 						  addr, rss);
 			if (ret == -EIO) {
-				entry = pte_to_swp_entry(*src_pte);
+				entry = pte_to_swp_entry(ptep_get(src_pte));
 				break;
 			} else if (ret == -EBUSY) {
 				break;
@@ -1405,7 +1410,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	do {
-		pte_t ptent = *pte;
+		pte_t ptent = ptep_get(pte);
 		struct page *page;
 
 		if (pte_none(ptent))
@@ -1820,7 +1825,7 @@ static int validate_page_before_insert(struct page *page)
 static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 			unsigned long addr, struct page *page, pgprot_t prot)
 {
-	if (!pte_none(*pte))
+	if (!pte_none(ptep_get(pte)))
 		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
 	get_page(page);
@@ -2117,7 +2122,8 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	pte = get_locked_pte(mm, addr, &ptl);
 	if (!pte)
 		return VM_FAULT_OOM;
-	if (!pte_none(*pte)) {
+	entry = ptep_get(pte);
+	if (!pte_none(entry)) {
 		if (mkwrite) {
 			/*
 			 * For read faults on private mappings the PFN passed
@@ -2129,11 +2135,11 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			 * allocation and mapping invalidation so just skip the
 			 * update.
 			 */
-			if (pte_pfn(*pte) != pfn_t_to_pfn(pfn)) {
-				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(*pte)));
+			if (pte_pfn(entry) != pfn_t_to_pfn(pfn)) {
+				WARN_ON_ONCE(!is_zero_pfn(pte_pfn(entry)));
 				goto out_unlock;
 			}
-			entry = pte_mkyoung(*pte);
+			entry = pte_mkyoung(entry);
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 			if (ptep_set_access_flags(vma, addr, pte, entry, 1))
 				update_mmu_cache(vma, addr, pte);
@@ -2345,7 +2351,7 @@ static int remap_pte_range(struct mm_struct *mm, pmd_t *pmd,
 		return -ENOMEM;
 	arch_enter_lazy_mmu_mode();
 	do {
-		BUG_ON(!pte_none(*pte));
+		BUG_ON(!pte_none(ptep_get(pte)));
 		if (!pfn_modify_allowed(pfn, prot)) {
 			err = -EACCES;
 			break;
@@ -2586,7 +2592,7 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 
 	if (fn) {
 		do {
-			if (create || !pte_none(*pte)) {
+			if (create || !pte_none(ptep_get(pte))) {
 				err = fn(pte++, addr, data);
 				if (err)
 					break;
@@ -2788,7 +2794,7 @@ static inline int pte_unmap_same(struct vm_fault *vmf)
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
 		spin_lock(vmf->ptl);
-		same = pte_same(*vmf->pte, vmf->orig_pte);
+		same = pte_same(ptep_get(vmf->pte), vmf->orig_pte);
 		spin_unlock(vmf->ptl);
 	}
 #endif
@@ -2839,7 +2845,7 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 		pte_t entry;
 
 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
-		if (unlikely(!vmf->pte || !pte_same(*vmf->pte, vmf->orig_pte))) {
+		if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 			/*
 			 * Other thread has already handled the fault
 			 * and update local tlb only
@@ -2866,7 +2872,7 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 
 		/* Re-validate under PTL if the page is still mapped */
 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
-		if (unlikely(!vmf->pte || !pte_same(*vmf->pte, vmf->orig_pte))) {
+		if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 			/* The PTE changed under us, update local tlb */
 			update_mmu_tlb(vma, addr, vmf->pte);
 			ret = -EAGAIN;
@@ -3113,7 +3119,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	 * Re-check the pte - we dropped the lock
 	 */
 	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
-	if (likely(vmf->pte && pte_same(*vmf->pte, vmf->orig_pte))) {
+	if (likely(vmf->pte && pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 		if (old_folio) {
 			if (!folio_test_anon(old_folio)) {
 				dec_mm_counter(mm, mm_counter_file(&old_folio->page));
@@ -3240,7 +3246,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
 	 * We might have raced with another page fault while we released the
 	 * pte_offset_map_lock.
 	 */
-	if (!pte_same(*vmf->pte, vmf->orig_pte)) {
+	if (!pte_same(ptep_get(vmf->pte), vmf->orig_pte)) {
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return VM_FAULT_NOPAGE;
@@ -3335,7 +3341,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	struct folio *folio = NULL;
 
 	if (likely(!unshare)) {
-		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
+		if (userfaultfd_pte_wp(vma, ptep_get(vmf->pte))) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			return handle_userfault(vmf, VM_UFFD_WP);
 		}
@@ -3597,7 +3603,7 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 				&vmf->ptl);
-	if (likely(vmf->pte && pte_same(*vmf->pte, vmf->orig_pte)))
+	if (likely(vmf->pte && pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
 		restore_exclusive_pte(vma, vmf->page, vmf->address, vmf->pte);
 
 	if (vmf->pte)
@@ -3642,7 +3648,7 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 	 * quickly from a PTE_MARKER_UFFD_WP into PTE_MARKER_SWAPIN_ERROR.
 	 * So is_pte_marker() check is not enough to safely drop the pte.
 	 */
-	if (pte_same(vmf->orig_pte, *vmf->pte))
+	if (pte_same(vmf->orig_pte, ptep_get(vmf->pte)))
 		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return 0;
@@ -3738,7 +3744,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
 			if (unlikely(!vmf->pte ||
-				     !pte_same(*vmf->pte, vmf->orig_pte)))
+				     !pte_same(ptep_get(vmf->pte),
+							vmf->orig_pte)))
 				goto unlock;
 
 			/*
@@ -3815,7 +3822,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
-			if (likely(vmf->pte && pte_same(*vmf->pte, vmf->orig_pte)))
+			if (likely(vmf->pte &&
+				   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
 				ret = VM_FAULT_OOM;
 			goto unlock;
 		}
@@ -3885,7 +3893,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
-	if (unlikely(!vmf->pte || !pte_same(*vmf->pte, vmf->orig_pte)))
+	if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
 		goto out_nomap;
 
 	if (unlikely(!folio_test_uptodate(folio))) {
@@ -4330,9 +4338,9 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 static bool vmf_pte_changed(struct vm_fault *vmf)
 {
 	if (vmf->flags & FAULT_FLAG_ORIG_PTE_VALID)
-		return !pte_same(*vmf->pte, vmf->orig_pte);
+		return !pte_same(ptep_get(vmf->pte), vmf->orig_pte);
 
-	return !pte_none(*vmf->pte);
+	return !pte_none(ptep_get(vmf->pte));
 }
 
 /**
@@ -4642,7 +4650,7 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 			 * we don't have concurrent modification by hardware
 			 * followed by an update.
 			 */
-			if (unlikely(pte_none(*vmf->pte)))
+			if (unlikely(pte_none(ptep_get(vmf->pte))))
 				ret = VM_FAULT_SIGBUS;
 			else
 				ret = VM_FAULT_NOPAGE;
@@ -4698,7 +4706,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * the pfn may be screwed if the read is non atomic.
 	 */
 	spin_lock(vmf->ptl);
-	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
+	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		goto out;
 	}
@@ -4771,7 +4779,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 					       vmf->address, &vmf->ptl);
 		if (unlikely(!vmf->pte))
 			goto out;
-		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
+		if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			goto out;
 		}
@@ -4929,7 +4937,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
-	if (unlikely(!pte_same(*vmf->pte, entry))) {
+	if (unlikely(!pte_same(ptep_get(vmf->pte), entry))) {
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		goto unlock;
 	}
@@ -5415,7 +5423,7 @@ int follow_pte(struct mm_struct *mm, unsigned long address,
 	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
 	if (!ptep)
 		goto out;
-	if (!pte_present(*ptep))
+	if (!pte_present(ptep_get(ptep)))
 		goto unlock;
 	*ptepp = ptep;
 	return 0;
@@ -5452,7 +5460,7 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	ret = follow_pte(vma->vm_mm, address, &ptep, &ptl);
 	if (ret)
 		return ret;
-	*pfn = pte_pfn(*ptep);
+	*pfn = pte_pfn(ptep_get(ptep));
 	pte_unmap_unlock(ptep, ptl);
 	return 0;
 }
@@ -5472,7 +5480,7 @@ int follow_phys(struct vm_area_struct *vma,
 
 	if (follow_pte(vma->vm_mm, address, &ptep, &ptl))
 		goto out;
-	pte = *ptep;
+	pte = ptep_get(ptep);
 
 	if ((flags & FOLL_WRITE) && !pte_write(pte))
 		goto unlock;
@@ -5516,7 +5524,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 retry:
 	if (follow_pte(vma->vm_mm, addr, &ptep, &ptl))
 		return -EINVAL;
-	pte = *ptep;
+	pte = ptep_get(ptep);
 	pte_unmap_unlock(ptep, ptl);
 
 	prot = pgprot_val(pte_pgprot(pte));
@@ -5532,7 +5540,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if (follow_pte(vma->vm_mm, addr, &ptep, &ptl))
 		goto out_unmap;
 
-	if (!pte_same(pte, *ptep)) {
+	if (!pte_same(pte, ptep_get(ptep))) {
 		pte_unmap_unlock(ptep, ptl);
 		iounmap(maddr);
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0241bb64978b..edc25195f5bd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -508,6 +508,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 	unsigned long flags = qp->flags;
 	bool has_unmovable = false;
 	pte_t *pte, *mapped_pte;
+	pte_t ptent;
 	spinlock_t *ptl;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
@@ -520,9 +521,10 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
-		if (!pte_present(*pte))
+		ptent = ptep_get(pte);
+		if (!pte_present(ptent))
 			continue;
-		folio = vm_normal_folio(vma, addr, *pte);
+		folio = vm_normal_folio(vma, addr, ptent);
 		if (!folio || folio_is_zone_device(folio))
 			continue;
 		/*
diff --git a/mm/migrate.c b/mm/migrate.c
index 363562992046..ce35afdbc1e3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -188,6 +188,7 @@ static bool remove_migration_pte(struct folio *folio,
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
+		pte_t old_pte;
 		pte_t pte;
 		swp_entry_t entry;
 		struct page *new;
@@ -210,17 +211,18 @@ static bool remove_migration_pte(struct folio *folio,
 
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
-		if (pte_swp_soft_dirty(*pvmw.pte))
+		old_pte = ptep_get(pvmw.pte);
+		if (pte_swp_soft_dirty(old_pte))
 			pte = pte_mksoft_dirty(pte);
 
-		entry = pte_to_swp_entry(*pvmw.pte);
+		entry = pte_to_swp_entry(old_pte);
 		if (!is_migration_entry_young(entry))
 			pte = pte_mkold(pte);
 		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
 			pte = pte_mkdirty(pte);
 		if (is_writable_migration_entry(entry))
 			pte = pte_mkwrite(pte);
-		else if (pte_swp_uffd_wp(*pvmw.pte))
+		else if (pte_swp_uffd_wp(old_pte))
 			pte = pte_mkuffd_wp(pte);
 
 		if (folio_test_anon(folio) && !is_readable_migration_entry(entry))
@@ -234,9 +236,9 @@ static bool remove_migration_pte(struct folio *folio,
 				entry = make_readable_device_private_entry(
 							page_to_pfn(new));
 			pte = swp_entry_to_pte(entry);
-			if (pte_swp_soft_dirty(*pvmw.pte))
+			if (pte_swp_soft_dirty(old_pte))
 				pte = pte_swp_mksoft_dirty(pte);
-			if (pte_swp_uffd_wp(*pvmw.pte))
+			if (pte_swp_uffd_wp(old_pte))
 				pte = pte_swp_mkuffd_wp(pte);
 		}
 
@@ -308,7 +310,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	if (!ptep)
 		return;
 
-	pte = *ptep;
+	pte = ptep_get(ptep);
 	pte_unmap(ptep);
 
 	if (!is_swap_pte(pte))
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index a14af6b12b04..02d272b909b5 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -111,7 +111,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		swp_entry_t entry;
 		pte_t pte;
 
-		pte = *ptep;
+		pte = ptep_get(ptep);
 
 		if (pte_none(pte)) {
 			if (vma_is_anonymous(vma)) {
@@ -194,7 +194,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			bool anon_exclusive;
 			pte_t swp_pte;
 
-			flush_cache_page(vma, addr, pte_pfn(*ptep));
+			flush_cache_page(vma, addr, pte_pfn(pte));
 			anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
 			if (anon_exclusive) {
 				pte = ptep_clear_flush(vma, addr, ptep);
@@ -573,6 +573,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
+	pte_t orig_pte;
 
 	/* Only allow populating anonymous memory */
 	if (!vma_is_anonymous(vma))
@@ -628,16 +629,18 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 	if (!ptep)
 		goto abort;
+	orig_pte = ptep_get(ptep);
+
 	if (check_stable_address_space(mm))
 		goto unlock_abort;
 
-	if (pte_present(*ptep)) {
-		unsigned long pfn = pte_pfn(*ptep);
+	if (pte_present(orig_pte)) {
+		unsigned long pfn = pte_pfn(orig_pte);
 
 		if (!is_zero_pfn(pfn))
 			goto unlock_abort;
 		flush = true;
-	} else if (!pte_none(*ptep))
+	} else if (!pte_none(orig_pte))
 		goto unlock_abort;
 
 	/*
@@ -654,7 +657,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	get_page(page);
 
 	if (flush) {
-		flush_cache_page(vma, addr, pte_pfn(*ptep));
+		flush_cache_page(vma, addr, pte_pfn(orig_pte));
 		ptep_clear_flush_notify(vma, addr, ptep);
 		set_pte_at_notify(mm, addr, ptep, entry);
 		update_mmu_cache(vma, addr, ptep);
diff --git a/mm/mincore.c b/mm/mincore.c
index f33f6a0b1ded..b7f7a516b26c 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -119,7 +119,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		return 0;
 	}
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
-		pte_t pte = *ptep;
+		pte_t pte = ptep_get(ptep);
 
 		/* We need to do cache lookup too for pte markers */
 		if (pte_none_mostly(pte))
diff --git a/mm/mlock.c b/mm/mlock.c
index 9f2b1173b1b1..d7db94519884 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -312,6 +312,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	struct vm_area_struct *vma = walk->vma;
 	spinlock_t *ptl;
 	pte_t *start_pte, *pte;
+	pte_t ptent;
 	struct folio *folio;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
@@ -334,9 +335,10 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	}
 	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
-		if (!pte_present(*pte))
+		ptent = ptep_get(pte);
+		if (!pte_present(ptent))
 			continue;
-		folio = vm_normal_folio(vma, addr, *pte);
+		folio = vm_normal_folio(vma, addr, ptent);
 		if (!folio || folio_is_zone_device(folio))
 			continue;
 		if (folio_test_large(folio))
diff --git a/mm/mprotect.c b/mm/mprotect.c
index c697b9c0269f..6f658d483704 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -105,7 +105,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 	flush_tlb_batched_pending(vma->vm_mm);
 	arch_enter_lazy_mmu_mode();
 	do {
-		oldpte = *pte;
+		oldpte = ptep_get(pte);
 		if (pte_present(oldpte)) {
 			pte_t ptent;
 
@@ -544,7 +544,8 @@ long change_protection(struct mmu_gather *tlb,
 static int prot_none_pte_entry(pte_t *pte, unsigned long addr,
 			       unsigned long next, struct mm_walk *walk)
 {
-	return pfn_modify_allowed(pte_pfn(*pte), *(pgprot_t *)(walk->private)) ?
+	return pfn_modify_allowed(pte_pfn(ptep_get(pte)),
+				  *(pgprot_t *)(walk->private)) ?
 		0 : -EACCES;
 }
 
@@ -552,7 +553,8 @@ static int prot_none_hugetlb_entry(pte_t *pte, unsigned long hmask,
 				   unsigned long addr, unsigned long next,
 				   struct mm_walk *walk)
 {
-	return pfn_modify_allowed(pte_pfn(*pte), *(pgprot_t *)(walk->private)) ?
+	return pfn_modify_allowed(pte_pfn(ptep_get(pte)),
+				  *(pgprot_t *)(walk->private)) ?
 		0 : -EACCES;
 }
 
diff --git a/mm/mremap.c b/mm/mremap.c
index bfc3d1902a94..8ec184ac90ff 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -188,7 +188,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 
 	for (; old_addr < old_end; old_pte++, old_addr += PAGE_SIZE,
 				   new_pte++, new_addr += PAGE_SIZE) {
-		if (pte_none(*old_pte))
+		if (pte_none(ptep_get(old_pte)))
 			continue;
 
 		pte = ptep_get_and_clear(mm, old_addr, old_pte);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 0c511330dbc9..8f89f9c8f0df 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -190,7 +190,7 @@ void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
 	if (&init_mm == mm)
 		return;
 
-	__page_table_check_pte_clear(mm, addr, *ptep);
+	__page_table_check_pte_clear(mm, addr, ptep_get(ptep));
 	if (pte_user_accessible_page(pte)) {
 		page_table_check_set(mm, addr, pte_pfn(pte),
 				     PAGE_SIZE >> PAGE_SHIFT,
@@ -243,7 +243,7 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
 		if (WARN_ON(!ptep))
 			return;
 		for (i = 0; i < PTRS_PER_PTE; i++) {
-			__page_table_check_pte_clear(mm, addr, *ptep);
+			__page_table_check_pte_clear(mm, addr, ptep_get(ptep));
 			addr += PAGE_SIZE;
 			ptep++;
 		}
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 2af734274073..49e0d28f0379 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -15,6 +15,8 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 
 static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 {
+	pte_t ptent;
+
 	if (pvmw->flags & PVMW_SYNC) {
 		/* Use the stricter lookup */
 		pvmw->pte = pte_offset_map_lock(pvmw->vma->vm_mm, pvmw->pmd,
@@ -35,10 +37,12 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 	if (!pvmw->pte)
 		return false;
 
+	ptent = ptep_get(pvmw->pte);
+
 	if (pvmw->flags & PVMW_MIGRATION) {
-		if (!is_swap_pte(*pvmw->pte))
+		if (!is_swap_pte(ptent))
 			return false;
-	} else if (is_swap_pte(*pvmw->pte)) {
+	} else if (is_swap_pte(ptent)) {
 		swp_entry_t entry;
 		/*
 		 * Handle un-addressable ZONE_DEVICE memory.
@@ -56,11 +60,11 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 		 * For more details on device private memory see HMM
 		 * (include/linux/hmm.h or mm/hmm.c).
 		 */
-		entry = pte_to_swp_entry(*pvmw->pte);
+		entry = pte_to_swp_entry(ptent);
 		if (!is_device_private_entry(entry) &&
 		    !is_device_exclusive_entry(entry))
 			return false;
-	} else if (!pte_present(*pvmw->pte)) {
+	} else if (!pte_present(ptent)) {
 		return false;
 	}
 	pvmw->ptl = *ptlp;
@@ -90,33 +94,34 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
 static bool check_pte(struct page_vma_mapped_walk *pvmw)
 {
 	unsigned long pfn;
+	pte_t ptent = ptep_get(pvmw->pte);
 
 	if (pvmw->flags & PVMW_MIGRATION) {
 		swp_entry_t entry;
-		if (!is_swap_pte(*pvmw->pte))
+		if (!is_swap_pte(ptent))
 			return false;
-		entry = pte_to_swp_entry(*pvmw->pte);
+		entry = pte_to_swp_entry(ptent);
 
 		if (!is_migration_entry(entry) &&
 		    !is_device_exclusive_entry(entry))
 			return false;
 
 		pfn = swp_offset_pfn(entry);
-	} else if (is_swap_pte(*pvmw->pte)) {
+	} else if (is_swap_pte(ptent)) {
 		swp_entry_t entry;
 
 		/* Handle un-addressable ZONE_DEVICE memory */
-		entry = pte_to_swp_entry(*pvmw->pte);
+		entry = pte_to_swp_entry(ptent);
 		if (!is_device_private_entry(entry) &&
 		    !is_device_exclusive_entry(entry))
 			return false;
 
 		pfn = swp_offset_pfn(entry);
 	} else {
-		if (!pte_present(*pvmw->pte))
+		if (!pte_present(ptent))
 			return false;
 
-		pfn = pte_pfn(*pvmw->pte);
+		pfn = pte_pfn(ptent);
 	}
 
 	return (pfn - pvmw->pfn) < pvmw->nr_pages;
@@ -294,7 +299,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 				goto restart;
 			}
 			pvmw->pte++;
-		} while (pte_none(*pvmw->pte));
+		} while (pte_none(ptep_get(pvmw->pte)));
 
 		if (!pvmw->ptl) {
 			pvmw->ptl = ptl;
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index c7ab18a5fb77..4d454953046f 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -68,7 +68,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pte_t *ptep,
 			  pte_t entry, int dirty)
 {
-	int changed = !pte_same(*ptep, entry);
+	int changed = !pte_same(ptep_get(ptep), entry);
 	if (changed) {
 		set_pte_at(vma->vm_mm, address, ptep, entry);
 		flush_tlb_fix_spurious_fault(vma, address, ptep);
diff --git a/mm/rmap.c b/mm/rmap.c
index ae127f60a4fb..ae2b8178f8f7 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -826,7 +826,8 @@ static bool folio_referenced_one(struct folio *folio,
 		}
 
 		if (pvmw.pte) {
-			if (lru_gen_enabled() && pte_young(*pvmw.pte)) {
+			if (lru_gen_enabled() &&
+			    pte_young(ptep_get(pvmw.pte))) {
 				lru_gen_look_around(&pvmw);
 				referenced++;
 			}
@@ -956,13 +957,13 @@ static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 
 		address = pvmw->address;
 		if (pvmw->pte) {
-			pte_t entry;
 			pte_t *pte = pvmw->pte;
+			pte_t entry = ptep_get(pte);
 
-			if (!pte_dirty(*pte) && !pte_write(*pte))
+			if (!pte_dirty(entry) && !pte_write(entry))
 				continue;
 
-			flush_cache_page(vma, address, pte_pfn(*pte));
+			flush_cache_page(vma, address, pte_pfn(entry));
 			entry = ptep_clear_flush(vma, address, pte);
 			entry = pte_wrprotect(entry);
 			entry = pte_mkclean(entry);
@@ -1137,7 +1138,7 @@ void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
  * @folio:	Folio which contains page.
  * @page:	Page to add to rmap.
  * @vma:	VM area to add page to.
- * @address:	User virtual address of the mapping	
+ * @address:	User virtual address of the mapping
  * @exclusive:	the page is exclusively owned by the current process
  */
 static void __page_set_anon_rmap(struct folio *folio, struct page *page,
@@ -1458,6 +1459,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	unsigned long pfn;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1508,8 +1510,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			break;
 		}
 
-		subpage = folio_page(folio,
-					pte_pfn(*pvmw.pte) - folio_pfn(folio));
+		pfn = pte_pfn(ptep_get(pvmw.pte));
+		subpage = folio_page(folio, pfn - folio_pfn(folio));
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
 				 PageAnonExclusive(subpage);
@@ -1571,7 +1573,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			}
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 		} else {
-			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
+			flush_cache_page(vma, address, pfn);
 			/* Nuke the page table entry. */
 			if (should_defer_flush(mm, flags)) {
 				/*
@@ -1818,6 +1820,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	unsigned long pfn;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1877,6 +1880,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
+		pfn = pte_pfn(ptep_get(pvmw.pte));
+
 		if (folio_is_zone_device(folio)) {
 			/*
 			 * Our PTE is a non-present device exclusive entry and
@@ -1891,8 +1896,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			VM_BUG_ON_FOLIO(folio_nr_pages(folio) > 1, folio);
 			subpage = &folio->page;
 		} else {
-			subpage = folio_page(folio,
-					pte_pfn(*pvmw.pte) - folio_pfn(folio));
+			subpage = folio_page(folio, pfn - folio_pfn(folio));
 		}
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
@@ -1952,7 +1956,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			/* Nuke the hugetlb page table entry */
 			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
 		} else {
-			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
+			flush_cache_page(vma, address, pfn);
 			/* Nuke the page table entry. */
 			if (should_defer_flush(mm, flags)) {
 				/*
@@ -2187,6 +2191,7 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 	struct mmu_notifier_range range;
 	swp_entry_t entry;
 	pte_t swp_pte;
+	pte_t ptent;
 
 	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_EXCLUSIVE, 0,
 				      vma->vm_mm, address, min(vma->vm_end,
@@ -2198,18 +2203,19 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 		/* Unexpected PMD-mapped THP? */
 		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
 
-		if (!pte_present(*pvmw.pte)) {
+		ptent = ptep_get(pvmw.pte);
+		if (!pte_present(ptent)) {
 			ret = false;
 			page_vma_mapped_walk_done(&pvmw);
 			break;
 		}
 
 		subpage = folio_page(folio,
-				pte_pfn(*pvmw.pte) - folio_pfn(folio));
+				pte_pfn(ptent) - folio_pfn(folio));
 		address = pvmw.address;
 
 		/* Nuke the page table entry. */
-		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
+		flush_cache_page(vma, address, pte_pfn(ptent));
 		pteval = ptep_clear_flush(vma, address, pvmw.pte);
 
 		/* Set the dirty flag on the folio now the pte is gone. */
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 10d73a0dfcec..a044a130405b 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -133,7 +133,7 @@ static void * __meminit altmap_alloc_block_buf(unsigned long size,
 void __meminit vmemmap_verify(pte_t *pte, int node,
 				unsigned long start, unsigned long end)
 {
-	unsigned long pfn = pte_pfn(*pte);
+	unsigned long pfn = pte_pfn(ptep_get(pte));
 	int actual_node = early_pfn_to_nid(pfn);
 
 	if (node_distance(actual_node, node) > LOCAL_DISTANCE)
@@ -146,7 +146,7 @@ pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 				       struct page *reuse)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
-	if (pte_none(*pte)) {
+	if (pte_none(ptep_get(pte))) {
 		pte_t entry;
 		void *p;
 
@@ -414,7 +414,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 * with just tail struct pages.
 		 */
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_page(*pte));
+					      pte_page(ptep_get(pte)));
 	}
 
 	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
@@ -438,7 +438,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 */
 		next += PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    pte_page(*pte));
+					    pte_page(ptep_get(pte)));
 		if (rc)
 			return -ENOMEM;
 	}
diff --git a/mm/swap_state.c b/mm/swap_state.c
index a33c60e0158f..4a5c7b748051 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -275,9 +275,9 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
 	}
 }
 
-/* 
- * If we are the only user, then try to free up the swap cache. 
- * 
+/*
+ * If we are the only user, then try to free up the swap cache.
+ *
  * Its ok to check the swapcache flag without the folio lock
  * here because we are going to recheck again inside
  * folio_free_swap() _with_ the lock.
@@ -294,7 +294,7 @@ void free_swap_cache(struct page *page)
 	}
 }
 
-/* 
+/*
  * Perform a free_page(), also freeing any swap cache associated with
  * this page if it is the last user of the page.
  */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 74dd4d2337b7..a6945c2e0d03 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1745,7 +1745,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	struct page *page = folio_file_page(folio, swp_offset(entry));
 	struct page *swapcache;
 	spinlock_t *ptl;
-	pte_t *pte, new_pte;
+	pte_t *pte, new_pte, old_pte;
 	bool hwposioned = false;
 	int ret = 1;
 
@@ -1757,11 +1757,14 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		hwposioned = true;
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
-	if (unlikely(!pte || !pte_same_as_swp(*pte, swp_entry_to_pte(entry)))) {
+	if (unlikely(!pte || !pte_same_as_swp(ptep_get(pte),
+						swp_entry_to_pte(entry)))) {
 		ret = 0;
 		goto out;
 	}
 
+	old_pte = ptep_get(pte);
+
 	if (unlikely(hwposioned || !PageUptodate(page))) {
 		swp_entry_t swp_entry;
 
@@ -1793,7 +1796,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		 * call and have the page locked.
 		 */
 		VM_BUG_ON_PAGE(PageWriteback(page), page);
-		if (pte_swp_exclusive(*pte))
+		if (pte_swp_exclusive(old_pte))
 			rmap_flags |= RMAP_EXCLUSIVE;
 
 		page_add_anon_rmap(page, vma, addr, rmap_flags);
@@ -1802,9 +1805,9 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
 	new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
-	if (pte_swp_soft_dirty(*pte))
+	if (pte_swp_soft_dirty(old_pte))
 		new_pte = pte_mksoft_dirty(new_pte);
-	if (pte_swp_uffd_wp(*pte))
+	if (pte_swp_uffd_wp(old_pte))
 		new_pte = pte_mkuffd_wp(new_pte);
 setpte:
 	set_pte_at(vma->vm_mm, addr, pte, new_pte);
@@ -1833,6 +1836,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned char swp_count;
 		swp_entry_t entry;
 		int ret;
+		pte_t ptent;
 
 		if (!pte++) {
 			pte = pte_offset_map(pmd, addr);
@@ -1840,10 +1844,12 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				break;
 		}
 
-		if (!is_swap_pte(*pte))
+		ptent = ptep_get_lockless(pte);
+
+		if (!is_swap_pte(ptent))
 			continue;
 
-		entry = pte_to_swp_entry(*pte);
+		entry = pte_to_swp_entry(ptent);
 		if (swp_type(entry) != type)
 			continue;
 
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 5fd787158c70..a2bf37ee276d 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -97,7 +97,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	 * registered, we firstly wr-protect a none pte which has no page cache
 	 * page backing it, then access the page.
 	 */
-	if (!pte_none_mostly(*dst_pte))
+	if (!pte_none_mostly(ptep_get(dst_pte)))
 		goto out_unlock;
 
 	folio = page_folio(page);
@@ -230,7 +230,7 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 			goto out_unlock;
 	}
 	ret = -EEXIST;
-	if (!pte_none(*dst_pte))
+	if (!pte_none(ptep_get(dst_pte)))
 		goto out_unlock;
 	set_pte_at(dst_vma->vm_mm, dst_addr, dst_pte, _dst_pte);
 	/* No need to invalidate - it was non-present before */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 41e490597159..93cf99aba335 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -103,7 +103,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (!pte)
 		return -ENOMEM;
 	do {
-		BUG_ON(!pte_none(*pte));
+		BUG_ON(!pte_none(ptep_get(pte)));
 
 #ifdef CONFIG_HUGETLB_PAGE
 		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
@@ -472,7 +472,7 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	do {
 		struct page *page = pages[*nr];
 
-		if (WARN_ON(!pte_none(*pte)))
+		if (WARN_ON(!pte_none(ptep_get(pte))))
 			return -EBUSY;
 		if (WARN_ON(!page))
 			return -ENOMEM;
@@ -704,7 +704,7 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 		return NULL;
 
 	ptep = pte_offset_kernel(pmd, addr);
-	pte = *ptep;
+	pte = ptep_get(ptep);
 	if (pte_present(pte))
 		page = pte_page(pte);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0b242864f64a..45d17c7cc555 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4022,15 +4022,16 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	for (i = pte_index(start), addr = start; addr != end; i++, addr += PAGE_SIZE) {
 		unsigned long pfn;
 		struct folio *folio;
+		pte_t ptent = ptep_get(pte + i);
 
 		total++;
 		walk->mm_stats[MM_LEAF_TOTAL]++;
 
-		pfn = get_pte_pfn(pte[i], args->vma, addr);
+		pfn = get_pte_pfn(ptent, args->vma, addr);
 		if (pfn == -1)
 			continue;
 
-		if (!pte_young(pte[i])) {
+		if (!pte_young(ptent)) {
 			walk->mm_stats[MM_LEAF_OLD]++;
 			continue;
 		}
@@ -4045,7 +4046,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		young++;
 		walk->mm_stats[MM_LEAF_YOUNG]++;
 
-		if (pte_dirty(pte[i]) && !folio_test_dirty(folio) &&
+		if (pte_dirty(ptent) && !folio_test_dirty(folio) &&
 		    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
 		      !folio_test_swapcache(folio)))
 			folio_mark_dirty(folio);
@@ -4688,12 +4689,13 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 
 	for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
 		unsigned long pfn;
+		pte_t ptent = ptep_get(pte + i);
 
-		pfn = get_pte_pfn(pte[i], pvmw->vma, addr);
+		pfn = get_pte_pfn(ptent, pvmw->vma, addr);
 		if (pfn == -1)
 			continue;
 
-		if (!pte_young(pte[i]))
+		if (!pte_young(ptent))
 			continue;
 
 		folio = get_pfn_folio(pfn, memcg, pgdat, !walk || walk->can_swap);
@@ -4705,7 +4707,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 
 		young++;
 
-		if (pte_dirty(pte[i]) && !folio_test_dirty(folio) &&
+		if (pte_dirty(ptent) && !folio_test_dirty(folio) &&
 		    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
 		      !folio_test_swapcache(folio)))
 			folio_mark_dirty(folio);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 51e4882d0873..fb37adecfc91 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2578,6 +2578,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 {
 	kvm_pfn_t pfn;
 	pte_t *ptep;
+	pte_t pte;
 	spinlock_t *ptl;
 	int r;
 
@@ -2601,14 +2602,16 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			return r;
 	}
 
-	if (write_fault && !pte_write(*ptep)) {
+	pte = ptep_get(ptep);
+
+	if (write_fault && !pte_write(pte)) {
 		pfn = KVM_PFN_ERR_RO_FAULT;
 		goto out;
 	}
 
 	if (writable)
-		*writable = pte_write(*ptep);
-	pfn = pte_pfn(*ptep);
+		*writable = pte_write(pte);
+	pfn = pte_pfn(pte);
 
 	/*
 	 * Get a reference here because callers of *hva_to_pfn* and
@@ -2626,7 +2629,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 	 * tail pages of non-compound higher order allocations, which
 	 * would then underflow the refcount when the caller does the
 	 * required put_page. Don't allow those pages here.
-	 */ 
+	 */
 	if (!kvm_try_get_pfn(pfn))
 		r = -EFAULT;
 
-- 
2.25.1

