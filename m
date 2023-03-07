Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3AF6AE1D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCGOK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjCGOJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5158ABE0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D204261454
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE34C433A8;
        Tue,  7 Mar 2023 14:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198092;
        bh=X9Ek6XmryrGuZuPxCkSVXUt6q5oJSf6iQG3CXGNKcYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXFkLomw7g6jIgPo/aXn1Yg6xIqW1a6HGbT1Gln303rNFhIYofW3qduzp/8iDECUV
         bkuzoxc+lpzab4iQ3g8zXgaMR5iUOCj3y4S+FFf61U8IXt2u2/NMYlr6dkIgG/2cS+
         ekJePay1/wARy8k0WzwNlQARXRz/UAFJYeF4veuwTau2kEMqWQtnTDp0uLp/4w43vA
         OsqjfpP5xDSFWPc1h1oE0dlflV/TEw1NW8/8TwXJ7Q2qB9MKdXyOjbJwnswHdm+kuS
         YabWkbTlX7pZzVDhZ2+OTg2MVY1eA7WSlmZwnjjhBwhO7ndUrtmhl2bgOHHQzjsggi
         PGquE9fjlqc5g==
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
Subject: [PATCH v3 39/60] arm64: mm: omit redundant remap of kernel image
Date:   Tue,  7 Mar 2023 15:05:01 +0100
Message-Id: <20230307140522.2311461-40-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9110; i=ardb@kernel.org; h=from:subject; bh=X9Ek6XmryrGuZuPxCkSVXUt6q5oJSf6iQG3CXGNKcYU=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdJfVHdVds+ypenp3dSbmRacv+rnQ6coN1zoInF8UK1 5WfX/axo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkogvDPx1BsYjo9T7PZ289 nxFuXvdr58VTbGbNz53v8zO7lXdzyzL8T5M8pLd6j9V0y8T0sxJNP1Kzt7PmFmr8Zjvzd1PnQkc GXgA=
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

Now that the early kernel mapping is created with all the right
attributes and segment boundaries, there is no longer a need to recreate
it and switch to it. This also means we no longer have to copy the kasan
shadow or some parts of the fixmap from one set of page tables to the
other.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/kasan.h    |   2 -
 arch/arm64/include/asm/mmu.h      |   2 +-
 arch/arm64/kernel/image-vars.h    |   1 +
 arch/arm64/kernel/pi/map_kernel.c |   6 +-
 arch/arm64/mm/kasan_init.c        |  15 ---
 arch/arm64/mm/mmu.c               | 110 +++-----------------
 6 files changed, 20 insertions(+), 116 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index 12d5f47f7dbec628..ab52688ac4bd43b6 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -36,12 +36,10 @@ void kasan_init(void);
 #define _KASAN_SHADOW_START(va)	(KASAN_SHADOW_END - (1UL << ((va) - KASAN_SHADOW_SCALE_SHIFT)))
 #define KASAN_SHADOW_START      _KASAN_SHADOW_START(vabits_actual)
 
-void kasan_copy_shadow(pgd_t *pgdir);
 asmlinkage void kasan_early_init(void);
 
 #else
 static inline void kasan_init(void) { }
-static inline void kasan_copy_shadow(pgd_t *pgdir) { }
 #endif
 
 #endif
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index e74dfae8e48214c3..fce956cd721ba64f 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -95,7 +95,7 @@ static inline bool kaslr_disabled_cmdline(void)
 }
 
 #define INIT_MM_CONTEXT(name)	\
-	.pgd = init_pg_dir,
+	.pgd = swapper_pg_dir,
 
 #endif	/* !__ASSEMBLY__ */
 #endif
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 6ca235b09a30d5d3..1c0e920a2466f851 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -50,6 +50,7 @@ PROVIDE(__pi_memstart_offset_seed	= memstart_offset_seed);
 PROVIDE(__pi_init_idmap_pg_dir		= init_idmap_pg_dir);
 PROVIDE(__pi_init_pg_dir		= init_pg_dir);
 PROVIDE(__pi_init_pg_end		= init_pg_end);
