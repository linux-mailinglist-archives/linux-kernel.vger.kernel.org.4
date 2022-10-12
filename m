Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1145FCA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJLSRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJLSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:17:20 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8D145F6E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:17 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j20-20020a056a00235400b00565af23c8c2so1135142pfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UcVvkDQBBHipi7B9bc9w9EXjqJE1fFNcFSTj++h2wVs=;
        b=QkHR2nWKcX4fk382uPwPldcRQqjFRAey2CHttSccJdRNJsDzASiGBLZma3s8fgFwmK
         MPC2y+wVmpuFeM9PgB6jB8hbl+3JliNqQSjdpvYHGZDj2AeAFrWh/dlqtwmDflksZw+8
         zChiYaPDsdA6SyO0YKD4tc/D0n2NdJyGoBXY9ozL8wJzWo7AKgogmmoNLJGKtX75uJid
         YZHjqVB8ZThf0XVWDUjszIJL2WMI8R6gLOnnrB3A9jMbqh2h5VtqprIKbsUEjJAUWns+
         E2y684CDnfAzdbgV7Mug7sVXg/iSOHFHaVDXNovV0gZobyyYa649/V760naGZ/GqaciV
         CTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcVvkDQBBHipi7B9bc9w9EXjqJE1fFNcFSTj++h2wVs=;
        b=4+mfb7t0CScCwliq+H+2E4aeQVrL/LtLas6j1Pp3z+dagGu39IntC53cX6LroV2vl5
         MxJM0/kEd4krqxiHfCWM+xcRc8yiI6y13qezO7IzRRoH955lgpaeWmIHWdLdXxXcEyZs
         8r5/nE/YyVNxXt0wX2bHZMZnqP7dWB4HGi81qBd63Pfrm9IeZDgdTjFxw9nDfNe2cESi
         IUDp9ZxaSDqFUfsYedwiBabFCfv0hOXG8UZZwpE9rtJrBKw7PnLx6dS8INdGlPPFnaIb
         0t1lqsTPy+i1S75nZhDpV4wl26iR4TS05OG7kych5cfLXZxDKXXXRFfna039e9AbYEMp
         vaIg==
X-Gm-Message-State: ACrzQf1RUpQUwdIdc5RuX0n2edevDN/L4Q8ZCRn5DmWcfVgGb7kM1g5P
        N5UEWjEwo0CaLNeze3Nm2sryvdQZ07I=
X-Google-Smtp-Source: AMsMyM6tFuF6KpvADH5ubFcQPbqpoqffWf9m6rAN+DG10+8ZPvAr4c5f85Ii1WQeXWz6bSfoOnmWTNVm+Oc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ba8f:b0:17f:9b1b:6634 with SMTP id
 k15-20020a170902ba8f00b0017f9b1b6634mr31226126pls.171.1665598635998; Wed, 12
 Oct 2022 11:17:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 12 Oct 2022 18:16:56 +0000
In-Reply-To: <20221012181702.3663607-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221012181702.3663607-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221012181702.3663607-6-seanjc@google.com>
Subject: [PATCH v4 05/11] KVM: x86/mmu: Avoid memslot lookup during
 KVM_PFN_ERR_HWPOISON handling
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

From: David Matlack <dmatlack@google.com>

Pass the kvm_page_fault struct down to kvm_handle_error_pfn() to avoid a
memslot lookup when handling KVM_PFN_ERR_HWPOISON. Opportunistically
move the gfn_to_hva_memslot() call and @current down into
kvm_send_hwpoison_signal() to cut down on line lengths.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6417a909181c..07c3f83b3204 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3150,23 +3150,25 @@ static int __direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	return ret;
 }
 
-static void kvm_send_hwpoison_signal(unsigned long address, struct task_struct *tsk)
+static void kvm_send_hwpoison_signal(struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, PAGE_SHIFT, tsk);
+	unsigned long hva = gfn_to_hva_memslot(slot, gfn);
+
+	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva, PAGE_SHIFT, current);
 }
 
-static int kvm_handle_error_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
+static int kvm_handle_error_pfn(struct kvm_page_fault *fault)
 {
 	/*
 	 * Do not cache the mmio info caused by writing the readonly gfn
 	 * into the spte otherwise read access on readonly gfn also can
 	 * caused mmio page fault and treat it as mmio access.
 	 */
-	if (pfn == KVM_PFN_ERR_RO_FAULT)
+	if (fault->pfn == KVM_PFN_ERR_RO_FAULT)
 		return RET_PF_EMULATE;
 
-	if (pfn == KVM_PFN_ERR_HWPOISON) {
-		kvm_send_hwpoison_signal(kvm_vcpu_gfn_to_hva(vcpu, gfn), current);
+	if (fault->pfn == KVM_PFN_ERR_HWPOISON) {
+		kvm_send_hwpoison_signal(fault->slot, fault->gfn);
 		return RET_PF_RETRY;
 	}
 
@@ -4207,7 +4209,7 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		return ret;
 
 	if (unlikely(is_error_pfn(fault->pfn)))
-		return kvm_handle_error_pfn(vcpu, fault->gfn, fault->pfn);
+		return kvm_handle_error_pfn(fault);
 
 	return RET_PF_CONTINUE;
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog

