Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA16D6AE1EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjCGONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCGOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:12:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534498315C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F8C4B818FE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C8BC433A0;
        Tue,  7 Mar 2023 14:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198121;
        bh=gZ6gT92QoewG67ylJsd53DevrQCpgBq5112YtMXuQRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRNBdv0NFEKBnS2lFqek4SATtENdEPGBRch+JF41rd9uNvJhbI17ES1Td3abUFDER
         Ke6ptVpzc28DJ1gF0r+NHw1mFqi2YHyp7EDnh6fOpae2aHwCBDKhUWx4vYGX32vHgA
         9ObQl4V/08s/85qs1tljGmIOYbsd99LB4S3a6A8DNFcuLnXl3Z/jPimstby0RP1CGl
         eE5ZSVjT1mweedTOg7ca8Ig3cdZ7h/f+hU6o1NVlBnK/JCSb1NjlMrerDZuMvgw93K
         Bj0yluZ6KFNOUtnqGvTaIMcYp9gT/WedJDVZe7Wrca4HkHdsEbJ7E5DyhfIEit5Nfr
         CWRK8+qbRq5Ng==
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
Subject: [PATCH v3 51/60] arm64: kasan: Reduce minimum shadow alignment and enable 5 level paging
Date:   Tue,  7 Mar 2023 15:05:13 +0100
Message-Id: <20230307140522.2311461-52-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9265; i=ardb@kernel.org; h=from:subject; bh=gZ6gT92QoewG67ylJsd53DevrQCpgBq5112YtMXuQRo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdpS2Xof1souYOwccVnnP/nZX7HPXzp8WNVaXc3Y1ru pkreQo6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQSEhgZOvK/PnTfUsn9ItrP vE9HPLs8NSbG5P2Oo1V6Fs3bQrS3MTIcFXq0xyzk0wO3XSemrC/hsX9QkbFLTiX2y6yHb2XCFFz 5AA==
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

Allow the KASAN init code to deal with 5 levels of paging, and relax the
requirement that the shadow region is aligned to the top level pgd_t
size. This is necessary for LPA2 based 52-bit virtual addressing, where
the KASAN shadow will never be aligned to the pgd_t size. Allowing this
also enables the 16k/48-bit case for KASAN, which is a nice bonus.

This involves some hackery to manipulate the root and next level page
tables without having to distinguish all the various configurations,
including 16k/48-bits (which has a two entry pgd_t level), and LPA2
configurations running with one translation level less on non-LPA2
hardware.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig         |   2 +-
 arch/arm64/mm/kasan_init.c | 143 ++++++++++++++++++--
 2 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d287dad29198c843..52aac583823863e4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -157,7 +157,7 @@ config ARM64
 	select HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
