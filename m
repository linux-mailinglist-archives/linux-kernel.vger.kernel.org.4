Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF89E6AE1D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCGOKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjCGOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867222A991
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC3E26145F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDF8C4339C;
        Tue,  7 Mar 2023 14:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198080;
        bh=YQWbS+XJ/JSBrJ9hB1PhXjdrQkCZwn5zDRPI22xFlB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uu2tlBVsoW+wPyD231S1oJeski1njGoCs3V4l0uwcUuaOKRljcgXVsZw6xnqaPGZc
         T+fwIU7XBdPo+ihvRgPLntoBXTOxCUsyxRqXIddcmArt7y5+tim9Y+x+5SgC0NCetg
         hkZKiuL7VQwaGwDUMUGcPMBNSCYGYWv1sucqvQMXsT/kDyLTqlpY7L5whRPVvkl/a7
         3EoB9DodaQh7+h2XuQ0Q6CDbRpxx250roGSfdmA1/ItFftgHXmYpM8ZFQJmCvXckpm
         PJjxufWQ6G4zfduOlvklwHtkrI0Mmfi10YnR4rDojosx8B1n3a9iknJIYjUpENxlRA
         bWD0GTNanerXA==
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
Subject: [PATCH v3 34/60] arm64: head: Move early kernel mapping routines into C code
Date:   Tue,  7 Mar 2023 15:04:56 +0100
Message-Id: <20230307140522.2311461-35-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24410; i=ardb@kernel.org; h=from:subject; bh=YQWbS+XJ/JSBrJ9hB1PhXjdrQkCZwn5zDRPI22xFlB8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdJbQkX+la1dlXEZOPSa0X2/dZJGf+z293Q67v/2LC0 v327KJJHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiFisZGXYdcjBRW7fqtUHi ZsXiTeU6wlNEXM5nznmcfmz2urcfj+cw/JUOFVsd9bXmwNz+nMkv5rMdfXApTP+G+upbjV4HNGR e5jACAA==
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

The asm version of the kernel mapping code works fine for creating a
coarse grained identity map, but for mapping the kernel down to its
exact boundaries with the right attributes, it is not suitable. This is
why we create a preliminary RWX kernel mapping first, and then rebuild
it from scratch later on.

So let's reimplement this in C, in a way that will make it unnecessary
to create the kernel page tables yet another time in paging_init().

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/mmu.h          |   1 -
 arch/arm64/include/asm/scs.h          |  32 +---
 arch/arm64/kernel/cpufeature.c        |   2 +-
 arch/arm64/kernel/head.S              |  52 +-----
 arch/arm64/kernel/image-vars.h        |  16 ++
 arch/arm64/kernel/pi/Makefile         |   1 +
 arch/arm64/kernel/pi/idreg-override.c |  22 ++-
 arch/arm64/kernel/pi/kaslr_early.c    |  12 +-
 arch/arm64/kernel/pi/map_kernel.c     | 171 ++++++++++++++++++++
 arch/arm64/kernel/pi/map_range.c      |  87 ++++++++++
 arch/arm64/kernel/pi/patch-scs.c      |  16 +-
 arch/arm64/kernel/pi/pi.h             |  12 ++
 arch/arm64/kernel/pi/relocate.c       |   2 +
 arch/arm64/kernel/setup.c             |   7 -
 arch/arm64/kernel/vmlinux.lds.S       |   4 +-
 arch/arm64/mm/proc.S                  |   1 +
 16 files changed, 317 insertions(+), 121 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 9b9a206e4e9c9d4e..e74dfae8e48214c3 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -70,7 +70,6 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       pgprot_t prot, bool page_mappings_only);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
