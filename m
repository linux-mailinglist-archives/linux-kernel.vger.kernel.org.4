Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25965689146
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjBCHxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjBCHxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:53:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8A288CE7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:53:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u10so145756wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 23:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsDDO4uellZf0C+juEHPa8tYsGopFAarZz2ZBHCW4I4=;
        b=I53rM8yLqYDNmQibTFQjsgss7KgXNYwWbK/iJxYtuz5pNX4ze8W726qKpAJMR7NRX3
         C2duUmm2BcS6urEtVHOx/mTQ/xjfkGRD2YRirvwfx/E1xsFt94xPJnJjZYSogiyANv0X
         GsIjuFe+pAERItgOlbVguFZxE2XtJTnV6KOVr+U0Bu6qPBjBepeGxlrHpl74yK6JvhtB
         nUu8xEv1MgIIpUC/8EOWfAIf+5jjJb5+73O/X/Grbuc7Ig4Q0nsL601LAgWsIxvLA8oY
         ekrPDbPSS+WIvhG3NOIg/nRqb31wM6RD53lfTWeMcY+H9o/0DOgY/kYemVRhPIgABWV1
         ycCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsDDO4uellZf0C+juEHPa8tYsGopFAarZz2ZBHCW4I4=;
        b=OHBc19JNMCtc2y686TcBy0icn8YNxV1aEJeqzhg0n9d7WlkAHlGvwj1U+KIeh0rtxs
         2lXAdlLM49U36nLq1dFzFp2sg7bWlEpWQVdfUGwJMiGSPHIujFHcnXNMOs/gNJUzZ/lE
         mlcmP3r3UQ4mb3Qf/OWB0q1zg/bDF+ZVIrQWQsZYRH7H4XtGjeesNgrRx/RcNZOmAqXF
         tB7ageEbxOR0UWc1FxYQYIDuqnHBnPIJh60A0Tde5KwiS0H8j8DC74B3x58Vacvk6iaq
         Z83Rt7ev4S5OxHWxU4M+OM0P6i2L4UEEi5LfQf/NSyBG0gSAeI8pmzFydtkCzEuUmga7
         eu4A==
X-Gm-Message-State: AO0yUKWgXY3/uLviLX3Ey56GdzDAKIxcm5REa5M781WkyGNPpztX5005
        p8cOf6JNHO5I56s8b7AGOPOtsA==
X-Google-Smtp-Source: AK7set8lNOH+sUU/3Y2BVBQF8aAnuwMinRAie2cuYMItQluN7HU7JpW92M1G2IWw83JHg6Sgetl5AQ==
X-Received: by 2002:a05:600c:4f10:b0:3dc:58b9:83f7 with SMTP id l16-20020a05600c4f1000b003dc58b983f7mr8783023wmq.35.1675410816466;
        Thu, 02 Feb 2023 23:53:36 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id az24-20020a05600c601800b003dc4baaedd3sm7258082wmb.37.2023.02.02.23.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:53:36 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 1/6] riscv: Split early and final KASAN population functions
Date:   Fri,  3 Feb 2023 08:52:27 +0100
Message-Id: <20230203075232.274282-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203075232.274282-1-alexghiti@rivosinc.com>
References: <20230203075232.274282-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preliminary work that allows to make the code more
understandable.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/kasan_init.c | 185 +++++++++++++++++++++++--------------
 1 file changed, 116 insertions(+), 69 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index e1226709490f..2a48eba6bd08 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -95,23 +95,13 @@ static void __init kasan_populate_pmd(pud_t *pud, unsigned long vaddr, unsigned
 }
 
 static void __init kasan_populate_pud(pgd_t *pgd,
-				      unsigned long vaddr, unsigned long end,
-				      bool early)
+				      unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	pud_t *pudp, *base_pud;
 	unsigned long next;
 
