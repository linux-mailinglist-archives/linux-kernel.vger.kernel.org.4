Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1904D6AE1EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjCGOMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCGOMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:12:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E148B06C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44B7B61466
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F62C433D2;
        Tue,  7 Mar 2023 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198106;
        bh=IooEg3M7Xp8n6fFz2ry7RA2wM5641yTnqrKiOOpwF8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+uJPAJ5Tmrt2XLa4LwUWbI3E6c05+YTuH0eIiMVX0N76LVrsgRFqGc7FXnR10oMs
         KrdfJ7APfiu765sYJ4LdDNjLnkoxTNerwpZu77p5URLx4vaJZpGKTZfzUysycbmtWF
         YFmt+IqvwkPCfVZrXESjfWAg5tnWrYXUGGJ5L+O/bUNPpw7WMoemYWf7236SrOSjHe
         /8asHrreZFw8/sJN1tyUyZw+EQDfsW3LXVj9xsb3gqCrzH+4VMTaXcHoUpkAdByuCi
         tpaCfzsHVoPepxoXXsgua7Dl0osV7qUDuf8jC1z8ail8RlVF/1/RauRHJqXw9qEl8C
         BdpbYsg2QxtJQ==
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
Subject: [PATCH v3 45/60] arm64: mm: Wire up TCR.DS bit to PTE shareability fields
Date:   Tue,  7 Mar 2023 15:05:07 +0100
Message-Id: <20230307140522.2311461-46-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2969; i=ardb@kernel.org; h=from:subject; bh=IooEg3M7Xp8n6fFz2ry7RA2wM5641yTnqrKiOOpwF8I=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdpTR3+pcUlnIXNWM+Rr9fFSn3L/GkFn0W+hOmbXpzx rsYvo6OUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMBHmk4wMB1/yXZwumVc4Y/fG xwL1k1MWLvHbli2158l3BV/3Hs5wJUaGkz77CopVEhey2flmv77/bYLexYescTpfbi49b1vYvDG IBwA=
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

When LPA2 is enabled, bits 8 and 9 of page and block descriptors become
part of the output address instead of carrying shareability attributes
for the region in question.

So avoid setting these bits if TCR.DS == 1, which means LPA2 is enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig                    |  4 ++++
 arch/arm64/include/asm/pgtable-prot.h | 18 ++++++++++++++++--
 arch/arm64/mm/mmap.c                  |  4 ++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1023e896d46b8969..d287dad29198c843 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1287,6 +1287,10 @@ config ARM64_PA_BITS
 	default 48 if ARM64_PA_BITS_48
 	default 52 if ARM64_PA_BITS_52
 
+config ARM64_LPA2
+	def_bool y
+	depends on ARM64_PA_BITS_52 && !ARM64_64K_PAGES
+
 choice
 	prompt "Endianness"
 	default CPU_LITTLE_ENDIAN
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 9b165117a454595a..269584d5a2c017fc 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -40,6 +40,20 @@ extern bool arm64_use_ng_mappings;
 #define PTE_MAYBE_NG		(arm64_use_ng_mappings ? PTE_NG : 0)
 #define PMD_MAYBE_NG		(arm64_use_ng_mappings ? PMD_SECT_NG : 0)
 
+#ifndef CONFIG_ARM64_LPA2
+#define lpa2_is_enabled()	false
+#define PTE_MAYBE_SHARED	PTE_SHARED
+#define PMD_MAYBE_SHARED	PMD_SECT_S
+#else
+static inline bool __pure lpa2_is_enabled(void)
+{
+	return read_tcr() & TCR_DS;
+}
+
+#define PTE_MAYBE_SHARED	(lpa2_is_enabled() ? 0 : PTE_SHARED)
+#define PMD_MAYBE_SHARED	(lpa2_is_enabled() ? 0 : PMD_SECT_S)
+#endif
+
 /*
  * If we have userspace only BTI we don't want to mark kernel pages
  * guarded even if the system does support BTI.
@@ -50,8 +64,8 @@ extern bool arm64_use_ng_mappings;
 #define PTE_MAYBE_GP		0
 #endif
 
-#define PROT_DEFAULT		(_PROT_DEFAULT | PTE_MAYBE_NG)
-#define PROT_SECT_DEFAULT	(_PROT_SECT_DEFAULT | PMD_MAYBE_NG)
+#define PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_MAYBE_NG | PTE_MAYBE_SHARED | PTE_AF)
+#define PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_MAYBE_NG | PMD_MAYBE_SHARED | PMD_SECT_AF)
 
 #define PROT_DEVICE_nGnRnE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRnE))
 #define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRE))
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 8f5b7ce857ed4a8f..adcf547f74eb8e60 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -73,6 +73,10 @@ static int __init adjust_protection_map(void)
 		protection_map[VM_EXEC | VM_SHARED] = PAGE_EXECONLY;
 	}
 
+	if (lpa2_is_enabled())
+		for (int i = 0; i < ARRAY_SIZE(protection_map); i++)
+			pgprot_val(protection_map[i]) &= ~PTE_SHARED;
+
 	return 0;
 }
 arch_initcall(adjust_protection_map);
-- 
2.39.2

