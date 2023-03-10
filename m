Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BA76B51FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjCJUeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCJUdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:33:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96003FF0A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:33:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2AA561D5B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 20:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64776C433A1;
        Fri, 10 Mar 2023 20:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678480309;
        bh=E33gLvhncP0FoIguuAP+oP3VVHZPkpJEOS6jylkNXaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRVrtrdpohlTpYLNgDB9AsDYWi6WwgfwR87ZeD4jwi3QwNkPmWlW/PBbrsXhnv6Cv
         9ytSvf5FXJBDQhehw2Ksmkb8U+l09sZ56imGNf/GC2cjfHietsLOFwWZU1UrgCmcgk
         /S6UJ8TQ/eED5AkTlUXD7zl5hI9/oQEx93Y/8FxQ9yOT4OE0u0xsYEepTk8WioxsGm
         TThHduHCJ3kZowkLvV2x2XHoSKFHcEEL33Z+QN/ai1vKmu8N5LAbLmuH/0zmvq15j3
         dNM0pOLd/l2CY7ZLrYROs4lfMXqLZoXZs0bROUHJaxblkCme0JboRgKo0DfeYQSUy+
         JNXKjblsP05Cg==
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
Subject: [RFC][PATCH 3/5] static_call: Remove static_call_cond() and its usages
Date:   Fri, 10 Mar 2023 12:31:15 -0800
Message-Id: <7d549181d8a08444131baf05934f32052ea6b102.1678474914.git.jpoimboe@kernel.org>
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

static_call_cond() is now identical to static_call().  All static calls
to NULL function pointers are now NOPs for all configs.  Replace all
static_call_cond() usages and remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/events/core.c                    | 24 +++++++++++------------
 arch/x86/include/asm/kvm-x86-ops.h        |  3 +--
 arch/x86/include/asm/kvm-x86-pmu-ops.h    |  3 +--
 arch/x86/include/asm/kvm_host.h           |  4 ++--
 arch/x86/kvm/irq.c                        |  2 +-
 arch/x86/kvm/lapic.c                      | 22 ++++++++++-----------
 arch/x86/kvm/pmu.c                        |  4 ++--
 arch/x86/kvm/x86.c                        | 24 +++++++++++------------
 include/linux/static_call.h               |  7 -------
 security/keys/trusted-keys/trusted_core.c |  2 +-
 10 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d096b04bf80e..c94537501091 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -995,7 +995,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		n0 -= cpuc->n_txn;
 
