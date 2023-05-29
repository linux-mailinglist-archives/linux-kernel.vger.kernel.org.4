Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A211A714225
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 04:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjE2Cs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 22:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjE2Cs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 22:48:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4714AD
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 19:48:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d3491609fso2061960b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 19:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685328535; x=1687920535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G4Nb/gFMm8Ye9wyALRV/xgn92872VRuD4vbstmC2QEw=;
        b=NOjWamSYnCLQvYfKu8DJq+B0/i3lMIg0lSMnghs2kA7eYtwehwitTw8cfLbYhKd0ju
         foqc4dLoVmDgrUN4Ezs5H6a7UBsIJyFrXiEacDO5HjrImstFrJvGqwuZrTatKkTAarSE
         O+Y2NpFKFMia/vtb7J1ZW03ErSdff5CWJI7/jkRzHLzbcdT4JCqNigWlprjEou16haR6
         Pl0P+rk2jW8g8oJx7qBpc4A1n3D6xsfQX5BwzPvKJO3WcrhXerEgnyX6/Pa/4w0Vm83i
         6CFPiuIuLuF8HOg6QCCOk/haz6HHhzZn4V+eoWVH1z27pqmnnEBa/0ximUKIKtaAC/IJ
         jFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685328535; x=1687920535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4Nb/gFMm8Ye9wyALRV/xgn92872VRuD4vbstmC2QEw=;
        b=SD28CuTyE2OcDDVfVCaRwbolrc0aV/OgkV3VSaCs9ZPNFFwuapb4pj4XRJre1ygFhL
         jlu9qSQWTalz5f9IWqBSHLWS6qd8ZxrSwh0pcABTHvnFULeJOiRXdyX0yCD+i+Ja4bpC
         De6suDG1koGONlA0wDuQTdyv4up+rKSnJFOcHz2fat/8nakFM44Mi0cV2o/JMN7ctt3M
         nP+Ekmuruq/Y+3y/Kc5h8Rd+VO2Hb/c6kHtLfHWY269YeDx9KGtnOiIMpfyDG+Yx78si
         H9BM0OV5GVwxU6oi7/NJRv5ddhQ007EWjOWXAnmv+1R4NqZoK2YcqG+CQUjpEIPgaNas
         Q95Q==
X-Gm-Message-State: AC+VfDxNhxe+mDJrLSDH4d13fxyvPoMbYSPNDrkurY0iCCPuwuml8Bjg
        vGpcREAl4/lpVgX2wnoDUsCbsg==
X-Google-Smtp-Source: ACHHUZ4mx6kzGcSLWLye7VJKM8QzXipRR+WZ0JOezVy9o+7MbOB0M4Cmb/lafTqjjm77gYCEBD9Uxw==
X-Received: by 2002:a05:6a00:1486:b0:647:b6c9:179d with SMTP id v6-20020a056a00148600b00647b6c9179dmr15084106pfu.21.1685328535460;
        Sun, 28 May 2023 19:48:55 -0700 (PDT)
Received: from fedora.. ([157.82.203.71])
        by smtp.gmail.com with ESMTPSA id c8-20020aa78c08000000b0063d2d9990ecsm5791039pfd.87.2023.05.28.19.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 19:48:55 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] KVM: arm64: Populate fault info for watchpoint
Date:   Mon, 29 May 2023 11:48:47 +0900
Message-Id: <20230529024847.8671-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling ESR_ELx_EC_WATCHPT_LOW, far_el2 member of struct
kvm_vcpu_fault_info will be copied to far member of struct
kvm_debug_exit_arch and exposed to the userspace. The userspace will
see stale values from older faults if the fault info does not get
populated.

Fixes: 8fb2046180a0 ("KVM: arm64: Move early handlers to per-EC handlers")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c        | 6 ++++--
 arch/arm64/kvm/hyp/vhe/switch.c         | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 07d37ff88a3f..2eb0a1481ead 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -351,7 +351,7 @@ static bool kvm_hyp_handle_cp15_32(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return false;
 }
 
-static bool kvm_hyp_handle_iabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
+static bool kvm_hyp_handle_generic_fault(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	if (!__populate_fault_info(vcpu))
 		return true;
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index c2cb46ca4fb6..1b77866079dc 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -184,8 +184,9 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg,
 	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
-	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
+	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_generic_fault,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
+	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_generic_fault,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
 };
 
@@ -194,8 +195,9 @@ static const exit_handler_fn pvm_exit_handlers[] = {
 	[ESR_ELx_EC_SYS64]		= kvm_handle_pvm_sys64,
 	[ESR_ELx_EC_SVE]		= kvm_handle_pvm_restricted,
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
-	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
+	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_generic_fault,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
+	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_generic_fault,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
 };
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 1a97391fedd2..08ae0ee4697b 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -108,8 +108,9 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_SYS64]		= kvm_hyp_handle_sysreg,
 	[ESR_ELx_EC_SVE]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
-	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
+	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_generic_fault,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
+	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_generic_fault,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
 };
 
-- 
2.40.1