-extern bool kaslr_requires_kpti(void);
 
 static inline unsigned long kaslr_offset(void)
 {
diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index bcf8ad574807b82c..f246b1515fd59507 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -33,37 +33,11 @@
 #include <asm/cpufeature.h>
 
 #ifdef CONFIG_UNWIND_PATCH_PAC_INTO_SCS
-static inline bool should_patch_pac_into_scs(void)
-{
-	u64 reg;
-
-	/*
-	 * We only enable the shadow call stack dynamically if we are running
-	 * on a system that does not implement PAC or BTI. PAC and SCS provide
-	 * roughly the same level of protection, and BTI relies on the PACIASP
-	 * instructions serving as landing pads, preventing us from patching
-	 * those instructions into something else.
-	 */
-	reg = read_sysreg_s(SYS_ID_AA64ISAR1_EL1);
-	if (SYS_FIELD_GET(ID_AA64ISAR1_EL1, APA, reg) |
-	    SYS_FIELD_GET(ID_AA64ISAR1_EL1, API, reg))
-		return false;
-
-	reg = read_sysreg_s(SYS_ID_AA64ISAR2_EL1);
-	if (SYS_FIELD_GET(ID_AA64ISAR2_EL1, APA3, reg))
-		return false;
-
-	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)) {
-		reg = read_sysreg_s(SYS_ID_AA64PFR1_EL1);
-		if (reg & (0xf << ID_AA64PFR1_EL1_BT_SHIFT))
-			return false;
-	}
-	return true;
-}
-
 static inline void dynamic_scs_init(void)
 {
-	if (should_patch_pac_into_scs()) {
+	extern bool __pi_dynamic_scs_is_enabled;
+
+	if (__pi_dynamic_scs_is_enabled) {
 		pr_info("Enabling dynamic shadow call stack\n");
 		static_branch_enable(&dynamic_scs_enabled);
 	}
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9838934fee028bcb..e9788671be044a47 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1607,7 +1607,7 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
  * state once the SMP CPUs are up and thus make the switch to non-global
  * mappings if required.
  */
-bool kaslr_requires_kpti(void)
+static bool kaslr_requires_kpti(void)
 {
 	/*
 	 * E0PD does a similar job to KPTI so can be used instead
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 81c2dd06420992ea..e45fd99e8ab4272a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -81,7 +81,6 @@
 	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
-	 *  x23        __primary_switch()                       physical misalignment/KASLR offset
 	 *  x25        primary_entry() .. start_kernel()        supported VA size
 	 *  x28        create_idmap()                           callee preserved temp register
 	 */
@@ -408,24 +407,6 @@ SYM_FUNC_START_LOCAL(create_idmap)
 0:	ret	x28
 SYM_FUNC_END(create_idmap)
 
-SYM_FUNC_START_LOCAL(create_kernel_mapping)
-	adrp	x0, init_pg_dir
-	mov_q	x5, KIMAGE_VADDR		// compile time __va(_text)
-#ifdef CONFIG_RELOCATABLE
-	add	x5, x5, x23			// add KASLR displacement
-#endif
-	adrp	x6, _end			// runtime __pa(_end)
-	adrp	x3, _text			// runtime __pa(_text)
-	sub	x6, x6, x3			// _end - _text
-	add	x6, x6, x5			// runtime __va(_end)
-	mov	x7, SWAPPER_RW_MMUFLAGS
-
-	map_memory x0, x1, x5, x6, x7, x3, (VA_BITS - PGDIR_SHIFT), x10, x11, x12, x13, x14
-
-	dsb	ishst				// sync with page table walker
-	ret
-SYM_FUNC_END(create_kernel_mapping)
-
 	/*
 	 * Initialize CPU registers with task-specific and cpu-specific context.
 	 *
@@ -750,44 +731,13 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	adrp	x2, init_idmap_pg_dir
 	bl	__enable_mmu
 
-	// Clear BSS
-	adrp	x0, __bss_start
-	mov	x1, xzr
-	adrp	x2, init_pg_end
-	sub	x2, x2, x0
-	bl	__pi_memset
-	dsb	ishst				// Make zero page visible to PTW
-
 	adrp	x1, early_init_stack
 	mov	sp, x1
 	mov	x29, xzr
 	mov	x0, x20				// pass the full boot status
 	mov	x1, x22				// pass the low FDT mapping
-	bl	__pi_init_feature_override	// Parse cpu feature overrides
-
-#ifdef CONFIG_RELOCATABLE
-	adrp	x23, KERNEL_START
-	and	x23, x23, MIN_KIMG_ALIGN - 1
-#ifdef CONFIG_RANDOMIZE_BASE
-	mov	x0, x22
-	bl	__pi_kaslr_early_init
-	bic	x0, x0, #SZ_2M - 1
-	orr	x23, x23, x0			// record kernel offset
-#endif
-#endif
-	bl	create_kernel_mapping
+	bl	__pi_early_map_kernel		// Map and relocate the kernel
 
-	adrp	x1, init_pg_dir
-	load_ttbr1 x1, x1, x2
-#ifdef CONFIG_RELOCATABLE
-	mov	x0, x23
-	bl	__pi_relocate_kernel
-#endif
-#ifdef CONFIG_UNWIND_PATCH_PAC_INTO_SCS
-	ldr	x0, =__eh_frame_start
-	ldr	x1, =__eh_frame_end
-	bl	__pi_scs_patch_vmlinux
-#endif
 	ldr	x8, =__primary_switched
 	adrp	x0, KERNEL_START		// __pa(KERNEL_START)
 	br	x8
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index b7fa7fbf8fa543a6..6eeb2a09c8d2441d 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -43,9 +43,25 @@ PROVIDE(__pi_id_aa64pfr1_override	= id_aa64pfr1_override);
 PROVIDE(__pi_id_aa64smfr0_override	= id_aa64smfr0_override);
 PROVIDE(__pi_id_aa64zfr0_override	= id_aa64zfr0_override);
 PROVIDE(__pi_arm64_sw_feature_override	= arm64_sw_feature_override);
+PROVIDE(__pi_arm64_use_ng_mappings	= arm64_use_ng_mappings);
 PROVIDE(__pi__ctype			= _ctype);
 PROVIDE(__pi_memstart_offset_seed	= memstart_offset_seed);
 
+PROVIDE(__pi_init_pg_dir		= init_pg_dir);
+PROVIDE(__pi_init_pg_end		= init_pg_end);
+
+PROVIDE(__pi__text			= _text);
+PROVIDE(__pi__stext               	= _stext);
+PROVIDE(__pi__etext               	= _etext);
+PROVIDE(__pi___start_rodata       	= __start_rodata);
+PROVIDE(__pi___inittext_begin     	= __inittext_begin);
+PROVIDE(__pi___inittext_end       	= __inittext_end);
+PROVIDE(__pi___initdata_begin     	= __initdata_begin);
+PROVIDE(__pi___initdata_end       	= __initdata_end);
+PROVIDE(__pi__data                	= _data);
+PROVIDE(__pi___bss_start		= __bss_start);
+PROVIDE(__pi__end			= _end);
+
 #ifdef CONFIG_KVM
 
 /*
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index a8b302245f15326a..8c2f80a46b9387b0 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -39,6 +39,7 @@ $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
 obj-y					:= idreg-override.pi.o \
+					   map_kernel.pi.o map_range.pi.o \
 					   lib-fdt.pi.o lib-fdt_ro.pi.o
 obj-$(CONFIG_RELOCATABLE)		+= relocate.pi.o
 obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr_early.pi.o
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index 6c547cccaf6a9e9c..265b35b09dd488f1 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -301,37 +301,35 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 	} while (1);
 }
 
-static __init const u8 *get_bootargs_cmdline(const void *fdt)
+static __init const u8 *get_bootargs_cmdline(const void *fdt, int node)
 {
+	static char const bootargs[] __initconst = "bootargs";
 	const u8 *prop;
-	int node;
 
-	node = fdt_path_offset(fdt, "/chosen");
 	if (node < 0)
 		return NULL;
 
-	prop = fdt_getprop(fdt, node, "bootargs", NULL);
+	prop = fdt_getprop(fdt, node, bootargs, NULL);
 	if (!prop)
 		return NULL;
 
 	return strlen(prop) ? prop : NULL;
 }
 
-static __init void parse_cmdline(const void *fdt)
+static __init void parse_cmdline(const void *fdt, int chosen)
 {
-	const u8 *prop = get_bootargs_cmdline(fdt);
+	static char const cmdline[] __initconst = CONFIG_CMDLINE;
+	const u8 *prop = get_bootargs_cmdline(fdt, chosen);
 
 	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !prop)
-		__parse_cmdline(CONFIG_CMDLINE, true);
+		__parse_cmdline(cmdline, true);
 
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && prop)
 		__parse_cmdline(prop, true);
 }
 
-/* Keep checkers quiet */
-void init_feature_override(u64 boot_status, const void *fdt);
-
-asmlinkage void __init init_feature_override(u64 boot_status, const void *fdt)
+void __init init_feature_override(u64 boot_status, const void *fdt,
+				  int chosen)
 {
 	struct arm64_ftr_override *override;
 	const struct ftr_set_desc *reg;
@@ -347,7 +345,7 @@ asmlinkage void __init init_feature_override(u64 boot_status, const void *fdt)
 
 	__boot_status = boot_status;
 
-	parse_cmdline(fdt);
+	parse_cmdline(fdt, chosen);
 
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
 		reg = prel64_to_pointer(&regs[i].reg_prel);
diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index eeecee7ffd6fa125..0257b43819db85eb 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -16,17 +16,17 @@
 #include <asm/memory.h>
 #include <asm/pgtable.h>
 
+#include "pi.h"
+
 extern u16 memstart_offset_seed;
 
-static u64 __init get_kaslr_seed(void *fdt)
+static u64 __init get_kaslr_seed(void *fdt, int node)
 {
-	static char const chosen_str[] __initconst = "chosen";
 	static char const seed_str[] __initconst = "kaslr-seed";
-	int node, len;
 	fdt64_t *prop;
 	u64 ret;
+	int len;
 
-	node = fdt_path_offset(fdt, chosen_str);
 	if (node < 0)
 		return 0;
 
@@ -39,14 +39,14 @@ static u64 __init get_kaslr_seed(void *fdt)
 	return ret;
 }
 
-asmlinkage u64 __init kaslr_early_init(void *fdt)
+u64 __init kaslr_early_init(void *fdt, int chosen)
 {
 	u64 seed, range;
 
 	if (kaslr_disabled_cmdline())
 		return 0;
 
-	seed = get_kaslr_seed(fdt);
+	seed = get_kaslr_seed(fdt, chosen);
 	if (!seed) {
 		if (!__early_cpu_has_rndr() ||
 		    !__arm64_rndr((unsigned long *)&seed))
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
new file mode 100644
index 0000000000000000..b573c964c7d88d1b
--- /dev/null
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2023 Google LLC
+// Author: Ard Biesheuvel <ardb@google.com>
+
+#include <linux/init.h>
+#include <linux/libfdt.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+#include <asm/memory.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/tlbflush.h>
+
+#include "pi.h"
+
+extern const u8 __eh_frame_start[], __eh_frame_end[];
+
+extern void idmap_cpu_replace_ttbr1(void *pgdir);
+
+static void map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
+			void *start, void *end, pgprot_t prot,
+			bool may_use_cont, int root_level)
+{
+	map_range(pgd, ((u64)start + va_offset) & ~PAGE_OFFSET,
+		  ((u64)end + va_offset) & ~PAGE_OFFSET, (u64)start,
+		  prot, root_level, (pte_t *)pg_dir, may_use_cont, 0);
+}
+
+static void unmap_segment(pgd_t *pg_dir, u64 va_offset, void *start,
+			  void *end, int root_level)
+{
+	map_segment(pg_dir, NULL, va_offset, start, end, __pgprot(0),
+		    false, root_level);
+}
+
+static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
+{
+	bool enable_scs = IS_ENABLED(CONFIG_UNWIND_PATCH_PAC_INTO_SCS);
+	bool twopass = IS_ENABLED(CONFIG_RELOCATABLE);
+	u64 pgdp = (u64)init_pg_dir + PAGE_SIZE;
+	pgprot_t text_prot = PAGE_KERNEL_ROX;
+	pgprot_t data_prot = PAGE_KERNEL;
+	pgprot_t prot;
+
+	/*
+	 * External debuggers may need to write directly to the text mapping to
+	 * install SW breakpoints. Allow this (only) when explicitly requested
+	 * with rodata=off.
+	 */
+	if (cpuid_feature_extract_unsigned_field(arm64_sw_feature_override.val,
+						 ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF))
+		text_prot = PAGE_KERNEL_EXEC;
+
+	/*
+	 * We only enable the shadow call stack dynamically if we are running
+	 * on a system that does not implement PAC or BTI. PAC and SCS provide
+	 * roughly the same level of protection, and BTI relies on the PACIASP
+	 * instructions serving as landing pads, preventing us from patching
+	 * those instructions into something else.
+	 */
+	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL) && cpu_has_pac())
+		enable_scs = false;
+
+	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && cpu_has_bti()) {
+		enable_scs = false;
+
+		/*
+		 * If we have a CPU that supports BTI and a kernel built for
+		 * BTI then mark the kernel executable text as guarded pages
+		 * now so we don't have to rewrite the page tables later.
+		 */
+		text_prot = __pgprot_modify(text_prot, PTE_GP, PTE_GP);
+	}
+
+	/* Map all code read-write on the first pass if needed */
+	twopass |= enable_scs;
+	prot = twopass ? data_prot : text_prot;
+
+	map_segment(init_pg_dir, &pgdp, va_offset, _stext, _etext, prot,
+		    !twopass, root_level);
+	map_segment(init_pg_dir, &pgdp, va_offset, __start_rodata,
+		    __inittext_begin, data_prot, false, root_level);
+	map_segment(init_pg_dir, &pgdp, va_offset, __inittext_begin,
+		    __inittext_end, prot, false, root_level);
+	map_segment(init_pg_dir, &pgdp, va_offset, __initdata_begin,
+		    __initdata_end, data_prot, false, root_level);
+	map_segment(init_pg_dir, &pgdp, va_offset, _data, _end, data_prot,
+		    true, root_level);
+	dsb(ishst);
+
+	idmap_cpu_replace_ttbr1(init_pg_dir);
+
+	if (twopass) {
+		if (IS_ENABLED(CONFIG_RELOCATABLE))
+			relocate_kernel(kaslr_offset);
+
+		if (enable_scs) {
+			scs_patch(__eh_frame_start + va_offset,
+				  __eh_frame_end - __eh_frame_start);
+			asm("ic ialluis");
+
+			dynamic_scs_is_enabled = true;
+		}
+
+		/*
+		 * Unmap the text region before remapping it, to avoid
+		 * potential TLB conflicts when creating the contiguous
+		 * descriptors.
+		 */
+		unmap_segment(init_pg_dir, va_offset, _stext, _etext,
+			      root_level);
+		dsb(ishst);
+		isb();
+		__tlbi(vmalle1);
+		isb();
+
+		/*
+		 * Remap these segments with different permissions
+		 * No new page table allocations should be needed
+		 */
+		map_segment(init_pg_dir, NULL, va_offset, _stext, _etext,
+			    text_prot, true, root_level);
+		map_segment(init_pg_dir, NULL, va_offset, __inittext_begin,
+			    __inittext_end, text_prot, false, root_level);
+		dsb(ishst);
+	}
+}
+
+asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
+{
+	static char const chosen_str[] __initconst = "/chosen";
+	u64 va_base, pa_base = (u64)&_text;
+	u64 kaslr_offset = pa_base % MIN_KIMG_ALIGN;
+	int root_level = 4 - CONFIG_PGTABLE_LEVELS;
+	int chosen;
+
+	/* Clear BSS and the initial page tables */
+	memset(__bss_start, 0, (u64)init_pg_end - (u64)__bss_start);
+
+	/* Parse the command line for CPU feature overrides */
+	chosen = fdt_path_offset(fdt, chosen_str);
+	init_feature_override(boot_status, fdt, chosen);
+
+	/*
+	 * The virtual KASLR displacement modulo 2MiB is decided by the
+	 * physical placement of the image, as otherwise, we might not be able
+	 * to create the early kernel mapping using 2 MiB block descriptors. So
+	 * take the low bits of the KASLR offset from the physical address, and
+	 * fill in the high bits from the seed.
+	 */
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
+		u64 kaslr_seed = kaslr_early_init(fdt, chosen);
+
+		/*
+		 * Assume that any CPU that does not implement E0PD needs KPTI
+		 * to ensure that KASLR randomized addresses will not leak.
+		 * This means we need to use non-global mappings for the kernel
+		 * text and data.
+		 */
+		if (kaslr_seed && !cpu_has_e0pd())
+			arm64_use_ng_mappings = true;
+
+		kaslr_offset |= kaslr_seed & ~(MIN_KIMG_ALIGN - 1);
+	}
+
+	va_base = KIMAGE_VADDR + kaslr_offset;
+	map_kernel(kaslr_offset, va_base - pa_base, root_level);
+}
diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
new file mode 100644
index 0000000000000000..61cbd6e82418c033
--- /dev/null
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2023 Google LLC
+// Author: Ard Biesheuvel <ardb@google.com>
+
+#include <linux/types.h>
+#include <linux/sizes.h>
+
+#include <asm/memory.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+
+#include "pi.h"
+
+/**
+ * map_range - Map a contiguous range of physical pages into virtual memory
+ *
+ * @pte:		Address of physical pointer to array of pages to
+ *			allocate page tables from
+ * @start:		Virtual address of the start of the range
+ * @end:		Virtual address of the end of the range (exclusive)
+ * @pa:			Physical address of the start of the range
+ * @level:		Translation level for the mapping
+ * @tbl:		The level @level page table to create the mappings in
+ * @may_use_cont:	Whether the use of the contiguous attribute is allowed
+ * @va_offset:		Offset between a physical page and its current mapping
+ * 			in the VA space
+ */
+void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
+		      int level, pte_t *tbl, bool may_use_cont, u64 va_offset)
+{
+	u64 cmask = (level == 3) ? CONT_PTE_SIZE - 1 : U64_MAX;
+	u64 protval = pgprot_val(prot) & ~PTE_TYPE_MASK;
+	int lshift = (3 - level) * (PAGE_SHIFT - 3);
+	u64 lmask = (PAGE_SIZE << lshift) - 1;
+
+	start	&= PAGE_MASK;
+	pa	&= PAGE_MASK;
+
+	/* Advance tbl to the entry that covers start */
+	tbl += (start >> (lshift + PAGE_SHIFT)) % PTRS_PER_PTE;
+
+	/*
+	 * Set the right block/page bits for this level unless we are
+	 * clearing the mapping
+	 */
+	if (protval)
+		protval |= (level < 3) ? PMD_TYPE_SECT : PTE_TYPE_PAGE;
+
+	while (start < end) {
+		u64 next = min((start | lmask) + 1, PAGE_ALIGN(end));
+
+		if (level < 3 && (start | next | pa) & lmask) {
+			/*
+			 * This chunk needs a finer grained mapping. Create a
+			 * table mapping if necessary and recurse.
+			 */
+			if (pte_none(*tbl)) {
+				*tbl = __pte(__phys_to_pte_val(*pte) |
+					     PMD_TYPE_TABLE | PMD_TABLE_UXN);
+				*pte += PTRS_PER_PTE * sizeof(pte_t);
+			}
+			map_range(pte, start, next, pa, prot, level + 1,
+				  (pte_t *)(__pte_to_phys(*tbl) + va_offset),
+				  may_use_cont, va_offset);
+		} else {
+			/*
+			 * Start a contiguous range if start and pa are
+			 * suitably aligned
+			 */
+			if (((start | pa) & cmask) == 0 && may_use_cont)
+				protval |= PTE_CONT;
+
+			/*
+			 * Clear the contiguous attribute if the remaining
+			 * range does not cover a contiguous block
+			 */
+			if ((end & ~cmask) <= start)
+				protval &= ~PTE_CONT;
+
+			/* Put down a block or page mapping */
+			*tbl = __pte(__phys_to_pte_val(pa) | protval);
+		}
+		pa += next - start;
+		start = next;
+		tbl++;
+	}
+}
diff --git a/arch/arm64/kernel/pi/patch-scs.c b/arch/arm64/kernel/pi/patch-scs.c
index c65ef40d1e6b6b30..49d8b40e61bc050d 100644
--- a/arch/arm64/kernel/pi/patch-scs.c
+++ b/arch/arm64/kernel/pi/patch-scs.c
@@ -11,6 +11,10 @@
 
 #include <asm/scs.h>
 
