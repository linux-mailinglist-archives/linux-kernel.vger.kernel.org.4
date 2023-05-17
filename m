Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49CB706F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjEQRgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjEQRgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:36:20 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF930D4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:36:18 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-30641258c9eso435868f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684344976; x=1686936976;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5uJJv3crY452Cbw+h/uO2M9ipntFn8IiofxC6JQaalg=;
        b=oTfhi1BZqEqlbSyRZKsaZbxyoT1XGLw0ndFlgxV1Ih5MfIvb9saj+Q8te1b2ZHQWug
         5AuE7O1jzuWUbCBIcNQX5f4N+yYwOI/x6Ylr69+w7Zq9mDiDpeXrPthRBLmUI2pAcC9f
         PqsrGGBT1WCMauB0c8AGEG5xE/woeUlAdhNBrjkH3E6YGS5JhbiTIc7HTS5rpzimnnEC
         Lqv0tw6nPERm6RqH9V+PpS7OgADjWBbMiyoP2lk+K551bdcDZD1nobGj686zIDv1jjpJ
         co/Kpd6jk9In8B5tXNLaUmMIovihIySZ4ecE0lvpjPDJ3o2EY4ygh2CZDFDIYiw5s2z/
         GriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344976; x=1686936976;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5uJJv3crY452Cbw+h/uO2M9ipntFn8IiofxC6JQaalg=;
        b=RC3+avGEqwGt35Eb4MRDMh4sRN00TeAlZnRs0RvE6orqVtW9G2HcLgK4xmZfRNcHxJ
         ojJEX8bVTUj7RWYu8jOcBOd8qERhJbjYeDF8mzN94mHlvBDSWq+GW3K+sTOW6oGGnJaU
         TWreXELRHwc9eo3I97OT05llrepNsq6bRhsUN39cBW2quI9yVFjCfedmTQNVVezOksiZ
         KSpIP1whJO7Th0tkgMrOJwY37mg/d0jvkyLSBffZM7YOoQs2LVtUcvwUZkC92F99mFdP
         TV9VDx1JPbYJQ/97ZBKTXJIx5YAMmPmlsy3VDcj/PaXyE2iBo6lmhDsQpgXS7k/zZAiN
         pzoQ==
X-Gm-Message-State: AC+VfDxpgPeh6trKr7nxcvNBJIBh0/wUPZnz59UlytrW3Sgu87vp/rnz
        Ox7VSiOTZ4jjhxD/aT3gcyWmKDezbfnI4g==
X-Google-Smtp-Source: ACHHUZ6C/5xTtdIqstRhu/xWULwybxRbU5ExPUfg4iVpV0C5ry5eK1AJFKWXZsdClO5EAEDhW6Hu4Njz/NJ5hQ==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a5d:5272:0:b0:2fe:9a9f:195b with SMTP id
 l18-20020a5d5272000000b002fe9a9f195bmr247714wrc.5.1684344976634; Wed, 17 May
 2023 10:36:16 -0700 (PDT)
Date:   Wed, 17 May 2023 17:35:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230517173552.163711-1-smostafa@google.com>
Subject: [PATCH v2] KVM: arm64: Use BTI for nvhe
From:   Mostafa Saleh <smostafa@google.com>
To:     maz@kernel.org, oliver.upton@linux.dev,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     tabba@google.com, qperret@google.com, will@kernel.org,
        catalin.marinas@arm.com, yuzenghui@huawei.com,
        suzuki.poulose@arm.com, james.morse@arm.com, bgardon@google.com,
        gshan@redhat.com, Mostafa Saleh <smostafa@google.com>
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

CONFIG_ARM64_BTI_KERNEL compiles the kernel to support ARMv8.5-BTI.
However, the nvhe code doesn't make use of it as it doesn't map any
pages with Guarded Page(GP) bit.

This patch maps nvhe(and pKVM recreated mapping of) .text section
with GP bit which matches the kernel handling for BTI.

A new flag is added to enum kvm_pgtable_prot: KVM_PGTABLE_PROT_GP_S1,
which represents BTI guarded page in hypervisor stage-1 page table.

At hyp init, SCTLR_EL2.BT is set to 1 to match EL1 configuration
(SCTLR_EL1.BT1) set in bti_enable().

