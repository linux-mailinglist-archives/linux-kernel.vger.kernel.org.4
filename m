Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0286B5700
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCKArS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCKAq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:46:56 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3231140884
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:37 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id i7-20020a626d07000000b005d29737db06so3654568pfc.15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678495597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GrjkB3GbLNCU488mD1o6+a8J9bvUDXMzY1ZmunPEt30=;
        b=kGctua3b9Ol+gxvKXIEOfldGSTZQksGh7WFY8sbi7ayH9VX5eY0lmQFH/cEwfN8Fda
         lHQN/eC6wt2hSnbn+QrTdhrGprDYcUeWWUPut1SJMDWpSX2jVzmkZT6Tom5pP9+44jeG
         D/b2yVuttB3e5qUYJ03jT68wS3LcR47uXDzQrCmfUUsqASAP30otOQGxk3k0sZOgYyd4
         k1RRpKTpSWpFtaY4X2O9MmVNsmUbDAhkE5hATUcas6+mU9WOQSj3wwDtiYJUMR1FZEdK
         s650N+K9ZpWOAZPU34XcCYog6+6pNi9DOzL38NLvYnuMIZ7SD0tLeIEf7lV9Xl4atlVx
         Jy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrjkB3GbLNCU488mD1o6+a8J9bvUDXMzY1ZmunPEt30=;
        b=kAsx1llQ3V+UuAaU0fWmo7YtozhHRIaLytIG+UDp1XqICBmYeSVDBhi1fb38BoeXI3
         X70XKVSgBeloB9EtkGWIP/CjPCbegatNmdAdQS3o7N4lgfOob5UyvGubFcrKAI3I3Uji
         yVwF5R8v0HEIob8qa9I1kJABcg7V7aIcSM1zZpoOlFyvan2AxCrIMWirKZOQ5IQkIbfT
         vDEFp9D0+qndOVb6nOLjhlrBpFyScL4TKJbEV0zXN0Ovzw7fO5JWuYwIbw0qCKW/ckZ2
         O7GSAj1hwR0TPOBl/p+cctaH37V6xeBy9R6nUxVh1+zaWvNUnJ8PmmVDTLJTW1XyCQMe
         Y9rw==
X-Gm-Message-State: AO0yUKXiFKrjUw/3Z+uv+yhtAEXIkPmmTsCHbfLq5oYIqjCJomO4jkTy
        gds+duiHdu+t7r2UdLyIJd+Sqq3u/ak=
X-Google-Smtp-Source: AK7set8bTZF8ot+69fmxqaQOfk/QNAD3tjdOKkLqGRUSqklDwJaPm+iPoiA3bgdpSiwskoWPIPPDcpGdywU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6953:0:b0:501:f894:ae62 with SMTP id
 w19-20020a656953000000b00501f894ae62mr1277678pgq.4.1678495597406; Fri, 10 Mar
 2023 16:46:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:46:05 -0800
In-Reply-To: <20230311004618.920745-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311004618.920745-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311004618.920745-9-seanjc@google.com>
Subject: [PATCH v3 08/21] KVM: x86/pmu: Zero out LBR capabilities during PMU refresh
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

Zero out the LBR capabilities during PMU refresh to avoid exposing LBRs
to the guest against userspace's wishes. If userspace modifies the
guest's CPUID model or invokes KVM_CAP_PMU_CAPABILITY to disable vPMU
after an initial KVM_SET_CPUID2, but before the first KVM_RUN, KVM will
retain the previous LBR info due to bailing before refreshing the LBR
descriptor.

Note, this is a very theoretical bug, there is no known use case where a
VMM would deliberately enable the vPMU via KVM_SET_CPUID2, and then later
disable the vPMU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/pmu_intel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index e8a3be0b9df9..d889bb2a1de5 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -531,6 +531,16 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	pmu->pebs_enable_mask = ~0ull;
 	pmu->pebs_data_cfg_mask = ~0ull;
 
+	memset(&lbr_desc->records, 0, sizeof(lbr_desc->records));
+
+	/*
+	 * Setting passthrough of LBR MSRs is done only in the VM-Entry loop,
+	 * and PMU refresh is disallowed after the vCPU has run, i.e. this code
+	 * should never be reached while KVM is passing through MSRs.
+	 */
+	if (KVM_BUG_ON(lbr_desc->msr_passthrough, vcpu->kvm))
+		return;
+
 	entry = kvm_find_cpuid_entry(vcpu, 0xa);
 	if (!entry || !vcpu->kvm->arch.enable_pmu)
 		return;
-- 
2.40.0.rc1.284.g88254d51c5-goog

