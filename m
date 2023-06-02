Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D2371F77F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjFBBF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjFBBF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:05:56 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25163F2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:05:55 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b0424c50b8so7352565ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685667954; x=1688259954;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUFFpLyuf1rFekYt+wds5pivPqzR10FQp30bOV5fsBs=;
        b=x0+6ZpmncKnzCLRAhJL8b2WqLjdd3mQWGK52zPIBDBuKLQCx4nGH1XETCfh7WCuGcx
         WysMiyVYz5+jCA/lBjWoqR/8j6sakTh0FMGD3Z+ahpLbDFbGEbUkwFzMgOWbZ10jdeab
         fTlBiVQamGiG2cldcTGWKcrUEl602V60ib5t6lvIZ3OilE0geziJyUAImdFGXdRMAjQ5
         kAsuXP3TYv2Zn67DBHjQcYfH15dmxIeTJK1GRJOYvDhUvtE5OLY5FWmpthGK7IYAHN3O
         qDCdmhDTLH47rKGdEFqwx5q1d1eMuKYpxkSNKfNCM08QwKVTa4xG1azWJZRHbdVqr1ci
         oUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685667954; x=1688259954;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUFFpLyuf1rFekYt+wds5pivPqzR10FQp30bOV5fsBs=;
        b=jj5+oYeQKfSQQ3hAsGOF9CO7MbnqSpfTD9pXfbQ9GWgZSoY99/MtNZQThbR0WXM2MJ
         3nRp7+M+CArJmktQAfewqjUuqyd+YImFAhKKWrMV66S3EF/RwwldGsEqn2ypF5JZBgDD
         JG9gRncXmZnKaDL27hrbrReNdA/k1Jgo7uC55SAGELb+6R6ppkDX4BFJRicia9kraC0Y
         rV8xnYvmkvFHKW5yLehMGcDj/MJDSZd+fOgNqyUfv4IRDM8bmW6Nb0YkZ+WhYr3QgAEC
         XZTzOvoHO3SvL9Va+S5EUi/LhnA91XSszLTk7uKl+fLilI88ebZ9Ml/64mn8dQKMySKc
         MAVg==
X-Gm-Message-State: AC+VfDyppo3+VchsP5X+lM9Uh9Z/nqbswkgbm4dP4SkfZD7UjGDJBAL1
        iFVCSPsVzdhCk7WdbpRa9O5Iyny7d+U=
X-Google-Smtp-Source: ACHHUZ7HXwVi3roScoGcy8JdnhKS7Ac2H0bBjNeQZqp5S7NWiVIrEyoL9H78FiG4shCVW8p2+m5ITDjmSGo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:22c9:b0:1b1:7336:2654 with SMTP id
 y9-20020a17090322c900b001b173362654mr247247plg.11.1685667954653; Thu, 01 Jun
 2023 18:05:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Jun 2023 18:05:50 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602010550.785722-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Use cpu_feature_enabled() for PKU instead of #ifdef
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jon Kohler <jon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace an #ifdef on CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS with a
cpu_feature_enabled() check on X86_FEATURE_PKU.  The macro magic of
DISABLED_MASK_BIT_SET() means that cpu_feature_enabled() provides the
same end result (no code generated) when PKU is disabled by Kconfig.

No functional change intended.

Cc: Jon Kohler <jon@nutanix.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ceb7c5e9cf9e..eed1f0629023 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1017,13 +1017,11 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
 			wrmsrl(MSR_IA32_XSS, vcpu->arch.ia32_xss);
 	}
 
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-	if (static_cpu_has(X86_FEATURE_PKU) &&
+	if (cpu_feature_enabled(X86_FEATURE_PKU) &&
 	    vcpu->arch.pkru != vcpu->arch.host_pkru &&
 	    ((vcpu->arch.xcr0 & XFEATURE_MASK_PKRU) ||
 	     kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE)))
 		write_pkru(vcpu->arch.pkru);
-#endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 }
 EXPORT_SYMBOL_GPL(kvm_load_guest_xsave_state);
 
@@ -1032,15 +1030,13 @@ void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.guest_state_protected)
 		return;
 
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-	if (static_cpu_has(X86_FEATURE_PKU) &&
+	if (cpu_feature_enabled(X86_FEATURE_PKU) &&
 	    ((vcpu->arch.xcr0 & XFEATURE_MASK_PKRU) ||
 	     kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE))) {
 		vcpu->arch.pkru = rdpkru();
 		if (vcpu->arch.pkru != vcpu->arch.host_pkru)
 			write_pkru(vcpu->arch.host_pkru);
 	}
-#endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 
 	if (kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE)) {
 

base-commit: a053a0e4a9f8c52f3acf8a9d2520c4bf39077a7e
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

