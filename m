Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856A972F549
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbjFNHAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbjFNHA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:00:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E6D91996
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:00:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF3631FB;
        Wed, 14 Jun 2023 00:01:08 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.46.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 580863F663;
        Wed, 14 Jun 2023 00:00:18 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 03/14] arm64/sysreg: Rename TRBBASER_EL1 fields per auto-gen tools format
Date:   Wed, 14 Jun 2023 12:29:38 +0530
Message-Id: <20230614065949.146187-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614065949.146187-1-anshuman.khandual@arm.com>
References: <20230614065949.146187-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This renames TRBBASER_EL1 register fields per auto-gen tools format without
causing any functional change in the TRBE driver.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: kvmarm@lists.linux.dev
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h              | 4 ++--
 drivers/hwtracing/coresight/coresight-trbe.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index b7a0d7d0f4d6..896b9b6334b4 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -262,8 +262,8 @@
 #define TRBLIMITR_EL1_E			BIT(0)
 #define TRBPTR_EL1_PTR_MASK		GENMASK_ULL(63, 0)
 #define TRBPTR_EL1_PTR_SHIFT		0
-#define TRBBASER_BASE_MASK		GENMASK_ULL(51, 0)
-#define TRBBASER_BASE_SHIFT		12
+#define TRBBASER_EL1_BASE_MASK		GENMASK_ULL(63, 12)
+#define TRBBASER_EL1_BASE_SHIFT		12
 #define TRBSR_EC_MASK			GENMASK(5, 0)
 #define TRBSR_EC_SHIFT			26
 #define TRBSR_IRQ			BIT(22)
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index 8ea7079d60bb..0b73d9d10aa8 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -131,7 +131,7 @@ static inline unsigned long get_trbe_limit_pointer(void)
 static inline unsigned long get_trbe_base_pointer(void)
 {
 	u64 trbbaser = read_sysreg_s(SYS_TRBBASER_EL1);
-	unsigned long addr = trbbaser & (TRBBASER_BASE_MASK << TRBBASER_BASE_SHIFT);
+	unsigned long addr = trbbaser & TRBBASER_EL1_BASE_MASK;
 
 	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
 	return addr;
@@ -140,7 +140,7 @@ static inline unsigned long get_trbe_base_pointer(void)
 static inline void set_trbe_base_pointer(unsigned long addr)
 {
 	WARN_ON(is_trbe_enabled());
-	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBBASER_BASE_SHIFT)));
+	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBBASER_EL1_BASE_SHIFT)));
 	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
 	write_sysreg_s(addr, SYS_TRBBASER_EL1);
 }
-- 
2.25.1