+PROVIDE(__pi_swapper_pg_dir		= swapper_pg_dir);
 
 PROVIDE(__pi__text			= _text);
 PROVIDE(__pi__stext               	= _stext);
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index a718714eb671f290..a90c4d6fc75c35d0 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -125,8 +125,12 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 			    text_prot, true, root_level);
 		map_segment(init_pg_dir, NULL, va_offset, __inittext_begin,
 			    __inittext_end, text_prot, false, root_level);
-		dsb(ishst);
 	}
+
+	/* Copy the root page table to its final location */
+	memcpy((void *)swapper_pg_dir + va_offset, init_pg_dir, PGD_SIZE);
+	dsb(ishst);
+	idmap_cpu_replace_ttbr1(swapper_pg_dir);
 }
 
 static void map_fdt(u64 fdt)
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index e969e68de005fd2a..df98f496539f0e39 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -184,21 +184,6 @@ static void __init kasan_map_populate(unsigned long start, unsigned long end,
 	kasan_pgd_populate(start & PAGE_MASK, PAGE_ALIGN(end), node, false);
 }
 
-/*
- * Copy the current shadow region into a new pgdir.
- */
-void __init kasan_copy_shadow(pgd_t *pgdir)
-{
-	pgd_t *pgdp, *pgdp_new, *pgdp_end;
-
-	pgdp = pgd_offset_k(KASAN_SHADOW_START);
-	pgdp_end = pgd_offset_k(KASAN_SHADOW_END);
-	pgdp_new = pgd_offset_pgd(pgdir, KASAN_SHADOW_START);
-	do {
-		set_pgd(pgdp_new, READ_ONCE(*pgdp));
-	} while (pgdp++, pgdp_new++, pgdp != pgdp_end);
-}
-
 static void __init clear_pgds(unsigned long start,
 			unsigned long end)
 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3f631f3bc2f80b2b..81634ff5f6a67476 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -634,9 +634,9 @@ void mark_rodata_ro(void)
 	debug_checkwx();
 }
 
