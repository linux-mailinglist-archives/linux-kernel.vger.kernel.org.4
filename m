Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D636E296F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjDNRaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjDNR3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:29:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF558A65
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:29:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c17fb245dso249229837b3.21
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681493371; x=1684085371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/QcOk48IC1/WqT95Uij/puIMmQjCMEPr+3tO3HuwfQ=;
        b=QWo1etgNuCpfarKk0sMjzQs753lB5TZr5/dnk4kDZ9dJPaUJEmNY3uILq7HPKvclaQ
         eOaY0c84jzyuPtkG8WIs8wNNj4dICRvoSUA3jdsan+4OW4kEjfaDE2m7pI9ViIoSnWJB
         ZEuzO0GtCVYYyoXhaLH30dGXOiQI6gnx5uDxm7h5j7oyVv5zhpVts6Jiy7MLwkHgghpU
         SsMjEqgOL/Wzfe9PrnwFfVsVkxk8L+0IPhBMd+B5Rc44u+EK7i109xafD6IUh3tWfIFp
         zJbiyMqBbmQLFjVyJVoTA/ei6xFOZmIB/Zpb7Xob7ZA/TtTIwFZvMlrTUJgd8QJ/FP3X
         Oq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493371; x=1684085371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/QcOk48IC1/WqT95Uij/puIMmQjCMEPr+3tO3HuwfQ=;
        b=YNwdWTidCAsSGEJZ2JdIkObivzosmJXCaufwpU+eBAu2rVqXMJ5KGcORPL4USvtreW
         rCLsej63RhRvFqSSUiqfRkc1VzlSC8RUFMxrUMW1m2gLs2OgTYnCfBW50pWnXFkg1mPv
         pmxw1Nz0NAybcG+xmnBKYD64mIj0znxRX7oYNMsUkQB4wO23BbLxrVgTwzPakYpyWfqY
         dnEEjPStmMj1zLDkeazeTTx6/ppw4hDC91KEC8CBfFtuiyLzu+vmen0WDYY7UE/jewGi
         92Qo4qu16mntCI20uwaMEfnM+smSsfGMYYZV78KzJ8D5aaU7I9+AsQs/hsIePOEu/inI
         3sMg==
X-Gm-Message-State: AAQBX9cZH8ZeWXvVz5XXQwvFqv6QR2TxXIf1hxUF3MeM4rXL/9RhNz1o
        plA3bDsmv5FRLceOI6ipxXxcKhISAVig
X-Google-Smtp-Source: AKy350aKTf8FVFWFUEuIlPbsBl3FnkxxsJzsWFEzqHW9OeHTbS7Yyx6LF4uwJ6X2m+BIEmm4mo5HYIIjXnbX
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a25:cbd4:0:b0:b78:4788:525b with SMTP id
 b203-20020a25cbd4000000b00b784788525bmr4175103ybg.0.1681493371735; Fri, 14
 Apr 2023 10:29:31 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:29:21 +0000
In-Reply-To: <20230414172922.812640-1-rananta@google.com>
Mime-Version: 1.0
References: <20230414172922.812640-1-rananta@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414172922.812640-7-rananta@google.com>
Subject: [PATCH v3 6/7] KVM: arm64: Add 'skip_flush' arg to stage2_put_pte()
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 'skip_flush' argument in stage2_put_pte() to
control the TLB invalidations. This will be leveraged
by the upcoming patch to defer the individual PTE
invalidations until the entire walk is finished.

No functional change intended.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index b8f0dbd12f773..3f136e35feb5e 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -772,7 +772,7 @@ static void stage2_make_pte(const struct kvm_pgtable_visit_ctx *ctx, kvm_pte_t n
 }
 
 static void stage2_put_pte(const struct kvm_pgtable_visit_ctx *ctx, struct kvm_s2_mmu *mmu,
-			   struct kvm_pgtable_mm_ops *mm_ops)
+			   struct kvm_pgtable_mm_ops *mm_ops, bool skip_flush)
 {
 	/*
 	 * Clear the existing PTE, and perform break-before-make with
@@ -780,7 +780,10 @@ static void stage2_put_pte(const struct kvm_pgtable_visit_ctx *ctx, struct kvm_s
 	 */
 	if (kvm_pte_valid(ctx->old)) {
 		kvm_clear_pte(ctx->ptep);
-		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, ctx->addr, ctx->level);
+
+		if (!skip_flush)
+			kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu,
+					ctx->addr, ctx->level);
 	}
 
 	mm_ops->put_page(ctx->ptep);
@@ -1015,7 +1018,7 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	 * block entry and rely on the remaining portions being faulted
 	 * back lazily.
 	 */
-	stage2_put_pte(ctx, mmu, mm_ops);
+	stage2_put_pte(ctx, mmu, mm_ops, false);
 
 	if (need_flush && mm_ops->dcache_clean_inval_poc)
 		mm_ops->dcache_clean_inval_poc(kvm_pte_follow(ctx->old, mm_ops),
-- 
2.40.0.634.g4ca3ef3211-goog

