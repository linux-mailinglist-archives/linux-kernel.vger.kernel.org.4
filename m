Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23FB62DF39
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbiKQPKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240445AbiKQPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B945781A8;
        Thu, 17 Nov 2022 07:08:20 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1/aq0fv10nvJV45kQht6nHtOb6gdjUa5CnCxcQZYBc=;
        b=XEMq6pn86aAOcWlagaYOqJTv7HsjKGzczzcrsuATzDw/YgXRDSXgFKe6XR2CosDlvKNhyv
        mCcYTGs1qf4aEJ446eBp4Ymjruxm9VOY2RrUYe/IfafTqswC3nYClRtXBjBYTymzDWD/cY
        b9l2xKtab/0vPO7oZwY7bTSIt1K7QBjKksbizEZmfok4y6NT4juXkSVYFcWt/rmPXguMRD
        m9v+wKuQbgpGgVxR26K8/PICtzGh3Mwc32OEPAxzEbIwZLvbpzCuzUaAIIVo2JDsefy+0A
        BC/PnzpZJ1pf+PykIFrqtr/U8qeyaRzBue1ZjtrlwFhbw2KhCWhzA9WGg6kAzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1/aq0fv10nvJV45kQht6nHtOb6gdjUa5CnCxcQZYBc=;
        b=WFj9cGdqirS0aW2NIXqGpDg6fwHPRTIcK9kWL89BMySIIzzDy8VFXhFBm2PMNgrLJq+NWA
        l+U4HLlDmu51M+CA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.467556921@linutronix.de>
References: <20221111122014.467556921@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869769765.4906.9639291368963784702.tip-bot2@tip-bot2>
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

Commit-ID:     a474d3fbe287625c6c1cfc56c2a456c5fb7c479e
Gitweb:        https://git.kernel.org/tip/a474d3fbe287625c6c1cfc56c2a456c5fb7c479e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:19 +01:00

PCI/MSI: Get rid of PCI_MSI_IRQ_DOMAIN

What a zoo:

     PCI_MSI
	select GENERIC_MSI_IRQ

     PCI_MSI_IRQ_DOMAIN
     	def_bool y
	depends on PCI_MSI
	select GENERIC_MSI_IRQ_DOMAIN

Ergo PCI_MSI enables PCI_MSI_IRQ_DOMAIN which in turn selects
GENERIC_MSI_IRQ_DOMAIN. So all the dependencies on PCI_MSI_IRQ_DOMAIN are
just an indirection to PCI_MSI.

Match the reality and just admit that PCI_MSI requires
GENERIC_MSI_IRQ_DOMAIN.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122014.467556921@linutronix.de

