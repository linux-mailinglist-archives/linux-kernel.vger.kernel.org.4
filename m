Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1F1686478
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjBAKi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjBAKiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:38:21 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A59EE078
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:38:07 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id ds1-20020a170907724100b008775bfcef62so11659551ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0HqL97JwBrjBXTVTitohvXvgoY0lt+wZC5NHuty9hs=;
        b=F1IZEKRs3mKSdDu2GkUO3JAx8xog6bGbY5YEQdnkELQ+JYavswPHRCFgSSDntxzr3z
         1ueatA5A8Nd6ttFz8/7DGcnIgGIA7eriaQMhruHktvtlty43CtfRH/TqUON4d1PizEz4
         5pnXmqT5cDiTgFLZlGg3H5F7dFNcbrF0Rv0q/6/FWivipIr+E0nIGgy0MMby9nkNO+Jn
         0aJNuSO5zg3GuJodOaC0PpLm9ZvpsjR5waMWtPTydTn5b8teWS2HMMazQhXcMPdEAIbM
         rPcujNRHKq5fLArt7vH/HRRYlBO+M3SqbEBc1se50v6BVmy7F4DyBKMn1cP9vjuoMnTq
         5kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0HqL97JwBrjBXTVTitohvXvgoY0lt+wZC5NHuty9hs=;
        b=RjR/nq0CtonL1/KIrIi14LSDLDcmGHx6OhOLMdxEMvfs0A4x49Fx2kINEILNEx5Yk2
         x9+krOH/lSnuI+Jj2f96N3FFzhhDeeMU2qbQEIbeciJH6nvvhektz6L9nUXqdpJiJXJU
         StsbUlfDADkE33D1YRmIl5UoaA1y5cRlKrzEDgy4DMsl+Bsf+eJKLaJ92NGoW8rppAK7
         rB0OKB3XOikwzAqGToFoIDFaOWsY3QsnDrGJ3cahnxCGbgnEAIkJ+Y+E0T7frqr0EnW+
         vMJa9dIflvYdZDyucpf3RRmpQeyGITpCeMrh9UsClhLUknj4UbBI7n9bJKkFdbnauC+C
         eyqw==
X-Gm-Message-State: AO0yUKWr+yUyN6mxa5JbSnz6st0zfZmAbQmsnTSKNwjHfNZTHNoipQEv
        m6PBg9JNca6sUTOukpnvN+C8OfkTo0zG
X-Google-Smtp-Source: AK7set+sTpw/Mpdd613/Euhkdxc/bF7dUv+Wu8UjWoay1R8WXhYp3L5dRr06+SA/iTlYnzS3X5WLEMdWGBw9
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a17:907:2154:b0:88e:16e2:3b7f with SMTP id
 rk20-20020a170907215400b0088e16e23b7fmr275893ejb.300.1675247885947; Wed, 01
 Feb 2023 02:38:05 -0800 (PST)
Date:   Wed,  1 Feb 2023 10:37:52 +0000
In-Reply-To: <20230201103755.1398086-1-qperret@google.com>
Mime-Version: 1.0
References: <20230201103755.1398086-1-qperret@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230201103755.1398086-3-qperret@google.com>
Subject: [PATCH 2/4] KVM: arm64: Introduce finalise_el2_state macro
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the first half of the finalise_el2 function into a macro to
allow its reuse from the nVHE PSCI relay code. While at it, make the
register allocation parametric for the check_override macros as they are
now more widely exposed.

No functional changes intended.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/el2_setup.h | 78 +++++++++++++++++++++++++++++
 arch/arm64/kernel/hyp-stub.S       | 79 +-----------------------------
 2 files changed, 80 insertions(+), 77 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 668569adf4d3..fb7d04b81033 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -196,4 +196,82 @@
 	__init_el2_nvhe_prepare_eret
 .endm
 