hyp_init_valid_leaf_pte is added to avoid unnecessary considering GP
bit for stage-2.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
v1 -> v2:
- Enable BTI for nvhe also.
- Only set GP bit for executable pages from pgtable code.
- Set SCTLR_EL2.BT when BTI is used.
- use system_supports_bti() for consistency.
- Add hyp_init_valid_leaf_pte.
v1: https://lore.kernel.org/all/20230516141846.792193-1-smostafa@google.com/
---
 arch/arm64/include/asm/kvm_pgtable.h |  3 +++
 arch/arm64/include/asm/sysreg.h      |  1 +
 arch/arm64/kvm/arm.c                 |  7 ++++++-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S   |  7 +++++++
 arch/arm64/kvm/hyp/nvhe/setup.c      |  8 ++++++--
 arch/arm64/kvm/hyp/pgtable.c         | 11 ++++++++++-
 6 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 4cd6762bda80..5bcd06d664d3 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -151,6 +151,7 @@ enum kvm_pgtable_stage2_flags {
  * @KVM_PGTABLE_PROT_W:		Write permission.
  * @KVM_PGTABLE_PROT_R:		Read permission.
  * @KVM_PGTABLE_PROT_DEVICE:	Device attributes.
+ * @KVM_PGTABLE_PROT_GP_S1:	GP(guarded page) used for BTI in stage-1 only
  * @KVM_PGTABLE_PROT_SW0:	Software bit 0.
  * @KVM_PGTABLE_PROT_SW1:	Software bit 1.
  * @KVM_PGTABLE_PROT_SW2:	Software bit 2.
@@ -163,6 +164,8 @@ enum kvm_pgtable_prot {
 
 	KVM_PGTABLE_PROT_DEVICE			= BIT(3),
 
+	KVM_PGTABLE_PROT_GP_S1			= BIT(50),
+
 	KVM_PGTABLE_PROT_SW0			= BIT(55),
 	KVM_PGTABLE_PROT_SW1			= BIT(56),
 	KVM_PGTABLE_PROT_SW2			= BIT(57),
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e72d9aaab6b1..204124ce86c4 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -558,6 +558,7 @@
 			 (BIT(18)) | (BIT(22)) | (BIT(23)) | (BIT(28)) | \
 			 (BIT(29)))
 
+#define SCTLR_EL2_BT	(BIT(36))
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define ENDIAN_SET_EL2		SCTLR_ELx_EE
 #else
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 14391826241c..60c770030b33 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2073,6 +2073,7 @@ static int __init init_hyp_mode(void)
 	u32 hyp_va_bits;
 	int cpu;
 	int err = -ENOMEM;
+	enum kvm_pgtable_prot text_prot = PAGE_HYP_EXEC;
 
 	/*
 	 * The protected Hyp-mode cannot be initialized if the memory pool
@@ -2124,8 +2125,12 @@ static int __init init_hyp_mode(void)
 	/*
 	 * Map the Hyp-code called directly from the host
 	 */
+	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && system_supports_bti())
+		text_prot |= KVM_PGTABLE_PROT_GP_S1;
+
 	err = create_hyp_mappings(kvm_ksym_ref(__hyp_text_start),
-				  kvm_ksym_ref(__hyp_text_end), PAGE_HYP_EXEC);
+				  kvm_ksym_ref(__hyp_text_end), text_prot);
+
 	if (err) {
 		kvm_err("Cannot map world-switch code\n");
 		goto out_err;
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index a6d67c2bb5ae..e89b694bd8eb 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -128,6 +128,13 @@ alternative_if ARM64_HAS_ADDRESS_AUTH
 		     SCTLR_ELx_ENDA | SCTLR_ELx_ENDB)
 	orr	x0, x0, x1
 alternative_else_nop_endif
+
+#ifdef CONFIG_ARM64_BTI_KERNEL
+alternative_if ARM64_BTI
+	orr	x0, x0, #SCTLR_EL2_BT
+alternative_else_nop_endif
+#endif /* CONFIG_ARM64_BTI_KERNEL */
+
 	msr	sctlr_el2, x0
 	isb
 
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 110f04627785..c41065a5a4bd 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -66,7 +66,7 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 {
 	void *start, *end, *virt = hyp_phys_to_virt(phys);
 	unsigned long pgt_size = hyp_s1_pgtable_pages() << PAGE_SHIFT;
-	enum kvm_pgtable_prot prot;
+	enum kvm_pgtable_prot prot = PAGE_HYP_EXEC;
 	int ret, i;
 
 	/* Recreate the hyp page-table using the early page allocator */
@@ -88,7 +88,11 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 	if (ret)
 		return ret;
 
-	ret = pkvm_create_mappings(__hyp_text_start, __hyp_text_end, PAGE_HYP_EXEC);
+	/* Hypervisor text is mapped as guarded pages(GP). */
+	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && system_supports_bti())
+		prot |= KVM_PGTABLE_PROT_GP_S1;
+
+	ret = pkvm_create_mappings(__hyp_text_start, __hyp_text_end, prot);
 	if (ret)
 		return ret;
 
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 3d61bd3e591d..9f68e4ce6d14 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -152,6 +152,13 @@ static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
 	return pte;
 }
 
+static kvm_pte_t hyp_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
+{
+	kvm_pte_t pte = kvm_init_valid_leaf_pte(pa, attr, level);
+
+	return pte | (attr & KVM_PGTABLE_PROT_GP_S1);
+}
+
 static kvm_pte_t kvm_init_invalid_leaf_owner(u8 owner_id)
 {
 	return FIELD_PREP(KVM_INVALID_PTE_OWNER_MASK, owner_id);
@@ -371,6 +378,8 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 
 		if (device)
 			return -EINVAL;
+
+		attr |= prot & KVM_PGTABLE_PROT_GP_S1;
 	} else {
 		attr |= KVM_PTE_LEAF_ATTR_HI_S1_XN;
 	}
@@ -414,7 +423,7 @@ static bool hyp_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 		return false;
 
 	data->phys += granule;
-	new = kvm_init_valid_leaf_pte(phys, data->attr, ctx->level);
+	new = hyp_init_valid_leaf_pte(phys, data->attr, ctx->level);
 	if (ctx->old == new)
 		return true;
 	if (!kvm_pte_valid(ctx->old))
-- 
2.40.1.698.g37aff9b760-goog

