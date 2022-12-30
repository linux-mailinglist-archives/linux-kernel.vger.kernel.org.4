Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D743C652243
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiLTOQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiLTOQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:16:18 -0500
X-Greylist: delayed 2067 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Dec 2022 06:16:17 PST
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F029FEA;
        Tue, 20 Dec 2022 06:16:16 -0800 (PST)
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <pdurrant@amazon.com>)
        id 1p7csU-00012o-Dn; Tue, 20 Dec 2022 13:41:54 +0000
Received: from 54-240-197-227.amazon.com ([54.240.197.227] helo=debian.cbg12.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pdurrant@amazon.com>)
        id 1p7csU-0002HU-4d; Tue, 20 Dec 2022 13:41:54 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paul Durrant <pdurrant@amazon.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v6 2/2] KVM: x86/xen: update Xen CPUID Leaf 4 (tsc info) sub-leaves, if present
Date:   Tue, 20 Dec 2022 13:40:53 +0000
Message-Id: <20221220134053.15591-3-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221220134053.15591-1-pdurrant@amazon.com>
References: <20221220134053.15591-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_ADSP_ALL,
        RCVD_IN_DNSWL_MED,SPF_FAIL,SPF_HELO_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scaling information in subleaf 1 should match the values set by KVM in
the 'vcpu_info' sub-structure 'time_info' (a.k.a. pvclock_vcpu_time_info)
which is shared with the guest, but is not directly available to the VMM.
The offset values are not set since a TSC offset is already applied.
The TSC frequency should also be set in sub-leaf 2.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Woodhouse <dwmw2@infradead.org>

v6:
 - Stash Xen cpuid base and limit values when cpuid is set
 - Re-name kvm_xen_setup_tsc_info() to kvm_xen_update_tsc_info()

v5:
 - Drop the caching of the CPUID entry pointers and only update the
   sub-leaves if the CPU frequency has actually changed

v4:
 - Update commit comment

v3:
 - Add leaf limit check in kvm_xen_set_cpuid()

v2:
 - Make sure sub-leaf pointers are NULLed if the time leaf is removed
---
 arch/x86/include/asm/kvm_host.h | 11 ++++++-----
 arch/x86/kvm/cpuid.c            |  2 ++
 arch/x86/kvm/x86.c              |  1 +
 arch/x86/kvm/xen.c              | 26 ++++++++++++++++++++++++++
 arch/x86/kvm/xen.h              |  7 +++++++
 5 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ff201ad35551..44329594bdf7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -678,6 +678,11 @@ struct kvm_vcpu_hv {
 	} nested;
 };
 
+struct kvm_hypervisor_cpuid {
+	u32 base;
+	u32 limit;
+};
+
 /* Xen HVM per vcpu emulation context */
 struct kvm_vcpu_xen {
 	u64 hypercall_rip;
@@ -698,6 +703,7 @@ struct kvm_vcpu_xen {
 	struct hrtimer timer;
 	int poll_evtchn;
 	struct timer_list poll_timer;
+	struct kvm_hypervisor_cpuid cpuid;
 };
 
 struct kvm_queued_exception {
@@ -710,11 +716,6 @@ struct kvm_queued_exception {
 	bool has_payload;
 };
 
-struct kvm_hypervisor_cpuid {
-	u32 base;
-	u32 limit;
-};
-
 struct kvm_vcpu_arch {
 	/*
 	 * rip and regs accesses must go through
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2468720f8d84..e661413ddf8d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -25,6 +25,7 @@
 #include "mmu.h"
 #include "trace.h"
 #include "pmu.h"
+#include "xen.h"
 
 /*
  * Unlike "struct cpuinfo_x86.x86_capability", kvm_cpu_caps doesn't need to be
@@ -441,6 +442,7 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 	vcpu->arch.cpuid_nent = nent;
 
 	kvm_update_hypervisor_cpuid(vcpu, KVM_SIGNATURE, &vcpu->arch.kvm_cpuid);
+	kvm_update_hypervisor_cpuid(vcpu, XEN_SIGNATURE, &vcpu->arch.xen.cpuid);
 	kvm_vcpu_after_set_cpuid(vcpu);
 
 	return 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fd6c01a39312..60acc55f0c00 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3158,6 +3158,7 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 				   &vcpu->hv_clock.tsc_shift,
 				   &vcpu->hv_clock.tsc_to_system_mul);
 		vcpu->hw_tsc_khz = tgt_tsc_khz;
+		kvm_xen_update_tsc_info(v);
 	}
 
 	vcpu->hv_clock.tsc_timestamp = tsc_timestamp;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index d7af40240248..46297521791c 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -22,6 +22,9 @@
 #include <xen/interface/event_channel.h>
 #include <xen/interface/sched.h>
 
+#include <asm/xen/cpuid.h>
+
+#include "cpuid.h"
 #include "trace.h"
 
 static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm);
@@ -2061,6 +2064,29 @@ void kvm_xen_destroy_vcpu(struct kvm_vcpu *vcpu)
 	del_timer_sync(&vcpu->arch.xen.poll_timer);
 }
 
+void kvm_xen_update_tsc_info(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *entry;
+	u32 function;
+
+	if (!vcpu->arch.xen.cpuid.base)
+		return;
+
+	function = vcpu->arch.xen.cpuid.base | XEN_CPUID_LEAF(3);
+	if (function > vcpu->arch.xen.cpuid.limit)
+		return;
+
+	entry = kvm_find_cpuid_entry_index(vcpu, function, 1);
+	if (entry) {
+		entry->ecx = vcpu->arch.hv_clock.tsc_to_system_mul;
+		entry->edx = vcpu->arch.hv_clock.tsc_shift;
+	}
+
+	entry = kvm_find_cpuid_entry_index(vcpu, function, 2);
+	if (entry)
+		entry->eax = vcpu->arch.hw_tsc_khz;
+}
+
 void kvm_xen_init_vm(struct kvm *kvm)
 {
 	idr_init(&kvm->arch.xen.evtchn_ports);
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index ea33d80a0c51..88dd085e10f8 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -32,6 +32,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe,
 int kvm_xen_setup_evtchn(struct kvm *kvm,
 			 struct kvm_kernel_irq_routing_entry *e,
 			 const struct kvm_irq_routing_entry *ue);
+void kvm_xen_update_tsc_info(struct kvm_vcpu *vcpu);
 
 static inline bool kvm_xen_msr_enabled(struct kvm *kvm)
 {
@@ -135,6 +136,10 @@ static inline bool kvm_xen_timer_enabled(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
+
+static inline void kvm_xen_update_tsc_info(struct kvm_vcpu *vcpu)
+{
+}
 #endif
 
 int kvm_xen_hypercall(struct kvm_vcpu *vcpu);
@@ -143,6 +148,8 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu);
 #include <asm/xen/interface.h>
 #include <xen/interface/vcpu.h>
 
+#define XEN_SIGNATURE "XenVMMXenVMM"
+
 void kvm_xen_update_runstate(struct kvm_vcpu *vcpu, int state);
 
 static inline void kvm_xen_runstate_set_running(struct kvm_vcpu *vcpu)
-- 
2.20.1

