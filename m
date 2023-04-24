Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4F66D40BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjDCJfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjDCJej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:34:39 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC86F10AAF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:34:12 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-17aceccdcf6so30055293fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680514449; x=1683106449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36qDkjzHmxUW0X2MqXPdSwGD3Ix1QdRn1PpTCnDGYIc=;
        b=m8mCm6sqS+HQJL58ugQ3EdcYkZbLDbyhNL0+DRFMcMlqxNJ0231SbcNn/qvXNaCQFG
         6snzMGRyDOMjO547GUXzF5gmjgSUUslGalQAIZ24Vi1+1+OwicCLYidNY/D86dKoURFw
         t66fPH/tFGXIC5cIMEforKgHC7Iyf56pcwWC/wV9nzi9/SPKMnX9Qk7Iy5fHxuZp1rUJ
         WgSYxuBPdujbCCGWZcMXLZLT9XzGTXyF6uWV7QV+WDOjp4D/vDTuyC+/Ck8BVdZT/ecO
         mlhn60ff9usfWAjoZnK3BPI+KAhjTj21KkMlRZCWjvMm9g9E1zWp5hXBbVxxZ7cHWQJO
         Efog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680514449; x=1683106449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36qDkjzHmxUW0X2MqXPdSwGD3Ix1QdRn1PpTCnDGYIc=;
        b=FyDDOm30kzo6CY9cG3MlkBwxV//c/AxUmlmman+fvjKtmakKrQ2RSqGMJmnJuaFOuA
         HlktQHYdX49ODVbLe8Xm1BzfABVaXE7d2/ycKaodV0hArnXbl6CN/tQuCOYop/p7K/ot
         a94klV5UuOIjwzA+sSmxQ4yOcNg8kN1y9Jl+Wi6SAX3BQmWPOu4OTbeu7aQfW/S3+V2J
         6hFY6Jq7psgi8ARt3n3llH7jjmL2hjfse7PXWPV7avqIcAD4HB8MsbicqpO9309QnlMs
         MYhjTGXFZrd26xhdYrXSaliT3ebFNTazscJdpKoDsauiy4dxPuzsdYsQBD0LlG0RyZHY
         jNYA==
X-Gm-Message-State: AAQBX9dJ5cIrwj11irBW+KAxSTrWcHzjq2LJGiaAFwcZRHsKVMfpgGLN
        xJfqb8BaYv4xy53t68sCsGT/6w==
X-Google-Smtp-Source: AKy350YjRdWP+xUY9L9lpLX/5hHDHBgauckPBqmpIgXJTscIVZAqp254ZBZcmZJTcjtIYuQrAW+FoQ==
X-Received: by 2002:a05:6870:972a:b0:17a:e448:3dcd with SMTP id n42-20020a056870972a00b0017ae4483dcdmr22233510oaq.59.1680514448816;
        Mon, 03 Apr 2023 02:34:08 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id f5-20020a9d6c05000000b006a154373578sm3953953otq.39.2023.04.03.02.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 02:34:08 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 8/8] RISC-V: KVM: Implement guest external interrupt line management
Date:   Mon,  3 Apr 2023 15:03:10 +0530
Message-Id: <20230403093310.2271142-9-apatel@ventanamicro.com>
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

