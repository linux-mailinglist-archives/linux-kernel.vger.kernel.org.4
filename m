Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2C36131A9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJaIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:24:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36AAB10BF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:24:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E10A01FB;
        Mon, 31 Oct 2022 01:24:38 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 812153F534;
        Mon, 31 Oct 2022 01:24:29 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/mm: Simplify and document pte_to_phys() for 52 bit addresses
Date:   Mon, 31 Oct 2022 13:54:21 +0530
Message-Id: <20221031082421.1957288-1-anshuman.khandual@arm.com>
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
simplifies these operations, by deriving all positions and widths in macro
format and documenting individual steps in the physical address extraction.
While here, this also updates __pte_to_phys() and __phys_to_pte_val().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.1-rc3.

 arch/arm64/include/asm/assembler.h     | 37 +++++++++++++++++++++++---
 arch/arm64/include/asm/pgtable-hwdef.h |  5 ++++
 arch/arm64/include/asm/pgtable.h       |  4 +--
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index e5957a53be39..aea320b04d85 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -661,9 +661,40 @@ alternative_endif
 
 	.macro	pte_to_phys, phys, pte
 #ifdef CONFIG_ARM64_PA_BITS_52
-	ubfiz	\phys, \pte, #(48 - 16 - 12), #16
-	bfxil	\phys, \pte, #16, #32
-	lsl	\phys, \phys, #16
+	/*
+	 * Physical address needs to be derived from the given page table
+	 * entry according to the following formula.
+	 *
+	 *	phys = pte[47..16] | (pte[15..12] << 36)
+	 *
+	 * These instructions here retrieve the embedded 52 bits physical
+	 * address in phys[51..0]. This involves copying over both higher
+	 * and lower addresses into phys[35..0] which is then followed by
+	 * 16 bit left shift.
+	 *
+	 * Get higher 4 bits
+	 *
+	 *	phys[35..20] = pte[15..0] i.e phys[35..32] = pte[15..12]
+	 *
+	 * Get lower 32 bits
+	 *
+	 *	phys[31..0] = pte[47..16]
+	 *
+	 * Till now
+	 *
+	 *	phys[35..0] = pte[51..16]
+	 *
+	 * Left shift
+	 *
+	 *	phys[51..0]  = phys[35..0] << 16
+	 *
+	 * Finally
+	 *
+	 *	phys[51..16] = pte[47..16] | (pte[15..12] << 36)
+	 */
+	ubfiz	\phys, \pte, #HIGH_ADDR_SHIFT, #HIGH_ADDR_BITS_MAX
+	bfxil	\phys, \pte, #PAGE_SHIFT, #(LOW_ADDR_BITS_MAX - PAGE_SHIFT)
+	lsl	\phys, \phys, #PAGE_SHIFT
 #else
 	and	\phys, \pte, #PTE_ADDR_MASK
 #endif
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 5ab8d163198f..683ca2378960 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -157,6 +157,11 @@
 
 #define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
 #ifdef CONFIG_ARM64_PA_BITS_52
+#define LOW_ADDR_BITS_MAX	48
+#define HIGH_ADDR_BITS_MAX	16
+#define HIGH_ADDR_BITS_MIN	12
+#define HIGH_ADDR_WIDTH		(HIGH_ADDR_BITS_MAX - HIGH_ADDR_BITS_MIN)
+#define HIGH_ADDR_SHIFT		(LOW_ADDR_BITS_MAX - PAGE_SHIFT - PAGE_SHIFT + HIGH_ADDR_WIDTH)
 #define PTE_ADDR_HIGH		(_AT(pteval_t, 0xf) << 12)
 #define PTE_ADDR_MASK		(PTE_ADDR_LOW | PTE_ADDR_HIGH)
 #else
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 71a1af42f0e8..014bac4a69e9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -77,11 +77,11 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 static inline phys_addr_t __pte_to_phys(pte_t pte)
 {
 	return (pte_val(pte) & PTE_ADDR_LOW) |
-		((pte_val(pte) & PTE_ADDR_HIGH) << 36);
+		((pte_val(pte) & PTE_ADDR_HIGH) << (PHYS_MASK_SHIFT - PAGE_SHIFT));
 }
 static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 {
-	return (phys | (phys >> 36)) & PTE_ADDR_MASK;
+	return (phys | (phys >> (PHYS_MASK_SHIFT - PAGE_SHIFT))) & PTE_ADDR_MASK;
 }
 #else
 #define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_MASK)
-- 
2.25.1

