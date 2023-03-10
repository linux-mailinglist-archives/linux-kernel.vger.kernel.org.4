Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138FD6B5201
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjCJUeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjCJUdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:33:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD4718B17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:33:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FCCCB82403
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 20:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8015EC433A1;
        Fri, 10 Mar 2023 20:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678480310;
        bh=qMXFE2QpBff7KMyqc4AG0xYnUKng/KHjtSGW+0DAOko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=el9XcffuQmHP/XhWiD/xUbgnILI7z87CcpYivmuxImz8T7YvyOudi2Vzs8v6sFbhR
         TOKWrYIrPTJ5IqqJBRuz5kjegdEPi/x1+H0jb2nWOQGNlscJjOgl8n0x8i1uDb5mu/
         mfdUtre92689YIba0xgNu6oeM9Wr2rK3HJ2+67uqDpu6WO+iOUl9Hgn++c0TBELG5D
         WI3ejyeXZOG0T1JlOUnfhfqcRzmwLSotHAuVG9Hfg6bHYrQgyd9rH1y63hoDDN7CNw
         tEv3AbVdC2KXRy6tZiXxogdPSBBL8358VOTOJbsBUizpAui0iWuf8FFovxOtybXRnm
         fushUaCoeA/kg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC][PATCH 5/5] x86/kvm: Simplify static call handling
Date:   Fri, 10 Mar 2023 12:31:17 -0800
Message-Id: <432e4844ba65840af4a24f5e3f561aead867f6e7.1678474914.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678474914.git.jpoimboe@kernel.org>
References: <cover.1678474914.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static calls with a NULL function pointer are now "do nothing return 0"
functions by default.  Simplify the KVM static call handling
accordingly.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/kvm-x86-ops.h     | 85 ++++++++++++--------------
 arch/x86/include/asm/kvm-x86-pmu-ops.h | 16 ++---
 arch/x86/include/asm/kvm_host.h        |  2 -
 arch/x86/kvm/pmu.c                     |  7 +--
 arch/x86/kvm/x86.c                     | 12 +---
 5 files changed, 48 insertions(+), 74 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 2f0bfd910637..ea18a8abf4a1 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -1,17 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#if !defined(KVM_X86_OP) || !defined(KVM_X86_OP_OPTIONAL)
+#if !defined(KVM_X86_OP)
 BUILD_BUG_ON(1)
 #endif
 
 /*
- * KVM_X86_OP() and KVM_X86_OP_OPTIONAL() are used to help generate
- * both DECLARE/DEFINE_STATIC_CALL() invocations and
- * "static_call_update()" calls.
- *
- * KVM_X86_OP_OPTIONAL() can be used for those functions that can have
- * a NULL definition.  KVM_X86_OP_OPTIONAL_RET0() can be used likewise
- * to make a definition optional, but in this case the default will
- * be __static_call_return0.
+ * KVM_X86_OP() is used to help generate both DECLARE/DEFINE_STATIC_CALL()
+ * invocations and "static_call_update()" calls.  Note that NULL static calls
+ * default to "do-nothing return 0" functions.
  */
 KVM_X86_OP(check_processor_compatibility)
 KVM_X86_OP(hardware_enable)
@@ -20,8 +15,8 @@ KVM_X86_OP(hardware_unsetup)
 KVM_X86_OP(has_emulated_msr)
 KVM_X86_OP(vcpu_after_set_cpuid)
 KVM_X86_OP(vm_init)
-KVM_X86_OP_OPTIONAL(vm_destroy)
-KVM_X86_OP_OPTIONAL_RET0(vcpu_precreate)
+KVM_X86_OP(vm_destroy)
+KVM_X86_OP(vcpu_precreate)
 KVM_X86_OP(vcpu_create)
 KVM_X86_OP(vcpu_free)
 KVM_X86_OP(vcpu_reset)
@@ -37,7 +32,7 @@ KVM_X86_OP(get_cpl)
 KVM_X86_OP(set_segment)
 KVM_X86_OP(get_cs_db_l_bits)
 KVM_X86_OP(set_cr0)
-KVM_X86_OP_OPTIONAL(post_set_cr3)
+KVM_X86_OP(post_set_cr3)
 KVM_X86_OP(is_valid_cr4)
 KVM_X86_OP(set_cr4)
 KVM_X86_OP(set_efer)
@@ -53,15 +48,15 @@ KVM_X86_OP(set_rflags)
 KVM_X86_OP(get_if_flag)
 KVM_X86_OP(flush_tlb_all)
 KVM_X86_OP(flush_tlb_current)
-KVM_X86_OP_OPTIONAL(tlb_remote_flush)
-KVM_X86_OP_OPTIONAL(tlb_remote_flush_with_range)
+KVM_X86_OP(tlb_remote_flush)
+KVM_X86_OP(tlb_remote_flush_with_range)
 KVM_X86_OP(flush_tlb_gva)
 KVM_X86_OP(flush_tlb_guest)
 KVM_X86_OP(vcpu_pre_run)
 KVM_X86_OP(vcpu_run)
 KVM_X86_OP(handle_exit)
 KVM_X86_OP(skip_emulated_instruction)
