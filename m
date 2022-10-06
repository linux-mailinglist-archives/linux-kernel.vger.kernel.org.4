Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934B55F5E0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJFAvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJFAvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:51:39 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114F422DC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:51:33 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o15-20020a17090a0a0f00b0020ae208febfso113494pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IFtFULTMHbVoi3/vIZxiDjs7liuZPMUdcS3Rb7oFod0=;
        b=tcXBASGV9ZuUmRo+jBfSOFUx8jkTFDMAWGz5aqkHeMasXa1aQZWJESnauRmZVoLnh9
         CHIfS1EzCKzUzAm718VkltVOXvHz/UZAsLQkZMScNGTNyfmK4K5uznCnULduPsOT3anC
         JgojaiXCzMmN3dX/xfZ0MdyINJdx1oHRiDx0d3exKp1eyTT92KwNjrddtlrxSvKksZMo
         HvGoq/fPm/relOCFna9+jSTTicmz1cEX2R/VPLgtY4pMHopYK2wKY2078D+aPGJhXZMw
         xr/2ZdRI1hIDxcoBNz+uM+2aJ+mCRGOurieoWss+zf3L862lVRBuVK65lZGo3fdS3m6E
         SfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFtFULTMHbVoi3/vIZxiDjs7liuZPMUdcS3Rb7oFod0=;
        b=o+dCWt1L50W4kelNHa817bj+nUuvAeJgMMptcK5jqKmXsa5mU6IkaBECQOHDADJjlN
         QBZA8DVBSngg8NkAnclPJ+o0lcRuaY8hw6o5fpT0lR0D0jqg2CXj5Vv7v1nqJZZFeHQE
         LeU5jmYvip97zr5Q9LKkuZrHLUS636ux61v/bzF25KfSuyg4ye9PrKHecLijDEocDXTi
         0MF2QCKBKEjtYF8WeNuP/atgf7ewSV3a1YEhUMpzNjovAEP8R7Q/AXE3IzYwweXuzIkW
         S29fdJI0sUsw4/s0GBz7EGLio7BMvJgu6ukMeRp4AtxdABH74R+mmFaGBYLVOOYfFNap
         6SGg==
X-Gm-Message-State: ACrzQf2pGKMLACD2ZbJhbGZ2UlLBHZWYTR/PN+qOgInaGHA9L38xGVmu
        mVTE4ErS1wj48EEYcqdW+WjIeyu8p0M=
X-Google-Smtp-Source: AMsMyM7OQbCowDjgfSkmivg+MQKdbHtD3FGd6qVBsqAzxtVHU5i2bHVa8EGviKLq3ySdYpYQaQrF2SX1U/A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:14ce:b0:544:1ec7:2567 with SMTP id
 w14-20020a056a0014ce00b005441ec72567mr2411746pfu.24.1665017492966; Wed, 05
 Oct 2022 17:51:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:51:16 +0000
In-Reply-To: <20221006005125.680782-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006005125.680782-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006005125.680782-4-seanjc@google.com>
Subject: [PATCH 03/12] KVM: selftests: Add X86_PROPERTY_* framework to
 retrieve CPUID values
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
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

Introduce X86_PROPERTY_* to allow retrieving values/properties from CPUID
leafs, e.g. MAXPHYADDR from CPUID.0x80000008.  Use the same core code as
X86_FEATURE_*, the primary difference is that properties are multi-bit
values, whereas features enumerate a single bit.

Add this_cpu_has_p() to allow querying whether or not a property exists
based on the maximum leaf associated with the property, e.g. MAXPHYADDR
doesn't exist if the max leaf for 0x8000_xxxx is less than 0x8000_0008.

Use the new property infrastructure in vm_compute_max_gfn() to prove
that the code works as intended.  Future patches will convert additional
selftests code.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 68 +++++++++++++++++++
 .../selftests/kvm/lib/x86_64/processor.c      | 18 +++--
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 144268e30b22..55458e3d3ab4 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -168,6 +168,48 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_KVM_HC_MAP_GPA_RANGE	KVM_X86_CPU_FEATURE(0x40000001, 0, EAX, 16)
 #define X86_FEATURE_KVM_MIGRATION_CONTROL	KVM_X86_CPU_FEATURE(0x40000001, 0, EAX, 17)
 
