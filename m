Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9133C72FE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbjFNM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244597AbjFNM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:26:12 -0400
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8F1FCC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:26:10 -0700 (PDT)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2b168e97cdfso5428541fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686745569; x=1689337569;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCzCiWoRELswxyKR3MRcDLOgrFXaFbCkfTHkOK7uwD0=;
        b=gllsBxNq6gokE1zbrq87NmmsaIIb3mTAtMg7dO3GDuDj14v7zFtVy4Lcq4BZLStnZh
         hoP5wHluCVhHdkY/oo+tU6vjDyKxLcLLjj9jNXCDdXeq9/ISRg5MBtFyVdjjnNkdUPzL
         oCCHGVo1oanf2kaO2CroU/lWg9/MIshWsJTbsrw82EgF12g+6vvkCqfMAl5CqkIVlUIK
         VjL4P+LgD8QRi5l3dqlQFdTq0IK+pCCvORdRHncrJ4ssTn+VqLNrmRC5Cy0q/iZ3cgTv
         rrkAOGHzScUdeeZxDhGcxERAPcY4ZVU7KOQKXCUOo3roAVnOPGDn1Sjf7Z9mAM7FkOu4
         qgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686745569; x=1689337569;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCzCiWoRELswxyKR3MRcDLOgrFXaFbCkfTHkOK7uwD0=;
        b=b0nejK49ZlL3A8nDcCsj6VQD9Vs4D1dArl4mo/6oz+S1TbYc//l9ynAdVsSRaSYc1J
         Aq7mL7mp/3e7Z4DuTRA5A6zNJRNc683uN7YlYQGVfx/DNcjXT5fyJQkR4cNUhwFTG7g9
         ADBTXUgFEqEE7H43FEmcX28gkHDnaGm0+OcCwQkfDnD1URnNsWHZiR+ehX7HNG61sTWL
         2/yQsKJ9qqixUzgp5KV9id1Tb4mQwc2kA/H8aLb+dIHQK/NNTgOFbCcuPs/DHmnRlm9f
         fS5ERKx2dtj9PaC2JsmScTcd8DVqBXf40Gj/5ClYMGmI9bIRcF7xXhkqKZ8a27Js7soQ
         73Aw==
X-Gm-Message-State: AC+VfDwsMcFA6kR+KvOMfTfyQVCrkV/DNpl+i5BiJEgcqWOARnb2Z/K7
        SXxtARhMjZBFsB23uxG3qvvAZPWqszWOIg==
X-Google-Smtp-Source: ACHHUZ4uuMjHNfCmftPMbMtzKVaT5lwd5w6tsM1f8YtmMu9PT5/eEj8tScBG8lmCSia5m2Ir13MR585drZdnKw==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a2e:7310:0:b0:2ad:7f86:44e2 with SMTP id
 o16-20020a2e7310000000b002ad7f8644e2mr3059289ljc.9.1686745568914; Wed, 14 Jun
 2023 05:26:08 -0700 (PDT)
Date:   Wed, 14 Jun 2023 12:25:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614122600.2098901-1-smostafa@google.com>
Subject: [PATCH v2] KVM: arm64: Use different pointer authentication keys for pKVM
From:   Mostafa Saleh <smostafa@google.com>
To:     maz@kernel.org, oliver.upton@linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     tabba@google.com, kaleshsingh@google.com, will@kernel.org,
        catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com,
        Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the use of pointer authentication is enabled in the kernel it
applies to both the kernel itself as well as KVM's nVHE hypervisor. The
same keys are used for both the kernel and the nVHE hypervisor, which is
less than desirable for pKVM as the host is not trusted at runtime.

Naturally, the fix is to use a different set of keys for the hypervisor
when running in protected mode. Have the host generate a new set of keys
for the hypervisor before deprivileging the kernel. While there might be
other sources of random directly available at EL2, this keeps the
implementation simple, and the host is trusted anyways until it is
deprivileged.

Since the host and hypervisor no longer share a set of pointer
authentication keys, start context switching them on the host entry/exit
path exactly as we do for guest entry/exit. There is no need to handle
CPU migration as the nVHE code is not migratable in the first place.

Signed-off-by: Mostafa Saleh <smostafa@google.com>

