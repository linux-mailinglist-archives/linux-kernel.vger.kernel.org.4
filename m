Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18A6252CA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKKEpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiKKEnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:43:53 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691D2B00
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:43:23 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso2244387otr.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqMK06R0If5ha4Gvy43XkI6g7jwRsMR7s4CfIOVvfP0=;
        b=Dz5fPfP4wFbY6zSn1uN7ozIHsW2xSzi8V3HAfVfVipSQHog6Y3PB9MagTZ+4HygU1j
         DlNMsEs8KwQcueF28lVyGlpqBcRKf7xVIa9+FQAigb5ovU/JfAl/z6zRhA3SQlfDwztg
         moLwK82wozgWPSzZrlu4n2tSlwaZCiktjuCSEWQewVkkPaq+JEAH/AhHsNdBIU8egOAg
         Cb1TL2xFOw7FinWvAB5g0UMTYYNulSucfYv807SuUnhb/MPLIkHFfzcii+1kpztakseW
         q/Yc74TYdSn46q4HR8s+bU5wzagQqUG9yE/C/jJBOwMpuLHUwmqxCC41vtSaGjx+RVlO
         IAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqMK06R0If5ha4Gvy43XkI6g7jwRsMR7s4CfIOVvfP0=;
        b=ajmh80yxZ3L9t0xv9JTlwvLMbGw0cZWGgCQ1Aua/fHpAeepwXOvFqKHeLVFNBQtR4E
         Pwevdxm6aS++4dH6NALRosiguM7Ldz6vV23GIhy3Gh/ur+f7cUXroSH2ucoNpDWm9h0E
         3SSLBlOM7BM6CtJ2hPR37BOcEKK5T6tQywqCkYD6VDGnfe9pNIIHzuqnHDmD+QaFlIqw
         iugjqwfpTAtuKoQv6FDt6J5jO5izxhiZXU1ehuEaNEO87Kg5S6r9qYkp/63YkVk/pXYY
         3sJGQ8eOfPE+u4QsizIfg/Imw/jEfn/Bd3586loyZlVevrFGdW0KUi7YM95ABfx1Ucmr
         oMEQ==
X-Gm-Message-State: ANoB5pluwAbdedrQUvxDzI7HduP1p1jUO3NUYIWoe4jtv0KQ2cD+L/cd
        8v7hyZaoi9imfHowV91wtqnGUg==
X-Google-Smtp-Source: AA0mqf5ynqQ7NIJnBNXz0zOLudETiJOo59er6yqe7rEh4C6cjISPIwFeBo+53g7Q9NnMeH2tl91bbg==
X-Received: by 2002:a9d:7c86:0:b0:66b:48b5:6439 with SMTP id q6-20020a9d7c86000000b0066b48b56439mr455278otn.160.1668141802533;
        Thu, 10 Nov 2022 20:43:22 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870350e00b0013d9bd4ad2esm787353oah.12.2022.11.10.20.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:43:22 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 7/9] irqchip: Add RISC-V advanced PLIC driver
Date:   Fri, 11 Nov 2022 10:12:05 +0530
Message-Id: <20221111044207.1478350-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111044207.1478350-1-apatel@ventanamicro.com>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
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

