Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6368C72081A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbjFBRDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbjFBRCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:02:55 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA441A2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:02:54 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id ca18e2360f4ac-777097126abso83073139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685725374; x=1688317374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=46U2EWEjxn55kWeKsj3lDgLNoam846hFcVZO+vAwdLA=;
        b=WAqGXaWPraSA2daImKoen5B6tdZ+WYHgTjxhUUeeZAsbrniK5QsoJdy6bnYalQom0q
         MTUHUxan0x428dbLSXOSDczGl+sVACZNDReIhyFVk8qGv8O19J818JqDUV+L39pYvd+O
         +D0peOAv5LwnSHuhbBKS4on+Spl3k1vhxR2tQ3f+hr+YwUTyNz098zCnNqlglZ99wmXF
         03RZCAfLMqzIZPxHZwDc+9cJzrwA0lt7idYGl5Mr8XHmSaECCNan2CtJJnr3I5Ts2P2r
         magwgDPHCmtfLDNKqCKxBMgHtvBcTUMA++iZxC/lrSlB4KiCVknekWOPC0oT6ZjtI3V8
         dGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685725374; x=1688317374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46U2EWEjxn55kWeKsj3lDgLNoam846hFcVZO+vAwdLA=;
        b=ipymIVwzk2Z0Icl7YLJOuv9zEYAZ9TD/TBRpEiR1JI6iP4/2xzsjqGAKBhEc8lKe56
         yeodxpI7yDtDInCFgCpEi9QZwkz60VGpe0QQjQcy7i8QJ2sa+OeT+i3PGL/cMPTlmF+D
         PsIgARPUDNZmqKKJmVv2UKpLrDYmSJqE2Fu6yWZEooT7AVcLt1dpeSNrfszoUtYRSQ6e
         /04kmIh/Qn/IV57KRNs6ClamaPmoGFlMh87MM873Yma2UvOZnQlcZhx1J2tAaDpDHlu7
         euJUw84DSYufoRkilBPq+ixpumdxpcupwV3kOgey7BFaE/EmBgQLd1SENcD1a0R4Mnl9
         Xt0w==
X-Gm-Message-State: AC+VfDyBFGYT3/C4nl2QuocKDsoEL9WhobABzPaB0tl5Hj9ZuVv8phB3
        GU9pfgq2bGpemyZzRboYVgIdBOeHLKCuf9v56w==
X-Google-Smtp-Source: ACHHUZ4geDJMOIvtQH6zUtgqB8OHUq2dHYHBZAw17LyumZCyIixhJcFdC+UZZW8jvomo19VQYFFEQblUZyGsWdbTIA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6602:1503:b0:777:2367:a7d3 with
 SMTP id g3-20020a056602150300b007772367a7d3mr1813249iow.0.1685725373854; Fri,
 02 Jun 2023 10:02:53 -0700 (PDT)
Date:   Fri,  2 Jun 2023 17:01:47 +0000
In-Reply-To: <20230602170147.1541355-1-coltonlewis@google.com>
Mime-Version: 1.0
References: <20230602170147.1541355-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602170147.1541355-4-coltonlewis@google.com>
Subject: [PATCH 3/3] KVM: arm64: Skip break phase when we have FEAT_BBM level 2
From:   Colton Lewis <coltonlewis@google.com>
To:     kvm@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Colton Lewis <coltonlewis@google.com>
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

Skip the break phase of break-before-make when the CPU has FEAT_BBM
level 2. This allows skipping some expensive invalidation and
serialization and should result in significant performance
improvements when changing block size.

The ARM manual section D5.10.1 specifically states under heading
"Support levels for changing block size" that FEAT_BBM Level 2 support
means changing block size does not break coherency, ordering
guarantees, or uniprocessor semantics.

Because a compare-and-exchange operation was used in the break phase
to serialize access to the PTE, an analogous compare-and-exchange is
introduced in the make phase to ensure serialization remains even if
the break phase is skipped and proper handling is introduced to
account for this function now having a way to fail.

Considering the possibility that the new pte has different permissions
than the old pte, the minimum necessary tlb invalidations are used.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 58 +++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 8acab89080af9..6778e3df697f7 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -643,6 +643,11 @@ static bool stage2_has_fwb(struct kvm_pgtable *pgt)
 	return !(pgt->flags & KVM_PGTABLE_S2_NOFWB);
 }

