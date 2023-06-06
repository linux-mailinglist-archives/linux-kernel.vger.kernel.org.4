Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197E8724D0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbjFFT3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbjFFT3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:29:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1CD10EA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:29:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bac6a453dd5so7652295276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686079745; x=1688671745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJX97QI+ti3MLO2eZ0RB5q+cUC0tg2B7MRgGhqPSdoU=;
        b=RcVezT/+/Q8mG0UYDZnsdFHKOHniiQuIpjqjLx/cY/g1xzgASwICXK9Wqgs9eVucjT
         HIGAvPfE8ZgZh7cy7t0nQdK82U5/rzUnJKV3VS4vqSTdMjvp99ELBTEKYTE6OZecdZho
         651BWNdkC19a1JqYSWSyjmzOMAjT1wQhAL+FMk40w16n9aRdV/fLLle2cLbl33qZPyq7
         Z9IVaUYiI90fOFYfbURYEQK3I6FUdKje/TNTIkA3zjRF0WC7MK0bvKYng9obi+zCX1Z0
         40qfAe5u8OsWTqN6PqApBq1e4MfndxJKZLIILNempK+BnBKPZjEznus0nLi/aKu/5krT
         4ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686079745; x=1688671745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJX97QI+ti3MLO2eZ0RB5q+cUC0tg2B7MRgGhqPSdoU=;
        b=gJSjIKAmvgdp4LxLwdogRT/1oWGxpoicz+2rD3Cj0wa7C/YDuD3SV9TjpVhCWujYsS
         Xh7Die8ExCGtYPOcEfk+UKKdg8pY/HpTLiEP55xvRXubP/zT93Lgdn3pFoLy5pw883Np
         v8Q3eF/7MFJ6ZnBIbO7wO58IcGmYEg56Mu1gOxO/nVzQCCFtUsruLBEavcZe+aJvOFLP
         sYF2nqF4aTxd2dMObuV7UX5X8Wl506Sqzc4/rRXuZt6TUY8kKCLOn8Hq5GHm9uBaSy70
         V/rWfddJhQz7mJZ4FcMFasf1sQXVNpUCZS4zqSjFOYg2gSPiks+yurKU2l/XOWQLxIJf
         anyw==
X-Gm-Message-State: AC+VfDyos8XoYtsjR6YO35lADRCbAv4dpkcGTXV22a4xJfymj3WrR5Jm
        BIGcrYrzvkS4SO98TDLHfwSxBMqjvqlp
X-Google-Smtp-Source: ACHHUZ4utofyeOL86/Kh7XYvV5vjDO1rXmuNvLh41L3YVuhJgVaiYRIoiVec1XFLov1RpXm667fMK2Lo8ndc
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a05:6902:1886:b0:ba8:4b22:4e8a with SMTP
 id cj6-20020a056902188600b00ba84b224e8amr1774981ybb.0.1686079745555; Tue, 06
 Jun 2023 12:29:05 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:28:54 +0000
In-Reply-To: <20230606192858.3600174-1-rananta@google.com>
Mime-Version: 1.0
References: <20230606192858.3600174-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606192858.3600174-4-rananta@google.com>
Subject: [PATCH v5 3/7] KVM: arm64: Define kvm_tlb_flush_vmid_range()
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the helper kvm_tlb_flush_vmid_range() that acts
as a wrapper for range-based TLB invalidations. For the
given VMID, use the range-based TLBI instructions to do
the job or fallback to invalidating all the TLB entries.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 10 ++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 4cd6762bda805..1b12295a83595 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -682,4 +682,14 @@ enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte);
  *	   kvm_pgtable_prot format.
  */
 enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
+
+/**
+ * kvm_tlb_flush_vmid_range() - Invalidate/flush a range of TLB entries
+ *
+ * @mmu:	Stage-2 KVM MMU struct
+ * @addr:	The base Intermediate physical address from which to invalidate
+ * @size:	Size of the range from the base to invalidate
+ */
+void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
+				phys_addr_t addr, size_t size);
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 3d61bd3e591d2..df8ac14d9d3d4 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -631,6 +631,26 @@ static bool stage2_has_fwb(struct kvm_pgtable *pgt)
 	return !(pgt->flags & KVM_PGTABLE_S2_NOFWB);
 }
 
+void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
+				phys_addr_t addr, size_t size)
+{
+	unsigned long pages, inval_pages;
+
+	if (!system_supports_tlb_range()) {
+		kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
+		return;
+	}
+
+	pages = size >> PAGE_SHIFT;
+	while (pages > 0) {
+		inval_pages = min(pages, MAX_TLBI_RANGE_PAGES);
+		kvm_call_hyp(__kvm_tlb_flush_vmid_range, mmu, addr, inval_pages);
+
+		addr += inval_pages << PAGE_SHIFT;
+		pages -= inval_pages;
+	}
+}
+
 #define KVM_S2_MEMATTR(pgt, attr) PAGE_S2_MEMATTR(attr, stage2_has_fwb(pgt))
 
 static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot prot,
-- 
2.41.0.rc0.172.g3f132b7071-goog

