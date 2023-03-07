Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7736AE1E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjCGOMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjCGOKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:10:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B84888A1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC896135E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA955C4339E;
        Tue,  7 Mar 2023 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198118;
        bh=jq0ZfsvwfvGD7dc7+4ei8T6xxeCdjcLuVSzc5ozEYYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/g1FxQvtQ6Djb0efLquHx4sC5zwNZTzw6ha7e7dDSnGZtiJkcdGLhAJOIbO7Udrr
         c/pOatQglTTG4auyFwSaRThUdUosTsqq8d0NXzEt3QV9CzO9jtP37D1/KPzds7wH+X
         iP0lQkhdXjUMc+gIAoZpf0kTBUVYuSr0BYnrH6c2QUDuAl/7jsVa/FpkBUsHMTLxM1
         VuXoIvbr6ldY+JSpVneCzpiOuUWgYh6w2DJ8eLlEmMyTGEe6LsmKBzDyoOSkp9EjIV
         7kIVdgnn0PwRwNNqe9Jz7RuZdjmXLDXFUrz41yln2eVd24ywrvCeY5wWzD1qdtalDJ
         /RcDxpv06whmg==
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
Subject: [PATCH v3 50/60] arm64: mm: Add 5 level paging support to fixmap and swapper handling
Date:   Tue,  7 Mar 2023 15:05:12 +0100
Message-Id: <20230307140522.2311461-51-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6571; i=ardb@kernel.org; h=from:subject; bh=jq0ZfsvwfvGD7dc7+4ei8T6xxeCdjcLuVSzc5ozEYYU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdpUX48+cq3RMuB7/WPMm/4j+p8uWBmeqSBgce7tNIk Um+O+FrRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIG3aG/4UHXR/4de2Ysdhj Btuf1Jipx7veRyn9luW25rl0RXo1635Ghmtid2bd9fz36cClqTu/2B3bu2/eKtOSN4zfXx36c39 ShgMHAA==
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

Add support for using 5 levels of paging in the fixmap, as well as in
the kernel page table handling code which uses fixmaps internally.
This also handles the case where a 5 level build runs on hardware that
only supports 4 levels of paging.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/fixmap.h  |  1 +
 arch/arm64/include/asm/pgtable.h | 45 ++++++++++++--
 arch/arm64/mm/mmu.c              | 64 +++++++++++++++++---
 3 files changed, 96 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 71ed5fdf718bd0fd..8d4ec7bf74afb7a6 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -90,6 +90,7 @@ enum fixed_addresses {
 	FIX_PTE,
 	FIX_PMD,
 	FIX_PUD,
+	FIX_P4D,
 	FIX_PGD,
 
 	__end_of_fixed_addresses
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c667073e3f56755d..a286ecc447d33b24 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -613,12 +613,12 @@ static inline bool pud_table(pud_t pud) { return true; }
 				 PUD_TYPE_TABLE)
 #endif
 
-extern pgd_t init_pg_dir[PTRS_PER_PGD];
+extern pgd_t init_pg_dir[];
 extern pgd_t init_pg_end[];
-extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
-extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
-extern pgd_t reserved_pg_dir[PTRS_PER_PGD];
+extern pgd_t swapper_pg_dir[];
+extern pgd_t idmap_pg_dir[];
+extern pgd_t tramp_pg_dir[];
+extern pgd_t reserved_pg_dir[];
 
 extern void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd);
 
@@ -883,12 +883,47 @@ static inline p4d_t *p4d_offset(pgd_t *pgdp, unsigned long addr)
 	return p4d_offset_lockless(pgdp, READ_ONCE(*pgdp), addr);
 }
 
+static inline p4d_t *p4d_set_fixmap(unsigned long addr)
+{
+	if (!pgtable_l5_enabled())
+		return NULL;
+	return (p4d_t *)set_fixmap_offset(FIX_P4D, addr);
+}
+
+static inline p4d_t *p4d_set_fixmap_offset(pgd_t *pgdp, unsigned long addr)
+{
+	if (!pgtable_l5_enabled())
+		return pgd_to_folded_p4d(pgdp, addr);
+	return p4d_set_fixmap(p4d_offset_phys(pgdp, addr));
+}
+
+static inline void p4d_clear_fixmap(void)
+{
+	if (pgtable_l5_enabled())
+		clear_fixmap(FIX_P4D);
+}
+
+/* use ONLY for statically allocated translation tables */
+static inline p4d_t *p4d_offset_kimg(pgd_t *pgdp, u64 addr)
+{
+	if (!pgtable_l5_enabled())
+		return pgd_to_folded_p4d(pgdp, addr);
+	return (p4d_t *)__phys_to_kimg(p4d_offset_phys(pgdp, addr));
+}
+
 #define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(__pgd_to_phys(pgd)))
 
 #else
 
 static inline bool pgtable_l5_enabled(void) { return false; }
 
