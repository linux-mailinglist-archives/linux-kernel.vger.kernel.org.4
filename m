Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE92F73A358
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjFVOmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjFVOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:42:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2DCB1FE4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:42:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CB6C113E;
        Thu, 22 Jun 2023 07:43:17 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC8543F663;
        Thu, 22 Jun 2023 07:42:30 -0700 (PDT)
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
Subject: [PATCH v1 02/14] arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
Date:   Thu, 22 Jun 2023 15:41:57 +0100
Message-Id: <20230622144210.2623299-3-ryan.roberts@arm.com>
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

set_pte_at() is a core macro that forwards to set_ptes() (with nr=1).
Instead of creating a __set_pte_at() internal macro, convert all arch
users to use set_ptes()/__set_ptes() directly, as appropriate. Callers
in hugetlb may benefit from calling __set_ptes() once for their whole
range rather than managing their own loop. This is left for future
improvement.

No behavioural changes intended.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 12 +++++++++---
 arch/arm64/kernel/mte.c          |  2 +-
 arch/arm64/kvm/guest.c           |  2 +-
 arch/arm64/mm/fault.c            |  2 +-
 arch/arm64/mm/hugetlbpage.c      | 10 +++++-----
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7f5ce5687466..84919a3c558e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -356,7 +356,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	__set_pte(ptep, pte);
 }
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+static inline void __set_ptes(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte, unsigned int nr)
 {
 	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
@@ -370,7 +370,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_val(pte) += PAGE_SIZE;
 	}
 }
-#define set_ptes set_ptes
 
 /*
  * Huge pte definitions.
@@ -1067,7 +1066,7 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 #endif /* CONFIG_ARM64_MTE */
 
 /*
- * On AArch64, the cache coherency is handled via the set_pte_at() function.
+ * On AArch64, the cache coherency is handled via the __set_ptes() function.
  */
 static inline void update_mmu_cache_range(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, unsigned int nr)
@@ -1134,6 +1133,13 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	__set_pte(ptep, pte);
 }
 
+#define set_ptes set_ptes
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	__set_ptes(mm, addr, ptep, pte, nr);
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 7e89968bd282..9b248549a020 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -90,7 +90,7 @@ int memcmp_pages(struct page *page1, struct page *page2)
 	/*
 	 * If the page content is identical but at least one of the pages is
 	 * tagged, return non-zero to avoid KSM merging. If only one of the
-	 * pages is tagged, set_pte_at() may zero or change the tags of the
+	 * pages is tagged, __set_ptes() may zero or change the tags of the
 	 * other page via mte_sync_tags().
 	 */
 	if (page_mte_tagged(page1) || page_mte_tagged(page2))
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 20280a5233f6..478df2edcf99 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -1087,7 +1087,7 @@ int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 		} else {
 			/*
 			 * Only locking to serialise with a concurrent
-			 * set_pte_at() in the VMM but still overriding the
+			 * __set_ptes() in the VMM but still overriding the
 			 * tags, hence ignoring the return value.
 			 */
 			try_page_mte_tagging(page);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 6045a5117ac1..d3a64624ed88 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -191,7 +191,7 @@ static void show_pte(unsigned long addr)
  *
  * It needs to cope with hardware update of the accessed/dirty state by other
  * agents in the system and can safely skip the __sync_icache_dcache() call as,
- * like set_pte_at(), the PTE is never changed from no-exec to exec here.
+ * like __set_ptes(), the PTE is never changed from no-exec to exec here.
  *
  * Returns whether or not the PTE actually changed.
  */
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 95364e8bdc19..31a1da655bf1 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -264,12 +264,12 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		ncontig = num_contig_ptes(folio_size(folio), &pgsize);
 
 		for (i = 0; i < ncontig; i++, ptep++)
-			set_pte_at(mm, addr, ptep, pte);
+			__set_ptes(mm, addr, ptep, pte, 1);
 		return;
 	}
 
 	if (!pte_cont(pte)) {
-		set_pte_at(mm, addr, ptep, pte);
+		__set_ptes(mm, addr, ptep, pte, 1);
 		return;
 	}
 
@@ -281,7 +281,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	clear_flush(mm, addr, ptep, pgsize, ncontig);
 
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
+		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
 }
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -496,7 +496,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 	hugeprot = pte_pgprot(pte);
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
+		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
 
 	return 1;
 }
@@ -525,7 +525,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pfn = pte_pfn(pte);
 
 	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
+		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
 }
 
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-- 
2.25.1

