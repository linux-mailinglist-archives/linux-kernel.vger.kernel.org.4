Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48E569B639
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBQXKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBQXKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:10:31 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103E8582BF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:29 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5365a8dd33aso17105927b3.22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 15:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KioFTda0zEdQSBw0TQsNW7u7HebdEbC7ULL51zMSfbE=;
        b=MCT5iiV4rc2yE80RyBM9o4KOTMsZUh2bAIbwptEF0tPQ9AAIaLqeXfPV1v20xeQdBJ
         ngvY5MNXm07+nxgNuRVOw426oKdsi4ub/BMFNHHzgpk+EOmpzHjGpfwdwZBvTVIsXJ1Z
         ixYtudyqlOIGwVMjR24PG6YIbvmFhc89VzwHoRedtJxRbKHjBrbkpRxTQeXTDHZ53RLv
         v75nUo1kDzVi4ZVoxG0a8eb1dmu/6aE1NqaDLwhmqbHynV8Y12e7IUCx+nsNis1FHY/k
         nW0CsLs/BM7+/PNt0iB7yoNFIxk5lLvX8E9NBgK01X2cqZqg5s3MH84roh/Ua50ptKae
         XOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KioFTda0zEdQSBw0TQsNW7u7HebdEbC7ULL51zMSfbE=;
        b=4m6DcBcaKVUIdQ8tBovJFQ4XWykMZrU3lP4OBSq9Z5IZlW9ehPsGZuY7B9vdNMjxjr
         UMXNr04NA8RLm9ZH+2Ups4hqsKh9nAqYpsER+Ob1h/agyU9p8k4TSr/VQ9sD9lCkzPUm
         mDkFuxGO4/GMp+lFnZqy4G95s/nhnbWH2PriR/fflx4zp1OM/h2QtA5ZLFfWFS6HI0Fq
         pQJGLGfNBCIXTDicUN/4M1O04IIqqES30uaggLsWEltg4TvlyGBGGXVssU+OLQnO9xHC
         qHoGLLZsBge/XlpVpi6gcyWS3U+7cFCnZ6YnnJdOe9VaFPs1BJid97/r4Tqm+wK9U26Y
         yaGw==
X-Gm-Message-State: AO0yUKVoeMsY+O8sBR411CSuVpLdxRs9MG9bb7r49GTAukiYRLW4B2KX
        IHyVhz7eFp7VCiH5ZuIt9kpQgNK0WFg=
X-Google-Smtp-Source: AK7set9Dwo/hviHwIJnFBxeHVrNQ2bUODo/qyA0pDmZ2dx1zM98CMehXtRboa/88TVYh1yvoZFtBjxAmVxw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:9205:0:b0:8ef:90e1:b2f8 with SMTP id
 b5-20020a259205000000b008ef90e1b2f8mr206400ybo.2.1676675428316; Fri, 17 Feb
 2023 15:10:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 17 Feb 2023 15:10:11 -0800
