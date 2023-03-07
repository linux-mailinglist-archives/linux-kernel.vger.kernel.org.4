Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF46AE1C3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCGOIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjCGOIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:08:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B6E8C962
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B720613CA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD4DC4339C;
        Tue,  7 Mar 2023 14:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198036;
        bh=XnTvDw4ttdVCcfAeL2dMDAGtCMBFr94CQLQQmSGCFiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iioG0f+xikmcLwqqv55zuuJUYG85WwLmOHchnc+kJlH7ULC9s3GK6OaXARyL2o6S/
         qsDiDHjm9S9ectzT2lStvTr3IjA0jmFl0ZfJu5U/tcNVCy0uNA6w5qSCUcYI6sZQTN
         luBE6dOrPzni/K4wPVCg54bQ4KxRhVnUM9XeSAlvtxXk1YRRp4lYqMp/2TrQvJxlAd
         bZlAMiPUy4WKwTNCjMAfKAGowQOJLSYCjk24URoe97yQfEPQ3AEoGkhevB9f8caHAi
         Nu6fB9sIC4ZC1xa38Tq/+l1hHv2WC9VkENVmh9AlzhrM9ArsozwL9/LubPKgMzNcLN
         UsjyXIJ1KnzbQ==
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
Subject: [PATCH v3 16/60] arm64: head: move relocation handling to C code
Date:   Tue,  7 Mar 2023 15:04:38 +0100
Message-Id: <20230307140522.2311461-17-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10151; i=ardb@kernel.org; h=from:subject; bh=XnTvDw4ttdVCcfAeL2dMDAGtCMBFr94CQLQQmSGCFiY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdReXu2uPdS+6/s5VVaPtz8/m7KVvcSoOO+aQ+dN2Y9 jv561aFjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARU2GG/ynPPnA/CTiuyLvc ZWG4oG6RVE2454H7CrfPbwjgkiz/9oLhf1aNmxv3C8d5OZKnrTadUN9jLm5qcn9zqBHjqYjq0sg ULgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a mini C runtime before the kernel mapping is up, we
can move the non-trivial relocation processing code out of head.S and
reimplement it in C.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/Makefile      |   3 +-
 arch/arm64/kernel/head.S        | 104 ++------------------
 arch/arm64/kernel/pi/Makefile   |   5 +-
 arch/arm64/kernel/pi/relocate.c |  62 ++++++++++++
 arch/arm64/kernel/vmlinux.lds.S |  12 ++-
 5 files changed, 82 insertions(+), 104 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ceba6792f5b3c473..e27168d6ed2050b9 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -58,7 +58,8 @@ obj-$(CONFIG_ACPI)			+= acpi.o
 obj-$(CONFIG_ACPI_NUMA)			+= acpi_numa.o
 obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 obj-$(CONFIG_PARAVIRT)			+= paravirt.o
-obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o pi/
+obj-$(CONFIG_RELOCATABLE)		+= pi/
+obj-$(CONFIG_RANDOMIZE_BASE)		+= kaslr.o
 obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 obj-$(CONFIG_ELF_CORE)			+= elfcore.o
 obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 65cdaaa2c859418f..5047a2952ec273f9 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -81,7 +81,7 @@
 	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
-	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
+	 *  x23        __primary_switch()                       physical misalignment/KASLR offset
 	 *  x24        __primary_switch()                       linear map KASLR seed
 	 *  x25        primary_entry() .. start_kernel()        supported VA size
 	 *  x28        create_idmap()                           callee preserved temp register
@@ -389,7 +389,7 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	/* Remap the kernel page tables r/w in the ID map */
 	adrp	x1, _text
 	adrp	x2, init_pg_dir
-	adrp	x3, init_pg_end
+	adrp	x3, _end
 	bic	x4, x2, #SWAPPER_BLOCK_SIZE - 1
 	mov	x5, SWAPPER_RW_MMUFLAGS
 	mov	x6, #SWAPPER_BLOCK_SHIFT
@@ -777,97 +777,6 @@ SYM_FUNC_START_LOCAL(__no_granule_support)
 	b	1b
 SYM_FUNC_END(__no_granule_support)
 
