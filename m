Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F7C6AE1EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjCGONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjCGOMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:12:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B538587377
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 00690CE1BDC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584A1C433A7;
        Tue,  7 Mar 2023 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198116;
        bh=uqt4IdnYXpiB6CSkE9eZAiNwpiziaGeY81Q1yCJ946w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BC3Y5e2MYeAU6DTvADsWLXprN6x9wRbh2ZEgEu6ytUqI0LdRxXBxWQOKb76aG+kVF
         mO8IqZNU0JuotC7I6FA22ca3exI2hdnnWwz2SDYs6+TSO/iKKGX9fe3myr6yerQmof
         ojiWi3+gKbyG8ZUwjWZsc7aspR2750I7eCs5R3YtfCXzwGlSirQijFiszh4hi6XjJ9
         K8iofrYpN04JnsrGyNyiYyXZLuLCbH0BrgCXO01oAfnN/I62YoTfTVhYCF+rLSBKUf
         BkaAvUmFp0pZ8Y7Psml/mX+tRMwk9aJG3RFIr/bR8KS3zyZPcr+gp3djb5EIj2xBeb
         9tdWACaDMSN5g==
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
Subject: [PATCH v3 49/60] arm64: Enable LPA2 at boot if supported by the system
Date:   Tue,  7 Mar 2023 15:05:11 +0100
Message-Id: <20230307140522.2311461-50-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13392; i=ardb@kernel.org; h=from:subject; bh=uqt4IdnYXpiB6CSkE9eZAiNwpiziaGeY81Q1yCJ946w=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdpWHfi7pZB290+LaLf56Q9+HXx+m3+9j4Nii1W3nuD w0NinraUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYylY3hf5xsSNrOd0euH3VL O8W06oLHvQmFzg+3bPpw33ifnIMl10NGhiNPlVfpv/q/ROWg0d4NTW8brka5zItbNFvoeKK4I8e C3TwA
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

Update the early kernel mapping code to take 52-bit virtual addressing
into account based on the LPA2 feature. This is a bit more involved than
LVA (which is supported with 64k pages only), given that some page table
descriptor bits change meaning in this case.

To keep the handling in asm to a minimum, the initial ID map is still
created with 48-bit virtual addressing, which implies that the kernel
image must be loaded into 48-bit addressable physical memory. This is
currently required by the boot protocol, even though we happen to
support placement outside of that for LVA/64k based configurations.

Enabling LPA2 involves more than setting TCR.T1SZ to a lower value,
there is also a DS bit in TCR that needs to be set, and which changes
the meaning of bits [9:8] in all page table descriptors. Since we cannot
enable DS and every live page table descriptor at the same time, let's
pivot through another temporary mapping. This avoids the need to
reintroduce manipulations of the page tables with the MMU and caches
disabled.

To permit the LPA2 feature to be overridden on the kernel command line,
which may be necessary to work around silicon errata, or to deal with
mismatched features on heterogeneous SoC designs, test for CPU feature
overrides first, and only then enable LPA2.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h  |  8 ++-
 arch/arm64/include/asm/cpufeature.h | 18 +++++
 arch/arm64/include/asm/memory.h     |  4 ++
 arch/arm64/kernel/head.S            |  8 +++
 arch/arm64/kernel/image-vars.h      |  1 +
 arch/arm64/kernel/pi/map_kernel.c   | 70 +++++++++++++++++++-
 arch/arm64/kernel/pi/map_range.c    | 11 ++-
 arch/arm64/kernel/pi/pi.h           |  4 +-
 arch/arm64/mm/init.c                |  2 +-
 arch/arm64/mm/mmu.c                 |  6 +-
 arch/arm64/mm/proc.S                |  3 +
 11 files changed, 124 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 55e8731844cf7eb7..d5e139ce0820479b 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -581,11 +581,17 @@ alternative_endif
  * but we have to add an offset so that the TTBR1 address corresponds with the
  * pgdir entry that covers the lowest 48-bit addressable VA.
  *
