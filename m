Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269D36AD16D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCFWUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCFWUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:20:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069756C88F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:20:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 892D060F60
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B32AC433A0;
        Mon,  6 Mar 2023 22:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678141243;
        bh=E+3ApSAAjKRZFTXy1lr7SjpFnM5CKJ2ooFUGc9JA2I4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=B/9hOsCJWR/uyCEQQv6g3cKBuIGYjYniv6beVPtycKXs86sBl9kZ+U7SNQSTMBIaP
         /lsc3o5UMTZ/V47Rrw6B42X9cWVak9ounlf0mhnk9Ksbh5ddf/ShPgV6M+mTse0lOM
         3UrxV/RqSoEQpWbQUc6RTUtL61j0GVSXbIVfFWSQyByihmJmu2qQkm4zWhGxEEx643
         OVjiH1GDZTK8PTsT9nUsSmthqec3hurSaRNStE43gQhmAHQ/66Hs9HWwnN+Y/RHQUg
         2vXbvurCk2E87nRQzjiDQpzhgsRB1OcEqgwu84wsH6luxbiELeKhvP/c6+lIHPHHER
         MnSV4LwMVu3Ug==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 06 Mar 2023 22:20:25 +0000
Subject: [PATCH 3/3] arm64/cpufeature: Use helper macro to specify ID
 register for capabilites
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-arm64-cpufeature-helpers-v1-3-b16cf36acaea@kernel.org>
References: <20230303-arm64-cpufeature-helpers-v1-0-b16cf36acaea@kernel.org>
In-Reply-To: <20230303-arm64-cpufeature-helpers-v1-0-b16cf36acaea@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=20045; i=broonie@kernel.org;
 h=from:subject:message-id; bh=E+3ApSAAjKRZFTXy1lr7SjpFnM5CKJ2ooFUGc9JA2I4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBmczkdKkDFkpRR7COVvyz6rGXQ/Q+ufifxOqIm1C
 z14UUuKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAZnMwAKCRAk1otyXVSH0ITdB/
 43cSSO0ASBGU8p1XcaLwIEPMUl+zrDjVQoxjXH8G30G6BRSzGGwJgvVFwwKThUNN+oYBgUO1Xh+vDp
 JD0yNwkLMKCx3/EB3Us9K/Oft9wrkR1qKrVEkhGw2OISJbJk1Qr2JNYGlK0kUa3xut0yAYErmAmHSp
 t6L2qjk+YAJmrQovF3cPrpE+ebPcyrA6XC4nexoxqY3uX5Je3/Ln7/Fwlo7gfKxh7i4njX2lxf+RvR
 EYOURHPh4qgrxMFuyhALDPhPB20QryZcH5+RycVJF2sTVqmsVk0NcF7XrTh97XbDnHk6ltpPbMz49B
 Jjkra32aScvjZPuxovcP3EdkC0mVIn
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When defining which value to look for in a system register field we
currently manually specify the register, field shift, width and sign and
the value to look for. This opens the potential for error with for example
the wrong field width or sign being specified, an enumeration value for
a different similarly named field or letting something be initialised to 0.

Since we now generate defines for all the ID registers we now have named
constants for all of these things generated from the system register
description, meaning that we can generate initialisation for all the fields
used in matching from a minimal specification of register, field and match
value. This is both shorter and eliminates or makes build failures several
potential errors.

No change in the generated binary.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 245 ++++++++---------------------------------
 1 file changed, 44 insertions(+), 201 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1002ac437e8b..e25cb8bc60f6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2213,22 +2213,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_GIC_CPUIF_SYSREGS,
 		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
 		.matches = has_useable_gicv3_cpuif,
