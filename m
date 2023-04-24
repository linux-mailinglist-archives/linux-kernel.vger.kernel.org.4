Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F886D40B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjDCJeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjDCJeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:34:05 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995D113ED
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:33:48 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso15268725oti.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680514428; x=1683106428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lljahLWuR8JsBD3gvCl5zR1uriSA22DscqZTWVKA5Bk=;
        b=L5+GwuntdfH8mGUyXgcyS5qyVKfxWqdw2dWbNN3sLPpBL7FX0J+TZ4EjYf3MyfoL5z
         DRVty0aSIHMVsHpMe1R3TL+qxms0ZEk+qRHDC4ZuyAq/5t73Ia/PAGq3oks66BIsgowy
         ESk0KsUa3gclFpPmIE8zQageNKmwLFxC7r94aihIadepLz8VWhmpwscjMKGahcv5NtaF
         5acFq5wHyqWUBPqjwa0yN3+H96jKFbc2HmF637EetXL8kpQdB+01k/ogg/kz2JhRFsbC
         ihQyEXPSje1wtGTzTXC9Y3m1ohF0DxC5IGdy5Y8MWdkhy5fR1jvy0yALZl8h3IGC3jhf
         wRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680514428; x=1683106428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lljahLWuR8JsBD3gvCl5zR1uriSA22DscqZTWVKA5Bk=;
        b=Se3jXz1gY6th+M7a64gudfjlyxBMXifTlgRZgCLjmaaPnt8KiefRIkEG7JQJSP1TJL
         w4bttinkjV/D9jmC5tchbsq0CXHLNJLPWCimAZx/M8A9ME6lzsNPAt//uK1befuudXY0
         nlyzHBb7LfOkaTcWRZn3nSTCVq3B8fN66TqMqTULt9bKHK1d/jCHm8H4Nc0l+p4rSTU6
         X41y+LBZipMIXFn3LQdRVwb4CL+TVZEqRMksdsU3YQXCxjyi5hzun2ysMqCh8tSDpT/E
         rm70OYtfJA6asj2eg189/cyugwK1frsJxxCPFjwuOIZyac6+xDYx0HNTkQENtoZJahgz
         ysZw==
X-Gm-Message-State: AO0yUKWivtnXqiu/B51kkzGLCXj1EAmmyWzCAEIQZlo37E1JG3QFv36Y
        foM7jKS6nZ5YsTGL7vwYIxs2dQ==
X-Google-Smtp-Source: AK7set8tUP1xuIoR8AIEmfQEvrtxD4mAhhFCj7a6xnzWFjymW7IL9TviQws7YgHiCc4g1MXo7BiWsA==
X-Received: by 2002:a05:6830:e86:b0:69d:113c:c0e0 with SMTP id dp6-20020a0568300e8600b0069d113cc0e0mr14453670otb.36.1680514427756;
        Mon, 03 Apr 2023 02:33:47 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id f5-20020a9d6c05000000b006a154373578sm3953953otq.39.2023.04.03.02.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 02:33:47 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v3 4/8] RISC-V: KVM: Initial skeletal support for AIA
Date:   Mon,  3 Apr 2023 15:03:06 +0530
Message-Id: <20230403093310.2271142-5-apatel@ventanamicro.com>
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

To incrementally implement AIA support, we first add minimal skeletal
support which only compiles and detects AIA hardware support at the
boot-time but does not provide any functionality.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h    |   6 ++
 arch/riscv/include/asm/kvm_aia.h  | 109 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/kvm_host.h |   7 ++
 arch/riscv/kvm/Makefile           |   1 +
 arch/riscv/kvm/aia.c              |  66 ++++++++++++++++++
 arch/riscv/kvm/main.c             |  22 +++++-
 arch/riscv/kvm/vcpu.c             |  40 ++++++++++-
 arch/riscv/kvm/vcpu_insn.c        |   1 +
 arch/riscv/kvm/vm.c               |   4 ++
 9 files changed, 252 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/include/asm/kvm_aia.h
 create mode 100644 arch/riscv/kvm/aia.c

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 9c8ae4399565..8087e11a5cf8 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -48,6 +48,12 @@
 #define RISCV_ISA_EXT_MAX		64
 #define RISCV_ISA_EXT_NAME_LEN_MAX	32
 