+ * Note that this trick is only used for LVA/64k pages - LPA2/4k pages uses an
+ * additional paging level, and on LPA2/16k pages, we would end up with a root
+ * level table with only 2 entries, which is suboptimal in terms of TLB
+ * utilization, so there we fall back to 47 bits of translation if LPA2 is not
+ * supported.
+ *
  * orr is used as it can cover the immediate value (and is idempotent).
  * 	ttbr: Value of ttbr to set, modified.
  */
 	.macro	offset_ttbr1, ttbr, tmp
-#ifdef CONFIG_ARM64_VA_BITS_52
+#if defined(CONFIG_ARM64_VA_BITS_52) && !defined(CONFIG_ARM64_LPA2)
 	mrs	\tmp, tcr_el1
 	and	\tmp, \tmp, #TCR_T1SZ_MASK
 	cmp	\tmp, #TCR_T1SZ(VA_BITS_MIN)
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7faf9a48339e7c8c..170e18cb2b4faf11 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -1002,6 +1002,24 @@ static inline bool cpu_has_lva(void)
 						    ID_AA64MMFR2_EL1_VARange_SHIFT);
 }
 
+static inline bool cpu_has_lpa2(void)
+{
+#ifdef CONFIG_ARM64_LPA2
+	u64 mmfr0;
+	int feat;
+
+	mmfr0 = read_sysreg(id_aa64mmfr0_el1);
+	mmfr0 &= ~id_aa64mmfr0_override.mask;
+	mmfr0 |= id_aa64mmfr0_override.val;
+	feat = cpuid_feature_extract_signed_field(mmfr0,
+						  ID_AA64MMFR0_EL1_TGRAN_SHIFT);
+
+	return feat >= ID_AA64MMFR0_EL1_TGRAN_LPA2;
+#else
+	return false;
+#endif
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 3e32d957aadcb2bb..3163f0748d90b313 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -54,7 +54,11 @@
 #define FIXADDR_TOP		(ULONG_MAX - SZ_8M + 1)
 
 #if VA_BITS > 48
+#ifdef CONFIG_ARM64_16K_PAGES
+#define VA_BITS_MIN		(47)
+#else
 #define VA_BITS_MIN		(48)
+#endif
 #else
 #define VA_BITS_MIN		(VA_BITS)
 #endif
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 47ebe3242d7feb7e..17b2a5518f5b7f3b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -89,6 +89,7 @@ SYM_CODE_START(primary_entry)
 	mov	sp, x1
 	mov	x29, xzr
 	adrp	x0, init_idmap_pg_dir
+	mov	x1, xzr
 	bl	__pi_create_init_idmap
 
 	/*
@@ -471,9 +472,16 @@ SYM_FUNC_END(__enable_mmu)
 
 #ifdef CONFIG_ARM64_VA_BITS_52
 SYM_FUNC_START(__cpu_secondary_check52bitva)
+#ifndef CONFIG_ARM64_LPA2
 	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
 	and	x0, x0, #(0xf << ID_AA64MMFR2_EL1_VARange_SHIFT)
 	cbnz	x0, 2f
+#else
+	mrs	x0, id_aa64mmfr0_el1
+	sbfx	x0, x0, #ID_AA64MMFR0_EL1_TGRAN_SHIFT, 4
+	cmp	x0, #ID_AA64MMFR0_EL1_TGRAN_LPA2
+	b.ge	2f
+#endif
 
 	update_early_cpu_boot_status \
 		CPU_STUCK_IN_KERNEL | CPU_STUCK_REASON_52_BIT_VA, x0, x1
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 79a7e0e3edd1aa21..15e396c9113189f9 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -49,6 +49,7 @@ PROVIDE(__pi__ctype			= _ctype);
 PROVIDE(__pi_memstart_offset_seed	= memstart_offset_seed);
 
 PROVIDE(__pi_init_idmap_pg_dir		= init_idmap_pg_dir);
+PROVIDE(__pi_init_idmap_pg_end		= init_idmap_pg_end);
 PROVIDE(__pi_init_pg_dir		= init_pg_dir);
 PROVIDE(__pi_init_pg_end		= init_pg_end);
 PROVIDE(__pi_swapper_pg_dir		= swapper_pg_dir);
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index c1a5bef4e10a49d7..a14b7c1236b5707c 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -128,11 +128,64 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 	}
 
 	/* Copy the root page table to its final location */
-	memcpy((void *)swapper_pg_dir + va_offset, init_pg_dir, PGD_SIZE);
+	memcpy((void *)swapper_pg_dir + va_offset, init_pg_dir, PAGE_SIZE);
 	dsb(ishst);
 	idmap_cpu_replace_ttbr1(swapper_pg_dir);
 }
 
