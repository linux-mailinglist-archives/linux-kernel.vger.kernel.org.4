Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F67697E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBOOhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBOOhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:37:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658DA38B55
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:37:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so1690001wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6T1tjsb98FN3v4tidb0bt6QGsUcKMvFQDV82PTYx96Q=;
        b=INxhNJqbQk8OjrTsp01knjRKKZMmlBgSwnFoY1G9niH4R9rUkZw5cXYPCp7NobPxs4
         anMS8huUhM3dFlgphKqf3iRbr559v7nVeMkH5uMhHijB5nB3DMN8tcT3GbMJbr49L/dM
         56vH04hlAgIgrOIteCX/JwxK6IMYVvv0JSkAZAeIcPl9iuM6DZfj9bBiDli0rYuDoRrU
         GTgvoqLEZPclQCStDKm575BnHTV8b//ZeGBLODVrPccej/N9kDSVXvgSEjMcsQa1UEXq
         6/GMksWqyXV8v0QnqAKdid6Lm8Ao0WfHaJ1+qVTLpKIukG106KZwZRbP6q4m0pY/Q36D
         3P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6T1tjsb98FN3v4tidb0bt6QGsUcKMvFQDV82PTYx96Q=;
        b=gzKXXYzakZE1Y/j7S36/uADjgtYtUW/jGeuJJ8jiIQC8EbQDh0H6LiblZ6mXFB2j0P
         2+D5ToEr00UYVS80ZXVAEJOTakqpNOcpo2TXMk1RMVDr99a3bLU3pk5xtpCOU+iGtTdI
         RadN+itkicXAUTqXp/zj5c3UYpDHoCWDzA7rv4NEVr30g6TNb9Nph+Qog/p6F/OD69p5
         +opAS+8dDo1esv5JF6FG+CKt86+BlzlwFNVy8ZVhejSu8dU298ff1YsfBugDZl3+IiN5
         tFF3YvlPLLZ/iNcYqb6gik6djlSIquAWLQzK3OQfUFmM5oPvPuJB8Ot6Wm+QxgQd1hTN
         psjg==
X-Gm-Message-State: AO0yUKUM9uk5Xyn51PIjNOo3GOplsbr2iZnTK4m3Qf0IFJD7CAqWhShX
        fsFtUGmIYXKPj+XJSBe4QFQL/g==
X-Google-Smtp-Source: AK7set/X+AXt1w+FAaMuV9BwkXPxCbPMNoe5oZMv4HHF7AGTayiaHyBuR1kymX395Sd+pMRaRnQ7Wg==
X-Received: by 2002:a05:600c:340a:b0:3e1:11bd:f577 with SMTP id y10-20020a05600c340a00b003e111bdf577mr2146695wmp.26.1676471849838;
        Wed, 15 Feb 2023 06:37:29 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-450-160.w2-7.abo.wanadoo.fr. [2.7.42.160])
        by smtp.gmail.com with ESMTPSA id a24-20020a1cf018000000b003dfee43863fsm2292294wmb.26.2023.02.15.06.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:37:29 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v8 1/3] riscv: Introduce CONFIG_RELOCATABLE
Date:   Wed, 15 Feb 2023 15:36:24 +0100
Message-Id: <20230215143626.453491-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230215143626.453491-1-alexghiti@rivosinc.com>
References: <20230215143626.453491-1-alexghiti@rivosinc.com>
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

From: Alexandre Ghiti <alex@ghiti.fr>

This config allows to compile 64b kernel as PIE and to relocate it at
any virtual address at runtime: this paves the way to KASLR.
Runtime relocation is possible since relocation metadata are embedded into
the kernel.

