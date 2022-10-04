Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06685F43C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJDM7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJDM7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD5D5FF73
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664888161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJV5cwIs6IluN16zoA0wFyZidP8NwUMV1q5jnEor5v8=;
        b=O7FbuTHs/GdTfs+YlsyCtGLjO7jeBD3l305PSWp5m1f0YXeoLhvXJ87d7xLF6zl+Xbr4e8
        tvihHOCspau0Qa/sVJKxJhwAuaeIqqnLh+q+bwyNC1Yk3MWiI86uNWQzgyoLGXW8q5E1iv
        SBsJ7hm/GOlZ3s8JbG894433g4O4dl0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-SUhe_7lJNGuNERbdJg2kcw-1; Tue, 04 Oct 2022 08:41:21 -0400
X-MC-Unique: SUhe_7lJNGuNERbdJg2kcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4118299E761;
        Tue,  4 Oct 2022 12:41:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 502BC7AE5;
        Tue,  4 Oct 2022 12:41:18 +0000 (UTC)
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
Subject: [PATCH v11 33/46] KVM: selftests: Hyper-V PV IPI selftest
Date:   Tue,  4 Oct 2022 14:39:43 +0200
Message-Id: <20221004123956.188909-34-vkuznets@redhat.com>
In-Reply-To: <20221004123956.188909-1-vkuznets@redhat.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a selftest for Hyper-V PV IPI hypercalls
(HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx).

The test creates one 'sender' vCPU and two 'receiver' vCPU and then
issues various combinations of send IPI hypercalls in both 'normal'
and 'fast' (with XMM input where necessary) mode. Later, the test
checks whether IPIs were delivered to the expected destination vCPU[s].

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/x86_64/hyperv.h     |  35 +-
 .../selftests/kvm/x86_64/hyperv_features.c    |   2 +-
 .../testing/selftests/kvm/x86_64/hyperv_ipi.c | 330 ++++++++++++++++++
 5 files changed, 365 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/hyperv_ipi.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 45d9aee1c0d8..70a853711f9f 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -24,6 +24,7 @@
 /x86_64/hyperv_clock
 /x86_64/hyperv_cpuid
 /x86_64/hyperv_features
+/x86_64/hyperv_ipi
 /x86_64/hyperv_svm_test
 /x86_64/max_vcpuid_cap_test
 /x86_64/mmio_warning_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 8b1b32628ac8..e13dbf35947b 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -84,6 +84,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/fix_hypercall_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_clock
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_features
+TEST_GEN_PROGS_x86_64 += x86_64/hyperv_ipi
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_svm_test
 TEST_GEN_PROGS_x86_64 += x86_64/kvm_clock_test
 TEST_GEN_PROGS_x86_64 += x86_64/kvm_pv_test
diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
index 40f8b1b423fc..d299064fe2b1 100644
--- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
+++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
@@ -9,6 +9,8 @@
 #ifndef SELFTEST_KVM_HYPERV_H
 #define SELFTEST_KVM_HYPERV_H
 
+#include "processor.h"
+
 #define HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS	0x40000000
 #define HYPERV_CPUID_INTERFACE			0x40000001
 #define HYPERV_CPUID_VERSION			0x40000002
@@ -184,10 +186,15 @@
 
 /* hypercall options */
 #define HV_HYPERCALL_FAST_BIT		BIT(16)
+#define HV_HYPERCALL_VARHEAD_OFFSET	17
 
