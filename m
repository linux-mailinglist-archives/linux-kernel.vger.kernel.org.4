Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C69708D11
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjESAwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjESAwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:52:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1BD10D0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:52:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83fed51adso4904508276.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684457561; x=1687049561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e6DsOoIF+x/A7ZYSTdRHf2cD4dqAihxaeRbkm/Wf8QE=;
        b=5jParhefjh0HI3DzorDBwf9sb8RHRycHwmfDukeUSFn84zbi/9wRDfQaKoBx20Z2pS
         jgAJQ4ttTjCt4O4bkCtGffdz6NOopVPRPNoSjGutVL/MA59xkj/2i64IMZ4xsfb5JZvo
         kQknAlNduF12wnSsQxHbve4iQrVfw5KgPyNjRsYycjJCm6HjknBcGXCHSIYIS5n8fG/P
         xg/hoe/5+I5sWP+59TvQr8H21v4IS7jO4EfQnXFGK7qjua8eIK0OYqkQwb0pnsQqec5q
         4KabcCQrLkUiQ1gkV268Wti7RamOnI6hXcNQ2d3KXg8+bwW6KOn9g17yKdwKwZ3kjqrY
         RESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684457561; x=1687049561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6DsOoIF+x/A7ZYSTdRHf2cD4dqAihxaeRbkm/Wf8QE=;
        b=Jfg6dlQZdfa1kqm3nhD/oYNhyxU55WSZicYKdHz0C26Y0v6fkFcFGzU/Fr7Xion037
         J6GiEmp1ItvRt8WmSbomffQGvC2Uf3ArOmBZMxtge+uhoS+s2VYreXgt6VU1+PIqhwWS
         9NQGrVGo4OxiiTj9bxe4yoNtioExP1cOrf4A3rEYyCMEkf3oeuarME4UV4Yb8pn9zMZb
         WWUoREdk9mdxKehtIdZXva11oTiyq0KTVLG4mmT0FhN+lmANcvMwdlZ1PdId874eI1yA
         KJcQ+s+SfieFqBxPTErfKSoEK6gzXnxgRij364bsSVXMIKMShgOAaX/1gQbtbGYm/Lu+
         Joqw==
X-Gm-Message-State: AC+VfDz+qpzPTgavYfd7qMWT6SVcT87CA1s/2y9Yic2gdFMiVKANj5Tv
        /U3L93+b2AC4vYbR0iX21N/QkTzOWpZL
X-Google-Smtp-Source: ACHHUZ4Lgs2jxcq+llYDlHCAR5udROfxgqvoQbhs56Qn9JKtSHbYquhrdkyDxuf1xI7e7oDzhrf6uwFOdXpl
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a25:b906:0:b0:ba8:9096:df50 with SMTP id
 x6-20020a25b906000000b00ba89096df50mr26549ybj.9.1684457560955; Thu, 18 May
 2023 17:52:40 -0700 (PDT)
Date:   Fri, 19 May 2023 00:52:30 +0000
In-Reply-To: <20230519005231.3027912-1-rananta@google.com>
Mime-Version: 1.0
References: <20230519005231.3027912-1-rananta@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230519005231.3027912-6-rananta@google.com>
Subject: [PATCH v4 5/6] KVM: arm64: Invalidate the table entries upon a range
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
2.40.1.698.g37aff9b760-goog

