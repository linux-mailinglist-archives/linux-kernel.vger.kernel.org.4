Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1168F6D94C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbjDFLL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbjDFLLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:11:53 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6496472A0;
        Thu,  6 Apr 2023 04:11:48 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 19EEF24E0B4;
        Thu,  6 Apr 2023 19:11:47 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 6 Apr
 2023 19:11:46 +0800
Received: from ubuntu.localdomain (183.27.97.179) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 6 Apr
 2023 19:11:45 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v1 2/3] pcie: starfive: add StarFive JH7110 PCIe driver.
Date:   Thu, 6 Apr 2023 19:11:41 +0800
Message-ID: <20230406111142.74410-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406111142.74410-1-minda.chen@starfivetech.com>
References: <20230406111142.74410-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.179]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe controller driver for StarFive JH7110
SoC platform. The PCIe controller is PCIe 2.0, single lane.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 MAINTAINERS                            |   6 +
 drivers/pci/controller/Kconfig         |   8 +
 drivers/pci/controller/Makefile        |   1 +
 drivers/pci/controller/pcie-starfive.c | 958 +++++++++++++++++++++++++
 4 files changed, 973 insertions(+)
 create mode 100644 drivers/pci/controller/pcie-starfive.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0610bbf921bb..52501bcfd1ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19977,6 +19977,12 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
 
+STARFIVE JH71X0 PCIE DRIVERS
+M:	Minda Chen <minda.chen@starfivetech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
+F:	drivers/pci/controller/pcie-starfive.c
+
 STARFIVE JH71X0 USB DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Minda Chen <minda.chen@starfivetech.com>
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 42654035654a..3b39080018a5 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -342,6 +342,14 @@ config PCIE_MT7621
 	help
 	  This selects a driver for the MediaTek MT7621 PCIe Controller.
 
+config PCIE_STARFIVE
+	tristate "StarFive JH7110 PCIe controller"
+	depends on PCI_MSI && OF
+	select PCI_MSI_IRQ_DOMAIN
+	help
+	  Say 'Y' here if you want kernel to support the StarFive JH7110
+	  PCIe Host driver.
+
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
 source "drivers/pci/controller/cadence/Kconfig"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 37c8663de7fe..23708222db8a 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
 obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
 obj-$(CONFIG_PCIE_APPLE) += pcie-apple.o
 obj-$(CONFIG_PCIE_MT7621) += pcie-mt7621.o
