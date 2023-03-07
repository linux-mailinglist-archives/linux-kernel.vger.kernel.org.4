Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1B6AE1F0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCGONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjCGOMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:12:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207388E3DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 178D46143A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87415C4339E;
        Tue,  7 Mar 2023 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198111;
        bh=f14g6En1j1H8/46XCGRBb0cJRRltFQikhUYuv4JwJX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7NvPlCJVfkdnM7hIujijRqq8necan7cqiSKanTUuwHNgfSn56P8MSrXXN62bzK30
         yP/lIX90qRW72tlCLF6vCMsRhvOWoSnZiAWgc+54+dJZyfINVswgh9fIfq1R5gtA8j
         fE6LKADpyF3fkc7qcCBUj4azRwnw3xx+6IB9XJJKSfEaj7YB5KU/UPUigmNxPrrcLd
         UZtqncpzet1umF3S9UjyK7MrQtxZ34sSFCfpZlzqZ6nonEgVDyxS0A4DHTvnrtx7+G
         tu5mZyAwgbY4D7VjJ+RcqFZ8LLdTPoWw6cLzjiUB3CzsCAfJlGPWOB+hK4S4kekLrH
         EuVQSZ0qO20FA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 47/60] arm64: mm: Add definitions to support 5 levels of paging
Date:   Tue,  7 Mar 2023 15:05:09 +0100
Message-Id: <20230307140522.2311461-48-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10817; i=ardb@kernel.org; h=from:subject; bh=f14g6En1j1H8/46XCGRBb0cJRRltFQikhUYuv4JwJX0=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdper8epZzvExqYtqBjLfNXxrGOf29eOxxYI5F3Zkua 0PB5EUdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCL2xxj+8KhISm1y8XLzX5S2 7vvdmp51mrbbgxj7zA78S/p024GZjeGfytG7n/iOq4T5f7bUb9+402/zdkPf0Mg7tn1PH98MXZT ACAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required types and descriptor accessors to support 5 levels of
paging in the common code. This is one of the prerequisites for
supporting 52-bit virtual addressing with 4k pages.

Note that this does not cover the code that handles kernel mappings or
the fixmap.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgalloc.h       | 41 ++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h | 22 +++++-
 arch/arm64/include/asm/pgtable-types.h |  6 ++
 arch/arm64/include/asm/pgtable.h       | 82 +++++++++++++++++++-
 arch/arm64/mm/mmu.c                    | 31 +++++++-
 arch/arm64/mm/pgd.c                    | 15 +++-
 6 files changed, 188 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 237224484d0f6f11..cae8c648f4628709 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -60,6 +60,47 @@ static inline void __p4d_populate(p4d_t *p4dp, phys_addr_t pudp, p4dval_t prot)
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
 
+#if CONFIG_PGTABLE_LEVELS > 4
+
+static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
+{
+	if (pgtable_l5_enabled())
+		set_pgd(pgdp, __pgd(__phys_to_pgd_val(p4dp) | prot));
+}
+
+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
+{
+	pgdval_t pgdval = PGD_TYPE_TABLE;
+
+	pgdval |= (mm == &init_mm) ? PGD_TABLE_UXN : PGD_TABLE_PXN;
+	__pgd_populate(pgdp, __pa(p4dp), pgdval);
+}
+
+static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	gfp_t gfp = GFP_PGTABLE_USER;
+
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	return (p4d_t *)get_zeroed_page(gfp);
+}
+
+static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
+{
+	if (!pgtable_l5_enabled())
+		return;
+	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
+	free_page((unsigned long)p4d);
+}
+
+#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
+#else
+static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
+{
+	BUILD_BUG();
+}
+#endif	/* CONFIG_PGTABLE_LEVELS > 4 */
+
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgdp);
 
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index b91fe4781b066d54..b364b02e696b8172 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -26,10 +26,10 @@
 #define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))
 
 /*
- * Size mapped by an entry at level n ( 0 <= n <= 3)
+ * Size mapped by an entry at level n ( -1 <= n <= 3)
  * We map (PAGE_SHIFT - 3) at all translation levels and PAGE_SHIFT bits
  * in the final page. The maximum number of translation levels supported by
- * the architecture is 4. Hence, starting at level n, we have further
+ * the architecture is 5. Hence, starting at level n, we have further
  * ((4 - n) - 1) levels of translation excluding the offset within the page.
  * So, the total number of bits mapped by an entry at level n is :
  *
@@ -62,9 +62,16 @@
 #define PTRS_PER_PUD		(1 << (PAGE_SHIFT - 3))
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+#define P4D_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(0)
+#define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
+#define P4D_MASK		(~(P4D_SIZE-1))
+#define PTRS_PER_P4D		(1 << (PAGE_SHIFT - 3))
+#endif
+
 /*
  * PGDIR_SHIFT determines the size a top-level page table entry can map
- * (depending on the configuration, this level can be 0, 1 or 2).
+ * (depending on the configuration, this level can be -1, 0, 1 or 2).
  */
 #define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - CONFIG_PGTABLE_LEVELS)
 #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
