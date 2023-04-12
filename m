Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481586DFC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjDLROW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjDLROR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4248030FB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C86E5637B5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6882C4339E;
        Wed, 12 Apr 2023 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681319644;
        bh=VTfNMr9L+OZD61fr7gdaYm/jVX8qzkby7YMcuXZ9mFU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pYAgGKw6oBfEBPC3xb5MQ+qXF3cdhyq3xI7rkSDPbtGSWCqbri3izq9U9LxnbTf/6
         s3T8apuKYTELQapOBUNpMAJNsvaGB1jgNcXVRLxNwa2HZiPjBb0MqfpxCmyouHKRGI
         60fE2NOIf7xK9hlHbrmUtFhSmT25+kVJIUw2GjBtRHKPWuKihOYp13/kzkBchTOJrw
         J3i/l8Lgfq2FAHLUdG7cxbIaUuTL7ODcNp5YSpFPDnofA+5+X9mzr6dRyY/8cSiymS
         GQS88sMVE88d/ROUJhWIfb5tX6S4YbwShnvS/bNjOSNHPmnfhOaPTlFgntVArnWiSB
         N/8SGNgUpGOdg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Apr 2023 18:13:29 +0100
Subject: [PATCH v2 1/3] arm64/cpufeature: Pull out helper for CPUID
 register definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-arm64-cpufeature-helpers-v2-1-4c8f28a6f203@kernel.org>
References: <20230303-arm64-cpufeature-helpers-v2-0-4c8f28a6f203@kernel.org>
In-Reply-To: <20230303-arm64-cpufeature-helpers-v2-0-4c8f28a6f203@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VTfNMr9L+OZD61fr7gdaYm/jVX8qzkby7YMcuXZ9mFU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkNubWzerJZvckitenc7/mckoyIh0Nq134HMGt/est
 7Arl19CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZDbm1gAKCRAk1otyXVSH0FmRB/
 4utI+Mfu644AUhJ5yrBtdMLBweVc6k6yz5MOqzZkndbBDwU183tL71R4naBxLSyt/Kza+1LN/IeAfC
 B46aTYi2t+AqR3FeLo/Or/JMtuycmF4TtYHkXa5wymBNOtyEnQmECNML3ewKe5V/8uVfXAAyD6QDw/
 SJX6JMbdMfGs0rvkPycvIsfKf47y2J8Gpncud7HLvSjxoTea04oo8URuhLRf2t/g0gc7fiJy6CT5jl
 qeEwPj6wiePl18M3RyaVO9Omx5KCCsm5mzjAToqJU58dcIh7BdL+weOLc4PNixEm6cgXZ8sQOkls17
 rMVjYNeXhstvH7fjGYO3RdKnkmMMrd
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use the same structure to match hwcaps and CPU features so we can use
the same helper to generate the fields required. Pull the portion of the
current hwcaps helper that initialises the fields out into a separate
define placed earlier in the file so we can use it for cpufeatures.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 2e3e55139777..77862b7c8908 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -140,6 +140,13 @@ void dump_cpu_features(void)
 	pr_emerg("0x%*pb\n", ARM64_NCAPS, &cpu_hwcaps);
 }
 
+#define ARM64_CPUID_FIELDS(reg, field, min_value)			\
+		.sys_reg = SYS_##reg,							\
+		.field_pos = reg##_##field##_SHIFT,						\
+		.field_width = reg##_##field##_WIDTH,						\
+		.sign = reg##_##field##_SIGNED,							\
+		.min_field_value = reg##_##field##_##min_value,
+
 #define __ARM64_FTR_BITS(SIGNED, VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
 	{						\
 		.sign = SIGNED,				\
@@ -2776,12 +2783,8 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 };
 
 #define HWCAP_CPUID_MATCH(reg, field, min_value)			\
-		.matches = has_user_cpuid_feature,					\
-		.sys_reg = SYS_##reg,							\
-		.field_pos = reg##_##field##_SHIFT,						\
-		.field_width = reg##_##field##_WIDTH,						\
-		.sign = reg##_##field##_SIGNED,							\
-		.min_field_value = reg##_##field##_##min_value,
+		.matches = has_user_cpuid_feature,			\
+		ARM64_CPUID_FIELDS(reg, field, min_value)
 
 #define __HWCAP_CAP(name, cap_type, cap)					\
 		.desc = name,							\
@@ -2811,26 +2814,26 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 #ifdef CONFIG_ARM64_PTR_AUTH
 static const struct arm64_cpu_capabilities ptr_auth_hwcap_addr_matches[] = {
 	{
-		HWCAP_CPUID_MATCH(ID_AA64ISAR1_EL1, APA, PAuth)
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, APA, PAuth)
 	},
 	{
-		HWCAP_CPUID_MATCH(ID_AA64ISAR2_EL1, APA3, PAuth)
+		ARM64_CPUID_FIELDS(ID_AA64ISAR2_EL1, APA3, PAuth)
 	},
 	{
-		HWCAP_CPUID_MATCH(ID_AA64ISAR1_EL1, API, PAuth)
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, API, PAuth)
 	},
 	{},
 };
 
 static const struct arm64_cpu_capabilities ptr_auth_hwcap_gen_matches[] = {
 	{
-		HWCAP_CPUID_MATCH(ID_AA64ISAR1_EL1, GPA, IMP)
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, GPA, IMP)
 	},
 	{
-		HWCAP_CPUID_MATCH(ID_AA64ISAR2_EL1, GPA3, IMP)
+		ARM64_CPUID_FIELDS(ID_AA64ISAR2_EL1, GPA3, IMP)
 	},
 	{
-		HWCAP_CPUID_MATCH(ID_AA64ISAR1_EL1, GPI, IMP)
+		ARM64_CPUID_FIELDS(ID_AA64ISAR1_EL1, GPI, IMP)
 	},
 	{},
 };

-- 
2.30.2