-	if (early) {
-		/*
-		 * We can't use pgd_page_vaddr here as it would return a linear
-		 * mapping address but it is not mapped yet, but when populating
-		 * early_pg_dir, we need the physical address and when populating
-		 * swapper_pg_dir, we need the kernel virtual address so use
-		 * pt_ops facility.
-		 */
-		base_pud = pt_ops.get_pud_virt(pfn_to_phys(_pgd_pfn(*pgd)));
-	} else if (pgd_none(*pgd)) {
+	if (pgd_none(*pgd)) {
 		base_pud = memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_SIZE);
 		memcpy(base_pud, (void *)kasan_early_shadow_pud,
 			sizeof(pud_t) * PTRS_PER_PUD);
@@ -130,16 +120,10 @@ static void __init kasan_populate_pud(pgd_t *pgd,
 		next = pud_addr_end(vaddr, end);
 
 		if (pud_none(*pudp) && IS_ALIGNED(vaddr, PUD_SIZE) && (next - vaddr) >= PUD_SIZE) {
-			if (early) {
-				phys_addr = __pa(((uintptr_t)kasan_early_shadow_pmd));
-				set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_TABLE));
+			phys_addr = memblock_phys_alloc(PUD_SIZE, PUD_SIZE);
+			if (phys_addr) {
+				set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_KERNEL));
 				continue;
-			} else {
-				phys_addr = memblock_phys_alloc(PUD_SIZE, PUD_SIZE);
-				if (phys_addr) {
-					set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_KERNEL));
-					continue;
-				}
 			}
 		}
 
@@ -152,34 +136,21 @@ static void __init kasan_populate_pud(pgd_t *pgd,
 	 * it entirely, memblock could allocate a page at a physical address
 	 * where KASAN is not populated yet and then we'd get a page fault.
 	 */
-	if (!early)
-		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pud)), PAGE_TABLE));
+	set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pud)), PAGE_TABLE));
 }
 
 static void __init kasan_populate_p4d(pgd_t *pgd,
-				      unsigned long vaddr, unsigned long end,
-				      bool early)
+				      unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	p4d_t *p4dp, *base_p4d;
 	unsigned long next;
 
-	if (early) {
-		/*
-		 * We can't use pgd_page_vaddr here as it would return a linear
-		 * mapping address but it is not mapped yet, but when populating
-		 * early_pg_dir, we need the physical address and when populating
-		 * swapper_pg_dir, we need the kernel virtual address so use
-		 * pt_ops facility.
-		 */
-		base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pgd)));
-	} else {
-		base_p4d = (p4d_t *)pgd_page_vaddr(*pgd);
-		if (base_p4d == lm_alias(kasan_early_shadow_p4d)) {
-			base_p4d = memblock_alloc(PTRS_PER_PUD * sizeof(p4d_t), PAGE_SIZE);
-			memcpy(base_p4d, (void *)kasan_early_shadow_p4d,
-				sizeof(p4d_t) * PTRS_PER_P4D);
-		}
+	base_p4d = (p4d_t *)pgd_page_vaddr(*pgd);
+	if (base_p4d == lm_alias(kasan_early_shadow_p4d)) {
+		base_p4d = memblock_alloc(PTRS_PER_PUD * sizeof(p4d_t), PAGE_SIZE);
+		memcpy(base_p4d, (void *)kasan_early_shadow_p4d,
+		       sizeof(p4d_t) * PTRS_PER_P4D);
 	}
 
 	p4dp = base_p4d + p4d_index(vaddr);
@@ -188,20 +159,14 @@ static void __init kasan_populate_p4d(pgd_t *pgd,
 		next = p4d_addr_end(vaddr, end);
 
 		if (p4d_none(*p4dp) && IS_ALIGNED(vaddr, P4D_SIZE) && (next - vaddr) >= P4D_SIZE) {
-			if (early) {
-				phys_addr = __pa(((uintptr_t)kasan_early_shadow_pud));
-				set_p4d(p4dp, pfn_p4d(PFN_DOWN(phys_addr), PAGE_TABLE));
+			phys_addr = memblock_phys_alloc(P4D_SIZE, P4D_SIZE);
+			if (phys_addr) {
+				set_p4d(p4dp, pfn_p4d(PFN_DOWN(phys_addr), PAGE_KERNEL));
 				continue;
-			} else {
-				phys_addr = memblock_phys_alloc(P4D_SIZE, P4D_SIZE);
-				if (phys_addr) {
-					set_p4d(p4dp, pfn_p4d(PFN_DOWN(phys_addr), PAGE_KERNEL));
-					continue;
-				}
 			}
 		}
 
-		kasan_populate_pud((pgd_t *)p4dp, vaddr, next, early);
+		kasan_populate_pud((pgd_t *)p4dp, vaddr, next);
 	} while (p4dp++, vaddr = next, vaddr != end);
 
 	/*
@@ -210,8 +175,7 @@ static void __init kasan_populate_p4d(pgd_t *pgd,
 	 * it entirely, memblock could allocate a page at a physical address
 	 * where KASAN is not populated yet and then we'd get a page fault.
 	 */
-	if (!early)
-		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_p4d)), PAGE_TABLE));
+	set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_p4d)), PAGE_TABLE));
 }
 
 #define kasan_early_shadow_pgd_next			(pgtable_l5_enabled ?	\