@@ -87,6 +94,15 @@
 /*
  * Hardware page table definitions.
  *
+ * Level -1 descriptor (PGD).
+ */
+#define PGD_TYPE_TABLE		(_AT(pgdval_t, 3) << 0)
+#define PGD_TABLE_BIT		(_AT(pgdval_t, 1) << 1)
+#define PGD_TYPE_MASK		(_AT(pgdval_t, 3) << 0)
+#define PGD_TABLE_PXN		(_AT(pgdval_t, 1) << 59)
+#define PGD_TABLE_UXN		(_AT(pgdval_t, 1) << 60)
+
+/*
  * Level 0 descriptor (P4D).
  */
 #define P4D_TYPE_TABLE		(_AT(p4dval_t, 3) << 0)
diff --git a/arch/arm64/include/asm/pgtable-types.h b/arch/arm64/include/asm/pgtable-types.h
index b8f158ae25273679..6d6d4065b0cb4ed1 100644
--- a/arch/arm64/include/asm/pgtable-types.h
+++ b/arch/arm64/include/asm/pgtable-types.h
@@ -36,6 +36,12 @@ typedef struct { pudval_t pud; } pud_t;
 #define __pud(x)	((pud_t) { (x) } )
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+typedef struct { p4dval_t p4d; } p4d_t;
+#define p4d_val(x)	((x).p4d)
+#define __p4d(x)	((p4d_t) { (x) } )
+#endif
+
 typedef struct { pgdval_t pgd; } pgd_t;
 #define pgd_val(x)	((x).pgd)
 #define __pgd(x)	((pgd_t) { (x) } )
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c8666d5c31fd1e52..c667073e3f56755d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -800,7 +800,6 @@ static inline pud_t *p4d_pgtable(p4d_t p4d)
 #else
 
 #define p4d_page_paddr(p4d)	({ BUILD_BUG(); 0;})
-#define pgd_page_paddr(pgd)	({ BUILD_BUG(); 0;})
 
 /* Match pud_offset folding in <asm/generic/pgtable-nopud.h> */
 #define pud_set_fixmap(addr)		NULL
@@ -811,6 +810,87 @@ static inline pud_t *p4d_pgtable(p4d_t p4d)
 
 #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
 
