Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B496AE1CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjCGOJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCGOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:09:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625F188
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C6A761453
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE50C4339E;
        Tue,  7 Mar 2023 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198072;
        bh=R6myqakIkwiwpNZGWu/wqgHZyBX0rotu/zhA9jFg+14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqDiStOJRd9+NhvoSAIywVDmpCjynLcL+RYWa93nYJQM/oBShIoyF+U+KiBwSIxef
         HZPWxpJwJ0h8AoW+RPyxOSHEKwbDBL7Zs5urldwQuygv8OA5dXH27JlhVnHdBOcO3Y
         4cqEarAi4uvZn6KAOQ2haI2KpetS0thitH4boR8rf4DTjVwhPjTEP5mG8DnJanY4Vp
         HeD5HuyMbpLDkt4GuFezCNDmvlTli6v5JDrTu9f2BcYtfyAzZ5v+S6+EgailWPFbo3
         QUFwMWhTVBbLpuHyN0hcxDFh+jVf8pWv+2kHVoEplNcb475NlItufqevmsIr75Ry6Q
         0tKA3kmN1qGSQ==
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
Subject: [PATCH v3 31/60] arm64: Add helpers to probe local CPU for PAC/BTI/E0PD support
Date:   Tue,  7 Mar 2023 15:04:53 +0100
Message-Id: <20230307140522.2311461-32-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3104; i=ardb@kernel.org; h=from:subject; bh=R6myqakIkwiwpNZGWu/wqgHZyBX0rotu/zhA9jFg+14=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdxUeJM+v9htPWPAbaa45Ocnnovf8M67tZp/etWeLDv 83l0I/2jlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRu3KMDLdPXgmcE6l4dO20 3TNdzz3rWNma+qhwzxWDmaFPuErKG4sY/rt++3xvwdHF+27M/Vj0cfuB7VeFZIK+hWTPWNmxZId DaSUXAA==
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

Add some helpers that will be used by the early kernel mapping code to
check feature support on the local CPU. This permits the early kernel
mapping to be created with the right attributes, removing the need for
tearing it down and recreating it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h | 56 ++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c      | 12 +----
 2 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index edc7733aa49846b2..edefe3b36fe5c243 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -933,6 +933,62 @@ extern struct arm64_ftr_override arm64_sw_feature_override;
 u32 get_kvm_ipa_limit(void);
 void dump_cpu_features(void);
 
+static inline bool cpu_has_bti(void)
+{
+	u64 pfr1;
+
+	if (!IS_ENABLED(CONFIG_ARM64_BTI))
+		return false;
+
+	pfr1 = read_cpuid(ID_AA64PFR1_EL1);
+	pfr1 &= ~id_aa64pfr1_override.mask;
+	pfr1 |= id_aa64pfr1_override.val;
+
+	return cpuid_feature_extract_unsigned_field(pfr1,
+						    ID_AA64PFR1_EL1_BT_SHIFT);
+}
+
+static inline bool cpu_has_e0pd(void)
+{
+	u64 mmfr2;
+
+	if (!IS_ENABLED(CONFIG_ARM64_E0PD))
+		return false;
+
+	mmfr2 = read_sysreg_s(SYS_ID_AA64MMFR2_EL1);
+	return cpuid_feature_extract_unsigned_field(mmfr2,
+						    ID_AA64MMFR2_EL1_E0PD_SHIFT);
+}
+
+static inline bool cpu_has_pac(void)
+{
+	u64 isar1, isar2;
+	u8 feat;
+
+	if (!IS_ENABLED(CONFIG_ARM64_PTR_AUTH))
+		return false;
+
+	isar1 = read_cpuid(ID_AA64ISAR1_EL1);
+	isar1 &= ~id_aa64isar1_override.mask;
+	isar1 |= id_aa64isar1_override.val;
+	feat = cpuid_feature_extract_unsigned_field(isar1,
+						    ID_AA64ISAR1_EL1_APA_SHIFT);
+	if (feat)
+		return true;
+
+	feat = cpuid_feature_extract_unsigned_field(isar1,
+						    ID_AA64ISAR1_EL1_API_SHIFT);
+	if (feat)
+		return true;
+
+	isar2 = read_sysreg_s(SYS_ID_AA64ISAR2_EL1);
+	isar2 &= ~id_aa64isar2_override.mask;
+	isar2 |= id_aa64isar2_override.val;
+	feat = cpuid_feature_extract_unsigned_field(isar2,
+						    ID_AA64ISAR2_EL1_APA3_SHIFT);
+	return feat;
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0b16e676b68c6543..9838934fee028bcb 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1609,21 +1609,11 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
  */
 bool kaslr_requires_kpti(void)
 {
-	if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
-		return false;
-
 	/*
 	 * E0PD does a similar job to KPTI so can be used instead
 	 * where available.
 	 */
-	if (IS_ENABLED(CONFIG_ARM64_E0PD)) {
-		u64 mmfr2 = read_sysreg_s(SYS_ID_AA64MMFR2_EL1);
-		if (cpuid_feature_extract_unsigned_field(mmfr2,
-						ID_AA64MMFR2_EL1_E0PD_SHIFT))
-			return false;
-	}
-
-	return kaslr_enabled();
+	return kaslr_enabled() && !cpu_has_e0pd();
 }
 
 static bool __meltdown_safe = true;
-- 
2.39.2

