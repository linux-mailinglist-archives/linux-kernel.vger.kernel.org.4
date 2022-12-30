Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4F65970A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiL3Jz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiL3JzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:55:21 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1871A818
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:55:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so20141258pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TArwYxCFrSBrMRpJqgmbgk8qp38LFtviL46odPa8HP0=;
        b=V2PPlMtIYzvmjTJcM3MvXUYStMJqQopldJARZAwRv+FVYRzKxm8EdA+RLIqYUME/Hm
         KaLh1Hru7NsccKthnioIq8xgC8HtSTaiYaLEchA1erIpB4E4X6kKPYwGeysBXNGNUgTJ
         PAsx5OLLBNNwZcX4sPd0A8ExO/quD4GN+oC9qkWRszdG7UjrUcyobgeQ81TgAwNonXEj
         HiOXauWJkUMAI9tqsTCCKyyr3L6nW3kE/ENC0TVF9GeqnrK6zhnpuAIJ7Ihg/3pH5tHU
         yFUicSZAxYWNp1OtEPhMsQG3yijRRKISF2DaK/k5PpB3Gi7kJu3OkTzVHggsE+cX/AVl
         Vyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TArwYxCFrSBrMRpJqgmbgk8qp38LFtviL46odPa8HP0=;
        b=7bG16bjDBMhfUOyFhvjOph1slHwNhBXMiK7qfPt3Xib0LZUn82Tve6HnrDfAzd6Xa/
         iaEmefO3gyXZ15B9fkw0wfNsY75wIh1e2oEGaYDK4hzO90/MdvpmbEkgxm6tH0IyArzA
         onscgQqDD15cenbPyzyvW6xesJgYC9Gi6O/KVS/6EeVR4CMJ2V4VKza+/iof6NKHehUK
         6Z2dfGn7Fd4EvHTB9lYOgnDoExwmqhp9jSN3wQ3VR5eZJq5deG8boigN9uYGS58PEoQ8
         4NqjKu+dmJESVudGCFDdrfGLnBEtyF8t0WQK3WLwgrVcZRk+ipczjyZNft5JUKG6MLwJ
         DTwg==
X-Gm-Message-State: AFqh2kqsboPBHrLeeEF7j6YvjYkA2mz6vzSJWKejCPXw8n7Kmme5n9T/
        R4srKXbJx722lGBccKDwcLI/Lw==
X-Google-Smtp-Source: AMrXdXspaJ3vzRPB7+tbTBg5dQm4cj1J+UupdkoXbHJZ8PRRvxXXsuCCZcu+swH+OAPkleWIX3ymKQ==
X-Received: by 2002:a17:902:b207:b0:189:e3d0:daf8 with SMTP id t7-20020a170902b20700b00189e3d0daf8mr30780379plr.55.1672394120198;
        Fri, 30 Dec 2022 01:55:20 -0800 (PST)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b00189c536c72asm14487719plk.148.2022.12.30.01.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 01:55:19 -0800 (PST)
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
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 5/7] KVM: arm64: Always set HCR_TID2
Date:   Fri, 30 Dec 2022 18:54:50 +0900
Message-Id: <20221230095452.181764-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230095452.181764-1-akihiko.odaki@daynix.com>
References: <20221230095452.181764-1-akihiko.odaki@daynix.com>
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
---
 arch/arm64/include/asm/kvm_arm.h           | 3 ++-
 arch/arm64/include/asm/kvm_emulate.h       | 4 ----
 arch/arm64/include/asm/kvm_host.h          | 2 --
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 2 --
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 8aa8492dafc0..44be46c280c1 100644
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
index 45e2136322ba..cc2ede0eaed4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -621,7 +621,6 @@ static inline bool __vcpu_read_sys_reg_from_cpu(int reg, u64 *val)
 		return false;
 
 	switch (reg) {
-	case CSSELR_EL1:	*val = read_sysreg_s(SYS_CSSELR_EL1);	break;
 	case SCTLR_EL1:		*val = read_sysreg_s(SYS_SCTLR_EL12);	break;
 	case CPACR_EL1:		*val = read_sysreg_s(SYS_CPACR_EL12);	break;
 	case TTBR0_EL1:		*val = read_sysreg_s(SYS_TTBR0_EL12);	break;
@@ -666,7 +665,6 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
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

