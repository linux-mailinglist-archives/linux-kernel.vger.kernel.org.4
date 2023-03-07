Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E176A6AE1E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjCGOMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjCGOMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:12:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB26BDEE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48934B818F3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3720C433D2;
        Tue,  7 Mar 2023 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198101;
        bh=0PDBzg8wzgrWAIdBRQh7oJRLRwPNXTACA1QXrN62KoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSjJrjZrOyi5N8vBSHTP3EUIbXM2M6fNQP2xzAi5tBc0sPscgvRr+/NjFSoZfQCCk
         Oli2XrA16eygeNmOqFLUbMYkl/G9vdg40hlywgUKoQ9qQ1FuKISZk15fd8qjIp5Yy/
         w6jF1um8p/ZVrMAw3iDw3tt0ixz/EzvwE5+Rj4OslXVxbczM14P0Aa9S4jLWfp4hDS
         RkFsUQEXmmtfEh6fZGdT3QHzkBEMZxjzcQpvOg6hx1AqAeLjrmfh+2N+XJxv+PmJPK
         oW5IhIdPSQFmcWTw5qgt+BBh4QzCfELU6DNUolujxQDSklsZpaddw9pYet0dXFPxre
         oGrDuauncxUXA==
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
Subject: [PATCH v3 43/60] arm64: mm: Handle LVA support as a CPU feature
Date:   Tue,  7 Mar 2023 15:05:05 +0100
Message-Id: <20230307140522.2311461-44-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10247; i=ardb@kernel.org; h=from:subject; bh=0PDBzg8wzgrWAIdBRQh7oJRLRwPNXTACA1QXrN62KoY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdpUD+zW72xNf/H74SuMLyw0gj46rMeXdhj4zcOK8X+ 9Yvcl7QUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbCu4CRYe7280J/Qgxf1eb/ 5jyUIrhn4iWL9FdrwnUqdm/7dyLmlAnD/6ynEVz6cyJ0r4qu+yJ3hvPAj7ccvJXsSvv8/yjd/hv mzQUA
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

Currently, we detect CPU support for 52-bit virtual addressing (LVA)
extremely early, before creating the kernel page tables or enabling the
MMU. We cannot override the feature this early, and so large virtual
addressing is always enabled on CPUs that implement support for it if
the software support for it was enabled at build time. It also means we
rely on non-trivial code in asm to deal with this feature.

Given that both the ID map and the TTBR1 mapping of the kernel image are
guaranteed to be 48-bit addressable, it is not actually necessary to
enable support this early, and instead, we can model it as a CPU
feature. That way, we can rely on code patching to get the correct
TCR.T1SZ values programmed on secondary boot and suspend from resume.

On the primary boot path, we simply enable the MMU with 48-bit virtual
addressing initially, and update TCR.T1SZ if LVA is supported from C
code, right before creating the kernel mapping. Given that TTBR1 still
points to reserved_pg_dir at this point, updating TCR.T1SZ should be
safe without the need for explicit TLB maintenance.

Since this gets rid of all accesses to the vabits_actual variable from
asm code that occurred before TCR.T1SZ had been programmed, we no longer
have a need for this variable, and we can replace it with a C expression
that produces the correct value directly, based on the value of TCR.T1SZ.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  9 ++++++
 arch/arm64/include/asm/memory.h     | 13 ++++++++-
 arch/arm64/kernel/cpufeature.c      | 13 +++++++++
 arch/arm64/kernel/head.S            | 29 +++++---------------
 arch/arm64/kernel/image-vars.h      |  1 -
 arch/arm64/kernel/pi/map_kernel.c   |  3 ++
 arch/arm64/kernel/sleep.S           |  3 --
 arch/arm64/mm/mmu.c                 |  5 ----
 arch/arm64/mm/proc.S                |  9 +++---
 arch/arm64/tools/cpucaps            |  1 +
 10 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index edefe3b36fe5c243..a37f4956d5a7ef6e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -989,6 +989,15 @@ static inline bool cpu_has_pac(void)
 	return feat;
 }
 
