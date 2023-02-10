Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12569157B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjBJAc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjBJAcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:32:16 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB495CBF3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:32:02 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id x3-20020a654143000000b004f2f2dafb21so1760547pgp.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qEyz/D/GwawmEFE6mKfSBe68GjnRayQfCebOkuONNBw=;
        b=keO5G55ZMsL2Z8lWgVdrwBdDX+uSCcf60tBA/h0bLFRFunQ5U8VPjAPDzH6pZORQWk
         nFQ43s7XYMOcxFPfMOg3Xlj5CCK96SCu9/R6aCyl0Tutl6y55A7r4BGMFVSaBcWI1POs
         A5azzTnHL/yjeNxWOjKh+hIu+eN4pZ9OrmUhNxyVeT7+aoSp5MdiX3CAIx+MP33eLvqj
         SKRAXmxKQbst1gty7eyX6ljXkIK+d1fVdqpcHC5Kj9TccjqvRPaN37oj0mxo0d+CAW1b
         +BJ5S4PwpjQn7P3pHtGLmZKEPafI+rpLBqKOJ732ZFzz/bQQUmeuDwAapEM4arLY9Jgx
         lUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEyz/D/GwawmEFE6mKfSBe68GjnRayQfCebOkuONNBw=;
        b=goLZqqRjo13OOAJAO4WRj9ql5eeByQ6onndxW3noqx7H4w3G+m2X6xDEKwXCQf1MzN
         xcRqfVd8VVn4MWNV8g43wHSoaWl1I9Y+ZsmSajnnv9NW3vW7KfsrzAOLYw1FQlAA1Bwt
         oDxaMuSIj/QYD9Ran4EPc2P3Ur8x2fhK5EhMXYvrCIJkfrU2OR7WorwISmLu+njjhZ7r
         Edr3NHSqm0WOCME0Ss0cTvNptLlQGvBhAdHHvGrsi035PXCNnuMqJ8EE3QAYHEQObUtJ
         jrSy1vZ5YzEfMy4ljXYSpuLYMN96gKZvPwW1A0w+3Szqcfr1f6SmCaPuoncEa6igYzZE
         MrxQ==
X-Gm-Message-State: AO0yUKWDn0nQ8Xq34kXwkzV3t03lKH4XLOLe7ivr8vz7TGkv5o8tXVjr
        suNfTLIcqwK95a+T0p7WYoDZsEt4Lww=
X-Google-Smtp-Source: AK7set+Lg4llgEJ6QaiikJdamHYHEjb0MDTZ0zPakDnAXCfGtwwICr3RneW3uXmfczA4QmZz33KIBVoHPHo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1957:b0:230:9d9a:377d with SMTP id
 nk23-20020a17090b195700b002309d9a377dmr2128693pjb.102.1675989121567; Thu, 09
 Feb 2023 16:32:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Feb 2023 00:31:33 +0000
In-Reply-To: <20230210003148.2646712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210003148.2646712-7-seanjc@google.com>
Subject: [PATCH v2 06/21] KVM: x86/pmu: WARN and bug the VM if PMU is
 refreshed after vCPU has run
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

Now that KVM disallows changing feature MSRs, i.e. PERF_CAPABILITIES,
after running a vCPU, WARN and bug the VM if the PMU is refreshed after
the vCPU has run.

Note, KVM has disallowed CPUID updates after running a vCPU since commit
feb627e8d6f6 ("KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN"), i.e.
PERF_CAPABILITIES was the only remaining way to trigger a PMU refresh
after KVM_RUN.

Cc: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c |  3 +++
 arch/x86/kvm/x86.c | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 612e6c70ce2e..7e974c4e61b0 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -589,6 +589,9 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
  */
 void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 {
+	if (KVM_BUG_ON(kvm_vcpu_has_run(vcpu), vcpu->kvm))
+		return;
+
 	static_call(kvm_x86_pmu_refresh)(vcpu);
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 186cb6a81643..1b14632a94a3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3626,9 +3626,17 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (data & ~kvm_caps.supported_perf_cap)
 			return 1;
 
+		/*
+		 * Note, this is not just a performance optimization!  KVM
+		 * disallows changing feature MSRs after the vCPU has run; PMU
+		 * refresh will bug the VM if called after the vCPU has run.
+		 */
+		if (vcpu->arch.perf_capabilities == data)
+			break;
+
 		vcpu->arch.perf_capabilities = data;
 		kvm_pmu_refresh(vcpu);
-		return 0;
+		break;
 	case MSR_EFER:
 		return set_efer(vcpu, msr_info);
 	case MSR_K7_HWCR:
-- 
2.39.1.581.gbfd45094c4-goog

