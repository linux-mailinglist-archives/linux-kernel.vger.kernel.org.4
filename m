Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCB7738DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjFURwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjFURv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:51:26 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6985D2691
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:50:33 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id ca18e2360f4ac-77ac4aa24eeso595068339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687369832; x=1689961832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1k5M++jVJQN3HsAnULjgdeEMSBZOk/cO6/5CPwT5F8k=;
        b=w6GZsyPqZZib29SWYZEVnZb1y4/Lbstpu1dT+fTCnzTCJENFj5D4vH91+GzI+/bi6H
         1oi0xlgidMJoef1Cy+DHvVUNiEPFe0GTcgPM9Vz0WN5MJ/vDDywJ8SAurP3W7Z0E8RV1
         bL9yrGC0vSg5SmdyfHRQ/SYavKI9Z8TdIi8UUAeeguYA5s8unRrmN3ckrBjyYDhQ3H/C
         6kxbOF2nw+aLZFKsd8D0RuLiMEtzfCulkKG3cg/gg/4NqQ7iNsqHpVsN/CzszFwqzu1T
         HZd28iVtbf1SIrpe9Y+ZQDrpu1IIvftL7laiPI+V4lrVf1uTFxBYBnD5cSNCRy3C9bk2
         Iw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687369832; x=1689961832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1k5M++jVJQN3HsAnULjgdeEMSBZOk/cO6/5CPwT5F8k=;
        b=E73yjn78nrszRX1+z/VEfBFD3/w3uAEiEZUclz+XB4KWEZt02ftAX9/Tl2WbnR4YI9
         DNPxZCaES4EEzHhf/zITu271S0XJJ/wumAYtBRl/QacdXM+POL8u0KCC862Wl/+PSPaK
         +9ZV5vzAMsDbBmV+HqXkTCDCeVXlENX2APXtg1RggfdZ6INblyYoab1RW6IRx5pFRjdH
         7YAifMh4JJpPrtfmVbPZOl/qgyULqHd9HlAiz/BqS3L7brazRG9mbbmhibG8lUBJpGUn
         DfOJHE8Iw+r9UqFjC/J6giAtn+MV7XLvNxMa7Xwp8QtXI2KdyEFzh0yVGJ+DbVq7oJW4
         7+Eg==
X-Gm-Message-State: AC+VfDzr6Urb6gYEqV/c9vwXhFNuUyVikSffWVv4Go1XefL6GCIK5+5f
        6tKns+pRYGi84EAoF3FTUaG6HGRiVWeZ
X-Google-Smtp-Source: ACHHUZ7D/T/4id1CIm/7FILU8FYzyWybEpfQUoMmSgByaqoojlf3IY4EM1ax7sfpQ3tyXmvK1JA9xHULv5Uv
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a02:2ac7:0:b0:41a:c455:f4c8 with SMTP id
 w190-20020a022ac7000000b0041ac455f4c8mr5918374jaw.3.1687369832124; Wed, 21
 Jun 2023 10:50:32 -0700 (PDT)
Date:   Wed, 21 Jun 2023 17:50:02 +0000
In-Reply-To: <20230621175002.2832640-1-rananta@google.com>
Mime-Version: 1.0
References: <20230621175002.2832640-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621175002.2832640-12-rananta@google.com>
Subject: [RESEND PATCH v5 11/11] KVM: arm64: Use TLBI range-based intructions
 for unmap
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
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

The current implementation of the stage-2 unmap walker traverses
the given range and, as a part of break-before-make, performs
TLB invalidations with a DSB for every PTE. A multitude of this
combination could cause a performance bottleneck on some systems.

Hence, if the system supports FEAT_TLBIRANGE, defer the TLB
invalidations until the entire walk is finished, and then
use range-based instructions to invalidate the TLBs in one go.
Condition deferred TLB invalidation on the system supporting FWB,
as the optimization is entirely pointless when the unmap walker
needs to perform CMOs.

Rename stage2_put_pte() to stage2_unmap_put_pte() as the function
now serves the stage-2 unmap walker specifically, rather than
acting generic.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 67 +++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 50ef7623c54db..1451f9011590d 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -789,16 +789,54 @@ static void stage2_make_pte(const struct kvm_pgtable_visit_ctx *ctx, kvm_pte_t n
 	smp_store_release(ctx->ptep, new);
 }
 
