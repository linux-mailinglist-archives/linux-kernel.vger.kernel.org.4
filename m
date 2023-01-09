Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B1D663387
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjAIVyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237793AbjAIVyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:54:21 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7B3C389
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:54:10 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id s2-20020a056e02216200b0030bc3be69e5so7112778ilv.20
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BjMR5IMZCP3wwXGcrrOi/YjnHWAxQ/J3ysDtq7OdZIc=;
        b=QFiqc5zB4Ezhsqh0uJctnxBIZ06ZL1uMn/Q6xiIlBq5mgzNSVfWobcWpl+XMH2a1ZB
         dyTqEaOqhGBhJi7TVqx9StbjModEQJPT51Fp+zKoDaVSyWWwvkyuhXL0k9HyZODKS15w
         9JlfwdWOMTUVfOEYqSMJLThOAGQxLoYB8ZW/Avt5hEjhYd0eK3JbsAvOQXV9NpGxcwRz
         lghVpihiMlnlLlYNqfMsVhO5Zpa6QT6bvsGvCsxj/WPp3DYK/2EnM1p3hEFKreLXtScE
         jGL0g9SEPsYvYkF7UxjUTJ9ghGVXrlOWYd3EPOYn4m5JgjcjbfoXOFdcf4QsUodhmm6m
         Uvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjMR5IMZCP3wwXGcrrOi/YjnHWAxQ/J3ysDtq7OdZIc=;
        b=IfhE3MPhoZBseLg8zsm4q8BBHFQBLfoXa9hQQYmXx5EVfOULKg7lIFwAsCFrbSqtOI
         xgscPAI/yt3gKW3sAu7fy1/WTaV5HuNhwuAT6i0nsjbgZ2UZ2mTIg+APiqlRSSuYZVD4
         /73O5I4MP1sZhbaogW3Cr5iMJJlTtTMMu68eKZkqkBiWfAJWaItdivPFphtTvGghhDFv
         a9285OJ1LfeqP9AKZxEh62/64rWMyYQpsP5oeD4IlcJUuRdApidiZgdVJwewSVbD+06Z
         fsjNbrH0Is1AFBOuc9yUIGo6z0qnJBXpa0XEuWRhWFkG3sulXJX7L5tGbq/4WXpiRlc1
         GHSg==
X-Gm-Message-State: AFqh2ko2xjdrVk3MrsvLbWu7tZrkKW06dtAPvvjfmGGti/2ZBxn6sae9
        VxJ6eo0JVdY7+4AWly/noN1569WYz+gW
X-Google-Smtp-Source: AMrXdXveLZ+wlH5ggK1nS8geCa3M7PI/cZSvzt5mjAy3d14vsfPB1eAi+vunpQHd5SoWZ396qOqlx95aAAQc
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a05:6e02:2206:b0:30c:3823:2907 with SMTP
 id j6-20020a056e02220600b0030c38232907mr4744567ilf.304.1673301250053; Mon, 09
 Jan 2023 13:54:10 -0800 (PST)
Date:   Mon,  9 Jan 2023 21:53:46 +0000
In-Reply-To: <20230109215347.3119271-1-rananta@google.com>
Mime-Version: 1.0
References: <20230109215347.3119271-1-rananta@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109215347.3119271-6-rananta@google.com>
Subject: [RFC PATCH 5/6] KVM: arm64: Optimize the stage2 map path with TLBI
 range instructions
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oupton@google.com>, Marc Zyngier <maz@kernel.org>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when the map path of stage2 page-table coalesces a
bunch of pages into a hugepage, KVM invalidates the entire
VM's TLB entries. This would cause a perforamance penality for
the guest whose pages have already been coalesced earlier as they
would have to refill their TLB entries unnecessarily again.

Hence, if the system supports it, use __kvm_tlb_flush_range_vmid_ipa()
to flush only the range of pages that have been combined into
a hugepage, while leaving other TLB entries alone.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index b11cf2c618a6c..099032bb01bce 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -686,6 +686,22 @@ static bool stage2_try_set_pte(const struct kvm_pgtable_visit_ctx *ctx, kvm_pte_
 	return cmpxchg(ctx->ptep, ctx->old, new) == ctx->old;
 }
 
+static void kvm_table_pte_flush(struct kvm_s2_mmu *mmu, u64 addr, u32 level, u32 tlb_level)
+{
+	if (system_supports_tlb_range()) {
+		u64 end = addr + kvm_granule_size(level);
+
+		kvm_call_hyp(__kvm_tlb_flush_range_vmid_ipa, mmu, addr, end, tlb_level);
+	} else {
+		/*
+		 * Invalidate the whole stage-2, as we may have numerous leaf
+		 * entries below us which would otherwise need invalidating
+		 * individually.
+		 */
+		kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
+	}
+}
+
 /**
  * stage2_try_break_pte() - Invalidates a pte according to the
  *			    'break-before-make' requirements of the
@@ -693,6 +709,7 @@ static bool stage2_try_set_pte(const struct kvm_pgtable_visit_ctx *ctx, kvm_pte_
  *
  * @ctx: context of the visited pte.
  * @mmu: stage-2 mmu
+ * @tlb_level: The level at which the leaf pages are expected (for FEAT_TTL hint)
  *
  * Returns: true if the pte was successfully broken.
  *
@@ -701,7 +718,7 @@ static bool stage2_try_set_pte(const struct kvm_pgtable_visit_ctx *ctx, kvm_pte_
  * on the containing table page.
  */
 static bool stage2_try_break_pte(const struct kvm_pgtable_visit_ctx *ctx,
-				 struct kvm_s2_mmu *mmu)
+				 struct kvm_s2_mmu *mmu, u32 tlb_level)
 {
 	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
 
@@ -722,7 +739,7 @@ static bool stage2_try_break_pte(const struct kvm_pgtable_visit_ctx *ctx,
 	 * value (if any).
 	 */
 	if (kvm_pte_table(ctx->old, ctx->level))
-		kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
+		kvm_table_pte_flush(mmu, ctx->addr, ctx->level, tlb_level);
 	else if (kvm_pte_valid(ctx->old))
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, ctx->addr, ctx->level);
 
@@ -804,7 +821,7 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	if (!stage2_pte_needs_update(ctx->old, new))
 		return -EAGAIN;
 
-	if (!stage2_try_break_pte(ctx, data->mmu))
+	if (!stage2_try_break_pte(ctx, data->mmu, ctx->level))
 		return -EAGAIN;
 
 	/* Perform CMOs before installation of the guest stage-2 PTE */
@@ -861,7 +878,11 @@ static int stage2_map_walk_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	if (!childp)
 		return -ENOMEM;
 
-	if (!stage2_try_break_pte(ctx, data->mmu)) {
+	/*
+	 * As the table will be replaced with a block, one level down would
+	 * be the current page entries held by the table.
+	 */
+	if (!stage2_try_break_pte(ctx, data->mmu, ctx->level + 1)) {
 		mm_ops->put_page(childp);
 		return -EAGAIN;
 	}
-- 
2.39.0.314.g84b9a713c41-goog

