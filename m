Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392D16D71A0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbjDEAp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbjDEAp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:45:26 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6612018E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 17:45:25 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id z16-20020a170902d55000b001a06f9b5e31so20500520plf.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 17:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680655525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7DA+p9LgbhVdVl+ZZN2EOFJj3Y+toC812cwG1G1Tydo=;
        b=NuptfWe+kbxpMI4xsKwwX3YVDMgXaZ48Y3wNEkIDr743/Q757lyf/pOnOzUmRThrUq
         65zXsyfaIMgHd3AgFVjMbeNqzFVtITy9vvBN071dZtWEiJNTq10X+JDf/aMndem5ymbD
         j+fFgjBgOTirtIvdmAic2l7FUDkz7jodobZqdztSLKApS9S4jEE7fxeXP2uaFoz16Cvw
         JJrpTZ3A8ats7oTsoLcBGJHg68R5EgXNSbnA8OGHVYnEnQnmU6KvmtyW8RBB9lksCtyb
         TqECMaLutBKQk+nDl5CQiWAwH1KAVdwxeQio5mK3jQNYSMESSjyDxcv6PFgBSqd8Qmc0
         ytNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DA+p9LgbhVdVl+ZZN2EOFJj3Y+toC812cwG1G1Tydo=;
        b=xqfUUWbNVnAQJI2cqzVUp3JrwIdSjizehSXw68V/XyjgMB8GlMxSKPu3pZPbOlkC8K
         NzxIYKDddOGLbGIePbvxT2mIRjb8HGTxlHYO4og7m9FnpXaPPTA6WHsH0Ci3q51BFWu3
         AsbNp3/xUkNKceD66y71l62Z0ncxNQiBbieQukipsMiSCJUeIFFtE3YebdMk+IMXQm3A
         jwT8a4Q6aX/mmMCpQEBShDtFu/ngYCmt5gBjLNp3cJ2PZ9JiJCCWbcD4bBxW/6k/FniX
         mev0fRUChio3CwioUCeKwP+VXrce0i6F0ipQVXxirlMr9AwpUwkKAkHIGil/6qzamx5c
         0Ilg==
X-Gm-Message-State: AAQBX9c4mI353kYiIrhCcc+DU86b0J5lCYOg6gNynQCEbDJA9PKpIJSM
        vR52oR24Sc8lvqTQxM9xzpjm2wv9lTs=
X-Google-Smtp-Source: AKy350a9xMMtKcyXM43Qy4kq9QpFU/MleKPOetKKD30yFWZgJjZ74PVPrD/jtOo6/RYqzYmi+8Mclk8+mak=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ba94:b0:1a0:48ff:5388 with SMTP id
 k20-20020a170902ba9400b001a048ff5388mr1806065pls.6.1680655524982; Tue, 04 Apr
 2023 17:45:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 Apr 2023 17:45:15 -0700
In-Reply-To: <20230405004520.421768-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230405004520.421768-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405004520.421768-2-seanjc@google.com>
Subject: [PATCH v4 1/6] KVM: x86: Add a helper to handle filtering of
 unpermitted XCR0 features
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>,
        Mingwei Zhang <mizhang@google.com>,
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

From: Aaron Lewis <aaronlewis@google.com>

Add a helper, kvm_get_filtered_xcr0(), to dedup code that needs to account
for XCR0 features that require explicit opt-in on a per-process basis.  In
addition to documenting when KVM should/shouldn't consult
xstate_get_guest_group_perm(), the helper will also allow sanitizing the
filtered XCR0 to avoid enumerating architecturally illegal XCR0 values,
e.g. XTILE_CFG without XTILE_DATA.

No functional changes intended.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
Reviewed-by: Mingwei Zhang <mizhang@google.com>
[sean: rename helper, move to x86.h, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c |  2 +-
 arch/x86/kvm/x86.c   |  4 +---
 arch/x86/kvm/x86.h   | 13 +++++++++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 6972e0be60fa..542bcaab3592 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -996,7 +996,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = entry->ebx = entry->ecx = 0;
 		break;
 	case 0xd: {
-		u64 permitted_xcr0 = kvm_caps.supported_xcr0 & xstate_get_guest_group_perm();
+		u64 permitted_xcr0 = kvm_get_filtered_xcr0();
 		u64 permitted_xss = kvm_caps.supported_xss;
 
 		entry->eax &= permitted_xcr0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2c0ff40e5345..7bac4162cfae 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4567,9 +4567,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			r = 0;
 		break;
 	case KVM_CAP_XSAVE2: {
-		u64 guest_perm = xstate_get_guest_group_perm();
-
-		r = xstate_required_size(kvm_caps.supported_xcr0 & guest_perm, false);
+		r = xstate_required_size(kvm_get_filtered_xcr0(), false);
 		if (r < sizeof(struct kvm_xsave))
 			r = sizeof(struct kvm_xsave);
 		break;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 203fb6640b5b..b6c6988d99b5 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -315,6 +315,19 @@ extern struct kvm_caps kvm_caps;
 
 extern bool enable_pmu;
 
+/*
+ * Get a filtered version of KVM's supported XCR0 that strips out dynamic
+ * features for which the current process doesn't (yet) have permission to use.
+ * This is intended to be used only when enumerating support to userspace,
+ * e.g. in KVM_GET_SUPPORTED_CPUID and KVM_CAP_XSAVE2, it does NOT need to be
+ * used to check/restrict guest behavior as KVM rejects KVM_SET_CPUID{2} if
+ * userspace attempts to enable unpermitted features.
+ */
+static inline u64 kvm_get_filtered_xcr0(void)
+{
+	return kvm_caps.supported_xcr0 & xstate_get_guest_group_perm();
+}
+
 static inline bool kvm_mpx_supported(void)
 {
 	return (kvm_caps.supported_xcr0 & (XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR))
-- 
2.40.0.348.gf938b09366-goog