-#ifdef CONFIG_RELOCATABLE
-SYM_FUNC_START_LOCAL(__relocate_kernel)
-	/*
-	 * Iterate over each entry in the relocation table, and apply the
-	 * relocations in place.
-	 */
-	adr_l	x9, __rela_start
-	adr_l	x10, __rela_end
-	mov_q	x11, KIMAGE_VADDR		// default virtual offset
-	add	x11, x11, x23			// actual virtual offset
-
-0:	cmp	x9, x10
-	b.hs	1f
-	ldp	x12, x13, [x9], #24
-	ldr	x14, [x9, #-8]
-	cmp	w13, #R_AARCH64_RELATIVE
-	b.ne	0b
-	add	x14, x14, x23			// relocate
-	str	x14, [x12, x23]
-	b	0b
-
-1:
-#ifdef CONFIG_RELR
-	/*
-	 * Apply RELR relocations.
-	 *
-	 * RELR is a compressed format for storing relative relocations. The
-	 * encoded sequence of entries looks like:
-	 * [ AAAAAAAA BBBBBBB1 BBBBBBB1 ... AAAAAAAA BBBBBB1 ... ]
-	 *
-	 * i.e. start with an address, followed by any number of bitmaps. The
-	 * address entry encodes 1 relocation. The subsequent bitmap entries
-	 * encode up to 63 relocations each, at subsequent offsets following
-	 * the last address entry.
-	 *
-	 * The bitmap entries must have 1 in the least significant bit. The
-	 * assumption here is that an address cannot have 1 in lsb. Odd
-	 * addresses are not supported. Any odd addresses are stored in the RELA
-	 * section, which is handled above.
-	 *
-	 * Excluding the least significant bit in the bitmap, each non-zero
-	 * bit in the bitmap represents a relocation to be applied to
-	 * a corresponding machine word that follows the base address
-	 * word. The second least significant bit represents the machine
-	 * word immediately following the initial address, and each bit
-	 * that follows represents the next word, in linear order. As such,
-	 * a single bitmap can encode up to 63 relocations in a 64-bit object.
-	 *
-	 * In this implementation we store the address of the next RELR table
-	 * entry in x9, the address being relocated by the current address or
-	 * bitmap entry in x13 and the address being relocated by the current
-	 * bit in x14.
-	 */
-	adr_l	x9, __relr_start
-	adr_l	x10, __relr_end
-
-2:	cmp	x9, x10
-	b.hs	7f
-	ldr	x11, [x9], #8
-	tbnz	x11, #0, 3f			// branch to handle bitmaps
-	add	x13, x11, x23
-	ldr	x12, [x13]			// relocate address entry
-	add	x12, x12, x23
-	str	x12, [x13], #8			// adjust to start of bitmap
-	b	2b
-
-3:	mov	x14, x13
-4:	lsr	x11, x11, #1
-	cbz	x11, 6f
-	tbz	x11, #0, 5f			// skip bit if not set
-	ldr	x12, [x14]			// relocate bit
-	add	x12, x12, x23
-	str	x12, [x14]
-
-5:	add	x14, x14, #8			// move to next bit's address
-	b	4b
-
-6:	/*
-	 * Move to the next bitmap's address. 8 is the word size, and 63 is the
-	 * number of significant bits in a bitmap entry.
-	 */
-	add	x13, x13, #(8 * 63)
-	b	2b
-
-7:
-#endif
-	ret
-
-SYM_FUNC_END(__relocate_kernel)
-#endif
-
 SYM_FUNC_START_LOCAL(__primary_switch)
 	adrp	x1, reserved_pg_dir
 	adrp	x2, init_idmap_pg_dir
@@ -875,11 +784,11 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 #ifdef CONFIG_RELOCATABLE
 	adrp	x23, KERNEL_START
 	and	x23, x23, MIN_KIMG_ALIGN - 1
-#ifdef CONFIG_RANDOMIZE_BASE
-	mov	x0, x22
-	adrp	x1, init_pg_end
+	adrp	x1, early_init_stack
 	mov	sp, x1
 	mov	x29, xzr
+#ifdef CONFIG_RANDOMIZE_BASE
+	mov	x0, x22
 	bl	__pi_kaslr_early_init
 	and	x24, x0, #SZ_2M - 1		// capture memstart offset seed
 	bic	x0, x0, #SZ_2M - 1
@@ -892,7 +801,8 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	adrp	x1, init_pg_dir
 	load_ttbr1 x1, x1, x2
 #ifdef CONFIG_RELOCATABLE
-	bl	__relocate_kernel
+	mov	x0, x23
+	bl	__pi_relocate_kernel
 #endif
 	ldr	x8, =__primary_switched
 	adrp	x0, KERNEL_START		// __pa(KERNEL_START)
diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index 2bbe866417d453ff..d084c1dcf4165420 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -38,5 +38,6 @@ $(obj)/lib-%.pi.o: OBJCOPYFLAGS += --prefix-alloc-sections=.init
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-obj-y		:= kaslr_early.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
-extra-y		:= $(patsubst %.pi.o,%.o,$(obj-y))
+obj-y				:= relocate.pi.o
+obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr_early.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
+extra-y				:= $(patsubst %.pi.o,%.o,$(obj-y))
diff --git a/arch/arm64/kernel/pi/relocate.c b/arch/arm64/kernel/pi/relocate.c
new file mode 100644
index 0000000000000000..1853408ea76b0e5d
--- /dev/null
+++ b/arch/arm64/kernel/pi/relocate.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2023 Google LLC
+// Authors: Ard Biesheuvel <ardb@google.com>
+//          Peter Collingbourne <pcc@google.com>
+
+#include <linux/elf.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+extern const Elf64_Rela rela_start[], rela_end[];
+extern const u64 relr_start[], relr_end[];
+
+void __init relocate_kernel(u64 offset)
+{
+	u64 *place = NULL;
+
+	for (const Elf64_Rela *rela = rela_start; rela < rela_end; rela++) {
+		if (ELF64_R_TYPE(rela->r_info) != R_AARCH64_RELATIVE)
+			continue;
+		*(u64 *)(rela->r_offset + offset) = rela->r_addend + offset;
+	}
+
+	if (!IS_ENABLED(CONFIG_RELR) || !offset)
+		return;
+
+	/*
+	 * Apply RELR relocations.
+	 *
+	 * RELR is a compressed format for storing relative relocations. The
+	 * encoded sequence of entries looks like:
+	 * [ AAAAAAAA BBBBBBB1 BBBBBBB1 ... AAAAAAAA BBBBBB1 ... ]
+	 *
+	 * i.e. start with an address, followed by any number of bitmaps. The
+	 * address entry encodes 1 relocation. The subsequent bitmap entries
+	 * encode up to 63 relocations each, at subsequent offsets following
+	 * the last address entry.
+	 *
+	 * The bitmap entries must have 1 in the least significant bit. The
+	 * assumption here is that an address cannot have 1 in lsb. Odd
+	 * addresses are not supported. Any odd addresses are stored in the
+	 * RELA section, which is handled above.
+	 *
+	 * With the exception of the least significant bit, each bit in the
+	 * bitmap corresponds with a machine word that follows the base address
+	 * word, and the bit value indicates whether or not a relocation needs
+	 * to be applied to it. The second least significant bit represents the
+	 * machine word immediately following the initial address, and each bit
+	 * that follows represents the next word, in linear order. As such, a
+	 * single bitmap can encode up to 63 relocations in a 64-bit object.
+	 */
+	for (const u64 *relr = relr_start; relr < relr_end; relr++) {
+		if ((*relr & 1) == 0) {
+			place = (u64 *)(*relr + offset);
+			*place++ += offset;
+		} else {
+			for (u64 *p = place, r = *relr >> 1; r; p++, r >>= 1)
+				if (r & 1)
+					*p += offset;
+			place += 63;
+		}
+	}
+}
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b9202c2ee18e02d8..ec24b1e70d606ec8 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -271,15 +271,15 @@ SECTIONS
 	HYPERVISOR_RELOC_SECTION
 
 	.rela.dyn : ALIGN(8) {
-		__rela_start = .;
+		__pi_rela_start = .;
 		*(.rela .rela*)
-		__rela_end = .;
+		__pi_rela_end = .;
 	}
 
 	.relr.dyn : ALIGN(8) {
-		__relr_start = .;
+		__pi_relr_start = .;
 		*(.relr.dyn)
-		__relr_end = .;
+		__pi_relr_end = .;
 	}
 
 	. = ALIGN(SEGMENT_ALIGN);
@@ -318,6 +318,10 @@ SECTIONS
 	init_pg_dir = .;
 	. += INIT_DIR_SIZE;
 	init_pg_end = .;
+#ifdef CONFIG_RELOCATABLE
+	. += SZ_4K;		/* stack for the early relocation code */
+	early_init_stack = .;
+#endif
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
-- 
2.39.2

