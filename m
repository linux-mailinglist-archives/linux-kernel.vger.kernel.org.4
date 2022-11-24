Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C530263791C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiKXMkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiKXMka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:40:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18D98245
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1FC962119
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 12:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D70C43147;
        Thu, 24 Nov 2022 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669293594;
        bh=ncTuy2wGTIYIRDuDgupcnhxQcFcwTch9Wfg3k1aZ64w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjTwBiy76tw/z8GXhzp7QGLMPYjOTQ4GUipQ+LY3vcZbJjAoMAQyoCyr4buSbQM6G
         hvXp4kr/JgTjB/tzfWuLZQ9PEYxy9K5aRN7XDx3A/HvTSo7pko+gL1famGfEhxxYv8
         yu8VpBT1nF1YTjEOgDcalRx7UoYrefJRVJuB32L4sWx/B/f5XPLMWdi9lnYjL/jvQX
         t44w/FTdSzMR6051hi4NUn3NOzBlWnfa8ovv6hVgDVxODyL6GlNEJ/5hSDcW2wLn2h
         Sq8Vf8xYARV42Y6Hz+Tx+GhplGi4WVfHs3kGiWfkNIsWRX/vm24xg1KsCs2ErJmeEG
         eaurHt8JaA/nA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/19] arm64/mm: Simplify and document pte_to_phys() for 52 bit addresses
Date:   Thu, 24 Nov 2022 13:39:14 +0100
Message-Id: <20221124123932.2648991-2-ardb@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221124123932.2648991-1-ardb@kernel.org>
References: <20221124123932.2648991-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <anshuman.khandual@arm.com>

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
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20221107141753.2938621-1-anshuman.khandual@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/assembler.h     | 8 +++-----
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/include/asm/pgtable.h       | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index e5957a53be39..89038067ef34 100644
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
+	orr	\phys, \phys, \phys, lsl #PTE_ADDR_HIGH_SHIFT
+	and	\phys, \phys, GENMASK_ULL(PHYS_MASK_SHIFT - 1, PAGE_SHIFT)
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
2.38.1.584.g0f3c55d4c2-goog