+static bool stage2_has_bbm_level2(void)
+{
+	return cpus_have_const_cap(ARM64_HAS_STAGE2_BBM2);
+}
+
 #define KVM_S2_MEMATTR(pgt, attr) PAGE_S2_MEMATTR(attr, stage2_has_fwb(pgt))

 static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot prot,
@@ -730,7 +735,7 @@ static bool stage2_try_set_pte(const struct kvm_pgtable_visit_ctx *ctx, kvm_pte_
  * @ctx: context of the visited pte.
  * @mmu: stage-2 mmu
  *
- * Returns: true if the pte was successfully broken.
+ * Returns: true if the pte was successfully broken or there is no need.
  *
  * If the removed pte was valid, performs the necessary serialization and TLB
  * invalidation for the old value. For counted ptes, drops the reference count
@@ -750,6 +755,10 @@ static bool stage2_try_break_pte(const struct kvm_pgtable_visit_ctx *ctx,
 		return false;
 	}

+	/* There is no need to break the pte. */
+	if (stage2_has_bbm_level2())
+		return true;
+
 	if (!stage2_try_set_pte(ctx, KVM_INVALID_PTE_LOCKED))
 		return false;

@@ -771,16 +780,45 @@ static bool stage2_try_break_pte(const struct kvm_pgtable_visit_ctx *ctx,
 	return true;
 }

-static void stage2_make_pte(const struct kvm_pgtable_visit_ctx *ctx, kvm_pte_t new)
+static bool stage2_pte_perms_equal(kvm_pte_t p1, kvm_pte_t p2)
+{
+	u64 perms1 = p1 & KVM_PGTABLE_PROT_RWX;
+	u64 perms2 = p2 & KVM_PGTABLE_PROT_RWX;
+
+	return perms1 == perms2;
+}
+
+/**
+ * stage2_try_make_pte() - Attempts to install a new pte.
+ *
+ * @ctx: context of the visited pte.
+ * @new: new pte to install
+ *
+ * Returns: true if the pte was successfully installed
+ *
+ * If the old pte had different permissions, perform appropriate TLB
+ * invalidation for the old value. For counted ptes, drops the
+ * reference count on the containing table page.
+ */
+static bool stage2_try_make_pte(const struct kvm_pgtable_visit_ctx *ctx, struct kvm_s2_mmu *mmu, kvm_pte_t new)
 {
 	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;

-	WARN_ON(!stage2_pte_is_locked(*ctx->ptep));
+	if (!stage2_has_bbm_level2())
+		WARN_ON(!stage2_pte_is_locked(*ctx->ptep));
+
+	if (!stage2_try_set_pte(ctx, new))
+		return false;
+
+	if (kvm_pte_table(ctx->old, ctx->level))
+		kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
+	else if (kvm_pte_valid(ctx->old) && !stage2_pte_perms_equal(ctx->old, new))
+		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa_nsh, mmu, ctx->addr, ctx->level);

 	if (stage2_pte_is_counted(new))
 		mm_ops->get_page(ctx->ptep);

-	smp_store_release(ctx->ptep, new);
+	return true;
 }

 static void stage2_put_pte(const struct kvm_pgtable_visit_ctx *ctx, struct kvm_s2_mmu *mmu,
@@ -879,7 +917,8 @@ static int stage2_map_walker_try_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	    stage2_pte_executable(new))
 		mm_ops->icache_inval_pou(kvm_pte_follow(new, mm_ops), granule);

-	stage2_make_pte(ctx, new);
+	if (!stage2_try_make_pte(ctx, data->mmu, new))
+		return -EAGAIN;

 	return 0;
 }
@@ -934,7 +973,9 @@ static int stage2_map_walk_leaf(const struct kvm_pgtable_visit_ctx *ctx,
 	 * will be mapped lazily.
 	 */
 	new = kvm_init_table_pte(childp, mm_ops);
-	stage2_make_pte(ctx, new);
+
+	if (!stage2_try_make_pte(ctx, data->mmu, new))
+		return -EAGAIN;

 	return 0;
 }
@@ -1385,7 +1426,10 @@ static int stage2_split_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	 * writes the PTE using smp_store_release().
 	 */
 	new = kvm_init_table_pte(childp, mm_ops);
-	stage2_make_pte(ctx, new);
+
+	if (!stage2_try_make_pte(ctx, mmu, new))
+		return -EAGAIN;
+
 	dsb(ishst);
 	return 0;
 }
--
2.41.0.rc0.172.g3f132b7071-goog
