Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22D0745192
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGBTzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjGBTzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7939346AC;
        Sun,  2 Jul 2023 12:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE5C660C87;
        Sun,  2 Jul 2023 19:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05CAC433C8;
        Sun,  2 Jul 2023 19:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327475;
        bh=SEP2CzktpoE0uCCFCAsWQ24FTZXxeagAN1OVOP/WSpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqD3qbhHR2fd1eXOJBApVbVnfR81FgC/f7sIRwp+T/mgBsBlHJyF2b4MBHciFRK/a
         uTP5KVZQgb+aVfK1uupaCiLWdLJAk88CM1NPf1K+UnGyghmyCeWrR9UdpJfypy3+8/
         LjWmuw2txXfz3cBKgWzKiOg5rKDClq338GhCFBPALhOF4EW3IPtZaqransZr4kCtqa
         ypPi5D1PIm5WKXoy2CjUyH02GGilJxIS6+o2pVmJGb6oI0TXhPhZU3eDzqVFsCRs+z
         CfI2BayVJYTbGRID7+ENnJ7sMzzdSuwYqqXCr0ZYa9g+1XefJJj7KiDwzfN5jpfCOj
         +1/TNc2GBPJEQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>, will@kernel.org,
        broonie@kernel.org, james.morse@arm.com, mark.rutland@arm.com,
        amit.kachhap@arm.com, maz@kernel.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.4 07/12] arm64: cpufeature: detect FEAT_HCX
Date:   Sun,  2 Jul 2023 15:50:52 -0400
Message-Id: <20230702195057.1787686-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195057.1787686-1-sashal@kernel.org>
References: <20230702195057.1787686-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kristina Martsenko <kristina.martsenko@arm.com>

[ Upstream commit b0c756fe996ac930033882ca56410639e5cad1ec ]

Detect if the system has the new HCRX_EL2 register added in ARMv8.7/9.2,
so that subsequent patches can check for its presence.

KVM currently relies on the register being present on all CPUs (or
none), so the kernel will panic if that is not the case. Fortunately no
such systems currently exist, but this can be revisited if they appear.
Note that the kernel will not panic if CONFIG_KVM is disabled.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Link: https://lore.kernel.org/r/20230509142235.3284028-3-kristina.martsenko@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 8 ++++++++
 arch/arm64/tools/cpucaps       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7d7128c651614..9898ad77b1dba 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -364,6 +364,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_TIDCP1_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_AFP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_HCX_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_ETS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_TWED_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1_XNX_SHIFT, 4, 0),
@@ -2309,6 +2310,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
 		.matches = is_kvm_protected_mode,
 	},
+	{
+		.desc = "HCRX_EL2 register",
+		.capability = ARM64_HAS_HCX,
+		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64MMFR1_EL1, HCX, IMP)
+	},
 #endif
 	{
 		.desc = "Kernel page table isolation (KPTI)",
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 40ba95472594d..e1de10fa080e0 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -32,6 +32,7 @@ HAS_GENERIC_AUTH_IMP_DEF
 HAS_GIC_CPUIF_SYSREGS
 HAS_GIC_PRIO_MASKING
 HAS_GIC_PRIO_RELAXED_SYNC
+HAS_HCX
 HAS_LDAPR
 HAS_LSE_ATOMICS
 HAS_NESTED_VIRT
-- 
2.39.2