-	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
+	select HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 7e32f21fb8e1e227..7ab7520133946e91 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -23,7 +23,7 @@
 
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
-static pgd_t tmp_pg_dir[PTRS_PER_PGD] __initdata __aligned(PGD_SIZE);
+static pgd_t tmp_pg_dir[PTRS_PER_PTE] __initdata __aligned(PAGE_SIZE);
 
 /*
  * The p*d_populate functions call virt_to_phys implicitly so they can't be used
@@ -99,6 +99,19 @@ static pud_t *__init kasan_pud_offset(p4d_t *p4dp, unsigned long addr, int node,
 	return early ? pud_offset_kimg(p4dp, addr) : pud_offset(p4dp, addr);
 }
 
+static p4d_t *__init kasan_p4d_offset(pgd_t *pgdp, unsigned long addr, int node,
+				      bool early)
+{
+	if (pgd_none(READ_ONCE(*pgdp))) {
+		phys_addr_t p4d_phys = early ?
+				__pa_symbol(kasan_early_shadow_p4d)
+					: kasan_alloc_zeroed_page(node);
+		__pgd_populate(pgdp, p4d_phys, PGD_TYPE_TABLE);
+	}
+
+	return early ? p4d_offset_kimg(pgdp, addr) : p4d_offset(pgdp, addr);
+}
+
 static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
 				      unsigned long end, int node, bool early)
 {
@@ -144,12 +157,12 @@ static void __init kasan_p4d_populate(pgd_t *pgdp, unsigned long addr,
 				      unsigned long end, int node, bool early)
 {
 	unsigned long next;
-	p4d_t *p4dp = p4d_offset(pgdp, addr);
+	p4d_t *p4dp = kasan_p4d_offset(pgdp, addr, node, early);
 
 	do {
 		next = p4d_addr_end(addr, end);
 		kasan_pud_populate(p4dp, addr, next, node, early);
-	} while (p4dp++, addr = next, addr != end);
+	} while (p4dp++, addr = next, addr != end && p4d_none(READ_ONCE(*p4dp)));
 }
 
 static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
@@ -165,14 +178,48 @@ static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
 	} while (pgdp++, addr = next, addr != end);
 }
 
+#if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS > 4
+#define SHADOW_ALIGN	P4D_SIZE
+#else
+#define SHADOW_ALIGN	PUD_SIZE
+#endif
+
+/*
+ * Return whether 'addr' is aligned to the size covered by a root level
+ * descriptor.
+ */
+static bool __init root_level_aligned(u64 addr)
+{
+	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits_actual) - 1) * (PAGE_SHIFT - 3);
+
+	return (addr % (PAGE_SIZE << shift)) == 0;
+}
+
 /* The early shadow maps everything to a single page of zeroes */
 asmlinkage void __init kasan_early_init(void)
 {
 	BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
 		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
-	BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS), PGDIR_SIZE));
-	BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS_MIN), PGDIR_SIZE));
-	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE));
+	BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS), SHADOW_ALIGN));
+	BUILD_BUG_ON(!IS_ALIGNED(_KASAN_SHADOW_START(VA_BITS_MIN), SHADOW_ALIGN));
+	BUILD_BUG_ON(!IS_ALIGNED(KASAN_SHADOW_END, SHADOW_ALIGN));
+
+	if (!root_level_aligned(KASAN_SHADOW_START)) {
+		/*
+		 * The start address is misaligned, and so the next level table
+		 * will be shared with the linear region. This can happen with
+		 * 4 or 5 level paging, so install a generic pte_t[] as the
+		 * next level. This prevents the kasan_pgd_populate call below
+		 * from inserting an entry that refers to the shared KASAN zero
+		 * shadow pud_t[]/p4d_t[], which could end up getting corrupted
+		 * when the linear region is mapped.
+		 */
+		static pte_t tbl[PTRS_PER_PTE] __page_aligned_bss;
+		pgd_t *pgdp = pgd_offset_k(KASAN_SHADOW_START);
+
+		set_pgd(pgdp, __pgd(__pa_symbol(tbl) | PGD_TYPE_TABLE));
+	}
+
 	kasan_pgd_populate(KASAN_SHADOW_START, KASAN_SHADOW_END, NUMA_NO_NODE,
 			   true);
 }
@@ -184,20 +231,75 @@ static void __init kasan_map_populate(unsigned long start, unsigned long end,
 	kasan_pgd_populate(start & PAGE_MASK, PAGE_ALIGN(end), node, false);
 }
 
