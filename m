Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2789C5F16E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiI3Xt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiI3XtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:49:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF17A1A88C5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:49:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id x23-20020a634857000000b0043c700f6441so3661553pgk.21
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=P6j0rbGAvi4nbiHtlbtCumR9M0TyW9iEXbtYLEfrO3k=;
        b=Pjve0sHGQTuOxAex1GQ4futLlOhLAhOTSVOHLqdAvaSa+VeeDc8hlAmWV4B+NZWTxM
         qJzcX4LK9hJmVyMdi04Nap4WvnhJStE+PMCnNW+K2rhmbT3kPJKW0FLok5j6t8L7sTbB
         11rQtLjUFofbvQp75ieQwOt3Pt2LRmuu/P70WRRvEVxGmouQnwRmBbcHQJZlUEoeydVC
         pM+TGvezZtY/g8zZdFTjl795/5QWPlIGqPHofUgo+eqQ7MW8xcUr5V7diqSmOmQaXOAL
         QR571kFlUnVwD8ceTmiSqNPwSYwwuJy/jCsgfXEzWf2j8c9F3hFwPrPFW7yIw2JOuNgb
         tfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=P6j0rbGAvi4nbiHtlbtCumR9M0TyW9iEXbtYLEfrO3k=;
        b=3NH9Stx4LVIFXisoAhyg2OG6t8ZJASho75j91+0WZ8/cS8UgJyJ8Q+npsTbGMKEUQ7
         pYt0KTy+eANO/Wypv0Z84QEaFOywOluvy8QsfK8LmYkRKWLwbghuZIe69JdE5pi2zw41
         DyiNW9X3Z17r7T2nbeyfEHNv9TdOKjDwClMk2YGtmF9Y/1l/vm+UM+eSINzsIFWIzpAa
         2wt264NnrublqEF04Tdm54naXVrZHrBdWOm0arZsbWI0GX6Ao8cGaqFWEcu4mUx3PwaC
         I6/Vcbnl0k6RY7RntwqgUaRfkyLG3f1ho89bGjUoCcNU9aFHf2gtKmFlV8aTHNLEiHZg
         ijNQ==
X-Gm-Message-State: ACrzQf2FziQbeo3de8rTZ27TvsPrKMPawQdADduXzxO0NaeaoAvKdYw+
        X5TdAgjv3n40JQRYAQb3rp+09HaSdUs=
X-Google-Smtp-Source: AMsMyM6YIWd8wJdQWWCIDEAA4YK+32mD0DI1+SSNAPHjJx3EqhIntv3fj1R3Ty9o3Gu/sOuuY0wX97ss+cI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a83:b0:54a:e52e:9472 with SMTP id
 b3-20020a056a000a8300b0054ae52e9472mr11480267pfl.50.1664581749286; Fri, 30
 Sep 2022 16:49:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 30 Sep 2022 23:48:54 +0000
In-Reply-To: <20220930234854.1739690-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220930234854.1739690-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930234854.1739690-8-seanjc@google.com>
Subject: [PATCH v5 7/7] KVM: x86/mmu: explicitly check nx_hugepage in disallowed_hugepage_adjust()
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mingwei Zhang <mizhang@google.com>

Explicitly check if a NX huge page is disallowed when determining if a
page fault needs to be forced to use a smaller sized page.  KVM currently
assumes that the NX huge page mitigation is the only scenario where KVM
will force a shadow page instead of a huge page, and so unnecessarily
keeps an existing shadow page instead of replacing it with a huge page.

Any scenario that causes KVM to zap leaf SPTEs may result in having a SP
that can be made huge without violating the NX huge page mitigation.
E.g. prior to commit 5ba7c4c6d1c7 ("KVM: x86/MMU: Zap non-leaf SPTEs when
disabling dirty logging"), KVM would keep shadow pages after disabling
dirty logging due to a live migration being canceled, resulting in
degraded performance due to running with 4kb pages instead of huge pages.

Although the dirty logging case is "fixed", that fix is coincidental,
i.e. is an implementation detail, and there are other scenarios where KVM
will zap leaf SPTEs.  E.g. zapping leaf SPTEs in response to a host page
migration (mmu_notifier invalidation) to create a huge page would yield a
similar result; KVM would see the shadow-present non-leaf SPTE and assume
a huge page is disallowed.

Fixes: b8e8c8303ff2 ("kvm: mmu: ITLB_MULTIHIT mitigation")
Reviewed-by: Ben Gardon <bgardon@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: use spte_to_child_sp(), massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 54005b7f1499..688beed3a41e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3110,6 +3110,11 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
 	    cur_level == fault->goal_level &&
 	    is_shadow_present_pte(spte) &&
 	    !is_large_pte(spte)) {
+		u64 page_mask;
+
+		if (!spte_to_child_sp(spte)->nx_huge_page_disallowed)
+			return;
+
 		/*
 		 * A small SPTE exists for this pfn, but FNAME(fetch)
 		 * and __direct_map would like to create a large PTE
@@ -3117,8 +3122,8 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
 		 * patching back for them into pfn the next 9 bits of
 		 * the address.
 		 */
-		u64 page_mask = KVM_PAGES_PER_HPAGE(cur_level) -
-				KVM_PAGES_PER_HPAGE(cur_level - 1);
+		page_mask = KVM_PAGES_PER_HPAGE(cur_level) -
+			    KVM_PAGES_PER_HPAGE(cur_level - 1);
 		fault->pfn |= fault->gfn & page_mask;
 		fault->goal_level--;
 	}
-- 
2.38.0.rc1.362.ged0d419d3c-goog