+obj-$(CONFIG_PCIE_STARFIVE) += pcie-starfive.o
 
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
diff --git a/drivers/pci/controller/pcie-starfive.c b/drivers/pci/controller/pcie-starfive.c
new file mode 100644
index 000000000000..e1dc8ecc769a
--- /dev/null
+++ b/drivers/pci/controller/pcie-starfive.c
@@ -0,0 +1,958 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCIe host controller driver for Starfive JH7110 Soc.
+ *
+ * Based on pcie-altera.c, pcie-altera-msi.c.
+ *
+ * Copyright (C) StarFive Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/pci-ecam.h>
+#include <linux/phy/phy.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include "../pci.h"
+
+#define IMASK_LOCAL			0x180
+#define ISTATUS_LOCAL			0x184
+#define IMSI_ADDR			0x190
+#define ISTATUS_MSI			0x194
+#define GEN_SETTINGS			0x80
+#define PCIE_PCI_IDS			0x9C
+#define PCIE_WINROM			0xFC
+#define PMSG_SUPPORT_RX			0x3F0
+
+#define PCI_MISC			0xB4
+
+#define RP_ENABLE			1
+
+#define IDS_CLASS_CODE_SHIFT		16
+
+#define DATA_LINK_ACTIVE		BIT(5)
+#define PREF_MEM_WIN_64_SUPPORT		BIT(3)
+#define PMSG_LTR_SUPPORT		BIT(2)
+#define LINK_SPEED_GEN2			BIT(12)
+#define PHY_FUNCTION_DIS		BIT(15)
+#define PCIE_FUNC_NUM			4
+#define PHY_FUNC_SHIFT			9
+
+#define XR3PCI_ATR_AXI4_SLV0		0x800
+#define XR3PCI_ATR_SRC_ADDR_LOW		0x0
+#define XR3PCI_ATR_SRC_ADDR_HIGH	0x4
+#define XR3PCI_ATR_TRSL_ADDR_LOW	0x8
+#define XR3PCI_ATR_TRSL_ADDR_HIGH	0xc
+#define XR3PCI_ATR_TRSL_PARAM		0x10
+#define XR3PCI_ATR_TABLE_OFFSET		0x20
+#define XR3PCI_ATR_MAX_TABLE_NUM	8
+
+#define XR3PCI_ATR_SRC_WIN_SIZE_SHIFT	1
+#define XR3PCI_ATR_SRC_ADDR_MASK	GENMASK(31, 12)
+#define XR3PCI_ATR_TRSL_ADDR_MASK	GENMASK(31, 12)
+#define XR3PCI_ECAM_SIZE		BIT(28)
+#define XR3PCI_ATR_TRSL_DIR		BIT(22)
+/* IDs used in the XR3PCI_ATR_TRSL_PARAM */
+#define XR3PCI_ATR_TRSLID_PCIE_MEMORY	0x0
+#define XR3PCI_ATR_TRSLID_PCIE_CONFIG	0x1
+
+#define INT_AXI_POST_ERROR		BIT(16)
+#define INT_AXI_FETCH_ERROR		BIT(17)
+#define INT_AXI_DISCARD_ERROR		BIT(18)
+#define INT_PCIE_POST_ERROR		BIT(20)
+#define INT_PCIE_FETCH_ERROR		BIT(21)
+#define INT_PCIE_DISCARD_ERROR		BIT(22)
+#define INT_ERRORS		(INT_AXI_POST_ERROR | INT_AXI_FETCH_ERROR | \
+				 INT_AXI_DISCARD_ERROR | INT_PCIE_POST_ERROR | \
+				 INT_PCIE_FETCH_ERROR | INT_PCIE_DISCARD_ERROR)
+
+#define INTA_OFFSET		24
+#define INTA			BIT(24)
+#define INTB			BIT(25)
+#define INTC			BIT(26)
+#define INTD			BIT(27)
+#define INT_MSI			BIT(28)
+#define INT_INTX_MASK		(INTA | INTB | INTC | INTD)
+#define INT_MASK		(INT_INTX_MASK | INT_MSI | INT_ERRORS)
+
+#define INT_PCI_MSI_NR		32
+
+/* system control */
+#define STG_SYSCON_K_RP_NEP			BIT(8)
+#define STG_SYSCON_AXI4_SLVL_ARFUNC_MASK	GENMASK(22, 8)
+#define STG_SYSCON_AXI4_SLVL_ARFUNC_SHIFT	8
+#define STG_SYSCON_AXI4_SLVL_AWFUNC_MASK	GENMASK(14, 0)
+#define STG_SYSCON_CLKREQ			BIT(22)
+#define STG_SYSCON_CKREF_SRC_SHIFT		18
+#define STG_SYSCON_CKREF_SRC_MASK		GENMASK(19, 18)
+
+/* MSI information */
+struct jh7110_pcie_msi {
+	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
+	struct irq_domain *msi_domain;
+	struct irq_domain *inner_domain;
+	/* Protect bitmap variable */
+	struct mutex lock;
+};
+
+struct starfive_jh7110_pcie {
+	struct platform_device	*pdev;
+	void __iomem		*reg_base;
+	void __iomem		*config_base;
+	phys_addr_t config_phyaddr;
+	struct regmap *reg_syscon;
+	struct phy *phy;
+	u32 stg_arfun;
+	u32 stg_awfun;
+	u32 stg_rp_nep;
+	u32 stg_lnksta;
+	int			irq;
+	struct irq_domain	*legacy_irq_domain;
+	struct pci_host_bridge  *bridge;
+	struct jh7110_pcie_msi	msi;
+	struct reset_control *resets;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	int atr_table_num;
+	struct gpio_desc *power_gpio;
+	struct gpio_desc *reset_gpio;
+};
+
+/*
+ * StarFive PCIe port uses BAR0-BAR1 of RC's configuration space as
+ * the translation from PCI bus to native BUS.  Entire DDR region
+ * is mapped into PCIe space using these registers, so it can be
+ * reached by DMA from EP devices.  The BAR0/1 of bridge should be
+ * hidden during enumeration to avoid the sizing and resource allocation
+ * by PCIe core.
+ */
+static bool starfive_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
+				  int offset)
+{
+	if (pci_is_root_bus(bus) && (devfn == 0)
+		&& ((offset == PCI_BASE_ADDRESS_0)
+		|| (offset == PCI_BASE_ADDRESS_1)))
+		return true;
+
+	return false;
+}
+
+void __iomem *starfive_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
+			   int where)
+{
+	struct starfive_jh7110_pcie *pcie = bus->sysdata;
+
+	return pcie->config_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
+}
+
+int starfive_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
+			   int where, int size, u32 value)
+{
+	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return pci_generic_config_write(bus, devfn, where, size, value);
+}
+
+static void starfive_pcie_handle_msi_irq(struct starfive_jh7110_pcie *pcie)
+{
+	struct jh7110_pcie_msi *msi = &pcie->msi;
+	u32 bit;
+	u32 virq;
+	unsigned long status = readl(pcie->reg_base + ISTATUS_MSI);
+
+	for_each_set_bit(bit, &status, INT_PCI_MSI_NR) {
+		/* Clear interrupts */
+		writel(1 << bit, pcie->reg_base + ISTATUS_MSI);
+		virq = irq_find_mapping(msi->inner_domain, bit);
+		if (virq) {
+			if (test_bit(bit, msi->used))
+				generic_handle_irq(virq);
+			else
+				dev_err(&pcie->pdev->dev,
+					"Unhandled MSI, MSI%d virq %d\n", bit,
+					virq);
+		} else
+			dev_err(&pcie->pdev->dev, "Unexpected MSI, MSI%d\n",
+				bit);
+	}
+	writel(INT_MSI, pcie->reg_base + ISTATUS_LOCAL);
+}
+
+static void starfive_pcie_handle_intx_irq(struct starfive_jh7110_pcie *pcie,
+				      unsigned long status)
+{
+	u32 bit;
+	u32 virq;
+
+	status >>= INTA_OFFSET;
+
+	for_each_set_bit(bit, &status, PCI_NUM_INTX) {
+		/* Clear interrupts */
+		writel(1 << (bit + INTA_OFFSET), pcie->reg_base + ISTATUS_LOCAL);
+
+		virq = irq_find_mapping(pcie->legacy_irq_domain, bit);
+		if (virq)
+			generic_handle_irq(virq);
+		else
+			dev_err(&pcie->pdev->dev,
+				"unexpected IRQ, INT%d\n", bit);
+	}
+}
+
+static void starfive_pcie_handle_errors_irq(struct starfive_jh7110_pcie *pcie, u32 status)
+{
+	if (status & INT_AXI_POST_ERROR)
+		dev_err(&pcie->pdev->dev, "AXI post error\n");
+	if (status & INT_AXI_FETCH_ERROR)
+		dev_err(&pcie->pdev->dev, "AXI fetch error\n");
+	if (status & INT_AXI_DISCARD_ERROR)
+		dev_err(&pcie->pdev->dev, "AXI discard error\n");
+	if (status & INT_PCIE_POST_ERROR)
+		dev_err(&pcie->pdev->dev, "PCIe post error\n");
+	if (status & INT_PCIE_FETCH_ERROR)
+		dev_err(&pcie->pdev->dev, "PCIe fetch error\n");
+	if (status & INT_PCIE_DISCARD_ERROR)
+		dev_err(&pcie->pdev->dev, "PCIe discard error\n");
+
+	writel(INT_ERRORS, pcie->reg_base + ISTATUS_LOCAL);
+}
+
+static void starfive_pcie_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct starfive_jh7110_pcie *pcie;
+	u32 status;
+
+	chained_irq_enter(chip, desc);
+	pcie = irq_desc_get_handler_data(desc);
+
+	status = readl(pcie->reg_base + ISTATUS_LOCAL);
+	while ((status = (readl(pcie->reg_base + ISTATUS_LOCAL) & INT_MASK))) {
+		if (status & INT_INTX_MASK)
+			starfive_pcie_handle_intx_irq(pcie, status);
+
+		if (status & INT_MSI)
+			starfive_pcie_handle_msi_irq(pcie);
+
+		if (status & INT_ERRORS)
+			starfive_pcie_handle_errors_irq(pcie, status);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+#ifdef CONFIG_PCI_MSI
+static struct irq_chip starfive_pcie_msi_irq_chip = {
+	.name = "StarFive PCIe MSI",
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static struct msi_domain_info starfive_pcie_msi_domain_info = {
+	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_PCI_MSIX),
+	.chip = &starfive_pcie_msi_irq_chip,
+};
+#endif
+
+static void starfive_pcie_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct starfive_jh7110_pcie *pcie = irq_data_get_irq_chip_data(data);
+	phys_addr_t msi_addr = readl(pcie->reg_base + IMSI_ADDR);
+
+	msg->address_lo = lower_32_bits(msi_addr);
+	msg->address_hi = upper_32_bits(msi_addr);
+	msg->data = data->hwirq;
+
+	dev_info(&pcie->pdev->dev, "msi#%d address_hi %#x address_lo %#x\n",
+		(int)data->hwirq, msg->address_hi, msg->address_lo);
+}
+
+static int starfive_pcie_msi_set_affinity(struct irq_data *irq_data,
+				 const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip starfive_irq_chip = {
+	.name = "StarFive MSI",
+	.irq_compose_msi_msg = starfive_pcie_compose_msi_msg,
+	.irq_set_affinity = starfive_pcie_msi_set_affinity,
+};
+
+static int starfive_pcie_msi_alloc(struct irq_domain *domain, unsigned int virq,
+			  unsigned int nr_irqs, void *args)
+{
+	struct starfive_jh7110_pcie *pcie = domain->host_data;
+	struct jh7110_pcie_msi *msi = &pcie->msi;
+	int bit;
+
+	WARN_ON(nr_irqs != 1);
+	mutex_lock(&msi->lock);
+
+	bit = find_first_zero_bit(msi->used, INT_PCI_MSI_NR);
+	if (bit >= INT_PCI_MSI_NR) {
+		mutex_unlock(&msi->lock);
+		return -ENOSPC;
+	}
+
+	set_bit(bit, msi->used);
+
+	irq_domain_set_info(domain, virq, bit, &starfive_irq_chip,
+			    domain->host_data, handle_simple_irq,
+			    NULL, NULL);
+	mutex_unlock(&msi->lock);
+
+	return 0;
+}
+
+static void starfive_pcie_msi_free(struct irq_domain *domain, unsigned int virq,
+			  unsigned int nr_irqs)
+{
+	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
+	struct starfive_jh7110_pcie *pcie = irq_data_get_irq_chip_data(data);
+	struct jh7110_pcie_msi *msi = &pcie->msi;
+
+	mutex_lock(&msi->lock);
+
+	if (!test_bit(data->hwirq, msi->used))
+		dev_err(&pcie->pdev->dev, "Trying to free unused MSI#%lu\n",
+			data->hwirq);
+	else
+		__clear_bit(data->hwirq, msi->used);
+
+	writel(0xffffffff, pcie->reg_base + ISTATUS_MSI);
+	mutex_unlock(&msi->lock);
+}
+
+static const struct irq_domain_ops dev_msi_domain_ops = {
+	.alloc  = starfive_pcie_msi_alloc,
+	.free   = starfive_pcie_msi_free,
+};
+
+static void starfive_pcie_msi_free_irq_domain(struct starfive_jh7110_pcie *pcie)
+{
+#ifdef CONFIG_PCI_MSI
+	struct jh7110_pcie_msi *msi = &pcie->msi;
+	u32 irq;
+	int i;
+
+	for (i = 0; i < INT_PCI_MSI_NR; i++) {
+		irq = irq_find_mapping(msi->inner_domain, i);
+		if (irq > 0)
+			irq_dispose_mapping(irq);
+	}
+
+	if (msi->msi_domain)
+		irq_domain_remove(msi->msi_domain);
+
+	if (msi->inner_domain)
+		irq_domain_remove(msi->inner_domain);
+#endif
+}
+
+static void starfive_pcie_free_irq_domain(struct starfive_jh7110_pcie *pcie)
+{
+	int i;
+	u32 irq;
+
+	/* Disable all interrupts */
+	writel(0, pcie->reg_base + IMASK_LOCAL);
+
+	if (pcie->legacy_irq_domain) {
+		for (i = 0; i < PCI_NUM_INTX; i++) {
+			irq = irq_find_mapping(pcie->legacy_irq_domain, i);
+			if (irq > 0)
+				irq_dispose_mapping(irq);
+		}
+		irq_domain_remove(pcie->legacy_irq_domain);
+	}
+
+	if (pci_msi_enabled())
+		starfive_pcie_msi_free_irq_domain(pcie);
+	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+}
+
+static int starfive_pcie_init_msi_irq_domain(struct starfive_jh7110_pcie *pcie)
+{
+#ifdef CONFIG_PCI_MSI
+	struct fwnode_handle *fwn = of_node_to_fwnode(pcie->pdev->dev.of_node);
+	struct jh7110_pcie_msi *msi = &pcie->msi;
+
+	msi->inner_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
+						  &dev_msi_domain_ops, pcie);
+	if (!msi->inner_domain) {
+		dev_err(&pcie->pdev->dev, "Failed to create dev IRQ domain\n");
+		return -ENOMEM;
+	}
+	msi->msi_domain = pci_msi_create_irq_domain(fwn, &starfive_pcie_msi_domain_info,
+						    msi->inner_domain);
+	if (!msi->msi_domain) {
+		dev_err(&pcie->pdev->dev, "Failed to create msi IRQ domain\n");
+		irq_domain_remove(msi->inner_domain);
+		return -ENOMEM;
+	}
+#endif
+	return 0;
+}
+
+static int starfive_pcie_enable_msi(struct starfive_jh7110_pcie *pcie, struct pci_bus *bus)
+{
+	struct jh7110_pcie_msi *msi = &pcie->msi;
+	u32 reg;
+
+	mutex_init(&msi->lock);
+
+	/* Enable MSI */
+	reg = readl(pcie->reg_base + IMASK_LOCAL);
+	reg |= INT_MSI;
+	writel(reg, pcie->reg_base + IMASK_LOCAL);
+	return 0;
+}
+
+static int starfive_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = starfive_pcie_intx_map,
+	.xlate = pci_irqd_intx_xlate,
+};
+
+static int starfive_pcie_init_irq_domain(struct starfive_jh7110_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	struct device_node *node = dev->of_node;
+	int ret;
+
+	if (pci_msi_enabled()) {
+		ret = starfive_pcie_init_msi_irq_domain(pcie);
+		if (ret != 0)
+			return -ENOMEM;
+	}
+
+	/* Setup INTx */
+	pcie->legacy_irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
+					&intx_domain_ops, pcie);
+
+	if (!pcie->legacy_irq_domain) {
+		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler_and_data(pcie->irq, starfive_pcie_isr, pcie);
+
+	return 0;
+}
+
+static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie)
+{
+	struct resource *cfg_res;
+	struct platform_device *pdev = pcie->pdev;
+	unsigned int args[4];
+
+	pcie->reg_base =
+		devm_platform_ioremap_resource_byname(pdev, "reg");
+
+	if (IS_ERR(pcie->reg_base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pcie->reg_base),
+			"Failed to map reg memory\n");
+
+	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
+	if (!cfg_res)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+			"Failed to get config memory\n");
+
+	pcie->config_base = devm_ioremap_resource(&pdev->dev, cfg_res);
+	if (IS_ERR(pcie->config_base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pcie->config_base),
+			"Failed to map config memory\n");
+
+	pcie->config_phyaddr = cfg_res->start;
+
+	pcie->phy = devm_phy_optional_get(&pdev->dev, NULL);
+	if (IS_ERR(pcie->phy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pcie->phy),
+			"Failed to get pcie phy\n");
+
+	pcie->irq = platform_get_irq(pdev, 0);
+	if (pcie->irq < 0)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+			"Failed to get IRQ: %d\n", pcie->irq);
+
+	pcie->reg_syscon = syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
+		"starfive,stg-syscon", 4, args);
+
+	if (IS_ERR(pcie->reg_syscon))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pcie->reg_syscon),
+			"Failed to parse starfive,stg-syscon\n");
+
+	pcie->stg_arfun = args[0];
+	pcie->stg_awfun = args[1];
+	pcie->stg_rp_nep = args[2];
+	pcie->stg_lnksta = args[3];
+
+	/* Clear all interrupts */
+	writel(0xffffffff, pcie->reg_base + ISTATUS_LOCAL);
+	writel(INT_INTX_MASK | INT_ERRORS, pcie->reg_base + IMASK_LOCAL);
+
+	return 0;
+}
+
+static struct pci_ops starfive_pcie_ops = {
+	.map_bus	= starfive_pcie_map_bus,
+	.read           = pci_generic_config_read,
+	.write          = starfive_pcie_config_write,
+};
+
+static void starfive_pcie_set_atr_entry(struct starfive_jh7110_pcie *pcie,
+			phys_addr_t src_addr, phys_addr_t trsl_addr,
+			size_t window_size, int trsl_param)
+{
+	void __iomem *base =
+		pcie->reg_base + XR3PCI_ATR_AXI4_SLV0;
+
+	/* Support AXI4 Slave 0 Address Translation Tables 0-7. */
+	if (pcie->atr_table_num >= XR3PCI_ATR_MAX_TABLE_NUM)
+		pcie->atr_table_num = XR3PCI_ATR_MAX_TABLE_NUM - 1;
+	base +=  XR3PCI_ATR_TABLE_OFFSET * pcie->atr_table_num;
+	pcie->atr_table_num++;
+
+	/*
+	 * X3PCI_ATR_SRC_ADDR_LOW:
+	 *   - bit 0: enable entry,
+	 *   - bits 1-6: ATR window size: total size in bytes: 2^(ATR_WSIZE + 1)
+	 *   - bits 7-11: reserved
+	 *   - bits 12-31: start of source address
+	 */
+	writel((lower_32_bits(src_addr) & XR3PCI_ATR_SRC_ADDR_MASK) |
+			(fls(window_size) - 1) << XR3PCI_ATR_SRC_WIN_SIZE_SHIFT | 1,
+			base + XR3PCI_ATR_SRC_ADDR_LOW);
+	writel(upper_32_bits(src_addr), base + XR3PCI_ATR_SRC_ADDR_HIGH);
+	writel((lower_32_bits(trsl_addr) & XR3PCI_ATR_TRSL_ADDR_MASK),
+			base + XR3PCI_ATR_TRSL_ADDR_LOW);
+	writel(upper_32_bits(trsl_addr), base + XR3PCI_ATR_TRSL_ADDR_HIGH);
+	writel(trsl_param, base + XR3PCI_ATR_TRSL_PARAM);
+
+	dev_info(&pcie->pdev->dev, "ATR entry: 0x%010llx %s 0x%010llx [0x%010llx] (param: 0x%06x)\n",
+	       src_addr, (trsl_param & XR3PCI_ATR_TRSL_DIR) ? "<-" : "->",
+	       trsl_addr, (u64)window_size, trsl_param);
+}
+
+static int starfive_pcie_setup_windows(struct starfive_jh7110_pcie *pcie)
+{
+	struct pci_host_bridge *bridge = pcie->bridge;
+	struct resource_entry *entry;
+	u64 pci_addr;
+
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		if (resource_type(entry->res) == IORESOURCE_MEM) {
+			pci_addr = entry->res->start - entry->offset;
+			starfive_pcie_set_atr_entry(pcie,
+						entry->res->start, pci_addr,
+						resource_size(entry->res),
+						XR3PCI_ATR_TRSLID_PCIE_MEMORY);
+		}
+	}
+
+	return 0;
+}
+
+static int starfive_pcie_clk_rst_init(struct starfive_jh7110_pcie *pcie)
+{
+	int ret;
+	struct device *dev = &pcie->pdev->dev;
+
+	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
+	if (pcie->num_clks < 0)
+		return dev_err_probe(dev, -ENODEV,
+			"Failed to get pcie clocks\n");
+
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
+	if (ret)
+		return dev_err_probe(&pcie->pdev->dev, ret,
+			"Failed to enable clocks\n");
+
+	pcie->resets = devm_reset_control_array_get_exclusive(dev);
+	if (IS_ERR(pcie->resets)) {
+		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+		return dev_err_probe(dev, PTR_ERR(pcie->resets),
+			"Failed to get pcie resets");
+	}
+
+	return reset_control_deassert(pcie->resets);
+}
+
+static void starfive_pcie_clk_rst_deinit(struct starfive_jh7110_pcie *pcie)
+{
+	reset_control_assert(pcie->resets);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+}
+
+int starfive_pcie_gpio_init(struct starfive_jh7110_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+
+	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR_OR_NULL(pcie->reset_gpio)) {
+		dev_warn(dev, "Failed to get reset-gpio.\n");
+		return -EINVAL;
+	}
+
+	pcie->power_gpio = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
+	if (IS_ERR_OR_NULL(pcie->power_gpio))
+		pcie->power_gpio = NULL;
+
+	return 0;
+}
+
+static void starfive_pcie_hw_init(struct starfive_jh7110_pcie *pcie)
+{
+	unsigned int value;
+	int i;
+
+	if (pcie->power_gpio)
+		gpiod_set_value_cansleep(pcie->power_gpio, 1);
+
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
+	/* Disable physical functions except #0 */
+	for (i = 1; i < PCIE_FUNC_NUM; i++) {
+		regmap_update_bits(pcie->reg_syscon,
+				pcie->stg_arfun,
+				STG_SYSCON_AXI4_SLVL_ARFUNC_MASK,
+				(i << PHY_FUNC_SHIFT) <<
+				STG_SYSCON_AXI4_SLVL_ARFUNC_SHIFT);
+		regmap_update_bits(pcie->reg_syscon,
+				pcie->stg_awfun,
+				STG_SYSCON_AXI4_SLVL_AWFUNC_MASK,
+				i << PHY_FUNC_SHIFT);
+
+		value = readl(pcie->reg_base + PCI_MISC);
+		value |= PHY_FUNCTION_DIS;
+		writel(value, pcie->reg_base + PCI_MISC);
+	}
+
+
+	regmap_update_bits(pcie->reg_syscon,
+				pcie->stg_arfun,
+				STG_SYSCON_AXI4_SLVL_ARFUNC_MASK,
+				0);
+	regmap_update_bits(pcie->reg_syscon,
+				pcie->stg_awfun,
+				STG_SYSCON_AXI4_SLVL_AWFUNC_MASK,
+				0);
+
+	/* Enable root port */
+	value = readl(pcie->reg_base + GEN_SETTINGS);
+	value |= RP_ENABLE;
+	writel(value, pcie->reg_base + GEN_SETTINGS);
+
+	/* PCIe PCI Standard Configuration Identification Settings. */
+	value = (PCI_CLASS_BRIDGE_PCI << IDS_CLASS_CODE_SHIFT);
+	writel(value, pcie->reg_base + PCIE_PCI_IDS);
+
+	/*
+	 * The LTR message forwarding of PCIe Message Reception was set by core
+	 * as default, but the forward id & addr are also need to be reset.
+	 * If we do not disable LTR message forwarding here, or set a legal
+	 * forwarding address, the kernel will get stuck after this driver probe.
+	 * To workaround, disable the LTR message forwarding support on
+	 * PCIe Message Reception.
+	 */
+	value = readl(pcie->reg_base + PMSG_SUPPORT_RX);
+	value &= ~PMSG_LTR_SUPPORT;
+	writel(value, pcie->reg_base + PMSG_SUPPORT_RX);
+
+	/* Prefetchable memory window 64-bit addressing support */
+	value = readl(pcie->reg_base + PCIE_WINROM);
+	value |= PREF_MEM_WIN_64_SUPPORT;
+	writel(value, pcie->reg_base + PCIE_WINROM);
+
+	/*
+	 * As the two host bridges in JH7110 soc have the same default
+	 * address translation table, this cause the second root port can't
+	 * access it's host bridge config space correctly.
+	 * To workaround, config the ATR of host bridge config space by SW.
+	 */
+	starfive_pcie_set_atr_entry(pcie,
+			pcie->config_phyaddr, 0,
+			XR3PCI_ECAM_SIZE,
+			XR3PCI_ATR_TRSLID_PCIE_CONFIG);
+
+	starfive_pcie_setup_windows(pcie);
+
+	/* Ensure that PERST has been asserted for at least 100 ms */
+	msleep(300);
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+}
+
+static bool starfive_pcie_is_link_up(struct starfive_jh7110_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	int ret;
+	u32 stg_reg_val;
+
+	/* 100ms timeout value should be enough for Gen1/2 training */
+	ret = regmap_read_poll_timeout(pcie->reg_syscon,
+					pcie->stg_lnksta,
+					stg_reg_val,
+					stg_reg_val & DATA_LINK_ACTIVE,
+					10 * 1000, 100 * 1000);
+
+	/* If the link is down (no device in slot), then exit. */
+	if (ret == -ETIMEDOUT) {
+		dev_info(dev, "Port link down, exit.\n");
+		return false;
+	} else if (ret == 0) {
+		dev_info(dev, "Port link up.\n");
+		return true;
+	}
+
+	dev_warn(dev, "Read stg_linksta failed.\n");
+
+	return false;
+}
+
+static int starfive_pcie_enable_phy(struct device *dev,
+		struct starfive_jh7110_pcie *pcie)
+{
+	int ret;
+
+	if (!pcie->phy)
+		return 0;
+
+	ret = phy_init(pcie->phy);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"failed to initialize pcie phy\n");
+
+	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
+	if (ret) {
+		ret = dev_err_probe(dev, ret,
+			"failed to set pcie mode\n");
+		goto err_phy_on;
+	}
+
+	ret = phy_power_on(pcie->phy);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "failed to power on pcie phy\n");
+		goto err_phy_on;
+	}
+
+	return 0;
+
+err_phy_on:
+	phy_exit(pcie->phy);
+	return ret;
+}
+
+static void starfive_pcie_disable_phy(struct starfive_jh7110_pcie *pcie)
+{
+	phy_power_off(pcie->phy);
+	phy_exit(pcie->phy);
+}
+
+static int starfive_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct starfive_jh7110_pcie *pcie;
+	struct pci_bus *bus;
+	struct pci_host_bridge *bridge;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->pdev = pdev;
+	pcie->atr_table_num = 0;
+
+	ret = starfive_pcie_parse_dt(pcie);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, pcie);
+
+	ret = starfive_pcie_gpio_init(pcie);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(pcie->reg_syscon,
+				pcie->stg_rp_nep,
+				STG_SYSCON_K_RP_NEP,
+				STG_SYSCON_K_RP_NEP);
+
+	regmap_update_bits(pcie->reg_syscon,
+				pcie->stg_awfun,
+				STG_SYSCON_CKREF_SRC_MASK,
+				2 << STG_SYSCON_CKREF_SRC_SHIFT);
+
+	regmap_update_bits(pcie->reg_syscon,
+				pcie->stg_awfun,
+				STG_SYSCON_CLKREQ,
+				STG_SYSCON_CLKREQ);
+
+	ret = starfive_pcie_clk_rst_init(pcie);
+	if (ret)
+		return ret;
+
+	ret = starfive_pcie_init_irq_domain(pcie);
+	if (ret)
+		return ret;
+
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
+	if (!bridge)
+		return -ENOMEM;
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
+	/* Set default bus ops */
+	bridge->ops = &starfive_pcie_ops;
+	bridge->sysdata = pcie;
+	pcie->bridge = bridge;
+
+	starfive_pcie_hw_init(pcie);
+
+	if (starfive_pcie_is_link_up(pcie) == false)
+		goto release;
+
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		ret = starfive_pcie_enable_msi(pcie, bus);
+		if (ret < 0) {
+			dev_err(dev, "Failed to enable MSI support: %d\n", ret);
+			goto release;
+		}
+	}
+
+	ret = starfive_pcie_enable_phy(dev, pcie);
+	if (ret)
+		goto release;
+
+	ret = pci_host_probe(bridge);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "Failed to pci host probe: %d\n", ret);
+		goto err_phy_on;
+	}
+
+	return ret;
+
+err_phy_on:
+	starfive_pcie_disable_phy(pcie);
+release:
+	if (pcie->power_gpio)
+		gpiod_set_value_cansleep(pcie->power_gpio, 0);
+
+	starfive_pcie_clk_rst_deinit(pcie);
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	pci_free_host_bridge(pcie->bridge);
+	platform_set_drvdata(pdev, NULL);
+
+	return ret;
+}
+
+static int starfive_pcie_remove(struct platform_device *pdev)
+{
+	struct starfive_jh7110_pcie *pcie = platform_get_drvdata(pdev);
+
+	starfive_pcie_disable_phy(pcie);
+	if (pcie->power_gpio)
+		gpiod_set_value_cansleep(pcie->power_gpio, 0);
+	starfive_pcie_free_irq_domain(pcie);
+	starfive_pcie_clk_rst_deinit(pcie);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int __maybe_unused starfive_pcie_suspend_noirq(struct device *dev)
+{
+	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
+
+	if (!pcie)
+		return 0;
+
+	starfive_pcie_disable_phy(pcie);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+
+	return 0;
+}
+
+static int __maybe_unused starfive_pcie_resume_noirq(struct device *dev)
+{
+	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	if (!pcie)
+		return 0;
+
+	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"Failed to enable clocks\n");
+
+	ret = starfive_pcie_enable_phy(dev, pcie);
+	if (ret)
+		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
+
+	return ret;
+}
+
+static const struct dev_pm_ops starfive_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(starfive_pcie_suspend_noirq,
+				      starfive_pcie_resume_noirq)
+};
+#endif
+
+static const struct of_device_id starfive_pcie_of_match[] = {
+	{ .compatible = "starfive,jh7110-pcie"},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, starfive_pcie_of_match);
+
+static struct platform_driver starfive_pcie_driver = {
+	.driver = {
+		.name = "pcie-starfive",
+		.of_match_table = of_match_ptr(starfive_pcie_of_match),
+#ifdef CONFIG_PM_SLEEP
+		.pm = &starfive_pcie_pm_ops,
+#endif
+	},
+	.probe = starfive_pcie_probe,
+	.remove = starfive_pcie_remove,
+};
+module_platform_driver(starfive_pcie_driver);
+
+MODULE_DESCRIPTION("StarFive JH7110 PCIe host driver");
+MODULE_AUTHOR("Mason Huo <mason.huo@starfivetech.com>");
+MODULE_AUTHOR("Kevin Xie <kevin.xie@starfivetech.com>");
+MODULE_AUTHOR("Minda Chen <minda.chen@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

