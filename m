Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EC2700AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbjELO6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbjELO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:58:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B73A86
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09FCE65735
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEA8C4339B;
        Fri, 12 May 2023 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683903479;
        bh=nJDJ9NE+3mcyJNnGkZl+cobDBvPDump2PA8ld/F5o/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkPLrlyFezs3jORrA3aROLm9iXC6Kr9vZjNIJzD6TiCZIqDJsxH49o0Pu+gEOK/gU
         VQeKq8IgWZHG4gxyuGcDrQwf0pp5Ti0KFT8is/rChRqO0i3zkfDEZmL9fQi/Yrx6Wj
         gHPD02kEB1754XbX7Dra6eV9gfEWk+l0+gyV+8AtChmvojBDWyWK4jNMnQ6wv8Ytdv
         W7YJLyXvLt9mx73HO6vwf+V0/FvXaM4esp+YR7xgUlVMxUGXnkUQ0kiaiaLLtHbtN/
         QB9T/Gofz00zxK9cWCo+6XUlba0SMqDf2WOJ/jm6328ZydxnvV7MKyLnlDsJQZIFjQ
         M+xECs9iopGtA==
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
Subject: [PATCH 1/7] riscv: mm: Pre-allocate PGD leaves to avoid synchronization
Date:   Fri, 12 May 2023 16:57:31 +0200
Message-Id: <20230512145737.985671-2-bjorn@kernel.org>
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

The RISC-V port copies PGD from init_mm to all userland pages-tables,
which means that when the PGD level of the init_mm table is changed,
other page-tables has to be updated.

One way to avoid synchronizing page-tables is to pre-allocate the
pages that are copied (need to be synchronized). For memory
hotswapping builds, prefer to waste some pages, rather than do
explicit synchronization.

Prepare the RISC-V port for memory add/remove, by getting rid of PGD
synchronization. Pre-allocate vmemmap, and direct map pages. This will
roughly waste ~128 worth of 4K pages.

Note that this is only done for memory hotswap enabled configuration.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/kasan.h |  4 +-
 arch/riscv/mm/init.c           | 86 ++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
index 0b85e363e778..e6a0071bdb56 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -6,8 +6,6 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_KASAN
-
 /*
  * The following comment was copied from arm64:
  * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
@@ -34,6 +32,8 @@
  */
 #define KASAN_SHADOW_START	((KASAN_SHADOW_END - KASAN_SHADOW_SIZE) & PGDIR_MASK)
 #define KASAN_SHADOW_END	MODULES_LOWEST_VADDR
+
+#ifdef CONFIG_KASAN
 #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 
 void kasan_init(void);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 747e5b1ef02d..d2595cc33a1c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -31,6 +31,7 @@
 #include <asm/io.h>
 #include <asm/ptdump.h>
 #include <asm/numa.h>
+#include <asm/kasan.h>
 
 #include "../kernel/head.h"
 
@@ -156,6 +157,90 @@ static void __init print_vm_layout(void)
 static void print_vm_layout(void) { }
 #endif /* CONFIG_DEBUG_VM */
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+/*
+ * Pre-allocates page-table pages for a specific area in the kernel
+ * page-table. Only the level which needs to be synchronized between
+ * all page-tables is allocated because the synchronization can be
+ * expensive.
+ */
+static void __init preallocate_pgd_pages_range(unsigned long start, unsigned long end,
+					       const char *area)
+{
+	unsigned long addr;
+	const char *lvl;
+
+	for (addr = start; addr < end; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
+		pgd_t *pgd = pgd_offset_k(addr);
+		p4d_t *p4d;
+		pud_t *pud;
+		pmd_t *pmd;
+
+		lvl = "p4d";
+		p4d = p4d_alloc(&init_mm, pgd, addr);
+		if (!p4d)
+			goto failed;
+
+		if (pgtable_l5_enabled)
+			continue;
+
+		/*
+		 * The goal here is to allocate all possibly required
+		 * hardware page tables pointed to by the top hardware
+		 * level.
+		 *
+		 * On 4-level systems, the P4D layer is folded away
+		 * and the above code does no preallocation.  Below,
+		 * go down to the pud _software_ level to ensure the
+		 * second hardware level is allocated on 4-level
+		 * systems too.
+		 */
+		lvl = "pud";
+		pud = pud_alloc(&init_mm, p4d, addr);
+		if (!pud)
+			goto failed;
+
+		if (pgtable_l4_enabled)
+			continue;
+		/*
+		 * The goal here is to allocate all possibly required
+		 * hardware page tables pointed to by the top hardware
+		 * level.
+		 *
+		 * On 3-level systems, the PUD layer is folded away
+		 * and the above code does no preallocation.  Below,
+		 * go down to the pmd _software_ level to ensure the
+		 * second hardware level is allocated on 3-level
+		 * systems too.
+		 */
+		lvl = "pmd";
+		pmd = pmd_alloc(&init_mm, pud, addr);
+		if (!pmd)
+			goto failed;
+	}
+
+	return;
+
+failed:
+
+	/*
+	 * The pages have to be there now or they will be missing in
+	 * process page-tables later.
+	 */
+	panic("Failed to pre-allocate %s pages for %s area\n", lvl, area);
+}
+
+#define PAGE_END KASAN_SHADOW_START
+#endif
+
+static void __init prepare_memory_hotplug(void)
+{
+#ifdef CONFIG_MEMORY_HOTPLUG
+	preallocate_pgd_pages_range(VMEMMAP_START, VMEMMAP_END, "vmemmap");
+	preallocate_pgd_pages_range(PAGE_OFFSET, PAGE_END, "direct map");
+#endif
+}
+
 void __init mem_init(void)
 {
 #ifdef CONFIG_FLATMEM
@@ -164,6 +249,7 @@ void __init mem_init(void)
 
 	swiotlb_init(max_pfn > PFN_DOWN(dma32_phys_limit), SWIOTLB_VERBOSE);
 	memblock_free_all();
+	prepare_memory_hotplug();
 
 	print_vm_layout();
 }
-- 
2.39.2

