Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927B35F5E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJFAwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJFAvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:51:48 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12746564D5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:51:43 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p14-20020a170902e74e00b0017f7f885f36so174609plf.17
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=F7z262WyQEsAco3CPfB3JK6bCoyUQnjOYNCBs1U/yls=;
        b=l2DVfO+YGoAJNhLzheTjdsoflQLG0Riz+LHTJLZwyZp1Z7xMtijG+f4DbDM6bHY01S
         SiW94ec2GGT+SrdaSDIGjczOHBJz0LqYdVHYIOiCHN2IT59pMzPW+m3SpmO6igbwC80f
         a5B1VNiRFy7CKHCi4aEw3Pop2K3YWqVgV2cJ1vzoQb8EFFUCx3Td2hAX3dszpIAFIXPm
         uGH1B566TX9c8OPXN+DLcdwqyM4b6RNzThBaekL07ETTY5Ng99NrmWRA4N4ocTbI0XmR
         Ym3zEuof12zo0NumbDhWAC2yBAeVcQZej4x+MVZY+YzyQMCp408RSf+Mtw78prdiLWVx
         ARWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7z262WyQEsAco3CPfB3JK6bCoyUQnjOYNCBs1U/yls=;
        b=YHEz/YHuFaJWfXhghEfSh/dpi+fgBYNJxbSypxAPyvJTeEPXajh3RAZZ5k+FfbgiT5
         N+4yQ3UnoRaH1M9y26ZNZIyoCAidJPZqfG78oU6iQ5RnA5mg2L/oRBnffKi2VA7qIf1q
         0SprxYsqKqBDNRMd5oYNcDEQvsRXLHYPUjEEWKPYJgVdI1oxY4L/dD8n7grj46oa8pZw
         XTK46/5ZDoA6o2iBQaB3iQtRWMQh8BHvMNT4X/am+WT++Pt5Iiz8oQRofj8pEo1FX4Cy
         Ec83X9PZ1+ilJXNZAjEz0akiv2ux8vmwwlfNdJi66J3JPHquJBeYZeIAlNaVwvt4D0ZG
         VL0g==
X-Gm-Message-State: ACrzQf0En5vPnA4VIwoKkzo/MVwree0WdUUcIcZZZFEdlR2/p0tiJTLB
        kZz3AgDxs2qNhKcZmDGHuXlEXfFwf3s=
X-Google-Smtp-Source: AMsMyM5FSIAb+Qp2p7jHIWH+uC0Nlw4+6Nm2sVtNXVUfdHuAJgC1EOhrA9zj9qpABs+F31CK+otryTJcr2I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4c09:b0:203:1b6d:2135 with SMTP id
 na9-20020a17090b4c0900b002031b6d2135mr2412991pjb.42.1665017503412; Wed, 05
 Oct 2022 17:51:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:51:22 +0000
In-Reply-To: <20221006005125.680782-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006005125.680782-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006005125.680782-10-seanjc@google.com>
Subject: [PATCH 09/12] KVM: selftest: Add PMU feature framework, use in PMU
 event filter test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
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

Add an X86_PMU_FEATURE_* framework to simplify probing architectural
events on Intel PMUs, which require checking the length of a bit vector
and the _absence_ of a "feature" bit.  Add helpers for both KVM and
"this CPU", and use the newfangled magic (along with X86_PROPERTY_*)
to  clean up pmu_event_filter_test.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 41 +++++++++++++++
 .../kvm/x86_64/pmu_event_filter_test.c        | 51 +++----------------
 2 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 209de48eb501..acad7184d1b6 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -201,6 +201,8 @@ struct kvm_x86_cpu_property {
 
 #define X86_PROPERTY_MAX_BASIC_LEAF		KVM_X86_CPU_PROPERTY(0, 0, EAX, 0, 31)
 #define X86_PROPERTY_PMU_VERSION		KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 0, 7)
+#define X86_PROPERTY_PMU_NR_GP_COUNTERS		KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 8, 15)
+#define X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH	KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 24, 31)
 
 #define X86_PROPERTY_XSTATE_MAX_SIZE_XCR0	KVM_X86_CPU_PROPERTY(0xd,  0, EBX,  0, 31)
 #define X86_PROPERTY_XSTATE_MAX_SIZE		KVM_X86_CPU_PROPERTY(0xd,  0, ECX,  0, 31)
@@ -221,6 +223,29 @@ struct kvm_x86_cpu_property {
 
 #define X86_PROPERTY_MAX_CENTAUR_LEAF		KVM_X86_CPU_PROPERTY(0xC0000000, 0, EAX, 0, 31)
 
+/*
+ * Intel's architectural PMU events are bizarre.  They have a "feature" bit
+ * that indicates the feature is _not_ supported, and a property that states
+ * the length of the bit mask of unsupported features.  A feature is supported
+ * if the size of the bit mask is larger than the "unavailable" bit, and said
+ * bit is not set.
+ *
+ * Wrap the "unavailable" feature to simplify checking whether or not a given
+ * architectural event is supported.
+ */
+struct kvm_x86_pmu_feature {
+	struct kvm_x86_cpu_feature anti_feature;
+};
+#define	KVM_X86_PMU_FEATURE(name, __bit)					\
+({										\
+	struct kvm_x86_pmu_feature feature = {					\
+		.anti_feature = KVM_X86_CPU_FEATURE(0xa, 0, EBX, __bit),	\
+	};									\
+										\
+	feature;								\
+})
+
+#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED	KVM_X86_PMU_FEATURE(BRANCH_INSNS_RETIRED, 5)
 
 /* Page table bitfield declarations */
 #define PTE_PRESENT_MASK        BIT_ULL(0)
@@ -529,6 +554,14 @@ static __always_inline bool this_cpu_has_p(struct kvm_x86_cpu_property property)
 	return max_leaf >= property.function;
 }
 
+static inline bool this_pmu_has(struct kvm_x86_pmu_feature feature)
+{
+	uint32_t nr_bits = this_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH);
+
+	return nr_bits > feature.anti_feature.bit &&
+	       !this_cpu_has(feature.anti_feature);
+}
+
 #define SET_XMM(__var, __xmm) \
 	asm volatile("movq %0, %%"#__xmm : : "r"(__var) : #__xmm)
 
@@ -737,6 +770,14 @@ static __always_inline bool kvm_cpu_has_p(struct kvm_x86_cpu_property property)
 	return max_leaf >= property.function;
 }
 
