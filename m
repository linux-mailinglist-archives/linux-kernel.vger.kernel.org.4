Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB9691574
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBJAcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjBJAb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:31:56 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88CE1817E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:31:54 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id b5-20020a170902d50500b00198f3be5233so2112382plg.16
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GMrgZXh8eRXUUybNQrnQTy6sLOXQO4H5b5tUEnbNKec=;
        b=oyw0c2cuopZVKbsk7SgDz1IYza0BOCd+ulMvdJ8xEjdGMuT/jqffPe5ewUsajChM75
         o8PjURT5214HgqCI7j7vp14jw0Ad6mHw403ZTcTfLxy8th+VCdeljjaad9z/sXp6btAv
         Ezflm0koCwysFQIjB8wNz7tb/P4486eh4tDgKMwDN+48+ShexTXTmQsc9l0BkWoZGJaM
         9qjzhxPj3GcB+C1ycykOtd/bQCV+Qkka+SAbWCb2veOu4EmPKTYrNqTSf7SdhqrskGg+
         QvqNpH2Tvh6x8nMwDg8Z11SjW1GK10whZH5VZ3Gnr2IzC/7CYwUqbx8rJn9HHe0l07Fg
         ezPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMrgZXh8eRXUUybNQrnQTy6sLOXQO4H5b5tUEnbNKec=;
        b=GX5vneono4lkt1JtOdAAKBKqbHNFQNZfxtes9yTwm5IwV34qvGeekzPolqp2N6Wyfm
         anrMIKcylQ0WLAM99BOA9Z1J79HbMJbRunzPzIEyFoZ+Pe9jy3jMXTaChNK8N4qeOo8r
         eUo6ojjTaCULnGUi2VZJ04SMUz64i+v3OeOqFHq3WEpUthi9Bhl5SQvV+mUlAYiegnV/
         7pP51gTSgzETK3TvaSASc/PEwHrlTEQcyB96JNWBXwp6GOWmgCcuyJpJT/my5k793yLM
         LkAhn60sX4/IgMxSCT2UzZLf78myGrsyeR3x+PrMkuaxo4e21ba/99XzZNAghV2sKvIC
         tVoA==
X-Gm-Message-State: AO0yUKXEt40Mk5ZlHlHqyVpYFuc7Ixu1ImJ3Hic+WmfdLsNa4D3a3POE
        xxNsWpEnRnpK1WD257lfo6QM8+tBHH4=
X-Google-Smtp-Source: AK7set+R3ZE3dE85d/8UU+a1nJGJCmgsfDudhKwHpUe86fe8CzvUZFNpjT21c/NDLZS8xbqB0ulFG5tAdro=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:db05:b0:199:4e77:7fae with SMTP id
 m5-20020a170902db0500b001994e777faemr1708398plx.2.1675989114447; Thu, 09 Feb
 2023 16:31:54 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Feb 2023 00:31:29 +0000
In-Reply-To: <20230210003148.2646712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210003148.2646712-3-seanjc@google.com>
Subject: [PATCH v2 02/21] KVM: x86: Add a helper to query whether or not a
 vCPU has ever run
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>
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

Add a helper to query if a vCPU has run so that KVM doesn't have to open
code the check on last_vmentry_cpu being set to a magic value.

No functional change intended.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c   | 2 +-
 arch/x86/kvm/mmu/mmu.c | 2 +-
 arch/x86/kvm/x86.h     | 5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8f8edeaf8177..448d627ce891 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -420,7 +420,7 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 	 * KVM_SET_CPUID{,2} again. To support this legacy behavior, check
 	 * whether the supplied CPUID data is equal to what's already set.
 	 */
-	if (vcpu->arch.last_vmentry_cpu != -1) {
+	if (kvm_vcpu_has_run(vcpu)) {
 		r = kvm_cpuid_check_equal(vcpu, e2, nent);
 		if (r)
 			return r;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c91ee2927dd7..b0693195273b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5393,7 +5393,7 @@ void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * Changing guest CPUID after KVM_RUN is forbidden, see the comment in
 	 * kvm_arch_vcpu_ioctl().
 	 */
-	KVM_BUG_ON(vcpu->arch.last_vmentry_cpu != -1, vcpu->kvm);
+	KVM_BUG_ON(kvm_vcpu_has_run(vcpu), vcpu->kvm);
 }
 
 void kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index a8167b47b8c8..754190af1791 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -83,6 +83,11 @@ static inline unsigned int __shrink_ple_window(unsigned int val,
 void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu);
 int kvm_check_nested_events(struct kvm_vcpu *vcpu);
 
+static inline bool kvm_vcpu_has_run(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.last_vmentry_cpu != -1;
+}
+
 static inline bool kvm_is_exception_pending(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.exception.pending ||
-- 
2.39.1.581.gbfd45094c4-goog

