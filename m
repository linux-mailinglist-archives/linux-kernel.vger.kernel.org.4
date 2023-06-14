Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF5272F54D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243084AbjFNHBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243252AbjFNHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:00:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA6931FF7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:00:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E177A1FB;
        Wed, 14 Jun 2023 00:01:27 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.46.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 781D53F663;
        Wed, 14 Jun 2023 00:00:39 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 07/14] arm64/sysreg: Rename TRBIDR_EL1 fields per auto-gen tools format
Date:   Wed, 14 Jun 2023 12:29:42 +0530
Message-Id: <20230614065949.146187-8-anshuman.khandual@arm.com>
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

This renames TRBIDR_EL1 register fields per auto-gen tools format without
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
 arch/arm64/include/asm/el2_setup.h           | 2 +-
 arch/arm64/include/asm/sysreg.h              | 8 ++++----
 arch/arm64/kvm/debug.c                       | 2 +-
 drivers/hwtracing/coresight/coresight-trbe.h | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 037724b19c5c..63ea1ef6c99e 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -69,7 +69,7 @@
 	cbz	x0, .Lskip_trace_\@		// Skip if TraceBuffer is not present
 
 	mrs_s	x0, SYS_TRBIDR_EL1
-	and	x0, x0, TRBIDR_PROG
+	and	x0, x0, TRBIDR_EL1_P
 	cbnz	x0, .Lskip_trace_\@		// If TRBE is available at EL2
 
 	mov	x0, #(MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4789d932d027..c505838d7851 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -283,10 +283,10 @@
 #define TRBMAR_EL1_Attr_SHIFT		0
 #define TRBTRG_EL1_TRG_MASK		GENMASK(31, 0)
 #define TRBTRG_EL1_TRG_SHIFT		0
-#define TRBIDR_FLAG			BIT(5)
-#define TRBIDR_PROG			BIT(4)
-#define TRBIDR_ALIGN_MASK		GENMASK(3, 0)
-#define TRBIDR_ALIGN_SHIFT		0
+#define TRBIDR_EL1_F			BIT(5)
+#define TRBIDR_EL1_P			BIT(4)
+#define TRBIDR_EL1_Align_MASK		GENMASK(3, 0)
+#define TRBIDR_EL1_Align_SHIFT		0
 
 #define SYS_PMINTENSET_EL1		sys_reg(3, 0, 9, 14, 1)
 #define SYS_PMINTENCLR_EL1		sys_reg(3, 0, 9, 14, 2)
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 55f80fb93925..8725291cb00a 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -333,7 +333,7 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
 
 	/* Check if we have TRBE implemented and available at the host */
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
-	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_PROG))
+	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
 		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
index 3743d9085355..d661b062293f 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.h
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -95,17 +95,17 @@ static inline bool is_trbe_running(u64 trbsr)
 
 static inline bool get_trbe_flag_update(u64 trbidr)
 {
-	return trbidr & TRBIDR_FLAG;
+	return trbidr & TRBIDR_EL1_F;
 }
 
 static inline bool is_trbe_programmable(u64 trbidr)
 {
-	return !(trbidr & TRBIDR_PROG);
+	return !(trbidr & TRBIDR_EL1_P);
 }
 
 static inline int get_trbe_address_align(u64 trbidr)
 {
-	return (trbidr >> TRBIDR_ALIGN_SHIFT) & TRBIDR_ALIGN_MASK;
+	return (trbidr & TRBIDR_EL1_Align_MASK) >> TRBIDR_EL1_Align_SHIFT;
 }
 
 static inline unsigned long get_trbe_write_pointer(void)
-- 
2.25.1