---
 arch/um/drivers/Kconfig                 |  1 +-
 arch/um/include/asm/pci.h               |  2 +-
 arch/x86/Kconfig                        |  1 +-
 arch/x86/include/asm/pci.h              |  4 +-
 drivers/pci/Kconfig                     |  8 +---
 drivers/pci/controller/Kconfig          | 30 +++++++--------
 drivers/pci/controller/dwc/Kconfig      | 48 ++++++++++++------------
 drivers/pci/controller/mobiveil/Kconfig |  6 +--
 drivers/pci/msi/Makefile                |  2 +-
 drivers/pci/probe.c                     |  2 +-
 include/linux/msi.h                     | 29 +++++----------
 11 files changed, 58 insertions(+), 75 deletions(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 5903e2b..a4f0a19 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -381,7 +381,6 @@ config UML_PCI_OVER_VIRTIO
 	select UML_IOMEM_EMULATION
 	select UML_DMA_EMULATION
 	select PCI_MSI
-	select PCI_MSI_IRQ_DOMAIN
 	select PCI_LOCKLESS_CONFIG
 
 config UML_PCI_OVER_VIRTIO_DEVICE_ID
diff --git a/arch/um/include/asm/pci.h b/arch/um/include/asm/pci.h
index 34fe492..238d2e7 100644
--- a/arch/um/include/asm/pci.h
+++ b/arch/um/include/asm/pci.h
@@ -7,7 +7,7 @@
 /* Generic PCI */
 #include <asm-generic/pci.h>
 
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+#ifdef CONFIG_PCI_MSI
 /*
  * This is a bit of an annoying hack, and it assumes we only have
  * the virt-pci (if anything). Which is true, but still.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ce..64f81a1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1109,7 +1109,6 @@ config X86_LOCAL_APIC
 	def_bool y
 	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
 	select IRQ_DOMAIN_HIERARCHY
-	select PCI_MSI_IRQ_DOMAIN if PCI_MSI
 
 config X86_IO_APIC
 	def_bool y
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 736793d..c4789de 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -21,7 +21,7 @@ struct pci_sysdata {
 #ifdef CONFIG_X86_64
 	void		*iommu;		/* IOMMU private data */
 #endif
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+#ifdef CONFIG_PCI_MSI
 	void		*fwnode;	/* IRQ domain for MSI assignment */
 #endif
 #if IS_ENABLED(CONFIG_VMD)
@@ -52,7 +52,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 }
 #endif
 
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+#ifdef CONFIG_PCI_MSI
 static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
 {
 	return to_pci_sysdata(bus)->fwnode;
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 55c028a..b7f6221 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -38,6 +38,7 @@ source "drivers/pci/pcie/Kconfig"
 
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
+	select GENERIC_MSI_IRQ_DOMAIN
 	select GENERIC_MSI_IRQ
 	help
 	   This allows device drivers to enable MSI (Message Signaled
@@ -51,11 +52,6 @@ config PCI_MSI
 
 	   If you don't know what to do here, say Y.
 
-config PCI_MSI_IRQ_DOMAIN
-	def_bool y
-	depends on PCI_MSI
-	select GENERIC_MSI_IRQ_DOMAIN
-
 config PCI_MSI_ARCH_FALLBACKS
 	bool
 
@@ -192,7 +188,7 @@ config PCI_LABEL
 
 config PCI_HYPERV
 	tristate "Hyper-V PCI Frontend"
-	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && SYSFS
+	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && SYSFS
 	select PCI_HYPERV_INTERFACE
 	help
 	  The PCI device frontend driver allows the kernel to import arbitrary
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index bfd9bac..1569d9a 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -19,7 +19,7 @@ config PCI_AARDVARK
 	tristate "Aardvark PCIe controller"
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCI_BRIDGE_EMUL
 	help
 	 Add support for Aardvark 64bit PCIe Host Controller. This
@@ -29,7 +29,7 @@ config PCI_AARDVARK
 config PCIE_XILINX_NWL
 	bool "NWL PCIe Core"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	 Say 'Y' here if you want kernel support for Xilinx
 	 NWL PCIe controller. The controller can act as Root Port
@@ -53,7 +53,7 @@ config PCI_IXP4XX
 config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
@@ -70,7 +70,7 @@ config PCI_RCAR_GEN2
 config PCIE_RCAR_HOST
 	bool "Renesas R-Car PCIe host controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Say Y here if you want PCIe controller support on R-Car SoCs in host
 	  mode.
@@ -99,7 +99,7 @@ config PCI_HOST_GENERIC
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
 	depends on OF || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
@@ -124,7 +124,7 @@ config PCI_XGENE
 config PCI_XGENE_MSI
 	bool "X-Gene v1 PCIe MSI feature"
 	depends on PCI_XGENE
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	default y
 	help
 	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
@@ -170,7 +170,7 @@ config PCIE_IPROC_BCMA
 config PCIE_IPROC_MSI
 	bool "Broadcom iProc PCIe MSI support"
 	depends on PCIE_IPROC_PLATFORM || PCIE_IPROC_BCMA
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	default ARCH_BCM_IPROC
 	help
 	  Say Y here if you want to enable MSI support for Broadcom's iProc
@@ -186,7 +186,7 @@ config PCIE_ALTERA
 config PCIE_ALTERA_MSI
 	tristate "Altera PCIe MSI feature"
 	depends on PCIE_ALTERA
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Say Y here if you want PCIe MSI support for the Altera FPGA.
 	  This MSI driver supports Altera MSI to GIC controller IP.
@@ -215,7 +215,7 @@ config PCIE_ROCKCHIP_HOST
 	tristate "Rockchip PCIe host controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
 	help
@@ -239,7 +239,7 @@ config PCIE_MEDIATEK
 	tristate "MediaTek PCIe controller"
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
@@ -247,7 +247,7 @@ config PCIE_MEDIATEK
 config PCIE_MEDIATEK_GEN3
 	tristate "MediaTek Gen3 PCIe controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	help
 	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
 	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
@@ -277,7 +277,7 @@ config PCIE_BRCMSTB
 	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCMBCA || \
 		   BMIPS_GENERIC || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  Say Y here to enable PCIe host controller support for
@@ -285,7 +285,7 @@ config PCIE_BRCMSTB
 
 config PCI_HYPERV_INTERFACE
 	tristate "Hyper-V PCI Interface"
-	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN
+	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && PCI_MSI
 	help
 	  The Hyper-V PCI Interface is a helper driver allows other drivers to
 	  have a common interface with the Hyper-V PCI frontend driver.
@@ -303,8 +303,6 @@ config PCI_LOONGSON
 config PCIE_MICROCHIP_HOST
 	bool "Microchip AXI PCIe host bridge support"
 	depends on PCI_MSI && OF
-	select PCI_MSI_IRQ_DOMAIN
-	select GENERIC_MSI_IRQ_DOMAIN
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want kernel to support the Microchip AXI PCIe
@@ -326,7 +324,7 @@ config PCIE_APPLE
 	tristate "Apple PCIe controller"
 	depends on ARCH_APPLE || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want to enable PCIe controller support on Apple
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 62ce3ab..f3c4621 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -21,7 +21,7 @@ config PCI_DRA7XX_HOST
 	tristate "TI DRA7xx PCIe controller Host Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on OF && HAS_IOMEM && TI_PIPE3
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCI_DRA7XX
 	default y if SOC_DRA7XX
@@ -53,7 +53,7 @@ config PCIE_DW_PLAT
 
 config PCIE_DW_PLAT_HOST
 	bool "Platform bus based DesignWare PCIe Controller - Host mode"
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCIE_DW_PLAT
 	help
@@ -67,7 +67,7 @@ config PCIE_DW_PLAT_HOST
 
 config PCIE_DW_PLAT_EP
 	bool "Platform bus based DesignWare PCIe Controller - Endpoint mode"
-	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on PCI && PCI_MSI
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCIE_DW_PLAT
@@ -83,7 +83,7 @@ config PCIE_DW_PLAT_EP
 config PCI_EXYNOS
 	tristate "Samsung Exynos PCIe controller"
 	depends on ARCH_EXYNOS || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Enables support for the PCIe controller in the Samsung Exynos SoCs
@@ -94,13 +94,13 @@ config PCI_EXYNOS
 config PCI_IMX6
 	bool "Freescale i.MX6/7/8 PCIe controller"
 	depends on ARCH_MXC || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
 	depends on ARCH_SPEAR13XX || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
@@ -111,7 +111,7 @@ config PCI_KEYSTONE
 config PCI_KEYSTONE_HOST
 	bool "PCI Keystone Host Mode"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCI_KEYSTONE
 	help
@@ -135,7 +135,7 @@ config PCI_KEYSTONE_EP
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller - Host mode"
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select MFD_SYSCON
 	help
@@ -160,7 +160,7 @@ config PCI_LAYERSCAPE_EP
 config PCI_HISI
 	depends on OF && (ARM64 || COMPILE_TEST)
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCI_HOST_COMMON
 	help
@@ -170,7 +170,7 @@ config PCI_HISI
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select CRC8
 	help
@@ -191,7 +191,7 @@ config PCIE_QCOM_EP
 config PCIE_ARMADA_8K
 	bool "Marvell Armada-8K PCIe controller"
 	depends on ARCH_MVEBU || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want to enable PCIe controller support on
@@ -205,7 +205,7 @@ config PCIE_ARTPEC6
 config PCIE_ARTPEC6_HOST
 	bool "Axis ARTPEC-6 PCIe controller Host Mode"
 	depends on MACH_ARTPEC6 || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCIE_ARTPEC6
 	help
@@ -226,7 +226,7 @@ config PCIE_ROCKCHIP_DW_HOST
 	bool "Rockchip DesignWare PCIe controller"
 	select PCIE_DW
 	select PCIE_DW_HOST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on OF
 	help
@@ -236,7 +236,7 @@ config PCIE_ROCKCHIP_DW_HOST
 config PCIE_INTEL_GW
 	bool "Intel Gateway PCIe host controller support"
 	depends on OF && (X86 || COMPILE_TEST)
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say 'Y' here to enable PCIe Host controller support on Intel
@@ -250,7 +250,7 @@ config PCIE_KEEMBAY
 config PCIE_KEEMBAY_HOST
 	bool "Intel Keem Bay PCIe controller - Host mode"
 	depends on ARCH_KEEMBAY || COMPILE_TEST
-	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCIE_KEEMBAY
 	help
@@ -262,7 +262,7 @@ config PCIE_KEEMBAY_HOST
 config PCIE_KEEMBAY_EP
 	bool "Intel Keem Bay PCIe controller - Endpoint mode"
 	depends on ARCH_KEEMBAY || COMPILE_TEST
-	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCIE_KEEMBAY
@@ -275,7 +275,7 @@ config PCIE_KEEMBAY_EP
 config PCIE_KIRIN
 	depends on OF && (ARM64 || COMPILE_TEST)
 	tristate "HiSilicon Kirin series SoCs PCIe controllers"
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support
@@ -284,7 +284,7 @@ config PCIE_KIRIN
 config PCIE_HISI_STB
 	bool "HiSilicon STB SoCs PCIe controllers"
 	depends on ARCH_HISI || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
@@ -292,7 +292,7 @@ config PCIE_HISI_STB
 config PCI_MESON
 	tristate "MESON PCIe controller"
 	default m if ARCH_MESON
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want to enable PCI controller support on Amlogic
@@ -306,7 +306,7 @@ config PCIE_TEGRA194
 config PCIE_TEGRA194_HOST
 	tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
 	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PHY_TEGRA194_P2U
 	select PCIE_TEGRA194
@@ -336,7 +336,7 @@ config PCIE_TEGRA194_EP
 config PCIE_VISCONTI_HOST
 	bool "Toshiba Visconti PCIe controllers"
 	depends on ARCH_VISCONTI || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
@@ -346,7 +346,7 @@ config PCIE_UNIPHIER
 	bool "Socionext UniPhier PCIe host controllers"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
 	depends on OF && HAS_IOMEM
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want PCIe host controller support on UniPhier SoCs.
@@ -365,7 +365,7 @@ config PCIE_UNIPHIER_EP
 config PCIE_AL
 	bool "Amazon Annapurna Labs PCIe controller"
 	depends on OF && (ARM64 || COMPILE_TEST)
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCI_ECAM
 	help
@@ -377,7 +377,7 @@ config PCIE_AL
 
 config PCIE_FU740
 	bool "SiFive FU740 PCIe host controller"
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	depends on SOC_SIFIVE || COMPILE_TEST
 	select PCIE_DW_HOST
 	help
diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index e4643fb..1d7a07b 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -8,14 +8,14 @@ config PCIE_MOBIVEIL
 
 config PCIE_MOBIVEIL_HOST
 	bool
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_MOBIVEIL
 
 config PCIE_MOBIVEIL_PLAT
 	bool "Mobiveil AXI PCIe controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_MOBIVEIL_HOST
 	help
 	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
@@ -25,7 +25,7 @@ config PCIE_MOBIVEIL_PLAT
 config PCIE_LAYERSCAPE_GEN4
 	bool "Freescale Layerscape PCIe Gen4 controller"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI
 	select PCIE_MOBIVEIL_HOST
 	help
 	  Say Y here if you want PCIe Gen4 controller support on
diff --git a/drivers/pci/msi/Makefile b/drivers/pci/msi/Makefile
index 93ef7b9..4e0a7e0 100644
--- a/drivers/pci/msi/Makefile
+++ b/drivers/pci/msi/Makefile
@@ -3,5 +3,5 @@
 # Makefile for the PCI/MSI
 obj-$(CONFIG_PCI)			+= pcidev_msi.o
 obj-$(CONFIG_PCI_MSI)			+= msi.o
-obj-$(CONFIG_PCI_MSI_IRQ_DOMAIN)	+= irqdomain.o
+obj-$(CONFIG_PCI_MSI)			+= irqdomain.o
 obj-$(CONFIG_PCI_MSI_ARCH_FALLBACKS)	+= legacy.o
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b66fa42..fdd7e56 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -842,7 +842,6 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 	if (!d)
 		d = pci_host_bridge_acpi_msi_domain(bus);
 
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 	/*
 	 * If no IRQ domain was found via the OF tree, try looking it up
 	 * directly through the fwnode_handle.
@@ -854,7 +853,6 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 			d = irq_find_matching_fwnode(fwnode,
 						     DOMAIN_BUS_PCI_MSI);
 	}
-#endif
 
 	return d;
 }
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 2dfd7b2..9b84145 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -238,15 +238,6 @@ static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
 }
 #endif
 
-#ifdef CONFIG_PCI_MSI
-struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
-void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
-#else /* CONFIG_PCI_MSI */
-static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
-{
-}
-#endif /* CONFIG_PCI_MSI */
-
 int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
 void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
 
@@ -259,12 +250,6 @@ static inline void msi_free_msi_descs(struct device *dev)
 	msi_free_msi_descs_range(dev, 0, MSI_MAX_INDEX);
 }
 
-void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
-void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
-
-void pci_msi_mask_irq(struct irq_data *data);
-void pci_msi_unmask_irq(struct irq_data *data);
-
 /*
  * The arch hooks to setup up msi irqs. Default functions are implemented
  * as weak symbols so that they /can/ be overriden by architecture specific
@@ -468,18 +453,26 @@ void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int vir
 void *platform_msi_get_host_data(struct irq_domain *domain);
 #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
 
-#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+/* PCI specific interfaces */
+#ifdef CONFIG_PCI_MSI
+struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
+void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
+void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+void pci_msi_mask_irq(struct irq_data *data);
+void pci_msi_unmask_irq(struct irq_data *data);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
 bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
-#else
+#else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
 	return NULL;
 }
-#endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
+static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg) { }
+#endif /* !CONFIG_PCI_MSI */
 
 #endif /* LINUX_MSI_H */
