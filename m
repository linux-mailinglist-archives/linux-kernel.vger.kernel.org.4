Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0F75C0194
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiIUP3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiIUP2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1939A6AB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663773978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSHAxvWPIWn5dQFzZOzUI2rwRDY7z8WW3evSPUjauiA=;
        b=W/sDvJy9nMusy1nMLz4cy7IisYuISHmNDwAYf6CO+8D0MW6RrvLMUCk8hkQbjVlLgJg9Ff
        Tj4saEw13islrdRvmGAXSA0n81QZ2h7wdLlDiAIPbeveqAub5ec4D6HApJk/Z7NRZ/RoDx
        kXhL2KsoxamM8V0iUoaYuuH2dU+6qE4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-kAL6AIPeNKmFiwxE3msWgA-1; Wed, 21 Sep 2022 11:26:15 -0400
X-MC-Unique: kAL6AIPeNKmFiwxE3msWgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDCF68001B8;
        Wed, 21 Sep 2022 15:26:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F20C72166B26;
        Wed, 21 Sep 2022 15:26:12 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 37/39] KVM: selftests: evmcs_test: Introduce L2 TLB flush test
Date:   Wed, 21 Sep 2022 17:24:34 +0200
Message-Id: <20220921152436.3673454-38-vkuznets@redhat.com>
In-Reply-To: <20220921152436.3673454-1-vkuznets@redhat.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
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

Enable Hyper-V L2 TLB flush and check that Hyper-V TLB flush hypercalls
from L2 don't exit to L1 unless 'TlbLockCount' is set in the
Partition assist page.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 .../selftests/kvm/include/x86_64/evmcs.h      |  2 +
 .../testing/selftests/kvm/x86_64/evmcs_test.c | 50 ++++++++++++++++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/evmcs.h b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
index 94d6059e9a12..901caf0e0939 100644
--- a/tools/testing/selftests/kvm/include/x86_64/evmcs.h
+++ b/tools/testing/selftests/kvm/include/x86_64/evmcs.h
@@ -237,6 +237,8 @@ struct hv_enlightened_vmcs {
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_ENLIGHTENMENTSCONTROL    BIT(15)
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL                      0xFFFF
 
+#define HV_VMX_SYNTHETIC_EXIT_REASON_TRAP_AFTER_FLUSH 0x10000031
+
 extern struct hv_enlightened_vmcs *current_evmcs;
 
 int vcpu_enable_evmcs(struct kvm_vcpu *vcpu);
diff --git a/tools/testing/selftests/kvm/x86_64/evmcs_test.c b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
index 74f076ba574b..691dbe0a0881 100644
--- a/tools/testing/selftests/kvm/x86_64/evmcs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/evmcs_test.c
@@ -16,6 +16,7 @@
 
 #include "kvm_util.h"
 
+#include "hyperv.h"
 #include "vmx.h"
 
 static int ud_count;
@@ -48,6 +49,8 @@ static inline void rdmsr_gs_base(void)
 
 void l2_guest_code(void)
 {
+	u64 unused;
+
 	GUEST_SYNC(7);
 
 	GUEST_SYNC(8);
@@ -64,15 +67,33 @@ void l2_guest_code(void)
 	vmcall();
 	rdmsr_gs_base(); /* intercepted */
 
+	/* L2 TLB flush tests */
+	hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE | HV_HYPERCALL_FAST_BIT, 0x0,
+			   HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES | HV_FLUSH_ALL_PROCESSORS);
+	rdmsr_fs_base();
+	/*
+	 * Note: hypercall status (RAX) is not preserved correctly by L1 after
+	 * synthetic vmexit, use unchecked version.
+	 */
+	__hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE | HV_HYPERCALL_FAST_BIT, 0x0,
+			   HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES | HV_FLUSH_ALL_PROCESSORS,
+			   &unused);
+	/* Make sure we're no issuing Hyper-V TLB flush call again */
+	__asm__ __volatile__ ("mov $0xdeadbeef, %rcx");
+
 	/* Done, exit to L1 and never come back.  */
 	vmcall();
 }
 
-void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages)
+void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
+		vm_vaddr_t hv_hcall_page_gpa)
 {
 #define L2_GUEST_STACK_SIZE 64
 	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+	wrmsr(HV_X64_MSR_HYPERCALL, hv_hcall_page_gpa);
+
 	x2apic_enable();
 
 	GUEST_SYNC(1);
@@ -102,6 +123,14 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages)
 	vmwrite(PIN_BASED_VM_EXEC_CONTROL, vmreadz(PIN_BASED_VM_EXEC_CONTROL) |
 		PIN_BASED_NMI_EXITING);
 
+	/* L2 TLB flush setup */
+	current_evmcs->partition_assist_page = hv_pages->partition_assist_gpa;
+	current_evmcs->hv_enlightenments_control.nested_flush_hypercall = 1;
+	current_evmcs->hv_vm_id = 1;
+	current_evmcs->hv_vp_id = 1;
+	current_vp_assist->nested_control.features.directhypercall = 1;
+	*(u32 *)(hv_pages->partition_assist) = 0;
+
 	GUEST_ASSERT(!vmlaunch());
 	GUEST_ASSERT(vmptrstz() == hv_pages->enlightened_vmcs_gpa);
 
@@ -146,6 +175,18 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages)
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
 	current_evmcs->guest_rip += 2; /* rdmsr */
 
+	/*
+	 * L2 TLB flush test. First VMCALL should be handled directly by L0,
+	 * no VMCALL exit expected.
+	 */
+	GUEST_ASSERT(!vmresume());
+	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_MSR_READ);
+	current_evmcs->guest_rip += 2; /* rdmsr */
+	/* Enable synthetic vmexit */
+	*(u32 *)(hv_pages->partition_assist) = 1;
+	GUEST_ASSERT(!vmresume());
+	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == HV_VMX_SYNTHETIC_EXIT_REASON_TRAP_AFTER_FLUSH);
+
 	GUEST_ASSERT(!vmresume());
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	GUEST_SYNC(11);
@@ -199,6 +240,7 @@ static struct kvm_vcpu *save_restore_vm(struct kvm_vm *vm,
 int main(int argc, char *argv[])
 {
 	vm_vaddr_t vmx_pages_gva = 0, hv_pages_gva = 0;
+	vm_vaddr_t hcall_page;
 
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -212,12 +254,16 @@ int main(int argc, char *argv[])
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS));
 
+	hcall_page = vm_vaddr_alloc_pages(vm, 1);
+	memset(addr_gva2hva(vm, hcall_page), 0x0,  getpagesize());
+
 	vcpu_set_hv_cpuid(vcpu);
 	vcpu_enable_evmcs(vcpu);
 
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
 	vcpu_alloc_hyperv_test_pages(vm, &hv_pages_gva);
-	vcpu_args_set(vcpu, 2, vmx_pages_gva, hv_pages_gva);
+	vcpu_args_set(vcpu, 3, vmx_pages_gva, hv_pages_gva, addr_gva2gpa(vm, hcall_page));
+	vcpu_set_msr(vcpu, HV_X64_MSR_VP_INDEX, vcpu->id);
 
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
-- 
2.37.3

