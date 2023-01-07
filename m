Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DD6660D5A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbjAGJr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbjAGJrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:47:12 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD00A8060D
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 01:47:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v23so3881010pju.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 01:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrHvMB16lAcrTCRgHPeXQ+m99p1hKRk4z+mzwMZ3/vQ=;
        b=XIR4iKAGY5tizFikPrCbS3m01UvFm1MG/NpL2cA/3LBGXtr/aI1d8C5NVAd/xF1+VQ
         5JoQ/wB1dNT/qH8pnwi0ZtDwUbbdbpgemB5XDgepm++5Txb/Uqws6j70U7djjUDHGEvo
         gZXLG+Uk2JUQ/4rohKbG2rFh4HRaiLCAAcQ9i5olH31hO7SzAJDyOs1Usojcbxqq1nWI
         X23PwIX5hfVSp94lZxS9MoDKykWhz8M/i1iN/+YF7iWNCAdVydQoOI4EAOfd8P0S0sIS
         chYOElEP0EmIeUf/nG1GMHWU4ggzy+shP9+3gsf09Qi5wQsl7CSj8mub1vrombmlL4on
         rN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrHvMB16lAcrTCRgHPeXQ+m99p1hKRk4z+mzwMZ3/vQ=;
        b=WTr9EJqgcgbE5qgOMWSrUWicJT/mwxxHsjxhlf9lLUKfndGqJFy1jjkwL4CwsVb0HJ
         L7rDxVvJgb8DYob4fy0tguTFrfanThW4AgmyHCMxzo/Sc8Xe+yC+0n5W5SNXS6XNWrYp
         G9ltzpFz3DcmiKk9sjvB4OOOb+7WZmLNh9xwTOmr52zaFCHhWYyE+6KuvWHX1Gb4NLei
         zeX+NxuJUePvpORJ/0KEBgg+AnCosB2GyerTiXODOCgyCOwJFnelpbwBlejwUCLFa2tJ
         O1Dv/wZWa6yN6Omtd35dc+5HRuRROva5Zv2TE0ROz4Nr++rswDq/9uqOSLYRqvJWehYz
         QyRA==
X-Gm-Message-State: AFqh2krrfjcp63HLZYYin/RlNwrICvWhZX72wylJ3WzBBqcwaf5dDsJz
        pdZzR4wOnDyGaCJwJf4qYpqRtA==
X-Google-Smtp-Source: AMrXdXvSgLOZX5XyO03JF/K1p6Sj9gHpq7HzVmF626nTVj4T5INy7DN6cR/GnQ6UVqxTHUTpuELAkg==
X-Received: by 2002:a17:902:7c90:b0:18f:6b2b:e88d with SMTP id y16-20020a1709027c9000b0018f6b2be88dmr58697261pll.36.1673084820291;
        Sat, 07 Jan 2023 01:47:00 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b00183c6784704sm2263449plc.291.2023.01.07.01.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 01:46:59 -0800 (PST)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Reiji Watanabe <reijiw@google.com>
Subject: [PATCH v6 5/7] KVM: arm64: Always set HCR_TID2
Date:   Sat,  7 Jan 2023 18:46:27 +0900
Message-Id: <20230107094629.181236-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230107094629.181236-1-akihiko.odaki@daynix.com>
References: <20230107094629.181236-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always set HCR_TID2 to trap CTR_EL0, CCSIDR2_EL1, CLIDR_EL1, and
CSSELR_EL1. This saves a few lines of code and allows to employ their
access trap handlers for more purposes anticipated by the old
condition for setting HCR_TID2.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Reiji Watanabe <reijiw@google.com>
---
 arch/arm64/include/asm/kvm_arm.h           | 3 ++-
 arch/arm64/include/asm/kvm_emulate.h       | 4 ----
 arch/arm64/include/asm/kvm_host.h          | 2 --
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 2 --
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 0df3fc3a0173..158f2033fde9 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -81,11 +81,12 @@
  * SWIO:	Turn set/way invalidates into set/way clean+invalidate
  * PTW:		Take a stage2 fault if a stage1 walk steps in device memory
  * TID3:	Trap EL1 reads of group 3 ID registers
+ * TID2:	Trap CTR_EL0, CCSIDR2_EL1, CLIDR_EL1, and CSSELR_EL1
  */
 #define HCR_GUEST_FLAGS (HCR_TSC | HCR_TSW | HCR_TWE | HCR_TWI | HCR_VM | \
 			 HCR_BSU_IS | HCR_FB | HCR_TACR | \
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
-			 HCR_FMO | HCR_IMO | HCR_PTW | HCR_TID3 )
+			 HCR_FMO | HCR_IMO | HCR_PTW | HCR_TID3 | HCR_TID2)
 #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
 #define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
 #define HCR_HOST_NVHE_PROTECTED_FLAGS (HCR_HOST_NVHE_FLAGS | HCR_TSC)
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 9bdba47f7e14..30c4598d643b 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -88,10 +88,6 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 	if (vcpu_el1_is_32bit(vcpu))
 		vcpu->arch.hcr_el2 &= ~HCR_RW;
 
-	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
-	    vcpu_el1_is_32bit(vcpu))
-		vcpu->arch.hcr_el2 |= HCR_TID2;
-
 	if (kvm_has_mte(vcpu->kvm))
 		vcpu->arch.hcr_el2 |= HCR_ATA;
 }
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 35a159d131b5..374390a9212e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -705,7 +705,6 @@ static inline bool __vcpu_read_sys_reg_from_cpu(int reg, u64 *val)
 		return false;
 
 	switch (reg) {
-	case CSSELR_EL1:	*val = read_sysreg_s(SYS_CSSELR_EL1);	break;
 	case SCTLR_EL1:		*val = read_sysreg_s(SYS_SCTLR_EL12);	break;
 	case CPACR_EL1:		*val = read_sysreg_s(SYS_CPACR_EL12);	break;
 	case TTBR0_EL1:		*val = read_sysreg_s(SYS_TTBR0_EL12);	break;
@@ -750,7 +749,6 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
 		return false;
 
 	switch (reg) {
-	case CSSELR_EL1:	write_sysreg_s(val, SYS_CSSELR_EL1);	break;
 	case SCTLR_EL1:		write_sysreg_s(val, SYS_SCTLR_EL12);	break;
 	case CPACR_EL1:		write_sysreg_s(val, SYS_CPACR_EL12);	break;
 	case TTBR0_EL1:		write_sysreg_s(val, SYS_TTBR0_EL12);	break;
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index baa5b9b3dde5..147cb4c846c6 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -39,7 +39,6 @@ static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
 
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 {
-	ctxt_sys_reg(ctxt, CSSELR_EL1)	= read_sysreg(csselr_el1);
 	ctxt_sys_reg(ctxt, SCTLR_EL1)	= read_sysreg_el1(SYS_SCTLR);
 	ctxt_sys_reg(ctxt, CPACR_EL1)	= read_sysreg_el1(SYS_CPACR);
 	ctxt_sys_reg(ctxt, TTBR0_EL1)	= read_sysreg_el1(SYS_TTBR0);
@@ -95,7 +94,6 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, MPIDR_EL1),	vmpidr_el2);
-	write_sysreg(ctxt_sys_reg(ctxt, CSSELR_EL1),	csselr_el1);
 
 	if (has_vhe() ||
 	    !cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
-- 
2.38.1

