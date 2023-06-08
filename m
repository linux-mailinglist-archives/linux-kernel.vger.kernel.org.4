Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185F9728AE1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbjFHWGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbjFHWGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:06:15 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE5D30D0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:06:12 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b0314f0aadso911115ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686261972; x=1688853972;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f9CaDc6GGBWuK7eCpoNYT6YueR8Zbl2jpIpeaKQVQvQ=;
        b=g6TUacceAYPEbfsv6EW0WtXBfm6IOz5S5d+OFFFjRuXIN+Gt6qw1Hxz/wxQRodLv6Q
         fZvF+Q31Rn/FCi8bHs7ONm0lzgg2+m7cQKkQ6aAmUBSZVRKELWdRRtCJE1LkgFGEy3zQ
         SxZE6ZO51wmiUifCL70ATkprYaVBcUZO8HlrsZfUqqxFI2uuJg2p5Hgbntzk6iKii5ZF
         qYY0amN96y9UZxoF6WKyTwgEpRR55ljoc844L4vL0UGsBIG0swmXQmOgRXIkO3EUuJIv
         vyKSVUkn1eQVVuBk8NZ6GWTUIYEHnAR4AAFKiV+taoOoCgyj5MdYG6SmNJrXxexjNXoH
         ZfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686261972; x=1688853972;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9CaDc6GGBWuK7eCpoNYT6YueR8Zbl2jpIpeaKQVQvQ=;
        b=IwMKg5rYBxqYm5H81z1rIR8J0NKqFkAu2mL4Hmx8Uz3R3siBOi53gszCK7KQLEqbMs
         kegPz7Yt7b8CtAnZ2TlvuvRr8zEVMPhzb1hWIKlk5FzxRPrPkM3zT13leb3ByfYffGr0
         +kucu0YzO9QxjS/zhHK2nJRoyzEz8AMTogB01wKCn2hCCiUZTgA80LREpdFTi/dnftK+
         1t1jMegJqW5Uv3qOI993bOfmsJyvQmUYKpZJAMKSQEq61Dzk5N2cQ5oTb/GwGivcGgrD
         US66fcyPrC/mEwkzERlKISpeODcV7qhA1LPz/7X3CTFoCI06RI+bwyzeLYsfoP/YMVMf
         /aaw==
X-Gm-Message-State: AC+VfDzo71VGssBapnM68Khen5lvKn7a8UENnDYqu/rhvoDWfsa01brJ
        jXPdRJmUqcbeLQtBB6v9Mc2wFULMgL+JIundLOnb065F/I5ln2w5O3Vh3rCJRbFWO20vSpuhApT
        Hd8MGoP6fhtRMU9rIQLfVvGdJJR1zEkfR3g17CqvNcAc4H+NvMrWYkuwFCG07dshtytKvSw==
X-Google-Smtp-Source: ACHHUZ6MQlIY790bFakXPIY1+zDRu/UOVYFkss4KwDwJ93EXpywhfKozP0OWWxinQPg4v+c45aCEckKGtc8=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5cff])
 (user=ctshao job=sendgmr) by 2002:a17:902:8c81:b0:1b0:46af:7edf with SMTP id
 t1-20020a1709028c8100b001b046af7edfmr626301plo.2.1686261971803; Thu, 08 Jun
 2023 15:06:11 -0700 (PDT)
Date:   Thu,  8 Jun 2023 15:05:38 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230608220558.39094-1-ctshao@google.com>
Subject: [PATCH v1 1/3] KVM: arm64: Consistently use free_removed_table() for stage-2
From:   Chun-Tse Shao <ctshao@google.com>
To:     linux-kernel@vger.kernel.org, yuzhao@google.com,
        oliver.upton@linux.dev
Cc:     Chun-Tse Shao <ctshao@google.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ben Gardon <bgardon@google.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
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

From: Oliver Upton <oliver.upton@linux.dev>

free_removed_table() is essential to the RCU-protected parallel walking
scheme, as behind the scenes the cleanup is deferred until an RCU grace
period. Nonetheless, the stage-2 unmap path calls put_page() directly,
which leads to table memory being freed inline with the table walk.

This is safe for the time being, as the stage-2 unmap walker is called
while holding the write lock. A future change to KVM will further relax
the locking mechanics around the stage-2 page tables to allow lock-free
walkers protected only by RCU. As such, switch to the RCU-safe mechanism
for freeing table memory.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 5282cb9ca4cf..cc1af0286755 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -1042,7 +1042,7 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
 					       kvm_granule_size(ctx->level));
 
 	if (childp)
-		mm_ops->put_page(childp);
+		mm_ops->free_removed_table(childp, ctx->level);
 
 	return 0;
 }
-- 
2.41.0.162.gfafddb0af9-goog

