Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB8A63268D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiKUOm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiKUOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:40:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D75C80FA;
        Mon, 21 Nov 2022 06:38:29 -0800 (PST)
Message-ID: <20221121091328.288703733@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sW8r56oF49A4i8rN512SjZ6u9WBK7UD+PEe8Hh+LXW0=;
        b=SdPw+Wl+kDHuGGrZ0q/4ybOoO9Hlw7u8mXXfPPS8QTL3b/KW6LnGHkmTWYSsU3vXn7HrsI
        OhYCSWbbfER3hKvTAf7X+s9eOpGdM9YAOE2Ln+sP1sju/aRSxZsMDKwgPscKLFdQpJm7a7
        593nzWy45MdJve5g4/b5OjY/WSz+ERlKIolytlaSlEmA3s70C5maNqP+JH+XONz2OCVyyL
        jOa2RjOrW87y/ew1q1BFVM1lFSLLHLtvUuph2LnxPZhA7yvlR3uBCz6MJkozcBv7qPkKsZ
        5Mv6E7rpiHjMPpdsEmBOSpxEGNcdB4uClVLKCS/KiBn3KVg5U+AdcRkWADolfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sW8r56oF49A4i8rN512SjZ6u9WBK7UD+PEe8Hh+LXW0=;
        b=TiuEbxSxnValWkGhp2Z7cDVYyIkNBjyh5r0Mlk08rDRHWt0bi6ZfA4Qpy46f8Rn3KHEPnY
        xTGuVK7oKkCTZwBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V2 33/33] irqchip: Add IDXD Interrupt Message Store driver
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:27 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a driver for the Intel IDXD IMS implementation. The implementation
uses a large message store array in device memory.

The IMS domain implementation is minimal and just provides the required
irq_chip callbacks and one domain callback which prepares the MSI
descriptor for easy usage in the irq_chip callbacks.

The necessary iobase is stored in the irqdomain and the PASID which is
required for operation is handed in via msi_instance_cookie in the
allocation function.

Not much to see here. A few lines of code and a filled in template is all
what's needed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/Kconfig                    |    7 +
 drivers/irqchip/Makefile                   |    1 
 drivers/irqchip/irq-pci-intel-idxd.c       |  143 +++++++++++++++++++++++++++++
 include/linux/irqchip/irq-pci-intel-idxd.h |   22 ++++
 4 files changed, 173 insertions(+)

--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -695,4 +695,11 @@ config SUNPLUS_SP7021_INTC
 	  chained controller, routing all interrupt source in P-Chip to
 	  the primary controller on C-Chip.
 
