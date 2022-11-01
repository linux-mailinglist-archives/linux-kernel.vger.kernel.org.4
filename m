Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD24614D34
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiKAOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiKAOzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E516301
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667314481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QFxOQ3PtGIbBD+RVLQskRjxlIhD002VdmDFB8+zh1fI=;
        b=eJGk9FSkUZX1uwt7cXozQY+I7M+l08BMHx7M314dGdBm9qNsGNXOjWm8aYU4YB9wAjnaqN
        ZMkGUdbNp5RDEK23K8ekAh5LPEVGA6HLCxTbfjI6TSjfO8VVzxbhv93xpSyEXVixrFHWKf
        SKMrK2TO/vMAtch3Wsjrpfh8ophSMkw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-Os-v50pzP_mqHSE14eF0Cg-1; Tue, 01 Nov 2022 10:54:37 -0400
X-MC-Unique: Os-v50pzP_mqHSE14eF0Cg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEC9F3C32C42;
        Tue,  1 Nov 2022 14:54:36 +0000 (UTC)
Received: from ovpn-194-149.brq.redhat.com (ovpn-194-149.brq.redhat.com [10.40.194.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48F99C15BA5;
        Tue,  1 Nov 2022 14:54:34 +0000 (UTC)
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
Subject: [PATCH v13 02/48] KVM: selftests: Move "struct hv_enlightenments" to x86_64/svm.h
Date:   Tue,  1 Nov 2022 15:53:40 +0100
Message-Id: <20221101145426.251680-3-vkuznets@redhat.com>
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

Move Hyper-V's VMCB "struct hv_enlightenments" to the svm.h header so
that the struct can be referenced in "struct vmcb_control_area".
Alternatively, a dedicated header for SVM+Hyper-V could be added, a la
x86_64/evmcs.h, but it doesn't appear that Hyper-V will end up needing
a wholesale replacement for the VMCB.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 .../testing/selftests/kvm/include/x86_64/svm.h | 17 +++++++++++++++++
 .../selftests/kvm/x86_64/hyperv_svm_test.c     | 18 ------------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/svm.h b/tools/testing/selftests/kvm/include/x86_64/svm.h
index c8343ff84f7f..89ce2c6b57fe 100644
--- a/tools/testing/selftests/kvm/include/x86_64/svm.h
+++ b/tools/testing/selftests/kvm/include/x86_64/svm.h
@@ -58,6 +58,23 @@ enum {
 	INTERCEPT_RDPRU,
 };
 
+struct hv_enlightenments {
+	struct __packed hv_enlightenments_control {
+		u32 nested_flush_hypercall:1;
+		u32 msr_bitmap:1;
+		u32 enlightened_npt_tlb: 1;
+		u32 reserved:29;
+	} __packed hv_enlightenments_control;
+	u32 hv_vp_id;
+	u64 hv_vm_id;
+	u64 partition_assist_page;
+	u64 reserved;
+} __packed;
+
+/*
+ * Hyper-V uses the software reserved clean bit in VMCB
+ */
+#define HV_VMCB_NESTED_ENLIGHTENMENTS (1U << 31)
 
 struct __attribute__ ((__packed__)) vmcb_control_area {
 	u32 intercept_cr;
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
index 5060fcfe1760..2fd64b419928 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c
@@ -23,24 +23,6 @@
 
 #define L2_GUEST_STACK_SIZE 256
 
-struct hv_enlightenments {
-	struct __packed hv_enlightenments_control {
-		u32 nested_flush_hypercall:1;
-		u32 msr_bitmap:1;
-		u32 enlightened_npt_tlb: 1;
-		u32 reserved:29;
-	} __packed hv_enlightenments_control;
-	u32 hv_vp_id;
-	u64 hv_vm_id;
-	u64 partition_assist_page;
-	u64 reserved;
-} __packed;
-
-/*
- * Hyper-V uses the software reserved clean bit in VMCB
- */
-#define HV_VMCB_NESTED_ENLIGHTENMENTS (1U << 31)
-
 void l2_guest_code(void)
 {
 	GUEST_SYNC(3);
-- 
2.37.3

