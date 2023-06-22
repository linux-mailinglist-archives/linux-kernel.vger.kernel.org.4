Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9573A363
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjFVOnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjFVOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:43:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD3781FFD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:43:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A45B71042;
        Thu, 22 Jun 2023 07:43:51 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 207E63F663;
        Thu, 22 Jun 2023 07:43:05 -0700 (PDT)
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
Subject: [PATCH v1 14/14] arm64/mm: Implement ptep_set_wrprotects() to optimize fork()
Date:   Thu, 22 Jun 2023 15:42:09 +0100
Message-Id: <20230622144210.2623299-15-ryan.roberts@arm.com>
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

With the core-mm changes in place to batch-copy ptes during fork, we can
take advantage of this in arm64 to greatly reduce the number of tlbis we
have to issue, and recover the lost fork performance incured when adding
support for transparent contiguous ptes.

If we are write-protecting a whole contig range, we can apply the
write-protection to the whole range and know that it won't change
whether the range should have the contiguous bit set or not. For ranges
smaller than the contig range, we will still have to unfold, apply the
write-protection, then fold if the change now means the range is
foldable.

Performance tested with the following test written for the will-it-scale
framework:

-------

char *testcase_description = "fork and exit";

void testcase(unsigned long long *iterations, unsigned long nr)
{
	int pid;
	char *mem;

	mem = malloc(SZ_128M);
	assert(mem);
	memset(mem, 1, SZ_128M);

	while (1) {
		pid = fork();
		assert(pid >= 0);

		if (!pid)
			exit(0);

		waitpid(pid, NULL, 0);

		(*iterations)++;
	}
}

-------

I see huge performance regression when PTE_CONT support was added, then
the regression is mostly fixed with the addition of this change. The
following shows regression relative to before PTE_CONT was enabled
(bigger negative value is bigger regression):

|   cpus |   before opt |   after opt |
|-------:|-------------:|------------:|
|      1 |       -10.4% |       -5.2% |
|      8 |       -15.4% |       -3.5% |
|     16 |       -38.7% |       -3.7% |
|     24 |       -57.0% |       -4.4% |
|     32 |       -65.8% |       -5.4% |

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 48 ++++++++++++++++++++++----------
 arch/arm64/mm/contpte.c          | 41 +++++++++++++++++++++++++++
 arch/arm64/mm/hugetlbpage.c      |  2 +-
 3 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5963da651da7..479a9e5ab756 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -963,21 +963,25 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
- * __ptep_set_wrprotect - mark read-only while trasferring potential hardware
+ * __ptep_set_wrprotects - mark read-only while trasferring potential hardware
  * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
  */
-static inline void __ptep_set_wrprotect(struct mm_struct *mm,
-					unsigned long address, pte_t *ptep)
+static inline void __ptep_set_wrprotects(struct mm_struct *mm,
+					unsigned long address, pte_t *ptep,
+					unsigned int nr)
 {
 	pte_t old_pte, pte;
-
-	pte = __ptep_get(ptep);
-	do {
-		old_pte = pte;
-		pte = pte_wrprotect(pte);
-		pte_val(pte) = cmpxchg_relaxed(&pte_val(*ptep),
-					       pte_val(old_pte), pte_val(pte));
-	} while (pte_val(pte) != pte_val(old_pte));
+	unsigned int i;
+
+	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++) {
+		pte = __ptep_get(ptep);
+		do {
+			old_pte = pte;
+			pte = pte_wrprotect(pte);
+			pte_val(pte) = cmpxchg_relaxed(&pte_val(*ptep),
+						pte_val(old_pte), pte_val(pte));
+		} while (pte_val(pte) != pte_val(old_pte));
+	}
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -985,7 +989,7 @@ static inline void __ptep_set_wrprotect(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pmd_t *pmdp)
 {
-	__ptep_set_wrprotect(mm, address, (pte_t *)pmdp);
+	__ptep_set_wrprotects(mm, address, (pte_t *)pmdp, 1);
 }
 
 #define pmdp_establish pmdp_establish
@@ -1134,6 +1138,8 @@ extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
+extern void contpte_set_wrprotects(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, unsigned int nr);
 extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				pte_t entry, int dirty);
@@ -1298,13 +1304,25 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return contpte_ptep_clear_flush_young(vma, addr, ptep);
 }
 
+#define ptep_set_wrprotects ptep_set_wrprotects
+static inline void ptep_set_wrprotects(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, unsigned int nr)
+{
+	if (!contpte_is_enabled(mm))
+		__ptep_set_wrprotects(mm, addr, ptep, nr);
+	else if (nr == 1) {
+		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+		__ptep_set_wrprotects(mm, addr, ptep, 1);
+		contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
+	} else
+		contpte_set_wrprotects(mm, addr, ptep, nr);
+}
+
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
 {
-	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
-	__ptep_set_wrprotect(mm, addr, ptep);
-	contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
+	ptep_set_wrprotects(mm, addr, ptep, 1);
 }
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 0b585d1c4c94..4f666697547d 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -353,6 +353,47 @@ int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 	return young;
 }
 
+void contpte_set_wrprotects(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, unsigned int nr)
+{
+	unsigned long next;
+	unsigned long end = addr + (nr << PAGE_SHIFT);
+
+	do {
+		next = pte_cont_addr_end(addr, end);
+		nr = (next - addr) >> PAGE_SHIFT;
+
+		/*
+		 * If wrprotecting an entire contig range, we can avoid
+		 * unfolding. Just set wrprotect and wait for the later
+		 * mmu_gather flush to invalidate the tlb. Until the flush, the
+		 * page may or may not be wrprotected. After the flush, it is
+		 * guarranteed wrprotected. If its a partial range though, we
+		 * must unfold, because we can't have a case where CONT_PTE is
+		 * set but wrprotect applies to a subset of the PTEs; this would
+		 * cause it to continue to be unpredictable after the flush.
+		 */
+		if (nr != CONT_PTES)
+			contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+
+		__ptep_set_wrprotects(mm, addr, ptep, nr);
+
+		addr = next;
+		ptep += nr;
+
+		/*
+		 * If applying to a partial contig range, the change could have
+		 * made the range foldable. Use the last pte in the range we
+		 * just set for comparison, since contpte_try_fold() only
+		 * triggers when acting on the last pte in the contig range.
+		 */
+		if (nr != CONT_PTES)
+			contpte_try_fold(mm, addr - PAGE_SIZE, ptep - 1,
+					 __ptep_get(ptep - 1));
+
+	} while (addr != end);
+}
+
 int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep,
 					pte_t entry, int dirty)
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 82b2036dbe2f..ecf7bfa761c3 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -511,7 +511,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pte_t pte;
 
 	if (!pte_cont(__ptep_get(ptep))) {
-		__ptep_set_wrprotect(mm, addr, ptep);
+		__ptep_set_wrprotects(mm, addr, ptep, 1);
 		return;
 	}
 
-- 
2.25.1

