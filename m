Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1A6AE1E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjCGOLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjCGOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:10:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C3B88885
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C35F61454
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C47BC433A4;
        Tue,  7 Mar 2023 14:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198123;
        bh=M+Dxbzwxo1zhfbcCFC0Rc6KRuDeSFFODIUXYwuEc0NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HR0Ne7eLliaReh5F1ElF6ihdhEvIHi6XJT51ROG5g7YmaOMCoRQNnTc/Ht/yWa1Ea
         WtU8h46WTfYbwdXFKA/THdbA5b6azNWHqN1A6polWgXkwc33m+xCuEhDEIg8RhIRCa
         6US23ctHhX4qt+sBavKW18bMbTKXu8c6uHWM1XGBIFQNHkwkl0tBoZYf8nndtEfFLW
         h2DtLgfNCUWACUyXX0WA8GqJ918mrWYp39N7Zczl/vuMoaKfp6zGWCoovNTm3hXGbs
         kjvSM0juOjczrAUcePSXHfakKpmFllB083rDe5OMQEYFKlOr0Ko01PtOyrKnEgAZJG
         YOWvUv/3EOZMw==
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
Subject: [PATCH v3 52/60] arm64: mm: Add support for folding PUDs at runtime
Date:   Tue,  7 Mar 2023 15:05:14 +0100
Message-Id: <20230307140522.2311461-53-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8426; i=ardb@kernel.org; h=from:subject; bh=M+Dxbzwxo1zhfbcCFC0Rc6KRuDeSFFODIUXYwuEc0NQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdpXPjq4MMiSZP7l/JVLq0/rvf+tincVIXayTlHzC/P 7xzUrBoRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIbSzDX/muB7K31SeUe7ef Mk7mf2H9fuvnPVOa/8gxNtxZtCi2+TYjw6GNRYfrlISUlxoVa2rMKJlW72H5asHiOzwcSzlT5IT quQE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support LPA2 on 16k pages in a way that permits non-LPA2
systems to run the same kernel image, we have to be able to fall back to
at most 48 bits of virtual addressing.

Falling back to 48 bits would result in a level 0 with only 2 entries,
which is suboptimal in terms of TLB utilization. So instead, let's fall
back to 47 bits in that case. This means we need to be able to fold PUDs
dynamically, similar to how we fold P4Ds for 48 bit virtual addressing
on LPA2 with 4k pages.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgalloc.h | 12 ++-
 arch/arm64/include/asm/pgtable.h | 87 +++++++++++++++++---
 arch/arm64/include/asm/tlb.h     |  3 +-
 arch/arm64/kernel/cpufeature.c   |  2 +
 arch/arm64/mm/mmu.c              |  2 +-
 arch/arm64/mm/pgd.c              |  2 +
 6 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index cae8c648f4628709..aeba2cf15a253ee1 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -14,6 +14,7 @@
 #include <asm/tlbflush.h>
 
 #define __HAVE_ARCH_PGD_FREE
+#define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
@@ -43,7 +44,8 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 
 static inline void __p4d_populate(p4d_t *p4dp, phys_addr_t pudp, p4dval_t prot)
 {
-	set_p4d(p4dp, __p4d(__phys_to_p4d_val(pudp) | prot));
+	if (pgtable_l4_enabled())
+		set_p4d(p4dp, __p4d(__phys_to_p4d_val(pudp) | prot));
 }
 
 static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4dp, pud_t *pudp)
@@ -53,6 +55,14 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4dp, pud_t *pudp)
 	p4dval |= (mm == &init_mm) ? P4D_TABLE_UXN : P4D_TABLE_PXN;
 	__p4d_populate(p4dp, __pa(pudp), p4dval);
 }
+
+static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	if (!pgtable_l4_enabled())
+		return;
+	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
+	free_page((unsigned long)pud);
+}
 #else
 static inline void __p4d_populate(p4d_t *p4dp, phys_addr_t pudp, p4dval_t prot)
 {
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a286ecc447d33b24..02ba59a8ede7e0fd 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -751,12 +751,27 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
+static __always_inline bool pgtable_l4_enabled(void)
+{
+	if (CONFIG_PGTABLE_LEVELS > 4 || !IS_ENABLED(CONFIG_ARM64_LPA2))
+		return true;
+	if (!alternative_has_feature_likely(ARM64_ALWAYS_BOOT))
+		return vabits_actual == VA_BITS;
+	return alternative_has_feature_unlikely(ARM64_HAS_VA52);
+}
+
+static inline bool mm_pud_folded(const struct mm_struct *mm)
+{
+	return !pgtable_l4_enabled();
+}
+#define mm_pud_folded  mm_pud_folded
+
 #define pud_ERROR(e)	\
 	pr_err("%s:%d: bad pud %016llx.\n", __FILE__, __LINE__, pud_val(e))
 
-#define p4d_none(p4d)		(!p4d_val(p4d))
-#define p4d_bad(p4d)		(!(p4d_val(p4d) & 2))
-#define p4d_present(p4d)	(p4d_val(p4d))
+#define p4d_none(p4d)		(pgtable_l4_enabled() && !p4d_val(p4d))
+#define p4d_bad(p4d)		(pgtable_l4_enabled() && !(p4d_val(p4d) & 2))
+#define p4d_present(p4d)	(!p4d_none(p4d))
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
@@ -772,7 +787,8 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 
 static inline void p4d_clear(p4d_t *p4dp)
 {
-	set_p4d(p4dp, __p4d(0));
+	if (pgtable_l4_enabled())
+		set_p4d(p4dp, __p4d(0));
 }
 
 static inline phys_addr_t p4d_page_paddr(p4d_t p4d)
@@ -780,25 +796,74 @@ static inline phys_addr_t p4d_page_paddr(p4d_t p4d)
 	return __p4d_to_phys(p4d);
 }
 