The RISC-V host will have one guest external interrupt line for each
VS-level IMSICs associated with a HART. The guest external interrupt
lines are per-HART resources and hypervisor can use HGEIE, HGEIP, and
HIE CSRs to manage these guest external interrupt lines.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_aia.h |  10 ++
 arch/riscv/kvm/aia.c             | 241 +++++++++++++++++++++++++++++++
 arch/riscv/kvm/main.c            |   3 +-
 arch/riscv/kvm/vcpu.c            |   2 +
 4 files changed, 255 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index 1de0717112e5..0938e0cadf80 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -44,10 +44,15 @@ struct kvm_vcpu_aia {
 
 #define irqchip_in_kernel(k)		((k)->arch.aia.in_kernel)
 
+extern unsigned int kvm_riscv_aia_nr_hgei;
 DECLARE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
 #define kvm_riscv_aia_available() \
 	static_branch_unlikely(&kvm_riscv_aia_available)
 
+static inline void kvm_riscv_vcpu_aia_imsic_release(struct kvm_vcpu *vcpu)
+{
+}
+
 #define KVM_RISCV_AIA_IMSIC_TOPEI	(ISELECT_MASK + 1)
 static inline int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *vcpu,
 					       unsigned long isel,
@@ -119,6 +124,11 @@ static inline void kvm_riscv_aia_destroy_vm(struct kvm *kvm)
 {
 }
 
+int kvm_riscv_aia_alloc_hgei(int cpu, struct kvm_vcpu *owner,
+			     void __iomem **hgei_va, phys_addr_t *hgei_pa);
+void kvm_riscv_aia_free_hgei(int cpu, int hgei);
+void kvm_riscv_aia_wakeon_hgei(struct kvm_vcpu *owner, bool enable);
+
 void kvm_riscv_aia_enable(void);
 void kvm_riscv_aia_disable(void);
 int kvm_riscv_aia_init(void);
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index d530912f28bc..1264783e7c4d 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -7,11 +7,46 @@
  *	Anup Patel <apatel@ventanamicro.com>
  */
 
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/kvm_host.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
 #include <asm/hwcap.h>
 
+struct aia_hgei_control {
+	raw_spinlock_t lock;
+	unsigned long free_bitmap;
+	struct kvm_vcpu *owners[BITS_PER_LONG];
+};
+static DEFINE_PER_CPU(struct aia_hgei_control, aia_hgei);
+static int hgei_parent_irq;
+
+unsigned int kvm_riscv_aia_nr_hgei;
 DEFINE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
 
+static int aia_find_hgei(struct kvm_vcpu *owner)
+{
+	int i, hgei;
+	unsigned long flags;
+	struct aia_hgei_control *hgctrl = this_cpu_ptr(&aia_hgei);
+
+	raw_spin_lock_irqsave(&hgctrl->lock, flags);
+
+	hgei = -1;
+	for (i = 1; i <= kvm_riscv_aia_nr_hgei; i++) {
+		if (hgctrl->owners[i] == owner) {
+			hgei = i;
+			break;
+		}
+	}
+
+	raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
+
+	return hgei;
+}
+
 static void aia_set_hvictl(bool ext_irq_pending)
 {
 	unsigned long hvictl;
@@ -55,6 +90,7 @@ void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
 
 bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
 {
+	int hgei;
 	unsigned long seip;
 
 	if (!kvm_riscv_aia_available())
@@ -72,6 +108,10 @@ bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
 	if (!kvm_riscv_aia_initialized(vcpu->kvm) || !seip)
 		return false;
 
+	hgei = aia_find_hgei(vcpu);
+	if (hgei > 0)
+		return (csr_read(CSR_HGEIP) & BIT(hgei)) ? true : false;
+
 	return false;
 }
 
@@ -343,6 +383,144 @@ int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_num,
 	return KVM_INSN_EXIT_TO_USER_SPACE;
 }
 
+int kvm_riscv_aia_alloc_hgei(int cpu, struct kvm_vcpu *owner,
+			     void __iomem **hgei_va, phys_addr_t *hgei_pa)
+{
+	int ret = -ENOENT;
+	unsigned long flags;
+	struct aia_hgei_control *hgctrl = per_cpu_ptr(&aia_hgei, cpu);
+
+	if (!kvm_riscv_aia_available())
+		return -ENODEV;
+	if (!hgctrl)
+		return -ENODEV;
+
+	raw_spin_lock_irqsave(&hgctrl->lock, flags);
+
+	if (hgctrl->free_bitmap) {
+		ret = __ffs(hgctrl->free_bitmap);
+		hgctrl->free_bitmap &= ~BIT(ret);
+		hgctrl->owners[ret] = owner;
+	}
+
+	raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
+
+	/* TODO: To be updated later by AIA in-kernel irqchip support */
+	if (hgei_va)
+		*hgei_va = NULL;
+	if (hgei_pa)
+		*hgei_pa = 0;
+
+	return ret;
+}
+
+void kvm_riscv_aia_free_hgei(int cpu, int hgei)
+{
+	unsigned long flags;
+	struct aia_hgei_control *hgctrl = per_cpu_ptr(&aia_hgei, cpu);
+
+	if (!kvm_riscv_aia_available() || !hgctrl)
+		return;
+
+	raw_spin_lock_irqsave(&hgctrl->lock, flags);
+
+	if (hgei > 0 && hgei <= kvm_riscv_aia_nr_hgei) {
+		if (!(hgctrl->free_bitmap & BIT(hgei))) {
+			hgctrl->free_bitmap |= BIT(hgei);
+			hgctrl->owners[hgei] = NULL;
+		}
+	}
+
+	raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
+}
+
+void kvm_riscv_aia_wakeon_hgei(struct kvm_vcpu *owner, bool enable)
+{
+	int hgei;
+
+	if (!kvm_riscv_aia_available())
+		return;
+
+	hgei = aia_find_hgei(owner);
+	if (hgei > 0) {
+		if (enable)
+			csr_set(CSR_HGEIE, BIT(hgei));
+		else
+			csr_clear(CSR_HGEIE, BIT(hgei));
+	}
+}
+
+static irqreturn_t hgei_interrupt(int irq, void *dev_id)
+{
+	int i;
+	unsigned long hgei_mask, flags;
+	struct aia_hgei_control *hgctrl = this_cpu_ptr(&aia_hgei);
+
+	hgei_mask = csr_read(CSR_HGEIP) & csr_read(CSR_HGEIE);
+	csr_clear(CSR_HGEIE, hgei_mask);
+
+	raw_spin_lock_irqsave(&hgctrl->lock, flags);
+
+	for_each_set_bit(i, &hgei_mask, BITS_PER_LONG) {
+		if (hgctrl->owners[i])
+			kvm_vcpu_kick(hgctrl->owners[i]);
+	}
+
+	raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static int aia_hgei_init(void)
+{
+	int cpu, rc;
+	struct irq_domain *domain;
+	struct aia_hgei_control *hgctrl;
+
+	/* Initialize per-CPU guest external interrupt line management */
+	for_each_possible_cpu(cpu) {
+		hgctrl = per_cpu_ptr(&aia_hgei, cpu);
+		raw_spin_lock_init(&hgctrl->lock);
+		if (kvm_riscv_aia_nr_hgei) {
+			hgctrl->free_bitmap =
+				BIT(kvm_riscv_aia_nr_hgei + 1) - 1;
+			hgctrl->free_bitmap &= ~BIT(0);
+		} else
+			hgctrl->free_bitmap = 0;
+	}
+
+	/* Find INTC irq domain */
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!domain) {
+		kvm_err("unable to find INTC domain\n");
+		return -ENOENT;
+	}
+
+	/* Map per-CPU SGEI interrupt from INTC domain */
+	hgei_parent_irq = irq_create_mapping(domain, IRQ_S_GEXT);
+	if (!hgei_parent_irq) {
+		kvm_err("unable to map SGEI IRQ\n");
+		return -ENOMEM;
+	}
+
+	/* Request per-CPU SGEI interrupt */
+	rc = request_percpu_irq(hgei_parent_irq, hgei_interrupt,
+				"riscv-kvm", &aia_hgei);
+	if (rc) {
+		kvm_err("failed to request SGEI IRQ\n");
+		return rc;
+	}
+
+	return 0;
+}
+
+static void aia_hgei_exit(void)
+{
+	/* Free per-CPU SGEI interrupt */
+	free_percpu_irq(hgei_parent_irq, &aia_hgei);
+}
+
 void kvm_riscv_aia_enable(void)
 {
 	if (!kvm_riscv_aia_available())
@@ -357,21 +535,79 @@ void kvm_riscv_aia_enable(void)
 	csr_write(CSR_HVIPRIO1H, 0x0);
 	csr_write(CSR_HVIPRIO2H, 0x0);
 #endif
+
+	/* Enable per-CPU SGEI interrupt */
+	enable_percpu_irq(hgei_parent_irq,
+			  irq_get_trigger_type(hgei_parent_irq));
+	csr_set(CSR_HIE, BIT(IRQ_S_GEXT));
 }
 
 void kvm_riscv_aia_disable(void)
 {
+	int i;
+	unsigned long flags;
+	struct kvm_vcpu *vcpu;
+	struct aia_hgei_control *hgctrl = this_cpu_ptr(&aia_hgei);
+
 	if (!kvm_riscv_aia_available())
 		return;
 
+	/* Disable per-CPU SGEI interrupt */
+	csr_clear(CSR_HIE, BIT(IRQ_S_GEXT));
+	disable_percpu_irq(hgei_parent_irq);
+
 	aia_set_hvictl(false);
+
+	raw_spin_lock_irqsave(&hgctrl->lock, flags);
+
+	for (i = 0; i <= kvm_riscv_aia_nr_hgei; i++) {
+		vcpu = hgctrl->owners[i];
+		if (!vcpu)
+			continue;
+
+		/*
+		 * We release hgctrl->lock before notifying IMSIC
+		 * so that we don't have lock ordering issues.
+		 */
+		raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
+
+		/* Notify IMSIC */
+		kvm_riscv_vcpu_aia_imsic_release(vcpu);
+
+		/*
+		 * Wakeup VCPU if it was blocked so that it can
+		 * run on other HARTs
+		 */
+		if (csr_read(CSR_HGEIE) & BIT(i)) {
+			csr_clear(CSR_HGEIE, BIT(i));
+			kvm_vcpu_kick(vcpu);
+		}
+
+		raw_spin_lock_irqsave(&hgctrl->lock, flags);
+	}
+
+	raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
 }
 
 int kvm_riscv_aia_init(void)
 {
+	int rc;
+
 	if (!riscv_isa_extension_available(NULL, SxAIA))
 		return -ENODEV;
 
+	/* Figure-out number of bits in HGEIE */
+	csr_write(CSR_HGEIE, -1UL);
+	kvm_riscv_aia_nr_hgei = fls_long(csr_read(CSR_HGEIE));
+	csr_write(CSR_HGEIE, 0);
+	if (kvm_riscv_aia_nr_hgei)
+		kvm_riscv_aia_nr_hgei--;
+
+	/* Initialize guest external interrupt line management */
+	rc = aia_hgei_init();
+	if (rc)
+		return rc;
+
 	/* Enable KVM AIA support */
 	static_branch_enable(&kvm_riscv_aia_available);
 
@@ -380,4 +616,9 @@ int kvm_riscv_aia_init(void)
 
 void kvm_riscv_aia_exit(void)
 {
+	if (!kvm_riscv_aia_available())
+		return;
+
+	/* Cleanup the HGEI state */
+	aia_hgei_exit();
 }
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 6396352b4e4d..b0b46f48f31e 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -116,7 +116,8 @@ static int __init riscv_kvm_init(void)
 	kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits());
 
 	if (kvm_riscv_aia_available())
-		kvm_info("AIA available\n");
+		kvm_info("AIA available with %d guest external interrupts\n",
+			 kvm_riscv_aia_nr_hgei);
 
 	rc = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 	if (rc) {
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 30acf3ebdc3d..eace51dd896f 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -249,10 +249,12 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
+	kvm_riscv_aia_wakeon_hgei(vcpu, true);
 }
 
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
+	kvm_riscv_aia_wakeon_hgei(vcpu, false);
 }
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
-- 
2.34.1

