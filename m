Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0E67E34F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjA0Lac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjA0L3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:29:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 657BC72679
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:29:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 555F5165C;
        Fri, 27 Jan 2023 03:29:14 -0800 (PST)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.35.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34CC63F64C;
        Fri, 27 Jan 2023 03:28:30 -0800 (PST)
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
Subject: [RFC PATCH 08/14] arm64: Make the PHYS_MASK_SHIFT dynamic
Date:   Fri, 27 Jan 2023 11:27:52 +0000
Message-Id: <20230127112758.37891-9-steven.price@arm.com>
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

Make the PHYS_MASK_SHIFT dynamic for Realms. This is only is required
for masking the PFN from a pte entry. Elsewhere, we could still use the
PA bits configured by the kernel. So, this patch:

 -> renames PHYS_MASK_SHIFT -> MAX_PHYS_SHIFT as supported by the kernel
 -> Makes PHYS_MASK_SHIFT -> Dynamic value of the (I)PA bit width
 -> For a realm: reduces phys_mask_shift if the RMM reports a smaller
    configured size for the guest.

Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h       | 2 +-
 arch/arm64/include/asm/pgtable-hwdef.h | 4 ++--
 arch/arm64/include/asm/pgtable.h       | 5 +++++
 arch/arm64/kernel/head.S               | 2 +-
 arch/arm64/kernel/rsi.c                | 5 +++++
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 0df3fc3a0173..924f84024009 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -346,7 +346,7 @@
  * bits in PAR are res0.
  */
 #define PAR_TO_HPFAR(par)		\
-	(((par) & GENMASK_ULL(52 - 1, 12)) >> 8)
+	(((par) & GENMASK_ULL(MAX_PHYS_MASK_SHIFT - 1, 12)) >> 8)
 
 #define ECN(x) { ESR_ELx_EC_##x, #x }
 
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index f658aafc47df..677bf7a91616 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -178,8 +178,8 @@
 /*
  * Highest possible physical address supported.
  */
-#define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
-#define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
+#define MAX_PHYS_MASK_SHIFT	(CONFIG_ARM64_PA_BITS)
+#define MAX_PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
 
 #define TTBR_CNP_BIT		(UL(1) << 0)
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b4bbeed80fb6..a1319a743b38 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -35,6 +35,11 @@
 #include <linux/sched.h>
 #include <linux/page_table_check.h>
 
+extern unsigned int phys_mask_shift;
+
+#define PHYS_MASK_SHIFT		(phys_mask_shift)
+#define PHYS_MASK		((1UL << PHYS_MASK_SHIFT) - 1)
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 952e17bd1c0b..a05504667b69 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -321,7 +321,7 @@ SYM_FUNC_START_LOCAL(create_idmap)
 #error "Mismatch between VA_BITS and page size/number of translation levels"
 #endif
 #else
-#define IDMAP_PGD_ORDER	(PHYS_MASK_SHIFT - PGDIR_SHIFT)
+#define IDMAP_PGD_ORDER	(MAX_PHYS_MASK_SHIFT - PGDIR_SHIFT)
 #define EXTRA_SHIFT
 	/*
 	 * If VA_BITS == 48, we don't have to configure an additional
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 9c63ee1c6979..49d36dfe0064 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -12,6 +12,8 @@ struct realm_config __attribute((aligned(PAGE_SIZE))) config;
 unsigned long prot_ns_shared;
 EXPORT_SYMBOL(prot_ns_shared);
 
+unsigned int phys_mask_shift = CONFIG_ARM64_PA_BITS;
+
 DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
 
 static bool rsi_version_matches(void)
@@ -54,5 +56,8 @@ void __init arm64_rsi_init(void)
 		return;
 	prot_ns_shared = BIT(config.ipa_bits - 1);
 
+	if (config.ipa_bits - 1 < phys_mask_shift)
+		phys_mask_shift = config.ipa_bits - 1;
+
 	static_branch_enable(&rsi_present);
 }
-- 
2.34.1

