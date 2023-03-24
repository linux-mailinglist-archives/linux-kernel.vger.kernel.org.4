Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BB76C81FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjCXP5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjCXP5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:57:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE57F1E5E1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:57:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v1so2319367wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679673452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhhEYFPCPVqM+bv/vdKyIuWfXi+AjGplPQmUGopcOcU=;
        b=m3WT+FNIduuiQuRRQK2gEavpehgueTGx9br5jILqJam7WzWuSCoSPo70Vaz7WrYBFt
         +HFMqSyA/nMVG4EKyFRyElCmY5Nie3HcgRSGEi3jmHn5KN7ohI6QKhZOaVmtHfUKgNud
         M5/SrhKd3BLN/ZcRChD/whjG8SIpO4w3gtuXl/PIMiGPSE7RrTVgHNXG4No7leGMQRSF
         2cPN4OBEwwOYFmt7K0UVK/yopyZAaaq2DOxf6l/fzvVYIoL3GxNS1YqIfr1L7nSLsM0I
         p2xjtt2YI6AP5y+I55Pa7/ddwecKFUmQHaiXaUsXAofsELfar9qoEg/M3IrnW+6cg7tl
         R9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679673452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhhEYFPCPVqM+bv/vdKyIuWfXi+AjGplPQmUGopcOcU=;
        b=r/faxCWycqQCaTWCuu2XI7zx7wON+UBYuApc09TkjqJVeNSIKC2Oo5hNi1/zgA5ziJ
         Gyn3PQqebWHvsz4Lrjt+Iq/SCyJ5n+EdzzVo/aRySACO/aivd0gD5b+iGYw+bn/TBK88
         GwL/jYzMPs/tEGt0Z1rvi3QoLCxvolAyouo46WMAzWNPhl+fyKvKh9M8NxhnHhXtkseW
         5ndub5dZiXdD6LiGUdpE9YTCUFdnsTfLOgNICkhiGMMHnvSXZB94LbuDUdSQj7pin1IZ
         GE+ne7Aqe4c+HQuDztJ9TMAjpbi5Q5Uqna5VnsRaE5lKZqhAjYZKrDGhdXha+8DHxcEQ
         SH9Q==
X-Gm-Message-State: AAQBX9cxBetvSd7TmTOHs8o/3hlqliWenJfqR+1uAXhCV1ag3h3AGpKj
        pnXNxwMhGWl9Y3SPgb+qnqSLwQ==
X-Google-Smtp-Source: AKy350ZKFS9Zknv3kJTbWN0OS/rVhFjsRCqh2HsrZErz2y8l5F7eehLZBdmucO6ButWIk1v8iCKvAA==
X-Received: by 2002:adf:e64d:0:b0:2c5:4af3:3d26 with SMTP id b13-20020adfe64d000000b002c54af33d26mr2912903wrn.9.1679673452317;
        Fri, 24 Mar 2023 08:57:32 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6082000000b002c6d0462163sm18580112wrt.100.2023.03.24.08.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:57:32 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 3/3] riscv: Use PUD/P4D/PGD pages for the linear mapping
Date:   Fri, 24 Mar 2023 16:54:21 +0100
Message-Id: <20230324155421.271544-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230324155421.271544-1-alexghiti@rivosinc.com>
References: <20230324155421.271544-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the early page table creation, we used to set the mapping for
PAGE_OFFSET to the kernel load address: but the kernel load address is
always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
PAGE_OFFSET is).

But actually we don't have to establish this mapping (ie set va_pa_offset)
that early in the boot process because:

- first, setup_vm installs a temporary kernel mapping and among other
  things, discovers the system memory,
- then, setup_vm_final creates the final kernel mapping and takes
  advantage of the discovered system memory to create the linear
  mapping.

During the first phase, we don't know the start of the system memory and
then until the second phase is finished, we can't use the linear mapping at
all and phys_to_virt/virt_to_phys translations must not be used because it
would result in a different translation from the 'real' one once the final
mapping is installed.

