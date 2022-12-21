Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5A6535FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiLUSPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiLUSP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:15:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB9B2644
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:15:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90C01618BF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 18:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91760C43392;
        Wed, 21 Dec 2022 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671646517;
        bh=qT18h6VXOzbVG0+Hhyjes2EA4hUevjFqDZ/SghRNSxI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=eW7uEND1Xkoo20ktoD4lSU/z/2kmd/qN8A/fvYnQ/4BKl8Hx5sDh5rwOO9aoC3EBB
         4qjThBalhTnKnmpuVc1v3A1wvJaRscQUtvpb82LD+BmhRYu0L+UyBBN7PmwwzFDR3o
         XGbV+R7EherBkWA3RKu6hFeHq19WmP0sdVvpoXJkK4cUYfWcHSK/X0n5ft2TfXe3mf
         gWCj3UcAVze7vG5Wsdb3JDCbSTbnRCMIIagUe2Wkibazh9VmGFqMljdUlFctbvxp3d
         Sfb2rASBeMGtQquuCPwwB0Q5Gvob9EZ43/y4HI/0O+dHYph5dPUjt2JnJ8wzzX4Ivz
         Go93EfDCvQwxw==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 21 Dec 2022 18:06:10 +0000
Subject: [PATCH 2/2] KVM: arm64: Remove use of ARM64_FEATURE_MASK()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221221-kvm-sysreg-cleanup-v1-2-112ddb14fb4e@kernel.org>
References: <20221221-kvm-sysreg-cleanup-v1-0-112ddb14fb4e@kernel.org>
In-Reply-To: <20221221-kvm-sysreg-cleanup-v1-0-112ddb14fb4e@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-05166
X-Developer-Signature: v=1; a=openpgp-sha256; l=12890; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qT18h6VXOzbVG0+Hhyjes2EA4hUevjFqDZ/SghRNSxI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjo00rGhaawau3jMrrVFD9OI8WRlEZ82QrOeGliFxW
 78fSqVeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6NNKwAKCRAk1otyXVSH0HZdB/
 9HQmF/CVXhC6vDEu2hSBiWl5PGCcOAA+xIcwLSSmw2HlARvhSbri3faWZUNDec/INw7X46gtk+7mpC
 shC/wUD2GHJwRWpyrsHSPr3nYxSDgOnH/1QTsh0k1aDAsmVqKJUX8+pxoT57Ipcn9pu3txVwI7Fkl/
 1trwN4P+FqGG10F9B6YPDuycqory5C/Rqk24LTDM6y6BIjTcn6CJM3J+4AFHib6rzI7e4ONktQ4mRo
 Z2mZNbYMl9H7Thv0DDzVhXbqS35m/ogCdR/Gxia14v03iEMOLLDTrrtyFzIADEFVRrxnRYphvT2wMl
 tjjZQfmdigp4QgN1DsiXu2BJJdsyV/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KVM code makes extensive use of ARM64_FEATURE_MASK() to generate a
mask for fields in the ID registers. This macro has the assumption that
all feature fields are 4 bits wide but the architecture has evolved to
add fields with other widths, such as the 1 bit fields in ID_AA64SMFR0_EL1,
so we need to adjust the

We could fix this by making ARM64_FEATURE_MASK() use the generated macros
that we have now but since one of these is a direct _MASK constant the
result is something that's more verbose and less direct than just updating
the users to directly use the generated mask macros, writing

	#define ARM64_FEATURE_MASK(x)	(x##_MASK)

obviously looks redundant and if we look at the users updating them turns

	val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_CSV3);

into the more direct

	val &= ~ID_AA64PFR0_EL1_CSV3_MASK;

rather than updating the macro just remove the users. This is a relatively
large code change but very mechanical.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h                |   3 -
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h | 106 ++++++++++++-------------
 arch/arm64/kvm/hyp/nvhe/sys_regs.c             |  14 ++--
 arch/arm64/kvm/sys_regs.c                      |  44 +++++-----
 4 files changed, 82 insertions(+), 85 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 1312fb48f18b..3ac6ed1921c7 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -809,9 +809,6 @@
 
 #define ARM64_FEATURE_FIELD_BITS	4
 
-/* Create a mask for the feature bits of the specified feature. */
-#define ARM64_FEATURE_MASK(x)	(GENMASK_ULL(x##_SHIFT + ARM64_FEATURE_FIELD_BITS - 1, x##_SHIFT))
-
 #ifdef __ASSEMBLY__
 
 	.macro	mrs_s, rt, sreg
