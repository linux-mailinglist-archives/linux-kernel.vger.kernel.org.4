Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C64E6B56F4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCKAqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCKAq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:46:27 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6668C139D10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:26 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id iy17-20020a170903131100b0019ce046d8f3so3681183plb.23
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678495586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UCsKlBygaljo69pUMHBC7qjxT0Bam71YbVnLW7zzuTY=;
        b=bopgSxhYe35UHp/rSiq09olTYF29A1imC6FArKNKFxhlP0K0N0lZ6PLoQ965s5g5Rt
         NVCHCqPnHGytA8ygpHPGELSoVIp9ofpPVlaUF8GAUXZTHX1yB92x3JO++ljLO35kbtVz
         rDQ+LNBkzoyarhZecu2C5j5b9GblnHruxlaZU45g+YyY1q63393HbLRSsKxv/bdhth8D
         i20oGCke767wvQVjjkPHusCU10BkLI2SISNDtkhVDhbsVaA/Oiy6DHfvoE3qcAEdY24M
         BTGeCxij4o+iNPUCnrCJCqjPtr7fWle3vrLWZiVDTgmi56LSrvUElX2/IvgwFu5nnaUO
         CtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCsKlBygaljo69pUMHBC7qjxT0Bam71YbVnLW7zzuTY=;
        b=LtmlgoCYVFoZyuC2UpSoM01QMNamQ7RkntYKgoOPUjHng5toSsV5PgxeLJ41DKf4Vj
         xuySgU/1FaGVXWnPkWuzb1jECxEoD2obC/LSRicxewVQoz16CeFUZ6ryYKqkSpGHTyBW
         HHVI0AXHCTL5uGJRtaDB2XafcfKKBYmKZlHVz6cu40fGYgx6B0puUGHMiYDQM0lXcx8r
         cUp3qxz9WNYXrE8A/EjOBIByg1CwoJ0TuOWokwVHfaXGnTnlSztU/5zTbDOmPQg/me56
         CCaQ90L3TdT5y9hHJbwvyzZOLoMIjZWtspFSiMdn2T5Q7w5Ji8tjJpGu/fbrDtBTVWVj
         PToA==
X-Gm-Message-State: AO0yUKUV5+sdg4eOtYwlr8XYZHJpGkT86zHVFcX+/KvtFb34CUODNRbA
        +KeQDYrCUMZlp6KhBt3kif7oFKM4F68=
X-Google-Smtp-Source: AK7set99ZSXAcHXf00oP45I5uaEIdA6QUlelD/iSNJsNSlIOwPxUisVvKHaY+mfZM1joKZnzP/vR49Q3MdA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:dd86:b0:233:be3d:8a42 with SMTP id
 l6-20020a17090add8600b00233be3d8a42mr10052365pjv.0.1678495585934; Fri, 10 Mar
 2023 16:46:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:45:59 -0800
In-Reply-To: <20230311004618.920745-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311004618.920745-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311004618.920745-3-seanjc@google.com>
Subject: [PATCH v3 02/21] KVM: x86: Add a helper to query whether or not a
 vCPU has ever run
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
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

Add a helper to query if a vCPU has run so that KVM doesn't have to open
code the check on last_vmentry_cpu being set to a magic value.

No functional change intended.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Like Xu <like.xu.linux@gmail.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
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
index c8ebe542c565..e5a6d785d77a 100644
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
2.40.0.rc1.284.g88254d51c5-goog