+#include "pi.h"
+
+bool dynamic_scs_is_enabled;
+
 //
 // This minimal DWARF CFI parser is partially based on the code in
 // arch/arc/kernel/unwind.c, and on the document below:
@@ -46,8 +50,6 @@
 #define DW_CFA_GNU_negative_offset_extended 0x2f
 #define DW_CFA_hi_user                      0x3f
 
-extern const u8 __eh_frame_start[], __eh_frame_end[];
-
 enum {
 	PACIASP		= 0xd503233f,
 	AUTIASP		= 0xd50323bf,
@@ -250,13 +252,3 @@ int scs_patch(const u8 eh_frame[], int size)
 	}
 	return 0;
 }
-
-asmlinkage void __init scs_patch_vmlinux(const u8 start[], const u8 end[])
-{
-	if (!should_patch_pac_into_scs())
-		return;
-
-	scs_patch(start, end - start);
-	asm("ic ialluis");
-	isb();
-}
diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
index f455ad385976a664..dfc70828ad0ad2a8 100644
--- a/arch/arm64/kernel/pi/pi.h
+++ b/arch/arm64/kernel/pi/pi.h
@@ -2,6 +2,8 @@
 // Copyright 2023 Google LLC
 // Author: Ard Biesheuvel <ardb@google.com>
 