-	static_call_cond(x86_pmu_start_scheduling)(cpuc);
+	static_call(x86_pmu_start_scheduling)(cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
 		c = cpuc->event_constraint[i];
@@ -1094,7 +1094,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	 */
 	if (!unsched && assign) {
 		for (i = 0; i < n; i++)
-			static_call_cond(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
+			static_call(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
 	} else {
 		for (i = n0; i < n; i++) {
 			e = cpuc->event_list[i];
@@ -1102,13 +1102,13 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 			/*
 			 * release events that failed scheduling
 			 */
-			static_call_cond(x86_pmu_put_event_constraints)(cpuc, e);
+			static_call(x86_pmu_put_event_constraints)(cpuc, e);
 
 			cpuc->event_constraint[i] = NULL;
 		}
 	}
 
-	static_call_cond(x86_pmu_stop_scheduling)(cpuc);
+	static_call(x86_pmu_stop_scheduling)(cpuc);
 
 	return unsched ? -EINVAL : 0;
 }
@@ -1221,7 +1221,7 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	hwc->last_cpu = smp_processor_id();
 	hwc->last_tag = ++cpuc->tags[i];
 
-	static_call_cond(x86_pmu_assign)(event, idx);
+	static_call(x86_pmu_assign)(event, idx);
 
 	switch (hwc->idx) {
 	case INTEL_PMC_IDX_FIXED_BTS:
@@ -1399,7 +1399,7 @@ int x86_perf_event_set_period(struct perf_event *event)
 	if (left > x86_pmu.max_period)
 		left = x86_pmu.max_period;
 
-	static_call_cond(x86_pmu_limit_period)(event, &left);
+	static_call(x86_pmu_limit_period)(event, &left);
 
 	this_cpu_write(pmc_prev_left[idx], left);
 
@@ -1487,7 +1487,7 @@ static int x86_pmu_add(struct perf_event *event, int flags)
 	 * This is before x86_pmu_enable() will call x86_pmu_start(),
 	 * so we enable LBRs before an event needs them etc..
 	 */
-	static_call_cond(x86_pmu_add)(event);
+	static_call(x86_pmu_add)(event);
 
 	ret = 0;
 out:
@@ -1640,7 +1640,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (i >= cpuc->n_events - cpuc->n_added)
 		--cpuc->n_added;
 
-	static_call_cond(x86_pmu_put_event_constraints)(cpuc, event);
+	static_call(x86_pmu_put_event_constraints)(cpuc, event);
 
 	/* Delete the array entry. */
 	while (++i < cpuc->n_events) {
@@ -1660,7 +1660,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	 * This is after x86_pmu_stop(); so we disable LBRs after any
 	 * event can need them etc..
 	 */
-	static_call_cond(x86_pmu_del)(event);
+	static_call(x86_pmu_del)(event);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
@@ -2627,13 +2627,13 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 
 static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
-	static_call_cond(x86_pmu_sched_task)(pmu_ctx, sched_in);
+	static_call(x86_pmu_sched_task)(pmu_ctx, sched_in);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_pmu_context *prev_epc,
 				  struct perf_event_pmu_context *next_epc)
 {
-	static_call_cond(x86_pmu_swap_task_ctx)(prev_epc, next_epc);
+	static_call(x86_pmu_swap_task_ctx)(prev_epc, next_epc);
 }
 
 void perf_check_microcode(void)
@@ -2672,7 +2672,7 @@ static bool x86_pmu_filter(struct pmu *pmu, int cpu)
 {
 	bool ret = false;
 
-	static_call_cond(x86_pmu_filter)(pmu, cpu, &ret);
+	static_call(x86_pmu_filter)(pmu, cpu, &ret);
 
 	return ret;
 }
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 8dc345cc6318..2f0bfd910637 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -9,8 +9,7 @@ BUILD_BUG_ON(1)
  * "static_call_update()" calls.
  *
  * KVM_X86_OP_OPTIONAL() can be used for those functions that can have
- * a NULL definition, for example if "static_call_cond()" will be used
- * at the call sites.  KVM_X86_OP_OPTIONAL_RET0() can be used likewise
+ * a NULL definition.  KVM_X86_OP_OPTIONAL_RET0() can be used likewise
  * to make a definition optional, but in this case the default will
  * be __static_call_return0.
  */
diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
index c17e3e96fc1d..6815319c4ff3 100644
--- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
+++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
@@ -9,8 +9,7 @@ BUILD_BUG_ON(1)
  * "static_call_update()" calls.
  *
  * KVM_X86_PMU_OP_OPTIONAL() can be used for those functions that can have
- * a NULL definition, for example if "static_call_cond()" will be used
- * at the call sites.
+ * a NULL definition.
  */
 KVM_X86_PMU_OP(hw_event_available)
 KVM_X86_PMU_OP(pmc_is_enabled)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 808c292ad3f4..1dfba499d3e5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2172,12 +2172,12 @@ static inline bool kvm_irq_is_postable(struct kvm_lapic_irq *irq)
 
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
-	static_call_cond(kvm_x86_vcpu_blocking)(vcpu);
+	static_call(kvm_x86_vcpu_blocking)(vcpu);
 }
 
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
-	static_call_cond(kvm_x86_vcpu_unblocking)(vcpu);
+	static_call(kvm_x86_vcpu_unblocking)(vcpu);
 }
 
 static inline int kvm_cpu_get_apicid(int mps_cpu)
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index b2c397dd2bc6..4f9e090c9d42 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -155,7 +155,7 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu)
 {
 	__kvm_migrate_apic_timer(vcpu);
 	__kvm_migrate_pit_timer(vcpu);
-	static_call_cond(kvm_x86_migrate_timers)(vcpu);
+	static_call(kvm_x86_migrate_timers)(vcpu);
 }
 
 bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args)
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index e542cf285b51..d5f7e829d975 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -681,8 +681,8 @@ static inline void apic_clear_irr(int vec, struct kvm_lapic *apic)
 	if (unlikely(apic->apicv_active)) {
 		/* need to update RVI */
 		kvm_lapic_clear_vector(vec, apic->regs + APIC_IRR);
-		static_call_cond(kvm_x86_hwapic_irr_update)(apic->vcpu,
-							    apic_find_highest_irr(apic));
+		static_call(kvm_x86_hwapic_irr_update)(apic->vcpu,
+						       apic_find_highest_irr(apic));
 	} else {
 		apic->irr_pending = false;
 		kvm_lapic_clear_vector(vec, apic->regs + APIC_IRR);
@@ -708,7 +708,7 @@ static inline void apic_set_isr(int vec, struct kvm_lapic *apic)
 	 * just set SVI.
 	 */
 	if (unlikely(apic->apicv_active))
-		static_call_cond(kvm_x86_hwapic_isr_update)(vec);
+		static_call(kvm_x86_hwapic_isr_update)(vec);
 	else {
 		++apic->isr_count;
 		BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
@@ -753,7 +753,7 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	 * and must be left alone.
 	 */
 	if (unlikely(apic->apicv_active))
-		static_call_cond(kvm_x86_hwapic_isr_update)(apic_find_highest_isr(apic));
+		static_call(kvm_x86_hwapic_isr_update)(apic_find_highest_isr(apic));
 	else {
 		--apic->isr_count;
 		BUG_ON(apic->isr_count < 0);
@@ -2519,7 +2519,7 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
 
 	if ((old_value ^ value) & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE)) {
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
-		static_call_cond(kvm_x86_set_virtual_apic_mode)(vcpu);
+		static_call(kvm_x86_set_virtual_apic_mode)(vcpu);
 	}
 
 	apic->base_address = apic->vcpu->arch.apic_base &
@@ -2682,9 +2682,9 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vcpu->arch.pv_eoi.msr_val = 0;
 	apic_update_ppr(apic);
 	if (apic->apicv_active) {
-		static_call_cond(kvm_x86_apicv_post_state_restore)(vcpu);
-		static_call_cond(kvm_x86_hwapic_irr_update)(vcpu, -1);
-		static_call_cond(kvm_x86_hwapic_isr_update)(-1);
+		static_call(kvm_x86_apicv_post_state_restore)(vcpu);
+		static_call(kvm_x86_hwapic_irr_update)(vcpu, -1);
+		static_call(kvm_x86_hwapic_isr_update)(-1);
 	}
 
 	vcpu->arch.apic_arb_prio = 0;
@@ -2961,9 +2961,9 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	kvm_lapic_set_reg(apic, APIC_TMCCT, 0);
 	kvm_apic_update_apicv(vcpu);
 	if (apic->apicv_active) {
-		static_call_cond(kvm_x86_apicv_post_state_restore)(vcpu);
-		static_call_cond(kvm_x86_hwapic_irr_update)(vcpu, apic_find_highest_irr(apic));
-		static_call_cond(kvm_x86_hwapic_isr_update)(apic_find_highest_isr(apic));
+		static_call(kvm_x86_apicv_post_state_restore)(vcpu);
+		static_call(kvm_x86_hwapic_irr_update)(vcpu, apic_find_highest_irr(apic));
+		static_call(kvm_x86_hwapic_isr_update)(apic_find_highest_isr(apic));
 	}
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	if (ioapic_in_kernel(vcpu->kvm))
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 612e6c70ce2e..6accb46295a3 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -552,7 +552,7 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
 {
 	if (lapic_in_kernel(vcpu)) {
-		static_call_cond(kvm_x86_pmu_deliver_pmi)(vcpu);
+		static_call(kvm_x86_pmu_deliver_pmi)(vcpu);
 		kvm_apic_local_deliver(vcpu->arch.apic, APIC_LVTPC);
 	}
 }
@@ -632,7 +632,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu)
 			pmc_stop_counter(pmc);
 	}
 
