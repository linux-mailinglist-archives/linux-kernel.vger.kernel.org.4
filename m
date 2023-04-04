Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C306D6789
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbjDDPgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbjDDPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:36:23 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1001F524E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:36:02 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id w13-20020a4aca0d000000b0053b8aa32089so5221013ooq.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680622557; x=1683214557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuyefCMrEGb6zxtF4trC2hDPFKrujg1KHw2Hj4tSfWs=;
        b=GEJkJ8ZNOSYF4yLuQQji2HfR1F3YxAQlLQTg+r3ygy+ZTCvpXBB/o4ab9A9Y8nz3UB
         q906JxOuzFe/79ellhU6DX8sww9NfyOxJX4eyBRGeWzfyLeC9WB5qyLiSaldamDlX1t4
         yjp2t5crDY0WtrH5DGMEb2/eJTLCgxVw+KAAFgGJQH3NHSjfnBoATU22PMqshVXHJ8rX
         3sojzFan5J+XOvKgh48xziTsl7Mc5gjYLD1ytUx18316RlJTpQpQzl92aj+EQtl3VeaO
         y6gcJKtOEZZ5JTCTGVB3KVLJmmfmU8NcL8NCDr6XQWu/R2TGSAoE/RvSzw9DE0Y+pxtJ
         YJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680622557; x=1683214557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuyefCMrEGb6zxtF4trC2hDPFKrujg1KHw2Hj4tSfWs=;
        b=3+yQdzlnNdIHpi5VMexHh988S26NqnOD4JC1YaLbmlRidZ+G37X4FlhvG1zV4jt6Hk
         8LxeTTYHHXQDaOwhTfve5TqjxTl6pABwzB63YSGs8o4nBOgC3NZOS/3MonJHDwlO1V/F
         9vvY5BQRpcCWTTmeVHWfYOYN+XtQkVMh6/dSq5mSFlan1PgamsMGudhH7J4iP/n74s+l
         jFzWdMkhw7hWYBthcITEcvUeLCxYXN2iFOAELKV7MbqrdV6q6N8o5nrOperoc5L1Evpu
         1tusvEudGUhpmr9fD+PPVSkBFeB9awnenXhWi3RVmyphoGcgr73B9Hlt/z9kPiz/4b13
         9MzA==
X-Gm-Message-State: AAQBX9ek+ElSd6NAsWsm3dReyB9HV2X5OUdGRbT/JA0TimaLMIkmc4s7
        2Eyr90LLuUjcrTJBE4f5UNRs4g==
X-Google-Smtp-Source: AKy350ZmBNsRy5H9bUIF5udf7Pe4BcETxczDRhAG7n4QPyLCbhpY+BwblmwzCdQCM+b4Z9AefIDSqg==
X-Received: by 2002:a4a:41c3:0:b0:517:4020:60b6 with SMTP id x186-20020a4a41c3000000b00517402060b6mr1281394ooa.8.1680622557175;
        Tue, 04 Apr 2023 08:35:57 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id w124-20020acadf82000000b00387384dc768sm5325803oig.9.2023.04.04.08.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 08:35:56 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 8/9] RISC-V: KVM: Virtualize per-HART AIA CSRs
Date:   Tue,  4 Apr 2023 21:04:51 +0530
Message-Id: <20230404153452.2405681-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404153452.2405681-1-apatel@ventanamicro.com>
References: <20230404153452.2405681-1-apatel@ventanamicro.com>
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
 arch/riscv/include/asm/kvm_aia.h  |  88 ++++----
 arch/riscv/include/uapi/asm/kvm.h |   7 +
 arch/riscv/kvm/aia.c              | 322 ++++++++++++++++++++++++++++++
 3 files changed, 382 insertions(+), 35 deletions(-)

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
index 7a633331cd3e..4bf1e83add55 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -7,6 +7,7 @@
  *	Anup Patel <apatel@ventanamicro.com>
  */
 
+#include <linux/kernel.h>
 #include <linux/kvm_host.h>
 #include <asm/hwcap.h>
 
@@ -26,6 +27,327 @@ static void aia_set_hvictl(bool ext_irq_pending)
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
+	    (vcpu->arch.aia_context.guest_csr.vsieh & upper_32_bits(mask))
+		return true;
+#endif
+
+	seip = vcpu->arch.guest_csr.vsie;
+	seip &= (unsigned long)mask;
+	seip &= BIT(IRQ_S_EXT);
+
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
+	aia_set_hvictl(!!(csr->hvip & BIT(IRQ_VS_EXT)));
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
+	}
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
+	}
+
+	hviprio &= ~(TOPI_IPRIO_MASK << (bitpos % BITS_PER_LONG));
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
+	}
+}
+
+static int aia_rmw_iprio(struct kvm_vcpu *vcpu, unsigned int isel,
+			 unsigned long *val, unsigned long new_val,
+			 unsigned long wr_mask)
+{
+	int i, first_irq, nirqs;
+	unsigned long old_val;
+	u8 prio;
+
+#ifndef CONFIG_32BIT
+	if (isel & 0x1)
+		return KVM_INSN_ILLEGAL_TRAP;
+#endif
+
+	nirqs = 4 * (BITS_PER_LONG / 32);
+	first_irq = (isel - ISELECT_IPRIO0) * 4;
+
+	old_val = 0;
+	for (i = 0; i < nirqs; i++) {
+		prio = aia_get_iprio8(vcpu, first_irq + i);
+		old_val |= (unsigned long)prio << (TOPI_IPRIO_BITS * i);
+	}
+
+	if (val)
+		*val = old_val;
+
+	if (wr_mask) {
+		new_val = (old_val & ~wr_mask) | (new_val & wr_mask);
+		for (i = 0; i < nirqs; i++) {
+			prio = (new_val >> (TOPI_IPRIO_BITS * i)) &
+				TOPI_IPRIO_MASK;
+			aia_set_iprio8(vcpu, first_irq + i, prio);
+		}
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
-- 
2.34.1