So here we simply delay the initialization of va_pa_offset to after the
system memory discovery. But to make sure noone uses the linear mapping
before, we add some guard in the DEBUG_VIRTUAL config.

Finally we can use PUD/P4D/PGD hugepages when possible, which will result
in a better TLB utilization.

Note that:
- this does not apply to rv32 as the kernel mapping lies in the linear
  mapping.
- we rely on the firmware to protect itself using PMP.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Rob Herring <robh@kernel.org> # DT bits
---
 arch/riscv/include/asm/page.h | 16 ++++++++++
 arch/riscv/mm/init.c          | 58 +++++++++++++++++++++++++++++++----
 arch/riscv/mm/physaddr.c      | 16 ++++++++++
 drivers/of/fdt.c              | 11 ++++---
 4 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 8dc686f549b6..ea1a0e237211 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -90,6 +90,14 @@ typedef struct page *pgtable_t;
 #define PTE_FMT "%08lx"
 #endif
 
+#ifdef CONFIG_64BIT
+/*
+ * We override this value as its generic definition uses __pa too early in
+ * the boot process (before kernel_map.va_pa_offset is set).
+ */
+#define MIN_MEMBLOCK_ADDR      0
+#endif
+
 #ifdef CONFIG_MMU
 #define ARCH_PFN_OFFSET		(PFN_DOWN((unsigned long)phys_ram_base))
 #else
@@ -121,7 +129,11 @@ extern phys_addr_t phys_ram_base;
 #define is_linear_mapping(x)	\
 	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
 
+#ifndef CONFIG_DEBUG_VIRTUAL
 #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
+#else
+void *linear_mapping_pa_to_va(unsigned long x);
+#endif
 #define kernel_mapping_pa_to_va(y)	({					\
 	unsigned long _y = (unsigned long)(y);					\
 	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?			\
@@ -130,7 +142,11 @@ extern phys_addr_t phys_ram_base;
 	})
 #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
 
+#ifndef CONFIG_DEBUG_VIRTUAL
 #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - kernel_map.va_pa_offset)
+#else
+phys_addr_t linear_mapping_va_to_pa(unsigned long x);
+#endif
 #define kernel_mapping_va_to_pa(y) ({						\
 	unsigned long _y = (unsigned long)(y);					\
 	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 3b37d8606920..f803671d18b2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -213,6 +213,14 @@ static void __init setup_bootmem(void)
 	phys_ram_end = memblock_end_of_DRAM();
 	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
 		phys_ram_base = memblock_start_of_DRAM();
+
+	/*
+	 * In 64-bit, any use of __va/__pa before this point is wrong as we
+	 * did not know the start of DRAM before.
+	 */
+	if (IS_ENABLED(CONFIG_64BIT))
+		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
+
 	/*
 	 * memblock allocator is not aware of the fact that last 4K bytes of
 	 * the addressable memory can not be mapped because of IS_ERR_VALUE
@@ -667,9 +675,16 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 
 static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 {
-	/* Upgrade to PMD_SIZE mappings whenever possible */
-	base &= PMD_SIZE - 1;
-	if (!base && size >= PMD_SIZE)
+	if (!(base & (PGDIR_SIZE - 1)) && size >= PGDIR_SIZE)
+		return PGDIR_SIZE;
+
+	if (!(base & (P4D_SIZE - 1)) && size >= P4D_SIZE)
+		return P4D_SIZE;
+
+	if (!(base & (PUD_SIZE - 1)) && size >= PUD_SIZE)
+		return PUD_SIZE;
+
+	if (!(base & (PMD_SIZE - 1)) && size >= PMD_SIZE)
 		return PMD_SIZE;
 
 	return PAGE_SIZE;
@@ -978,11 +993,22 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	set_satp_mode();
 #endif
 