+// This will clobber tmp1 and tmp2, and expect tmp1 to contain
+// the id register value as read from the HW
+.macro __check_override idreg, fld, width, pass, fail, tmp1, tmp2
+	ubfx	\tmp1, \tmp1, #\fld, #\width
+	cbz	\tmp1, \fail
+
+	adr_l	\tmp1, \idreg\()_override
+	ldr	\tmp2, [\tmp1, FTR_OVR_VAL_OFFSET]
+	ldr	\tmp1, [\tmp1, FTR_OVR_MASK_OFFSET]
+	ubfx	\tmp2, \tmp2, #\fld, #\width
+	ubfx	\tmp1, \tmp1, #\fld, #\width
+	cmp	\tmp1, xzr
+	and	\tmp2, \tmp2, \tmp1
+	csinv	\tmp2, \tmp2, xzr, ne
+	cbnz	\tmp2, \pass
+	b	\fail
+.endm
+
+// This will clobber tmp1 and tmp2
+.macro check_override idreg, fld, pass, fail, tmp1, tmp2
+	mrs	\tmp1, \idreg\()_el1
+	__check_override \idreg \fld 4 \pass \fail \tmp1 \tmp2
+.endm
+
+.macro finalise_el2_state
+	check_override id_aa64pfr0, ID_AA64PFR0_EL1_SVE_SHIFT, .Linit_sve_\@, .Lskip_sve_\@, x1, x2
+
+.Linit_sve_\@:	/* SVE register access */
+	mrs	x0, cptr_el2			// Disable SVE traps
+	bic	x0, x0, #CPTR_EL2_TZ
+	msr	cptr_el2, x0
+	isb
+	mov	x1, #ZCR_ELx_LEN_MASK		// SVE: Enable full vector
+	msr_s	SYS_ZCR_EL2, x1			// length for EL1.
+
+.Lskip_sve_\@:
+	check_override id_aa64pfr1, ID_AA64PFR1_EL1_SME_SHIFT, .Linit_sme_\@, .Lskip_sme_\@, x1, x2
+
+.Linit_sme_\@:	/* SME register access and priority mapping */
+	mrs	x0, cptr_el2			// Disable SME traps
+	bic	x0, x0, #CPTR_EL2_TSM
+	msr	cptr_el2, x0
+	isb
+
+	mrs	x1, sctlr_el2
+	orr	x1, x1, #SCTLR_ELx_ENTP2	// Disable TPIDR2 traps
+	msr	sctlr_el2, x1
+	isb
+
+	mov	x0, #0				// SMCR controls
+
+	// Full FP in SM?
+	mrs_s	x1, SYS_ID_AA64SMFR0_EL1
+	__check_override id_aa64smfr0, ID_AA64SMFR0_EL1_FA64_SHIFT, 1, .Linit_sme_fa64_\@, .Lskip_sme_fa64_\@, x1, x2
+
+.Linit_sme_fa64_\@:
+	orr	x0, x0, SMCR_ELx_FA64_MASK
+.Lskip_sme_fa64_\@:
+
+	orr	x0, x0, #SMCR_ELx_LEN_MASK	// Enable full SME vector
+	msr_s	SYS_SMCR_EL2, x0		// length for EL1.
+
+	mrs_s	x1, SYS_SMIDR_EL1		// Priority mapping supported?
+	ubfx    x1, x1, #SMIDR_EL1_SMPS_SHIFT, #1
+	cbz     x1, .Lskip_sme_\@
+
+	msr_s	SYS_SMPRIMAP_EL2, xzr		// Make all priorities equal
+
+	mrs	x1, id_aa64mmfr1_el1		// HCRX_EL2 present?
+	ubfx	x1, x1, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
+	cbz	x1, .Lskip_sme_\@
+
+	mrs_s	x1, SYS_HCRX_EL2
+	orr	x1, x1, #HCRX_EL2_SMPME_MASK	// Enable priority mapping
+	msr_s	SYS_HCRX_EL2, x1
+.Lskip_sme_\@:
+.endm
+
 #endif /* __ARM_KVM_INIT_H__ */
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 2ee18c860f2a..9439240c3fcf 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -16,30 +16,6 @@
 #include <asm/ptrace.h>
 #include <asm/virt.h>
 
