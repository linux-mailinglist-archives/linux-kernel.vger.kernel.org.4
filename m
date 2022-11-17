Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF4362DF35
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiKQPKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbiKQPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D41781A3;
        Thu, 17 Nov 2022 07:08:19 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4Bznlzmzpzp5mi9t27okMEpLJcJyXKzYCUHI7O9Kdo=;
        b=tuuGeQRv0TdG4qeyGRChtfdLo3gZDPfDt9d2mq5qlznRkSi7yUWqduDnqIfebD9RJhTa5M
        DzlWml2PgHr7BJHX9E+ap9ykVkBwMoxMlu+QzHdiEVGrygT6tQuj7A4JOVya1f9DYLy6At
        AIZ+5rPgepbuvu07N0WKo/lXg94fjBcoMnIWDw8N7byA+ADdUW4AQiUTyYq3oFbQQsc6dC
        Hjc3dQuFx3SKtgHJYHkbsfVliLgm0CeKk8O0a95pz7X+k3xx5qdu6cUqpZV9RfqNAkAHlI
        aa3Gwsp9r7wRiX4P3sytD/WMUV58ZRYk08Kk+q5lHv/G2zgWzDEkf049sYgFfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4Bznlzmzpzp5mi9t27okMEpLJcJyXKzYCUHI7O9Kdo=;
        b=ZD6YHETG9Nn4BJAcH1qUwzD8arf3Pyps/vx2zYeeCzfhlDuCb60NaOXByYY8vxjqSSmhvQ
        JDzBm16ps8hdpeAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.524842979@linutronix.de>
References: <20221111122014.524842979@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869769649.4906.4149362707512771458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     13e7accb81d6c07993385af8342238ff22b41ac8
Gitweb:        https://git.kernel.org/tip/13e7accb81d6c07993385af8342238ff22b41ac8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:20 +01:00

genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN

Adjust to reality and remove another layer of pointless Kconfig
indirection. CONFIG_GENERIC_MSI_IRQ is good enough to serve
all purposes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20221111122014.524842979@linutronix.de

---
 drivers/base/Makefile       | 2 +-
 drivers/bus/fsl-mc/Kconfig  | 2 +-
 drivers/dma/Kconfig         | 2 +-
 drivers/dma/qcom/hidma.c    | 8 ++++----
 drivers/iommu/Kconfig       | 2 +-
 drivers/irqchip/Kconfig     | 6 +++---
 drivers/mailbox/Kconfig     | 2 +-
 drivers/pci/Kconfig         | 1 -
 drivers/perf/Kconfig        | 2 +-
 drivers/soc/ti/Kconfig      | 2 +-
 include/asm-generic/msi.h   | 4 ++--
 include/linux/device.h      | 8 +++-----
 include/linux/gpio/driver.h | 2 +-
 include/linux/msi.h         | 8 +++-----
 kernel/irq/Kconfig          | 7 +------
 kernel/irq/msi.c            | 3 ---
 16 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 83217d2..3079bfe 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_REGMAP)	+= regmap/
 obj-$(CONFIG_SOC_BUS) += soc.o
 obj-$(CONFIG_PINCTRL) += pinctrl.o
 obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
-obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
+obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
 obj-$(CONFIG_ACPI) += physical_location.o
diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
index b1fd559..9492342 100644
--- a/drivers/bus/fsl-mc/Kconfig
+++ b/drivers/bus/fsl-mc/Kconfig
@@ -8,7 +8,7 @@
 config FSL_MC_BUS
 	bool "QorIQ DPAA2 fsl-mc bus driver"
 	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86_LOCAL_APIC || PPC)))
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	help
 	  Driver to enable the bus infrastructure for the QorIQ DPAA2
 	  architecture.  The fsl-mc bus driver handles discovery of
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 7524b62..25e111a 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -462,7 +462,7 @@ config MV_XOR_V2
 	select DMA_ENGINE
 	select DMA_ENGINE_RAID
 	select ASYNC_TX_ENABLE_CHANNEL_SWITCH
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	help
 	  Enable support for the Marvell version 2 XOR engine.
 
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 210f1a9..04d1c33 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -610,7 +610,7 @@ static irqreturn_t hidma_chirq_handler(int chirq, void *arg)
 	return hidma_ll_inthandler(chirq, lldev);
 }
 
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 static irqreturn_t hidma_chirq_handler_msi(int chirq, void *arg)
 {
 	struct hidma_lldev **lldevp = arg;
@@ -671,7 +671,7 @@ static int hidma_sysfs_init(struct hidma_dev *dev)
 	return device_create_file(dev->ddev.dev, dev->chid_attrs);
 }
 
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 static void hidma_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct device *dev = msi_desc_to_dev(desc);
@@ -687,7 +687,7 @@ static void hidma_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 
 static void hidma_free_msis(struct hidma_dev *dmadev)
 {
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 	struct device *dev = dmadev->ddev.dev;
 	int i, virq;
 
@@ -704,7 +704,7 @@ static void hidma_free_msis(struct hidma_dev *dmadev)
 static int hidma_request_msi(struct hidma_dev *dmadev,
 			     struct platform_device *pdev)
 {
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 	int rc, i, virq;
 
 	rc = platform_msi_domain_alloc_irqs(&pdev->dev, HIDMA_MSI_INTS,
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc5f7a1..8eaf9b7 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -389,7 +389,7 @@ config ARM_SMMU_V3
 	depends on ARM64
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	help
 	  Support for implementations of the ARM System MMU architecture
 	  version 3 providing translation support to a PCIe root complex.
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e..ffea6a8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -38,7 +38,7 @@ config ARM_GIC_V3
 
 config ARM_GIC_V3_ITS
 	bool
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	default ARM_GIC_V3
 
 config ARM_GIC_V3_ITS_PCI
@@ -375,7 +375,7 @@ config MVEBU_ICU
 
 config MVEBU_ODMI
 	bool
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 
 config MVEBU_PIC
 	bool
@@ -488,7 +488,7 @@ config IMX_MU_MSI
 	default m if ARCH_MXC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	help
 	  Provide a driver for the i.MX Messaging Unit block used as a
 	  CPU-to-CPU MSI controller. This requires a specially crafted DT
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05d6fae..d7af896 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -223,7 +223,7 @@ config BCM_FLEXRM_MBOX
 	tristate "Broadcom FlexRM Mailbox"
 	depends on ARM64
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	default m if ARCH_BCM_IPROC
 	help
 	  Mailbox implementation of the Broadcom FlexRM ring manager,
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index b7f6221..9309f24 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -38,7 +38,6 @@ source "drivers/pci/pcie/Kconfig"
 
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
-	select GENERIC_MSI_IRQ_DOMAIN
 	select GENERIC_MSI_IRQ
 	help
 	   This allows device drivers to enable MSI (Message Signaled
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 341010f..692ffd5 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -93,7 +93,7 @@ config ARM_PMU_ACPI
 config ARM_SMMU_V3_PMU
 	 tristate "ARM SMMUv3 Performance Monitors Extension"
 	 depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
-	 depends on GENERIC_MSI_IRQ_DOMAIN
+	 depends on GENERIC_MSI_IRQ
 	   help
 	   Provides support for the ARM SMMUv3 Performance Monitor Counter
 	   Groups (PMCG), which provide monitoring of transactions passing
diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 7e2fb1c..e9a597e 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -98,6 +98,6 @@ endif # SOC_TI
 
 config TI_SCI_INTA_MSI_DOMAIN
 	bool
-	select GENERIC_MSI_IRQ_DOMAIN
+	select GENERIC_MSI_IRQ
 	help
 	  Driver to enable Interrupt Aggregator specific MSI Domain.
diff --git a/include/asm-generic/msi.h b/include/asm-generic/msi.h
index bf910d4..124c734 100644
--- a/include/asm-generic/msi.h
+++ b/include/asm-generic/msi.h
@@ -4,7 +4,7 @@
 
 #include <linux/types.h>
 
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 
 #ifndef NUM_MSI_ALLOC_SCRATCHPAD_REGS
 # define NUM_MSI_ALLOC_SCRATCHPAD_REGS	2
@@ -36,6 +36,6 @@ typedef struct msi_alloc_info {
 
 #define GENERIC_MSI_DOMAIN_OPS		1
 
-#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
+#endif /* CONFIG_GENERIC_MSI_IRQ */
 
 #endif
diff --git a/include/linux/device.h b/include/linux/device.h
index 424b55d..c90a444 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -378,10 +378,8 @@ struct dev_links_info {
  * @data:	Pointer to MSI device data
  */
 struct dev_msi_info {
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	struct irq_domain	*domain;
-#endif
 #ifdef CONFIG_GENERIC_MSI_IRQ
+	struct irq_domain	*domain;
 	struct msi_device_data	*data;
 #endif
 };
@@ -742,7 +740,7 @@ static inline void set_dev_node(struct device *dev, int node)
 
 static inline struct irq_domain *dev_get_msi_domain(const struct device *dev)
 {
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 	return dev->msi.domain;
 #else
 	return NULL;
@@ -751,7 +749,7 @@ static inline struct irq_domain *dev_get_msi_domain(const struct device *dev)
 
 static inline void dev_set_msi_domain(struct device *dev, struct irq_domain *d)
 {
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 	dev->msi.domain = d;
 #endif
 }
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 6aeea10..88ae451 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -27,7 +27,7 @@ struct gpio_chip;
 
 union gpio_irq_fwspec {
 	struct irq_fwspec	fwspec;
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 	msi_alloc_info_t	msiinfo;
 #endif
 };
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 9b84145..8b28714 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -79,9 +79,7 @@ void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
 #else
-static inline void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
-{
-}
+static inline void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg) { }
 #endif
 
 typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
@@ -278,7 +276,7 @@ static inline void msi_device_destroy_sysfs(struct device *dev) { }
  */
 bool arch_restore_msi_irqs(struct pci_dev *dev);
 
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+#ifdef CONFIG_GENERIC_MSI_IRQ
 
 #include <linux/irqhandler.h>
 
@@ -451,7 +449,7 @@ int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int vir
 void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
 				     unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
-#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
+#endif /* CONFIG_GENERIC_MSI_IRQ */
 
 /* PCI specific interfaces */
 #ifdef CONFIG_PCI_MSI
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index db3d174..b64c44a 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -86,15 +86,10 @@ config GENERIC_IRQ_IPI
 	depends on SMP
 	select IRQ_DOMAIN_HIERARCHY
 
-# Generic MSI interrupt support
-config GENERIC_MSI_IRQ
-	bool
-
 # Generic MSI hierarchical interrupt domain support
-config GENERIC_MSI_IRQ_DOMAIN
+config GENERIC_MSI_IRQ
 	bool
 	select IRQ_DOMAIN_HIERARCHY
-	select GENERIC_MSI_IRQ
 
 config IRQ_MSI_IOMMU
 	bool
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index b46b747..4fde917 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -461,7 +461,6 @@ static inline int msi_sysfs_populate_desc(struct device *dev, struct msi_desc *d
 static inline void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *desc) { }
 #endif /* !CONFIG_SYSFS */
 
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec);
 static void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 
@@ -1058,5 +1057,3 @@ struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain)
 {
 	return (struct msi_domain_info *)domain->host_data;
 }
-
-#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