diff --git a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
index f42cd1bdb45b..a8aa9efe6581 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
@@ -35,9 +35,9 @@
  * - Data Independent Timing
  */
 #define PVM_ID_AA64PFR0_ALLOW (\
-	ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_FP) | \
-	ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_AdvSIMD) | \
-	ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_DIT) \
+	ID_AA64PFR0_EL1_FP_MASK | \
+	ID_AA64PFR0_EL1_AdvSIMD_MASK | \
+	ID_AA64PFR0_EL1_DIT_MASK \
 	)
 
 /*
@@ -62,8 +62,8 @@
  * - Speculative Store Bypassing
  */
 #define PVM_ID_AA64PFR1_ALLOW (\
-	ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_BT) | \
-	ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SSBS) \
+	ID_AA64PFR1_EL1_BT_MASK | \
+	ID_AA64PFR1_EL1_SSBS_MASK \
 	)
 
 /*
@@ -74,10 +74,10 @@
  * - Non-context synchronizing exception entry and exit
  */
 #define PVM_ID_AA64MMFR0_ALLOW (\
-	ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_BIGEND) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_SNSMEM) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_BIGENDEL0) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR0_EL1_EXS) \
+	ID_AA64MMFR0_EL1_BIGEND_MASK | \
+	ID_AA64MMFR0_EL1_SNSMEM_MASK | \
+	ID_AA64MMFR0_EL1_BIGENDEL0_MASK | \
+	ID_AA64MMFR0_EL1_EXS_MASK \
 	)
 
 /*
@@ -100,12 +100,12 @@
  * - Enhanced Translation Synchronization
  */
 #define PVM_ID_AA64MMFR1_ALLOW (\
-	ARM64_FEATURE_MASK(ID_AA64MMFR1_EL1_HAFDBS) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR1_EL1_VMIDBits) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR1_EL1_HPDS) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR1_EL1_PAN) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR1_EL1_SpecSEI) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR1_EL1_ETS) \
+	ID_AA64MMFR1_EL1_HAFDBS_MASK | \
+	ID_AA64MMFR1_EL1_VMIDBits_MASK | \
+	ID_AA64MMFR1_EL1_HPDS_MASK | \
+	ID_AA64MMFR1_EL1_PAN_MASK | \
+	ID_AA64MMFR1_EL1_SpecSEI_MASK | \
+	ID_AA64MMFR1_EL1_ETS_MASK \
 	)
 
 /*
@@ -120,14 +120,14 @@
  * - E0PDx mechanism
  */
 #define PVM_ID_AA64MMFR2_ALLOW (\
-	ARM64_FEATURE_MASK(ID_AA64MMFR2_EL1_CnP) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR2_EL1_UAO) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR2_EL1_IESB) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR2_EL1_AT) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR2_EL1_IDS) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR2_EL1_TTL) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR2_EL1_BBM) | \
-	ARM64_FEATURE_MASK(ID_AA64MMFR2_EL1_E0PD) \
+	ID_AA64MMFR2_EL1_CnP_MASK | \
+	ID_AA64MMFR2_EL1_UAO_MASK | \
+	ID_AA64MMFR2_EL1_IESB_MASK | \
+	ID_AA64MMFR2_EL1_AT_MASK | \
+	ID_AA64MMFR2_EL1_IDS_MASK | \
+	ID_AA64MMFR2_EL1_TTL_MASK | \
+	ID_AA64MMFR2_EL1_BBM_MASK | \
+	ID_AA64MMFR2_EL1_E0PD_MASK \
 	)
 
 /*
@@ -159,42 +159,42 @@
  * No restrictions on instructions implemented in AArch64.
  */
 #define PVM_ID_AA64ISAR0_ALLOW (\
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_AES) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_SHA1) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_SHA2) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_CRC32) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_ATOMIC) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_RDM) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_SHA3) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_SM3) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_SM4) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_DP) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_FHM) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_TS) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_TLB) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR0_EL1_RNDR) \
+	ID_AA64ISAR0_EL1_AES_MASK | \
+	ID_AA64ISAR0_EL1_SHA1_MASK | \
+	ID_AA64ISAR0_EL1_SHA2_MASK | \
+	ID_AA64ISAR0_EL1_CRC32_MASK | \
+	ID_AA64ISAR0_EL1_ATOMIC_MASK | \
+	ID_AA64ISAR0_EL1_RDM_MASK | \
+	ID_AA64ISAR0_EL1_SHA3_MASK | \
+	ID_AA64ISAR0_EL1_SM3_MASK | \
+	ID_AA64ISAR0_EL1_SM4_MASK | \
+	ID_AA64ISAR0_EL1_DP_MASK | \
+	ID_AA64ISAR0_EL1_FHM_MASK | \
+	ID_AA64ISAR0_EL1_TS_MASK | \
+	ID_AA64ISAR0_EL1_TLB_MASK | \
+	ID_AA64ISAR0_EL1_RNDR_MASK \
 	)
 
 #define PVM_ID_AA64ISAR1_ALLOW (\
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_DPB) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_APA) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_API) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_JSCVT) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_FCMA) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_LRCPC) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_GPA) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_GPI) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_FRINTTS) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_SB) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_SPECRES) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_BF16) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_DGH) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_I8MM) \
+	ID_AA64ISAR1_EL1_DPB_MASK | \
+	ID_AA64ISAR1_EL1_APA_MASK | \
+	ID_AA64ISAR1_EL1_API_MASK | \
+	ID_AA64ISAR1_EL1_JSCVT_MASK | \
+	ID_AA64ISAR1_EL1_FCMA_MASK | \
+	ID_AA64ISAR1_EL1_LRCPC_MASK | \
+	ID_AA64ISAR1_EL1_GPA_MASK | \
+	ID_AA64ISAR1_EL1_GPI_MASK | \
+	ID_AA64ISAR1_EL1_FRINTTS_MASK | \
+	ID_AA64ISAR1_EL1_SB_MASK | \
+	ID_AA64ISAR1_EL1_SPECRES_MASK | \
+	ID_AA64ISAR1_EL1_BF16_MASK | \
+	ID_AA64ISAR1_EL1_DGH_MASK | \
+	ID_AA64ISAR1_EL1_I8MM_MASK \
 	)
 
 #define PVM_ID_AA64ISAR2_ALLOW (\
