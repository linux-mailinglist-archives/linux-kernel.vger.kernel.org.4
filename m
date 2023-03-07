Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9700F6AE1D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCGOKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCGOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FDF7D0BB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BCE361460
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0CFC4339E;
        Tue,  7 Mar 2023 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198087;
        bh=EtxR6WdIX1pAf3FgtWNSOEDemqq7GCr4fk8qBVA/F5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vN0hgK1ANHWYOwx1zgggu6iVhL/dJd9wsiweC2lh83fAc+e/BX4LddRXN5OB0eN8j
         aOaHUCoRT14fqk3BGy8TF1dv2Sm20ycKx/0ElJF9FTG2TSREPcoisRYCFjaX01cP87
         /9M9h4/wo9TQAbSbQUSE6u0909Hcv7iyilsGYc143tfrIyojWfZWRrW+m2g9nN6jgU
         H+Q9ioYqFPHlufhY8HUlFweoApJhZgVUVnakd0djFlVEMkhrVHCI622DktNKh2nlji
         Oll/chaISrOOrUzSPZQurxhhXimLaFE5KcsR3G+rNk5g/1cduMwMypT1Sr2YPWYqh5
         GivOiIYPG60XQ==
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
Subject: [PATCH v3 37/60] arm64: kernel: Create initial ID map from C code
Date:   Tue,  7 Mar 2023 15:04:59 +0100
Message-Id: <20230307140522.2311461-38-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24376; i=ardb@kernel.org; h=from:subject; bh=EtxR6WdIX1pAf3FgtWNSOEDemqq7GCr4fk8qBVA/F5I=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdJe7ZpJsTjkvFlZ2z/F0pUbEmZtIRBqerDz3amC5UL jv87fjdjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCROfsZGb79XVpeyjihYcJd Wd3b5+bo/nFfyjfxsEHasaRDla9Vgq4x/DPPdLwxUS1tD4uamfrMc7xPLxqVFNZZ8YYW55Qd0Mw tYQMA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm code that creates the initial ID map is rather intricate and
hard to follow. This is problematic because it makes adding support for
things like LPA2 or WXN more difficult than necessary. Also, it is
parameterized like the rest of the MM code to run with a configurable
number of levels, which is rather pointless, given that all AArch64 CPUs
implement support for 48-bit virtual addressing, and that many systems
exist with DRAM located outside of the 39-bit addressable range, which
is the only smaller VA size that is widely used, and we need additional
tricks to make things work in that combination.

So let's bite the bullet, and rip out all the asm macros, and fiddly
code, and replace it with a C implementation based on the newly added
routines for creating the early kernel VA mappings. And while at it,
create the initial ID map based on 48-bit virtual addressing as well,
regardless of the number of configured levels for the kernel proper.

Note that this code may execute with the MMU and caches disabled, and is
therefore not permitted to make unaligned accesses. This shouldn't
generally happen in any case for the algorithm as implemented, but to be
sure, let's pass -mstrict-align to the compiler just in case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h      |  14 -
 arch/arm64/include/asm/kernel-pgtable.h |  50 ++--
 arch/arm64/include/asm/mmu_context.h    |   6 +-
 arch/arm64/kernel/head.S                | 267 ++------------------
 arch/arm64/kernel/image-vars.h          |   1 +
 arch/arm64/kernel/pi/Makefile           |   3 +
 arch/arm64/kernel/pi/map_kernel.c       |  18 ++
 arch/arm64/kernel/pi/map_range.c        |  12 +
 arch/arm64/kernel/pi/pi.h               |   4 +
 arch/arm64/mm/mmu.c                     |   5 -
 arch/arm64/mm/proc.S                    |   2 +-
 11 files changed, 87 insertions(+), 295 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 376a980f2bad08bb..beb53bbd8c19bb1c 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -345,20 +345,6 @@ alternative_cb_end
 	bfi	\valreg, \t1sz, #TCR_T1SZ_OFFSET, #TCR_TxSZ_WIDTH
 	.endm
 
