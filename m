Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABD700ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241621AbjELO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbjELO6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7FF3A86
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54A3561137
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057B2C433EF;
        Fri, 12 May 2023 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683903482;
        bh=TbHgG2w0XhFAPXkR+9W7hs3AnwbEfk/0KY6kqBQIJeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rWaW1yO4zoG2gWhzY8P7BBZ0myq/alPhT7G9vRjXjVAcXidr8fdCS6X5CaHFGusk7
         qjVS7b8XygHKs5JocjZwRQDxE+2oIuGJdZK09eCTMn0jLx8sOjkhFdpD3WL7S+BBgX
         r4z2SQVi2ZV24FFoPCpEtzWv+8VokXA3/LhdoSwVI7mcsZQJ/GkKl2yHLw+2PwlzvI
         8GE3RPwss0CYTl9KkCRlDemA4GHpeMZ15fFn4z7MXRJg1TGizz45LBk1tMwq4mOHkO
         9ILUr0Iz6q6JnHnIL/zxOMu9dQ/j4NYpc9GZAgm4PtOIR5ohWNiccDnmE/1e2KtNht
         3fAZL7Z6pcaJA==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        virtualization@lists.linux-foundation.org, linux@rivosinc.com,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 2/7] riscv: mm: Change attribute from __init to __meminit for page functions
Date:   Fri, 12 May 2023 16:57:32 +0200
Message-Id: <20230512145737.985671-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512145737.985671-1-bjorn@kernel.org>
References: <20230512145737.985671-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Prepare for memory hot add/remove support by changing from __init to
__meminit for the page-table functions that are used by the upcoming
arch specific callbacks.

Changing the __init attribute to __meminit, avoids that the functions
are removed after init. __meminit keeps the functions after init, if
memory hotplugging is enabled for the build.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/mmu.h     |  2 +-
 arch/riscv/include/asm/pgtable.h |  2 +-
 arch/riscv/mm/init.c             | 49 ++++++++++++++------------------
 3 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 0099dc116168..9e5d4f37ba2e 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -22,7 +22,7 @@ typedef struct {
 #endif
 } mm_context_t;
 
-void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
+void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
 			       phys_addr_t sz, pgprot_t prot);
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2258b27173b0..a4cdcb689959 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -147,7 +147,7 @@ struct pt_alloc_ops {
 #endif
 };
 
-extern struct pt_alloc_ops pt_ops __initdata;
+extern struct pt_alloc_ops pt_ops __meminitdata;
 
 #ifdef CONFIG_MMU
 /* Number of PGD entries that a user-mode program can use */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index d2595cc33a1c..e974ff6ef036 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -356,7 +356,7 @@ static void __init setup_bootmem(void)
 }
 
 #ifdef CONFIG_MMU
-struct pt_alloc_ops pt_ops __initdata;
+struct pt_alloc_ops pt_ops __meminitdata;
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
@@ -418,7 +418,7 @@ static inline pte_t *__init get_pte_virt_fixmap(phys_addr_t pa)
 	return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
 }
 
-static inline pte_t *__init get_pte_virt_late(phys_addr_t pa)
+static inline pte_t *__meminit get_pte_virt_late(phys_addr_t pa)
 {
 	return (pte_t *) __va(pa);
 }
@@ -437,7 +437,7 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __init alloc_pte_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
 {
 	unsigned long vaddr;
 
@@ -447,9 +447,8 @@ static phys_addr_t __init alloc_pte_late(uintptr_t va)
 	return __pa(vaddr);
 }
 
-static void __init create_pte_mapping(pte_t *ptep,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_pte_mapping(pte_t *ptep, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+					 pgprot_t prot)
 {
 	uintptr_t pte_idx = pte_index(va);
 
@@ -503,7 +502,7 @@ static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t pa)
 	return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
 }
 
-static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
+static pmd_t *__meminit get_pmd_virt_late(phys_addr_t pa)
 {
 	return (pmd_t *) __va(pa);
 }