Note that relocating at runtime introduces an overhead even if the
kernel is loaded at the same address it was linked at and that the compiler
options are those used in arm64 which uses the same RELA relocation
format.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/Kconfig              | 14 +++++++++
 arch/riscv/Makefile             |  7 +++--
 arch/riscv/kernel/efi-header.S  |  6 ++--
 arch/riscv/kernel/vmlinux.lds.S | 10 ++++--
 arch/riscv/mm/Makefile          |  4 +++
 arch/riscv/mm/init.c            | 54 ++++++++++++++++++++++++++++++++-
 6 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b656043abf..e0ee7ce4b2e3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -544,6 +544,20 @@ config COMPAT
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config RELOCATABLE
+	bool "Build a relocatable kernel"
+	depends on MMU && 64BIT && !XIP_KERNEL
+	help
+          This builds a kernel as a Position Independent Executable (PIE),
+          which retains all relocation metadata required to relocate the
+          kernel binary at runtime to a different virtual address than the
+          address it was linked at.
+          Since RISCV uses the RELA relocation format, this requires a
+          relocation pass at runtime even if the kernel is loaded at the
+          same address it was linked at.
+
+          If unsure, say N.
+
 endmenu # "Kernel features"
 
 menu "Boot options"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 82153960ac00..97c34136b027 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -7,9 +7,12 @@
 #
 
 OBJCOPYFLAGS    := -O binary
-LDFLAGS_vmlinux :=
+ifeq ($(CONFIG_RELOCATABLE),y)
+	LDFLAGS_vmlinux += -shared -Bsymbolic -z notext -z norelro
+	KBUILD_CFLAGS += -fPIE
+endif
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
-	LDFLAGS_vmlinux := --no-relax
+	LDFLAGS_vmlinux += --no-relax
 	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=8
 endif
diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
index 8e733aa48ba6..f7ee09c4f12d 100644
--- a/arch/riscv/kernel/efi-header.S
+++ b/arch/riscv/kernel/efi-header.S
@@ -33,7 +33,7 @@ optional_header:
 	.byte	0x02					// MajorLinkerVersion
 	.byte	0x14					// MinorLinkerVersion
 	.long	__pecoff_text_end - efi_header_end	// SizeOfCode
-	.long	__pecoff_data_virt_size			// SizeOfInitializedData
+	.long	__pecoff_data_virt_end - __pecoff_text_end	// SizeOfInitializedData
 	.long	0					// SizeOfUninitializedData
 	.long	__efistub_efi_pe_entry - _start		// AddressOfEntryPoint
 	.long	efi_header_end - _start			// BaseOfCode
@@ -91,9 +91,9 @@ section_table:
 		IMAGE_SCN_MEM_EXECUTE			// Characteristics
 
 	.ascii	".data\0\0\0"
-	.long	__pecoff_data_virt_size			// VirtualSize
+	.long	__pecoff_data_virt_end - __pecoff_text_end	// VirtualSize
 	.long	__pecoff_text_end - _start		// VirtualAddress
-	.long	__pecoff_data_raw_size			// SizeOfRawData
+	.long	__pecoff_data_raw_end - __pecoff_text_end	// SizeOfRawData
 	.long	__pecoff_text_end - _start		// PointerToRawData
 
 	.long	0					// PointerToRelocations
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 4e6c88aa4d87..8be2de3be08c 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -122,9 +122,15 @@ SECTIONS
 		*(.sdata*)
 	}
 
+	.rela.dyn : ALIGN(8) {
+		__rela_dyn_start = .;
+		*(.rela .rela*)
+		__rela_dyn_end = .;
+	}
+
 #ifdef CONFIG_EFI
 	.pecoff_edata_padding : { BYTE(0); . = ALIGN(PECOFF_FILE_ALIGNMENT); }
-	__pecoff_data_raw_size = ABSOLUTE(. - __pecoff_text_end);
+	__pecoff_data_raw_end = ABSOLUTE(.);
 #endif
 
 	/* End of data section */
@@ -134,7 +140,7 @@ SECTIONS
 
 #ifdef CONFIG_EFI
 	. = ALIGN(PECOFF_SECTION_ALIGNMENT);
