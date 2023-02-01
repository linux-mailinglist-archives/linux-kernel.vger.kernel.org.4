Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA967F590
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjA1H2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjA1H2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:28:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6E18D423
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:28:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso10075423pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOZwyKNH55hfy+v8yv2QzCDrhDdi6VPYfaL4N21XaZ8=;
        b=Fd8aCWPg+GTvvAKQZ2kMd+iVABMR08ANNO3fVbq/4cz+osgfYYAsI88ikKxOZ6OSUx
         a97COT8JuJmN0rT0f1WpLswnUi0cCitQHOUZdupev4T3Pjgv9f80pkIXQHA/BzMuwxhM
         TuEst6F0cdNr6osfRqUjfeOFTDl94U4Y/an/ongssx60WBSbKuWjMpHw9Trvd0AI2Kk4
         kIS2U9hS7zDFjewFB2DaCPW9Y21GoqbctRMdrdMaoI3PcTCatmW85yZCN19U1lRjM1Ai
         JBRJDItA8kAG1EXktTeErP4NsgR0CwNZujt/bSjxmQ5TFHliiC1qYYf3BYhuY+l8daEO
         ZjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOZwyKNH55hfy+v8yv2QzCDrhDdi6VPYfaL4N21XaZ8=;
        b=EfGu2BMwpjxPkihGhMVxfeAO6ZJBkTdlDuCtaTsHEmA7XvbCXDxFpblvRiuGspfKSn
         qtOJiwUPHPxBYJrSiVJPWYrUL10Rwo6YbHBpFVkHxxpVN0cIerILFCQg+6JsmuAHpqhT
         ZXEJvKLXrVukJqiaCI4zz4RxWpHsUv4i1BGSTWyRdrXf2VJR36wA7UBdI0e5Pk2RW4fU
         GnVMpUKDCMUgzpqq+wXIRaAvEohe3kgBIJYf5/krW0Kzj1LAH8M9rngdJLJNUhMx5Tb4
         kSAf8KaomaYzdivuIEbodGzOwO7CuRC1JWP9VveQT4YQAHbXf5v2PaPs5/cTmrddhbIJ
         3yNA==
X-Gm-Message-State: AO0yUKW8juJ6DDF5adrAFR/3JdVxUMjnk9qZoCyj8ZVRr7bCneFI/L7x
        7UomGTs7ZEnTP8+1/YY0BD7AcA==
X-Google-Smtp-Source: AK7set9vO0RzwyEGLiNNZod11dbN9ll23K3y7FCNOF9PmDrSw6eWfzHLvC+MDQLUvDIvEd9CIMa3AA==
X-Received: by 2002:a17:902:e74a:b0:196:6663:43e8 with SMTP id p10-20020a170902e74a00b00196666343e8mr1272019plf.7.1674890895672;
        Fri, 27 Jan 2023 23:28:15 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b00194ac38bc86sm753132plb.131.2023.01.27.23.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 23:28:15 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 6/7] RISC-V: KVM: Virtualize per-HART AIA CSRs
Date:   Sat, 28 Jan 2023 12:57:36 +0530
Message-Id: <20230128072737.2995881-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230128072737.2995881-1-apatel@ventanamicro.com>
References: <20230128072737.2995881-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 8776e7a465c7..607254177270 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -203,8 +203,9 @@ struct kvm_vcpu_arch {
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
@@ -331,7 +332,7 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq);
 int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq);
 void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu);
-bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, unsigned long mask);
+bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask);
 void kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu);
 void kvm_riscv_vcpu_power_on(struct kvm_vcpu *vcpu);
 
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index d0704eff0121..8aae65424a43 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -80,6 +80,13 @@ struct kvm_riscv_csr {
 
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
index 7a633331cd3e..3d68189e0bb1 100644
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
+	    (vcpu->arch.aia.guest_csr.vsieh & (unsigned long)(mask >> 32)))
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
+	csr_write(CSR_HVIPH, vcpu->arch.aia.guest_csr.hviph);
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
index 37933ea20274..151b35b3b05f 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -139,8 +139,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_riscv_vcpu_aia_reset(vcpu);
 
-	WRITE_ONCE(vcpu->arch.irqs_pending, 0);
-	WRITE_ONCE(vcpu->arch.irqs_pending_mask, 0);
+	bitmap_zero(vcpu->arch.irqs_pending, KVM_RISCV_VCPU_NR_IRQS);
+	bitmap_zero(vcpu->arch.irqs_pending_mask, KVM_RISCV_VCPU_NR_IRQS);
 
 	vcpu->arch.hfence_head = 0;
 	vcpu->arch.hfence_tail = 0;
@@ -465,6 +465,7 @@ static int kvm_riscv_vcpu_general_get_csr(struct kvm_vcpu *vcpu,
 	if (reg_num == KVM_REG_RISCV_CSR_REG(sip)) {
 		kvm_riscv_vcpu_flush_interrupts(vcpu);
 		*out_val = (csr->hvip >> VSIP_TO_HVIP_SHIFT) & VSIP_VALID_MASK;
+		*out_val |= csr->hvip & ~IRQ_LOCAL_MASK;
 	} else
 		*out_val = ((unsigned long *)csr)[reg_num];
 
@@ -525,7 +526,7 @@ static inline int kvm_riscv_vcpu_general_set_csr(struct kvm_vcpu *vcpu,
 	((unsigned long *)csr)[reg_num] = reg_val;
 
 	if (reg_num == KVM_REG_RISCV_CSR_REG(sip))
-		WRITE_ONCE(vcpu->arch.irqs_pending_mask, 0);
+		WRITE_ONCE(vcpu->arch.irqs_pending_mask[0], 0);
 
 	return 0;
 }
@@ -790,9 +791,9 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
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
@@ -816,12 +817,12 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
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
 
@@ -834,14 +835,20 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 
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
 
@@ -850,25 +857,33 @@ int kvm_riscv_vcpu_set_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 
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