-		.sys_reg = SYS_ID_AA64PFR0_EL1,
-		.field_pos = ID_AA64PFR0_EL1_GIC_SHIFT,
-		.field_width = 4,
-		.sign = FTR_UNSIGNED,
-		.min_field_value = ID_AA64PFR0_EL1_GIC_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, GIC, IMP)
 	},
 	{
 		.desc = "Enhanced Counter Virtualization",
 		.capability = ARM64_HAS_ECV,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64MMFR0_EL1,
-		.field_pos = ID_AA64MMFR0_EL1_ECV_SHIFT,
-		.field_width = 4,
-		.sign = FTR_UNSIGNED,
-		.min_field_value = ID_AA64MMFR0_EL1_ECV_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, ECV, IMP)
 	},
 #ifdef CONFIG_ARM64_PAN
 	{
@@ -2236,12 +2228,8 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_PAN,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64MMFR1_EL1,
-		.field_pos = ID_AA64MMFR1_EL1_PAN_SHIFT,
-		.field_width = 4,
-		.sign = FTR_UNSIGNED,
-		.min_field_value = ID_AA64MMFR1_EL1_PAN_IMP,
 		.cpu_enable = cpu_enable_pan,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR1_EL1, PAN, IMP)
 	},
 #endif /* CONFIG_ARM64_PAN */
 #ifdef CONFIG_ARM64_EPAN
@@ -2250,11 +2238,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_EPAN,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64MMFR1_EL1,
-		.field_pos = ID_AA64MMFR1_EL1_PAN_SHIFT,
-		.field_width = 4,
-		.sign = FTR_UNSIGNED,
-		.min_field_value = ID_AA64MMFR1_EL1_PAN_PAN3,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR1_EL1, PAN, PAN3)
 	},
 #endif /* CONFIG_ARM64_EPAN */
 #ifdef CONFIG_ARM64_LSE_ATOMICS
@@ -2263,11 +2247,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_LSE_ATOMICS,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64ISAR0_EL1,
-		.field_pos = ID_AA64ISAR0_EL1_ATOMIC_SHIFT,
-		.field_width = 4,
-		.sign = FTR_UNSIGNED,
-		.min_field_value = ID_AA64ISAR0_EL1_ATOMIC_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR0_EL1, ATOMIC, IMP)
 	},
 #endif /* CONFIG_ARM64_LSE_ATOMICS */
 	{
@@ -2288,21 +2268,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_NESTED_VIRT,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_nested_virt_support,
-		.sys_reg = SYS_ID_AA64MMFR2_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64MMFR2_EL1_NV_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64MMFR2_EL1_NV_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, NV, IMP)
 	},
 	{
 		.capability = ARM64_HAS_32BIT_EL0_DO_NOT_USE,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_32bit_el0,
-		.sys_reg = SYS_ID_AA64PFR0_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64PFR0_EL1_EL0_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR0_EL1_ELx_32BIT_64BIT,
+		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, EL0, AARCH32)
 	},
 #ifdef CONFIG_KVM
 	{
@@ -2310,11 +2282,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_32BIT_EL1,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64PFR0_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64PFR0_EL1_EL1_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR0_EL1_ELx_32BIT_64BIT,
+		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, EL1, AARCH32)
 	},
 	{
 		.desc = "Protected KVM",
@@ -2327,17 +2295,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "Kernel page table isolation (KPTI)",
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
 		.type = ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE,
+		.cpu_enable = kpti_install_ng_mappings,
+		.matches = unmap_kernel_at_el0,
 		/*
 		 * The ID feature fields below are used to indicate that
 		 * the CPU doesn't need KPTI. See unmap_kernel_at_el0 for
 		 * more details.
 		 */
-		.sys_reg = SYS_ID_AA64PFR0_EL1,
-		.field_pos = ID_AA64PFR0_EL1_CSV3_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR0_EL1_CSV3_IMP,
-		.matches = unmap_kernel_at_el0,
-		.cpu_enable = kpti_install_ng_mappings,
+		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, CSV3, IMP)
 	},
 	{
 		/* FP/SIMD is not implemented */
@@ -2352,21 +2317,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_DCPOP,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64ISAR1_EL1,
-		.field_pos = ID_AA64ISAR1_EL1_DPB_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64ISAR1_EL1_DPB_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, DPB, IMP)
 	},
 	{
 		.desc = "Data cache clean to Point of Deep Persistence",
 		.capability = ARM64_HAS_DCPODP,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64ISAR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64ISAR1_EL1_DPB_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64ISAR1_EL1_DPB_DPB2,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, DPB, DPB2)
 	},
 #endif
 #ifdef CONFIG_ARM64_SVE
