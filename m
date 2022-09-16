Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179835BAE92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiIPNxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiIPNw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8453AE851
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663336351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDtczjMwYRtrJ/8Rid2fJUsvxXpjDuh2iYjzJoY6xJE=;
        b=ZuVpzG8VAR2MgViTAyc2Y5S/8cDh7OLZ6QRMuwvY3OSTU9oZaNZsTi6nfV5YEcrEs01L30
        RmKDM5yngFcuLKj5vgr6XEYmzutUS7yO2ylImQ7+Kte/s/k9pOGA/VaISttsoOLUP2oqKw
        kzuTeLPhrs3B5ZorDI8wl4wEwSCKHro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-AWvARZipPeia9Tb5CVlz9w-1; Fri, 16 Sep 2022 09:52:27 -0400
X-MC-Unique: AWvARZipPeia9Tb5CVlz9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA553886C61;
        Fri, 16 Sep 2022 13:52:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9EB42166B29;
        Fri, 16 Sep 2022 13:52:22 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] KVM: selftests: Test Hyper-V invariant TSC control
Date:   Fri, 16 Sep 2022 15:52:05 +0200
Message-Id: <20220916135205.3185973-7-vkuznets@redhat.com>
In-Reply-To: <20220916135205.3185973-1-vkuznets@redhat.com>
References: <20220916135205.3185973-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for the newly introduced Hyper-V invariant TSC control feature:
- HV_X64_MSR_TSC_INVARIANT_CONTROL is not available without
 HV_ACCESS_TSC_INVARIANT CPUID bit set and available with it.
- BIT(0) of HV_X64_MSR_TSC_INVARIANT_CONTROL controls the filtering of
architectural invariant TSC (CPUID.80000007H:EDX[8]) bit.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 .../selftests/kvm/include/x86_64/hyperv.h     |  3 +
 .../selftests/kvm/include/x86_64/processor.h  |  1 +
 .../selftests/kvm/x86_64/hyperv_features.c    | 58 +++++++++++++++++--
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
index 843748dde1ff..8368d65afbe4 100644
--- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
+++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
@@ -232,4 +232,7 @@
 /* hypercall options */
 #define HV_HYPERCALL_FAST_BIT		BIT(16)
 
+/* HV_X64_MSR_TSC_INVARIANT_CONTROL bits */
+#define HV_INVARIANT_TSC_EXPOSED               BIT_ULL(0)
+
 #endif /* !SELFTEST_KVM_HYPERV_H */
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 0cbc71b7af50..8d106380b0af 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -128,6 +128,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_GBPAGES		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
 #define	X86_FEATURE_RDTSCP		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 27)
 #define	X86_FEATURE_LM			KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 29)
+#define	X86_FEATURE_INVTSC		KVM_X86_CPU_FEATURE(0x80000007, 0, EDX, 8)
 #define	X86_FEATURE_RDPRU		KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 4)
 #define	X86_FEATURE_AMD_IBPB		KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 12)
 #define	X86_FEATURE_NPT			KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 0)
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index d4bd18bc580d..18b44450dfb8 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -46,20 +46,33 @@ struct hcall_data {
 
 static void guest_msr(struct msr_data *msr)
 {
-	uint64_t ignored;
+	uint64_t msr_val = 0;
 	uint8_t vector;
 
 	GUEST_ASSERT(msr->idx);
 
-	if (!msr->write)
-		vector = rdmsr_safe(msr->idx, &ignored);
-	else
+	if (!msr->write) {
+		vector = rdmsr_safe(msr->idx, &msr_val);
+	} else {
 		vector = wrmsr_safe(msr->idx, msr->write_val);
+		if (!vector)
+			msr_val = msr->write_val;
+	}
 
 	if (msr->fault_expected)
 		GUEST_ASSERT_2(vector == GP_VECTOR, msr->idx, vector);
 	else
 		GUEST_ASSERT_2(!vector, msr->idx, vector);
+
+	/* Invariant TSC bit appears when TSC invariant control MSR is written to */
+	if (msr->idx == HV_X64_MSR_TSC_INVARIANT_CONTROL) {
+		if (!this_cpu_has(HV_ACCESS_TSC_INVARIANT))
+			GUEST_ASSERT(this_cpu_has(X86_FEATURE_INVTSC));
+		else
+			GUEST_ASSERT(this_cpu_has(X86_FEATURE_INVTSC) ==
+				     !!(msr_val & HV_INVARIANT_TSC_EXPOSED));
+	}
+
 	GUEST_DONE();
 }
 
@@ -114,6 +127,7 @@ static void guest_test_msrs_access(void)
 	int stage = 0;
 	vm_vaddr_t msr_gva;
 	struct msr_data *msr;
+	bool has_invtsc = kvm_cpu_has(X86_FEATURE_INVTSC);
 
 	while (true) {
 		vm = vm_create_with_one_vcpu(&vcpu, guest_msr);
@@ -425,6 +439,42 @@ static void guest_test_msrs_access(void)
 			break;
 
 		case 44:
+			/* MSR is not available when CPUID feature bit is unset */
+			if (!has_invtsc)
+				continue;
+			msr->idx = HV_X64_MSR_TSC_INVARIANT_CONTROL;
+			msr->write = 0;
+			msr->fault_expected = 1;
+			break;
+		case 45:
+			/* MSR is vailable when CPUID feature bit is set */
+			if (!has_invtsc)
+				continue;
+			vcpu_set_cpuid_feature(vcpu, HV_ACCESS_TSC_INVARIANT);
+			msr->idx = HV_X64_MSR_TSC_INVARIANT_CONTROL;
+			msr->write = 0;
+			msr->fault_expected = 0;
+			break;
+		case 46:
+			/* Writing bits other than 0 is forbidden */
+			if (!has_invtsc)
+				continue;
+			msr->idx = HV_X64_MSR_TSC_INVARIANT_CONTROL;
+			msr->write = 1;
+			msr->write_val = 0xdeadbeef;
+			msr->fault_expected = 1;
+			break;
+		case 47:
+			/* Setting bit 0 enables the feature */
+			if (!has_invtsc)
+				continue;
+			msr->idx = HV_X64_MSR_TSC_INVARIANT_CONTROL;
+			msr->write = 1;
+			msr->write_val = 1;
+			msr->fault_expected = 0;
+			break;
+
+		default:
 			kvm_vm_free(vm);
 			return;
 		}
-- 
2.37.2

