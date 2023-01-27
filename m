Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A4167E352
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjA0Laq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjA0L36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:29:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8136F41092
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:29:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 615EC1684;
        Fri, 27 Jan 2023 03:29:19 -0800 (PST)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.35.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 608483F64C;
        Fri, 27 Jan 2023 03:28:35 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev
Subject: [RFC PATCH 10/14] arm64: Enable memory encrypt for Realms
Date:   Fri, 27 Jan 2023 11:27:54 +0000
Message-Id: <20230127112758.37891-11-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127112758.37891-1-steven.price@arm.com>
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <20230127112758.37891-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the memory encryption APIs to trigger a RSI call to request a
transition between protected memory and shared memory (or vice versa)
and updating the kernel's linear map of modified pages to flip the top
bit of the IPA. This requires that block mappings are not used in the
direct map for realm guests.

Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/Kconfig                   |  3 ++
 arch/arm64/include/asm/mem_encrypt.h | 19 +++++++++++
 arch/arm64/kernel/rsi.c              | 12 +++++++
 arch/arm64/mm/pageattr.c             | 48 +++++++++++++++++++++++++---
 4 files changed, 78 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/include/asm/mem_encrypt.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 03934808b2ed..0aac44a993ac 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -20,6 +20,7 @@ config ARM64
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
+	select ARCH_HAS_CC_PLATFORM
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
@@ -39,6 +40,8 @@ config ARM64
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_MEM_ENCRYPT
+	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select ARCH_STACKWALK
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
new file mode 100644
index 000000000000..7381f9585321
--- /dev/null
+++ b/arch/arm64/include/asm/mem_encrypt.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 ARM Ltd.
+ */
+
+#ifndef __ASM_MEM_ENCRYPT_H
+#define __ASM_MEM_ENCRYPT_H
+
+#include <asm/rsi.h>
+
+/* All DMA must be to non-secure memory for now */
+static inline bool force_dma_unencrypted(struct device *dev)
+{
+	return is_realm_world();
+}
+
+int set_memory_encrypted(unsigned long addr, int numpages);
+int set_memory_decrypted(unsigned long addr, int numpages);
+#endif
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 1a07eefdd2e9..1cc292826f2b 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -6,6 +6,7 @@
 #include <linux/jump_label.h>
 #include <linux/memblock.h>
 #include <linux/swiotlb.h>
+#include <linux/cc_platform.h>
 
 #include <asm/rsi.h>
 
@@ -18,6 +19,17 @@ unsigned int phys_mask_shift = CONFIG_ARM64_PA_BITS;
 
 DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
 
+bool cc_platform_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return is_realm_world();
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
+
 static bool rsi_version_matches(void)
 {
 	unsigned long ver = rsi_get_version();
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 79dd201c59d8..bbd7364dd9a8 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -5,10 +5,12 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/mem_encrypt.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 
 #include <asm/cacheflush.h>
+#include <asm/pgtable-prot.h>
 #include <asm/set_memory.h>
 #include <asm/tlbflush.h>
 
@@ -22,12 +24,12 @@ bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED
 bool can_set_direct_map(void)
 {
 	/*
-	 * rodata_full, DEBUG_PAGEALLOC and KFENCE require linear map to be
-	 * mapped at page granularity, so that it is possible to
-	 * protect/unprotect single pages.
+	 * rodata_full, DEBUG_PAGEALLOC, KFENCE and a Realm guest all require
+	 * linear map to be mapped at page granularity, so that it is possible
+	 * to protect/unprotect single pages.
 	 */
 	return (rodata_enabled && rodata_full) || debug_pagealloc_enabled() ||
-		IS_ENABLED(CONFIG_KFENCE);
+		IS_ENABLED(CONFIG_KFENCE) || is_realm_world();
 }
 
 static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
@@ -38,6 +40,7 @@ static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 	pte = clear_pte_bit(pte, cdata->clear_mask);
 	pte = set_pte_bit(pte, cdata->set_mask);
 
+	/* TODO: Break before make for PROT_NS_SHARED updates */
 	set_pte(ptep, pte);
 	return 0;
 }
@@ -190,6 +193,43 @@ int set_direct_map_default_noflush(struct page *page)
 				   PAGE_SIZE, change_page_range, &data);
 }
 
+static int __set_memory_encrypted(unsigned long addr,
+				  int numpages,
+				  bool encrypt)
+{
+	unsigned long set_prot = 0, clear_prot = 0;
+	phys_addr_t start, end;
+
+	if (!is_realm_world())
+		return 0;
+
+	WARN_ON(!__is_lm_address(addr));
+	start = __virt_to_phys(addr);
+	end = start + numpages * PAGE_SIZE;
+
+	if (encrypt) {
+		clear_prot = PROT_NS_SHARED;
+		set_memory_range_protected(start, end);
+	} else {
+		set_prot = PROT_NS_SHARED;
+		set_memory_range_shared(start, end);
+	}
+
+	return __change_memory_common(addr, PAGE_SIZE * numpages,
+				      __pgprot(set_prot),
+				      __pgprot(clear_prot));
+}
+
+int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	return __set_memory_encrypted(addr, numpages, true);
+}
+
+int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	return __set_memory_encrypted(addr, numpages, false);
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
-- 
2.34.1