-/*
- * idmap_get_t0sz - get the T0SZ value needed to cover the ID map
- *
- * Calculate the maximum allowed value for TCR_EL1.T0SZ so that the
- * entire ID map region can be mapped. As T0SZ == (64 - #bits used),
- * this number conveniently equals the number of leading zeroes in
- * the physical address of _end.
- */
-	.macro	idmap_get_t0sz, reg
-	adrp	\reg, _end
-	orr	\reg, \reg, #(1 << VA_BITS_MIN) - 1
-	clz	\reg, \reg
-	.endm
-
 /*
  * tcr_compute_pa_size - set TCR.(I)PS to the highest supported
  * ID_AA64MMFR0_EL1.PARange value
diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index bfc35944a5304e8e..f4d5858d2f66821d 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -29,6 +29,7 @@
 #define SWAPPER_TABLE_SHIFT	(SWAPPER_BLOCK_SHIFT + PAGE_SHIFT - 3)
 
 #define SWAPPER_PGTABLE_LEVELS		(CONFIG_PGTABLE_LEVELS - SWAPPER_SKIP_LEVEL)
+#define INIT_IDMAP_PGTABLE_LEVELS	(IDMAP_LEVELS - SWAPPER_SKIP_LEVEL)
 
 #define IDMAP_LEVELS		ARM64_HW_PGTABLE_LEVELS(48)
 #define IDMAP_ROOT_LEVEL	(4 - IDMAP_LEVELS)
@@ -59,44 +60,39 @@
 #define EARLY_ENTRIES(vstart, vend, shift, add) \
 	((((vend) - 1) >> (shift)) - ((vstart) >> (shift)) + 1 + add)
 
-#define EARLY_LEVEL(l, vstart, vend, add)	\
-	(SWAPPER_PGTABLE_LEVELS > l ? EARLY_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + l * (PAGE_SHIFT - 3), add) : 0)
+#define EARLY_LEVEL(l, lvls, vstart, vend, add)	\
+	(lvls > l ? EARLY_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + l * (PAGE_SHIFT - 3), add) : 0)
 
-#define EARLY_PAGES(vstart, vend, add) (1 	/* PGDIR page */				\
-	+ EARLY_LEVEL(3, (vstart), (vend), add) /* each entry needs a next level page table */	\
-	+ EARLY_LEVEL(2, (vstart), (vend), add)	/* each entry needs a next level page table */	\
-	+ EARLY_LEVEL(1, (vstart), (vend), add))/* each entry needs a next level page table */
-#define INIT_DIR_SIZE (PAGE_SIZE * (EARLY_PAGES(KIMAGE_VADDR, _end, EARLY_KASLR) + EARLY_SEGMENT_EXTRA_PAGES))
+#define EARLY_PAGES(lvls, vstart, vend, add) (1 	/* PGDIR page */				\
+	+ EARLY_LEVEL(3, (lvls), (vstart), (vend), add) /* each entry needs a next level page table */	\
+	+ EARLY_LEVEL(2, (lvls), (vstart), (vend), add)	/* each entry needs a next level page table */	\
+	+ EARLY_LEVEL(1, (lvls), (vstart), (vend), add))/* each entry needs a next level page table */
+#define INIT_DIR_SIZE (PAGE_SIZE * (EARLY_PAGES(SWAPPER_PGTABLE_LEVELS, KIMAGE_VADDR, _end, EARLY_KASLR) \
+				    + EARLY_SEGMENT_EXTRA_PAGES))
 
-/* the initial ID map may need two extra pages if it needs to be extended */
-#if VA_BITS < 48
-#define INIT_IDMAP_DIR_SIZE	((INIT_IDMAP_DIR_PAGES + 2) * PAGE_SIZE)
-#else
-#define INIT_IDMAP_DIR_SIZE	(INIT_IDMAP_DIR_PAGES * PAGE_SIZE)
-#endif
-#define INIT_IDMAP_DIR_PAGES	EARLY_PAGES(KIMAGE_VADDR, _end + MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE, 1)
+#define INIT_IDMAP_DIR_PAGES	(EARLY_PAGES(INIT_IDMAP_PGTABLE_LEVELS, KIMAGE_VADDR, _end, 1))
+#define INIT_IDMAP_DIR_SIZE	((INIT_IDMAP_DIR_PAGES + EARLY_IDMAP_EXTRA_PAGES) * PAGE_SIZE)
+
+#define INIT_IDMAP_FDT_PAGES	(EARLY_PAGES(INIT_IDMAP_PGTABLE_LEVELS, 0UL, UL(MAX_FDT_SIZE), 1) - 1)
+#define INIT_IDMAP_FDT_SIZE	((INIT_IDMAP_FDT_PAGES + EARLY_IDMAP_EXTRA_FDT_PAGES) * PAGE_SIZE)
 
 /* The number of segments in the kernel image (text, rodata, inittext, initdata, data+bss) */
 #define KERNEL_SEGMENT_COUNT	5
 
 #if SWAPPER_BLOCK_SIZE > SEGMENT_ALIGN
 #define EARLY_SEGMENT_EXTRA_PAGES (KERNEL_SEGMENT_COUNT + 1)