+static inline bool kvm_pmu_has(struct kvm_x86_pmu_feature feature)
+{
+	uint32_t nr_bits = kvm_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH);
+
+	return nr_bits > feature.anti_feature.bit &&
+	       !kvm_cpu_has(feature.anti_feature);
+}
+
 static inline size_t kvm_cpuid2_size(int nr_entries)
 {
 	return sizeof(struct kvm_cpuid2) +
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index ea4e259a1e2e..5cc88ac31c45 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -21,29 +21,6 @@
 #define ARCH_PERFMON_EVENTSEL_OS			(1ULL << 17)
 #define ARCH_PERFMON_EVENTSEL_ENABLE			(1ULL << 22)
 
-union cpuid10_eax {
-	struct {
-		unsigned int version_id:8;
-		unsigned int num_counters:8;
-		unsigned int bit_width:8;
-		unsigned int mask_length:8;
-	} split;
-	unsigned int full;
-};
-
-union cpuid10_ebx {
-	struct {
-		unsigned int no_unhalted_core_cycles:1;
-		unsigned int no_instructions_retired:1;
-		unsigned int no_unhalted_reference_cycles:1;
-		unsigned int no_llc_reference:1;
-		unsigned int no_llc_misses:1;
-		unsigned int no_branch_instruction_retired:1;
-		unsigned int no_branch_misses_retired:1;
-	} split;
-	unsigned int full;
-};
-
 /* End of stuff taken from perf_event.h. */
 
 /* Oddly, this isn't in perf_event.h. */
@@ -380,30 +357,16 @@ static void test_pmu_config_disable(void (*guest_code)(void))
 }
 
 /*
- * Check for a non-zero PMU version, at least one general-purpose
- * counter per logical processor, an EBX bit vector of length greater
- * than 5, and EBX[5] clear.
- */
-static bool check_intel_pmu_leaf(const struct kvm_cpuid_entry2 *entry)
-{
-	union cpuid10_eax eax = { .full = entry->eax };
-	union cpuid10_ebx ebx = { .full = entry->ebx };
-
-	return eax.split.version_id && eax.split.num_counters > 0 &&
-		eax.split.mask_length > ARCH_PERFMON_BRANCHES_RETIRED &&
-		!ebx.split.no_branch_instruction_retired;
-}
-
-/*
- * Note that CPUID leaf 0xa is Intel-specific. This leaf should be
- * clear on AMD hardware.
+ * On Intel, check for a non-zero PMU version, at least one general-purpose
+ * counter per logical processor, and support for counting the number of branch
+ * instructions retired.
  */
 static bool use_intel_pmu(void)
 {
-	const struct kvm_cpuid_entry2 *entry;
-
-	entry = kvm_get_supported_cpuid_entry(0xa);
-	return is_intel_cpu() && check_intel_pmu_leaf(entry);
+	return is_intel_cpu() &&
+	       kvm_cpu_property(X86_PROPERTY_PMU_VERSION) &&
+	       kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS) &&
+	       kvm_pmu_has(X86_PMU_FEATURE_BRANCH_INSNS_RETIRED);
 }
 
 static bool is_zen1(uint32_t eax)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