-static inline uint8_t hyperv_hypercall(u64 control, vm_vaddr_t input_address,
-				       vm_vaddr_t output_address,
-				       uint64_t *hv_status)
+/*
+ * Issue a Hyper-V hypercall. Returns exception vector raised or 0, 'hv_status'
+ * is set to the hypercall status (if no exception occurred).
+ */
+static inline uint8_t __hyperv_hypercall(u64 control, vm_vaddr_t input_address,
+					 vm_vaddr_t output_address,
+					 uint64_t *hv_status)
 {
 	uint8_t vector;
 
@@ -203,6 +210,28 @@ static inline uint8_t hyperv_hypercall(u64 control, vm_vaddr_t input_address,
 	return vector;
 }
 
+/* Issue a Hyper-V hypercall and assert that it succeeded. */
+static inline void hyperv_hypercall(u64 control, vm_vaddr_t input_address,
+				    vm_vaddr_t output_address)
+{
+	uint64_t hv_status;
+	uint8_t vector;
+
+	vector = __hyperv_hypercall(control, input_address, output_address, &hv_status);
+
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT((hv_status & 0xffff) == 0);
+}
+
+/* Write 'Fast' hypercall input 'data' to the first 'n_sse_regs' SSE regs */
+static inline void hyperv_write_xmm_input(void *data, int n_sse_regs)
+{
+	int i;
+
+	for (i = 0; i < n_sse_regs; i++)
+		write_sse_reg(i, (sse128_t *)(data + sizeof(sse128_t) * i));
+}
+
 /* Proper HV_X64_MSR_GUEST_OS_ID value */
 #define HYPERV_LINUX_OS_ID ((u64)0x8100 << 48)
 
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 5ff4ff2365bb..3163c3e8db0a 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -62,7 +62,7 @@ static void guest_hcall(vm_vaddr_t pgs_gpa, struct hcall_data *hcall)
 		input = output = 0;
 	}
 
-	vector = hyperv_hypercall(hcall->control, input, output, &res);
+	vector = __hyperv_hypercall(hcall->control, input, output, &res);
 	if (hcall->ud_expected) {
 		GUEST_ASSERT_2(vector == UD_VECTOR, hcall->control, vector);
 	} else {
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c b/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
new file mode 100644
index 000000000000..1d99741e339d
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_ipi.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hyper-V HvCallSendSyntheticClusterIpi{,Ex} tests
+ *
+ * Copyright (C) 2022, Red Hat, Inc.
+ *
+ */
+
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <pthread.h>
+#include <inttypes.h>
+
+#include "kvm_util.h"
+#include "hyperv.h"
+#include "test_util.h"
+#include "vmx.h"
+
+#define RECEIVER_VCPU_ID_1 2
+#define RECEIVER_VCPU_ID_2 65
+
+#define IPI_VECTOR	 0xfe
+
+static volatile uint64_t ipis_rcvd[RECEIVER_VCPU_ID_2 + 1];
+
+struct hv_vpset {
+	u64 format;
+	u64 valid_bank_mask;
+	u64 bank_contents[2];
+};
+
+enum HV_GENERIC_SET_FORMAT {
+	HV_GENERIC_SET_SPARSE_4K,
+	HV_GENERIC_SET_ALL,
+};
+
+/* HvCallSendSyntheticClusterIpi hypercall */
+struct hv_send_ipi {
+	u32 vector;
+	u32 reserved;
+	u64 cpu_mask;
+};
+
+/* HvCallSendSyntheticClusterIpiEx hypercall */
+struct hv_send_ipi_ex {
+	u32 vector;
+	u32 reserved;
+	struct hv_vpset vp_set;
+};
+
+static inline void hv_init(vm_vaddr_t pgs_gpa)
+{
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+	wrmsr(HV_X64_MSR_HYPERCALL, pgs_gpa);
+}
+
+static void receiver_code(void *hcall_page, vm_vaddr_t pgs_gpa)
+{
+	u32 vcpu_id;
+
+	x2apic_enable();
+	hv_init(pgs_gpa);
+
+	vcpu_id = rdmsr(HV_X64_MSR_VP_INDEX);
+
+	/* Signal sender vCPU we're ready */
+	ipis_rcvd[vcpu_id] = (u64)-1;
+
+	for (;;)
+		asm volatile("sti; hlt; cli");
+}
+
+static void guest_ipi_handler(struct ex_regs *regs)
+{
+	u32 vcpu_id = rdmsr(HV_X64_MSR_VP_INDEX);
+
+	ipis_rcvd[vcpu_id]++;
+	wrmsr(HV_X64_MSR_EOI, 1);
+}
+
+static inline void nop_loop(void)
+{
+	int i;
+
+	for (i = 0; i < 100000000; i++)
+		asm volatile("nop");
+}
+
+static void sender_guest_code(void *hcall_page, vm_vaddr_t pgs_gpa)
+{
+	struct hv_send_ipi *ipi = (struct hv_send_ipi *)hcall_page;
+	struct hv_send_ipi_ex *ipi_ex = (struct hv_send_ipi_ex *)hcall_page;
+	int stage = 1, ipis_expected[2] = {0};
+
+	hv_init(pgs_gpa);
+	GUEST_SYNC(stage++);
+
+	/* Wait for receiver vCPUs to come up */
+	while (!ipis_rcvd[RECEIVER_VCPU_ID_1] || !ipis_rcvd[RECEIVER_VCPU_ID_2])
+		nop_loop();
+	ipis_rcvd[RECEIVER_VCPU_ID_1] = ipis_rcvd[RECEIVER_VCPU_ID_2] = 0;
+
+	/* 'Slow' HvCallSendSyntheticClusterIpi to RECEIVER_VCPU_ID_1 */
+	ipi->vector = IPI_VECTOR;
+	ipi->cpu_mask = 1 << RECEIVER_VCPU_ID_1;
+	hyperv_hypercall(HVCALL_SEND_IPI, pgs_gpa, pgs_gpa + 4096);
+	nop_loop();
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_1] == ++ipis_expected[0]);
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_2] == ipis_expected[1]);
+	GUEST_SYNC(stage++);
+	/* 'Fast' HvCallSendSyntheticClusterIpi to RECEIVER_VCPU_ID_1 */
+	hyperv_hypercall(HVCALL_SEND_IPI | HV_HYPERCALL_FAST_BIT,
+			 IPI_VECTOR, 1 << RECEIVER_VCPU_ID_1);
+	nop_loop();
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_1] == ++ipis_expected[0]);
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_2] == ipis_expected[1]);
+	GUEST_SYNC(stage++);
+
+	/* 'Slow' HvCallSendSyntheticClusterIpiEx to RECEIVER_VCPU_ID_1 */
+	memset(hcall_page, 0, 4096);
+	ipi_ex->vector = IPI_VECTOR;
+	ipi_ex->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
+	ipi_ex->vp_set.valid_bank_mask = 1 << 0;
+	ipi_ex->vp_set.bank_contents[0] = BIT(RECEIVER_VCPU_ID_1);
+	hyperv_hypercall(HVCALL_SEND_IPI_EX | (1 << HV_HYPERCALL_VARHEAD_OFFSET),
+			 pgs_gpa, pgs_gpa + 4096);
+	nop_loop();
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_1] == ++ipis_expected[0]);
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_2] == ipis_expected[1]);
+	GUEST_SYNC(stage++);
+	/* 'XMM Fast' HvCallSendSyntheticClusterIpiEx to RECEIVER_VCPU_ID_1 */
+	hyperv_write_xmm_input(&ipi_ex->vp_set.valid_bank_mask, 1);
+	hyperv_hypercall(HVCALL_SEND_IPI_EX | HV_HYPERCALL_FAST_BIT |
+			 (1 << HV_HYPERCALL_VARHEAD_OFFSET),
+			 IPI_VECTOR, HV_GENERIC_SET_SPARSE_4K);
+	nop_loop();
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_1] == ++ipis_expected[0]);
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_2] == ipis_expected[1]);
+	GUEST_SYNC(stage++);
+
+	/* 'Slow' HvCallSendSyntheticClusterIpiEx to RECEIVER_VCPU_ID_2 */
+	memset(hcall_page, 0, 4096);
+	ipi_ex->vector = IPI_VECTOR;
+	ipi_ex->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
+	ipi_ex->vp_set.valid_bank_mask = 1 << 1;
+	ipi_ex->vp_set.bank_contents[0] = BIT(RECEIVER_VCPU_ID_2 - 64);
+	hyperv_hypercall(HVCALL_SEND_IPI_EX | (1 << HV_HYPERCALL_VARHEAD_OFFSET),
+			 pgs_gpa, pgs_gpa + 4096);
+	nop_loop();
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_1] == ipis_expected[0]);
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_2] == ++ipis_expected[1]);
+	GUEST_SYNC(stage++);
+	/* 'XMM Fast' HvCallSendSyntheticClusterIpiEx to RECEIVER_VCPU_ID_2 */
+	hyperv_write_xmm_input(&ipi_ex->vp_set.valid_bank_mask, 1);
+	hyperv_hypercall(HVCALL_SEND_IPI_EX | HV_HYPERCALL_FAST_BIT |
+			 (1 << HV_HYPERCALL_VARHEAD_OFFSET),
+			 IPI_VECTOR, HV_GENERIC_SET_SPARSE_4K);
+	nop_loop();
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_1] == ipis_expected[0]);
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_2] == ++ipis_expected[1]);
+	GUEST_SYNC(stage++);
+
+	/* 'Slow' HvCallSendSyntheticClusterIpiEx to both RECEIVER_VCPU_ID_{1,2} */
+	memset(hcall_page, 0, 4096);
+	ipi_ex->vector = IPI_VECTOR;
+	ipi_ex->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
+	ipi_ex->vp_set.valid_bank_mask = 1 << 1 | 1;
+	ipi_ex->vp_set.bank_contents[0] = BIT(RECEIVER_VCPU_ID_1);
+	ipi_ex->vp_set.bank_contents[1] = BIT(RECEIVER_VCPU_ID_2 - 64);
+	hyperv_hypercall(HVCALL_SEND_IPI_EX | (2 << HV_HYPERCALL_VARHEAD_OFFSET),
+			 pgs_gpa, pgs_gpa + 4096);
+	nop_loop();
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_1] == ++ipis_expected[0]);
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_2] == ++ipis_expected[1]);
+	GUEST_SYNC(stage++);
+	/* 'XMM Fast' HvCallSendSyntheticClusterIpiEx to both RECEIVER_VCPU_ID_{1, 2} */
+	hyperv_write_xmm_input(&ipi_ex->vp_set.valid_bank_mask, 2);
+	hyperv_hypercall(HVCALL_SEND_IPI_EX | HV_HYPERCALL_FAST_BIT |
+			 (2 << HV_HYPERCALL_VARHEAD_OFFSET),
+			 IPI_VECTOR, HV_GENERIC_SET_SPARSE_4K);
+	nop_loop();
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_1] == ++ipis_expected[0]);
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_2] == ++ipis_expected[1]);
+	GUEST_SYNC(stage++);
+
+	/* 'Slow' HvCallSendSyntheticClusterIpiEx to HV_GENERIC_SET_ALL */
+	memset(hcall_page, 0, 4096);
+	ipi_ex->vector = IPI_VECTOR;
+	ipi_ex->vp_set.format = HV_GENERIC_SET_ALL;
+	hyperv_hypercall(HVCALL_SEND_IPI_EX, pgs_gpa, pgs_gpa + 4096);
+	nop_loop();
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_1] == ++ipis_expected[0]);
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_2] == ++ipis_expected[1]);
+	GUEST_SYNC(stage++);
+	/*
+	 * 'XMM Fast' HvCallSendSyntheticClusterIpiEx to HV_GENERIC_SET_ALL.
+	 * Nothing to write anything to XMM regs.
+	 */
+	hyperv_hypercall(HVCALL_SEND_IPI_EX | HV_HYPERCALL_FAST_BIT,
+			 IPI_VECTOR, HV_GENERIC_SET_ALL);
+	nop_loop();
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_1] == ++ipis_expected[0]);
+	GUEST_ASSERT(ipis_rcvd[RECEIVER_VCPU_ID_2] == ++ipis_expected[1]);
+	GUEST_SYNC(stage++);
+
+	GUEST_DONE();
+}
+
+static void *vcpu_thread(void *arg)
+{
+	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)arg;
+	struct ucall uc;
+	int old;
+	int r;
+	unsigned int exit_reason;
+
+	r = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &old);
+	TEST_ASSERT(r == 0,
+		    "pthread_setcanceltype failed on vcpu_id=%u with errno=%d",
+		    vcpu->id, r);
+
+	vcpu_run(vcpu);
+	exit_reason = vcpu->run->exit_reason;
+
+	TEST_ASSERT(exit_reason == KVM_EXIT_IO,
+		    "vCPU %u exited with unexpected exit reason %u-%s, expected KVM_EXIT_IO",
+		    vcpu->id, exit_reason, exit_reason_str(exit_reason));
+
+	if (get_ucall(vcpu, &uc) == UCALL_ABORT) {
+		TEST_ASSERT(false,
+			    "vCPU %u exited with error: %s.\n",
+			    vcpu->id, (const char *)uc.args[0]);
+	}
+
+	return NULL;
+}
+
+static void cancel_join_vcpu_thread(pthread_t thread, struct kvm_vcpu *vcpu)
+{
+	void *retval;
+	int r;
+
+	r = pthread_cancel(thread);
+	TEST_ASSERT(r == 0,
+		    "pthread_cancel on vcpu_id=%d failed with errno=%d",
+		    vcpu->id, r);
+
+	r = pthread_join(thread, &retval);
+	TEST_ASSERT(r == 0,
+		    "pthread_join on vcpu_id=%d failed with errno=%d",
+		    vcpu->id, r);
+	TEST_ASSERT(retval == PTHREAD_CANCELED,
+		    "expected retval=%p, got %p", PTHREAD_CANCELED,
+		    retval);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu[3];
+	unsigned int exit_reason;
+	vm_vaddr_t hcall_page;
+	pthread_t threads[2];
+	int stage = 1, r;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu[0], sender_guest_code);
+
+	/* Hypercall input/output */
+	hcall_page = vm_vaddr_alloc_pages(vm, 2);
+	memset(addr_gva2hva(vm, hcall_page), 0x0, 2 * getpagesize());
+
+	vm_init_descriptor_tables(vm);
+
+	vcpu[1] = vm_vcpu_add(vm, RECEIVER_VCPU_ID_1, receiver_code);
+	vcpu_init_descriptor_tables(vcpu[1]);
+	vcpu_args_set(vcpu[1], 2, hcall_page, addr_gva2gpa(vm, hcall_page));
+	vcpu_set_msr(vcpu[1], HV_X64_MSR_VP_INDEX, RECEIVER_VCPU_ID_1);
+	vcpu_set_hv_cpuid(vcpu[1]);
+
+	vcpu[2] = vm_vcpu_add(vm, RECEIVER_VCPU_ID_2, receiver_code);
+	vcpu_init_descriptor_tables(vcpu[2]);
+	vcpu_args_set(vcpu[2], 2, hcall_page, addr_gva2gpa(vm, hcall_page));
+	vcpu_set_msr(vcpu[2], HV_X64_MSR_VP_INDEX, RECEIVER_VCPU_ID_2);
+	vcpu_set_hv_cpuid(vcpu[2]);
+
+	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler);
+
+	vcpu_args_set(vcpu[0], 2, hcall_page, addr_gva2gpa(vm, hcall_page));
+	vcpu_set_hv_cpuid(vcpu[0]);
+
+	r = pthread_create(&threads[0], NULL, vcpu_thread, vcpu[1]);
+	TEST_ASSERT(r == 0,
+		    "pthread_create halter failed errno=%d", errno);
+
+	r = pthread_create(&threads[1], NULL, vcpu_thread, vcpu[2]);
+	TEST_ASSERT(r == 0,
+		    "pthread_create halter failed errno=%d", errno);
+
+	while (true) {
+		r = _vcpu_run(vcpu[0]);
+		exit_reason = vcpu[0]->run->exit_reason;
+
+		TEST_ASSERT(!r, "vcpu_run failed: %d\n", r);
+		TEST_ASSERT(exit_reason == KVM_EXIT_IO,
+			    "unexpected exit reason: %u (%s)",
+			    exit_reason, exit_reason_str(exit_reason));
+
+		switch (get_ucall(vcpu[0], &uc)) {
+		case UCALL_SYNC:
+			TEST_ASSERT(uc.args[1] == stage,
+				    "Unexpected stage: %ld (%d expected)\n",
+				    uc.args[1], stage);
+			break;
+		case UCALL_ABORT:
+			TEST_FAIL("%s at %s:%ld", (const char *)uc.args[0],
+				  __FILE__, uc.args[1]);
+			return 1;
+		case UCALL_DONE:
+			return 0;
+		}
+
+		stage++;
+	}
+
+	cancel_join_vcpu_thread(threads[0], vcpu[1]);
+	cancel_join_vcpu_thread(threads[1], vcpu[2]);
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.37.3