-#else
-#define EARLY_SEGMENT_EXTRA_PAGES 0
-#endif
-
 /*
- * Initial memory map attributes.
+ * The initial ID map consists of the kernel image, mapped as two separate
+ * segments, and may appear misaligned wrt the swapper block size. This means
+ * we need 3 additional pages. The DT could straddle a swapper block boundary,
+ * so it may need 2.
  */
-#define SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
-#define SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
-
-#ifdef CONFIG_ARM64_4K_PAGES
-#define SWAPPER_RW_MMUFLAGS	(PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS)
-#define SWAPPER_RX_MMUFLAGS	(SWAPPER_RW_MMUFLAGS | PMD_SECT_RDONLY)
+#define EARLY_IDMAP_EXTRA_PAGES		3
+#define EARLY_IDMAP_EXTRA_FDT_PAGES	2
 #else
-#define SWAPPER_RW_MMUFLAGS	(PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS)
-#define SWAPPER_RX_MMUFLAGS	(SWAPPER_RW_MMUFLAGS | PTE_RDONLY)
+#define EARLY_SEGMENT_EXTRA_PAGES	0
+#define EARLY_IDMAP_EXTRA_PAGES		0
+#define EARLY_IDMAP_EXTRA_FDT_PAGES	0
 #endif
 
 /*
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 72dbd6400549c185..f9ae2891e4c72c7f 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -57,11 +57,9 @@ static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
 }
 
 /*
- * TCR.T0SZ value to use when the ID map is active. Usually equals
- * TCR_T0SZ(VA_BITS), unless system RAM is positioned very high in
- * physical memory, in which case it will be smaller.
+ * TCR.T0SZ value to use when the ID map is active.
  */
-extern int idmap_t0sz;
+#define idmap_t0sz	TCR_T0SZ(48)
 
 /*
  * Ensure TCR.T0SZ is set to the provided value.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index fc6a4076d826b728..c6f8c3b1f026c07b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -80,26 +80,42 @@
 	 *  x19        primary_entry() .. start_kernel()        whether we entered with the MMU on
 	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
-	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
 	 *  x25        primary_entry() .. start_kernel()        supported VA size
-	 *  x28        create_idmap()                           callee preserved temp register
 	 */
 SYM_CODE_START(primary_entry)
 	bl	record_mmu_state
 	bl	preserve_boot_args
-	bl	create_idmap
+
+	adrp	x1, early_init_stack
+	mov	sp, x1
+	mov	x29, xzr
+	adrp	x0, init_idmap_pg_dir
+	bl	__pi_create_init_idmap
+
+	/*
+	 * If the page tables have been populated with non-cacheable
+	 * accesses (MMU disabled), invalidate those tables again to
+	 * remove any speculatively loaded cache lines.
+	 */
+	cbnz	x19, 0f
+	dmb     sy
+	mov	x1, x0				// end of used region
+	adrp    x0, init_idmap_pg_dir
+	adr_l	x2, dcache_inval_poc
+	blr	x2
+	b	1f
 
 	/*
 	 * If we entered with the MMU and caches on, clean the ID mapped part
 	 * of the primary boot code to the PoC so we can safely execute it with
 	 * the MMU off.
 	 */
