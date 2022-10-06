Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E655F5D76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJFADg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJFADY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:03:24 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB61186820
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:03:23 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id q3-20020a17090311c300b0017898180dddso142534plh.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QqkTsotquztSOhKCsGxZ7jnMJ1Q4/SxQ9WGAiQ1iUM4=;
        b=VltPshIZbtjK6IQgaxvnmemzbjNs/4JCfY+W4Mo3ZlbMjHQuYb4eKA2UrXPOjZtST3
         yL+tKIjdh5Yy0BhH+uiyehGydzHKC6RnFth6N3qoi1UcFzeSY3bZiLcLcCbzjoOD77yX
         ahawA7j+QuYh38QO2nSkBXQPEtnJIO3LDHgudJzE5RelpK5wRfP7J8ce05VO7kxKuLOd
         x1mxp4QHtad1xLi6OsoIxKg1v8BUCdXHyzpt/4UE31Y7PiEMDYA5N+V++ZoCQUYhZrEH
         bnGk6dlCiqX/cy1CNN6x7KpHLa70f16MphBduRav+N9KHNueytrrKGjTRnYA4zZoRBXs
         c/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqkTsotquztSOhKCsGxZ7jnMJ1Q4/SxQ9WGAiQ1iUM4=;
        b=07n8c5n6KKO2XLd85M+EqFqaViXrmKVucDQf4jt6hCVdyRR0iWvAmlmfyt0Ek8NUla
         JU57eVklUvzPSYYb4tcEoOSjZzweCFnbTp2Cn82BMO2/vxY95SPBdxSzTa6YkfhzTDfq
         yXN3Km6lx1luOQIF3WJcqg6rD84R98BksrBgACkzDXyh/eE52ESh1oB/XHPFM0001dEh
         j+xSt6qfRI/CAeXtpmJQv611SS2Rvr3iZhM74P9dBF5WckRe9m2w2c5T+PVC5ORoF6pO
         7WEoPaBhI+GFtTU/xxnW0FBcJMSIypKIPv1oUsGn82eBpLw5JnOpP54/yDMu9aHVUvzj
         o4SA==
X-Gm-Message-State: ACrzQf37GRBkzfshdL5dTcjvvtxffC/SOfScuYqfIsNhw857P5h+Pp8o
        BTTLm4gLh3RE0IqjkCD6423UKvTEXbA=
X-Google-Smtp-Source: AMsMyM5oLSMANpLQHpKw/HhjgHATYwn9XSrmp+P17cUSX7wQwWAdEe7Cv7AzuAqabzuS9ywPvyZx5XMwynU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1503:b0:546:833c:ed05 with SMTP id
 q3-20020a056a00150300b00546833ced05mr2299761pfu.44.1665014602996; Wed, 05 Oct
 2022 17:03:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:03:09 +0000
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006000314.73240-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006000314.73240-4-seanjc@google.com>
Subject: [PATCH v5 3/8] KVM: VMX: Fold vmx_supported_debugctl() into vcpu_supported_debugctl()
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
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

Fold vmx_supported_debugctl() into vcpu_supported_debugctl(), its only
caller.  Setting bits only to clear them a few instructions later is
rather silly, and splitting the logic makes things seem more complicated
than they actually are.

Opportunistically drop DEBUGCTLMSR_LBR_MASK now that there's a single
reference to the pair of bits.  The extra layer of indirection provides
no meaningful value and makes it unnecessarily tedious to understand
what KVM is doing.

No functional change.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/capabilities.h | 15 ---------------
 arch/x86/kvm/vmx/vmx.c          | 12 +++++++-----
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index a6689bf06542..479124e49bbd 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -24,8 +24,6 @@ extern int __read_mostly pt_mode;
 #define PMU_CAP_FW_WRITES	(1ULL << 13)
 #define PMU_CAP_LBR_FMT		0x3f
 
-#define DEBUGCTLMSR_LBR_MASK		(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI)
-
 struct nested_vmx_msrs {
 	/*
 	 * We only store the "true" versions of the VMX capability MSRs. We
@@ -422,19 +420,6 @@ static inline u64 vmx_get_perf_capabilities(void)
 	return perf_cap;
 }
 
-static inline u64 vmx_supported_debugctl(void)
-{
-	u64 debugctl = 0;
-
-	if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
-		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
-
-	if (vmx_get_perf_capabilities() & PMU_CAP_LBR_FMT)
-		debugctl |= DEBUGCTLMSR_LBR_MASK;
-
-	return debugctl;
-}
-
 static inline bool cpu_has_notify_vmexit(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9dba04b6b019..97fc873c37fa 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2023,13 +2023,15 @@ static u64 nested_vmx_truncate_sysenter_addr(struct kvm_vcpu *vcpu,
 
 static u64 vcpu_supported_debugctl(struct kvm_vcpu *vcpu)
 {
-	u64 debugctl = vmx_supported_debugctl();
+	u64 debugctl = 0;
 
-	if (!intel_pmu_lbr_is_enabled(vcpu))
-		debugctl &= ~DEBUGCTLMSR_LBR_MASK;
+	if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) &&
+	    guest_cpuid_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
+		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
 
-	if (!guest_cpuid_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
-		debugctl &= ~DEBUGCTLMSR_BUS_LOCK_DETECT;
+	if ((vmx_get_perf_capabilities() & PMU_CAP_LBR_FMT) &&
+	    intel_pmu_lbr_is_enabled(vcpu))
+		debugctl |= DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
 	return debugctl;
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog

