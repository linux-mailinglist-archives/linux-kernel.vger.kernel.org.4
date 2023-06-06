Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90129724D12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbjFFT3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbjFFT3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:29:15 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2279E1725
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:29:09 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id ca18e2360f4ac-7776dd75224so447284739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686079748; x=1688671748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSh72g4ZHJDv4/8vl2ojF6XiepiDvTufhm8MWFlXvRw=;
        b=DgqodgA0VlUZWQrMG4GP7C/weUqyJOTcJeeBU+QJtyx73nrL97iFH09J3NN1a3ZqZp
         HnGGp8mag6nk53M7ixB65x5AD6Ms56KjI1ef3YbrAECkzd/sBiP49ZaRawRDGSG6W/48
         zpTIZ9xiNUakwan9Sah7O3FQZq8hbYO+vJYMpPhkX+vPtaFLwYWWIJatBbkiuWPko3KK
         xLOP8K2IyKlFQWL5H/yaFnL404Xk/QQOl56Czr3QPqSe5ks+kz2URjUEHgddpbJaiPlb
         GYXlIgD7DvVtN5XvZx5Rt/1wo3vRwOLcLfUaazlKhmWPNVBuGWB5FFLS01Y/RwmF7Ac/
         NxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686079748; x=1688671748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSh72g4ZHJDv4/8vl2ojF6XiepiDvTufhm8MWFlXvRw=;
        b=HafdSrKXtQSLI1zfx747b+4e9zTR1ydSlI4OLnKB37zNvQdDR65DSGaQJ6o73Cp66g
         K6vRPFBfPv0vejRaDy8memIosDKGvTQSZtVo6hLkxh4wM/L9RHx1MM5zKwYS6kpbQYNM
         A1O4I6Xu8im2z8C4KoS495nRuIh4dGytEOykSezfP0L4TOe6ssjgwHBBzlMYAM5T+p4w
         2vANEdtTVVNWqIJIjzPYcwKkOzgG27GiXlaqwONQDxYbMV8BuciBs1y+s+ggrPKINuoF
         F3QZq0PyCcVoJj+/5vBbF0YsBu3UWcVpYGiKezM6e4PPLhlV+SkpjC2xDvDTR+20730N
         hbhw==
X-Gm-Message-State: AC+VfDwbu37/NembPd6uORV7LmH12m+3H40ZU+ZwY/oId50zDOkbmCfO
        tqmpb88wllIvLvmp77eNl6qfpBe6JKQb
X-Google-Smtp-Source: ACHHUZ7CbVG1v9+02j/lP6GitPjQFKqy8MFcVF4f6QKfj749lOkIhDCulQsPILWvgJRfRfbdJbdIHNk5CYhj
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a02:85e6:0:b0:416:7e77:bb5f with SMTP id
 d93-20020a0285e6000000b004167e77bb5fmr1392579jai.0.1686079748520; Tue, 06 Jun
 2023 12:29:08 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:28:57 +0000
In-Reply-To: <20230606192858.3600174-1-rananta@google.com>
Mime-Version: 1.0
References: <20230606192858.3600174-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606192858.3600174-7-rananta@google.com>
Subject: [PATCH v5 6/7] KVM: arm64: Invalidate the table entries upon a range
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

Currently, during the operations such as a hugepage collapse,
KVM would flush the entire VM's context using 'vmalls12e1is'
TLBI operation. Specifically, if the VM is faulting on many
hugepages (say after dirty-logging), it creates a performance
penalty for the guest whose pages have already been faulted
earlier as they would have to refill their TLBs again.

Instead, leverage kvm_tlb_flush_vmid_range() for table entries.
If the system supports it, only the required range will be
flushed. Else, it'll fallback to the previous mechanism.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index df8ac14d9d3d4..50ef7623c54db 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -766,7 +766,8 @@ static bool stage2_try_break_pte(const struct kvm_pgtable_visit_ctx *ctx,
 	 * value (if any).
 	 */
 	if (kvm_pte_table(ctx->old, ctx->level))
-		kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
+		kvm_tlb_flush_vmid_range(mmu, ctx->addr,
+					kvm_granule_size(ctx->level));
 	else if (kvm_pte_valid(ctx->old))
 		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, ctx->addr, ctx->level);
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