-	cbz	x19, 0f
-	adrp	x0, __idmap_text_start
+0:	adrp	x0, __idmap_text_start
 	adr_l	x1, __idmap_text_end
 	adr_l	x2, dcache_clean_poc
 	blr	x2
-0:	mov	x0, x19
+
+1:	mov	x0, x19
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
 
@@ -175,238 +191,6 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 	ret
 SYM_CODE_END(preserve_boot_args)
 
-/*
- * Macro to populate page table entries, these entries can be pointers to the next level
- * or last level entries pointing to physical memory.
- *
- *	tbl:	page table address
- *	rtbl:	pointer to page table or physical memory
- *	index:	start index to write
- *	eindex:	end index to write - [index, eindex] written to
- *	flags:	flags for pagetable entry to or in
- *	inc:	increment to rtbl between each entry
- *	tmp1:	temporary variable
- *
- * Preserves:	tbl, eindex, flags, inc
- * Corrupts:	index, tmp1
- * Returns:	rtbl
- */
-	.macro populate_entries, tbl, rtbl, index, eindex, flags, inc, tmp1
-.Lpe\@:	phys_to_pte \tmp1, \rtbl
-	orr	\tmp1, \tmp1, \flags	// tmp1 = table entry
-	str	\tmp1, [\tbl, \index, lsl #3]
-	add	\rtbl, \rtbl, \inc	// rtbl = pa next level
-	add	\index, \index, #1
-	cmp	\index, \eindex
-	b.ls	.Lpe\@
-	.endm
-
-/*
- * Compute indices of table entries from virtual address range. If multiple entries
- * were needed in the previous page table level then the next page table level is assumed
- * to be composed of multiple pages. (This effectively scales the end index).
- *
- *	vstart:	virtual address of start of range
- *	vend:	virtual address of end of range - we map [vstart, vend]
- *	shift:	shift used to transform virtual address into index
- *	order:  #imm 2log(number of entries in page table)
- *	istart:	index in table corresponding to vstart
- *	iend:	index in table corresponding to vend
- *	count:	On entry: how many extra entries were required in previous level, scales
- *			  our end index.
- *		On exit: returns how many extra entries required for next page table level
- *
- * Preserves:	vstart, vend
- * Returns:	istart, iend, count
- */
-	.macro compute_indices, vstart, vend, shift, order, istart, iend, count
-	ubfx	\istart, \vstart, \shift, \order
-	ubfx	\iend, \vend, \shift, \order
-	add	\iend, \iend, \count, lsl \order
-	sub	\count, \iend, \istart
-	.endm
-
-/*
- * Map memory for specified virtual address range. Each level of page table needed supports
- * multiple entries. If a level requires n entries the next page table level is assumed to be
- * formed from n pages.
- *
- *	tbl:	location of page table
- *	rtbl:	address to be used for first level page table entry (typically tbl + PAGE_SIZE)
- *	vstart:	virtual address of start of range
- *	vend:	virtual address of end of range - we map [vstart, vend - 1]
- *	flags:	flags to use to map last level entries
- *	phys:	physical address corresponding to vstart - physical memory is contiguous
- *	order:  #imm 2log(number of entries in PGD table)
- *
- * If extra_shift is set, an extra level will be populated if the end address does
- * not fit in 'extra_shift' bits. This assumes vend is in the TTBR0 range.
- *
- * Temporaries:	istart, iend, tmp, count, sv - these need to be different registers
- * Preserves:	vstart, flags
- * Corrupts:	tbl, rtbl, vend, istart, iend, tmp, count, sv
- */
-	.macro map_memory, tbl, rtbl, vstart, vend, flags, phys, order, istart, iend, tmp, count, sv, extra_shift
-	sub \vend, \vend, #1
-	add \rtbl, \tbl, #PAGE_SIZE
-	mov \count, #0
-
-	.ifnb	\extra_shift
-	tst	\vend, #~((1 << (\extra_shift)) - 1)
-	b.eq	.L_\@
-	compute_indices \vstart, \vend, #\extra_shift, #(PAGE_SHIFT - 3), \istart, \iend, \count
-	mov \sv, \rtbl
-	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
-	mov \tbl, \sv
-	.endif
-.L_\@:
-	compute_indices \vstart, \vend, #PGDIR_SHIFT, #\order, \istart, \iend, \count
-	mov \sv, \rtbl
-	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
-	mov \tbl, \sv
-
-#if SWAPPER_PGTABLE_LEVELS > 3
-	compute_indices \vstart, \vend, #PUD_SHIFT, #(PAGE_SHIFT - 3), \istart, \iend, \count
-	mov \sv, \rtbl
-	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
-	mov \tbl, \sv
-#endif
-
-#if SWAPPER_PGTABLE_LEVELS > 2
-	compute_indices \vstart, \vend, #SWAPPER_TABLE_SHIFT, #(PAGE_SHIFT - 3), \istart, \iend, \count
-	mov \sv, \rtbl
-	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
-	mov \tbl, \sv
-#endif
-
-	compute_indices \vstart, \vend, #SWAPPER_BLOCK_SHIFT, #(PAGE_SHIFT - 3), \istart, \iend, \count
-	bic \rtbl, \phys, #SWAPPER_BLOCK_SIZE - 1
-	populate_entries \tbl, \rtbl, \istart, \iend, \flags, #SWAPPER_BLOCK_SIZE, \tmp
-	.endm
-
-/*
- * Remap a subregion created with the map_memory macro with modified attributes
- * or output address. The entire remapped region must have been covered in the
- * invocation of map_memory.
- *
- * x0: last level table address (returned in first argument to map_memory)
- * x1: start VA of the existing mapping
- * x2: start VA of the region to update
- * x3: end VA of the region to update (exclusive)
- * x4: start PA associated with the region to update
- * x5: attributes to set on the updated region
- * x6: order of the last level mappings
- */
-SYM_FUNC_START_LOCAL(remap_region)
-	sub	x3, x3, #1		// make end inclusive
-
-	// Get the index offset for the start of the last level table
-	lsr	x1, x1, x6
-	bfi	x1, xzr, #0, #PAGE_SHIFT - 3
-
-	// Derive the start and end indexes into the last level table
-	// associated with the provided region
-	lsr	x2, x2, x6
-	lsr	x3, x3, x6
-	sub	x2, x2, x1
-	sub	x3, x3, x1
-
-	mov	x1, #1
-	lsl	x6, x1, x6		// block size at this level
-
-	populate_entries x0, x4, x2, x3, x5, x6, x7
-	ret
-SYM_FUNC_END(remap_region)
-
-SYM_FUNC_START_LOCAL(create_idmap)
-	mov	x28, lr
-	/*
-	 * The ID map carries a 1:1 mapping of the physical address range
-	 * covered by the loaded image, which could be anywhere in DRAM. This
-	 * means that the required size of the VA (== PA) space is decided at
-	 * boot time, and could be more than the configured size of the VA
-	 * space for ordinary kernel and user space mappings.
-	 *
-	 * There are three cases to consider here:
-	 * - 39 <= VA_BITS < 48, and the ID map needs up to 48 VA bits to cover
-	 *   the placement of the image. In this case, we configure one extra
-	 *   level of translation on the fly for the ID map only. (This case
-	 *   also covers 42-bit VA/52-bit PA on 64k pages).
-	 *
-	 * - VA_BITS == 48, and the ID map needs more than 48 VA bits. This can
-	 *   only happen when using 64k pages, in which case we need to extend
-	 *   the root level table rather than add a level. Note that we can
-	 *   treat this case as 'always extended' as long as we take care not
-	 *   to program an unsupported T0SZ value into the TCR register.
-	 *
-	 * - Combinations that would require two additional levels of
-	 *   translation are not supported, e.g., VA_BITS==36 on 16k pages, or
-	 *   VA_BITS==39/4k pages with 5-level paging, where the input address
-	 *   requires more than 47 or 48 bits, respectively.
-	 */
-#if (VA_BITS < 48)
-#define IDMAP_PGD_ORDER	(VA_BITS - PGDIR_SHIFT)
-#define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
-
-	/*
-	 * If VA_BITS < 48, we have to configure an additional table level.
-	 * First, we have to verify our assumption that the current value of
-	 * VA_BITS was chosen such that all translation levels are fully
-	 * utilised, and that lowering T0SZ will always result in an additional
-	 * translation level to be configured.
-	 */
-#if VA_BITS != EXTRA_SHIFT
-#error "Mismatch between VA_BITS and page size/number of translation levels"
-#endif
-#else
-#define IDMAP_PGD_ORDER	(PHYS_MASK_SHIFT - PGDIR_SHIFT)
-#define EXTRA_SHIFT
-	/*
-	 * If VA_BITS == 48, we don't have to configure an additional
-	 * translation level, but the top-level table has more entries.
-	 */
-#endif
-	adrp	x0, init_idmap_pg_dir
-	adrp	x3, _text
-	adrp	x6, _end + MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE
-	mov	x7, SWAPPER_RX_MMUFLAGS
-
-	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
-
-	/* Remap [.init].data, BSS and the kernel page tables r/w in the ID map */
-	adrp	x1, _text
-	adrp	x2, __initdata_begin
-	adrp	x3, _end
-	bic	x4, x2, #SWAPPER_BLOCK_SIZE - 1
-	mov	x5, SWAPPER_RW_MMUFLAGS
-	mov	x6, #SWAPPER_BLOCK_SHIFT
-	bl	remap_region
-
-	/* Remap the FDT after the kernel image */
-	adrp	x1, _text
-	adrp	x22, _end + SWAPPER_BLOCK_SIZE
-	bic	x2, x22, #SWAPPER_BLOCK_SIZE - 1
-	bfi	x22, x21, #0, #SWAPPER_BLOCK_SHIFT		// remapped FDT address
-	add	x3, x2, #MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE
-	bic	x4, x21, #SWAPPER_BLOCK_SIZE - 1
-	mov	x5, SWAPPER_RW_MMUFLAGS
-	mov	x6, #SWAPPER_BLOCK_SHIFT
-	bl	remap_region
-
-	/*
-	 * Since the page tables have been populated with non-cacheable
-	 * accesses (MMU disabled), invalidate those tables again to
-	 * remove any speculatively loaded cache lines.
-	 */
-	cbnz	x19, 0f				// skip cache invalidation if MMU is on
-	dmb	sy
-
-	adrp	x0, init_idmap_pg_dir
-	adrp	x1, init_idmap_pg_end
-	bl	dcache_inval_poc
-0:	ret	x28
-SYM_FUNC_END(create_idmap)
-
 	/*
 	 * Initialize CPU registers with task-specific and cpu-specific context.
 	 *
@@ -727,11 +511,6 @@ SYM_FUNC_START_LOCAL(__no_granule_support)
 SYM_FUNC_END(__no_granule_support)
 
 SYM_FUNC_START_LOCAL(__primary_switch)
-	mrs		x1, tcr_el1
-	mov		x2, #64 - VA_BITS
-	tcr_set_t0sz	x1, x2
-	msr		tcr_el1, x1
-
 	adrp	x1, reserved_pg_dir
 	adrp	x2, init_idmap_pg_dir
 	bl	__enable_mmu
@@ -740,7 +519,7 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	mov	sp, x1
 	mov	x29, xzr
 	mov	x0, x20				// pass the full boot status
-	mov	x1, x22				// pass the low FDT mapping
+	mov	x1, x21				// pass the FDT
 	bl	__pi_early_map_kernel		// Map and relocate the kernel
 
 	ldr	x8, =__primary_switched
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 6eeb2a09c8d2441d..6ca235b09a30d5d3 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -47,6 +47,7 @@ PROVIDE(__pi_arm64_use_ng_mappings	= arm64_use_ng_mappings);
 PROVIDE(__pi__ctype			= _ctype);
 PROVIDE(__pi_memstart_offset_seed	= memstart_offset_seed);
 
+PROVIDE(__pi_init_idmap_pg_dir		= init_idmap_pg_dir);
 PROVIDE(__pi_init_pg_dir		= init_pg_dir);
 PROVIDE(__pi_init_pg_end		= init_pg_end);
 
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index 8c2f80a46b9387b0..4393b41f0b7133da 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -11,6 +11,9 @@ KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
 		   -fno-asynchronous-unwind-tables -fno-unwind-tables \
 		   $(call cc-option,-fno-addrsig)
 
+# this code may run with the MMU off so disable unaligned accesses
+CFLAGS_map_range.o += -mstrict-align
+
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS	:= $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 # disable LTO
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index b573c964c7d88d1b..a718714eb671f290 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -129,6 +129,22 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 	}
 }
 
+static void map_fdt(u64 fdt)
+{
+	static u8 ptes[INIT_IDMAP_FDT_SIZE] __initdata __aligned(PAGE_SIZE);
+	u64 efdt = fdt + MAX_FDT_SIZE;
+	u64 ptep = (u64)ptes;
+
+	/*
+	 * Map up to MAX_FDT_SIZE bytes, but avoid overlap with
+	 * the kernel image.
+	 */
+	map_range(&ptep, fdt, (u64)_text > fdt ? min((u64)_text, efdt) : efdt,
+		  fdt, PAGE_KERNEL, IDMAP_ROOT_LEVEL,
+		  (pte_t *)init_idmap_pg_dir, false, 0);
+	dsb(ishst);
+}
+
 asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 {
 	static char const chosen_str[] __initconst = "/chosen";
@@ -137,6 +153,8 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 	int root_level = 4 - CONFIG_PGTABLE_LEVELS;
 	int chosen;
 
+	map_fdt((u64)fdt);
+
 	/* Clear BSS and the initial page tables */
 	memset(__bss_start, 0, (u64)init_pg_end - (u64)__bss_start);
 
diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index 61cbd6e82418c033..8de3fe2c1cb55722 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -85,3 +85,15 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
 		tbl++;
 	}
 }