@@ -219,16 +183,15 @@ static void __init kasan_populate_p4d(pgd_t *pgd,
 							(pgtable_l4_enabled ?	\
 				(uintptr_t)kasan_early_shadow_pud :		\
 				(uintptr_t)kasan_early_shadow_pmd))
-#define kasan_populate_pgd_next(pgdp, vaddr, next, early)			\
+#define kasan_populate_pgd_next(pgdp, vaddr, next)				\
 		(pgtable_l5_enabled ?						\
-		kasan_populate_p4d(pgdp, vaddr, next, early) :			\
+		kasan_populate_p4d(pgdp, vaddr, next) :				\
 		(pgtable_l4_enabled ?						\
-			kasan_populate_pud(pgdp, vaddr, next, early) :		\
+			kasan_populate_pud(pgdp, vaddr, next) :			\
 			kasan_populate_pmd((pud_t *)pgdp, vaddr, next)))
 
 static void __init kasan_populate_pgd(pgd_t *pgdp,
-				      unsigned long vaddr, unsigned long end,
-				      bool early)
+				      unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	unsigned long next;
@@ -237,11 +200,7 @@ static void __init kasan_populate_pgd(pgd_t *pgdp,
 		next = pgd_addr_end(vaddr, end);
 
 		if (IS_ALIGNED(vaddr, PGDIR_SIZE) && (next - vaddr) >= PGDIR_SIZE) {
-			if (early) {
-				phys_addr = __pa((uintptr_t)kasan_early_shadow_pgd_next);
-				set_pgd(pgdp, pfn_pgd(PFN_DOWN(phys_addr), PAGE_TABLE));
-				continue;
-			} else if (pgd_page_vaddr(*pgdp) ==
+			if (pgd_page_vaddr(*pgdp) ==
 				   (unsigned long)lm_alias(kasan_early_shadow_pgd_next)) {
 				/*
 				 * pgdp can't be none since kasan_early_init
@@ -258,7 +217,95 @@ static void __init kasan_populate_pgd(pgd_t *pgdp,
 			}
 		}
 
-		kasan_populate_pgd_next(pgdp, vaddr, next, early);
+		kasan_populate_pgd_next(pgdp, vaddr, next);
+	} while (pgdp++, vaddr = next, vaddr != end);
+}
+
+static void __init kasan_early_populate_pud(p4d_t *p4dp,
+					    unsigned long vaddr,
+					    unsigned long end)
+{
+	pud_t *pudp, *base_pud;
+	phys_addr_t phys_addr;
+	unsigned long next;
+
+	if (!pgtable_l4_enabled) {
+		pudp = (pud_t *)p4dp;
+	} else {
+		base_pud = pt_ops.get_pud_virt(pfn_to_phys(_p4d_pfn(*p4dp)));
+		pudp = base_pud + pud_index(vaddr);
+	}
+
+	do {
+		next = pud_addr_end(vaddr, end);
+
+		if (pud_none(*pudp) && IS_ALIGNED(vaddr, PUD_SIZE) &&
+		    (next - vaddr) >= PUD_SIZE) {
+			phys_addr = __pa((uintptr_t)kasan_early_shadow_pmd);
+			set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_TABLE));
+			continue;
+		}
+
+		BUG();
+	} while (pudp++, vaddr = next, vaddr != end);
+}
+
+static void __init kasan_early_populate_p4d(pgd_t *pgdp,
+					    unsigned long vaddr,
+					    unsigned long end)
+{
+	p4d_t *p4dp, *base_p4d;
+	phys_addr_t phys_addr;
+	unsigned long next;
+
+	/*
+	 * We can't use pgd_page_vaddr here as it would return a linear
+	 * mapping address but it is not mapped yet, but when populating
+	 * early_pg_dir, we need the physical address and when populating
+	 * swapper_pg_dir, we need the kernel virtual address so use
+	 * pt_ops facility.
+	 * Note that this test is then completely equivalent to
+	 * p4dp = p4d_offset(pgdp, vaddr)
+	 */
+	if (!pgtable_l5_enabled) {
+		p4dp = (p4d_t *)pgdp;
+	} else {
+		base_p4d = pt_ops.get_p4d_virt(pfn_to_phys(_pgd_pfn(*pgdp)));
+		p4dp = base_p4d + p4d_index(vaddr);
+	}
+
+	do {
+		next = p4d_addr_end(vaddr, end);
+
+		if (p4d_none(*p4dp) && IS_ALIGNED(vaddr, P4D_SIZE) &&
+		    (next - vaddr) >= P4D_SIZE) {
+			phys_addr = __pa((uintptr_t)kasan_early_shadow_pud);
+			set_p4d(p4dp, pfn_p4d(PFN_DOWN(phys_addr), PAGE_TABLE));
+			continue;
+		}
+
+		kasan_early_populate_pud(p4dp, vaddr, next);
+	} while (p4dp++, vaddr = next, vaddr != end);
+}
+
+static void __init kasan_early_populate_pgd(pgd_t *pgdp,
+					    unsigned long vaddr,
+					    unsigned long end)
+{
+	phys_addr_t phys_addr;
+	unsigned long next;
+
+	do {
+		next = pgd_addr_end(vaddr, end);
+
+		if (pgd_none(*pgdp) && IS_ALIGNED(vaddr, PGDIR_SIZE) &&
+		    (next - vaddr) >= PGDIR_SIZE) {
+			phys_addr = __pa((uintptr_t)kasan_early_shadow_p4d);
+			set_pgd(pgdp, pfn_pgd(PFN_DOWN(phys_addr), PAGE_TABLE));
+			continue;
+		}
+
+		kasan_early_populate_p4d(pgdp, vaddr, next);
 	} while (pgdp++, vaddr = next, vaddr != end);
 }
 
@@ -295,16 +342,16 @@ asmlinkage void __init kasan_early_init(void)
 					PAGE_TABLE));
 	}
 
