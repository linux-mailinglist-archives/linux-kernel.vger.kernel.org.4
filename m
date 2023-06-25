Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E565B73D1B2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFYP3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFYP3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:29:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC89F1AA;
        Sun, 25 Jun 2023 08:29:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6689430d803so1082740b3a.0;
        Sun, 25 Jun 2023 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687706945; x=1690298945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+WOYDIvLdd2NWRRa7PZxlpSE8oO3O/uffxAnfRWFTQ=;
        b=M/P1iEtEmWvR4gNy5Xi0GhWXMDNv1iAV49eqjRiWX/SAZBBrZ4s/wFnFIiajnvMR4U
         Cq1f9q3461N2I20MICOALV/oq3Y75DDRsxKW1LcN3YmT0VMpcBO192i2R/Tnray4uCLy
         qlguMhROpd4O4D0+1D39cIOsXUNWM1KGSHyLzylZe4sBdvfCgnfcCkK1IUM3FALO35Xj
         ESLoTOb/a6y+uu7bEc76FcwrssFtglHWWl1AsX9M1choSG87grsiErSmdrjGFyaW8M7I
         5DGHbp/HmQuets+G9z+XnvhIyKsSjFiGne8NHRtO3iGjmISL0FDVioxo/FCmNlSMUbVn
         DwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687706945; x=1690298945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+WOYDIvLdd2NWRRa7PZxlpSE8oO3O/uffxAnfRWFTQ=;
        b=i94Kg88Pb4xMJzNa65PqhuaTJrTSufF72ZXdK2wcVICM1CgMWkmrQ6nK7g9mdno9W8
         0coFWHNrveyxycKkOhIbTKCWRLwPL/72CJDsthd7b1C050KzpteduKXTdUK4S6+7ffAI
         TPDksOyqu+/ibm2/70DKUmmxeqyQVa1D35MXWgPmfjk62KYYuTNetLxLkfmhRpXVq6ol
         4K2G75tiWpmd3PxQGm+rSd3pfkaFHw6U+mewi1nTgY0vrcDXW8zaVKyNK4iY9HmMWPae
         5ebnEFQy3mT7u4cDdgeH2brFlpB5X+bPQrqVl1t7/W6tol4ntc1MxK6blbysMHRoB1Q3
         5ABw==
X-Gm-Message-State: AC+VfDy70/xGoZDT4y6XtT6ENwKO8a1ddGZjQkwpRnIKeo7OeO5DizUw
        XXZPV4yUOBkhR1jzy5f5Gow=
X-Google-Smtp-Source: ACHHUZ6mNVKRC/wAju5m3w9CI3n8kce2f6IYE2Xf6XLkhFJuxLumcPtstkhxjS+602cCUYMD2xfLoQ==
X-Received: by 2002:a05:6a20:96db:b0:126:6c67:18bc with SMTP id hq27-20020a056a2096db00b001266c6718bcmr2001479pzc.38.1687706945039;
        Sun, 25 Jun 2023 08:29:05 -0700 (PDT)
Received: from localhost.localdomain ([112.2.230.41])
        by smtp.gmail.com with ESMTPSA id e19-20020a62aa13000000b0062bc045bf4fsm1710619pff.19.2023.06.25.08.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 08:29:04 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     songshuaishuai@tinylab.org
Cc:     ajones@ventanamicro.com, alexghiti@rivosinc.com,
        anshuman.khandual@arm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, arnd@arndb.de, conor.dooley@microchip.com,
        devicetree@vger.kernel.org, frowand.list@gmail.com,
        heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mpe@ellerman.id.au,
        palmer@dabbelt.com, panqinglin2020@iscas.ac.cn,
        paul.walmsley@sifive.com, robh+dt@kernel.org, rppt@kernel.org,
        samuel@sholland.org, xianting.tian@linux.alibaba.com
Subject: [PATCH V1 3/3] Revert "riscv: Use PUD/P4D/PGD pages for the linear mapping"
Date:   Sun, 25 Jun 2023 23:28:41 +0800
Message-Id: <20230625152841.1280937-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
References: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Shuai <songshuaishuai@tinylab.org>

This reverts commit 3335068f87217ea59d08f462187dc856652eea15.

This commit maps the PMP regions from some versions of OpenSbi in
the linear mapping, that will lead to an access fault when doing
hibernation[1] or some speculative accesses.

The best_map_size() function from this commit doesn't check the
virtual alignment before choosing a map size, that will cause a
page fault[2]. We can let best_map_size() take the VA into
consideration via commit 49a0a3731596 ("riscv: Check the virtual
alignment before choosing a map size"), but that commit slows down
the boot time and consumes some system memory when UEFI booting.

This commit uses PUD/P4D/PGD pages for the linear mapping to improve
the performance is marginal from a recent talk [3] from Mike Rapoport.
OpenSbi had marked all the PMP-protected regions as "no-map" [4]
to practice this talk.

For all those reasons, let's revert this commit.

[1] https://lore.kernel.org/linux-riscv/CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
[2] https://lore.kernel.org/linux-riscv/tencent_7C3B580B47C1B17C16488EC1@qq.com/
[3] https://lwn.net/Articles/931406/
[4] https://github.com/riscv-software-src/opensbi/commit/8153b2622b08802cc542f30a1fcba407a5667ab9

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 arch/riscv/include/asm/page.h | 16 ---------------
 arch/riscv/mm/init.c          | 38 ++++++-----------------------------
 arch/riscv/mm/physaddr.c      | 16 ---------------
 drivers/of/fdt.c              | 11 +++++-----
 4 files changed, 11 insertions(+), 70 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index b55ba20903ec..21b346ab81c2 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -89,14 +89,6 @@ typedef struct page *pgtable_t;
 #define PTE_FMT "%08lx"
 #endif
 
-#ifdef CONFIG_64BIT
-/*
- * We override this value as its generic definition uses __pa too early in
- * the boot process (before kernel_map.va_pa_offset is set).
- */
-#define MIN_MEMBLOCK_ADDR      0
-#endif
-
 #ifdef CONFIG_MMU
 #define ARCH_PFN_OFFSET		(PFN_DOWN((unsigned long)phys_ram_base))
 #else
@@ -128,11 +120,7 @@ extern phys_addr_t phys_ram_base;
 #define is_linear_mapping(x)	\
 	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
 
-#ifndef CONFIG_DEBUG_VIRTUAL
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
-#else
-void *linear_mapping_pa_to_va(unsigned long x);
-#endif
 #define kernel_mapping_pa_to_va(y)	({					\
 	unsigned long _y = (unsigned long)(y);					\
 	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?			\
@@ -141,11 +129,7 @@ void *linear_mapping_pa_to_va(unsigned long x);
 	})
 #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
 