+#ifdef CONFIG_RISCV_M_MODE
+#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
+#else
+#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <linux/jump_label.h>
diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
new file mode 100644
index 000000000000..258a835d4c32
--- /dev/null
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ *
+ * Authors:
+ *	Anup Patel <apatel@ventanamicro.com>
+ */
+
+#ifndef __KVM_RISCV_AIA_H
+#define __KVM_RISCV_AIA_H
+
+#include <linux/jump_label.h>
+#include <linux/kvm_types.h>
+
+struct kvm_aia {
+	/* In-kernel irqchip created */
+	bool		in_kernel;
+
+	/* In-kernel irqchip initialized */
+	bool		initialized;
+};
+
+struct kvm_vcpu_aia {
+};
+
+#define kvm_riscv_aia_initialized(k)	((k)->arch.aia.initialized)
+
+#define irqchip_in_kernel(k)		((k)->arch.aia.in_kernel)
+
+DECLARE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
+#define kvm_riscv_aia_available() \
+	static_branch_unlikely(&kvm_riscv_aia_available)
+
+static inline void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_vcpu *vcpu)
+{
+}
+
+static inline void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
+{
+}
+
+static inline bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu,
+						     u64 mask)
+{
+	return false;
+}
+
+static inline void kvm_riscv_vcpu_aia_update_hvip(struct kvm_vcpu *vcpu)
+{
+}
+
+static inline void kvm_riscv_vcpu_aia_load(struct kvm_vcpu *vcpu, int cpu)
+{
+}
+
+static inline void kvm_riscv_vcpu_aia_put(struct kvm_vcpu *vcpu)
+{
+}
+
+static inline int kvm_riscv_vcpu_aia_get_csr(struct kvm_vcpu *vcpu,
+					     unsigned long reg_num,
+					     unsigned long *out_val)
+{
+	*out_val = 0;
+	return 0;
+}
+
+static inline int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
+					     unsigned long reg_num,
+					     unsigned long val)
+{
+	return 0;
+}
+
+#define KVM_RISCV_VCPU_AIA_CSR_FUNCS
+
+static inline int kvm_riscv_vcpu_aia_update(struct kvm_vcpu *vcpu)
+{
+	return 1;
+}
+
+static inline void kvm_riscv_vcpu_aia_reset(struct kvm_vcpu *vcpu)
+{
+}
+
+static inline int kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static inline void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcpu)
+{
+}
+
+static inline void kvm_riscv_aia_init_vm(struct kvm *kvm)
+{
+}
+
+static inline void kvm_riscv_aia_destroy_vm(struct kvm *kvm)
+{
+}
+
+void kvm_riscv_aia_enable(void);
+void kvm_riscv_aia_disable(void);
+int kvm_riscv_aia_init(void);
+void kvm_riscv_aia_exit(void);
+
+#endif
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index cc7da66ee0c0..3157cf748df1 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -14,6 +14,7 @@
 #include <linux/kvm_types.h>
 #include <linux/spinlock.h>
 #include <asm/hwcap.h>
+#include <asm/kvm_aia.h>
 #include <asm/kvm_vcpu_fp.h>
 #include <asm/kvm_vcpu_insn.h>
 #include <asm/kvm_vcpu_sbi.h>
