Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4FF5FCA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJLSR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJLSRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:17:35 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5C74DC8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:21 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y15-20020aa78f2f000000b00562674456afso9227305pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iyX7m6ZRNZlr207DNB9Z4rPKTDQz+P1dKMcokiI8RMw=;
        b=dC6BDjbSgC/mF0qaOjJetXhcy1TYDU0SUaizDMBnGuRPt/Fqu3XnBcriNNLmfUaF8A
         jHJWE+50+BKwWoAUEFKfPs7JX+LiontYRkUNgYu2lWEjoD/A7I1JZ1btPTHnQxm+BQBD
         XJRPLFpPKaiJB858dnI1+kR+okEwz+0Jb+b+n+WN74PapBfCSuF38Uw+ZhRzz/frm0Cb
         CApPtaWK00kbu0aCeQZRVUniej6ZcoPk3IkoTKMH2KIaQvRsvJPd3B4s3MQRrzhb473V
         ++Ul2fQwyVoawNPjxzqc2i4kqS1ID4adt0Gw318+WHr6icbpw9/C9s6y6WNQalVwvqpM
         lRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyX7m6ZRNZlr207DNB9Z4rPKTDQz+P1dKMcokiI8RMw=;
        b=jOvb9o79Kkqh5vCYWsK1XpU3oDfBG3aRoj8bWdEry5ZS/iYsoNm5jivBTfgCRW8+rK
         r45P7bG2rLWaKphhIler3eg129x81+iEFJIfEo+SMNAmXNu47iGJsTZ/6A0feLbyydmy
         abKqCMg79aV74EjLAsp6FMdYeainXn36aFljy63ZxINjw/Og5UibLhnJZFOCF9xvKU5k
         5A8tf12bHthLDZFqACROlnFnNkvJ0dzhemRuYHOBeMbt0I+alQeDrmaG0W5XcOyb2yZc
         nG7gj5H6kO8SfvYQNexxytBA67qDC9U7s6aBPSPO07dkhtoAtOU3URAFUZtEdmnW3loe
         yutg==
X-Gm-Message-State: ACrzQf0EVq3rUbyljB51MnUnHq0b7gZ/drTcWylEXuf0ncuNNmENucLg
        tFfegjX8ynSMvEvxVeS+pYVOg5pIIcw=
X-Google-Smtp-Source: AMsMyM4lEwUUMdCeCnx7mAlaFt4RogEpGNjpcS+QFSvdr1Yi+YI0AfEFIvaH9uUZneNKjtU2x9asckXEOHs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:4d4:b0:17f:7ecc:88e3 with SMTP id
 jm20-20020a17090304d400b0017f7ecc88e3mr29589224plb.169.1665598639452; Wed, 12
 Oct 2022 11:17:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 12 Oct 2022 18:16:58 +0000
In-Reply-To: <20221012181702.3663607-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221012181702.3663607-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221012181702.3663607-8-seanjc@google.com>
Subject: [PATCH v4 07/11] KVM: x86/mmu: Pivot on "TDP MMU enabled" when
 handling direct page faults
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>
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

When handling direct page faults, pivot on the TDP MMU being globally
enabled instead of checking if the target MMU is a TDP MMU.  Now that the
TDP MMU is all-or-nothing, if the TDP MMU is enabled, KVM will reach
direct_page_fault() if and only if the MMU is a TDP MMU.  When TDP is
enabled (obviously required for the TDP MMU), only non-nested TDP page
faults reach direct_page_fault(), i.e. nonpaging MMUs are impossible, as
NPT requires paging to be enabled and EPT faults use ept_page_fault().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5710be4d328b..fe3aa890a487 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3324,7 +3324,7 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	do {
 		u64 new_spte;
 
-		if (is_tdp_mmu(vcpu->arch.mmu))
+		if (is_tdp_mmu_enabled())
 			sptep = kvm_tdp_mmu_fast_pf_get_last_sptep(vcpu, fault->addr, &spte);
 		else
 			sptep = fast_pf_get_last_sptep(vcpu, fault->addr, &spte);
@@ -4252,7 +4252,6 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 
 static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
-	bool is_tdp_mmu_fault = is_tdp_mmu(vcpu->arch.mmu);
 	int r;
 
 	fault->gfn = fault->addr >> PAGE_SHIFT;
@@ -4275,7 +4274,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 	r = RET_PF_RETRY;
 
-	if (is_tdp_mmu_fault)
+	if (is_tdp_mmu_enabled())
 		read_lock(&vcpu->kvm->mmu_lock);
 	else
 		write_lock(&vcpu->kvm->mmu_lock);
@@ -4287,13 +4286,13 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	if (r)
 		goto out_unlock;
 
-	if (is_tdp_mmu_fault)
+	if (is_tdp_mmu_enabled())
 		r = kvm_tdp_mmu_map(vcpu, fault);
 	else
 		r = __direct_map(vcpu, fault);
 
 out_unlock:
-	if (is_tdp_mmu_fault)
+	if (is_tdp_mmu_enabled())
 		read_unlock(&vcpu->kvm->mmu_lock);
 	else
 		write_unlock(&vcpu->kvm->mmu_lock);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

