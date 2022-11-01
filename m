Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2624614D43
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiKAO4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiKAOzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CE7644D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667314488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h2ZbSkL4gKln8MZc4BtzBq49GjPVHV1GT5MM1ZOs798=;
        b=Gn8TZT44HRZMnY/oP5jun2Np0Kg0oyjep+QtpfgGQ53Lqlef+9SouWS86IlfEWmPqucuWZ
        TBBwhzENvirWnFteoKJpCIoHDysYN0T0uRONoalFTGi+tsOrHgtklYAFqmLpMv1Tct/tFI
        Q/dmIWAD4/o/pQPjVyyBaoYumzXu5sQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-ubCFdUyYNNu0E5neASIJqg-1; Tue, 01 Nov 2022 10:54:42 -0400
X-MC-Unique: ubCFdUyYNNu0E5neASIJqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AF68185A78F;
        Tue,  1 Nov 2022 14:54:42 +0000 (UTC)
Received: from ovpn-194-149.brq.redhat.com (ovpn-194-149.brq.redhat.com [10.40.194.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4481C15BA5;
        Tue,  1 Nov 2022 14:54:39 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 04/48] x86/hyperv: KVM: Rename "hv_enlightenments" to "hv_vmcb_enlightenments"
Date:   Tue,  1 Nov 2022 15:53:42 +0100
Message-Id: <20221101145426.251680-5-vkuznets@redhat.com>
In-Reply-To: <20221101145426.251680-1-vkuznets@redhat.com>
References: <20221101145426.251680-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

Now that KVM isn't littered with "struct hv_enlightenments" casts, rename
the struct to "hv_vmcb_enlightenments" to highlight the fact that the
struct is specifically for SVM's VMCB.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/hyperv-tlfs.h                   | 2 +-
 arch/x86/include/asm/svm.h                           | 2 +-
 arch/x86/kvm/svm/nested.c                            | 2 +-
 arch/x86/kvm/svm/svm.h                               | 2 +-
 arch/x86/kvm/svm/svm_onhyperv.c                      | 2 +-
 arch/x86/kvm/svm/svm_onhyperv.h                      | 6 +++---
 tools/testing/selftests/kvm/include/x86_64/svm.h     | 4 ++--
 tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 245a806a9717..c5e0e5a06c0d 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -602,7 +602,7 @@ struct hv_enlightened_vmcs {
  * Hyper-V uses the software reserved 32 bytes in VMCB control area to expose
  * SVM enlightenments to guests.
  */
-struct hv_enlightenments {
+struct hv_vmcb_enlightenments {
 	struct __packed hv_enlightenments_control {
 		u32 nested_flush_hypercall:1;
 		u32 msr_bitmap:1;
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 6befed2b30a6..621f064bb7cc 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -164,7 +164,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	 * for use by hypervisor/software.
 	 */
 	union {
-		struct hv_enlightenments hv_enlightenments;
+		struct hv_vmcb_enlightenments hv_enlightenments;
 		u8 reserved_sw[32];
 	};
 };
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c8e967f6cafe..c2a49aa50a58 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -179,7 +179,7 @@ void recalc_intercepts(struct vcpu_svm *svm)
  */
 static bool nested_svm_vmrun_msrpm(struct vcpu_svm *svm)
 {
-	struct hv_enlightenments *hve = &svm->nested.ctl.hv_enlightenments;
+	struct hv_vmcb_enlightenments *hve = &svm->nested.ctl.hv_enlightenments;
 	int i;
 
 	/*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 9eb2fc76732f..5e1178bc9a64 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -152,7 +152,7 @@ struct vmcb_ctrl_area_cached {
 	u64 virt_ext;
 	u32 clean;
 	union {
-		struct hv_enlightenments hv_enlightenments;
+		struct hv_vmcb_enlightenments hv_enlightenments;
 		u8 reserved_sw[32];
 	};
 };
diff --git a/arch/x86/kvm/svm/svm_onhyperv.c b/arch/x86/kvm/svm/svm_onhyperv.c
index 422d00fee24a..52c73a8be72b 100644
--- a/arch/x86/kvm/svm/svm_onhyperv.c
+++ b/arch/x86/kvm/svm/svm_onhyperv.c
@@ -16,7 +16,7 @@
 
 int svm_hv_enable_direct_tlbflush(struct kvm_vcpu *vcpu)
 {
-	struct hv_enlightenments *hve;
+	struct hv_vmcb_enlightenments *hve;
 	struct hv_partition_assist_pg **p_hv_pa_pg =
 			&to_kvm_hv(vcpu->kvm)->hv_pa_pg;
 
diff --git a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
index 5c664dd7bee2..d5cb2c62e355 100644
--- a/arch/x86/kvm/svm/svm_onhyperv.h
+++ b/arch/x86/kvm/svm/svm_onhyperv.h
@@ -17,7 +17,7 @@ int svm_hv_enable_direct_tlbflush(struct kvm_vcpu *vcpu);
 
 static inline void svm_hv_init_vmcb(struct vmcb *vmcb)
 {
-	struct hv_enlightenments *hve = &vmcb->control.hv_enlightenments;
+	struct hv_vmcb_enlightenments *hve = &vmcb->control.hv_enlightenments;
 
 	BUILD_BUG_ON(sizeof(vmcb->control.hv_enlightenments) !=
 		     sizeof(vmcb->control.reserved_sw));
@@ -62,7 +62,7 @@ static inline void svm_hv_vmcb_dirty_nested_enlightenments(
 		struct kvm_vcpu *vcpu)
 {
 	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
-	struct hv_enlightenments *hve = &vmcb->control.hv_enlightenments;
+	struct hv_vmcb_enlightenments *hve = &vmcb->control.hv_enlightenments;
 
 	if (hve->hv_enlightenments_control.msr_bitmap)
 		vmcb_mark_dirty(vmcb, HV_VMCB_NESTED_ENLIGHTENMENTS);
@@ -70,7 +70,7 @@ static inline void svm_hv_vmcb_dirty_nested_enlightenments(
 
 static inline void svm_hv_update_vp_id(struct vmcb *vmcb, struct kvm_vcpu *vcpu)
 {
-	struct hv_enlightenments *hve = &vmcb->control.hv_enlightenments;
+	struct hv_vmcb_enlightenments *hve = &vmcb->control.hv_enlightenments;
 	u32 vp_index = kvm_hv_get_vpindex(vcpu);
 
 	if (hve->hv_vp_id != vp_index) {
diff --git a/tools/testing/selftests/kvm/include/x86_64/svm.h b/tools/testing/selftests/kvm/include/x86_64/svm.h
index 6e1527aa3419..483e6ae12f69 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm.h
@@ -58,7 +58,7 @@ enum {
 	INTERCEPT_RDPRU,
 };
 
-struct hv_enlightenments {
+struct hv_vmcb_enlightenments {
 	struct __packed hv_enlightenments_control {
 		u32 nested_flush_hypercall:1;
 		u32 msr_bitmap:1;
@@ -124,7 +124,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 	 * for use by hypervisor/software.
 	 */
 	union {
-		struct hv_enlightenments hv_enlightenments;
+		struct hv_vmcb_enlightenments hv_enlightenments;
 		u8 reserved_sw[32];
 	};
 };
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
index 8ef6a4c83cb1..1c3fc38b4f15 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
@@ -46,7 +46,7 @@ static void __attribute__((__flatten__)) guest_code(struct svm_test_data *svm)
 {
 	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
-	struct hv_enlightenments *hve = &vmcb->control.hv_enlightenments;
+	struct hv_vmcb_enlightenments *hve = &vmcb->control.hv_enlightenments;
 
 	GUEST_SYNC(1);
 
-- 
2.37.3