+static inline bool cpu_has_lva(void)
+{
+	u64 mmfr2;
+
+	mmfr2 = read_sysreg_s(SYS_ID_AA64MMFR2_EL1);
+	return cpuid_feature_extract_unsigned_field(mmfr2,
+						    ID_AA64MMFR2_EL1_VARange_SHIFT);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f96975466ef1b752..3e32d957aadcb2bb 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -183,9 +183,20 @@
 #include <asm/boot.h>
 #include <asm/bug.h>
 #include <asm/sections.h>
+#include <asm/sysreg.h>
+
+static inline u64 __pure read_tcr(void)
+{
+	u64  tcr;
+
+	// read_sysreg() uses asm volatile, so avoid it here
+	asm("mrs %0, tcr_el1" : "=r"(tcr));
+	return tcr;
+}
 
 #if VA_BITS > 48
-extern u64			vabits_actual;
+// For reasons of #include hell, we can't use TCR_T1SZ_OFFSET/TCR_T1SZ_MASK here
+#define vabits_actual		(64 - ((read_tcr() >> 16) & 63))
 #else
 #define vabits_actual		((u64)VA_BITS)
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b206de4758ce6fb3..660dedcae173841a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2752,6 +2752,19 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.cpu_enable = cpu_enable_dit,
 	},
+#ifdef CONFIG_ARM64_VA_BITS_52
+	{
+		.desc = "52-bit Virtual Addressing (LVA)",
+		.capability = ARM64_HAS_VA52,
+		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
+		.sys_reg = SYS_ID_AA64MMFR2_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_width = 4,
+		.field_pos = ID_AA64MMFR2_EL1_VARange_SHIFT,
+		.matches = has_cpuid_feature,
+		.min_field_value = ID_AA64MMFR2_EL1_VARange_52,
+	},
+#endif
 	{},
 };
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c6f8c3b1f026c07b..47ebe3242d7feb7e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -80,7 +80,6 @@
 	 *  x19        primary_entry() .. start_kernel()        whether we entered with the MMU on
 	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
-	 *  x25        primary_entry() .. start_kernel()        supported VA size
 	 */
 SYM_CODE_START(primary_entry)
 	bl	record_mmu_state
@@ -125,14 +124,6 @@ SYM_CODE_START(primary_entry)
 	 * On return, the CPU will be ready for the MMU to be turned on and
 	 * the TCR will have been set.
 	 */
-#if VA_BITS > 48
-	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
-	tst	x0, #0xf << ID_AA64MMFR2_EL1_VARange_SHIFT
-	mov	x0, #VA_BITS
-	mov	x25, #VA_BITS_MIN
-	csel	x25, x25, x0, eq
-	mov	x0, x25
-#endif
 	bl	__cpu_setup			// initialise processor
 	b	__primary_switch
 SYM_CODE_END(primary_entry)
@@ -242,11 +233,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	mov	x0, x20
 	bl	set_cpu_boot_mode_flag
 
-#if VA_BITS > 48
-	adr_l	x8, vabits_actual		// Set this early so KASAN early init
-	str	x25, [x8]			// ... observes the correct value
-	dc	civac, x8			// Make visible to booting secondaries
-#endif
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
@@ -374,10 +360,13 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	 * Common entry point for secondary CPUs.
 	 */
 	mov	x20, x0				// preserve boot mode
+
+#ifdef CONFIG_ARM64_VA_BITS_52
+alternative_if ARM64_HAS_VA52
 	bl	__cpu_secondary_check52bitva
-#if VA_BITS > 48
-	ldr_l	x0, vabits_actual
+alternative_else_nop_endif
 #endif
+
 	bl	__cpu_setup			// initialise processor
 	adrp	x1, swapper_pg_dir
 	adrp	x2, idmap_pg_dir
@@ -480,12 +469,8 @@ SYM_FUNC_START(__enable_mmu)
 	ret
 SYM_FUNC_END(__enable_mmu)
 
+#ifdef CONFIG_ARM64_VA_BITS_52
 SYM_FUNC_START(__cpu_secondary_check52bitva)
-#if VA_BITS > 48
-	ldr_l	x0, vabits_actual
-	cmp	x0, #52
-	b.ne	2f
-
 	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
 	and	x0, x0, #(0xf << ID_AA64MMFR2_EL1_VARange_SHIFT)
 	cbnz	x0, 2f
