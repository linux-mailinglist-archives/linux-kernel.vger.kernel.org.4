Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6976AE1E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjCGOMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCGOMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:12:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE508B066
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2354661465
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D80C4331F;
        Tue,  7 Mar 2023 14:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198135;
        bh=YIW4J/8Ja06Oc4Jt2bgT8fgcTe+XjUtudi32T81ok3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0DJw20FkK7dxCUGjAykqaaKXLPuSoiEyjrQYvx+ChLW+pl57DQg42bh69fCi4pcg
         H6qqtWN1x6uMObJ8ymnBiUSa4WsnEK1FYolGSHa/22V3Mc6InVr33kHacQ3vgp1A9u
         8BW5ilCifaEec1GClCX2LMr60u3cjeziWbD8DeqQ3oizhlQ4By9aeCr0yBdiW/4K5G
         e7+y/HkcynYocGxZ7Ay+67JfPcuC0GPInGgT9QEUitCRxgii3cWMUrJw1KCmlT6WU8
         SpU0MKJx+G2liWyEafch4Rojm2bFlWuKY+IA9krCNt654sRuNmipGU3C7ZnQk8D3wA
         lQtiEXGAfA2lg==
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
Subject: [PATCH v3 57/60] arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs
Date:   Tue,  7 Mar 2023 15:05:19 +0100
Message-Id: <20230307140522.2311461-58-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4995; i=ardb@kernel.org; h=from:subject; bh=YIW4J/8Ja06Oc4Jt2bgT8fgcTe+XjUtudi32T81ok3g=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdZVbj7ZnTH1/9fX5yZ9Ry+9k7v6m/Kpwq6rraO81hY rpEu8ryjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARtQyG/2l5q02yyiT3PXgf UJtY4p0cI8sVVpu/4oqnYIrAma37+hn+VzpWbjg+5en7wms6Ogw3JnLfevJkkm/XFJUUvSm6jgr VLAA=
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

Update Kconfig to permit 4k and 16k granule configurations to be built
with 52-bit virtual addressing, now that all the prerequisites are in
place.

While at it, update the feature description so it matches on the
appropriate feature bits depending on the page size. For simplicity,
let's just keep ARM64_HAS_VA52 as the feature name.

Note that LPA2 based 52-bit virtual addressing requires 52-bit physical
addressing support to be enabled as well, as programming TCR.TxSZ to
values below 16 is not allowed unless TCR.DS is set, which is what
activates the 52-bit physical addressing support.

While supporting the converse (52-bit physical addressing without 52-bit
virtual addressing) would be possible in principle, let's keep things
simple, by only allowing these features to be enabled at the same time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig             | 17 ++++++++-------
 arch/arm64/kernel/cpufeature.c | 22 ++++++++++++++++----
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 52aac583823863e4..938fe1d090a5bb4e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -351,7 +351,9 @@ config PGTABLE_LEVELS
 	default 3 if ARM64_64K_PAGES && (ARM64_VA_BITS_48 || ARM64_VA_BITS_52)
 	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
 	default 3 if ARM64_16K_PAGES && ARM64_VA_BITS_47
+	default 4 if ARM64_16K_PAGES && (ARM64_VA_BITS_48 || ARM64_VA_BITS_52)
 	default 4 if !ARM64_64K_PAGES && ARM64_VA_BITS_48
+	default 5 if ARM64_4K_PAGES && ARM64_VA_BITS_52
 
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
@@ -365,13 +367,13 @@ config BROKEN_GAS_INST
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
-	default 0xdfff800000000000 if (ARM64_VA_BITS_48 || ARM64_VA_BITS_52) && !KASAN_SW_TAGS
-	default 0xdfffc00000000000 if ARM64_VA_BITS_47 && !KASAN_SW_TAGS
+	default 0xdfff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS_52 && !ARM64_16K_PAGES)) && !KASAN_SW_TAGS
+	default 0xdfffc00000000000 if (ARM64_VA_BITS_47 || ARM64_VA_BITS_52) && ARM64_16K_PAGES && !KASAN_SW_TAGS
 	default 0xdffffe0000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
 	default 0xdfffffc000000000 if ARM64_VA_BITS_39 && !KASAN_SW_TAGS
 	default 0xdffffff800000000 if ARM64_VA_BITS_36 && !KASAN_SW_TAGS
-	default 0xefff800000000000 if (ARM64_VA_BITS_48 || ARM64_VA_BITS_52) && KASAN_SW_TAGS
-	default 0xefffc00000000000 if ARM64_VA_BITS_47 && KASAN_SW_TAGS
+	default 0xefff800000000000 if (ARM64_VA_BITS_48 || (ARM64_VA_BITS_52 && !ARM64_16K_PAGES)) && KASAN_SW_TAGS
+	default 0xefffc00000000000 if (ARM64_VA_BITS_47 || ARM64_VA_BITS_52) && ARM64_16K_PAGES && KASAN_SW_TAGS
 	default 0xeffffe0000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
 	default 0xefffffc000000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
 	default 0xeffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
@@ -1220,7 +1222,7 @@ config ARM64_VA_BITS_48
 
 config ARM64_VA_BITS_52
 	bool "52-bit"
-	depends on ARM64_64K_PAGES && (ARM64_PAN || !ARM64_SW_TTBR0_PAN)
+	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	help
 	  Enable 52-bit virtual addressing for userspace when explicitly
 	  requested via a hint to mmap(). The kernel will also use 52-bit
@@ -1267,10 +1269,11 @@ choice
 
 config ARM64_PA_BITS_48
 	bool "48-bit"
+	depends on ARM64_64K_PAGES || !ARM64_VA_BITS_52
 
 config ARM64_PA_BITS_52
-	bool "52-bit (ARMv8.2)"
-	depends on ARM64_64K_PAGES
+	bool "52-bit"
+	depends on ARM64_64K_PAGES || ARM64_VA_BITS_52
 	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN
 	help
 	  Enable support for a 52-bit physical address space, introduced as
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 62f6d397f27b07c0..4487745e9b660c5f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2763,15 +2763,29 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	},
 #ifdef CONFIG_ARM64_VA_BITS_52
 	{
-		.desc = "52-bit Virtual Addressing (LVA)",
 		.capability = ARM64_HAS_VA52,
 		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
-		.sys_reg = SYS_ID_AA64MMFR2_EL1,
-		.sign = FTR_UNSIGNED,
+		.matches = has_cpuid_feature,
 		.field_width = 4,
+#ifdef CONFIG_ARM64_64K_PAGES
+		.desc = "52-bit Virtual Addressing (LVA)",
+		.sign = FTR_SIGNED,
+		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.field_pos = ID_AA64MMFR2_EL1_VARange_SHIFT,
-		.matches = has_cpuid_feature,
 		.min_field_value = ID_AA64MMFR2_EL1_VARange_52,
+#else
+		.desc = "52-bit Virtual Addressing (LPA2)",
+		.sys_reg = SYS_ID_AA64MMFR0_EL1,
+#ifdef CONFIG_ARM64_4K_PAGES
+		.sign = FTR_SIGNED,
+		.field_pos = ID_AA64MMFR0_EL1_TGRAN4_SHIFT,
+		.min_field_value = ID_AA64MMFR0_EL1_TGRAN4_52_BIT,
+#else
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64MMFR0_EL1_TGRAN16_SHIFT,
+		.min_field_value = ID_AA64MMFR0_EL1_TGRAN16_52_BIT,
+#endif
+#endif
 	},
 #endif
 	{},
-- 
2.39.2