+config PCI_INTEL_IDXD_IMS
+	tristate "Intel IDXD Interrupt Message Store controller"
+	depends on PCI_MSI
+	help
+	  Support for Intel IDXD IMS Interrupt Message Store controller
+	  with IMS slot storage in a slot array in device memory
+
 endmenu
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -121,3 +121,4 @@ obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt32
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
+obj-$(CONFIG_PCI_INTEL_IDXD_IMS)	+= irq-pci-intel-idxd.o
--- /dev/null
+++ b/drivers/irqchip/irq-pci-intel-idxd.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interrupt chip and domain for Intel IDXD with hardware array based
+ * interrupt message store (IMS).
+ */
+#include <linux/device.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+
+#include <linux/irqchip/irq-pci-intel-idxd.h>
+
+MODULE_LICENSE("GPL");
+
+/**
+ * struct ims_slot - The hardware layout of a slot in the memory table
+ * @address_lo:	Lower 32bit address
+ * @address_hi:	Upper 32bit address
+ * @data:	Message data
+ * @ctrl:	Control word
+ */
+struct ims_slot {
+	u32	address_lo;
+	u32	address_hi;
+	u32	data;
+	u32	ctrl;
+} __packed;
+
+/* Bit to mask the interrupt in the control word */
+#define CTRL_VECTOR_MASKBIT	BIT(0)
+/* Bit to enable PASID in the control word */
+#define CTRL_PASID_ENABLE	BIT(3)
+/* Position of PASID.LSB in the control word */
+#define CTRL_PASID_SHIFT	12
+
+static inline void iowrite32_and_flush(u32 value, void __iomem *addr)
+{
+	iowrite32(value, addr);
+	ioread32(addr);
+}
+
+static void idxd_mask(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct ims_slot __iomem *slot = desc->data.dcookie.iobase;
+	u32 cval = (u32)desc->data.icookie.value;
+
+	iowrite32_and_flush(cval | CTRL_VECTOR_MASKBIT, &slot->ctrl);
+}
+
+static void idxd_unmask(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct ims_slot __iomem *slot = desc->data.dcookie.iobase;
+	u32 cval = (u32)desc->data.icookie.value;
+
+	iowrite32_and_flush(cval, &slot->ctrl);
+}
+
+static void idxd_write_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct ims_slot __iomem *slot = desc->data.dcookie.iobase;
+
+	iowrite32(msg->address_lo, &slot->address_lo);
+	iowrite32(msg->address_hi, &slot->address_hi);
+	iowrite32_and_flush(msg->data, &slot->data);
+}
+
+static void idxd_shutdown(struct irq_data *data)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+	struct ims_slot __iomem *slot = desc->data.dcookie.iobase;
+
+	iowrite32(0, &slot->address_lo);
+	iowrite32(0, &slot->address_hi);
+	iowrite32(0, &slot->data);
+	iowrite32_and_flush(CTRL_VECTOR_MASKBIT, &slot->ctrl);
+}
+
+static void idxd_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
+			      struct msi_desc *desc)
+{
+	struct msi_domain_info *info = domain->host_data;
+	struct ims_slot __iomem *slot;
+
+	/* Set up the slot address for the irq_chip callbacks */
+	slot = (__force struct ims_slot __iomem *) info->data;
+	slot += desc->msi_index;
+	desc->data.dcookie.iobase = slot;
+
+	/* Mask the interrupt for paranoia sake */
+	iowrite32_and_flush(CTRL_VECTOR_MASKBIT, &slot->ctrl);
+
+	/*
+	 * The caller provided PASID. Shift it to the proper position
+	 * and set the PASID enable bit.
+	 */
+	desc->data.icookie.value <<= CTRL_PASID_SHIFT;
+	desc->data.icookie.value |= CTRL_PASID_ENABLE;
+
+	arg->hwirq = desc->msi_index;
+}
+
+static const struct msi_domain_template idxd_ims_template = {
+	.chip = {
+		.name			= "PCI-IDXD",
+		.irq_mask		= idxd_mask,
+		.irq_unmask		= idxd_unmask,
+		.irq_write_msi_msg	= idxd_write_msi_msg,
+		.irq_shutdown		= idxd_shutdown,
+		.flags			= IRQCHIP_ONESHOT_SAFE,
+	},
+
+	.ops = {
+		.prepare_desc		= idxd_prepare_desc,
+	},
+
+	.info = {
+		.flags			= MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
+					  MSI_FLAG_FREE_MSI_DESCS |
+					  MSI_FLAG_PCI_IMS,
+		.bus_token		= DOMAIN_BUS_PCI_DEVICE_IMS,
+	},
+};
+
+/**
+ * pci_intel_idxd_create_ims_domain - Create a IDXD IMS domain
+ * @pdev:	IDXD PCI device to operate on
+ * @slots:	Pointer to the mapped slot memory arrray
+ * @nr_slots:	The number of slots in the array
+ *
+ * Returns: True on success, false otherwise
+ *
+ * The domain is automatically destroyed when the @pdev is destroyed
+ */
+bool pci_intel_idxd_create_ims_domain(struct pci_dev *pdev, void __iomem *slots,
+				      unsigned int nr_slots)
+{
+	return pci_create_ims_domain(pdev, &idxd_ims_template, nr_slots, (__force void *)slots);
+}
+EXPORT_SYMBOL_GPL(pci_intel_idxd_create_ims_domain);
--- /dev/null
+++ b/include/linux/irqchip/irq-pci-intel-idxd.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* (C) Copyright 2022 Thomas Gleixner <tglx@linutronix.de> */
+
+#ifndef _LINUX_IRQCHIP_IRQ_PCI_INTEL_IDXD_H
+#define _LINUX_IRQCHIP_IRQ_PCI_INTEL_IDXD_H
+
+#include <linux/msi_api.h>
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/*
+ * Conveniance macro to wrap the PASID for interrupt allocation
+ * via pci_ims_alloc_irq(pdev, INTEL_IDXD_DEV_COOKIE(pasid))
+ */
+#define INTEL_IDXD_DEV_COOKIE(pasid)	(union msi_instance_cookie) { .value = (pasid), }
+
+struct pci_dev;
+
+bool pci_intel_idxd_create_ims_domain(struct pci_dev *pdev, void __iomem *slots,
+				      unsigned int nr_slots);
+
+#endif