-KVM_X86_OP_OPTIONAL(update_emulated_instruction)
+KVM_X86_OP(update_emulated_instruction)
 KVM_X86_OP(set_interrupt_shadow)
 KVM_X86_OP(get_interrupt_shadow)
 KVM_X86_OP(patch_hypercall)
@@ -75,19 +70,19 @@ KVM_X86_OP(get_nmi_mask)
 KVM_X86_OP(set_nmi_mask)
 KVM_X86_OP(enable_nmi_window)
 KVM_X86_OP(enable_irq_window)
-KVM_X86_OP_OPTIONAL(update_cr8_intercept)
+KVM_X86_OP(update_cr8_intercept)
 KVM_X86_OP(refresh_apicv_exec_ctrl)
-KVM_X86_OP_OPTIONAL(hwapic_irr_update)
-KVM_X86_OP_OPTIONAL(hwapic_isr_update)
-KVM_X86_OP_OPTIONAL_RET0(guest_apic_has_interrupt)
-KVM_X86_OP_OPTIONAL(load_eoi_exitmap)
-KVM_X86_OP_OPTIONAL(set_virtual_apic_mode)
-KVM_X86_OP_OPTIONAL(set_apic_access_page_addr)
+KVM_X86_OP(hwapic_irr_update)
+KVM_X86_OP(hwapic_isr_update)
+KVM_X86_OP(guest_apic_has_interrupt)
+KVM_X86_OP(load_eoi_exitmap)
+KVM_X86_OP(set_virtual_apic_mode)
+KVM_X86_OP(set_apic_access_page_addr)
 KVM_X86_OP(deliver_interrupt)
-KVM_X86_OP_OPTIONAL(sync_pir_to_irr)
-KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
-KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
-KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
+KVM_X86_OP(sync_pir_to_irr)
+KVM_X86_OP(set_tss_addr)
+KVM_X86_OP(set_identity_map_addr)
+KVM_X86_OP(get_mt_mask)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP(has_wbinvd_exit)
 KVM_X86_OP(get_l2_tsc_offset)
@@ -99,15 +94,15 @@ KVM_X86_OP(check_intercept)
 KVM_X86_OP(handle_exit_irqoff)
 KVM_X86_OP(request_immediate_exit)
 KVM_X86_OP(sched_in)
-KVM_X86_OP_OPTIONAL(update_cpu_dirty_logging)
-KVM_X86_OP_OPTIONAL(vcpu_blocking)
-KVM_X86_OP_OPTIONAL(vcpu_unblocking)
-KVM_X86_OP_OPTIONAL(pi_update_irte)
-KVM_X86_OP_OPTIONAL(pi_start_assignment)
-KVM_X86_OP_OPTIONAL(apicv_post_state_restore)
-KVM_X86_OP_OPTIONAL_RET0(dy_apicv_has_pending_interrupt)
-KVM_X86_OP_OPTIONAL(set_hv_timer)
-KVM_X86_OP_OPTIONAL(cancel_hv_timer)
+KVM_X86_OP(update_cpu_dirty_logging)
+KVM_X86_OP(vcpu_blocking)
+KVM_X86_OP(vcpu_unblocking)
+KVM_X86_OP(pi_update_irte)
+KVM_X86_OP(pi_start_assignment)
+KVM_X86_OP(apicv_post_state_restore)
+KVM_X86_OP(dy_apicv_has_pending_interrupt)
+KVM_X86_OP(set_hv_timer)
+KVM_X86_OP(cancel_hv_timer)
 KVM_X86_OP(setup_mce)
 #ifdef CONFIG_KVM_SMM
 KVM_X86_OP(smi_allowed)
@@ -115,22 +110,20 @@ KVM_X86_OP(enter_smm)
 KVM_X86_OP(leave_smm)
 KVM_X86_OP(enable_smi_window)
 #endif
-KVM_X86_OP_OPTIONAL(mem_enc_ioctl)
-KVM_X86_OP_OPTIONAL(mem_enc_register_region)
-KVM_X86_OP_OPTIONAL(mem_enc_unregister_region)
-KVM_X86_OP_OPTIONAL(vm_copy_enc_context_from)
-KVM_X86_OP_OPTIONAL(vm_move_enc_context_from)
-KVM_X86_OP_OPTIONAL(guest_memory_reclaimed)
+KVM_X86_OP(mem_enc_ioctl)
+KVM_X86_OP(mem_enc_register_region)
+KVM_X86_OP(mem_enc_unregister_region)
+KVM_X86_OP(vm_copy_enc_context_from)
+KVM_X86_OP(vm_move_enc_context_from)
+KVM_X86_OP(guest_memory_reclaimed)
 KVM_X86_OP(get_msr_feature)
 KVM_X86_OP(can_emulate_instruction)
 KVM_X86_OP(apic_init_signal_blocked)
-KVM_X86_OP_OPTIONAL(enable_l2_tlb_flush)
-KVM_X86_OP_OPTIONAL(migrate_timers)
+KVM_X86_OP(enable_l2_tlb_flush)
+KVM_X86_OP(migrate_timers)
 KVM_X86_OP(msr_filter_changed)
 KVM_X86_OP(complete_emulated_msr)
 KVM_X86_OP(vcpu_deliver_sipi_vector)
-KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
+KVM_X86_OP(vcpu_get_apicv_inhibit_reasons);
 
 #undef KVM_X86_OP
-#undef KVM_X86_OP_OPTIONAL
-#undef KVM_X86_OP_OPTIONAL_RET0
diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index 6815319c4ff3..b11885d1bcd4 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -1,15 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#if !defined(KVM_X86_PMU_OP) || !defined(KVM_X86_PMU_OP_OPTIONAL)
+#if !defined(KVM_X86_PMU_OP)
 BUILD_BUG_ON(1)
 #endif
 
 /*
- * KVM_X86_PMU_OP() and KVM_X86_PMU_OP_OPTIONAL() are used to help generate
- * both DECLARE/DEFINE_STATIC_CALL() invocations and
- * "static_call_update()" calls.
- *
- * KVM_X86_PMU_OP_OPTIONAL() can be used for those functions that can have
- * a NULL definition.
+ * KVM_X86_PMU_OP() is used to help generate both DECLARE/DEFINE_STATIC_CALL()
+ * invocations and "static_call_update()" calls.  Note that NULL static calls
+ * default to "do-nothing return 0" functions.
  */
 KVM_X86_PMU_OP(hw_event_available)
 KVM_X86_PMU_OP(pmc_is_enabled)
@@ -23,8 +20,7 @@ KVM_X86_PMU_OP(set_msr)
 KVM_X86_PMU_OP(refresh)
 KVM_X86_PMU_OP(init)
 KVM_X86_PMU_OP(reset)
-KVM_X86_PMU_OP_OPTIONAL(deliver_pmi)
-KVM_X86_PMU_OP_OPTIONAL(cleanup)
+KVM_X86_PMU_OP(deliver_pmi)
+KVM_X86_PMU_OP(cleanup)
 
 #undef KVM_X86_PMU_OP
-#undef KVM_X86_PMU_OP_OPTIONAL
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1dfba499d3e5..612531e1c478 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1789,8 +1789,6 @@ extern struct kvm_x86_ops kvm_x86_ops;
 
 #define KVM_X86_OP(func) \
 	DECLARE_STATIC_CALL(kvm_x86_##func, *(((struct kvm_x86_ops *)0)->func));
-#define KVM_X86_OP_OPTIONAL KVM_X86_OP
-#define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
 
 int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops);
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 6accb46295a3..5f7f860c5f17 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -77,20 +77,15 @@ static struct kvm_pmu_ops kvm_pmu_ops __read_mostly;
 #define KVM_X86_PMU_OP(func)					     \
 	DEFINE_STATIC_CALL_NULL(kvm_x86_pmu_##func,			     \
 				*(((struct kvm_pmu_ops *)0)->func));
-#define KVM_X86_PMU_OP_OPTIONAL KVM_X86_PMU_OP
 #include <asm/kvm-x86-pmu-ops.h>
 
 void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
 {
 	memcpy(&kvm_pmu_ops, pmu_ops, sizeof(kvm_pmu_ops));
 
-#define __KVM_X86_PMU_OP(func) \
-	static_call_update(kvm_x86_pmu_##func, kvm_pmu_ops.func);
 #define KVM_X86_PMU_OP(func) \
-	WARN_ON(!kvm_pmu_ops.func); __KVM_X86_PMU_OP(func)
-#define KVM_X86_PMU_OP_OPTIONAL __KVM_X86_PMU_OP
+	static_call_update(kvm_x86_pmu_##func, kvm_pmu_ops.func);
 #include <asm/kvm-x86-pmu-ops.h>
-#undef __KVM_X86_PMU_OP
 }
 
 static inline bool pmc_is_enabled(struct kvm_pmc *pmc)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fcf845fc5770..a9521e5b2435 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -135,9 +135,8 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
 #define KVM_X86_OP(func)					     \
 	DEFINE_STATIC_CALL_NULL(kvm_x86_##func,			     \
 				*(((struct kvm_x86_ops *)0)->func));
-#define KVM_X86_OP_OPTIONAL KVM_X86_OP
-#define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
+
 EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
 EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
 
@@ -9316,16 +9315,9 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 {
 	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
 
-#define __KVM_X86_OP(func) \
-	static_call_update(kvm_x86_##func, kvm_x86_ops.func);
 #define KVM_X86_OP(func) \
-	WARN_ON(!kvm_x86_ops.func); __KVM_X86_OP(func)
-#define KVM_X86_OP_OPTIONAL __KVM_X86_OP
-#define KVM_X86_OP_OPTIONAL_RET0(func) \
-	static_call_update(kvm_x86_##func, (void *)kvm_x86_ops.func ? : \
-					   (void *)__static_call_return0);
+	static_call_update(kvm_x86_##func, kvm_x86_ops.func);
 #include <asm/kvm-x86-ops.h>
-#undef __KVM_X86_OP
 
 	kvm_pmu_ops_update(ops->pmu_ops);
 }
-- 
2.39.2