@@ -94,6 +95,9 @@ struct kvm_arch {
 
 	/* Guest Timer */
 	struct kvm_guest_timer timer;
+
+	/* AIA Guest/VM context */
+	struct kvm_aia aia;
 };
 
 struct kvm_cpu_trap {
@@ -221,6 +225,9 @@ struct kvm_vcpu_arch {
 	/* SBI context */
 	struct kvm_vcpu_sbi_context sbi_context;
 
+	/* AIA VCPU context */
+	struct kvm_vcpu_aia aia_context;
+
 	/* Cache pages needed to program page tables with spinlock held */
 	struct kvm_mmu_memory_cache mmu_page_cache;
 
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 278e97c06e0a..8031b8912a0d 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -26,3 +26,4 @@ kvm-y += vcpu_sbi_replace.o
 kvm-y += vcpu_sbi_hsm.o
 kvm-y += vcpu_timer.o
 kvm-$(CONFIG_RISCV_PMU_SBI) += vcpu_pmu.o vcpu_sbi_pmu.o
+kvm-y += aia.o
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
new file mode 100644
index 000000000000..7a633331cd3e
--- /dev/null
+++ b/arch/riscv/kvm/aia.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ *
+ * Authors:
+ *	Anup Patel <apatel@ventanamicro.com>
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/hwcap.h>
+
+DEFINE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
+
+static void aia_set_hvictl(bool ext_irq_pending)
+{
+	unsigned long hvictl;
+
+	/*
+	 * HVICTL.IID == 9 and HVICTL.IPRIO == 0 represents
+	 * no interrupt in HVICTL.
+	 */
+
+	hvictl = (IRQ_S_EXT << HVICTL_IID_SHIFT) & HVICTL_IID;
+	hvictl |= ext_irq_pending;
+	csr_write(CSR_HVICTL, hvictl);
+}
+
+void kvm_riscv_aia_enable(void)
+{
+	if (!kvm_riscv_aia_available())
+		return;
+
+	aia_set_hvictl(false);
+	csr_write(CSR_HVIPRIO1, 0x0);
+	csr_write(CSR_HVIPRIO2, 0x0);
+#ifdef CONFIG_32BIT
+	csr_write(CSR_HVIPH, 0x0);
+	csr_write(CSR_HIDELEGH, 0x0);
+	csr_write(CSR_HVIPRIO1H, 0x0);
+	csr_write(CSR_HVIPRIO2H, 0x0);
+#endif
+}
+
+void kvm_riscv_aia_disable(void)
+{
+	if (!kvm_riscv_aia_available())
+		return;
+
+	aia_set_hvictl(false);
+}
+
+int kvm_riscv_aia_init(void)
+{
+	if (!riscv_isa_extension_available(NULL, SxAIA))
+		return -ENODEV;
+
+	/* Enable KVM AIA support */
+	static_branch_enable(&kvm_riscv_aia_available);
+
+	return 0;
+}
+
+void kvm_riscv_aia_exit(void)
+{
+}
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 41ad7639a17b..6396352b4e4d 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -44,11 +44,15 @@ int kvm_arch_hardware_enable(void)
 
 	csr_write(CSR_HVIP, 0);
 
+	kvm_riscv_aia_enable();
+
 	return 0;
 }
 
 void kvm_arch_hardware_disable(void)
 {
+	kvm_riscv_aia_disable();
+
 	/*
 	 * After clearing the hideleg CSR, the host kernel will receive
 	 * spurious interrupts if hvip CSR has pending interrupts and the
@@ -63,6 +67,7 @@ void kvm_arch_hardware_disable(void)
 
 static int __init riscv_kvm_init(void)
 {
+	int rc;
 	const char *str;
 
 	if (!riscv_isa_extension_available(NULL, h)) {
@@ -84,6 +89,10 @@ static int __init riscv_kvm_init(void)
 
 	kvm_riscv_gstage_vmid_detect();
 
+	rc = kvm_riscv_aia_init();
+	if (rc && rc != -ENODEV)
+		return rc;
+
 	kvm_info("hypervisor extension available\n");
 
 	switch (kvm_riscv_gstage_mode()) {
@@ -106,12 +115,23 @@ static int __init riscv_kvm_init(void)
 
 	kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits());
 
-	return kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	if (kvm_riscv_aia_available())
+		kvm_info("AIA available\n");
+
+	rc = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	if (rc) {
+		kvm_riscv_aia_exit();
+		return rc;
+	}
+
+	return 0;
 }
 module_init(riscv_kvm_init);
 
 static void __exit riscv_kvm_exit(void)
 {
+	kvm_riscv_aia_exit();
+
 	kvm_exit();
 }
 module_exit(riscv_kvm_exit);
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 02b49cb94561..1fd54ec15622 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -137,6 +137,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_riscv_vcpu_timer_reset(vcpu);
 
+	kvm_riscv_vcpu_aia_reset(vcpu);
+
 	WRITE_ONCE(vcpu->arch.irqs_pending, 0);
 	WRITE_ONCE(vcpu->arch.irqs_pending_mask, 0);
 
@@ -159,6 +161,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 
 int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
+	int rc;
 	struct kvm_cpu_context *cntx;
 	struct kvm_vcpu_csr *reset_csr = &vcpu->arch.guest_reset_csr;
 	unsigned long host_isa, i;
@@ -201,6 +204,11 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	/* setup performance monitoring */
 	kvm_riscv_vcpu_pmu_init(vcpu);
 
+	/* Setup VCPU AIA */
+	rc = kvm_riscv_vcpu_aia_init(vcpu);
+	if (rc)
+		return rc;
+
 	/* Reset VCPU */
 	kvm_riscv_reset_vcpu(vcpu);
 
@@ -220,6 +228,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
+	/* Cleanup VCPU AIA context */
+	kvm_riscv_vcpu_aia_deinit(vcpu);
+
 	/* Cleanup VCPU timer */
 	kvm_riscv_vcpu_timer_deinit(vcpu);
 
@@ -741,6 +752,9 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
 		csr->hvip &= ~mask;
 		csr->hvip |= val;
 	}
+
+	/* Flush AIA high interrupts */
+	kvm_riscv_vcpu_aia_flush_interrupts(vcpu);
 }
 
 void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
@@ -766,6 +780,9 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	/* Sync-up AIA high interrupts */
+	kvm_riscv_vcpu_aia_sync_interrupts(vcpu);
+
 	/* Sync-up timer CSRs */
 	kvm_riscv_vcpu_timer_sync(vcpu);
 }
@@ -802,10 +819,15 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
 
 bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, unsigned long mask)
 {
-	unsigned long ie = ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
-			    << VSIP_TO_HVIP_SHIFT) & mask;
+	unsigned long ie;
+
+	ie = ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
+		<< VSIP_TO_HVIP_SHIFT) & mask;
+	if (READ_ONCE(vcpu->arch.irqs_pending) & ie)
+		return true;
 
-	return (READ_ONCE(vcpu->arch.irqs_pending) & ie) ? true : false;
+	/* Check AIA high interrupts */
+	return kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
 }
 
 void kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu)
@@ -901,6 +923,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvm_riscv_vcpu_guest_fp_restore(&vcpu->arch.guest_context,
 					vcpu->arch.isa);
 
+	kvm_riscv_vcpu_aia_load(vcpu, cpu);
+
 	vcpu->cpu = cpu;
 }
 
@@ -910,6 +934,8 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 
 	vcpu->cpu = -1;
 
+	kvm_riscv_vcpu_aia_put(vcpu);
+
 	kvm_riscv_vcpu_guest_fp_save(&vcpu->arch.guest_context,
 				     vcpu->arch.isa);
 	kvm_riscv_vcpu_host_fp_restore(&vcpu->arch.host_context);
@@ -977,6 +1003,7 @@ static void kvm_riscv_update_hvip(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 
 	csr_write(CSR_HVIP, csr->hvip);
+	kvm_riscv_vcpu_aia_update_hvip(vcpu);
 }
 
 /*
@@ -1051,6 +1078,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		local_irq_disable();
 
+		/* Update AIA HW state before entering guest */
+		ret = kvm_riscv_vcpu_aia_update(vcpu);
+		if (ret <= 0) {
+			local_irq_enable();
+			continue;
+		}
+
 		/*
 		 * Ensure we set mode to IN_GUEST_MODE after we disable
 		 * interrupts and before the final VCPU requests check.
diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index f689337b78ff..7a6abed41bc1 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -214,6 +214,7 @@ struct csr_func {
 };
 
 static const struct csr_func csr_funcs[] = {
+	KVM_RISCV_VCPU_AIA_CSR_FUNCS
 	KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS
 };
 
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 65a964d7e70d..bc03d2ddcb51 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -41,6 +41,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		return r;
 	}
 
+	kvm_riscv_aia_init_vm(kvm);
+
 	kvm_riscv_guest_timer_init(kvm);
 
 	return 0;
@@ -49,6 +51,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
 	kvm_destroy_vcpus(kvm);
+
+	kvm_riscv_aia_destroy_vm(kvm);
 }
 
 int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
-- 
2.34.1