+#include <linux/types.h>
+
 #define __prel64_initconst	__section(".init.rodata.prel64")
 
 typedef volatile signed long prel64_t;
@@ -12,3 +14,13 @@ static inline void *prel64_to_pointer(const prel64_t *offset)
 		return NULL;
 	return (void *)offset + *offset;
 }
+
+extern bool dynamic_scs_is_enabled;
+
+void init_feature_override(u64 boot_status, const void *fdt, int chosen);
+u64 kaslr_early_init(void *fdt, int chosen);
+void relocate_kernel(u64 offset);
+int scs_patch(const u8 eh_frame[], int size);
+
+void map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
+	       int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
diff --git a/arch/arm64/kernel/pi/relocate.c b/arch/arm64/kernel/pi/relocate.c
index 1853408ea76b0e5d..2407d269639870fc 100644
--- a/arch/arm64/kernel/pi/relocate.c
+++ b/arch/arm64/kernel/pi/relocate.c
@@ -7,6 +7,8 @@
 #include <linux/init.h>
 #include <linux/types.h>
 
+#include "pi.h"
+
 extern const Elf64_Rela rela_start[], rela_end[];
 extern const u64 relr_start[], relr_end[];
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index bda21a9245943c57..a4578c823ab57b6f 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -281,13 +281,6 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 
 	*cmdline_p = boot_command_line;
 
-	/*
-	 * If know now we are going to need KPTI then use non-global
-	 * mappings from the start, avoiding the cost of rewriting
-	 * everything later.
-	 */
-	arm64_use_ng_mappings = kaslr_requires_kpti();
-
 	early_fixmap_init();
 	early_ioremap_init();
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6c79ad2945749260..e22bf17209c80ff9 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -126,9 +126,9 @@ jiffies = jiffies_64;
 #ifdef CONFIG_UNWIND_TABLES
 #define UNWIND_DATA_SECTIONS				\
 	.eh_frame : {					\
-		__eh_frame_start = .;			\
+		__pi___eh_frame_start = .;		\
 		*(.eh_frame)				\
-		__eh_frame_end = .;			\
+		__pi___eh_frame_end = .;		\
 	}
 #else
 #define UNWIND_DATA_SECTIONS
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 91410f48809000a0..82e88f4521737c0e 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -195,6 +195,7 @@ SYM_TYPED_FUNC_START(idmap_cpu_replace_ttbr1)
 
 	ret
 SYM_FUNC_END(idmap_cpu_replace_ttbr1)
+SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 	.popsection
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-- 
2.39.2