-	static_call_cond(kvm_x86_pmu_cleanup)(vcpu);
+	static_call(kvm_x86_pmu_cleanup)(vcpu);
 
 	bitmap_zero(pmu->pmc_in_use, X86_PMC_IDX_MAX);
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7713420abab0..fcf845fc5770 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4845,7 +4845,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
 				    struct kvm_lapic_state *s)
 {
-	static_call_cond(kvm_x86_sync_pir_to_irr)(vcpu);
+	static_call(kvm_x86_sync_pir_to_irr)(vcpu);
 
 	return kvm_apic_get_state(vcpu, s);
 }
@@ -8948,7 +8948,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			kvm_rip_write(vcpu, ctxt->eip);
 			if (r && (ctxt->tf || (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)))
 				r = kvm_vcpu_do_singlestep(vcpu);
-			static_call_cond(kvm_x86_update_emulated_instruction)(vcpu);
+			static_call(kvm_x86_update_emulated_instruction)(vcpu);
 			__kvm_set_rflags(vcpu, ctxt->eflags);
 		}
 
@@ -10307,7 +10307,7 @@ static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 	if (irqchip_split(vcpu->kvm))
 		kvm_scan_ioapic_routes(vcpu, vcpu->arch.ioapic_handled_vectors);
 	else {
-		static_call_cond(kvm_x86_sync_pir_to_irr)(vcpu);
+		static_call(kvm_x86_sync_pir_to_irr)(vcpu);
 		if (ioapic_in_kernel(vcpu->kvm))
 			kvm_ioapic_scan_entry(vcpu, vcpu->arch.ioapic_handled_vectors);
 	}
@@ -10329,11 +10329,11 @@ static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
 		bitmap_or((ulong *)eoi_exit_bitmap,
 			  vcpu->arch.ioapic_handled_vectors,
 			  to_hv_synic(vcpu)->vec_bitmap, 256);
