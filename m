Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E815F5D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJFAEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJFADl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:03:41 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F14868B7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:03:30 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id j3-20020a170902da8300b001782a6fbc87so120104plx.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cEkG9GEBTiUE8th5TFZ42NZiqyxd5/5OjQ/JbzJymEQ=;
        b=HZpuKtQwKzlujbVYW3M11GQu0M8KWSz0k/1l9wTjCp+9BEGr2WT/wWmHO+zcKJ4mkS
         p6vnMq3+ZeY75KvwgsBZr/0R8nJTVeMbbU0rDuIYoHWnHllB83NE0YS/GXitghHa+995
         nER/VuLKCZKssKvFOKrMqnVe+wSTNJ7fbX5i0IDdDmKYZlm1x04g5eBH5aD7nStplxL4
         HMY6/ZNWZpqTopZXWJaqOl90rnZ05if94Lyrlbrcem5/sovXyehgVbIf8tDITvxTe3kT
         1aoCB0ZiaC37HHPRiDWbSejAwDHs0/cDAeh+dJkACaBDLcqJGCta2y9GsYXKAvRIgl0o
         U/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEkG9GEBTiUE8th5TFZ42NZiqyxd5/5OjQ/JbzJymEQ=;
        b=u4M2NN79RkLJJYfJvQOldrBDLQED3eeM0MCkiLceOEipiTbVVrHzLbVjWfzuyfFKP1
         AFEIECocyUMKF3Kin6Y4MnsMC8R6F02NNBi2UMtNP+Gs9sFiD11i8pCyJaE6k9Vf7jUi
         Jlv2QVobI9+g+SEgYSiML82hRPpfULHON7P5k+lCIiGhR0zceIFFucLFH2Y4T7pXyG0C
         XK5/9ppuQ2Lk9blrqqJ2INTZXjmXb4Q2kdF67FabGNGo8m7Pvzp3NkLLDlKSN5NK77Ag
         QadKzoK3jWoiIi2PZtwl0a6HAYuT9xOGL9QuyqQT47ceaQUntPRQ3DMXImsK+7VqmamO
         Ec2A==
X-Gm-Message-State: ACrzQf2IgFWzFlUN2wz3BEo3WA37cjAvtZO0wR4338xRBr8NFFQiKsm4
        fz6z49Azp1Lk9X22/KrB5e5dkobAyl8=
X-Google-Smtp-Source: AMsMyM4vYKF91WDVjIeLWeM1NERAi/CGUxBO8aM/E7dVqea8tHTIQPPArdz7NyDaAfOAviH4bem/pSr9+mU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f791:b0:17c:c1dd:a3b5 with SMTP id
 q17-20020a170902f79100b0017cc1dda3b5mr1821332pln.141.1665014609775; Wed, 05
 Oct 2022 17:03:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:03:13 +0000
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006000314.73240-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006000314.73240-8-seanjc@google.com>
Subject: [PATCH v5 7/8] KVM: x86: Handle PERF_CAPABILITIES in common x86's kvm_get_msr_feature()
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle PERF_CAPABILITIES directly in kvm_get_msr_feature() now that the
supported value is available in kvm_caps.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 3 ---
 arch/x86/kvm/vmx/vmx.c | 3 ---
 arch/x86/kvm/x86.c     | 3 +++
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6b680b249975..0d8935e7a943 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2714,9 +2714,6 @@ static int svm_get_msr_feature(struct kvm_msr_entry *msr)
 		if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
 			msr->data |= MSR_F10H_DECFG_LFENCE_SERIALIZE;
 		break;
-	case MSR_IA32_PERF_CAPABILITIES:
-		msr->data = kvm_caps.supported_perf_cap;
-		return 0;
 	default:
 		return KVM_MSR_RET_INVALID;
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 850ff6e683d1..6ff832178e48 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1849,9 +1849,6 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 		if (!nested)
 			return 1;
 		return vmx_get_vmx_msr(&vmcs_config.nested, msr->index, &msr->data);
-	case MSR_IA32_PERF_CAPABILITIES:
-		msr->data = kvm_caps.supported_perf_cap;
-		return 0;
 	default:
 		return KVM_MSR_RET_INVALID;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b6a973d53f93..9443ddb358e6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1653,6 +1653,9 @@ static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 	case MSR_IA32_ARCH_CAPABILITIES:
 		msr->data = kvm_get_arch_capabilities();
 		break;
+	case MSR_IA32_PERF_CAPABILITIES:
+		msr->data = kvm_caps.supported_perf_cap;
+		break;
 	case MSR_IA32_UCODE_REV:
 		rdmsrl_safe(msr->index, &msr->data);
 		break;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

