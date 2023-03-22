Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B87A6C3F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCVBQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCVBPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:15:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1DF5A903
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:15:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a2514d5000000b00a3637aea9e1so18272039ybu.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679447721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bCprSD7F8RNK3sb9JsGw6XUAq7a4JeIg3plwEoRHVh8=;
        b=YIfiHPdYGeLXud9fanwJkzpqMhXu9ONdgLi3kWklYWx9AmdlQIm1JlSKnVHYPY903M
         w4KQNHT7wvCE16Stgyu5u74kWIU/niqgHvn8Nz8qYnIAIneIGXSECDDpWdmZ3POaPEW9
         h4V/uzUdVBGQ0Pav6rFS1wv0uf8sbXWgRZf20VkwMZL0ec4osReXufoHf/QT7EF3p4XT
         jds1OsktmRiJ4pJetVbRgnvOu2NLILefoU6ChynqqWUyoClpLR6ZzqmQJyB80CFjRWC7
         Q5SYO0NVDM0r+dYxbm9pi2l4SV2CpfagP+HLD9lHvLyaqcZtW2T4I82SJFq0Kor1DamS
         mmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679447721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCprSD7F8RNK3sb9JsGw6XUAq7a4JeIg3plwEoRHVh8=;
        b=ZbLm1UQcWPERaPf03wGjcmNAGNMli07mwNL2lk+pI5dmoTzYgZXAoSBfGhkJ4BA++V
         nkZmHMQzMcvzcFyMWUKOgeTRIjrBtiUb7xoz7gLHLAntIdK871iYkxnshLXLt328Jmov
         IV2Js2chaAv+ueon2E4OcE3VHDchb9c/BtcLaeSZuvLOHMFOQu/x9MvuxFG/a8rN+A2D
         8FxpwGGBGSSR3yaX3fN5ON94wzEBOyaY0KwAo3+RFGMRO0m7TR8HcJb3vFhAHraCtyfZ
         g8NpjjJfZeExGhNBZRd3CyP8lypd21WyfbdkzegggjUjaaBvpsnvEOCBz5rpTzTk7PYM
         Pfaw==
X-Gm-Message-State: AAQBX9cB139SwaU/PsqW9caNS0PlFOaRsM17rtoP5wsbjsC8TJGZ2Kaq
        jENz8yuHo6JM9Qo1WNUls5bxDh2pGyE=
X-Google-Smtp-Source: AKy350Z4GYLkN9GqsRyZPUTnQKxQkYtfWgACitjGks5G4hRIDJhBShaAPFpSuQT8RDwS/VE2uizQpswSTX4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b3c1:0:b0:541:9895:4ce9 with SMTP id
 r184-20020a81b3c1000000b0054198954ce9mr2208350ywh.9.1679447720994; Tue, 21
 Mar 2023 18:15:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 18:14:37 -0700
In-Reply-To: <20230322011440.2195485-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230322011440.2195485-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230322011440.2195485-4-seanjc@google.com>
Subject: [PATCH 3/6] KVM: SVM: Passthrough MSR_IA32_PRED_CMD based purely on
 host+guest CPUID
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passthrough MSR_IA32_PRED_CMD based purely on whether or not the MSR is
supported and enabled, i.e. don't wait until the first write.  There's no
benefit to deferred passthrough, and the extra logic only adds complexity.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 252e7f37e4e2..f757b436ffae 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2955,7 +2955,6 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			break;
 
 		wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
-		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_PRED_CMD, 0, 1);
 		break;
 	case MSR_AMD64_VIRT_SPEC_CTRL:
 		if (!msr->host_initiated &&
@@ -4151,6 +4150,10 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	svm_recalc_instruction_intercepts(vcpu, svm);
 
+	if (boot_cpu_has(X86_FEATURE_IBPB))
+		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_PRED_CMD, 0,
+				     !!guest_has_pred_cmd_msr(vcpu));
+
 	/* For sev guests, the memory encryption bit is not reserved in CR3.  */
 	if (sev_guest(vcpu->kvm)) {
 		best = kvm_find_cpuid_entry(vcpu, 0x8000001F);
-- 
2.40.0.rc2.332.ga46443480c-goog

