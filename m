Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBCE69996A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBPQCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBPQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:02:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0681185F56
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:02:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCA3B168F;
        Thu, 16 Feb 2023 08:02:44 -0800 (PST)
Received: from e126864.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DC973F881;
        Thu, 16 Feb 2023 08:01:59 -0800 (PST)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] arm64: mops: detect and enable FEAT_MOPS
Date:   Thu, 16 Feb 2023 16:00:11 +0000
Message-Id: <20230216160012.272345-10-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230216160012.272345-1-kristina.martsenko@arm.com>
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arm v8.8/9.3 FEAT_MOPS feature provides new instructions that
perform a memory copy or set. Wire up the cpufeature code to detect the
presence of FEAT_MOPS and enable it.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 Documentation/arm64/cpu-feature-registers.rst |  2 ++
 Documentation/arm64/elf_hwcaps.rst            |  3 +++
 arch/arm64/include/asm/hwcap.h                |  1 +
 arch/arm64/include/uapi/asm/hwcap.h           |  1 +
 arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c                   |  1 +
 arch/arm64/tools/cpucaps                      |  1 +
 7 files changed, 28 insertions(+)

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index c7adc7897df6..4e4625f2455f 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -288,6 +288,8 @@ infrastructure:
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
      +------------------------------+---------+---------+
+     | MOPS                         | [19-16] |    y    |
+     +------------------------------+---------+---------+
      | RPRES                        | [7-4]   |    y    |
      +------------------------------+---------+---------+
      | WFXT                         | [3-0]   |    y    |
diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 83e57e4d38e2..8f847d0dcf57 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -302,6 +302,9 @@ HWCAP2_SMEB16B16
 HWCAP2_SMEF16F16
     Functionality implied by ID_AA64SMFR0_EL1.F16F16 == 0b1
 
+HWCAP2_MOPS
+    Functionality implied by ID_AA64ISAR2_EL1.MOPS == 0b0001.
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 5d45f19fda7f..692b1ec663b2 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -137,6 +137,7 @@
 #define KERNEL_HWCAP_SME_BI32I32	__khwcap2_feature(SME_BI32I32)
 #define KERNEL_HWCAP_SME_B16B16		__khwcap2_feature(SME_B16B16)
 #define KERNEL_HWCAP_SME_F16F16		__khwcap2_feature(SME_F16F16)
+#define KERNEL_HWCAP_MOPS		__khwcap2_feature(MOPS)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 69a4fb749c65..a2cac4305b1e 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -102,5 +102,6 @@
 #define HWCAP2_SME_BI32I32	(1UL << 40)
 #define HWCAP2_SME_B16B16	(1UL << 41)
 #define HWCAP2_SME_F16F16	(1UL << 42)
+#define HWCAP2_MOPS		(1UL << 43)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1b0a71541381..70a08b2ddaa6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -216,6 +216,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_CSSC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_RPRFM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_HIGHER_SAFE, ID_AA64ISAR2_EL1_BC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_MOPS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
 		       FTR_STRICT, FTR_EXACT, ID_AA64ISAR2_EL1_APA3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
@@ -2158,6 +2159,11 @@ static void cpu_enable_dit(const struct arm64_cpu_capabilities *__unused)
 	set_pstate_dit(1);
 }
 
+static void cpu_enable_mops(const struct arm64_cpu_capabilities *__unused)
+{
+	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_MSCEn);
+}
+
 /* Internal helper functions to match cpu capability type */
 static bool
 cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
@@ -2759,6 +2765,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		.cpu_enable = cpu_enable_dit,
 	},
+	{
+		.desc = "Memory Copy and Memory Set instructions",
+		.capability = ARM64_HAS_MOPS,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.sys_reg = SYS_ID_AA64ISAR2_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64ISAR2_EL1_MOPS_SHIFT,
+		.field_width = 4,
+		.min_field_value = ID_AA64ISAR2_EL1_MOPS_IMP,
+		.matches = has_cpuid_feature,
+		.cpu_enable = cpu_enable_mops,
+	},
 	{},
 };
 
@@ -2891,6 +2909,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR2_EL1, RPRFM, IMP, CAP_HWCAP, KERNEL_HWCAP_RPRFM),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, RPRES, IMP, CAP_HWCAP, KERNEL_HWCAP_RPRES),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, WFxT, IMP, CAP_HWCAP, KERNEL_HWCAP_WFXT),
+	HWCAP_CAP(ID_AA64ISAR2_EL1, MOPS, IMP, CAP_HWCAP, KERNEL_HWCAP_MOPS),
 #ifdef CONFIG_ARM64_SME
 	HWCAP_CAP(ID_AA64PFR1_EL1, SME, IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
 	HWCAP_CAP(ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index eb4378c23b3c..076a124255d0 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -125,6 +125,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SME_BI32I32]	= "smebi32i32",
 	[KERNEL_HWCAP_SME_B16B16]	= "smeb16b16",
 	[KERNEL_HWCAP_SME_F16F16]	= "smef16f16",
+	[KERNEL_HWCAP_MOPS]		= "mops",
 };
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index bf32a1122c04..5018da44def2 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -34,6 +34,7 @@ HAS_GIC_PRIO_RELAXED_SYNC
 HAS_HCX
 HAS_LDAPR
 HAS_LSE_ATOMICS
+HAS_MOPS
 HAS_NO_FPSIMD
 HAS_NO_HW_PREFETCH
 HAS_PAN
-- 
2.25.1