The RISC-V advanced interrupt architecture (AIA) specification defines
a new interrupt controller for managing wired interrupts on a RISC-V
platform. This new interrupt controller is referred to as advanced
platform-level interrupt controller (APLIC) which can forward wired
interrupts to CPUs (or HARTs) as local interrupts OR as message
signaled interrupts.
(For more details refer https://github.com/riscv/riscv-aia)

This patch adds an irqchip driver for RISC-V APLIC found on RISC-V
platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig             |  12 +
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-riscv-aplic.c   | 656 ++++++++++++++++++++++++++++
 include/linux/irqchip/riscv-aplic.h | 117 +++++
 4 files changed, 786 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-aplic.c
 create mode 100644 include/linux/irqchip/riscv-aplic.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 8246c08f0fd3..9f022e71d937 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -563,6 +563,18 @@ config SIFIVE_PLIC
 
 	   If you don't know what to do here, say Y.
 
+config RISCV_APLIC
+	bool "RISC-V Advanced Platform-Level Interrupt Controller"
+	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_MSI_IRQ_DOMAIN
+	help
+	   This enables support for the APLIC chip found in RISC-V systems.
+	   The APLIC controls device wired interrupts and forwards them to
+	   each core as wired local interrupt or per-core MSIs.
+
+	   If you don't know what to do here, say Y.
+
 config RISCV_IMSIC
 	bool "RISC-V Incoming MSI Controller"
 	depends on RISCV
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 22c723cc6ec8..6154e5bc4228 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
+obj-$(CONFIG_RISCV_APLIC)		+= irq-riscv-aplic.o
 obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
diff --git a/drivers/irqchip/irq-riscv-aplic.c b/drivers/irqchip/irq-riscv-aplic.c
new file mode 100644
index 000000000000..e6d0e1bb15a8
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic.c
@@ -0,0 +1,656 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/riscv-aplic.h>
+#include <linux/irqchip/riscv-imsic.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/smp.h>
+
+#define APLIC_DEFAULT_PRIORITY		1
+#define APLIC_DISABLE_IDELIVERY		0
+#define APLIC_ENABLE_IDELIVERY		1
+#define APLIC_DISABLE_ITHRESHOLD	1
+#define APLIC_ENABLE_ITHRESHOLD		0
+
+struct aplic_msicfg {
+	phys_addr_t		base_ppn;
+	u32			hhxs;
+	u32			hhxw;
+	u32			lhxs;
+	u32			lhxw;
+};
+
+struct aplic_idc {
+	unsigned int		hart_index;
+	void __iomem		*regs;
+	struct aplic_priv	*priv;
+};
+
+struct aplic_priv {
+	struct device		*dev;
+	u32			nr_irqs;
+	u32			nr_idcs;
+	void __iomem		*regs;
+	struct irq_domain	*irqdomain;
+	struct aplic_msicfg	msicfg;
+	struct cpumask		lmask;
+};
+
+static unsigned int aplic_idc_parent_irq;
+static DEFINE_PER_CPU(struct aplic_idc, aplic_idcs);
+
+static void aplic_irq_unmask(struct irq_data *d)
+{
+	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	writel(d->hwirq, priv->regs + APLIC_SETIENUM);
+
+	if (!priv->nr_idcs)
+		irq_chip_unmask_parent(d);
+}
+
+static void aplic_irq_mask(struct irq_data *d)
+{
+	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	writel(d->hwirq, priv->regs + APLIC_CLRIENUM);
+
+	if (!priv->nr_idcs)
+		irq_chip_mask_parent(d);
+}
+
+static int aplic_set_type(struct irq_data *d, unsigned int type)
+{
+	u32 val = 0;
+	void __iomem *sourcecfg;
+	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		val = APLIC_SOURCECFG_SM_INACTIVE;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		val = APLIC_SOURCECFG_SM_LEVEL_LOW;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		val = APLIC_SOURCECFG_SM_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		val = APLIC_SOURCECFG_SM_EDGE_FALL;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		val = APLIC_SOURCECFG_SM_EDGE_RISE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sourcecfg = priv->regs + APLIC_SOURCECFG_BASE;
+	sourcecfg += (d->hwirq - 1) * sizeof(u32);
+	writel(val, sourcecfg);
+
+	return 0;
+}
+
+#ifdef CONFIG_SMP
+static int aplic_set_affinity(struct irq_data *d,
+			      const struct cpumask *mask_val, bool force)
+{
+	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
+	struct aplic_idc *idc;
+	unsigned int cpu, val;
+	struct cpumask amask;
+	void __iomem *target;
+
+	if (!priv->nr_idcs)
+		return irq_chip_set_affinity_parent(d, mask_val, force);
+
+	cpumask_and(&amask, &priv->lmask, mask_val);
+
+	if (force)
+		cpu = cpumask_first(&amask);
+	else
+		cpu = cpumask_any_and(&amask, cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	idc = per_cpu_ptr(&aplic_idcs, cpu);
+	target = priv->regs + APLIC_TARGET_BASE;
+	target += (d->hwirq - 1) * sizeof(u32);
+	val = idc->hart_index & APLIC_TARGET_HART_IDX_MASK;
+	val <<= APLIC_TARGET_HART_IDX_SHIFT;
+	val |= APLIC_DEFAULT_PRIORITY;
+	writel(val, target);
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
+static struct irq_chip aplic_chip = {
+	.name		= "RISC-V APLIC",
+	.irq_mask	= aplic_irq_mask,
+	.irq_unmask	= aplic_irq_unmask,
+	.irq_set_type	= aplic_set_type,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = aplic_set_affinity,
+#endif
+	.flags		= IRQCHIP_SET_TYPE_MASKED |
+			  IRQCHIP_SKIP_SET_WAKE |
+			  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int aplic_irqdomain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	if (WARN_ON(fwspec->param_count < 2))
+		return -EINVAL;
+	if (WARN_ON(!fwspec->param[0]))
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+	WARN_ON(*type == IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int aplic_irqdomain_msi_alloc(struct irq_domain *domain,
+				     unsigned int virq, unsigned int nr_irqs,
+				     void *arg)
+{
+	int i, ret;
+	unsigned int type;
+	irq_hw_number_t hwirq;
+	struct irq_fwspec *fwspec = arg;
+	struct aplic_priv *priv = platform_msi_get_host_data(domain);
+
+	ret = aplic_irqdomain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	ret = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &aplic_chip, priv);
+
+	return 0;
+}
+
+static const struct irq_domain_ops aplic_irqdomain_msi_ops = {
+	.translate	= aplic_irqdomain_translate,
+	.alloc		= aplic_irqdomain_msi_alloc,
+	.free		= platform_msi_device_domain_free,
+};
+
+static int aplic_irqdomain_idc_alloc(struct irq_domain *domain,
+				     unsigned int virq, unsigned int nr_irqs,
+				     void *arg)
+{
+	int i, ret;
+	unsigned int type;
+	irq_hw_number_t hwirq;
+	struct irq_fwspec *fwspec = arg;
+	struct aplic_priv *priv = domain->host_data;
+
+	ret = aplic_irqdomain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &aplic_chip, priv, handle_simple_irq,
+				    NULL, NULL);
+		irq_set_affinity(virq + i, &priv->lmask);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops aplic_irqdomain_idc_ops = {
+	.translate	= aplic_irqdomain_translate,
+	.alloc		= aplic_irqdomain_idc_alloc,
+	.free		= irq_domain_free_irqs_top,
+};
+
+static void aplic_init_hw_irqs(struct aplic_priv *priv)
+{
+	int i;
+
+	/* Disable all interrupts */
+	for (i = 0; i <= priv->nr_irqs; i += 32)
+		writel(-1U, priv->regs + APLIC_CLRIE_BASE +
+			    (i / 32) * sizeof(u32));
+
+	/* Set interrupt type and default priority for all interrupts */
+	for (i = 1; i <= priv->nr_irqs; i++) {
+		writel(0, priv->regs + APLIC_SOURCECFG_BASE +
+			  (i - 1) * sizeof(u32));
+		writel(APLIC_DEFAULT_PRIORITY,
+		       priv->regs + APLIC_TARGET_BASE +
+		       (i - 1) * sizeof(u32));
+	}
+
+	/* Clear APLIC domaincfg */
+	writel(0, priv->regs + APLIC_DOMAINCFG);
+}
+
+static void aplic_init_hw_global(struct aplic_priv *priv)
+{
+	u32 val;
+#ifdef CONFIG_RISCV_M_MODE
+	u32 valH;
+
+	if (!priv->nr_idcs) {
+		val = priv->msicfg.base_ppn;
+		valH = (priv->msicfg.base_ppn >> 32) &
+			APLIC_xMSICFGADDRH_BAPPN_MASK;
+		valH |= (priv->msicfg.lhxw & APLIC_xMSICFGADDRH_LHXW_MASK)
+			<< APLIC_xMSICFGADDRH_LHXW_SHIFT;
+		valH |= (priv->msicfg.hhxw & APLIC_xMSICFGADDRH_HHXW_MASK)
+			<< APLIC_xMSICFGADDRH_HHXW_SHIFT;
+		valH |= (priv->msicfg.lhxs & APLIC_xMSICFGADDRH_LHXS_MASK)
+			<< APLIC_xMSICFGADDRH_LHXS_SHIFT;
+		valH |= (priv->msicfg.hhxs & APLIC_xMSICFGADDRH_HHXS_MASK)
+			<< APLIC_xMSICFGADDRH_HHXS_SHIFT;
+		writel(val, priv->regs + APLIC_xMSICFGADDR);
+		writel(valH, priv->regs + APLIC_xMSICFGADDRH);
+	}
+#endif
+
+	/* Setup APLIC domaincfg register */
+	val = readl(priv->regs + APLIC_DOMAINCFG);
+	val |= APLIC_DOMAINCFG_IE;
+	if (!priv->nr_idcs)
+		val |= APLIC_DOMAINCFG_DM;
+	writel(val, priv->regs + APLIC_DOMAINCFG);
+	if (readl(priv->regs + APLIC_DOMAINCFG) != val)
+		dev_warn(priv->dev,
+			 "unable to write 0x%x in domaincfg\n", val);
+}
+
+static void aplic_msi_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	unsigned int group_index, hart_index, guest_index, val;
+	struct device *dev = msi_desc_to_dev(desc);
+	struct aplic_priv *priv = dev_get_drvdata(dev);
+	struct irq_data *d = irq_get_irq_data(desc->irq);
+	struct aplic_msicfg *mc = &priv->msicfg;
+	phys_addr_t tppn, tbppn, msg_addr;
+	void __iomem *target;
+
+	/* Save the MSI address and data */
+	msg_addr = (((u64)msg->address_hi) << 32) | msg->address_lo;
+	WARN_ON(msg->data > APLIC_TARGET_EIID_MASK);
+
+	/* Compute target HART PPN */
+	tppn = msg_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
+
+	/* Compute target HART Base PPN */
+	tbppn = tppn;
+	tbppn &= ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	tbppn &= ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
+	tbppn &= ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
+	WARN_ON(tbppn != mc->base_ppn);
+
+	/* Compute target group and hart indexes */
+	group_index = (tppn >> APLIC_xMSICFGADDR_PPN_HHX_SHIFT(mc->hhxs)) &
+		     APLIC_xMSICFGADDR_PPN_HHX_MASK(mc->hhxw);
+	hart_index = (tppn >> APLIC_xMSICFGADDR_PPN_LHX_SHIFT(mc->lhxs)) &
+		     APLIC_xMSICFGADDR_PPN_LHX_MASK(mc->lhxw);
+	hart_index |= (group_index << mc->lhxw);
+	WARN_ON(hart_index > APLIC_TARGET_HART_IDX_MASK);
+
+	/* Compute target guest index */
+	guest_index = tppn & APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	WARN_ON(guest_index > APLIC_TARGET_GUEST_IDX_MASK);
+
+	/* Update IRQ TARGET register */
+	target = priv->regs + APLIC_TARGET_BASE;
+	target += (d->hwirq - 1) * sizeof(u32);
+	val = (hart_index & APLIC_TARGET_HART_IDX_MASK)
+				<< APLIC_TARGET_HART_IDX_SHIFT;
+	val |= (guest_index & APLIC_TARGET_GUEST_IDX_MASK)
+				<< APLIC_TARGET_GUEST_IDX_SHIFT;
+	val |= (msg->data & APLIC_TARGET_EIID_MASK);
+	writel(val, target);
+}
+
+static int aplic_setup_msi(struct aplic_priv *priv)
+{
+	struct device *dev = priv->dev;
+	struct aplic_msicfg *mc = &priv->msicfg;
+	const struct imsic_global_config *imsic_global;
+
+	/*
+	 * The APLIC outgoing MSI config registers assume target MSI
+	 * controller to be RISC-V AIA IMSIC controller.
+	 */
+	imsic_global = imsic_get_global_config();
+	if (!imsic_global) {
+		dev_err(dev, "IMSIC global config not found\n");
+		return -ENODEV;
+	}
+
+	/* Find number of guest index bits (LHXS) */
+	mc->lhxs = imsic_global->guest_index_bits;
+	if (APLIC_xMSICFGADDRH_LHXS_MASK < mc->lhxs) {
+		dev_err(dev, "IMSIC guest index bits big for APLIC LHXS\n");
+		return -EINVAL;
+	}
+
+	/* Find number of HART index bits (LHXW) */
+	mc->lhxw = imsic_global->hart_index_bits;
+	if (APLIC_xMSICFGADDRH_LHXW_MASK < mc->lhxw) {
+		dev_err(dev, "IMSIC hart index bits big for APLIC LHXW\n");
+		return -EINVAL;
+	}
+
+	/* Find number of group index bits (HHXW) */
+	mc->hhxw = imsic_global->group_index_bits;
+	if (APLIC_xMSICFGADDRH_HHXW_MASK < mc->hhxw) {
+		dev_err(dev, "IMSIC group index bits big for APLIC HHXW\n");
+		return -EINVAL;
+	}
+
+	/* Find first bit position of group index (HHXS) */
+	mc->hhxs = imsic_global->group_index_shift;
+	if (mc->hhxs < (2 * APLIC_xMSICFGADDR_PPN_SHIFT)) {
+		dev_err(dev, "IMSIC group index shift should be >= %d\n",
+			(2 * APLIC_xMSICFGADDR_PPN_SHIFT));
+		return -EINVAL;
+	}
+	mc->hhxs -= (2 * APLIC_xMSICFGADDR_PPN_SHIFT);
+	if (APLIC_xMSICFGADDRH_HHXS_MASK < mc->hhxs) {
+		dev_err(dev, "IMSIC group index shift big for APLIC HHXS\n");
+		return -EINVAL;
+	}
+
+	/* Compute PPN base */
+	mc->base_ppn = imsic_global->base_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
+	mc->base_ppn &= ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	mc->base_ppn &= ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
+	mc->base_ppn &= ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
+
+	/* Use all possible CPUs as lmask */
+	cpumask_copy(&priv->lmask, cpu_possible_mask);
+
+	return 0;
+}
+
+/*
+ * To handle an APLIC IDC interrupts, we just read the CLAIMI register
+ * which will return highest priority pending interrupt and clear the
+ * pending bit of the interrupt. This process is repeated until CLAIMI
+ * register return zero value.
+ */
+static void aplic_idc_handle_irq(struct irq_desc *desc)
+{
+	struct aplic_idc *idc = this_cpu_ptr(&aplic_idcs);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	irq_hw_number_t hw_irq;
+	int irq;
+
+	chained_irq_enter(chip, desc);
+
+	while ((hw_irq = readl(idc->regs + APLIC_IDC_CLAIMI))) {
+		hw_irq = hw_irq >> APLIC_IDC_TOPI_ID_SHIFT;
+		irq = irq_find_mapping(idc->priv->irqdomain, hw_irq);
+
+		if (unlikely(irq <= 0))
+			pr_warn_ratelimited("hw_irq %lu mapping not found\n",
+					    hw_irq);
+		else
+			generic_handle_irq(irq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aplic_idc_set_delivery(struct aplic_idc *idc, bool en)
+{
+	u32 de = (en) ? APLIC_ENABLE_IDELIVERY : APLIC_DISABLE_IDELIVERY;
+	u32 th = (en) ? APLIC_ENABLE_ITHRESHOLD : APLIC_DISABLE_ITHRESHOLD;
+
+	/* Priority must be less than threshold for interrupt triggering */
+	writel(th, idc->regs + APLIC_IDC_ITHRESHOLD);
+
+	/* Delivery must be set to 1 for interrupt triggering */
+	writel(de, idc->regs + APLIC_IDC_IDELIVERY);
+}
+
+static int aplic_idc_dying_cpu(unsigned int cpu)
+{
+	if (aplic_idc_parent_irq)
+		disable_percpu_irq(aplic_idc_parent_irq);
+
+	return 0;
+}
+
+static int aplic_idc_starting_cpu(unsigned int cpu)
+{
+	if (aplic_idc_parent_irq)
+		enable_percpu_irq(aplic_idc_parent_irq,
+				  irq_get_trigger_type(aplic_idc_parent_irq));
+
+	return 0;
+}
+
+static int aplic_setup_idc(struct aplic_priv *priv)
+{
+	int i, j, rc, cpu, setup_count = 0;
+	struct device_node *node = priv->dev->of_node;
+	struct device *dev = priv->dev;
+	struct of_phandle_args parent;
+	struct irq_domain *domain;
+	unsigned long hartid;
+	struct aplic_idc *idc;
+	u32 val;
+
+	/* Setup per-CPU IDC and target CPU mask */
+	for (i = 0; i < priv->nr_idcs; i++) {
+		if (of_irq_parse_one(node, i, &parent)) {
+			dev_err(dev, "failed to parse parent for IDC%d.\n",
+				i);
+			return -EIO;
+		}
+
+		/* Skip IDCs which do not connect to external interrupts */
+		if (parent.args[0] != RV_IRQ_EXT)
+			continue;
+
+		rc = riscv_of_parent_hartid(parent.np, &hartid);
+		if (rc) {
+			dev_err(dev, "failed to parse hart ID for IDC%d.\n",
+				i);
+			return rc;
+		}
+
+		cpu = riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			dev_warn(dev, "invalid cpuid for IDC%d\n", i);
+			continue;
+		}
+
+		cpumask_set_cpu(cpu, &priv->lmask);
+
+		idc = per_cpu_ptr(&aplic_idcs, cpu);
+		WARN_ON(idc->priv);
+
+		idc->hart_index = i;
+		idc->regs = priv->regs + APLIC_IDC_BASE + i * APLIC_IDC_SIZE;
+		idc->priv = priv;
+
+		aplic_idc_set_delivery(idc, true);
+
+		/*
+		 * Boot cpu might not have APLIC hart_index = 0 so check
+		 * and update target registers of all interrupts.
+		 */
+		if (cpu == smp_processor_id() && idc->hart_index) {
+			val = idc->hart_index & APLIC_TARGET_HART_IDX_MASK;
+			val <<= APLIC_TARGET_HART_IDX_SHIFT;
+			val |= APLIC_DEFAULT_PRIORITY;
+			for (j = 1; j <= priv->nr_irqs; j++)
+				writel(val, priv->regs + APLIC_TARGET_BASE +
+					    (j - 1) * sizeof(u32));
+		}
+
+		setup_count++;
+	}
+
+	/* Find parent domain and register chained handler */
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!aplic_idc_parent_irq && domain) {
+		aplic_idc_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
+		if (aplic_idc_parent_irq) {
+			irq_set_chained_handler(aplic_idc_parent_irq,
+						aplic_idc_handle_irq);
+
+			/*
+			 * Setup CPUHP notifier to enable IDC parent
+			 * interrupt on all CPUs
+			 */
+			cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+					  "irqchip/riscv/aplic:starting",
+					  aplic_idc_starting_cpu,
+					  aplic_idc_dying_cpu);
+		}
+	}
+
+	/* Fail if we were not able to setup IDC for any CPU */
+	return (setup_count) ? 0 : -ENODEV;
+}
+
+static int aplic_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct aplic_priv *priv;
+	struct resource *regs;
+	phys_addr_t pa;
+	int rc;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(dev, "cannot find registers resource\n");
+		return -ENOENT;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, priv);
+	priv->dev = dev;
+
+	priv->regs = devm_ioremap(dev, regs->start, resource_size(regs));
+	if (WARN_ON(!priv->regs)) {
+		dev_err(dev, "failed ioremap registers\n");
+		return -EIO;
+	}
+
+	of_property_read_u32(node, "riscv,num-sources", &priv->nr_irqs);
+	if (!priv->nr_irqs) {
+		dev_err(dev, "failed to get number of interrupt sources\n");
+		return -EINVAL;
+	}
+
+	/* Setup initial state APLIC interrupts */
+	aplic_init_hw_irqs(priv);
+
+	/* Setup IDCs or MSIs based on parent interrupts in DT node */
+	priv->nr_idcs = of_irq_count(node);
+	if (priv->nr_idcs)
+		rc = aplic_setup_idc(priv);
+	else
+		rc = aplic_setup_msi(priv);
+	if (rc)
+		return rc;
+
+	/* Setup global config and interrupt delivery */
+	aplic_init_hw_global(priv);
+
+	/* Create irq domain instance for the APLIC */
+	if (priv->nr_idcs)
+		priv->irqdomain = irq_domain_create_linear(
+						of_node_to_fwnode(node),
+						priv->nr_irqs + 1,
+						&aplic_irqdomain_idc_ops,
+						priv);
+	else
+		priv->irqdomain = platform_msi_create_device_domain(dev,
+						priv->nr_irqs + 1,
+						aplic_msi_write_msg,
+						&aplic_irqdomain_msi_ops,
+						priv);
+	if (!priv->irqdomain) {
+		dev_err(dev, "failed to add irq domain\n");
+		return -ENOMEM;
+	}
+
+	/* Advertise the interrupt controller */
+	if (priv->nr_idcs) {
+		dev_info(dev, "%d interrupts directly connected to %d CPUs\n",
+			 priv->nr_irqs, priv->nr_idcs);
+	} else {
+		pa = priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHIFT;
+		dev_info(dev, "%d interrupts forwared to MSI base %pa\n",
+			 priv->nr_irqs, &pa);
+	}
+
+	return 0;
+}
+
+static int aplic_remove(struct platform_device *pdev)
+{
+	struct aplic_priv *priv = platform_get_drvdata(pdev);
+
+	irq_domain_remove(priv->irqdomain);
+
+	return 0;
+}
+
+static const struct of_device_id aplic_match[] = {
+	{ .compatible = "riscv,aplic" },
+	{}
+};
+
+static struct platform_driver aplic_driver = {
+	.driver = {
+		.name		= "riscv-aplic",
+		.of_match_table	= aplic_match,
+	},
+	.probe = aplic_probe,
+	.remove = aplic_remove,
+};
+
+static int __init aplic_init(void)
+{
+	return platform_driver_register(&aplic_driver);
+}
+core_initcall(aplic_init);
diff --git a/include/linux/irqchip/riscv-aplic.h b/include/linux/irqchip/riscv-aplic.h
new file mode 100644
index 000000000000..88177eefd411
--- /dev/null
+++ b/include/linux/irqchip/riscv-aplic.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+#ifndef __LINUX_IRQCHIP_RISCV_APLIC_H
+#define __LINUX_IRQCHIP_RISCV_APLIC_H
+
+#include <linux/bitops.h>
+
+#define APLIC_MAX_IDC			BIT(14)
+#define APLIC_MAX_SOURCE		1024
+
+#define APLIC_DOMAINCFG			0x0000
+#define APLIC_DOMAINCFG_RDONLY		0x80000000
+#define APLIC_DOMAINCFG_IE		BIT(8)
+#define APLIC_DOMAINCFG_DM		BIT(2)
+#define APLIC_DOMAINCFG_BE		BIT(0)
+
+#define APLIC_SOURCECFG_BASE		0x0004
+#define APLIC_SOURCECFG_D		BIT(10)
+#define APLIC_SOURCECFG_CHILDIDX_MASK	0x000003ff
+#define APLIC_SOURCECFG_SM_MASK	0x00000007
+#define APLIC_SOURCECFG_SM_INACTIVE	0x0
+#define APLIC_SOURCECFG_SM_DETACH	0x1
+#define APLIC_SOURCECFG_SM_EDGE_RISE	0x4
+#define APLIC_SOURCECFG_SM_EDGE_FALL	0x5
+#define APLIC_SOURCECFG_SM_LEVEL_HIGH	0x6
+#define APLIC_SOURCECFG_SM_LEVEL_LOW	0x7
+
+#define APLIC_MMSICFGADDR		0x1bc0
+#define APLIC_MMSICFGADDRH		0x1bc4
+#define APLIC_SMSICFGADDR		0x1bc8
+#define APLIC_SMSICFGADDRH		0x1bcc
+
+#ifdef CONFIG_RISCV_M_MODE
+#define APLIC_xMSICFGADDR		APLIC_MMSICFGADDR
+#define APLIC_xMSICFGADDRH		APLIC_MMSICFGADDRH
+#else
+#define APLIC_xMSICFGADDR		APLIC_SMSICFGADDR
+#define APLIC_xMSICFGADDRH		APLIC_SMSICFGADDRH
+#endif
+
+#define APLIC_xMSICFGADDRH_L		BIT(31)
+#define APLIC_xMSICFGADDRH_HHXS_MASK	0x1f
+#define APLIC_xMSICFGADDRH_HHXS_SHIFT	24
+#define APLIC_xMSICFGADDRH_LHXS_MASK	0x7
+#define APLIC_xMSICFGADDRH_LHXS_SHIFT	20
+#define APLIC_xMSICFGADDRH_HHXW_MASK	0x7
+#define APLIC_xMSICFGADDRH_HHXW_SHIFT	16
+#define APLIC_xMSICFGADDRH_LHXW_MASK	0xf
+#define APLIC_xMSICFGADDRH_LHXW_SHIFT	12
+#define APLIC_xMSICFGADDRH_BAPPN_MASK	0xfff
+
+#define APLIC_xMSICFGADDR_PPN_SHIFT	12
+
+#define APLIC_xMSICFGADDR_PPN_HART(__lhxs) \
+	(BIT(__lhxs) - 1)
+
+#define APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) \
+	(BIT(__lhxw) - 1)
+#define APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs) \
+	((__lhxs))
+#define APLIC_xMSICFGADDR_PPN_LHX(__lhxw, __lhxs) \
+	(APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) << \
+	 APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs))
+
+#define APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) \
+	(BIT(__hhxw) - 1)
+#define APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs) \
+	((__hhxs) + APLIC_xMSICFGADDR_PPN_SHIFT)
+#define APLIC_xMSICFGADDR_PPN_HHX(__hhxw, __hhxs) \
+	(APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
+	 APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
+
+#define APLIC_SETIP_BASE		0x1c00
+#define APLIC_SETIPNUM			0x1cdc
+
+#define APLIC_CLRIP_BASE		0x1d00
+#define APLIC_CLRIPNUM			0x1ddc
+
+#define APLIC_SETIE_BASE		0x1e00
+#define APLIC_SETIENUM			0x1edc
+
+#define APLIC_CLRIE_BASE		0x1f00
+#define APLIC_CLRIENUM			0x1fdc
+
+#define APLIC_SETIPNUM_LE		0x2000
+#define APLIC_SETIPNUM_BE		0x2004
+
+#define APLIC_GENMSI			0x3000
+
+#define APLIC_TARGET_BASE		0x3004
+#define APLIC_TARGET_HART_IDX_SHIFT	18
+#define APLIC_TARGET_HART_IDX_MASK	0x3fff
+#define APLIC_TARGET_GUEST_IDX_SHIFT	12
+#define APLIC_TARGET_GUEST_IDX_MASK	0x3f
+#define APLIC_TARGET_IPRIO_MASK	0xff
+#define APLIC_TARGET_EIID_MASK	0x7ff
+
+#define APLIC_IDC_BASE			0x4000
+#define APLIC_IDC_SIZE			32
+
+#define APLIC_IDC_IDELIVERY		0x00
+
+#define APLIC_IDC_IFORCE		0x04
+
+#define APLIC_IDC_ITHRESHOLD		0x08
+
+#define APLIC_IDC_TOPI			0x18
+#define APLIC_IDC_TOPI_ID_SHIFT	16
+#define APLIC_IDC_TOPI_ID_MASK	0x3ff
+#define APLIC_IDC_TOPI_PRIO_MASK	0xff
+
+#define APLIC_IDC_CLAIMI		0x1c
+
+#endif
-- 
2.34.1

