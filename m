Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565177012C6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbjELXwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbjELXv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:51:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE67E70A
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:51:17 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-643842c87dbso10938665b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935460; x=1686527460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uTLS7GH4gIRN1PlS1PI+vIgLYG0J1IjMSATijGXdups=;
        b=kvQYtK4ceeq9iZaPajPCSno8Cvvhd5VB84yKUQcF9KyPXp6xW2qCq2himmqvfIWrmV
         XS2/4cPWvCWx/B488GJX566n8/8ilhQq/DY0YloUmQOSqBWvkuqSLRuicMKHkFbgLEH0
         iHFrz2cCM4pBbAQSxkSIWK4a+ER/P+Ab7G8ulD0CZ8Be/7qNvOUkGhNRwc9i2tYYZbcQ
         eTTg+rc77wJkODC5XlDluglqiaCVRYPVyeUR5BrjeZ43h6NiSQA9IRt/shLAf1iU00GD
         zEjzDDopsLWUlIfMaEmjPlTIPse3nCvqcU0oOiHfmZ1BfK6pgwYjT5Ym/Ub1p/6CA2Sc
         PTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935461; x=1686527461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTLS7GH4gIRN1PlS1PI+vIgLYG0J1IjMSATijGXdups=;
        b=gn8mRqqsTRSefif+95wsIesL+nIxxey2BrxyvkZ21rQKoZhksiuNbLIqNB8tHoaBI5
         Pv6kcApUipR1Z90G+HAJNaiPEKQJJVDSXH0sUYhesexmuVr8htOY3IyZoIrOVE+N7ZRY
         MnzrukBW+SX3Q4zya7GAeruqctWtAJ+EAh0/Tc66lBVa6MXrve52jFQmBmyn761QQAfC
         h/hPh3bcSNybxFrLHJ2Uk55UtG3MHu9F+ca7vcVJnGKwbyLIPrLFEDsV57W40fBsiIXu
         4zfDe/BeeGUrOwXp5P03LQVkIjNgpMGeE4hrZCPYFXxlecHGAN7TMOHBvFY8Uzy/qHP0
         fFhA==
X-Gm-Message-State: AC+VfDzTabDsbcUk+Pysm2o7/Khi+YO/sKTt196QFNo+VuYPDn0X67OL
        2i0TtY3Q/qIrh6o91AXIvBgmzFO8AP0=
X-Google-Smtp-Source: ACHHUZ4FwMhCcIgCPfM5PBRpMD0yIf/X+GpptsjLvWUKlWl6UEbBBfCviS/y32hPpZQMovy3+EuAUfAPf9o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:80dc:b0:643:85a7:b49c with SMTP id
 ei28-20020a056a0080dc00b0064385a7b49cmr7155796pfb.5.1683935460717; Fri, 12
 May 2023 16:51:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:25 -0700
In-Reply-To: <20230512235026.808058-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230512235026.808058-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-18-seanjc@google.com>
Subject: [PATCH v3 17/18] KVM: x86: Force kvm_rebooting=true during emergency reboot/crash
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
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

Set kvm_rebooting when virtualization is disabled in an emergency so that
KVM eats faults on virtualization instructions even if kvm_reboot() isn't
reached.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 ++
 arch/x86/kvm/vmx/vmx.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2cc195d95d32..d00da133b14f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -611,6 +611,8 @@ static inline void kvm_cpu_svm_disable(void)
 
 static void svm_emergency_disable(void)
 {
+	kvm_rebooting = true;
+
 	kvm_cpu_svm_disable();
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 008914396180..1dec932aff21 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -771,6 +771,8 @@ static void vmx_emergency_disable(void)
 	int cpu = raw_smp_processor_id();
 	struct loaded_vmcs *v;
 
+	kvm_rebooting = true;
+
 	list_for_each_entry(v, &per_cpu(loaded_vmcss_on_cpu, cpu),
 			    loaded_vmcss_on_cpu_link)
 		vmcs_clear(v->vmcs);
-- 
2.40.1.606.ga4b1b128d6-goog