-#ifndef CONFIG_DEBUG_VIRTUAL
 #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - kernel_map.va_pa_offset)
-#else
-phys_addr_t linear_mapping_va_to_pa(unsigned long x);
-#endif
 #define kernel_mapping_va_to_pa(y) ({						\
 	unsigned long _y = (unsigned long)(y);					\
 	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 38c4b4d6b64f..4561781bcf60 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -216,14 +216,6 @@ static void __init setup_bootmem(void)
 	phys_ram_end = memblock_end_of_DRAM();
 	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
 		phys_ram_base = memblock_start_of_DRAM();
-
-	/*
-	 * In 64-bit, any use of __va/__pa before this point is wrong as we
-	 * did not know the start of DRAM before.
-	 */
-	if (IS_ENABLED(CONFIG_64BIT))
-		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
-
 	/*
 	 * memblock allocator is not aware of the fact that last 4K bytes of
 	 * the addressable memory can not be mapped because of IS_ERR_VALUE
@@ -662,16 +654,9 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 
 static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 {
-	if (!(base & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
-		return PGDIR_SIZE;
-
-	if (!(base & (P4D_SIZE - 1)) && size >= P4D_SIZE)
-		return P4D_SIZE;
-
-	if (!(base & (PUD_SIZE - 1)) && size >= PUD_SIZE)
-		return PUD_SIZE;
-
-	if (!(base & (PMD_SIZE - 1)) && size >= PMD_SIZE)
+	/* Upgrade to PMD_SIZE mappings whenever possible */
+	base &= PMD_SIZE - 1;
+	if (!base && size >= PMD_SIZE)
 		return PMD_SIZE;
 
 	return PAGE_SIZE;
@@ -1037,22 +1022,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	set_satp_mode(dtb_pa);
 #endif
 
-	/*
-	 * In 64-bit, we defer the setup of va_pa_offset to setup_bootmem,
-	 * where we have the system memory layout: this allows us to align
-	 * the physical and virtual mappings and then make use of PUD/P4D/PGD
-	 * for the linear mapping. This is only possible because the kernel
-	 * mapping lies outside the linear mapping.
-	 * In 32-bit however, as the kernel resides in the linear mapping,
-	 * setup_vm_final can not change the mapping established here,
-	 * otherwise the same kernel addresses would get mapped to different
-	 * physical addresses (if the start of dram is different from the
-	 * kernel physical address start).
-	 */
-	kernel_map.va_pa_offset = IS_ENABLED(CONFIG_64BIT) ?
-				0UL : PAGE_OFFSET - kernel_map.phys_addr;
+	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
 	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 
+	phys_ram_base = kernel_map.phys_addr;
+
 	/*
 	 * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
 	 * kernel, whereas for 64-bit kernel, the end of the virtual address
diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
index 18706f457da7..9b18bda74154 100644
--- a/arch/riscv/mm/physaddr.c
+++ b/arch/riscv/mm/physaddr.c
@@ -33,19 +33,3 @@ phys_addr_t __phys_addr_symbol(unsigned long x)
 	return __va_to_pa_nodebug(x);
 }
 EXPORT_SYMBOL(__phys_addr_symbol);
-
-phys_addr_t linear_mapping_va_to_pa(unsigned long x)
-{
-	BUG_ON(!kernel_map.va_pa_offset);
-
-	return ((unsigned long)(x) - kernel_map.va_pa_offset);
-}
-EXPORT_SYMBOL(linear_mapping_va_to_pa);
-
-void *linear_mapping_pa_to_va(unsigned long x)
-{
-	BUG_ON(!kernel_map.va_pa_offset);
-
-	return ((void *)((unsigned long)(x) + kernel_map.va_pa_offset));
-}
-EXPORT_SYMBOL(linear_mapping_pa_to_va);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..c28aedd7ae1f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -888,13 +888,12 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
-	/*
-	 * __va() is not yet available this early on some platforms. In that
-	 * case, the platform uses phys_initrd_start/phys_initrd_size instead
-	 * and does the VA conversion itself.
+	/* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
+	 * enabled since __va() is called too early. ARM64 does make use
+	 * of phys_initrd_start/phys_initrd_size so we can skip this
+	 * conversion.
 	 */
-	if (!IS_ENABLED(CONFIG_ARM64) &&
-	    !(IS_ENABLED(CONFIG_RISCV) && IS_ENABLED(CONFIG_64BIT))) {
+	if (!IS_ENABLED(CONFIG_ARM64)) {
 		initrd_start = (unsigned long)__va(start);
 		initrd_end = (unsigned long)__va(end);
 		initrd_below_start_ok = 1;
-- 
2.20.1

