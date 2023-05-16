Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11168705067
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjEPOTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbjEPOTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:19:16 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8587280
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:19:12 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-3f50aa22cd2so14825065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684246750; x=1686838750;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gA6XtRTSFH+7gbI9LxiaMPmJ/zupzliW7od3onrGWNM=;
        b=AOwGUZnMyyLA8iHs7jP21cMgPRF2hzI6RmNK7aKc/NSUxG/UCoWTY7Fu+gupD3aoFb
         efLSnTdFHYS/SFWT5hnebtwD9p/rI2tIJycNlKvw89utzeUx0jXlTuJdlQgKpPWjoolh
         bisZDCj08FJCWwCxeiGvw1GjKLtM1mhkI1Qt1snZPjyD+/AofG9I2G1uitjkgDOmtH5J
         wgdfIE+s2BDJnqxdvZf9zePYbBv3lrZ6tBtNVltJo2s39IBAvOFrvvjuA48JWLThSFmW
         V1gliA0Ot12nXkt+9YeXbcFn6FBu17Ab9icwTBFtyWDp3/h3XfxElurRlCEmYN/Xc8vj
         hlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684246750; x=1686838750;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gA6XtRTSFH+7gbI9LxiaMPmJ/zupzliW7od3onrGWNM=;
        b=GtDSSTxFgeeUU+Ul4JOqSEnlYIZ9kRGNJx7BdmKWvHJfzP4Lh8LQjgQdbytIULTmpa
         xD6Iq/NZn/MQ6ONM1HxDHCM6A1W4rq8ecSKyO87n3bvV26L8jLNKLAy/AKX8VJpr0YuJ
         8ywa5kHWca6NYRxaTvmctN8m5tlfJwGEc+6UtWJZ5xb03NKGPZFlyeusUEcb4B3Pl1Wm
         sKwyDQ6OaMUs49xdxvInktYhgK2MUBZqbQuHATS9j2Sx1vJsKWCrSHNkLL8Ofift2MGn
         xImOh+DzSnR4eXLGIp0oJLSjY5zInpEFvI4yJ/3J3TnHSjGk6axHBpBt7oR4SuHDqakr
         43FQ==
X-Gm-Message-State: AC+VfDwageeEVbdyYWA+8B9QMjtUXUkAJ1MHruAXwo8z3g1RKxWeavGv
        CVuVWvIHeO3qk1QgHfKvCkdCPiABDqhLKA==
X-Google-Smtp-Source: ACHHUZ7Io7X+jy8JLQYkj4bFApjAK1ehdd/QE0fm7hTqEAONOITaXEZbjKxjz9KOwpLiV94EXcGHlOEs8OGsMQ==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a7b:c4cc:0:b0:3f4:ec32:69fe with SMTP id
 g12-20020a7bc4cc000000b003f4ec3269femr3071985wmk.0.1684246750417; Tue, 16 May
 2023 07:19:10 -0700 (PDT)
Date:   Tue, 16 May 2023 14:18:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516141846.792193-1-smostafa@google.com>
Subject: [PATCH] KVM: arm64: Use BTI for pKVM
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

This patch maps pKVM .text section with GP bit which matches the
kernel handling for BTI.

A new flag is added to enum kvm_pgtable_prot: KVM_PGTABLE_PROT_GP_S1,
which represents BTI guarded page in hypervisor stage-1 page table.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 3 +++
 arch/arm64/kvm/hyp/nvhe/setup.c      | 8 ++++++--
 arch/arm64/kvm/hyp/pgtable.c         | 6 ++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

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
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 110f04627785..95f80e2b2946 100644
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
+	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && cpus_have_const_cap(ARM64_BTI))
+		prot |= KVM_PGTABLE_PROT_GP_S1;
+
+	ret = pkvm_create_mappings(__hyp_text_start, __hyp_text_end, prot);
 	if (ret)
 		return ret;
 
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 3d61bd3e591d..028e198acd48 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -145,7 +145,8 @@ static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
 	u64 type = (level == KVM_PGTABLE_MAX_LEVELS - 1) ? KVM_PTE_TYPE_PAGE :
 							   KVM_PTE_TYPE_BLOCK;
 
-	pte |= attr & (KVM_PTE_LEAF_ATTR_LO | KVM_PTE_LEAF_ATTR_HI);
+	pte |= attr & (KVM_PTE_LEAF_ATTR_LO | KVM_PTE_LEAF_ATTR_HI |
+		       KVM_PGTABLE_PROT_GP_S1);
 	pte |= FIELD_PREP(KVM_PTE_TYPE, type);
 	pte |= KVM_PTE_VALID;
 
@@ -378,7 +379,8 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_AP, ap);
 	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S1_SH, sh);
 	attr |= KVM_PTE_LEAF_ATTR_LO_S1_AF;
-	attr |= prot & KVM_PTE_LEAF_ATTR_HI_SW;
+	attr |= prot & (KVM_PTE_LEAF_ATTR_HI_SW | KVM_PGTABLE_PROT_GP_S1);
+
 	*ptep = attr;
 
 	return 0;
-- 
2.40.1.606.ga4b1b128d6-goog

