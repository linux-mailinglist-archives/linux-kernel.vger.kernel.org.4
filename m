Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231FC6D40BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjDCJfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjDCJe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:34:28 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44831113F9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:34:04 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso15269050oti.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680514444; x=1683106444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIvz+5NA5w/GkrB31UnJwC4BDULmbACp0ieETGerotU=;
        b=LZVATg8CljZT6ubWdlVvDtncteqdsMKbCDfcXxSs+nuvZNR3tX6DtsAPs4o8fxlfUh
         4/R/sIdks1iaA7azSOJVgpzQF969/ZvUUUbYoNDSVb/yW42erUfRS4mQP9SkFGaZVVzM
         fl7GAlqhR6eIa5z/B0zAYzXV1e6vgfSXZx30qgP9wixzAcDAurQ0uMlUa4qRmHX97ci+
         /9YsrLdTFV2lqK7ffzMsAjRuTEMS5ZB/jsOtsOIk1vynxawoOOybr7QckiRiBVLH8g5Q
         mom+Y7wL84ADxYjs1maL8ibh6F4iY87TaPps0h4QDy8G6Gmd6k0u9h5mEIOwpquK2uJ0
         mHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680514444; x=1683106444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIvz+5NA5w/GkrB31UnJwC4BDULmbACp0ieETGerotU=;
        b=ZI/S113e+OawDGHcGX1FBIRT5yincYMgUkEheAOzzCGybyCOibx1s333RKweai4Q0M
         dQvTizSCEsbQ7iTwGx1IPfGENFaMDWHTn0xmRn8Oe68T8RDMRTmDL5eqK/KmRpMgCH8L
         YMBecuNvp09Yz1d+4vpFQu7Wa90NSBsrDq983+SKAyxpYdmhHtry4WF+Z/Cn02acGvWv
         lNh1KJvdzH0sKZ9HFFeOPz/aC8/eR2N4MMw7XbbGLnolVRqGldB10S/la4zm2C+/o8bz
         eM4zzfe5e6oD21xjiNEaL+22suYSDUGx+93P3PTKZB2Q6aL5c4NBhZmzOa8oMW943A+j
         UPAw==
X-Gm-Message-State: AAQBX9fuwkHLH7QEozqlDLtUnHS3qgqJCSpVzPfqe+rqLGDeCVohUYYG
        FDLoa9wyR0Ga65+MaBQe9Z3iBvug4JzktFhVd6c=
X-Google-Smtp-Source: AKy350YaHJ8DuF++f45jsmqQl0IWm3ctwyuYLIyC0aZ73PvJgPQZWyqcCftBHuKjQldNfuWVG/4F4w==
X-Received: by 2002:a05:6830:16c5:b0:693:d7bf:dc26 with SMTP id l5-20020a05683016c500b00693d7bfdc26mr9415561otr.6.1680514443573;
        Mon, 03 Apr 2023 02:34:03 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id f5-20020a9d6c05000000b006a154373578sm3953953otq.39.2023.04.03.02.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 02:34:03 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 7/8] RISC-V: KVM: Virtualize per-HART AIA CSRs
Date:   Mon,  3 Apr 2023 15:03:09 +0530
Message-Id: <20230403093310.2271142-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403093310.2271142-1-apatel@ventanamicro.com>
References: <20230403093310.2271142-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AIA specification introduce per-HART AIA CSRs which primarily
support:
* 64 local interrupts on both RV64 and RV32
* priority for each of the 64 local interrupts
* interrupt filtering for local interrupts

This patch virtualize above mentioned AIA CSRs and also extend
ONE_REG interface to allow user-space save/restore Guest/VM
view of these CSRs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_aia.h  |  88 +++++----
 arch/riscv/include/asm/kvm_host.h |   7 +-
 arch/riscv/include/uapi/asm/kvm.h |   7 +
 arch/riscv/kvm/aia.c              | 317 ++++++++++++++++++++++++++++++
 arch/riscv/kvm/vcpu.c             |  53 +++--
 5 files changed, 415 insertions(+), 57 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index 258a835d4c32..1de0717112e5 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -12,6 +12,7 @@
 
 #include <linux/jump_label.h>
 #include <linux/kvm_types.h>