+static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttbr)
+{
+	u64 sctlr = read_sysreg(sctlr_el1);
+	u64 tcr = read_sysreg(tcr_el1) | TCR_DS;
+
+	asm("	msr	sctlr_el1, %0		;"
+	    "	isb				;"
+	    "   msr     ttbr0_el1, %1		;"
+	    "   msr     tcr_el1, %2		;"
+	    "	isb				;"
+	    "	tlbi    vmalle1			;"
+	    "	dsb     nsh			;"
+	    "	isb				;"
+	    "	msr     sctlr_el1, %3		;"
+	    "	isb				;"
+	    ::	"r"(sctlr & ~SCTLR_ELx_M), "r"(ttbr), "r"(tcr), "r"(sctlr));
+}
+
+static void __init remap_idmap_for_lpa2(void)
+{
+	/* clear the bits that change meaning once LPA2 is turned on */
+	pteval_t mask = PTE_SHARED;
+
+	/*
+	 * We have to clear bits [9:8] in all block or page descriptors in the
+	 * initial ID map, as otherwise they will be (mis)interpreted as
+	 * physical address bits once we flick the LPA2 switch (TCR.DS). Since
+	 * we cannot manipulate live descriptors in that way without creating
+	 * potential TLB conflicts, let's create another temporary ID map in a
+	 * LPA2 compatible fashion, and update the initial ID map while running
+	 * from that.
+	 */
+	create_init_idmap(init_pg_dir, mask);
+	dsb(ishst);
+	set_ttbr0_for_lpa2((u64)init_pg_dir);
+
+	/*
+	 * Recreate the initial ID map with the same granularity as before.
+	 * Don't bother with the FDT, we no longer need it after this.
+	 */
+	memset(init_idmap_pg_dir, 0,
+	       (u64)init_idmap_pg_dir - (u64)init_idmap_pg_end);
+
+	create_init_idmap(init_idmap_pg_dir, mask);
+	dsb(ishst);
+
+	/* switch back to the updated initial ID map */
+	set_ttbr0_for_lpa2((u64)init_idmap_pg_dir);
+
+	/* wipe the temporary ID map from memory */
+	memset(init_pg_dir, 0, (u64)init_pg_end - (u64)init_pg_dir);
+}
+
 static void map_fdt(u64 fdt)
 {
 	static u8 ptes[INIT_IDMAP_FDT_SIZE] __initdata __aligned(PAGE_SIZE);
@@ -155,6 +208,7 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 	u64 va_base, pa_base = (u64)&_text;
 	u64 kaslr_offset = pa_base % MIN_KIMG_ALIGN;
 	int root_level = 4 - CONFIG_PGTABLE_LEVELS;
+	int va_bits = VA_BITS;
 	int chosen;
 
 	map_fdt((u64)fdt);
@@ -166,8 +220,15 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 	chosen = fdt_path_offset(fdt, chosen_str);
 	init_feature_override(boot_status, fdt, chosen);
 
-	if (VA_BITS > VA_BITS_MIN && cpu_has_lva())
-		sysreg_clear_set(tcr_el1, TCR_T1SZ_MASK, TCR_T1SZ(VA_BITS));
+	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES) && !cpu_has_lva()) {
+		va_bits = VA_BITS_MIN;
+	} else if (IS_ENABLED(CONFIG_ARM64_LPA2) && !cpu_has_lpa2()) {
+		va_bits = VA_BITS_MIN;
+		root_level++;
+	}
+
+	if (va_bits > VA_BITS_MIN)
+		sysreg_clear_set(tcr_el1, TCR_T1SZ_MASK, TCR_T1SZ(va_bits));
 
 	/*
 	 * The virtual KASLR displacement modulo 2MiB is decided by the
@@ -191,6 +252,9 @@ asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
 		kaslr_offset |= kaslr_seed & ~(MIN_KIMG_ALIGN - 1);
 	}
 
+	if (IS_ENABLED(CONFIG_ARM64_LPA2) && va_bits > VA_BITS_MIN)
+		remap_idmap_for_lpa2();
+
 	va_base = KIMAGE_VADDR + kaslr_offset;
 	map_kernel(kaslr_offset, va_base - pa_base, root_level);
 }
diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index 8de3fe2c1cb55722..8a55c7775db8390f 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -86,14 +86,19 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
 	}
 }
 
-asmlinkage u64 __init create_init_idmap(pgd_t *pg_dir)
+asmlinkage u64 __init create_init_idmap(pgd_t *pg_dir, pteval_t clrmask)
 {
 	u64 ptep = (u64)pg_dir + PAGE_SIZE;
+	pgprot_t text_prot = PAGE_KERNEL_ROX;
+	pgprot_t data_prot = PAGE_KERNEL;
+
+	pgprot_val(text_prot) &= ~clrmask;
+	pgprot_val(data_prot) &= ~clrmask;
 
 	map_range(&ptep, (u64)_stext, (u64)__initdata_begin, (u64)_stext,
-		  PAGE_KERNEL_ROX, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0);
+		  text_prot, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0);
 	map_range(&ptep, (u64)__initdata_begin, (u64)_end, (u64)__initdata_begin,
-		  PAGE_KERNEL, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0);
+		  data_prot, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0);
 
 	return ptep;
 }
diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
index a8fe79c9b111140f..93d7457dd10d0380 100644
--- a/arch/arm64/kernel/pi/pi.h
+++ b/arch/arm64/kernel/pi/pi.h
@@ -17,7 +17,7 @@ static inline void *prel64_to_pointer(const prel64_t *offset)
 
 extern bool dynamic_scs_is_enabled;
 
-extern pgd_t init_idmap_pg_dir[];
+extern pgd_t init_idmap_pg_dir[], init_idmap_pg_end[];
 
 void init_feature_override(u64 boot_status, const void *fdt, int chosen);
 u64 kaslr_early_init(void *fdt, int chosen);
@@ -27,4 +27,4 @@ int scs_patch(const u8 eh_frame[], int size);
 void map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
 	       int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
 
-asmlinkage u64 create_init_idmap(pgd_t *pgd);
+asmlinkage u64 create_init_idmap(pgd_t *pgd, pteval_t clrmask);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 58a0bb2c17f18cf5..362b6884427c083f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -334,7 +334,7 @@ void __init arm64_memblock_init(void)
 	 * physical address of PAGE_OFFSET, we have to *subtract* from it.
 	 */
 	if (IS_ENABLED(CONFIG_ARM64_VA_BITS_52) && (vabits_actual != 52))
