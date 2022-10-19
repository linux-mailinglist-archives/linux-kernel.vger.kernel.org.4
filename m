Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FB4604DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiJSQ5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiJSQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:56:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97FA1D0D4F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:56:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y65-20020a25c844000000b006bb773548d5so16649901ybf.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zolBZdZc8YdUGOdwe6gjYM21Hp1u8s0GmGxgf32zoYY=;
        b=aLnzkHpDpkeBNhxgUkhiqgxKHHtY4ZbhvNY3bJhR0ovSRwtOSLtNKKCjvs1PDtXMUm
         eajcWDo93u7FNylqbddyXHZXnxbWOSBdTj4/5V9+IDyPKawo2MPzEFH/OpvcILanRjiD
         gbDCKj3AHS+JtcoCV39QmB0z7cGG7NkGppT/yxeMaseTYyjdsgZAA2RQq/tVesYvGjpA
         5FtfPIyuDpTIF9SAvKoNjSXl7TLkVUpl9hHutCkSkuAGWnBF+aJDh3/BM01cJb17gk4y
         3mBir7X7QBpyDRK+6zPStUPgfESc3jrBc+sa9GIY7ZNLR548FGyXpHKCSd0M3D4cXO4l
         8A9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zolBZdZc8YdUGOdwe6gjYM21Hp1u8s0GmGxgf32zoYY=;
        b=TLQMzEfk+NBpjsiQcVoGe79LyIDM32PdTaKFfSno6qy3uSmVHEiPmZFn8MC/dVklH+
         o5JzRHrVMeJkLj7Zw8c8TaPvRXAwO71VK3j8oMY9S83ZpDUG2tWaBXF9X2FAllFCOJ9q
         NJSVd+JTuskI86+Xm6k36RKxjX4E20bSH4vv6IoGDBrDHLiHK9H6EV1Imjn+rPTqS1ez
         h9WKKvcv02vbtDXsHiIQcIyRlenLZU1wXTDbhDTJTh1+SfAbiGW8fCvfmP1MLjniFyiL
         l0tFpCB6w6QDaCsl/+hVkIwlCR0j7Ub1DGrpFf0iVeJjX3tlLBYhWbMcmWjp1JzCS+kb
         BYXg==
X-Gm-Message-State: ACrzQf0Z0E1hTGrN9gLLK4BgaPPKRMqoBthiJ2BCrlEr19O4njNBYIAV
        kwkN0jrUBs0DoQ5iyls9amRI1A69jQI=
X-Google-Smtp-Source: AMsMyM4mXq3hJcrH4S1pzGhF1Jea+AaKfkF2gY94ctY00u10gPPANQHMA/3aJwt8pnG/FQZedr3joChQcn0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:bfc2:0:b0:6c0:fec7:ae64 with SMTP id
 q2-20020a25bfc2000000b006c0fec7ae64mr6946686ybm.366.1666198596284; Wed, 19
 Oct 2022 09:56:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 19 Oct 2022 16:56:18 +0000
In-Reply-To: <20221019165618.927057-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221019165618.927057-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221019165618.927057-9-seanjc@google.com>
Subject: [PATCH v6 8/8] KVM: x86/mmu: WARN if TDP MMU SP disallows hugepage
 after being zapped
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Ben Gardon <bgardon@google.com>
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

Extend the accounting sanity check in kvm_recover_nx_huge_pages() to the
TDP MMU, i.e. verify that zapping a shadow page unaccounts the disallowed
NX huge page regardless of the MMU type.  Recovery runs while holding
mmu_lock for write and so it should be impossible to get false positives
on the WARN.

Suggested-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 14674c9e10f7..dfd1656232ad 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6864,12 +6864,11 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm)
 				      struct kvm_mmu_page,
 				      possible_nx_huge_page_link);
 		WARN_ON_ONCE(!sp->nx_huge_page_disallowed);
-		if (is_tdp_mmu_page(sp)) {
+		if (is_tdp_mmu_page(sp))
 			flush |= kvm_tdp_mmu_zap_sp(kvm, sp);
-		} else {
+		else
 			kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
-			WARN_ON_ONCE(sp->nx_huge_page_disallowed);
-		}
+		WARN_ON_ONCE(sp->nx_huge_page_disallowed);
 
 		if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
 			kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
-- 
2.38.0.413.g74048e4d9e-goog