+#define pud_index(addr)		(((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
+
+static inline pud_t *p4d_to_folded_pud(p4d_t *p4dp, unsigned long addr)
+{
+	return (pud_t *)PTR_ALIGN_DOWN(p4dp, PAGE_SIZE) + pud_index(addr);
+}
+
 static inline pud_t *p4d_pgtable(p4d_t p4d)
 {
 	return (pud_t *)__va(p4d_page_paddr(p4d));
 }
 
-/* Find an entry in the first-level page table. */
-#define pud_offset_phys(dir, addr)	(p4d_page_paddr(READ_ONCE(*(dir))) + pud_index(addr) * sizeof(pud_t))
+static inline phys_addr_t pud_offset_phys(p4d_t *p4dp, unsigned long addr)
+{
+	BUG_ON(!pgtable_l4_enabled());
 
-#define pud_set_fixmap(addr)		((pud_t *)set_fixmap_offset(FIX_PUD, addr))
-#define pud_set_fixmap_offset(p4d, addr)	pud_set_fixmap(pud_offset_phys(p4d, addr))
-#define pud_clear_fixmap()		clear_fixmap(FIX_PUD)
+	return p4d_page_paddr(READ_ONCE(*p4dp)) + pud_index(addr) * sizeof(pud_t);
+}
 
-#define p4d_page(p4d)		pfn_to_page(__phys_to_pfn(__p4d_to_phys(p4d)))
+static inline
+pud_t *pud_offset_lockless(p4d_t *p4dp, p4d_t p4d, unsigned long addr)
+{
+	if (!pgtable_l4_enabled())
+		return p4d_to_folded_pud(p4dp, addr);
+	return (pud_t *)__va(p4d_page_paddr(p4d)) + pud_index(addr);
+}
+#define pud_offset_lockless pud_offset_lockless
+
+static inline pud_t *pud_offset(p4d_t *p4dp, unsigned long addr)
+{
+	return pud_offset_lockless(p4dp, READ_ONCE(*p4dp), addr);
+}
+#define pud_offset	pud_offset
+
+static inline pud_t *pud_set_fixmap(unsigned long addr)
+{
+	if (!pgtable_l4_enabled())
+		return NULL;
+	return (pud_t *)set_fixmap_offset(FIX_PUD, addr);
+}
+
+static inline pud_t *pud_set_fixmap_offset(p4d_t *p4dp, unsigned long addr)
+{
+	if (!pgtable_l4_enabled())
+		return p4d_to_folded_pud(p4dp, addr);
+	return pud_set_fixmap(pud_offset_phys(p4dp, addr));
+}
+
+static inline void pud_clear_fixmap(void)
+{
+	if (pgtable_l4_enabled())
+		clear_fixmap(FIX_PUD);
+}
 
 /* use ONLY for statically allocated translation tables */
-#define pud_offset_kimg(dir,addr)	((pud_t *)__phys_to_kimg(pud_offset_phys((dir), (addr))))
+static inline pud_t *pud_offset_kimg(p4d_t *p4dp, u64 addr)
+{
+	if (!pgtable_l4_enabled())
+		return p4d_to_folded_pud(p4dp, addr);
+	return (pud_t *)__phys_to_kimg(pud_offset_phys(p4dp, addr));
+}
+
+#define p4d_page(p4d)		pfn_to_page(__phys_to_pfn(__p4d_to_phys(p4d)))
 
 #else
 
+static inline bool pgtable_l4_enabled(void) { return false; }
+
 #define p4d_page_paddr(p4d)	({ BUILD_BUG(); 0;})
 
 /* Match pud_offset folding in <asm/generic/pgtable-nopud.h> */
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index c995d1f4594f6692..a23d33b6b56b8c35 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -94,7 +94,8 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
-	tlb_remove_table(tlb, virt_to_page(pudp));
+	if (pgtable_l4_enabled())
+		tlb_remove_table(tlb, virt_to_page(pudp));
 }
 #endif
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b0fee11886e54ca2..62f6d397f27b07c0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1731,6 +1731,8 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 
 	if (levels == 5 && !pgtable_l5_enabled())
 		levels = 4;
+	else if (levels == 4 && !pgtable_l4_enabled())
+		levels = 3;
 
 	if (__this_cpu_read(this_cpu_vector) == vectors) {
 		const char *v = arm64_get_bp_hardening_vector(EL1_VECTOR_KPTI);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 77cd163375124c6a..955c7c3341fbc9c2 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1043,7 +1043,7 @@ static void free_empty_pud_table(p4d_t *p4dp, unsigned long addr,
 		free_empty_pmd_table(pudp, addr, next, floor, ceiling);
 	} while (addr = next, addr < end);
 
-	if (CONFIG_PGTABLE_LEVELS <= 3)
+	if (!pgtable_l4_enabled())
 		return;
 
 	if (!pgtable_range_aligned(start, end, floor, ceiling, P4D_MASK))
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 3c4f8a279d2bc76a..0c501cabc23846c4 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -21,6 +21,8 @@ static bool pgdir_is_page_size(void)
 {
 	if (PGD_SIZE == PAGE_SIZE)
 		return true;
+	if (CONFIG_PGTABLE_LEVELS == 4)
+		return !pgtable_l4_enabled();
 	if (CONFIG_PGTABLE_LEVELS == 5)
 		return !pgtable_l5_enabled();
 	return false;
-- 
2.39.2