-static void __init clear_pgds(unsigned long start,
-			unsigned long end)
+/*
+ * Return the descriptor index of 'addr' in the root level table
+ */
+static int __init root_level_idx(u64 addr)
 {
 	/*
-	 * Remove references to kasan page tables from
-	 * swapper_pg_dir. pgd_clear() can't be used
-	 * here because it's nop on 2,3-level pagetable setups
+	 * On 64k pages, the TTBR1 range root tables are extended for 52-bit
+	 * virtual addressing, and TTBR1 will simply point to the pgd_t entry
+	 * that covers the start of the 48-bit addressable VA space if LVA is
+	 * not implemented. This means we need to index the table as usual,
+	 * instead of masking off bits based on vabits_actual.
 	 */
-	for (; start < end; start += PGDIR_SIZE)
-		set_pgd(pgd_offset_k(start), __pgd(0));
+	u64 vabits = IS_ENABLED(CONFIG_ARM64_64K_PAGES) ? VA_BITS
+							: vabits_actual;
+	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits) - 1) * (PAGE_SHIFT - 3);
+
+	return (addr & ~_PAGE_OFFSET(vabits)) >> (shift + PAGE_SHIFT);
+}
+
+/*
+ * Clone a next level table from swapper_pg_dir into tmp_pg_dir
+ */
+static void __init clone_next_level(u64 addr, pgd_t *tmp_pg_dir, pud_t *pud)
+{
+	int idx = root_level_idx(addr);
+	pgd_t pgd = READ_ONCE(swapper_pg_dir[idx]);
+	pud_t *pudp = (pud_t *)__phys_to_kimg(__pgd_to_phys(pgd));
+
+	memcpy(pud, pudp, PAGE_SIZE);
+	tmp_pg_dir[idx] = __pgd(__phys_to_pgd_val(__pa_symbol(pud)) |
+				PUD_TYPE_TABLE);
+}
+
+/*
+ * Return the descriptor index of 'addr' in the next level table
+ */
+static int __init next_level_idx(u64 addr)
+{
+	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits_actual) - 2) * (PAGE_SHIFT - 3);
+
+	return (addr >> (shift + PAGE_SHIFT)) % PTRS_PER_PTE;
+}
+
+/*
+ * Dereference the table descriptor at 'pgd_idx' and clear the entries from
+ * 'start' to 'end' (exclusive) from the table.
+ */
+static void __init clear_next_level(int pgd_idx, int start, int end)
+{
+	pgd_t pgd = READ_ONCE(swapper_pg_dir[pgd_idx]);
+	pud_t *pudp = (pud_t *)__phys_to_kimg(__pgd_to_phys(pgd));
+
+	memset(&pudp[start], 0, (end - start) * sizeof(pud_t));
+}
+
+static void __init clear_shadow(u64 start, u64 end)
+{
+	int l = root_level_idx(start), m = root_level_idx(end);
+
+	if (!root_level_aligned(start))
+		clear_next_level(l++, next_level_idx(start), PTRS_PER_PTE);
+	if (!root_level_aligned(end))
+		clear_next_level(m, 0, next_level_idx(end));
+	memset(&swapper_pg_dir[l], 0, (m - l) * sizeof(pgd_t));
 }
 
 static void __init kasan_init_shadow(void)
 {
+	static pud_t pud[2][PTRS_PER_PUD] __initdata __aligned(PAGE_SIZE);
 	u64 kimg_shadow_start, kimg_shadow_end;
 	u64 mod_shadow_start, mod_shadow_end;
 	u64 vmalloc_shadow_end;
@@ -220,10 +322,23 @@ static void __init kasan_init_shadow(void)
 	 * setup will be finished.
 	 */
 	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
+
+	/*
+	 * If the start or end address of the shadow region is not aligned to
+	 * the root level size, we have to allocate a temporary next-level table
+	 * in each case, clone the next level of descriptors, and install the
+	 * table into tmp_pg_dir. Note that with 5 levels of paging, the next
+	 * level will in fact be p4d_t, but that makes no difference in this
+	 * case.
+	 */
+	if (!root_level_aligned(KASAN_SHADOW_START))
+		clone_next_level(KASAN_SHADOW_START, tmp_pg_dir, pud[0]);
+	if (!root_level_aligned(KASAN_SHADOW_END))
+		clone_next_level(KASAN_SHADOW_END, tmp_pg_dir, pud[1]);
 	dsb(ishst);
 	cpu_replace_ttbr1(lm_alias(tmp_pg_dir));
 
-	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
+	clear_shadow(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
 	kasan_map_populate(kimg_shadow_start, kimg_shadow_end,
 			   early_pfn_to_nid(virt_to_pfn(lm_alias(KERNEL_START))));
-- 
2.39.2