In-Reply-To: <20230217231022.816138-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230217231022.816138-2-seanjc@google.com>
Subject: [PATCH 01/12] KVM: x86: Add a framework for enabling KVM-governed x86 features
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Introduce yet another X86_FEATURE flag framework to manage and cache KVM
governed features (for lack of a better term).  "Governed" in this case
means that KVM has some level of involvement and/or vested interest in
whether or not an X86_FEATURE can be used by the guest.  The intent of the
framework is twofold: to simplify caching of guest CPUID flags that KVM
needs to frequently query, and to add clarity to such caching, e.g. it
isn't immediately obvious that SVM's bundle of flags for "optional nested]
SVM features" track whether or not a flag is exposed to L1.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h  | 11 +++++++
 arch/x86/kvm/cpuid.c             |  2 ++
 arch/x86/kvm/cpuid.h             | 51 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/governed_features.h |  9 ++++++
 4 files changed, 73 insertions(+)
 create mode 100644 arch/x86/kvm/governed_features.h

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 792a6037047a..cd660de02f7b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -835,6 +835,17 @@ struct kvm_vcpu_arch {
 	struct kvm_cpuid_entry2 *cpuid_entries;
 	struct kvm_hypervisor_cpuid kvm_cpuid;
 
+	/*
+	 * Track whether or not the guest is allowed to use features that are
+	 * governed by KVM, where "governed" means KVM needs to manage state
+	 * and/or explicitly enable the feature in hardware.  Typically, but
+	 * not always, governed features can be used by the guest if and only
+	 * if both KVM and userspace want to expose the feature to the guest.
+	 */
+	struct {
+		u32 enabled;
+	} governed_features;
+
 	u64 reserved_gpa_bits;
 	int maxphyaddr;
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8f8edeaf8177..013fdc27fc8f 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -335,6 +335,8 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	struct kvm_cpuid_entry2 *best;
 
+	vcpu->arch.governed_features.enabled = 0;
+
 	best = kvm_find_cpuid_entry(vcpu, 1);
 	if (best && apic) {
 		if (cpuid_entry_has(best, X86_FEATURE_TSC_DEADLINE_TIMER))
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index b1658c0de847..f61a2106ba90 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -232,4 +232,55 @@ static __always_inline bool guest_pv_has(struct kvm_vcpu *vcpu,
 	return vcpu->arch.pv_cpuid.features & (1u << kvm_feature);
 }
 
+enum kvm_governed_features {
+#define KVM_GOVERNED_FEATURE(x) KVM_GOVERNED_##x,
+#include "governed_features.h"
+	KVM_NR_GOVERNED_FEATURES
+};
+
+static __always_inline int kvm_governed_feature_index(unsigned int x86_feature)
+{
+	switch (x86_feature) {
+#define KVM_GOVERNED_FEATURE(x) case x: return KVM_GOVERNED_##x;
+#include "governed_features.h"
+	default:
+		return -1;
+	}
+}
+
+static __always_inline int kvm_is_governed_feature(unsigned int x86_feature)
+{
+	return kvm_governed_feature_index(x86_feature) >= 0;
+}
+
+static __always_inline u32 kvm_governed_feature_bit(unsigned int x86_feature)
+{
+	int index = kvm_governed_feature_index(x86_feature);
+
+	BUILD_BUG_ON(index < 0);
+	return BIT(index);
+}
+
+static __always_inline void kvm_governed_feature_set(struct kvm_vcpu *vcpu,
+						     unsigned int x86_feature)
+{
+	BUILD_BUG_ON(KVM_NR_GOVERNED_FEATURES >
+		     sizeof(vcpu->arch.governed_features.enabled) * BITS_PER_BYTE);
+
+	vcpu->arch.governed_features.enabled |= kvm_governed_feature_bit(x86_feature);
+}
+
+static __always_inline void kvm_governed_feature_check_and_set(struct kvm_vcpu *vcpu,
+							       unsigned int x86_feature)
+{
+	if (guest_cpuid_has(vcpu, x86_feature))
+		kvm_governed_feature_set(vcpu, x86_feature);
+}
+
+static __always_inline bool guest_can_use(struct kvm_vcpu *vcpu,
+					  unsigned int x86_feature)
+{
+	return vcpu->arch.governed_features.enabled & kvm_governed_feature_bit(x86_feature);
+}
+
 #endif
diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
new file mode 100644
index 000000000000..40ce8e6608cd
--- /dev/null
+++ b/arch/x86/kvm/governed_features.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(KVM_GOVERNED_FEATURE) || defined(KVM_GOVERNED_X86_FEATURE)
+BUILD_BUG()
+#endif
+
+#define KVM_GOVERNED_X86_FEATURE(x) KVM_GOVERNED_FEATURE(X86_FEATURE_##x)
+
+#undef KVM_GOVERNED_X86_FEATURE
+#undef KVM_GOVERNED_FEATURE
-- 
2.39.2.637.g21b0678d19-goog