-static void stage2_put_pte(const struct kvm_pgtable_visit_ctx *ctx, struct kvm_s2_mmu *mmu,
-			   struct kvm_pgtable_mm_ops *mm_ops)
+struct stage2_unmap_data {
+	struct kvm_pgtable *pgt;
+	bool defer_tlb_flush_init;
+};
+
+static bool __stage2_unmap_defer_tlb_flush(struct kvm_pgtable *pgt)
+{
+	/*
+	 * If FEAT_TLBIRANGE is implemented, defer the individual
+	 * TLB invalidations until the entire walk is finished, and
+	 * then use the range-based TLBI instructions to do the
+	 * invalidations. Condition deferred TLB invalidation on the
+	 * system supporting FWB, as the optimization is entirely
+	 * pointless when the unmap walker needs to perform CMOs.
+	 */
+	return system_supports_tlb_range() && stage2_has_fwb(pgt);
+}
+
+static bool stage2_unmap_defer_tlb_flush(struct stage2_unmap_data *unmap_data)
+{
+	bool defer_tlb_flush = __stage2_unmap_defer_tlb_flush(unmap_data->pgt);
+
+	/*
+	 * Since __stage2_unmap_defer_tlb_flush() is based on alternative
+	 * patching and the TLBIs' operations behavior depend on this,
+	 * track if there's any change in the state during the unmap sequence.
+	 */
+	WARN_ON(unmap_data->defer_tlb_flush_init != defer_tlb_flush);
+	return defer_tlb_flush;
+}
+
+static void stage2_unmap_put_pte(const struct kvm_pgtable_visit_ctx *ctx,
+				struct kvm_s2_mmu *mmu,
+				struct kvm_pgtable_mm_ops *mm_ops)
 {
+	struct stage2_unmap_data *unmap_data = ctx->arg;
+
 	/*
-	 * Clear the existing PTE, and perform break-before-make with
-	 * TLB maintenance if it was valid.
+	 * Clear the existing PTE, and perform break-before-make if it was
+	 * valid. Depending on the system support, the TLB maintenance for
+	 * the same can be deferred until the entire unmap is completed.
 	 */
 	if (kvm_pte_valid(ctx->old)) {
 		kvm_clear_pte(ctx->ptep);
-		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, ctx->addr, ctx->level);
+
+		if (!stage2_unmap_defer_tlb_flush(unmap_data))
+			kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu,
+					ctx->addr, ctx->level);
 	}
 
 	mm_ops->put_page(ctx->ptep);
@@ -1005,7 +1043,8 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
 			       enum kvm_pgtable_walk_flags visit)
 {
-	struct kvm_pgtable *pgt = ctx->arg;
+	struct stage2_unmap_data *unmap_data = ctx->arg;
+	struct kvm_pgtable *pgt = unmap_data->pgt;
 	struct kvm_s2_mmu *mmu = pgt->mmu;
 	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
 	kvm_pte_t *childp = NULL;
@@ -1033,7 +1072,7 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	 * block entry and rely on the remaining portions being faulted
 	 * back lazily.
 	 */
-	stage2_put_pte(ctx, mmu, mm_ops);
+	stage2_unmap_put_pte(ctx, mmu, mm_ops);
 
 	if (need_flush && mm_ops->dcache_clean_inval_poc)
 		mm_ops->dcache_clean_inval_poc(kvm_pte_follow(ctx->old, mm_ops),
@@ -1047,13 +1086,23 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
 
 int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
 {
+	int ret;
+	struct stage2_unmap_data unmap_data = {
+		.pgt = pgt,
+		.defer_tlb_flush_init = __stage2_unmap_defer_tlb_flush(pgt),
+	};
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_unmap_walker,
-		.arg	= pgt,
+		.arg	= &unmap_data,
 		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
 	};
 
-	return kvm_pgtable_walk(pgt, addr, size, &walker);
+	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
+	if (stage2_unmap_defer_tlb_flush(&unmap_data))
+		/* Perform the deferred TLB invalidations */
+		kvm_tlb_flush_vmid_range(pgt->mmu, addr, size);
+
+	return ret;
 }
 
 struct stage2_attr_data {
-- 
2.41.0.162.gfafddb0af9-goog