-	ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_GPA3) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_APA3) \
+	ID_AA64ISAR2_EL1_GPA3_MASK | \
+	ID_AA64ISAR2_EL1_APA3_MASK \
 	)
 
 u64 pvm_read_id_reg(const struct kvm_vcpu *vcpu, u32 id);
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index 1e656d928819..bb024e0a5f75 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -106,7 +106,7 @@ static u64 get_pvm_id_aa64pfr1(const struct kvm_vcpu *vcpu)
 	u64 allow_mask = PVM_ID_AA64PFR1_ALLOW;
 
 	if (!kvm_has_mte(kvm))
-		allow_mask &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE);
+		allow_mask &= ~ID_AA64PFR1_EL1_MTE_MASK;
 
 	return id_aa64pfr1_el1_sys_val & allow_mask;
 }
@@ -171,10 +171,10 @@ static u64 get_pvm_id_aa64isar1(const struct kvm_vcpu *vcpu)
 	u64 allow_mask = PVM_ID_AA64ISAR1_ALLOW;
 
 	if (!vcpu_has_ptrauth(vcpu))
-		allow_mask &= ~(ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_APA) |
-				ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_API) |
-				ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_GPA) |
-				ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_GPI));
+		allow_mask &= ~(ID_AA64ISAR1_EL1_APA_MASK |
+				ID_AA64ISAR1_EL1_API_MASK |
+				ID_AA64ISAR1_EL1_GPA_MASK |
+				ID_AA64ISAR1_EL1_GPI_MASK);
 
 	return id_aa64isar1_el1_sys_val & allow_mask;
 }
@@ -184,8 +184,8 @@ static u64 get_pvm_id_aa64isar2(const struct kvm_vcpu *vcpu)
 	u64 allow_mask = PVM_ID_AA64ISAR2_ALLOW;
 
 	if (!vcpu_has_ptrauth(vcpu))
-		allow_mask &= ~(ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_APA3) |
-				ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_GPA3));
+		allow_mask &= ~(ID_AA64ISAR2_EL1_APA3_MASK |
+				ID_AA64ISAR2_EL1_GPA3_MASK);
 
 	return id_aa64isar2_el1_sys_val & allow_mask;
 }
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f97695bb8f64..12731ec000d2 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1108,52 +1108,52 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu, struct sys_reg_desc const *r
 	switch (id) {
 	case SYS_ID_AA64PFR0_EL1:
 		if (!vcpu_has_sve(vcpu))
-			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_SVE);
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_AMU);
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_CSV2);
+			val &= ~ID_AA64PFR0_EL1_SVE_MASK;
+		val &= ~ID_AA64PFR0_EL1_AMU_MASK;
+		val &= ~ID_AA64PFR0_EL1_CSV2_MASK;
 		val |= SYS_FIELD_PREP(ID_AA64PFR0_EL1, CSV2,
 				      (u64)vcpu->kvm->arch.pfr0_csv2);
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_CSV3);
+		val &= ~ID_AA64PFR0_EL1_CSV3_MASK;
 		val |= SYS_FIELD_PREP(ID_AA64PFR0_EL1, CSV3,
 				      (u64)vcpu->kvm->arch.pfr0_csv3);
 		if (kvm_vgic_global_state.type == VGIC_V3) {
-			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_GIC);
+			val &= ~ID_AA64PFR0_EL1_GIC_MASK;
 			val |= SYS_FIELD_PREP(ID_AA64PFR0_EL1, GIC, 1);
 		}
 		break;
 	case SYS_ID_AA64PFR1_EL1:
 		if (!kvm_has_mte(vcpu->kvm))