-		memstart_addr -= _PAGE_OFFSET(48) - _PAGE_OFFSET(52);
+		memstart_addr -= _PAGE_OFFSET(vabits_actual) - _PAGE_OFFSET(52);
 
 	/*
 	 * Apply the memory limit if it was set. Since the kernel may be loaded
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a16bcfba2e500600..6426df5211456cfe 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -543,8 +543,12 @@ static void __init map_mem(pgd_t *pgdp)
 	 * entries at any level are being shared between the linear region and
 	 * the vmalloc region. Check whether this is true for the PGD level, in
 	 * which case it is guaranteed to be true for all other levels as well.
+	 * (Unless we are running with support for LPA2, in which case the
+	 * entire reduced VA space is covered by a single pgd_t which will have
+	 * been populated without the PXNTable attribute by the time we get here.)
 	 */
-	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
+	BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end) &&
+		     pgd_index(_PAGE_OFFSET(VA_BITS_MIN)) != PTRS_PER_PGD - 1);
 
 	if (can_set_direct_map())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index f425cfc3e4dad188..68f8337cd8bf6ab9 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -488,6 +488,9 @@ SYM_FUNC_START(__cpu_setup)
 	mov		x9, #64 - VA_BITS
 alternative_if ARM64_HAS_VA52
 	tcr_set_t1sz	tcr, x9
+#ifdef CONFIG_ARM64_LPA2
+	orr		tcr, tcr, #TCR_DS
+#endif
 alternative_else_nop_endif
 #endif
 
-- 
2.39.2