+
+asmlinkage u64 __init create_init_idmap(pgd_t *pg_dir)
+{
+	u64 ptep = (u64)pg_dir + PAGE_SIZE;
+
+	map_range(&ptep, (u64)_stext, (u64)__initdata_begin, (u64)_stext,
+		  PAGE_KERNEL_ROX, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0);
+	map_range(&ptep, (u64)__initdata_begin, (u64)_end, (u64)__initdata_begin,
+		  PAGE_KERNEL, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0);
+
+	return ptep;
+}
diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
index dfc70828ad0ad2a8..a8fe79c9b111140f 100644
--- a/arch/arm64/kernel/pi/pi.h
+++ b/arch/arm64/kernel/pi/pi.h
@@ -17,6 +17,8 @@ static inline void *prel64_to_pointer(const prel64_t *offset)
 
 extern bool dynamic_scs_is_enabled;
 
+extern pgd_t init_idmap_pg_dir[];
+
 void init_feature_override(u64 boot_status, const void *fdt, int chosen);
 u64 kaslr_early_init(void *fdt, int chosen);
 void relocate_kernel(u64 offset);
@@ -24,3 +26,5 @@ int scs_patch(const u8 eh_frame[], int size);
 
 void map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
 	       int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
+
+asmlinkage u64 create_init_idmap(pgd_t *pgd);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a59433ae4f5f8d02..13f46c911558f21f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -43,8 +43,6 @@
 #define NO_CONT_MAPPINGS	BIT(1)
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
 
-int idmap_t0sz __ro_after_init;
-
 #if VA_BITS > 48
 u64 vabits_actual __ro_after_init = VA_BITS_MIN;
 EXPORT_SYMBOL(vabits_actual);
@@ -798,8 +796,6 @@ void __init paging_init(void)
 	pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
 	extern pgd_t init_idmap_pg_dir[];
 
-	idmap_t0sz = 63UL - __fls(__pa_symbol(_end) | GENMASK(VA_BITS_MIN - 1, 0));
-
 	map_kernel(pgdp);
 	map_mem(pgdp);
 
@@ -814,7 +810,6 @@ void __init paging_init(void)
 	memblock_allow_resize();
 
 	create_idmap();
-	idmap_t0sz = TCR_T0SZ(48);
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c7129b21bfd5191f..d0748f18b2abdf0e 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -200,7 +200,7 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 
-#define KPTI_NG_PTE_FLAGS	(PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS)
+#define KPTI_NG_PTE_FLAGS  (PTE_ATTRINDX(MT_NORMAL) | PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 
 	.pushsection ".idmap.text", "awx"
 
-- 
2.39.2