-			val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTE);
+			val &= ~ID_AA64PFR1_EL1_MTE_MASK;
 
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
+		val &= ~ID_AA64PFR1_EL1_SME_MASK;
 		break;
 	case SYS_ID_AA64ISAR1_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
-			val &= ~(ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_APA) |
-				 ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_API) |
-				 ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_GPA) |
-				 ARM64_FEATURE_MASK(ID_AA64ISAR1_EL1_GPI));
+			val &= ~(ID_AA64ISAR1_EL1_APA_MASK |
+				 ID_AA64ISAR1_EL1_API_MASK |
+				 ID_AA64ISAR1_EL1_GPA_MASK |
+				 ID_AA64ISAR1_EL1_GPI_MASK);
 		break;
 	case SYS_ID_AA64ISAR2_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
-			val &= ~(ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_APA3) |
-				 ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_GPA3));
+			val &= ~(ID_AA64ISAR2_EL1_APA3_MASK |
+				 ID_AA64ISAR2_EL1_GPA3_MASK);
 		if (!cpus_have_final_cap(ARM64_HAS_WFXT))
-			val &= ~ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_WFxT);
+			val &= ~ID_AA64ISAR2_EL1_WFxT_MASK;
 		break;
 	case SYS_ID_AA64DFR0_EL1:
 		/* Limit debug to ARMv8.0 */
-		val &= ~ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_DebugVer);
+		val &= ~ID_AA64DFR0_EL1_DebugVer_MASK;
 		val |= SYS_FIELD_PREP(ID_AA64DFR0_EL1, DebugVer, 6);
 		/* Set PMUver to the required version */
-		val &= ~ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer);
+		val &= ~ID_AA64DFR0_EL1_PMUVer_MASK;
 		val |= SYS_FIELD_PREP(ID_AA64DFR0_EL1, PMUVer,
 				      vcpu_pmuver(vcpu));
 		/* Hide SPE from guests */
-		val &= ~ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMSVer);
+		val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
 		break;
 	case SYS_ID_DFR0_EL1:
-		val &= ~ARM64_FEATURE_MASK(ID_DFR0_EL1_PerfMon);
+		val &= ~ID_DFR0_EL1_PerfMon_MASK;
 		val |= SYS_FIELD_PREP(ID_DFR0_EL1, PerfMon,
 				      pmuver_to_perfmon(vcpu_pmuver(vcpu)));
 		break;
@@ -1244,8 +1244,8 @@ static int set_id_aa64pfr0_el1(struct kvm_vcpu *vcpu,
 
 	/* We can only differ with CSV[23], and anything else is an error */
 	val ^= read_id_reg(vcpu, rd);
-	val &= ~(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_CSV2) |
-		 ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_CSV3));
+	val &= ~(ID_AA64PFR0_EL1_CSV2_MASK |
+		 ID_AA64PFR0_EL1_CSV3_MASK);
 	if (val)
 		return -EINVAL;
 
@@ -1282,7 +1282,7 @@ static int set_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
 
 	/* We can only differ with PMUver, and anything else is an error */
 	val ^= read_id_reg(vcpu, rd);
-	val &= ~ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer);
+	val &= ~ID_AA64DFR0_EL1_PMUVer_MASK;
 	if (val)
 		return -EINVAL;
 
@@ -1322,7 +1322,7 @@ static int set_id_dfr0_el1(struct kvm_vcpu *vcpu,
 
 	/* We can only differ with PerfMon, and anything else is an error */
 	val ^= read_id_reg(vcpu, rd);
-	val &= ~ARM64_FEATURE_MASK(ID_DFR0_EL1_PerfMon);
+	val &= ~ID_DFR0_EL1_PerfMon_MASK;
 	if (val)
 		return -EINVAL;
 

-- 
2.30.2
