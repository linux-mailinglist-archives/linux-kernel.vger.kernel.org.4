Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2069661F230
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiKGLtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiKGLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:49:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA49A1AD96
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:49:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 934B01FB;
        Mon,  7 Nov 2022 03:49:10 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6087B3F73D;
        Mon,  7 Nov 2022 03:49:01 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/mm: Simplify and document pte_to_phys() for 52 bit addresses
Date:   Mon,  7 Nov 2022 17:18:50 +0530
Message-Id: <20221107114850.2902150-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_to_phys() assembly definition does multiple bits field transformations
to derive physical address, embedded inside a page table entry. Unlike its
C counter part i.e __pte_to_phys(), pte_to_phys() is not very apparent. It
simplifies these operations via a new macro PTE_ADDR_HIGH_SHIFT indicating
how far the pte encoded higher address bits need to be left shifted. While
here, this also updates __pte_to_phys() and __phys_to_pte_val().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.1-rc4

Changes in V2:

- Added PTE_ADDR_HIGH_SHIFT based method per Ard
 
Changes in V1:

https://lore.kernel.org/all/20221031082421.1957288-1-anshuman.khandual@arm.com/

 arch/arm64/include/asm/assembler.h     | 8 +++-----
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/include/asm/pgtable.h       | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index e5957a53be39..6a39a3601cf7 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -660,12 +660,10 @@ alternative_endif
 	.endm
 
 	.macro	pte_to_phys, phys, pte
-#ifdef CONFIG_ARM64_PA_BITS_52
-	ubfiz	\phys, \pte, #(48 - 16 - 12), #16
-	bfxil	\phys, \pte, #16, #32
-	lsl	\phys, \phys, #16
-#else
 	and	\phys, \pte, #PTE_ADDR_MASK
+#ifdef CONFIG_ARM64_PA_BITS_52
+	orr \phys, \phys, \phys, lsl #PTE_ADDR_HIGH_SHIFT
+	and \phys, \phys, GENMASK_ULL(PHYS_MASK_SHIFT - 1, PAGE_SHIFT)
 #endif
 	.endm
 
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 5ab8d163198f..f658aafc47df 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -159,6 +159,7 @@
 #ifdef CONFIG_ARM64_PA_BITS_52
 #define PTE_ADDR_HIGH		(_AT(pteval_t, 0xf) << 12)
 #define PTE_ADDR_MASK		(PTE_ADDR_LOW | PTE_ADDR_HIGH)
+#define PTE_ADDR_HIGH_SHIFT	36
 #else
 #define PTE_ADDR_MASK		PTE_ADDR_LOW
 #endif
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 71a1af42f0e8..daedd6172227 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -77,11 +77,11 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 static inline phys_addr_t __pte_to_phys(pte_t pte)
 {
 	return (pte_val(pte) & PTE_ADDR_LOW) |
-		((pte_val(pte) & PTE_ADDR_HIGH) << 36);
+		((pte_val(pte) & PTE_ADDR_HIGH) << PTE_ADDR_HIGH_SHIFT);
 }
 static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 {
-	return (phys | (phys >> 36)) & PTE_ADDR_MASK;
+	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PTE_ADDR_MASK;
 }
 #else
 #define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_MASK)
-- 
2.25.1

