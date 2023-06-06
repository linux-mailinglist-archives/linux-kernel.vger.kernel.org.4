Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D6724398
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbjFFNF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbjFFNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:04:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A2610D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:04:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30af86a966eso4980587f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1686056688; x=1688648688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3haPEvDRoJ3tYhZAI4EXu9621m3NDLWoNUUl1GQmAY=;
        b=ASVrj5tMeWc+pwsvm4or8wSinHevJXpf9zBAaY3nlBPaltMhGU8g8v+Qoi55ScCaq7
         EziiB7U+WipxI+A+Z9/a4P8uc0gZM+tTwg4wbaKS4BXAQX1Y03rXcqGdyEdacC8w4wOX
         q2YNKrQHe7U5Tj1Bd24f0d0XVK5oa6ICWf4TQgU+R5YuddWcS7srfESdZCYc3e/rVvFB
         HFaAIql8fkGVInDqTLvNsXhiS18OxJgi1Ev7IdlrIZYswaU1DnVBvD05zU1QDEEE1KBw
         npDchwcbE2f8X2HCYBOsHNJ2yYlpDSOVWyJJXVYKmVe1uaXj4zZBlGg9XKdyOs/UfNuE
         9v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056688; x=1688648688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3haPEvDRoJ3tYhZAI4EXu9621m3NDLWoNUUl1GQmAY=;
        b=KW57eK/0kTQMbsVbhDsRStpwc4aQ0x1ibgakvsmM/iNPfv/mKnccyK/mkgFQb9sTMZ
         Lt+pzhDMgoP1fSaMghe1wqvKmi5hzNXsRAgTkqOP7AJ62A7/7OGkQKW13APYCXEroilD
         sLiIyejZz9CZjvLDCSP37sNlZCo95O/PX1fyzRVzC7cl50pPO1QOCrWzasGoPHKUhalV
         0Xdv7pgFl1G0l9w0X5lUaQThkJpgG7ueBg/zNU9AOUPvW7R2YaHXhb6eyHcRlN4hUgBb
         U3JDDNedhOlCSCxyl9K+nlllw1nyktoKiiWvwcrZtkynspBG0BcvDMjyKB9cUg5I8cs3
         4F8Q==
X-Gm-Message-State: AC+VfDxjkkzugbV0m0Ha5Phwdx1E9Q2pg/Z8OVKKA1qN1xs+T+uueem5
        R8FzmhpD5e6JTXGGq20bk/ZG7A==
X-Google-Smtp-Source: ACHHUZ41eQHOSf60ttSIG7aeqqEmChe7rIdpPtORMxGh2QNrT3wWwejnBIF2V8o28qc/QUTtCa9pXg==
X-Received: by 2002:adf:fac2:0:b0:30a:e097:7b5a with SMTP id a2-20020adffac2000000b0030ae0977b5amr1469605wrs.36.1686056688406;
        Tue, 06 Jun 2023 06:04:48 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id h9-20020a056000000900b002f9e04459desm12759236wrx.109.2023.06.06.06.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:04:48 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        kasan-dev@googlegroups.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     syzbot+a74d57bddabbedd75135@syzkaller.appspotmail.com
Subject: [PATCH] riscv: Fix kfence now that the linear mapping can be backed by PUD/P4D/PGD
Date:   Tue,  6 Jun 2023 15:04:44 +0200
Message-Id: <20230606130444.25090-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V Kfence implementation used to rely on the fact the linear mapping
was backed by at most PMD hugepages, which is not true anymore since
commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear
mapping").

Instead of splitting PUD/P4D/PGD mappings afterwards, directly map the
kfence pool region using PTE mappings by allocating this region before
setup_vm_final().

Reported-by: syzbot+a74d57bddabbedd75135@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a74d57bddabbedd75135
Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/kfence.h | 33 -------------------------------
 arch/riscv/mm/init.c            | 35 ++++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
index d887a54042aa..0bbffd528096 100644
--- a/arch/riscv/include/asm/kfence.h
+++ b/arch/riscv/include/asm/kfence.h
@@ -8,41 +8,8 @@
 #include <asm-generic/pgalloc.h>
 #include <asm/pgtable.h>
 