@@ -496,9 +481,9 @@ SYM_FUNC_START(__cpu_secondary_check52bitva)
 	wfi
 	b	1b
 
-#endif
 2:	ret
 SYM_FUNC_END(__cpu_secondary_check52bitva)
+#endif
 
 SYM_FUNC_START_LOCAL(__no_granule_support)
 	/* Indicate that this CPU can't boot and is stuck in the kernel */
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 1c0e920a2466f851..61d1d283a69ba5d8 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -34,7 +34,6 @@ PROVIDE(__pi___memcpy			= __pi_memcpy);
 PROVIDE(__pi___memmove			= __pi_memmove);
 PROVIDE(__pi___memset			= __pi_memset);
 
-PROVIDE(__pi_vabits_actual		= vabits_actual);
 PROVIDE(__pi_id_aa64isar1_override	= id_aa64isar1_override);
 PROVIDE(__pi_id_aa64isar2_override	= id_aa64isar2_override);
 PROVIDE(__pi_id_aa64mmfr1_override	= id_aa64mmfr1_override);
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index a90c4d6fc75c35d0..c1a5bef4e10a49d7 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -166,6 +166,9 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 	chosen = fdt_path_offset(fdt, chosen_str);
 	init_feature_override(boot_status, fdt, chosen);
 
+	if (VA_BITS > VA_BITS_MIN && cpu_has_lva())
+		sysreg_clear_set(tcr_el1, TCR_T1SZ_MASK, TCR_T1SZ(VA_BITS));
+
 	/*
 	 * The virtual KASLR displacement modulo 2MiB is decided by the
 	 * physical placement of the image, as otherwise, we might not be able
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 2ae7cff1953aaf87..353e71bd40a1e1e5 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -102,9 +102,6 @@ SYM_CODE_START(cpu_resume)
 	mov	x0, xzr
 	bl	init_kernel_el
 	mov	x19, x0			// preserve boot mode
-#if VA_BITS > 48
-	ldr_l	x0, vabits_actual
-#endif
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
 	adrp	x1, swapper_pg_dir
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 81634ff5f6a67476..914745697fb8b30c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -43,11 +43,6 @@
 #define NO_CONT_MAPPINGS	BIT(1)
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
 
-#if VA_BITS > 48
-u64 vabits_actual __ro_after_init = VA_BITS_MIN;
-EXPORT_SYMBOL(vabits_actual);
-#endif
-
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index d0748f18b2abdf0e..a5dc009b7dd5c141 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -396,8 +396,6 @@ SYM_FUNC_END(idmap_kpti_install_ng_mappings)
  *
  *	Initialise the processor for turning the MMU on.
  *
- * Input:
- *	x0 - actual number of VA bits (ignored unless VA_BITS > 48)
  * Output:
  *	Return in x0 the value of the SCTLR_EL1 register.
  */
@@ -422,16 +420,17 @@ SYM_FUNC_START(__cpu_setup)
 	mair	.req	x17
 	tcr	.req	x16
 	mov_q	mair, MAIR_EL1_SET
-	mov_q	tcr, TCR_T0SZ(48) | TCR_T1SZ(VA_BITS) | TCR_CACHE_FLAGS | \
+	mov_q	tcr, TCR_T0SZ(48) | TCR_T1SZ(VA_BITS_MIN) | TCR_CACHE_FLAGS | \
 		     TCR_SMP_FLAGS | TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
 		     TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS | TCR_MTE_FLAGS
 
 	tcr_clear_errata_bits tcr, x9, x5
 
 #ifdef CONFIG_ARM64_VA_BITS_52
-	sub		x9, xzr, x0
-	add		x9, x9, #64
+	mov		x9, #64 - VA_BITS
+alternative_if ARM64_HAS_VA52
 	tcr_set_t1sz	tcr, x9
+alternative_else_nop_endif
 #endif
 
 	/*
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 37b1340e96466411..fce10148f000a8a4 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -43,6 +43,7 @@ HAS_SB
 HAS_STAGE2_FWB
 HAS_TIDCP1
 HAS_TLB_RANGE
+HAS_VA52
 HAS_VIRT_HOST_EXTN
 HAS_WFXT
 HW_DBM
-- 
2.39.2

