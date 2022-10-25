Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A457960CF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiJYOw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiJYOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:52:08 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B394719E01F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:52:06 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id c9-20020a05640227c900b0045d4a88c750so11958092ede.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iW7y1fLgpkJui3hvQxzLoNSX4KE+fgXa0IU1VCGorq8=;
        b=qJakZ6WY7j9J9m8Y0t0mKscdKtWoQFQZx/SlIwtmdVidxM8A5xf050QT9Ki74jQrL1
         I1jtlS5bPffVifc9+0ncXh2wwwFOzVaq6063eYqf/v/Pl2+CjzJRqU13Oz7kC4XO9shq
         rk7e1jP74dU+C6IgUOoa4PVz3g4RhXXyTqm6wsiEhNC7ZVMmHNQhgmULb6ksYf93T5Pq
         Hz1ccacdzLT7No3GpTOIBgRj9eUiZYuKalDOV91XpIhsNHChn2V7IF28NwUwvxVpR7ps
         7iqals/Wlf90wOzqbZc+9XGB9AKrzHp5iU5dKE+mCdqT+LlsVAHopgFQJUCQmhrKOdkS
         ENcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iW7y1fLgpkJui3hvQxzLoNSX4KE+fgXa0IU1VCGorq8=;
        b=TyxYtKzsodw0KpfWXV6VTULRHGKlxTO7M2hc9j2ucSkJbJ/ibPlFyRI/+4313B0TIU
         cAT8tne7kSZt8C4XelxQMNr4Uke9I+O45kK8rWpvOj9fOawjLj1Dx/Lknwz2itHvtbMD
         oUA86V7bgmSGiSXl9RFNwLzKnjb5vHEKBL+oe8TQU7x7LoghGMoG/du0fI/xC76h4j9n
         g1UDsSSbzwr7EpUUcro0t/Jrv+4Npd3+WJN1XgZt+6QTMDywoFxgeWLRaUf4R2HkBpjY
         TbS2F2pG81s+8/y7m3hUPXKQSJ9rQ5gBU822WW/lMN+xYoqmAYkn1g84nn5jMIqPLTju
         sBUA==
X-Gm-Message-State: ACrzQf2VrxRkiyZ3q9ZtX7xVV0hjmV6dUqRe9ECu/pSr0TYi6UtkRgMk
        3wweJvvjqZtsaL83gNcM/gy3YczytpXY
X-Google-Smtp-Source: AMsMyM4BGDxK+RsryB8gWtAc8z+lfBDtIE7P/25DUQWrqxjJtocSP2UPxVASx3qt+ngO9qDF5OIYpYiVN++A
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a05:6402:d06:b0:45a:3ac6:ad26 with SMTP id
 eb6-20020a0564020d0600b0045a3ac6ad26mr36497510edb.195.1666709525134; Tue, 25
 Oct 2022 07:52:05 -0700 (PDT)
Date:   Tue, 25 Oct 2022 14:51:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221025145156.855308-1-qperret@google.com>
Subject: [PATCH] KVM: arm64: Use correct accessor to parse stage-1 PTEs
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
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

hyp_get_page_state() is used with pKVM to retrieve metadata about a page
by parsing a hypervisor stage-1 PTE. However, it incorrectly uses a
helper which parses *stage-2* mappings. Ouch.

Luckily, pkvm_getstate() only looks at the software bits, which happen
to be in the same place for stage-1 and stage-2 PTEs, and this all ends
up working correctly by accident. But clearly, we should do better.

Fix hyp_get_page_state() to use the correct helper.

Fixes: e82edcc75c4e ("KVM: arm64: Implement do_share() helper for sharing memory")
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 1e78acf9662e..07f9dc9848ef 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -516,7 +516,7 @@ static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte)
 	if (!kvm_pte_valid(pte))
 		return PKVM_NOPAGE;
 
-	return pkvm_getstate(kvm_pgtable_stage2_pte_prot(pte));
+	return pkvm_getstate(kvm_pgtable_hyp_pte_prot(pte));
 }
 
 static int __hyp_check_page_state_range(u64 addr, u64 size,
-- 
2.38.0.135.g90850a2211-goog

