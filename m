Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9E7607B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJUPh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiJUPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401D426FFB2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666366574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ja/6Vsf8yoC6HqVb1hwYdumnJYOROs1VQD+dzXv1ZK4=;
        b=GER8VGL2LplAqFmg/n6GPayoj055wlLIJo/JkqE5So4V4eC19Qu707BDK71MJpr4sA1Rqs
        UokfpTnY0ybaU1k8FZ69nJdGJuBuRDHu8jFU0CU7Fdv1aWHejF44I5jqkWTChFg4MaeFv1
        URLx7VJz74HOo2EqM/MX4gPN828HT00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-R1Y4YzY3NHulvY554S_H9A-1; Fri, 21 Oct 2022 11:36:10 -0400
X-MC-Unique: R1Y4YzY3NHulvY554S_H9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADF6B85704B;
        Fri, 21 Oct 2022 15:36:08 +0000 (UTC)
Received: from ovpn-192-65.brq.redhat.com (ovpn-192-65.brq.redhat.com [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E096D400EA8B;
        Fri, 21 Oct 2022 15:36:06 +0000 (UTC)
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
Subject: [PATCH v12 17/46] KVM: x86: hyper-v: Create a separate fifo for L2 TLB flush
Date:   Fri, 21 Oct 2022 17:34:52 +0200
Message-Id: <20221021153521.1216911-18-vkuznets@redhat.com>
In-Reply-To: <20221021153521.1216911-1-vkuznets@redhat.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To handle L2 TLB flush requests, KVM needs to use a separate fifo from
regular (L1) Hyper-V TLB flush requests: e.g. when a request to flush
something in L2 is made, the target vCPU can transition from L2 to L1,
receive a request to flush a GVA for L1 and then try to enter L2 back.
The first request needs to be processed at this point. Similarly,
requests to flush GVAs in L1 must wait until L2 exits to L1.

No functional change as KVM doesn't handle L2 TLB flush requests from
L2 yet.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  8 +++++++-
 arch/x86/kvm/hyperv.c           | 11 +++++++----
 arch/x86/kvm/hyperv.h           | 19 ++++++++++++++++---
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f8ee72dd8660..6ebcf78368d1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -612,6 +612,12 @@ struct kvm_vcpu_hv_synic {
  */
 #define KVM_HV_TLB_FLUSHALL_ENTRY  ((u64)-1)
 
+enum hv_tlb_flush_fifos {
+	HV_L1_TLB_FLUSH_FIFO,
+	HV_L2_TLB_FLUSH_FIFO,
+	HV_NR_TLB_FLUSH_FIFOS,
+};
+
 struct kvm_vcpu_hv_tlb_flush_fifo {
 	spinlock_t write_lock;
 	DECLARE_KFIFO(entries, u64, KVM_HV_TLB_FLUSH_FIFO_SIZE);
@@ -639,7 +645,7 @@ struct kvm_vcpu_hv {
 		u32 nested_ebx; /* HYPERV_CPUID_NESTED_FEATURES.EBX */
 	} cpuid_cache;
 
-	struct kvm_vcpu_hv_tlb_flush_fifo tlb_flush_fifo;
+	struct kvm_vcpu_hv_tlb_flush_fifo tlb_flush_fifo[HV_NR_TLB_FLUSH_FIFOS];
 };
 
 /* Xen HVM per vcpu emulation context */
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 1d1a65903eb5..56b725e852cb 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -956,8 +956,10 @@ int kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
 
 	hv_vcpu->vp_index = vcpu->vcpu_idx;
 
-	INIT_KFIFO(hv_vcpu->tlb_flush_fifo.entries);
-	spin_lock_init(&hv_vcpu->tlb_flush_fifo.write_lock);
+	for (i = 0; i < HV_NR_TLB_FLUSH_FIFOS; i++) {
+		INIT_KFIFO(hv_vcpu->tlb_flush_fifo[i].entries);
+		spin_lock_init(&hv_vcpu->tlb_flush_fifo[i].write_lock);
+	}
 
 	return 0;
 }
@@ -1839,7 +1841,8 @@ static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count)
 	if (!hv_vcpu)
 		return;
 
-	tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
+	/* kvm_hv_flush_tlb() is not ready to handle requests for L2s yet */
+	tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo[HV_L1_TLB_FLUSH_FIFO];
 
 	spin_lock(&tlb_flush_fifo->write_lock);
 
@@ -1874,7 +1877,7 @@ int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
 	if (!tdp_enabled || !hv_vcpu)
 		return -EINVAL;
 
-	tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
+	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
 
 	count = kfifo_out(&tlb_flush_fifo->entries, entries, KVM_HV_TLB_FLUSH_FIFO_SIZE);
 
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index f79edf9234cd..8942e8c6c912 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -22,6 +22,7 @@
 #define __ARCH_X86_KVM_HYPERV_H__
 
 #include <linux/kvm_host.h>
+#include "x86.h"
 
 /* "Hv#1" signature */
 #define HYPERV_CPUID_SIGNATURE_EAX 0x31237648
@@ -151,15 +152,27 @@ int kvm_vm_ioctl_hv_eventfd(struct kvm *kvm, struct kvm_hyperv_eventfd *args);
 int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 		     struct kvm_cpuid_entry2 __user *entries);
 
+static inline struct kvm_vcpu_hv_tlb_flush_fifo *kvm_hv_get_tlb_flush_fifo(struct kvm_vcpu *vcpu,
+									   bool is_guest_mode)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+	int i = is_guest_mode ? HV_L2_TLB_FLUSH_FIFO :
+				HV_L1_TLB_FLUSH_FIFO;
+
+	/* KVM does not handle L2 TLB flush requests yet */
+	WARN_ON_ONCE(i != HV_L1_TLB_FLUSH_FIFO);
+
+	return &hv_vcpu->tlb_flush_fifo[i];
+}
+
 static inline void kvm_hv_vcpu_purge_flush_tlb(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
-	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
-	if (!hv_vcpu || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
+	if (!to_hv_vcpu(vcpu) || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
 		return;
 
-	tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
+	tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(vcpu, is_guest_mode(vcpu));
 
 	kfifo_reset_out(&tlb_flush_fifo->entries);
 }
-- 
2.37.3