+/* Match p4d_offset folding in <asm/generic/pgtable-nop4d.h> */
+#define p4d_set_fixmap(addr)		NULL
+#define p4d_set_fixmap_offset(p4dp, addr)	((p4d_t *)p4dp)
+#define p4d_clear_fixmap()
+
+#define p4d_offset_kimg(dir,addr)	((p4d_t *)dir)
+
 #endif  /* CONFIG_PGTABLE_LEVELS > 4 */
 
 #define pgd_ERROR(e)	\
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 6426df5211456cfe..77cd163375124c6a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -315,15 +315,14 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 	} while (addr = next, addr != end);
 }
 
-static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
+static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 			   phys_addr_t phys, pgprot_t prot,
 			   phys_addr_t (*pgtable_alloc)(int),
 			   int flags)
 {
 	unsigned long next;
-	pud_t *pudp;
-	p4d_t *p4dp = p4d_offset(pgdp, addr);
 	p4d_t p4d = READ_ONCE(*p4dp);
+	pud_t *pudp;
 
 	if (p4d_none(p4d)) {
 		p4dval_t p4dval = P4D_TYPE_TABLE | P4D_TABLE_UXN;
@@ -371,6 +370,46 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	pud_clear_fixmap();
 }
 
+static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
+			   phys_addr_t phys, pgprot_t prot,
+			   phys_addr_t (*pgtable_alloc)(int),
+			   int flags)
+{
+	unsigned long next;
+	pgd_t pgd = READ_ONCE(*pgdp);
+	p4d_t *p4dp;
+
+	if (pgd_none(pgd)) {
+		pgdval_t pgdval = PGD_TYPE_TABLE | PGD_TABLE_UXN;
+		phys_addr_t p4d_phys;
+
+		if (flags & NO_EXEC_MAPPINGS)
+			pgdval |= PGD_TABLE_PXN;
+		BUG_ON(!pgtable_alloc);
+		p4d_phys = pgtable_alloc(P4D_SHIFT);
+		__pgd_populate(pgdp, p4d_phys, pgdval);
+		pgd = READ_ONCE(*pgdp);
+	}
+	BUG_ON(pgd_bad(pgd));
+
+	p4dp = p4d_set_fixmap_offset(pgdp, addr);
+	do {
+		p4d_t old_p4d = READ_ONCE(*p4dp);
+
+		next = p4d_addr_end(addr, end);
+
+		alloc_init_pud(p4dp, addr, next, phys, prot,
+			       pgtable_alloc, flags);
+
+		BUG_ON(p4d_val(old_p4d) != 0 &&
+		       p4d_val(old_p4d) != READ_ONCE(p4d_val(*p4dp)));
+
+		phys += next - addr;
+	} while (p4dp++, addr = next, addr != end);
+
+	p4d_clear_fixmap();
+}
+
 static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 					unsigned long virt, phys_addr_t size,
 					pgprot_t prot,
@@ -393,7 +432,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 
 	do {
 		next = pgd_addr_end(addr, end);
-		alloc_init_pud(pgdp, addr, next, phys, prot, pgtable_alloc,
+		alloc_init_p4d(pgdp, addr, next, phys, prot, pgtable_alloc,
 			       flags);
 		phys += next - addr;
 	} while (pgdp++, addr = next, addr != end);
@@ -1120,10 +1159,19 @@ void vmemmap_free(unsigned long start, unsigned long end,
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
-static inline pud_t *fixmap_pud(unsigned long addr)
+static inline p4d_t *fixmap_p4d(unsigned long addr)
 {
 	pgd_t *pgdp = pgd_offset_k(addr);
-	p4d_t *p4dp = p4d_offset(pgdp, addr);
+	pgd_t pgd = READ_ONCE(*pgdp);
+
+	BUG_ON(pgd_none(pgd) || pgd_bad(pgd));
+
+	return p4d_offset_kimg(pgdp, addr);
+}
+
+static inline pud_t *fixmap_pud(unsigned long addr)
+{
+	p4d_t *p4dp = fixmap_p4d(addr);
 	p4d_t p4d = READ_ONCE(*p4dp);
 
 	BUG_ON(p4d_none(p4d) || p4d_bad(p4d));
@@ -1154,14 +1202,12 @@ static inline pte_t *fixmap_pte(unsigned long addr)
  */
 void __init early_fixmap_init(void)
 {
-	pgd_t *pgdp;
 	p4d_t *p4dp, p4d;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	unsigned long addr = FIXADDR_START;
 
-	pgdp = pgd_offset_k(addr);
-	p4dp = p4d_offset(pgdp, addr);
+	p4dp = fixmap_p4d(addr);
 	p4d = READ_ONCE(*p4dp);
 	if (CONFIG_PGTABLE_LEVELS > 3 &&
 	    !(p4d_none(p4d) || p4d_page_paddr(p4d) == __pa_symbol(bm_pud))) {
-- 
2.39.2