+#include <asm/csr.h>
 
 struct kvm_aia {
 	/* In-kernel irqchip created */
@@ -21,7 +22,22 @@ struct kvm_aia {
 	bool		initialized;
 };
 
+struct kvm_vcpu_aia_csr {
+	unsigned long vsiselect;
+	unsigned long hviprio1;
+	unsigned long hviprio2;
+	unsigned long vsieh;
+	unsigned long hviph;
+	unsigned long hviprio1h;
+	unsigned long hviprio2h;
+};
+
 struct kvm_vcpu_aia {
+	/* CPU AIA CSR context of Guest VCPU */
+	struct kvm_vcpu_aia_csr guest_csr;
+
+	/* CPU AIA CSR context upon Guest VCPU reset */
+	struct kvm_vcpu_aia_csr guest_reset_csr;
 };
 
 #define kvm_riscv_aia_initialized(k)	((k)->arch.aia.initialized)
@@ -32,48 +48,50 @@ DECLARE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
 #define kvm_riscv_aia_available() \
 	static_branch_unlikely(&kvm_riscv_aia_available)
 
-static inline void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_vcpu *vcpu)
-{
-}
-
-static inline void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
-{
-}
-
-static inline bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu,
-						     u64 mask)
-{
-	return false;
-}
-
-static inline void kvm_riscv_vcpu_aia_update_hvip(struct kvm_vcpu *vcpu)
-{
-}
-
-static inline void kvm_riscv_vcpu_aia_load(struct kvm_vcpu *vcpu, int cpu)
-{
-}
-
-static inline void kvm_riscv_vcpu_aia_put(struct kvm_vcpu *vcpu)
+#define KVM_RISCV_AIA_IMSIC_TOPEI	(ISELECT_MASK + 1)
+static inline int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *vcpu,
+					       unsigned long isel,
+					       unsigned long *val,
+					       unsigned long new_val,
+					       unsigned long wr_mask)
 {
+	return 0;
 }
 
-static inline int kvm_riscv_vcpu_aia_get_csr(struct kvm_vcpu *vcpu,
-					     unsigned long reg_num,
-					     unsigned long *out_val)
+#ifdef CONFIG_32BIT
+void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu);
+#else
+static inline void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_vcpu *vcpu)
 {
-	*out_val = 0;
-	return 0;
 }
-
-static inline int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
-					     unsigned long reg_num,
-					     unsigned long val)
+static inline void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
 {
-	return 0;
 }
-
-#define KVM_RISCV_VCPU_AIA_CSR_FUNCS
+#endif
+bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask);
+
+void kvm_riscv_vcpu_aia_update_hvip(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_aia_load(struct kvm_vcpu *vcpu, int cpu);
+void kvm_riscv_vcpu_aia_put(struct kvm_vcpu *vcpu);
+int kvm_riscv_vcpu_aia_get_csr(struct kvm_vcpu *vcpu,
+			       unsigned long reg_num,
+			       unsigned long *out_val);
+int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
+			       unsigned long reg_num,
+			       unsigned long val);
+
+int kvm_riscv_vcpu_aia_rmw_topei(struct kvm_vcpu *vcpu,
+				 unsigned int csr_num,
+				 unsigned long *val,
+				 unsigned long new_val,
+				 unsigned long wr_mask);
+int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_num,
+				unsigned long *val, unsigned long new_val,
+				unsigned long wr_mask);
+#define KVM_RISCV_VCPU_AIA_CSR_FUNCS \
+{ .base = CSR_SIREG,      .count = 1, .func = kvm_riscv_vcpu_aia_rmw_ireg }, \
+{ .base = CSR_STOPEI,     .count = 1, .func = kvm_riscv_vcpu_aia_rmw_topei },
 
 static inline int kvm_riscv_vcpu_aia_update(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 3157cf748df1..ee0acccb1d3b 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -204,8 +204,9 @@ struct kvm_vcpu_arch {
 	 * in irqs_pending. Our approach is modeled around multiple producer
 	 * and single consumer problem where the consumer is the VCPU itself.
 	 */
-	unsigned long irqs_pending;
-	unsigned long irqs_pending_mask;
+#define KVM_RISCV_VCPU_NR_IRQS	64
+	DECLARE_BITMAP(irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
+	DECLARE_BITMAP(irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS);
 
 	/* VCPU Timer */
 	struct kvm_vcpu_timer timer;
@@ -334,7 +335,7 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq);
 int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq);
 void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu);
-bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, unsigned long mask);
+bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask);
 void kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
 
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index cbc3e74fa670..c517e70ddcd6 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -81,6 +81,13 @@ struct kvm_riscv_csr {
 
 /* AIA CSR registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
 struct kvm_riscv_aia_csr {
+	unsigned long siselect;
+	unsigned long siprio1;
+	unsigned long siprio2;
+	unsigned long sieh;
+	unsigned long siph;
+	unsigned long siprio1h;
+	unsigned long siprio2h;
 };
 
 /* TIMER registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 7a633331cd3e..d530912f28bc 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -26,6 +26,323 @@ static void aia_set_hvictl(bool ext_irq_pending)
 	csr_write(CSR_HVICTL, hvictl);
 }
 
+#ifdef CONFIG_32BIT
+void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
+	unsigned long mask, val;
+
+	if (!kvm_riscv_aia_available())
+		return;
+
+	if (READ_ONCE(vcpu->arch.irqs_pending_mask[1])) {
+		mask = xchg_acquire(&vcpu->arch.irqs_pending_mask[1], 0);
+		val = READ_ONCE(vcpu->arch.irqs_pending[1]) & mask;
+
+		csr->hviph &= ~mask;
+		csr->hviph |= val;
+	}
+}
+
+void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
+
+	if (kvm_riscv_aia_available())
+		csr->vsieh = csr_read(CSR_VSIEH);
+}
+#endif
+
+bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
+{
+	unsigned long seip;
+
+	if (!kvm_riscv_aia_available())
+		return false;
+
+#ifdef CONFIG_32BIT
+	if (READ_ONCE(vcpu->arch.irqs_pending[1]) &
+	    (vcpu->arch.aia_context.guest_csr.vsieh & (unsigned long)(mask >> 32)))
+		return true;
+#endif
+
+	seip = vcpu->arch.guest_csr.vsie;
+	seip &= (unsigned long)mask;
+	seip &= BIT(IRQ_S_EXT);
+	if (!kvm_riscv_aia_initialized(vcpu->kvm) || !seip)
+		return false;
+
+	return false;
+}
+
+void kvm_riscv_vcpu_aia_update_hvip(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
+
+	if (!kvm_riscv_aia_available())
+		return;
+
+#ifdef CONFIG_32BIT
+	csr_write(CSR_HVIPH, vcpu->arch.aia_context.guest_csr.hviph);
+#endif
+	aia_set_hvictl((csr->hvip & BIT(IRQ_VS_EXT)) ? true : false);
+}
+
+void kvm_riscv_vcpu_aia_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
+
+	if (!kvm_riscv_aia_available())
+		return;
+
+	csr_write(CSR_VSISELECT, csr->vsiselect);
+	csr_write(CSR_HVIPRIO1, csr->hviprio1);
+	csr_write(CSR_HVIPRIO2, csr->hviprio2);
+#ifdef CONFIG_32BIT
+	csr_write(CSR_VSIEH, csr->vsieh);
+	csr_write(CSR_HVIPH, csr->hviph);
+	csr_write(CSR_HVIPRIO1H, csr->hviprio1h);
+	csr_write(CSR_HVIPRIO2H, csr->hviprio2h);
+#endif
+}
+
+void kvm_riscv_vcpu_aia_put(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
+
+	if (!kvm_riscv_aia_available())
+		return;
+
+	csr->vsiselect = csr_read(CSR_VSISELECT);
+	csr->hviprio1 = csr_read(CSR_HVIPRIO1);
+	csr->hviprio2 = csr_read(CSR_HVIPRIO2);
+#ifdef CONFIG_32BIT
+	csr->vsieh = csr_read(CSR_VSIEH);
+	csr->hviph = csr_read(CSR_HVIPH);
+	csr->hviprio1h = csr_read(CSR_HVIPRIO1H);
+	csr->hviprio2h = csr_read(CSR_HVIPRIO2H);
+#endif
+}
+
+int kvm_riscv_vcpu_aia_get_csr(struct kvm_vcpu *vcpu,
+			       unsigned long reg_num,
+			       unsigned long *out_val)
+{
+	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
+
+	if (reg_num >= sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long))
+		return -EINVAL;
+
+	*out_val = 0;
+	if (kvm_riscv_aia_available())
+		*out_val = ((unsigned long *)csr)[reg_num];
+
+	return 0;
+}
+
+int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
+			       unsigned long reg_num,
+			       unsigned long val)
+{
+	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
+
+	if (reg_num >= sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long))
+		return -EINVAL;
+
+	if (kvm_riscv_aia_available()) {
+		((unsigned long *)csr)[reg_num] = val;
+
+#ifdef CONFIG_32BIT
+		if (reg_num == KVM_REG_RISCV_CSR_AIA_REG(siph))
+			WRITE_ONCE(vcpu->arch.irqs_pending_mask[1], 0);
+#endif
+	}
+
+	return 0;
+}
+
+int kvm_riscv_vcpu_aia_rmw_topei(struct kvm_vcpu *vcpu,
+				 unsigned int csr_num,
+				 unsigned long *val,
+				 unsigned long new_val,
+				 unsigned long wr_mask)
+{
+	/* If AIA not available then redirect trap */
+	if (!kvm_riscv_aia_available())
+		return KVM_INSN_ILLEGAL_TRAP;
+
+	/* If AIA not initialized then forward to user space */
+	if (!kvm_riscv_aia_initialized(vcpu->kvm))
+		return KVM_INSN_EXIT_TO_USER_SPACE;
+
+	return kvm_riscv_vcpu_aia_imsic_rmw(vcpu, KVM_RISCV_AIA_IMSIC_TOPEI,
+					    val, new_val, wr_mask);
+}
+
+/*
+ * External IRQ priority always read-only zero. This means default
+ * priority order  is always preferred for external IRQs unless
+ * HVICTL.IID == 9 and HVICTL.IPRIO != 0
+ */
+static int aia_irq2bitpos[] = {
+0,     8,   -1,   -1,   16,   24,   -1,   -1, /* 0 - 7 */
+32,   -1,   -1,   -1,   -1,   40,   48,   56, /* 8 - 15 */
+64,   72,   80,   88,   96,  104,  112,  120, /* 16 - 23 */
+-1,   -1,   -1,   -1,   -1,   -1,   -1,   -1, /* 24 - 31 */
+-1,   -1,   -1,   -1,   -1,   -1,   -1,   -1, /* 32 - 39 */
+-1,   -1,   -1,   -1,   -1,   -1,   -1,   -1, /* 40 - 47 */
+-1,   -1,   -1,   -1,   -1,   -1,   -1,   -1, /* 48 - 55 */
+-1,   -1,   -1,   -1,   -1,   -1,   -1,   -1, /* 56 - 63 */
+};
+
+static u8 aia_get_iprio8(struct kvm_vcpu *vcpu, unsigned int irq)
+{
+	unsigned long hviprio;
+	int bitpos = aia_irq2bitpos[irq];
+
+	if (bitpos < 0)
+		return 0;
+
+	switch (bitpos / BITS_PER_LONG) {
+	case 0:
+		hviprio = csr_read(CSR_HVIPRIO1);
+		break;
+	case 1:
+#ifndef CONFIG_32BIT
+		hviprio = csr_read(CSR_HVIPRIO2);
+		break;
+#else
+		hviprio = csr_read(CSR_HVIPRIO1H);
+		break;
+	case 2:
+		hviprio = csr_read(CSR_HVIPRIO2);
+		break;
+	case 3:
+		hviprio = csr_read(CSR_HVIPRIO2H);
+		break;
+#endif
+	default:
+		return 0;
+	};
+
+	return (hviprio >> (bitpos % BITS_PER_LONG)) & TOPI_IPRIO_MASK;
+}
+
+static void aia_set_iprio8(struct kvm_vcpu *vcpu, unsigned int irq, u8 prio)
+{
+	unsigned long hviprio;
+	int bitpos = aia_irq2bitpos[irq];
+
+	if (bitpos < 0)
+		return;
+
+	switch (bitpos / BITS_PER_LONG) {
+	case 0:
+		hviprio = csr_read(CSR_HVIPRIO1);
+		break;
+	case 1:
+#ifndef CONFIG_32BIT
+		hviprio = csr_read(CSR_HVIPRIO2);
+		break;
+#else
+		hviprio = csr_read(CSR_HVIPRIO1H);
+		break;
+	case 2:
+		hviprio = csr_read(CSR_HVIPRIO2);
+		break;
+	case 3:
+		hviprio = csr_read(CSR_HVIPRIO2H);
+		break;
+#endif
+	default:
+		return;
+	};
+
+	hviprio &= ~((unsigned long)TOPI_IPRIO_MASK <<
+		     (bitpos % BITS_PER_LONG));
+	hviprio |= (unsigned long)prio << (bitpos % BITS_PER_LONG);
+
+	switch (bitpos / BITS_PER_LONG) {
+	case 0:
+		csr_write(CSR_HVIPRIO1, hviprio);
+		break;
+	case 1:
+#ifndef CONFIG_32BIT
+		csr_write(CSR_HVIPRIO2, hviprio);
+		break;
+#else
+		csr_write(CSR_HVIPRIO1H, hviprio);
+		break;
+	case 2:
+		csr_write(CSR_HVIPRIO2, hviprio);
+		break;
+	case 3:
+		csr_write(CSR_HVIPRIO2H, hviprio);
+		break;
+#endif
+	default:
+		return;
+	};
+}
+
+static int aia_rmw_iprio(struct kvm_vcpu *vcpu, unsigned int isel,
+			 unsigned long *val, unsigned long new_val,
+			 unsigned long wr_mask)
+{
+	int i, firq, nirqs;
+	unsigned long old_val;
+
+#ifndef CONFIG_32BIT
+	if (isel & 0x1)
+		return KVM_INSN_ILLEGAL_TRAP;
+#endif
+
+	nirqs = 4 * (BITS_PER_LONG / 32);
+	firq = ((isel - ISELECT_IPRIO0) / (BITS_PER_LONG / 32)) * (nirqs);
+
+	old_val = 0;
+	for (i = 0; i < nirqs; i++)
+		old_val |= (unsigned long)aia_get_iprio8(vcpu, firq + i) <<
+			   (TOPI_IPRIO_BITS * i);
+
+	if (val)
+		*val = old_val;
+
+	if (wr_mask) {
+		new_val = (old_val & ~wr_mask) | (new_val & wr_mask);
+		for (i = 0; i < nirqs; i++)
+			aia_set_iprio8(vcpu, firq + i,
+			(new_val >> (TOPI_IPRIO_BITS * i)) & TOPI_IPRIO_MASK);
+	}
+
+	return KVM_INSN_CONTINUE_NEXT_SEPC;
+}
+
+#define IMSIC_FIRST	0x70
+#define IMSIC_LAST	0xff
+int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_num,
+				unsigned long *val, unsigned long new_val,
+				unsigned long wr_mask)
+{
+	unsigned int isel;
+
+	/* If AIA not available then redirect trap */
+	if (!kvm_riscv_aia_available())
+		return KVM_INSN_ILLEGAL_TRAP;
+
+	/* First try to emulate in kernel space */
+	isel = csr_read(CSR_VSISELECT) & ISELECT_MASK;
+	if (isel >= ISELECT_IPRIO0 && isel <= ISELECT_IPRIO15)
+		return aia_rmw_iprio(vcpu, isel, val, new_val, wr_mask);
+	else if (isel >= IMSIC_FIRST && isel <= IMSIC_LAST &&
+		 kvm_riscv_aia_initialized(vcpu->kvm))
+		return kvm_riscv_vcpu_aia_imsic_rmw(vcpu, isel, val, new_val,
+						    wr_mask);
+
+	/* We can't handle it here so redirect to user space */
+	return KVM_INSN_EXIT_TO_USER_SPACE;
+}
+
 void kvm_riscv_aia_enable(void)
 {
 	if (!kvm_riscv_aia_available())
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 15507cd3a595..30acf3ebdc3d 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -141,8 +141,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_riscv_vcpu_aia_reset(vcpu);
 
-	WRITE_ONCE(vcpu->arch.irqs_pending, 0);
-	WRITE_ONCE(vcpu->arch.irqs_pending_mask, 0);
+	bitmap_zero(vcpu->arch.irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
+	bitmap_zero(vcpu->arch.irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS);
 
 	kvm_riscv_vcpu_pmu_reset(vcpu);
 
@@ -474,6 +474,7 @@ static int kvm_riscv_vcpu_general_get_csr(struct kvm_vcpu *vcpu,
 	if (reg_num == KVM_REG_RISCV_CSR_REG(sip)) {
 		kvm_riscv_vcpu_flush_interrupts(vcpu);
 		*out_val = (csr->hvip >> VSIP_TO_HVIP_SHIFT) & VSIP_VALID_MASK;
+		*out_val |= csr->hvip & ~IRQ_LOCAL_MASK;
 	} else
 		*out_val = ((unsigned long *)csr)[reg_num];
 
@@ -497,7 +498,7 @@ static inline int kvm_riscv_vcpu_general_set_csr(struct kvm_vcpu *vcpu,
 	((unsigned long *)csr)[reg_num] = reg_val;
 
 	if (reg_num == KVM_REG_RISCV_CSR_REG(sip))
-		WRITE_ONCE(vcpu->arch.irqs_pending_mask, 0);
+		WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
 
 	return 0;
 }
@@ -799,9 +800,9 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 	unsigned long mask, val;
 
-	if (READ_ONCE(vcpu->arch.irqs_pending_mask)) {
-		mask = xchg_acquire(&vcpu->arch.irqs_pending_mask, 0);
-		val = READ_ONCE(vcpu->arch.irqs_pending) & mask;
+	if (READ_ONCE(vcpu->arch.irqs_pending_mask[0])) {
+		mask = xchg_acquire(&vcpu->arch.irqs_pending_mask[0], 0);
+		val = READ_ONCE(vcpu->arch.irqs_pending[0]) & mask;
 
 		csr->hvip &= ~mask;
 		csr->hvip |= val;
@@ -825,12 +826,12 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 	if ((csr->hvip ^ hvip) & (1UL << IRQ_VS_SOFT)) {
 		if (hvip & (1UL << IRQ_VS_SOFT)) {
 			if (!test_and_set_bit(IRQ_VS_SOFT,
-					      &v->irqs_pending_mask))
-				set_bit(IRQ_VS_SOFT, &v->irqs_pending);
+					      v->irqs_pending_mask))
+				set_bit(IRQ_VS_SOFT, v->irqs_pending);
 		} else {
 			if (!test_and_set_bit(IRQ_VS_SOFT,
-					      &v->irqs_pending_mask))
-				clear_bit(IRQ_VS_SOFT, &v->irqs_pending);
+					      v->irqs_pending_mask))
+				clear_bit(IRQ_VS_SOFT, v->irqs_pending);
 		}
 	}
 
@@ -843,14 +844,20 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 
 int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 {
-	if (irq != IRQ_VS_SOFT &&
+	/*
+	 * We only allow VS-mode software, timer, and external
+	 * interrupts when irq is one of the local interrupts
+	 * defined by RISC-V privilege specification.
+	 */
+	if (irq < IRQ_LOCAL_MAX &&
+	    irq != IRQ_VS_SOFT &&
 	    irq != IRQ_VS_TIMER &&
 	    irq != IRQ_VS_EXT)
 		return -EINVAL;
 
-	set_bit(irq, &vcpu->arch.irqs_pending);
+	set_bit(irq, vcpu->arch.irqs_pending);
 	smp_mb__before_atomic();
-	set_bit(irq, &vcpu->arch.irqs_pending_mask);
+	set_bit(irq, vcpu->arch.irqs_pending_mask);
 
 	kvm_vcpu_kick(vcpu);
 
@@ -859,25 +866,33 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 
 int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 {
-	if (irq != IRQ_VS_SOFT &&
+	/*
+	 * We only allow VS-mode software, timer, and external
+	 * interrupts when irq is one of the local interrupts
+	 * defined by RISC-V privilege specification.
+	 */
+	if (irq < IRQ_LOCAL_MAX &&
+	    irq != IRQ_VS_SOFT &&
 	    irq != IRQ_VS_TIMER &&
 	    irq != IRQ_VS_EXT)
 		return -EINVAL;
 
-	clear_bit(irq, &vcpu->arch.irqs_pending);
+	clear_bit(irq, vcpu->arch.irqs_pending);
 	smp_mb__before_atomic();
-	set_bit(irq, &vcpu->arch.irqs_pending_mask);
+	set_bit(irq, vcpu->arch.irqs_pending_mask);
 
 	return 0;
 }
 
-bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, unsigned long mask)
+bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
 {
 	unsigned long ie;
 
 	ie = ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
-		<< VSIP_TO_HVIP_SHIFT) & mask;
-	if (READ_ONCE(vcpu->arch.irqs_pending) & ie)
+		<< VSIP_TO_HVIP_SHIFT) & (unsigned long)mask;
+	ie |= vcpu->arch.guest_csr.vsie & ~IRQ_LOCAL_MASK &
+		(unsigned long)mask;
+	if (READ_ONCE(vcpu->arch.irqs_pending[0]) & ie)
 		return true;
 
 	/* Check AIA high interrupts */
-- 
2.34.1