-// Warning, hardcoded register allocation
-// This will clobber x1 and x2, and expect x1 to contain
-// the id register value as read from the HW
-.macro __check_override idreg, fld, width, pass, fail
-	ubfx	x1, x1, #\fld, #\width
-	cbz	x1, \fail
-
-	adr_l	x1, \idreg\()_override
-	ldr	x2, [x1, FTR_OVR_VAL_OFFSET]
-	ldr	x1, [x1, FTR_OVR_MASK_OFFSET]
-	ubfx	x2, x2, #\fld, #\width
-	ubfx	x1, x1, #\fld, #\width
-	cmp	x1, xzr
-	and	x2, x2, x1
-	csinv	x2, x2, xzr, ne
-	cbnz	x2, \pass
-	b	\fail
-.endm
-
-.macro check_override idreg, fld, pass, fail
-	mrs	x1, \idreg\()_el1
-	__check_override \idreg \fld 4 \pass \fail
-.endm
-
 	.text
 	.pushsection	.hyp.text, "ax"
 
@@ -98,58 +74,7 @@ SYM_CODE_START_LOCAL(elx_sync)
 SYM_CODE_END(elx_sync)
 
 SYM_CODE_START_LOCAL(__finalise_el2)
-	check_override id_aa64pfr0 ID_AA64PFR0_EL1_SVE_SHIFT .Linit_sve .Lskip_sve
-
-.Linit_sve:	/* SVE register access */
-	mrs	x0, cptr_el2			// Disable SVE traps
-	bic	x0, x0, #CPTR_EL2_TZ
-	msr	cptr_el2, x0
-	isb
-	mov	x1, #ZCR_ELx_LEN_MASK		// SVE: Enable full vector
-	msr_s	SYS_ZCR_EL2, x1			// length for EL1.
-
-.Lskip_sve:
-	check_override id_aa64pfr1 ID_AA64PFR1_EL1_SME_SHIFT .Linit_sme .Lskip_sme
-
-.Linit_sme:	/* SME register access and priority mapping */
-	mrs	x0, cptr_el2			// Disable SME traps
-	bic	x0, x0, #CPTR_EL2_TSM
-	msr	cptr_el2, x0
-	isb
-
-	mrs	x1, sctlr_el2
-	orr	x1, x1, #SCTLR_ELx_ENTP2	// Disable TPIDR2 traps
-	msr	sctlr_el2, x1
-	isb
-
-	mov	x0, #0				// SMCR controls
-
-	// Full FP in SM?
-	mrs_s	x1, SYS_ID_AA64SMFR0_EL1
-	__check_override id_aa64smfr0 ID_AA64SMFR0_EL1_FA64_SHIFT 1 .Linit_sme_fa64 .Lskip_sme_fa64
-
-.Linit_sme_fa64:
-	orr	x0, x0, SMCR_ELx_FA64_MASK
-.Lskip_sme_fa64:
-
-	orr	x0, x0, #SMCR_ELx_LEN_MASK	// Enable full SME vector
-	msr_s	SYS_SMCR_EL2, x0		// length for EL1.
-
-	mrs_s	x1, SYS_SMIDR_EL1		// Priority mapping supported?
-	ubfx    x1, x1, #SMIDR_EL1_SMPS_SHIFT, #1
-	cbz     x1, .Lskip_sme
-
-	msr_s	SYS_SMPRIMAP_EL2, xzr		// Make all priorities equal
-
-	mrs	x1, id_aa64mmfr1_el1		// HCRX_EL2 present?
-	ubfx	x1, x1, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
-	cbz	x1, .Lskip_sme
-
-	mrs_s	x1, SYS_HCRX_EL2
-	orr	x1, x1, #HCRX_EL2_SMPME_MASK	// Enable priority mapping
-	msr_s	SYS_HCRX_EL2, x1
-
-.Lskip_sme:
+	finalise_el2_state
 
 	// nVHE? No way! Give me the real thing!
 	// Sanity check: MMU *must* be off
@@ -157,7 +82,7 @@ SYM_CODE_START_LOCAL(__finalise_el2)
 	tbnz	x1, #0, 1f
 
 	// Needs to be VHE capable, obviously
-	check_override id_aa64mmfr1 ID_AA64MMFR1_EL1_VH_SHIFT 2f 1f
+	check_override id_aa64mmfr1 ID_AA64MMFR1_EL1_VH_SHIFT 2f 1f x1 x2
 
 1:	mov_q	x0, HVC_STUB_ERR
 	eret
-- 
2.39.1.456.gfc5497dd1b-goog