-		static_call_cond(kvm_x86_load_eoi_exitmap)(vcpu, eoi_exit_bitmap);
+		static_call(kvm_x86_load_eoi_exitmap)(vcpu, eoi_exit_bitmap);
 		return;
 	}
 
-	static_call_cond(kvm_x86_load_eoi_exitmap)(
+	static_call(kvm_x86_load_eoi_exitmap)(
 		vcpu, (u64 *)vcpu->arch.ioapic_handled_vectors);
 }
 
@@ -10353,7 +10353,7 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
 
 void kvm_arch_guest_memory_reclaimed(struct kvm *kvm)
 {
-	static_call_cond(kvm_x86_guest_memory_reclaimed)(kvm);
+	static_call(kvm_x86_guest_memory_reclaimed)(kvm);
 }
 
 static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
@@ -10361,7 +10361,7 @@ static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
 	if (!lapic_in_kernel(vcpu))
 		return;
 
-	static_call_cond(kvm_x86_set_apic_access_page_addr)(vcpu);
+	static_call(kvm_x86_set_apic_access_page_addr)(vcpu);
 }
 
 void __kvm_request_immediate_exit(struct kvm_vcpu *vcpu)
@@ -10603,7 +10603,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 * i.e. they can post interrupts even if APICv is temporarily disabled.
 	 */
 	if (kvm_lapic_enabled(vcpu))
-		static_call_cond(kvm_x86_sync_pir_to_irr)(vcpu);
+		static_call(kvm_x86_sync_pir_to_irr)(vcpu);
 
 	if (kvm_vcpu_exit_request(vcpu)) {
 		vcpu->mode = OUTSIDE_GUEST_MODE;
@@ -10654,7 +10654,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			break;
 
 		if (kvm_lapic_enabled(vcpu))
-			static_call_cond(kvm_x86_sync_pir_to_irr)(vcpu);
+			static_call(kvm_x86_sync_pir_to_irr)(vcpu);
 
 		if (unlikely(kvm_vcpu_exit_request(vcpu))) {
 			exit_fastpath = EXIT_FASTPATH_EXIT_HANDLED;
@@ -11392,7 +11392,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	*mmu_reset_needed |= kvm_read_cr3(vcpu) != sregs->cr3;
 	vcpu->arch.cr3 = sregs->cr3;
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
-	static_call_cond(kvm_x86_post_set_cr3)(vcpu, sregs->cr3);
+	static_call(kvm_x86_post_set_cr3)(vcpu, sregs->cr3);
 
 	kvm_set_cr8(vcpu, sregs->cr8);
 
@@ -12361,7 +12361,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		mutex_unlock(&kvm->slots_lock);
 	}
 	kvm_unload_vcpu_mmus(kvm);
-	static_call_cond(kvm_x86_vm_destroy)(kvm);
+	static_call(kvm_x86_vm_destroy)(kvm);
 	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
 	kvm_pic_destroy(kvm);
 	kvm_ioapic_destroy(kvm);
@@ -13049,7 +13049,7 @@ bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu)
 void kvm_arch_start_assignment(struct kvm *kvm)
 {
 	if (atomic_inc_return(&kvm->arch.assigned_device_count) == 1)
-		static_call_cond(kvm_x86_pi_start_assignment)(kvm);
+		static_call(kvm_x86_pi_start_assignment)(kvm);
 }
 EXPORT_SYMBOL_GPL(kvm_arch_start_assignment);
 
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 58783d112df5..3b3e9e9a1582 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -22,7 +22,6 @@
  *   __static_call_return0;
  *
  *   static_call(name)(args...);
- *   static_call_cond(name)(args...);
  *   static_call_update(name, func);
  *   static_call_query(name);
  *
@@ -174,8 +173,6 @@ extern int static_call_text_reserved(void *start, void *end);
 
 #define DEFINE_STATIC_CALL_RET0 DEFINE_STATIC_CALL_NULL
 
-#define static_call_cond(name)	__static_call(name)
-
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
@@ -211,8 +208,6 @@ static inline int static_call_init(void) { return 0; }
 
 #define DEFINE_STATIC_CALL_RET0 DEFINE_STATIC_CALL_NULL
 
-#define static_call_cond(name)	__static_call(name)
-
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
@@ -258,8 +253,6 @@ static inline int static_call_init(void) { return 0; }
 
 #define DEFINE_STATIC_CALL_RET0 DEFINE_STATIC_CALL_NULL
 
-#define static_call_cond(name) static_call(name)
-
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index c6fc50d67214..b7920482ebcb 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -388,7 +388,7 @@ static int __init init_trusted(void)
 
 static void __exit cleanup_trusted(void)
 {
-	static_call_cond(trusted_key_exit)();
+	static_call(trusted_key_exit)();
 }
 
 late_initcall(init_trusted);
-- 
2.39.2