@@ -2374,13 +2332,9 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "Scalable Vector Extension",
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.capability = ARM64_SVE,
-		.sys_reg = SYS_ID_AA64PFR0_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64PFR0_EL1_SVE_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR0_EL1_SVE_IMP,
-		.matches = has_cpuid_feature,
 		.cpu_enable = sve_kernel_enable,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, SVE, IMP)
 	},
 #endif /* CONFIG_ARM64_SVE */
 #ifdef CONFIG_ARM64_RAS_EXTN
@@ -2389,12 +2343,8 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_RAS_EXTN,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64PFR0_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64PFR0_EL1_RAS_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR0_EL1_RAS_IMP,
 		.cpu_enable = cpu_clear_disr,
+		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, RAS, IMP)
 	},
 #endif /* CONFIG_ARM64_RAS_EXTN */
 #ifdef CONFIG_ARM64_AMU_EXTN
@@ -2408,12 +2358,8 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_AMU_EXTN,
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
 		.matches = has_amu,
-		.sys_reg = SYS_ID_AA64PFR0_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64PFR0_EL1_AMU_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR0_EL1_AMU_IMP,
 		.cpu_enable = cpu_amu_enable,
+		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, AMU, IMP)
 	},
 #endif /* CONFIG_ARM64_AMU_EXTN */
 	{
@@ -2433,34 +2379,22 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "Stage-2 Force Write-Back",
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.capability = ARM64_HAS_STAGE2_FWB,
-		.sys_reg = SYS_ID_AA64MMFR2_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64MMFR2_EL1_FWB_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64MMFR2_EL1_FWB_IMP,
 		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, FWB, IMP)
 	},
 	{
 		.desc = "ARMv8.4 Translation Table Level",
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.capability = ARM64_HAS_ARMv8_4_TTL,
-		.sys_reg = SYS_ID_AA64MMFR2_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64MMFR2_EL1_TTL_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64MMFR2_EL1_TTL_IMP,
 		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, TTL, IMP)
 	},
 	{
 		.desc = "TLB range maintenance instructions",
 		.capability = ARM64_HAS_TLB_RANGE,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64ISAR0_EL1,
-		.field_pos = ID_AA64ISAR0_EL1_TLB_SHIFT,
-		.field_width = 4,
-		.sign = FTR_UNSIGNED,
-		.min_field_value = ID_AA64ISAR0_EL1_TLB_RANGE,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR0_EL1, TLB, RANGE)
 	},
 #ifdef CONFIG_ARM64_HW_AFDBM
 	{
@@ -2474,13 +2408,9 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		 */
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
 		.capability = ARM64_HW_DBM,
-		.sys_reg = SYS_ID_AA64MMFR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64MMFR1_EL1_HAFDBS_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64MMFR1_EL1_HAFDBS_DBM,
 		.matches = has_hw_dbm,
 		.cpu_enable = cpu_enable_hw_dbm,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR1_EL1, HAFDBS, DBM)
 	},
 #endif
 	{
@@ -2488,21 +2418,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_CRC32,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64ISAR0_EL1,
-		.field_pos = ID_AA64ISAR0_EL1_CRC32_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64ISAR0_EL1_CRC32_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR0_EL1, CRC32, IMP)
 	},
 	{
 		.desc = "Speculative Store Bypassing Safe (SSBS)",
 		.capability = ARM64_SSBS,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64PFR1_EL1,
-		.field_pos = ID_AA64PFR1_EL1_SSBS_SHIFT,
-		.field_width = 4,
-		.sign = FTR_UNSIGNED,
-		.min_field_value = ID_AA64PFR1_EL1_SSBS_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, SSBS, IMP)
 	},
 #ifdef CONFIG_ARM64_CNP
 	{
@@ -2510,12 +2433,8 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_CNP,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_useable_cnp,
-		.sys_reg = SYS_ID_AA64MMFR2_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64MMFR2_EL1_CnP_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64MMFR2_EL1_CnP_IMP,
 		.cpu_enable = cpu_enable_cnp,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, CnP, IMP)
 	},
 #endif
 	{
@@ -2523,45 +2442,29 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_SB,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64ISAR1_EL1,
-		.field_pos = ID_AA64ISAR1_EL1_SB_SHIFT,
-		.field_width = 4,
-		.sign = FTR_UNSIGNED,
-		.min_field_value = ID_AA64ISAR1_EL1_SB_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, SB, IMP)
 	},
 #ifdef CONFIG_ARM64_PTR_AUTH
 	{
 		.desc = "Address authentication (architected QARMA5 algorithm)",
 		.capability = ARM64_HAS_ADDRESS_AUTH_ARCH_QARMA5,
 		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
-		.sys_reg = SYS_ID_AA64ISAR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64ISAR1_EL1_APA_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64ISAR1_EL1_APA_PAuth,
 		.matches = has_address_auth_cpucap,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, APA, PAuth)
 	},
 	{
 		.desc = "Address authentication (architected QARMA3 algorithm)",
 		.capability = ARM64_HAS_ADDRESS_AUTH_ARCH_QARMA3,
 		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
-		.sys_reg = SYS_ID_AA64ISAR2_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64ISAR2_EL1_APA3_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64ISAR2_EL1_APA3_PAuth,
 		.matches = has_address_auth_cpucap,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR2_EL1, APA3, PAuth)
 	},
 	{
 		.desc = "Address authentication (IMP DEF algorithm)",
 		.capability = ARM64_HAS_ADDRESS_AUTH_IMP_DEF,
 		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
-		.sys_reg = SYS_ID_AA64ISAR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64ISAR1_EL1_API_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64ISAR1_EL1_API_PAuth,
 		.matches = has_address_auth_cpucap,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, API, PAuth)
 	},
 	{
 		.capability = ARM64_HAS_ADDRESS_AUTH,
@@ -2572,34 +2475,22 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "Generic authentication (architected QARMA5 algorithm)",
 		.capability = ARM64_HAS_GENERIC_AUTH_ARCH_QARMA5,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.sys_reg = SYS_ID_AA64ISAR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64ISAR1_EL1_GPA_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64ISAR1_EL1_GPA_IMP,
 		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, GPA, IMP)
 	},
 	{
 		.desc = "Generic authentication (architected QARMA3 algorithm)",
 		.capability = ARM64_HAS_GENERIC_AUTH_ARCH_QARMA3,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.sys_reg = SYS_ID_AA64ISAR2_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64ISAR2_EL1_GPA3_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64ISAR2_EL1_GPA3_IMP,
 		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR2_EL1, GPA3, IMP)
 	},
 	{
 		.desc = "Generic authentication (IMP DEF algorithm)",
 		.capability = ARM64_HAS_GENERIC_AUTH_IMP_DEF,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.sys_reg = SYS_ID_AA64ISAR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64ISAR1_EL1_GPI_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64ISAR1_EL1_GPI_IMP,
 		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, GPI, IMP)
 	},
 	{
 		.capability = ARM64_HAS_GENERIC_AUTH,
@@ -2631,13 +2522,9 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "E0PD",
 		.capability = ARM64_HAS_E0PD,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.sys_reg = SYS_ID_AA64MMFR2_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_width = 4,
-		.field_pos = ID_AA64MMFR2_EL1_E0PD_SHIFT,
-		.matches = has_cpuid_feature,
-		.min_field_value = ID_AA64MMFR2_EL1_E0PD_IMP,
 		.cpu_enable = cpu_enable_e0pd,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, E0PD, IMP)
 	},
 #endif
 	{
@@ -2645,11 +2532,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_HAS_RNG,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64ISAR0_EL1,
-		.field_pos = ID_AA64ISAR0_EL1_RNDR_SHIFT,
-		.field_width = 4,
-		.sign = FTR_UNSIGNED,
-		.min_field_value = ID_AA64ISAR0_EL1_RNDR_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR0_EL1, RNDR, IMP)
 	},
 #ifdef CONFIG_ARM64_BTI
 	{
@@ -2662,10 +2545,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 #endif
 		.matches = has_cpuid_feature,
 		.cpu_enable = bti_enable,
-		.sys_reg = SYS_ID_AA64PFR1_EL1,
-		.field_pos = ID_AA64PFR1_EL1_BT_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR1_EL1_BT_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, BT, IMP)
 		.sign = FTR_UNSIGNED,
 	},
 #endif
