Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA6715404
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjE3Crt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjE3Crq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:47:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4051E4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:47:14 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b025d26f4fso24628585ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685414834; x=1688006834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=alV8inSLdkpveU+gErF0Hqmj8NeaEg9f/ZBWhD5ez2U=;
        b=VXyb2L0Lk9rF7WpImdHVoDcV+wHY1TpjAjC6TnDsrpgVCNTBuP+09WDoovYSiQjFKp
         EyxL1UVZBQ8nW28vfQL72iihabRnhi/EkD8gk5OONuEfLhM+7gyFIuZ7gyhMgwCU+N4W
         pezZ+Dmt9GIkAGHjmh34aCGDBos3FhMi9ipGNE/4+KA2Jldfys+/6gNvVkHEqP2srBq3
         T0H6/N5WI5tiwwj9Vk+x1MlRC9IL1vjeh4j22arGcxuzaoP267EdprZlv6D2nwJHQrn6
         LLBLFXd1d0JlKwxP+YzIDQSbUuT51wptUFFfemshptbvqcUslGnBI1URWLf7UVKDT83K
         35QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685414834; x=1688006834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alV8inSLdkpveU+gErF0Hqmj8NeaEg9f/ZBWhD5ez2U=;
        b=KjVoIPMXzrkCslNxbNAkLqG4WYvnADDQc1ZQlR0T48bJH1G7hdowFd7HRom+ed9yRR
         igIFus7wZQRiU8GJpK+kOv4lsE35NgP1yAmrOYDo02KpkKfhLPhpRMn/2Xem8s/lZ8oL
         9HUgqHeO/4mKkMk8yOh1r1iSme+MyeikX+mMiL0eE7whanKSMf+iNvorQQq3ZaTMzTbK
         08aAOsGS4MvEcTLcPjIDO6S+H3LRGoQEmQzq2vo5TtyKUvNhf24Cg3qfKzhjzKCPGEYK
         2+Z37H6GzUGtRknwN+FXDmZavuNkEgyJGGlKHf3Sk6Lvwscwoe+wi0P94JmwMtXUpMnh
         /T0A==
X-Gm-Message-State: AC+VfDyRWo3kFjqrX6w+sSFsEsLVZ+A9Jh/qCO9NM7t1LeQNMQ8edwmd
        f2bve3xKCKlZM9fsYe6HB7/mwg==
X-Google-Smtp-Source: ACHHUZ5esirN+GjiMvMiqRhafSMP/4L6Nwl3/8gg9VPgzza/IsiTQ+IctgDBLZQizuhsmpqFTzEGGg==
X-Received: by 2002:a17:902:da82:b0:1b0:5ce9:adbb with SMTP id j2-20020a170902da8200b001b05ce9adbbmr967084plx.45.1685414834012;
        Mon, 29 May 2023 19:47:14 -0700 (PDT)
Received: from fedora.. ([157.82.203.71])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c10200b001aaf370b1c7sm8926329pli.278.2023.05.29.19.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 19:47:13 -0700 (PDT)
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
Subject: [PATCH v2] KVM: arm64: Populate fault info for watchpoint
Date:   Tue, 30 May 2023 11:46:51 +0900
Message-Id: <20230530024651.10014-1-akihiko.odaki@daynix.com>
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
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 8 ++++++--
 arch/arm64/kvm/hyp/nvhe/switch.c        | 2 ++
 arch/arm64/kvm/hyp/vhe/switch.c         | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 07d37ff88a3f..33f4d4200329 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -351,17 +351,21 @@ static bool kvm_hyp_handle_cp15_32(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return false;
 }
 
-static bool kvm_hyp_handle_iabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
+static bool kvm_hyp_handle_memory_fault(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	if (!__populate_fault_info(vcpu))
 		return true;
 
 	return false;
 }
+static bool kvm_hyp_handle_iabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
+	__alias(kvm_hyp_handle_memory_fault);
+static bool kvm_hyp_handle_watchpt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
+	__alias(kvm_hyp_handle_memory_fault);
 
 static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
-	if (!__populate_fault_info(vcpu))
+	if (kvm_hyp_handle_memory_fault(vcpu, exit_code))
 		return true;
 
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap)) {
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index c2cb46ca4fb6..895fb3200076 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -186,6 +186,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
+	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_watchpt_low,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
 };
 
@@ -196,6 +197,7 @@ static const exit_handler_fn pvm_exit_handlers[] = {
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
+	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_watchpt_low,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
 };
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 1a97391fedd2..45ac4a59cc2c 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -110,6 +110,7 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_FP_ASIMD]		= kvm_hyp_handle_fpsimd,
 	[ESR_ELx_EC_IABT_LOW]		= kvm_hyp_handle_iabt_low,
 	[ESR_ELx_EC_DABT_LOW]		= kvm_hyp_handle_dabt_low,
+	[ESR_ELx_EC_WATCHPT_LOW]	= kvm_hyp_handle_watchpt_low,
 	[ESR_ELx_EC_PAC]		= kvm_hyp_handle_ptrauth,
 };
 
-- 
2.40.1

