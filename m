Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35926705054
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjEPOQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjEPOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:16:00 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974EFAB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:15:59 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-3f433a2308bso21198075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684246558; x=1686838558;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B8N8PO1EikxzfdoHKZo5krI5/XOld4YdAWQeBGx5Jjk=;
        b=Wjo2awxanNESfU3T9n6puAeXqkMRNhZcXHTT6lsKWKqEZypv39qXzz0uLJr+HAgoZp
         SQelJrcAgx6xycEt86ZmfxjKaKldVb0NQ93xNCBM0qL8DubtX2CQCtpV+s+3Gl+z8ZKY
         +0E5yRWGqGmX7eQrA2HNLEumgmK5wYPh0BP26DqviRYDH7j9MyaQJbx1FUsBQLRXKdDn
         V2Nj1RjtPTCKkD3YK3sUFNcVQcKEdhbwUwo2pwyPaP/pYHq0LZnWwVOMaHyLebHA87J8
         lY0VjsC4Nd/4qDmL9l4g6cAh74FJkapsw+G3vHztTDBPun+NpxlWiHqEBuxmlxmaN1gO
         asYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684246558; x=1686838558;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8N8PO1EikxzfdoHKZo5krI5/XOld4YdAWQeBGx5Jjk=;
        b=cCG7wb7mSmD9JDntoBMUQSZ9avKGRdYd0tSGIg6BrEs700UQBo0Xpjv4nuHYY/YK1E
         FUuF+JpXK3GVmtcPA8Y+Yl4ipx89WNVyVwH06xd6EKMDvw6EO9Bj13OcTGx/rrCb7kQa
         tG9MgZz4N8xPn88vlklXvRz5mnConbS00XBFu5hEgtv/fJAEXgcZ8M33/0n5f9egBAxd
         Xb0AWQ/Yb+SKvVY3eaLdqXpePO9TzvnXRz6Mdzo5+K7VkmDiCGumOQqTNlh1Z8gJ7x8v
         fnW0gedsO8erQtWM8ehaqIz6GTOOQdBIUPXS+zbbkW5S2DpuGA1RnCuVD224U6KOE0VK
         oQzw==
X-Gm-Message-State: AC+VfDxFQuKqZjTp0YanoHcBLijSMtzef4nCCuSkGkRPUZh+Yo7EQ8jt
        KRKQzIaks83JbvOL+yb9o134rnyTcHsMWA==
X-Google-Smtp-Source: ACHHUZ4a8q5ljWXSfSaXs6ygqngOKLgwefkY5eVCtNF1uxBI+dX0LpgsHH1oWB+dpxEG2zYT08nY+GLkIYjHoA==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6000:1b01:b0:306:880c:c7f5 with SMTP
 id f1-20020a0560001b0100b00306880cc7f5mr6493164wrz.7.1684246558004; Tue, 16
 May 2023 07:15:58 -0700 (PDT)
Date:   Tue, 16 May 2023 14:15:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516141531.791492-1-smostafa@google.com>
Subject: [PATCH] KVM: arm64: Use different pointer authentication keys for pKVM
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

When the kernel is compiled with CONFIG_ARM64_PTR_AUTH_KERNEL, it
uses Armv8.3-Pauth for return address protection for the kernel code
including nvhe code in EL2.

Same keys are used in both kernel(EL1) and nvhe code(EL2), this is
fine for nvhe but not when running in protected mode(pKVM) as the host
can't be trusted.

The keys for the hypervisor are generated from the kernel before it
de-privileges, each cpu has different keys, this relies on nvhe code
not being migratable while running.

This patch adds host/hyp save/restore for the keys.
For guest/hyp, they are already handled in common kvm code in
__guest_enter, where they are saved/restored if they are not
trapped.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/arm.c           | 26 +++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/host.S | 35 +++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

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
index b6c0188c4b35..255ba4af911b 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -10,6 +10,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_ptrauth.h>
 
 	.text
 
@@ -37,10 +38,42 @@ SYM_FUNC_START(__host_exit)
 
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
2.40.1.606.ga4b1b128d6-goog