-static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
-				      pgprot_t prot, struct vm_struct *vma,
-				      int flags, unsigned long vm_flags)
+static void __init declare_vma(struct vm_struct *vma,
+			       void *va_start, void *va_end,
+			       unsigned long vm_flags)
 {
 	phys_addr_t pa_start = __pa_symbol(va_start);
 	unsigned long size = va_end - va_start;
@@ -644,9 +644,6 @@ static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
 	BUG_ON(!PAGE_ALIGNED(pa_start));
 	BUG_ON(!PAGE_ALIGNED(size));
 
-	__create_pgd_mapping(pgdp, pa_start, (unsigned long)va_start, size, prot,
-			     early_pgtable_alloc, flags);
-
 	if (!(vm_flags & VM_NO_GUARD))
 		size += PAGE_SIZE;
 
@@ -691,87 +688,17 @@ core_initcall(map_entry_trampoline);
 #endif
 
 /*
- * Open coded check for BTI, only for use to determine configuration
- * for early mappings for before the cpufeature code has run.
+ * Declare the VMA areas for the kernel
  */
-static bool arm64_early_this_cpu_has_bti(void)
+static void __init declare_kernel_vmas(void)
 {
-	u64 pfr1;
-
-	if (!IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
-		return false;
-
-	pfr1 = __read_sysreg_by_encoding(SYS_ID_AA64PFR1_EL1);
-	return cpuid_feature_extract_unsigned_field(pfr1,
-						    ID_AA64PFR1_EL1_BT_SHIFT);
-}
-
-/*
- * Create fine-grained mappings for the kernel.
- */
-static void __init map_kernel(pgd_t *pgdp)
-{
-	static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_inittext,
-				vmlinux_initdata, vmlinux_data;
-
-	/*
-	 * External debuggers may need to write directly to the text
-	 * mapping to install SW breakpoints. Allow this (only) when
-	 * explicitly requested with rodata=off.
-	 */
-	pgprot_t text_prot = rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
-
-	/*
-	 * If we have a CPU that supports BTI and a kernel built for
-	 * BTI then mark the kernel executable text as guarded pages
-	 * now so we don't have to rewrite the page tables later.
-	 */
-	if (arm64_early_this_cpu_has_bti())
-		text_prot = __pgprot_modify(text_prot, PTE_GP, PTE_GP);
+	static struct vm_struct vmlinux_seg[KERNEL_SEGMENT_COUNT];
 
-	/*
-	 * Only rodata will be remapped with different permissions later on,
-	 * all other segments are allowed to use contiguous mappings.
-	 */
-	map_kernel_segment(pgdp, _stext, _etext, text_prot, &vmlinux_text, 0,
-			   VM_NO_GUARD);
-	map_kernel_segment(pgdp, __start_rodata, __inittext_begin, PAGE_KERNEL,
-			   &vmlinux_rodata, NO_CONT_MAPPINGS, VM_NO_GUARD);
-	map_kernel_segment(pgdp, __inittext_begin, __inittext_end, text_prot,
-			   &vmlinux_inittext, 0, VM_NO_GUARD);
-	map_kernel_segment(pgdp, __initdata_begin, __initdata_end, PAGE_KERNEL,
-			   &vmlinux_initdata, 0, VM_NO_GUARD);
-	map_kernel_segment(pgdp, _data, _end, PAGE_KERNEL, &vmlinux_data, 0, 0);
-
-	if (!READ_ONCE(pgd_val(*pgd_offset_pgd(pgdp, FIXADDR_START)))) {
-		/*
-		 * The fixmap falls in a separate pgd to the kernel, and doesn't
-		 * live in the carveout for the swapper_pg_dir. We can simply
-		 * re-use the existing dir for the fixmap.
-		 */
-		set_pgd(pgd_offset_pgd(pgdp, FIXADDR_START),
-			READ_ONCE(*pgd_offset_k(FIXADDR_START)));
-	} else if (CONFIG_PGTABLE_LEVELS > 3) {
-		pgd_t *bm_pgdp;
-		p4d_t *bm_p4dp;
-		pud_t *bm_pudp;
-		/*
-		 * The fixmap shares its top level pgd entry with the kernel
-		 * mapping. This can really only occur when we are running
-		 * with 16k/4 levels, so we can simply reuse the pud level
-		 * entry instead.
-		 */
-		BUG_ON(!IS_ENABLED(CONFIG_ARM64_16K_PAGES));
-		bm_pgdp = pgd_offset_pgd(pgdp, FIXADDR_START);
-		bm_p4dp = p4d_offset(bm_pgdp, FIXADDR_START);
-		bm_pudp = pud_set_fixmap_offset(bm_p4dp, FIXADDR_START);
-		pud_populate(&init_mm, bm_pudp, lm_alias(bm_pmd));
-		pud_clear_fixmap();
-	} else {
-		BUG();
-	}
-
-	kasan_copy_shadow(pgdp);
+	declare_vma(&vmlinux_seg[0], _stext, _etext, VM_NO_GUARD);
+	declare_vma(&vmlinux_seg[1], __start_rodata, __inittext_begin, VM_NO_GUARD);
+	declare_vma(&vmlinux_seg[2], __inittext_begin, __inittext_end, VM_NO_GUARD);
+	declare_vma(&vmlinux_seg[3], __initdata_begin, __initdata_end, VM_NO_GUARD);
+	declare_vma(&vmlinux_seg[4], _data, _end, 0);
 }
 
 void __pi_map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
@@ -807,23 +734,12 @@ static void __init create_idmap(void)
 
 void __init paging_init(void)
 {
-	pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
-	extern pgd_t init_idmap_pg_dir[];
-
-	map_kernel(pgdp);
-	map_mem(pgdp);
-
-	pgd_clear_fixmap();
-
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir), init_idmap_pg_dir);
-	init_mm.pgd = swapper_pg_dir;
-
-	memblock_phys_free(__pa_symbol(init_pg_dir),
-			   __pa_symbol(init_pg_end) - __pa_symbol(init_pg_dir));
+	map_mem(swapper_pg_dir);
 
 	memblock_allow_resize();
 
 	create_idmap();
+	declare_kernel_vmas();
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-- 
2.39.2