---
v2:
- Add missing isb after updating hyp keys.
- Reword commit message from Oliver.
---
 arch/arm64/kvm/arm.c           | 26 ++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/host.S | 36 +++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 14391826241c..dd03b52f035d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -51,6 +51,8 @@ DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
+DECLARE_KVM_NVHE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
+
 static bool vgic_present;
 
 static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
@@ -2067,6 +2069,26 @@ static int __init kvm_hyp_init_protection(u32 hyp_va_bits)
 	return 0;
 }
 
+static void pkvm_hyp_init_ptrauth(void)
+{
+	struct kvm_cpu_context *hyp_ctxt;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		hyp_ctxt = per_cpu_ptr_nvhe_sym(kvm_hyp_ctxt, cpu);
+		hyp_ctxt->sys_regs[APIAKEYLO_EL1] = get_random_long();
+		hyp_ctxt->sys_regs[APIAKEYHI_EL1] = get_random_long();
+		hyp_ctxt->sys_regs[APIBKEYLO_EL1] = get_random_long();
+		hyp_ctxt->sys_regs[APIBKEYHI_EL1] = get_random_long();
+		hyp_ctxt->sys_regs[APDAKEYLO_EL1] = get_random_long();
+		hyp_ctxt->sys_regs[APDAKEYHI_EL1] = get_random_long();
+		hyp_ctxt->sys_regs[APDBKEYLO_EL1] = get_random_long();
+		hyp_ctxt->sys_regs[APDBKEYHI_EL1] = get_random_long();
+		hyp_ctxt->sys_regs[APGAKEYLO_EL1] = get_random_long();
+		hyp_ctxt->sys_regs[APGAKEYHI_EL1] = get_random_long();
+	}
+}
+
 /* Inits Hyp-mode on all online CPUs */
 static int __init init_hyp_mode(void)
 {
@@ -2228,6 +2250,10 @@ static int __init init_hyp_mode(void)
 	kvm_hyp_init_symbols();
 
 	if (is_protected_kvm_enabled()) {
+		if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL) &&
+		    cpus_have_const_cap(ARM64_HAS_ADDRESS_AUTH))
+			pkvm_hyp_init_ptrauth();
+
 		init_cpu_logical_map();
 
 		if (!init_psci_relay()) {
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index b6c0188c4b35..c87c63133e10 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -10,6 +10,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_ptrauth.h>
 
 	.text
 
@@ -37,10 +38,43 @@ SYM_FUNC_START(__host_exit)
 
 	/* Save the host context pointer in x29 across the function call */
 	mov	x29, x0
+
+#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
+alternative_if_not ARM64_HAS_ADDRESS_AUTH
+b __skip_pauth_save
+alternative_else_nop_endif
+
+alternative_if ARM64_KVM_PROTECTED_MODE
+	/* Save kernel ptrauth keys. */
+	add x18, x29, #CPU_APIAKEYLO_EL1
+	ptrauth_save_state x18, x19, x20
+
+	/* Use hyp keys. */
+	adr_this_cpu x18, kvm_hyp_ctxt, x19
+	add x18, x18, #CPU_APIAKEYLO_EL1
+	ptrauth_restore_state x18, x19, x20
+	isb
+alternative_else_nop_endif
+__skip_pauth_save:
+#endif /* CONFIG_ARM64_PTR_AUTH_KERNEL */
+
 	bl	handle_trap
 
-	/* Restore host regs x0-x17 */
 __host_enter_restore_full:
+	/* Restore kernel keys. */
+#ifdef CONFIG_ARM64_PTR_AUTH_KERNEL
+alternative_if_not ARM64_HAS_ADDRESS_AUTH
+b __skip_pauth_restore
+alternative_else_nop_endif
+
+alternative_if ARM64_KVM_PROTECTED_MODE
+	add x18, x29, #CPU_APIAKEYLO_EL1
+	ptrauth_restore_state x18, x19, x20
+alternative_else_nop_endif
+__skip_pauth_restore:
+#endif /* CONFIG_ARM64_PTR_AUTH_KERNEL */
+
+	/* Restore host regs x0-x17 */
 	ldp	x0, x1,   [x29, #CPU_XREG_OFFSET(0)]
 	ldp	x2, x3,   [x29, #CPU_XREG_OFFSET(2)]
 	ldp	x4, x5,   [x29, #CPU_XREG_OFFSET(4)]
-- 
2.41.0.162.gfafddb0af9-goog