-static inline int split_pmd_page(unsigned long addr)
-{
-	int i;
-	unsigned long pfn = PFN_DOWN(__pa((addr & PMD_MASK)));
-	pmd_t *pmd = pmd_off_k(addr);
-	pte_t *pte = pte_alloc_one_kernel(&init_mm);
-
-	if (!pte)
-		return -ENOMEM;
-
-	for (i = 0; i < PTRS_PER_PTE; i++)
-		set_pte(pte + i, pfn_pte(pfn + i, PAGE_KERNEL));
-	set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(pte)), PAGE_TABLE));
-
-	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
-	return 0;
-}
-
 static inline bool arch_kfence_init_pool(void)
 {
-	int ret;
-	unsigned long addr;
-	pmd_t *pmd;
-
-	for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
-	     addr += PAGE_SIZE) {
-		pmd = pmd_off_k(addr);
-
-		if (pmd_leaf(*pmd)) {
-			ret = split_pmd_page(addr);
-			if (ret)
-				return false;
-		}
-	}
-
 	return true;
 }
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 747e5b1ef02d..d42ea31c7de0 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -23,6 +23,7 @@
 #ifdef CONFIG_RELOCATABLE
 #include <linux/elf.h>
 #endif
+#include <linux/kfence.h>
 
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
@@ -1167,14 +1168,16 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 }
 
 static void __init create_linear_mapping_range(phys_addr_t start,
-					       phys_addr_t end)
+					       phys_addr_t end,
+					       uintptr_t fixed_map_size)
 {
 	phys_addr_t pa;
 	uintptr_t va, map_size;
 
 	for (pa = start; pa < end; pa += map_size) {
 		va = (uintptr_t)__va(pa);
-		map_size = best_map_size(pa, end - pa);
+		map_size = fixed_map_size ? fixed_map_size :
+					    best_map_size(pa, end - pa);
 
 		create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
 				   pgprot_from_va(va));
@@ -1184,6 +1187,7 @@ static void __init create_linear_mapping_range(phys_addr_t start,
 static void __init create_linear_mapping_page_table(void)
 {
 	phys_addr_t start, end;
+	phys_addr_t kfence_pool __maybe_unused;
 	u64 i;
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
@@ -1197,6 +1201,19 @@ static void __init create_linear_mapping_page_table(void)
 	memblock_mark_nomap(krodata_start, krodata_size);
 #endif
 
+#ifdef CONFIG_KFENCE
+	/*
+	 *  kfence pool must be backed by PAGE_SIZE mappings, so allocate it
+	 *  before we setup the linear mapping so that we avoid using hugepages
+	 *  for this region.
+	 */
+	kfence_pool = memblock_phys_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
+	BUG_ON(!kfence_pool);
+
+	memblock_mark_nomap(kfence_pool, KFENCE_POOL_SIZE);
+	__kfence_pool = __va(kfence_pool);
+#endif
+
 	/* Map all memory banks in the linear mapping */
 	for_each_mem_range(i, &start, &end) {
 		if (start >= end)
@@ -1207,17 +1224,25 @@ static void __init create_linear_mapping_page_table(void)
 		if (end >= __pa(PAGE_OFFSET) + memory_limit)
 			end = __pa(PAGE_OFFSET) + memory_limit;
 
-		create_linear_mapping_range(start, end);
+		create_linear_mapping_range(start, end, 0);
 	}
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-	create_linear_mapping_range(ktext_start, ktext_start + ktext_size);
+	create_linear_mapping_range(ktext_start, ktext_start + ktext_size, 0);
 	create_linear_mapping_range(krodata_start,
-				    krodata_start + krodata_size);
+				    krodata_start + krodata_size, 0);
 
 	memblock_clear_nomap(ktext_start,  ktext_size);
 	memblock_clear_nomap(krodata_start, krodata_size);
 #endif
+
+#ifdef CONFIG_KFENCE
+	create_linear_mapping_range(kfence_pool,
+				    kfence_pool + KFENCE_POOL_SIZE,
+				    PAGE_SIZE);
+
+	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
+#endif
 }
 
 static void __init setup_vm_final(void)
-- 
2.39.2

