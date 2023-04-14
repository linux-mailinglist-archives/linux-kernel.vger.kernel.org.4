Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53866E2974
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjDNR3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDNR3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:29:37 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8087B7A85
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:29:31 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id 199-20020a6b14d0000000b00760ac8c52cdso3239146iou.18
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681493371; x=1684085371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oKp1uqEVUDsYvqb7n0EE6E39VgTURLiqq4SIcHauWnY=;
        b=A4ww0TsBpNc8NyuHHycocTyIKbFT6p62k0/A8t5/ltX9KxG0M7SK44yK6ry6Z2mMF+
         jeqV8N1OxvCVX9VRDGFZjgankBqNIL3n4bQYbPNlur0Gt+i5wrEcpZtd0hABAsHIgk0I
         QQYcuZsYerlzIHJ/z/LzsZc/GTmGp4M7XXAI8JUUuj3h736xuhABjmEb6C0gPmwG/Lbv
         tnshnBhAnysXSf0cOeG/AmMed5U4ze4xTJmfqAReYTCUtmv8k1LurjOJXsjR04evZfNt
         855K7678/DIciNdxe2RQK1JEWX6ua6QX1paK8Ve8Ve8btXIDgE4M5fLPABa2fB1l2v8h
         VeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493371; x=1684085371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKp1uqEVUDsYvqb7n0EE6E39VgTURLiqq4SIcHauWnY=;
        b=lrA1EDsLVilAklVCjIn/41TQ90Pd07Gdeua6yH7IkviV8sVJZGyXR8XswSXiygDufD
         QueP/+JQVhTjkJtZSTLLjhERbNzPJWSH5uQ7DDdfwfc5sGQiiQEQYD9I6+2MY42A0W4H
         jxo1K4WRKIIWW/7D1uGnFXWGcLfskTsDta8Ly7/Yn0NHXyTl5NmB2B0KMca8CjjnD8BB
         wsOJfFEDj90VxH58+nlJrtJJDWDyMRT37TH1Madw0YeAHgMm9BlwbndCwcCzOa2gz31k
         eq7lFL/qUlpV65dpNLQpNDKpfFnzyCeNcrdTmv7POpUBxdbEZ5AWm18GpJ4dc12+Hs4z
         pavQ==
X-Gm-Message-State: AAQBX9c3cByfXB2KIMVgrsBygfOAvkbOKxmitV/DdE4XpI4D5yprxl9G
        Be/cMxNHsnXCpHZyKPl0XqQrDhkqj7UT
X-Google-Smtp-Source: AKy350YdGpBiZBP25Vx/4WpYHfw47rqMyEvx05N69DBsQ4xqQZ/W+6ShMamGjXosvj+ntNMXpPu5TKlDemlu
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a6b:e60c:0:b0:758:b52c:ec8b with SMTP id
 g12-20020a6be60c000000b00758b52cec8bmr2589760ioh.3.1681493370852; Fri, 14 Apr
 2023 10:29:30 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:29:20 +0000
In-Reply-To: <20230414172922.812640-1-rananta@google.com>
Mime-Version: 1.0
References: <20230414172922.812640-1-rananta@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414172922.812640-6-rananta@google.com>
Subject: [PATCH v3 5/7] KVM: arm64: Invalidate the table entries upon a range
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Ricardo Koller <ricarkol@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

Currently, during the operations such as a hugepage collapse,
KVM would flush the entire VM's context using 'vmalls12e1is'
TLBI operation. Specifically, if the VM is faulting on many
hugepages (say after dirty-logging), it creates a performance
penalty for the guest whose pages have already been faulted
earlier as they would have to refill their TLBs again.

Instead, call __kvm_tlb_flush_vmid_range() for table entries.
If the system supports it, only the required range will be
flushed. Else, it'll fallback to the previous mechanism.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 3d61bd3e591d2..b8f0dbd12f773 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -745,10 +745,13 @@ static bool stage2_try_break_pte(const struct kvm_pgtable_visit_ctx *ctx,
 	 * Perform the appropriate TLB invalidation based on the evicted pte
 	 * value (if any).
 	 */
-	if (kvm_pte_table(ctx->old, ctx->level))
-		kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
-	else if (kvm_pte_valid(ctx->old))
+	if (kvm_pte_table(ctx->old, ctx->level)) {
+		u64 end = ctx->addr + kvm_granule_size(ctx->level);
+
+		kvm_call_hyp(__kvm_tlb_flush_vmid_range, mmu, ctx->addr, end);
+	} else if (kvm_pte_valid(ctx->old)) {
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, ctx->addr, ctx->level);
+	}
 
 	if (stage2_pte_is_counted(ctx->old))
 		mm_ops->put_page(ctx->ptep);
-- 
2.40.0.634.g4ca3ef3211-goog