-	__pecoff_data_virt_size = ABSOLUTE(. - __pecoff_text_end);
+	__pecoff_data_virt_end = ABSOLUTE(.);
 #endif
 	_end = .;
 
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 2ac177c05352..b85e9e82f082 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 CFLAGS_init.o := -mcmodel=medany
+ifdef CONFIG_RELOCATABLE
+CFLAGS_init.o += -fno-pie
+endif
+
 ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_cacheflush.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 7f01c2e56efe..3862696c2ac9 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -20,6 +20,9 @@
 #include <linux/dma-map-ops.h>
 #include <linux/crash_dump.h>
 #include <linux/hugetlb.h>
+#ifdef CONFIG_RELOCATABLE
+#include <linux/elf.h>
+#endif
 
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
@@ -146,7 +149,7 @@ static void __init print_vm_layout(void)
 		print_ml("kasan", KASAN_SHADOW_START, KASAN_SHADOW_END);
 #endif
 
-		print_ml("kernel", (unsigned long)KERNEL_LINK_ADDR,
+		print_ml("kernel", (unsigned long)kernel_map.virt_addr,
 			 (unsigned long)ADDRESS_SPACE_END);
 	}
 }
@@ -854,6 +857,44 @@ static __init void set_satp_mode(uintptr_t dtb_pa)
 #error "setup_vm() is called from head.S before relocate so it should not use absolute addressing."
 #endif
 
+#ifdef CONFIG_RELOCATABLE
+extern unsigned long __rela_dyn_start, __rela_dyn_end;
+
+static void __init relocate_kernel(void)
+{
+	Elf64_Rela *rela = (Elf64_Rela *)&__rela_dyn_start;
+	/*
+	 * This holds the offset between the linked virtual address and the
+	 * relocated virtual address.
+	 */
+	uintptr_t reloc_offset = kernel_map.virt_addr - KERNEL_LINK_ADDR;
+	/*
+	 * This holds the offset between kernel linked virtual address and
+	 * physical address.
+	 */
+	uintptr_t va_kernel_link_pa_offset = KERNEL_LINK_ADDR - kernel_map.phys_addr;
+
+	for ( ; rela < (Elf64_Rela *)&__rela_dyn_end; rela++) {
+		Elf64_Addr addr = (rela->r_offset - va_kernel_link_pa_offset);
+		Elf64_Addr relocated_addr = rela->r_addend;
+
+		if (rela->r_info != R_RISCV_RELATIVE)
+			continue;
+
+		/*
+		 * Make sure to not relocate vdso symbols like rt_sigreturn
+		 * which are linked from the address 0 in vmlinux since
+		 * vdso symbol addresses are actually used as an offset from
+		 * mm->context.vdso in VDSO_OFFSET macro.
+		 */
+		if (relocated_addr >= KERNEL_LINK_ADDR)
+			relocated_addr += reloc_offset;
+
+		*(Elf64_Addr *)addr = relocated_addr;
+	}
+}
+#endif /* CONFIG_RELOCATABLE */
+
 #ifdef CONFIG_XIP_KERNEL
 static void __init create_kernel_page_table(pgd_t *pgdir,
 					    __always_unused bool early)
@@ -1039,6 +1080,17 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
 #endif
 
+#ifdef CONFIG_RELOCATABLE
+	/*
+	 * Early page table uses only one PUD, which makes it possible
+	 * to map PUD_SIZE aligned on PUD_SIZE: if the relocation offset
+	 * makes the kernel cross over a PUD_SIZE boundary, raise a bug
+	 * since a part of the kernel would not get mapped.
+	 */
+	BUG_ON(PUD_SIZE - (kernel_map.virt_addr & (PUD_SIZE - 1)) < kernel_map.size);
+	relocate_kernel();
+#endif
+
 	apply_early_boot_alternatives();
 	pt_ops_set_early();
 
-- 
2.37.2