@@ -520,7 +519,7 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __init alloc_pmd_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
 {
 	unsigned long vaddr;
 
@@ -530,9 +529,8 @@ static phys_addr_t __init alloc_pmd_late(uintptr_t va)
 	return __pa(vaddr);
 }
 
-static void __init create_pmd_mapping(pmd_t *pmdp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_pmd_mapping(pmd_t *pmdp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+					 pgprot_t prot)
 {
 	pte_t *ptep;
 	phys_addr_t pte_phys;
@@ -568,7 +566,7 @@ static pud_t *__init get_pud_virt_fixmap(phys_addr_t pa)
 	return (pud_t *)set_fixmap_offset(FIX_PUD, pa);
 }
 
-static pud_t *__init get_pud_virt_late(phys_addr_t pa)
+static pud_t *__meminit get_pud_virt_late(phys_addr_t pa)
 {
 	return (pud_t *)__va(pa);
 }
@@ -586,7 +584,7 @@ static phys_addr_t __init alloc_pud_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t alloc_pud_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pud_late(uintptr_t va)
 {
 	unsigned long vaddr;
 
@@ -606,7 +604,7 @@ static p4d_t *__init get_p4d_virt_fixmap(phys_addr_t pa)
 	return (p4d_t *)set_fixmap_offset(FIX_P4D, pa);
 }
 
-static p4d_t *__init get_p4d_virt_late(phys_addr_t pa)
+static p4d_t *__meminit get_p4d_virt_late(phys_addr_t pa)
 {
 	return (p4d_t *)__va(pa);
 }
@@ -624,7 +622,7 @@ static phys_addr_t __init alloc_p4d_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t alloc_p4d_late(uintptr_t va)
+static phys_addr_t __meminit alloc_p4d_late(uintptr_t va)
 {
 	unsigned long vaddr;
 
@@ -633,9 +631,8 @@ static phys_addr_t alloc_p4d_late(uintptr_t va)
 	return __pa(vaddr);
 }
 
-static void __init create_pud_mapping(pud_t *pudp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_pud_mapping(pud_t *pudp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+					 pgprot_t prot)
 {
 	pmd_t *nextp;
 	phys_addr_t next_phys;
@@ -660,9 +657,8 @@ static void __init create_pud_mapping(pud_t *pudp,
 	create_pmd_mapping(nextp, va, pa, sz, prot);
 }
 
-static void __init create_p4d_mapping(p4d_t *p4dp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_p4d_mapping(p4d_t *p4dp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+					 pgprot_t prot)
 {
 	pud_t *nextp;
 	phys_addr_t next_phys;
@@ -718,9 +714,8 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
 #define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot) do {} while(0)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-void __init create_pgd_mapping(pgd_t *pgdp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+				  pgprot_t prot)
 {
 	pgd_next_t *nextp;
 	phys_addr_t next_phys;
@@ -745,7 +740,7 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 	create_pgd_next_mapping(nextp, va, pa, sz, prot);
 }
 
-static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
+static uintptr_t __meminit best_map_size(phys_addr_t base, phys_addr_t size)
 {
 	if (!(base & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
 		return PGDIR_SIZE;
@@ -778,7 +773,7 @@ asmlinkage void __init __copy_data(void)
 #endif
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-static __init pgprot_t pgprot_from_va(uintptr_t va)
+static __meminit pgprot_t pgprot_from_va(uintptr_t va)
 {
 	if (is_va_kernel_text(va))
 		return PAGE_KERNEL_READ_EXEC;
@@ -805,7 +800,7 @@ void mark_rodata_ro(void)
 	debug_checkwx();
 }
 #else
-static __init pgprot_t pgprot_from_va(uintptr_t va)
+static __meminit pgprot_t pgprot_from_va(uintptr_t va)
 {
 	if (IS_ENABLED(CONFIG_64BIT) && !is_kernel_mapping(va))
 		return PAGE_KERNEL;
-- 
2.39.2