@@ -2675,109 +2555,72 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.capability = ARM64_MTE,
 		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64PFR1_EL1,
-		.field_pos = ID_AA64PFR1_EL1_MTE_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR1_EL1_MTE_MTE2,
-		.sign = FTR_UNSIGNED,
 		.cpu_enable = cpu_enable_mte,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, MTE, MTE2)
 	},
 	{
 		.desc = "Asymmetric MTE Tag Check Fault",
 		.capability = ARM64_MTE_ASYMM,
 		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
 		.matches = has_cpuid_feature,
-		.sys_reg = SYS_ID_AA64PFR1_EL1,
-		.field_pos = ID_AA64PFR1_EL1_MTE_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR1_EL1_MTE_MTE3,
-		.sign = FTR_UNSIGNED,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, MTE, MTE3)
 	},
 #endif /* CONFIG_ARM64_MTE */
 	{
 		.desc = "RCpc load-acquire (LDAPR)",
 		.capability = ARM64_HAS_LDAPR,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.sys_reg = SYS_ID_AA64ISAR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64ISAR1_EL1_LRCPC_SHIFT,
-		.field_width = 4,
 		.matches = has_cpuid_feature,
-		.min_field_value = ID_AA64ISAR1_EL1_LRCPC_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, LRCPC, IMP)
 	},
 #ifdef CONFIG_ARM64_SME
 	{
 		.desc = "Scalable Matrix Extension",
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.capability = ARM64_SME,
-		.sys_reg = SYS_ID_AA64PFR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64PFR1_EL1_SME_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR1_EL1_SME_IMP,
 		.matches = has_cpuid_feature,
 		.cpu_enable = sme_kernel_enable,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, SME, IMP)
 	},
 	/* FA64 should be sorted after the base SME capability */
 	{
 		.desc = "FA64",
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.capability = ARM64_SME_FA64,
-		.sys_reg = SYS_ID_AA64SMFR0_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64SMFR0_EL1_FA64_SHIFT,
-		.field_width = 1,
-		.min_field_value = ID_AA64SMFR0_EL1_FA64_IMP,
 		.matches = has_cpuid_feature,
 		.cpu_enable = fa64_kernel_enable,
+		ARM64_CPUID_FIELDS(ID_AA64SMFR0_EL1, FA64, IMP)
 	},
 	{
 		.desc = "SME2",
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.capability = ARM64_SME2,
-		.sys_reg = SYS_ID_AA64PFR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64PFR1_EL1_SME_SHIFT,
-		.field_width = ID_AA64PFR1_EL1_SME_WIDTH,
-		.min_field_value = ID_AA64PFR1_EL1_SME_SME2,
 		.matches = has_cpuid_feature,
 		.cpu_enable = sme2_kernel_enable,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, SME, SME2)
 	},
 #endif /* CONFIG_ARM64_SME */
 	{
 		.desc = "WFx with timeout",
 		.capability = ARM64_HAS_WFXT,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.sys_reg = SYS_ID_AA64ISAR2_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64ISAR2_EL1_WFxT_SHIFT,
-		.field_width = 4,
-		.matches = has_cpuid_feature,
-		.min_field_value = ID_AA64ISAR2_EL1_WFxT_IMP,
+		ARM64_CPUID_FIELDS(ID_AA64ISAR2_EL1, WFxT, IMP)
 	},
 	{
 		.desc = "Trap EL0 IMPLEMENTATION DEFINED functionality",
 		.capability = ARM64_HAS_TIDCP1,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.sys_reg = SYS_ID_AA64MMFR1_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64MMFR1_EL1_TIDCP1_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64MMFR1_EL1_TIDCP1_IMP,
 		.matches = has_cpuid_feature,
 		.cpu_enable = cpu_trap_el0_impdef,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR1_EL1, TIDCP1, IMP)
 	},
 	{
 		.desc = "Data independent timing control (DIT)",
 		.capability = ARM64_HAS_DIT,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.sys_reg = SYS_ID_AA64PFR0_EL1,
-		.sign = FTR_UNSIGNED,
-		.field_pos = ID_AA64PFR0_EL1_DIT_SHIFT,
-		.field_width = 4,
-		.min_field_value = ID_AA64PFR0_EL1_DIT_IMP,
 		.matches = has_cpuid_feature,
 		.cpu_enable = cpu_enable_dit,
+		ARM64_CPUID_FIELDS(ID_AA64PFR0_EL1, DIT, IMP)
 	},
 	{},
 };

-- 
2.30.2