+#if CONFIG_PGTABLE_LEVELS > 4
+
+static __always_inline bool pgtable_l5_enabled(void)
+{
+	if (!alternative_has_feature_likely(ARM64_ALWAYS_BOOT))
+		return vabits_actual == VA_BITS;
+	return alternative_has_feature_unlikely(ARM64_HAS_VA52);
+}
+
+static inline bool mm_p4d_folded(const struct mm_struct *mm)
+{
+	return !pgtable_l5_enabled();
+}
+#define mm_p4d_folded  mm_p4d_folded
+
+#define p4d_ERROR(e)	\
+	pr_err("%s:%d: bad p4d %016llx.\n", __FILE__, __LINE__, p4d_val(e))
+
+#define pgd_none(pgd)		(pgtable_l5_enabled() && !pgd_val(pgd))
+#define pgd_bad(pgd)		(pgtable_l5_enabled() && !(pgd_val(pgd) & 2))
+#define pgd_present(pgd)	(!pgd_none(pgd))
+
+static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
+{
+	if (in_swapper_pgdir(pgdp)) {
+		set_swapper_pgd(pgdp, __pgd(pgd_val(pgd)));
+		return;
+	}
+
+	WRITE_ONCE(*pgdp, pgd);
+	dsb(ishst);
+	isb();
+}
+
+static inline void pgd_clear(pgd_t *pgdp)
+{
+	if (pgtable_l5_enabled())
+		set_pgd(pgdp, __pgd(0));
+}
+
+static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
+{
+	return __pgd_to_phys(pgd);
+}
+
+#define p4d_index(addr)		(((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
+
+static inline p4d_t *pgd_to_folded_p4d(pgd_t *pgdp, unsigned long addr)
+{
+	return (p4d_t *)PTR_ALIGN_DOWN(pgdp, PAGE_SIZE) + p4d_index(addr);
+}
+
+static inline phys_addr_t p4d_offset_phys(pgd_t *pgdp, unsigned long addr)
+{
+	BUG_ON(!pgtable_l5_enabled());
+
+	return pgd_page_paddr(READ_ONCE(*pgdp)) + p4d_index(addr) * sizeof(p4d_t);
+}
+
+static inline
+p4d_t *p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
+{
+	if (!pgtable_l5_enabled())
+		return pgd_to_folded_p4d(pgdp, addr);
+	return (p4d_t *)__va(pgd_page_paddr(pgd)) + p4d_index(addr);
+}
+#define p4d_offset_lockless p4d_offset_lockless
+
+static inline p4d_t *p4d_offset(pgd_t *pgdp, unsigned long addr)
+{
+	return p4d_offset_lockless(pgdp, READ_ONCE(*pgdp), addr);
+}
+
+#define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(__pgd_to_phys(pgd)))
+
+#else
+
+static inline bool pgtable_l5_enabled(void) { return false; }
+
+#endif  /* CONFIG_PGTABLE_LEVELS > 4 */
+
 #define pgd_ERROR(e)	\
 	pr_err("%s:%d: bad pgd %016llx.\n", __FILE__, __LINE__, pgd_val(e))
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 914745697fb8b30c..a16bcfba2e500600 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1003,7 +1003,7 @@ static void free_empty_pud_table(p4d_t *p4dp, unsigned long addr,
 	if (CONFIG_PGTABLE_LEVELS <= 3)
 		return;
 
-	if (!pgtable_range_aligned(start, end, floor, ceiling, PGDIR_MASK))
+	if (!pgtable_range_aligned(start, end, floor, ceiling, P4D_MASK))
 		return;
 
 	/*
@@ -1026,8 +1026,8 @@ static void free_empty_p4d_table(pgd_t *pgdp, unsigned long addr,
 				 unsigned long end, unsigned long floor,
 				 unsigned long ceiling)
 {
-	unsigned long next;
 	p4d_t *p4dp, p4d;
+	unsigned long i, next, start = addr;
 
 	do {
 		next = p4d_addr_end(addr, end);
@@ -1039,6 +1039,27 @@ static void free_empty_p4d_table(pgd_t *pgdp, unsigned long addr,
 		WARN_ON(!p4d_present(p4d));
 		free_empty_pud_table(p4dp, addr, next, floor, ceiling);
 	} while (addr = next, addr < end);
+
+	if (!pgtable_l5_enabled())
+		return;
+
+	if (!pgtable_range_aligned(start, end, floor, ceiling, PGDIR_MASK))
+		return;
+
+	/*
+	 * Check whether we can free the p4d page if the rest of the
+	 * entries are empty. Overlap with other regions have been
+	 * handled by the floor/ceiling check.
+	 */
+	p4dp = p4d_offset(pgdp, 0UL);
+	for (i = 0; i < PTRS_PER_P4D; i++) {
+		if (!p4d_none(READ_ONCE(p4dp[i])))
+			return;
+	}
+
+	pgd_clear(pgdp);
+	__flush_tlb_kernel_pgtable(start);
+	free_hotplug_pgtable_page(virt_to_page(p4dp));
 }
 
 static void free_empty_tables(unsigned long addr, unsigned long end,
@@ -1283,6 +1304,12 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 	return 1;
 }
 
+#ifndef __PAGETABLE_P4D_FOLDED
+void p4d_clear_huge(p4d_t *p4dp)
+{
+}
+#endif
+
 int pud_clear_huge(pud_t *pudp)
 {
 	if (!pud_sect(READ_ONCE(*pudp)))
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 4a64089e5771c1e2..3c4f8a279d2bc76a 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -17,11 +17,20 @@
 
 static struct kmem_cache *pgd_cache __ro_after_init;
 
+static bool pgdir_is_page_size(void)
+{
+	if (PGD_SIZE == PAGE_SIZE)
+		return true;
+	if (CONFIG_PGTABLE_LEVELS == 5)
+		return !pgtable_l5_enabled();
+	return false;
+}
+
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	gfp_t gfp = GFP_PGTABLE_USER;
 
-	if (PGD_SIZE == PAGE_SIZE)
+	if (pgdir_is_page_size())
 		return (pgd_t *)__get_free_page(gfp);
 	else
 		return kmem_cache_alloc(pgd_cache, gfp);
@@ -29,7 +38,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	if (PGD_SIZE == PAGE_SIZE)
+	if (pgdir_is_page_size())
 		free_page((unsigned long)pgd);
 	else
 		kmem_cache_free(pgd_cache, pgd);
@@ -37,7 +46,7 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 void __init pgtable_cache_init(void)
 {
-	if (PGD_SIZE == PAGE_SIZE)
+	if (pgdir_is_page_size())
 		return;
 
 #ifdef CONFIG_ARM64_PA_BITS_52
-- 
2.39.2

