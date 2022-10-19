Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FFE604DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJSQ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiJSQ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:56:47 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B11D066E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:56:35 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id o17-20020a170902d4d100b0018552c4f4bcso6011420plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GscSUgsZGmj923/aia3vL9pbn6x7hvYEHqUbfgDwtc8=;
        b=EEYb/VsMizKiUoFVd4rA6w3z6WaZeZLTGOTALE6KAhnCcBnYhEXMFPjDuNc4rzrZHO
         nUFmb16EjwmVJfqiyDksrVEzabLxWMpScBPXbdJQUDqsH3BYALeiEkgnazdHZ08SDTWm
         pMYzsafuQf6bB0R8JZxi6+3SdTIbQYywOUJJoSeUwfT4C/tI/gURJ7ZZqEljbSEl0pYF
         ofyj11F5quyUEKESmgKhZz+Qz5tsUxfJJ2toI+fr6KON8xxn9hYtHKa3auN/hKaVVo05
         FlFcYetlto1j4ks++Bnrx2snmEGCvmqDASi99sKXlRwH/EXuK7ugvY4BoYkx/gQYd3hz
         eczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GscSUgsZGmj923/aia3vL9pbn6x7hvYEHqUbfgDwtc8=;
        b=4w91cTS5tL1veIwa9KVoViFCVF2WV6NnH9AYnoYXtoIO57eEIrrbH5FR525uRAlJ2I
         Oev5lTTUAw2UpphHygMzDTxS+CXszQeQpaNVq+D7hNDbBcLzXTYZCgfUXLbDd8KedAt6
         gSHYXvPqcI4BlMh/LdM1e191hHCMwfqeEZZjqvyVVp1i4BDf5A9xnd1qMwQ/ZctSJeNB
         H30MANClchp/yLG5d8S2FdpZXiJU3WNMEaJp/uQFug5wMp6gDIvc0B0uDwQEGfSYfgTy
         haWth2NmumpyRtqC8IDZdPiEhNn9zeBxsjYM36i+cYErPcSgb95EiHoKpnCxzQmlWIwJ
         qBbA==
X-Gm-Message-State: ACrzQf1j3OwiqeTR7XP1GwwVoDB/oFVyGp/qdrElk1Twp+cy1qW5aiRG
        dDMf7NhkkUu2FiekCkyMiWq/LS5q4MA=
X-Google-Smtp-Source: AMsMyM6C2OUBHA2Qh+2aXSV1vqJhhOvokoI0sAWn7iB6BoqYVldMoGUB5JUprkgTa0sQ/WOPmjum4FK8ZJk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c986:b0:205:f08c:a82b with SMTP id
 w6-20020a17090ac98600b00205f08ca82bmr2823103pjt.1.1666198594436; Wed, 19 Oct
 2022 09:56:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 19 Oct 2022 16:56:17 +0000
In-Reply-To: <20221019165618.927057-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221019165618.927057-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221019165618.927057-8-seanjc@google.com>
Subject: [PATCH v6 7/8] KVM: x86/mmu: explicitly check nx_hugepage in disallowed_hugepage_adjust()
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
[sean: use spte_to_child_sp(), massage changelog, fold into if-statement]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f4f1b1591a02..14674c9e10f7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3111,7 +3111,8 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
 	if (cur_level > PG_LEVEL_4K &&
 	    cur_level == fault->goal_level &&
 	    is_shadow_present_pte(spte) &&
-	    !is_large_pte(spte)) {
+	    !is_large_pte(spte) &&
+	    spte_to_child_sp(spte)->nx_huge_page_disallowed) {
 		/*
 		 * A small SPTE exists for this pfn, but FNAME(fetch)
 		 * and __direct_map would like to create a large PTE
-- 
2.38.0.413.g74048e4d9e-goog

