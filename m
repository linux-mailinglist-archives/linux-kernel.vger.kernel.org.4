Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD8E6AE1DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjCGOL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjCGOKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:10:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF6A888B1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:08:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D396145A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227C8C4339C;
        Tue,  7 Mar 2023 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198109;
        bh=fi/Mt46HTgtFSr//58GfJTVreCP10GiauildLa+dfPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D74pKz2SK0GhwT6OXSOFZBxCrCxnbr/Zik+TUtE7ZX7XEblwOUjevezzdHkkjMLJf
         YoW8jHmHJKFsfrAsFgMSo5TVDp5Kp8EgwpfnsEQ9VkNxYxct6u0yaTl1QqLrjDYdGM
         z+O4QmTkvctELq707bPzwvKD4tzcXF0/sCMregCkknVelfAtEj2h8MgCuSmrRQyQf/
         2VpbSXVHY9k/AWNYSoEhNEBPpY+XJZvzbeWc4KHbCkJFf2eT0wtz40oUOL6Kh9O6PV
         iUfyVVbmj6CiQG29BJQUuPNe0JWGlpnZapQJXpzoh4pHlzjERJUDzn7DQwuCLnAXqg
         vil8E9paMZopg==
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
Subject: [PATCH v3 46/60] arm64: mm: Add LPA2 support to phys<->pte conversion routines
Date:   Tue,  7 Mar 2023 15:05:08 +0100
Message-Id: <20230307140522.2311461-47-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4658; i=ardb@kernel.org; h=from:subject; bh=fi/Mt46HTgtFSr//58GfJTVreCP10GiauildLa+dfPw=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdpXzrUrues+869ZyDDzNHNyWnXli/1mdapIehgYVHf NKqaxYdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCK9YQz/zDQfFb4xZF5+W0tn rpjCtvPzb3zSXLXLcpcKYzjr3oM3njAyTHcq+Ga8L/3nL9nUUxW3p7KlLUjqUmHS/peasUjp90U fdgA=
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

In preparation for enabling LPA2 support, introduce the mask values for
converting between physical addresses and their representations in a
page table descriptor.

While at it, move the pte_to_phys asm macro into its only user, so that
we can freely modify it to use its input value register as a temp
register.

For LPA2, the PTE_ADDR_MASK contains two non-adjacent sequences of zero
bits, which means it no longer fits into the immediate field of an
ordinary ALU instruction. So let's redefine it to include the bits in
between as well, and only use it when converting from physical address
to PTE representation, where the distinction does not matter. Also
update the name accordingly to emphasize this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/assembler.h     | 16 ++--------------
 arch/arm64/include/asm/pgtable-hwdef.h | 10 +++++++---
 arch/arm64/include/asm/pgtable.h       |  5 +++--
 arch/arm64/mm/proc.S                   |  8 ++++++++
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0710c17800a49b75..55e8731844cf7eb7 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -612,25 +612,13 @@ alternative_endif
 
 	.macro	phys_to_pte, pte, phys
 #ifdef CONFIG_ARM64_PA_BITS_52
-	/*
-	 * We assume \phys is 64K aligned and this is guaranteed by only
-	 * supporting this configuration with 64K pages.
-	 */
-	orr	\pte, \phys, \phys, lsr #36
-	and	\pte, \pte, #PTE_ADDR_MASK
+	orr	\pte, \phys, \phys, lsr #PTE_ADDR_HIGH_SHIFT
+	and	\pte, \pte, #PHYS_TO_PTE_ADDR_MASK
 #else
 	mov	\pte, \phys
 #endif
 	.endm
 
-	.macro	pte_to_phys, phys, pte
-	and	\phys, \pte, #PTE_ADDR_MASK
-#ifdef CONFIG_ARM64_PA_BITS_52
-	orr	\phys, \phys, \phys, lsl #PTE_ADDR_HIGH_SHIFT
-	and	\phys, \phys, GENMASK_ULL(PHYS_MASK_SHIFT - 1, PAGE_SHIFT)
-#endif
-	.endm
-
 /*
  * tcr_clear_errata_bits - Clear TCR bits that trigger an errata on this CPU.
  */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index c4ad7fbb12c5c07a..b91fe4781b066d54 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -155,13 +155,17 @@
 #define PTE_PXN			(_AT(pteval_t, 1) << 53)	/* Privileged XN */
 #define PTE_UXN			(_AT(pteval_t, 1) << 54)	/* User XN */
 
-#define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
+#define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (50 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
 #ifdef CONFIG_ARM64_PA_BITS_52
+#ifdef CONFIG_ARM64_64K_PAGES
 #define PTE_ADDR_HIGH		(_AT(pteval_t, 0xf) << 12)
-#define PTE_ADDR_MASK		(PTE_ADDR_LOW | PTE_ADDR_HIGH)
 #define PTE_ADDR_HIGH_SHIFT	36
+#define PHYS_TO_PTE_ADDR_MASK	(PTE_ADDR_LOW | PTE_ADDR_HIGH)
 #else
-#define PTE_ADDR_MASK		PTE_ADDR_LOW
+#define PTE_ADDR_HIGH		(_AT(pteval_t, 0x3) << 8)
+#define PTE_ADDR_HIGH_SHIFT	42
+#define PHYS_TO_PTE_ADDR_MASK	GENMASK_ULL(49, 8)
+#endif
 #endif
 
 /*
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2259898e8c3d990a..c8666d5c31fd1e52 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -80,15 +80,16 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #ifdef CONFIG_ARM64_PA_BITS_52
 static inline phys_addr_t __pte_to_phys(pte_t pte)
 {
+	pte_val(pte) &= ~PTE_MAYBE_SHARED;
 	return (pte_val(pte) & PTE_ADDR_LOW) |
 		((pte_val(pte) & PTE_ADDR_HIGH) << PTE_ADDR_HIGH_SHIFT);
 }
 static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 {
-	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PTE_ADDR_MASK;
+	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PHYS_TO_PTE_ADDR_MASK;
 }
 #else
-#define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_MASK)
+#define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_LOW)
 #define __phys_to_pte_val(phys)	(phys)
 #endif
 
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index a5dc009b7dd5c141..74b846d77b88e843 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -204,6 +204,14 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 
 	.pushsection ".idmap.text", "awx"
 
+	.macro	pte_to_phys, phys, pte
+	and	\phys, \pte, #PTE_ADDR_LOW
+#ifdef CONFIG_ARM64_PA_BITS_52
+	and	\pte, \pte, #PTE_ADDR_HIGH
+	orr	\phys, \phys, \pte, lsl #PTE_ADDR_HIGH_SHIFT
+#endif
+	.endm
+
 	.macro	kpti_mk_tbl_ng, type, num_entries
 	add	end_\type\()p, cur_\type\()p, #\num_entries * 8
 .Ldo_\type:
-- 
2.39.2