-	kasan_populate_pgd(early_pg_dir + pgd_index(KASAN_SHADOW_START),
-			   KASAN_SHADOW_START, KASAN_SHADOW_END, true);
+	kasan_early_populate_pgd(early_pg_dir + pgd_index(KASAN_SHADOW_START),
+				 KASAN_SHADOW_START, KASAN_SHADOW_END);
 
 	local_flush_tlb_all();
 }
 
 void __init kasan_swapper_init(void)
 {
-	kasan_populate_pgd(pgd_offset_k(KASAN_SHADOW_START),
-			   KASAN_SHADOW_START, KASAN_SHADOW_END, true);
+	kasan_early_populate_pgd(pgd_offset_k(KASAN_SHADOW_START),
+				 KASAN_SHADOW_START, KASAN_SHADOW_END);
 
 	local_flush_tlb_all();
 }
@@ -314,7 +361,7 @@ static void __init kasan_populate(void *start, void *end)
 	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
 	unsigned long vend = PAGE_ALIGN((unsigned long)end);
 
-	kasan_populate_pgd(pgd_offset_k(vaddr), vaddr, vend, false);
+	kasan_populate_pgd(pgd_offset_k(vaddr), vaddr, vend);
 
 	local_flush_tlb_all();
 	memset(start, KASAN_SHADOW_INIT, end - start);
-- 
2.37.2

