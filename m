Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3546AD16B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCFWUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCFWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:20:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EEE5D476
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C20B7B81141
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B7AC433A0;
        Mon,  6 Mar 2023 22:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678141239;
        bh=VTfNMr9L+OZD61fr7gdaYm/jVX8qzkby7YMcuXZ9mFU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=JAg71P6ctiIsp3OinvUbuklYSbxEQNHCJaI/ZeYXIB8NoTMsEmlyMkkwvmmRqoEFY
         E3m7LuMxCfHN9MhDjpolb5APS/kcKsaZmEMHdKQyruQPMvZ/7/EmtNf7NSuCTIwE3J
         9fnRiAYO6eAaQ3J7znBejZKC8UudnzkTYtOj8WDeY0bTUs4xD6pTUUVge9pTC1l/Nj
         lbWS0XSJPjspt92Z28comwlS/tOVi7Br+ZzNPkH9ouFs5ur/P8cp4hSKQMYGjWXdoo
         AF2qutd3rFc0k+Meu1ziqVDJFsswMZquodLMj7QGQsAlgQEbYE/OqopiJhXRtmCBSx
         +ll9DngBkjrtQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 06 Mar 2023 22:20:23 +0000
Subject: [PATCH 1/3] arm64/cpufeature: Pull out helper for CPUID register
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-arm64-cpufeature-helpers-v1-1-b16cf36acaea@kernel.org>
References: <20230303-arm64-cpufeature-helpers-v1-0-b16cf36acaea@kernel.org>
In-Reply-To: <20230303-arm64-cpufeature-helpers-v1-0-b16cf36acaea@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VTfNMr9L+OZD61fr7gdaYm/jVX8qzkby7YMcuXZ9mFU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBmcx2Y5IxiHuDp4hea7brk355PUmvzDhPhmF8Ym6
 zQik5RyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAZnMQAKCRAk1otyXVSH0G8SB/
 9/oeM1uv8BJc13DrXGX31mWlPAc13MPIZtUQqHVCGbSaBn9FhFf2KiNeTUEiLFgJ7ELv6vtat5sxvX
 6sCPSPUASguAku2QrOpqPvsOTYRSZZbgutHwo3QiCgeXAh3AoHNRRxv0aqz18XXWetLBbcC/yW8uAz
 viwoR6jhD9kThahXuXeHqfwpifLxGxFCW99N7kC4Y51VVJlUSfRIUzxpEcWbByxifOE03B77EGT29b
 HUtBY+leSgaFW/CCr2+Lr6LVgH4PNrhlxcH6E6ykpCoZCKgA5/SZdUmwOW4vWceSQUfy2i9aErOD3E
 P4UeeXBXyg8M4WfXF0IKxcKAFqM+H5
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

