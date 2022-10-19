Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB66604DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiJSQ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJSQ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:56:29 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915AC1C711F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:56:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f186-20020a636ac3000000b0044adaa7d347so9955121pgc.14
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gy24ztDzsu2pVLCZMStQCiAA6/olN6OB6IFeEvw2nwc=;
        b=RkT5JmVHOx1xLJuKyPUTQ/GHWwPLL/Ofaa9fMFcWafnho5RGXPgWMJuq6JtFQIVRU5
         3MTRHaV+92xzf++NNAnl+DR9b5UgIZvfci41IYKi7CDUqVB2+NLKldXiZn18g62Ly3eN
         GP5xfcS2y6ft5gvqGdsKQufjnDmEap6e+Ggqnq1KWQ1ZMLIDN/eNajNku93QRdQyQSGg
         cXnlJOFm94o6frDwyz1i/mRrPIKOOgCJ3heiRrvlB8tXVHnRqxX8wwG5+Mf53qjVtc8D
         i/CqLQ/EdC68sMeiadZQajE7mvYEdOHQmt2H8C20u9lUD8opffszIpqLdrdMCs9Gvj+9
         isNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gy24ztDzsu2pVLCZMStQCiAA6/olN6OB6IFeEvw2nwc=;
        b=eAfb4B3GN0Hke9gaRQ8rqb1/XR02p2zfyfkdTps1Oz91Pm7D+OpKQDHzd3DKs4g61t
         9/QNTKQ064KajGfvRPAWznT/C2eREuE+UHFfMRvQE/A6zSmSmR9UikOVpfY5N2T7DLHl
         cIdzJ5KVZhMNRBW8B4X4SGFw8/ETq2kTmG8Jm640cGrNYihUODl2hbdLezTV6AbgmuUu
         Qecb3oN8lVjG9UAEwsS92mKbTEj6Ed+QE02vnbWqi4DsMSm88QfYVp5vio/eObIOGFfe
         CwUsJHVL5NqG2PL5DoqZCl0GpgbMD++P0aBvvC9V4f5P0ZvriwBP/JA2X5EFePGzASpK
         lH8g==
X-Gm-Message-State: ACrzQf2DoKkIYc32nOdGMYNaQgHDSvW7EsBKbU5Xadt/o5W+CWuBlZOu
        slPMo1pl61B5GJu+Iz1J04V/AeMVU+0=
X-Google-Smtp-Source: AMsMyM7z+/HoT4H7P+QTJw0UCU7RU2z3T7Pf6h3t9Z69xlXBk9B/YfAGWls9cWCXFmfCrFwseqxLeAzoXxI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f78a:b0:184:f2e2:a5fa with SMTP id
 q10-20020a170902f78a00b00184f2e2a5famr9560092pln.161.1666198587158; Wed, 19
 Oct 2022 09:56:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 19 Oct 2022 16:56:13 +0000
In-Reply-To: <20221019165618.927057-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221019165618.927057-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221019165618.927057-4-seanjc@google.com>
Subject: [PATCH v6 3/8] KVM: x86/mmu: Properly account NX huge page workaround
 for nonpaging MMUs
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

Account and track NX huge pages for nonpaging MMUs so that a future
enhancement to precisely check if a shadow page can't be replaced by a NX
huge page doesn't get false positives.  Without correct tracking, KVM can
get stuck in a loop if an instruction is fetching and writing data on the
same huge page, e.g. KVM installs a small executable page on the fetch
fault, replaces it with an NX huge page on the write fault, and faults
again on the fetch.

Alternatively, and perhaps ideally, KVM would simply not enforce the
workaround for nonpaging MMUs.  The guest has no page tables to abuse
and KVM is guaranteed to switch to a different MMU on CR0.PG being
toggled so there's no security or performance concerns.  However, getting
make_spte() to play nice now and in the future is unnecessarily complex.

In the current code base, make_spte() can enforce the mitigation if TDP
is enabled or the MMU is indirect, but make_spte() may not always have a
vCPU/MMU to work with, e.g. if KVM were to support in-line huge page
promotion when disabling dirty logging.

Without a vCPU/MMU, KVM could either pass in the correct information
and/or derive it from the shadow page, but the former is ugly and the
latter subtly non-trivial due to the possibility of direct shadow pages
in indirect MMUs.  Given that using shadow paging with an unpaged guest
is far from top priority _and_ has been subjected to the workaround since
its inception, keep it simple and just fix the accounting glitch.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/mmu/mmu.c  |  2 +-
 arch/x86/kvm/mmu/spte.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5dd98cdc5283..99086a684dd2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3143,7 +3143,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 			continue;
 
 		link_shadow_page(vcpu, it.sptep, sp);
-		if (fault->is_tdp && fault->huge_page_disallowed)
+		if (fault->huge_page_disallowed)
 			account_nx_huge_page(vcpu->kvm, sp,
 					     fault->req_level >= it.level);
 	}
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 2e08b2a45361..c0fd7e049b4e 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -161,6 +161,18 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	if (!prefetch)
 		spte |= spte_shadow_accessed_mask(spte);
 
+	/*
+	 * For simplicity, enforce the NX huge page mitigation even if not
+	 * strictly necessary.  KVM could ignore the mitigation if paging is
+	 * disabled in the guest, as the guest doesn't have an page tables to
+	 * abuse.  But to safely ignore the mitigation, KVM would have to
+	 * ensure a new MMU is loaded (or all shadow pages zapped) when CR0.PG
+	 * is toggled on, and that's a net negative for performance when TDP is
+	 * enabled.  When TDP is disabled, KVM will always switch to a new MMU
+	 * when CR0.PG is toggled, but leveraging that to ignore the mitigation
+	 * would tie make_spte() further to vCPU/MMU state, and add complexity
+	 * just to optimize a mode that is anything but performance critical.
+	 */
 	if (level > PG_LEVEL_4K && (pte_access & ACC_EXEC_MASK) &&
 	    is_nx_huge_page_enabled(vcpu->kvm)) {
 		pte_access &= ~ACC_EXEC_MASK;
-- 
2.38.0.413.g74048e4d9e-goog