+/*
+ * Same idea as X86_FEATURE_XXX, but X86_PROPERTY_XXX retrieves a multi-bit
+ * value/property as opposed to a single-bit feature.  Again, pack the info
+ * into a 64-bit value to pass by value with no overhead.
+ */
+struct kvm_x86_cpu_property {
+	u32	function;
+	u8	index;
+	u8	reg;
+	u8	lo_bit;
+	u8	hi_bit;
+};
+#define	KVM_X86_CPU_PROPERTY(fn, idx, gpr, low_bit, high_bit)			\
+({										\
+	struct kvm_x86_cpu_property property = {				\
+		.function = fn,							\
+		.index = idx,							\
+		.reg = KVM_CPUID_##gpr,						\
+		.lo_bit = low_bit,						\
+		.hi_bit = high_bit,						\
+	};									\
+										\
+	static_assert(low_bit < high_bit);					\
+	static_assert((fn & 0xc0000000) == 0 ||					\
+		      (fn & 0xc0000000) == 0x40000000 ||			\
+		      (fn & 0xc0000000) == 0x80000000 ||			\
+		      (fn & 0xc0000000) == 0xc0000000);				\
+	static_assert(idx < BIT(sizeof(property.index) * BITS_PER_BYTE));	\
+	property;								\
+})
+
+#define X86_PROPERTY_MAX_BASIC_LEAF		KVM_X86_CPU_PROPERTY(0, 0, EAX, 0, 31)
+
+#define X86_PROPERTY_MAX_KVM_LEAF		KVM_X86_CPU_PROPERTY(0x40000000, 0, EAX, 0, 31)
+
+#define X86_PROPERTY_MAX_EXT_LEAF		KVM_X86_CPU_PROPERTY(0x80000000, 0, EAX, 0, 31)
+#define X86_PROPERTY_MAX_PHY_ADDR		KVM_X86_CPU_PROPERTY(0x80000008, 0, EAX, 0, 7)
+#define X86_PROPERTY_PHYS_ADDR_REDUCTION	KVM_X86_CPU_PROPERTY(0x8000001F, 0, EBX, 6, 11)
+
+#define X86_PROPERTY_MAX_CENTAUR_LEAF		KVM_X86_CPU_PROPERTY(0xC0000000, 0, EAX, 0, 31)
+
+
 /* Page table bitfield declarations */
 #define PTE_PRESENT_MASK        BIT_ULL(0)
 #define PTE_WRITABLE_MASK       BIT_ULL(1)
@@ -449,6 +491,32 @@ static inline bool this_cpu_has(struct kvm_x86_cpu_feature feature)
 			      feature.reg, feature.bit, feature.bit);
 }
 
+static inline uint32_t this_cpu_property(struct kvm_x86_cpu_property property)
+{
+	return __this_cpu_has(property.function, property.index,
+			      property.reg, property.lo_bit, property.hi_bit);
+}
+
+static __always_inline bool this_cpu_has_p(struct kvm_x86_cpu_property property)
+{
+	uint32_t max_leaf;
+
+	switch (property.function & 0xc0000000) {
+	case 0:
+		max_leaf = this_cpu_property(X86_PROPERTY_MAX_BASIC_LEAF);
+		break;
+	case 0x40000000:
+		max_leaf = this_cpu_property(X86_PROPERTY_MAX_KVM_LEAF);
+		break;
+	case 0x80000000:
+		max_leaf = this_cpu_property(X86_PROPERTY_MAX_EXT_LEAF);
+		break;
+	case 0xc0000000:
+		max_leaf = this_cpu_property(X86_PROPERTY_MAX_CENTAUR_LEAF);
+	}
+	return max_leaf >= property.function;
+}
+
 #define SET_XMM(__var, __xmm) \
 	asm volatile("movq %0, %%"#__xmm : : "r"(__var) : #__xmm)
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index ca49944a6bce..fb9e90d25b60 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1276,7 +1276,8 @@ unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
 {
 	const unsigned long num_ht_pages = 12 << (30 - vm->page_shift); /* 12 GiB */
 	unsigned long ht_gfn, max_gfn, max_pfn;
-	uint32_t eax, ebx, ecx, edx, max_ext_leaf;
+	uint32_t eax, ebx, ecx, edx;
+	uint8_t maxphyaddr;
 
 	max_gfn = (1ULL << (vm->pa_bits - vm->page_shift)) - 1;
 
@@ -1299,17 +1300,14 @@ unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
 	 * reduced due to SME by bits 11:6 of CPUID[0x8000001f].EBX.  Use
 	 * the old conservative value if MAXPHYADDR is not enumerated.
 	 */
-	cpuid(0x80000000, &eax, &ebx, &ecx, &edx);
-	max_ext_leaf = eax;
-	if (max_ext_leaf < 0x80000008)
+	if (!this_cpu_has_p(X86_PROPERTY_MAX_PHY_ADDR))
 		goto done;
 
-	cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
-	max_pfn = (1ULL << ((eax & 0xff) - vm->page_shift)) - 1;
-	if (max_ext_leaf >= 0x8000001f) {
-		cpuid(0x8000001f, &eax, &ebx, &ecx, &edx);
-		max_pfn >>= (ebx >> 6) & 0x3f;
-	}
+	maxphyaddr = this_cpu_property(X86_PROPERTY_MAX_PHY_ADDR);
+	max_pfn = (1ULL << (maxphyaddr - vm->page_shift)) - 1;
+
+	if (this_cpu_has_p(X86_PROPERTY_PHYS_ADDR_REDUCTION))
+		max_pfn >>= this_cpu_property(X86_PROPERTY_PHYS_ADDR_REDUCTION);
 
 	ht_gfn = max_pfn - num_ht_pages;
 done:
-- 
2.38.0.rc1.362.ged0d419d3c-goog