-	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
+	/*
+	 * In 64-bit, we defer the setup of va_pa_offset to setup_bootmem,
+	 * where we have the system memory layout: this allows us to align
+	 * the physical and virtual mappings and then make use of PUD/P4D/PGD
+	 * for the linear mapping. This is only possible because the kernel
+	 * mapping lies outside the linear mapping.
+	 * In 32-bit however, as the kernel resides in the linear mapping,
+	 * setup_vm_final can not change the mapping established here,
+	 * otherwise the same kernel addresses would get mapped to different
+	 * physical addresses (if the start of dram is different from the
+	 * kernel physical address start).
+	 */
+	kernel_map.va_pa_offset = IS_ENABLED(CONFIG_64BIT) ?
+				0UL : PAGE_OFFSET - kernel_map.phys_addr;
 	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 
-	phys_ram_base = kernel_map.phys_addr;
-
 	/*
 	 * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
 	 * kernel, whereas for 64-bit kernel, the end of the virtual address
@@ -1106,6 +1132,17 @@ static void __init create_linear_mapping_page_table(void)
 	phys_addr_t start, end;
 	u64 i;
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	phys_addr_t ktext_start = __pa_symbol(_start);
+	phys_addr_t ktext_size = __init_data_begin - _start;
+	phys_addr_t krodata_start = __pa_symbol(__start_rodata);
+	phys_addr_t krodata_size = _data - __start_rodata;
+
+	/* Isolate kernel text and rodata so they don't get mapped with a PUD */
+	memblock_mark_nomap(ktext_start,  ktext_size);
+	memblock_mark_nomap(krodata_start, krodata_size);
+#endif
+
 	/* Map all memory banks in the linear mapping */
 	for_each_mem_range(i, &start, &end) {
 		if (start >= end)
@@ -1118,6 +1155,15 @@ static void __init create_linear_mapping_page_table(void)
 
 		create_linear_mapping_range(start, end);
 	}
+
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	create_linear_mapping_range(ktext_start, ktext_start + ktext_size);
+	create_linear_mapping_range(krodata_start,
+				    krodata_start + krodata_size);
+
+	memblock_clear_nomap(ktext_start,  ktext_size);
+	memblock_clear_nomap(krodata_start, krodata_size);
+#endif
 }
 
 static void __init setup_vm_final(void)
diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
index 9b18bda74154..18706f457da7 100644
--- a/arch/riscv/mm/physaddr.c
+++ b/arch/riscv/mm/physaddr.c
@@ -33,3 +33,19 @@ phys_addr_t __phys_addr_symbol(unsigned long x)
 	return __va_to_pa_nodebug(x);
 }
 EXPORT_SYMBOL(__phys_addr_symbol);
+
+phys_addr_t linear_mapping_va_to_pa(unsigned long x)
+{
+	BUG_ON(!kernel_map.va_pa_offset);
+
+	return ((unsigned long)(x) - kernel_map.va_pa_offset);
+}
+EXPORT_SYMBOL(linear_mapping_va_to_pa);
+
+void *linear_mapping_pa_to_va(unsigned long x)
+{
+	BUG_ON(!kernel_map.va_pa_offset);
+
+	return ((void *)((unsigned long)(x) + kernel_map.va_pa_offset));
+}
+EXPORT_SYMBOL(linear_mapping_pa_to_va);
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1a68b6d03b3..d14735a81301 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -887,12 +887,13 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
-	/* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
-	 * enabled since __va() is called too early. ARM64 does make use
-	 * of phys_initrd_start/phys_initrd_size so we can skip this
-	 * conversion.
+	/*
+	 * __va() is not yet available this early on some platforms. In that
+	 * case, the platform uses phys_initrd_start/phys_initrd_size instead
+	 * and does the VA conversion itself.
 	 */
-	if (!IS_ENABLED(CONFIG_ARM64)) {
+	if (!IS_ENABLED(CONFIG_ARM64) &&
+	    !(IS_ENABLED(CONFIG_RISCV) && IS_ENABLED(CONFIG_64BIT))) {
 		initrd_start = (unsigned long)__va(start);
 		initrd_end = (unsigned long)__va(end);
 		initrd_below_start_ok = 1;
-- 
2.37.2

