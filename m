Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C070768311F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjAaPPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjAaPPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:15:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801CC5895F;
        Tue, 31 Jan 2023 07:13:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 599BDB81D3A;
        Tue, 31 Jan 2023 15:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26944C433EF;
        Tue, 31 Jan 2023 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675177555;
        bh=NR6+Sw+XVUUAfLO1fjlZDIfAaaMpw56BqG+CDyOuZc0=;
        h=From:To:Cc:Subject:Date:From;
        b=FAxB/d/VFKe8weXPQxHIJdwbvxx+IB75ht8FO6HDi28XPgYzhpTk5E2kZgzqJl3WH
         7iD07f3HHFN/0Bqt2emFiOiNA7eXLMH3+z3G4BYg4qNJ9ZxtwK8asiImw46XvcgrwI
         f+QUPEIL893vbeXAhicWwP+w+Fmv6s1g5GqNJDf+VrAq5pzD8leTMhLgq6sADh99Tr
         h41vFhznOBckeMgtts5lp4BmDAu5Kq3HuA+qgLq5ec7RPeKsN7H7kVg/Oek7VF1CVl
         s0pUHXqE3ttz41MwX+2rRvLITwV+tTTPZcoLbqdeKn0BB6dPo3QrNnQZ0GnA1PHh8J
         CjH+wmggS03cA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] xhci: split out rcar/rz support from xhci-plat.c
Date:   Tue, 31 Jan 2023 16:04:31 +0100
Message-Id: <20230131150531.12347-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The USB_XHCI_RZV2M and USB_RENESAS_USB3 select other drivers
based on the enabled SoC types, which leads to build failures
when the dependencies are not met:

WARNING: unmet direct dependencies detected for USB_RZV2M_USB3DRD
  Depends on [n]: USB_SUPPORT [=y] && USB_GADGET [=n] && (ARCH_R9A09G011 [=n] || COMPILE_TEST [=y])
  Selected by [m]:
  - USB_XHCI_RZV2M [=m] && USB_SUPPORT [=y] && USB [=y] && USB_XHCI_HCD [=m] && USB_XHCI_PLATFORM [=m] && (ARCH_R9A09G011 [=n] || COMPILE_TEST [=y])
ERROR: modpost: "rzv2m_usb3drd_reset" [drivers/usb/host/xhci-plat-hcd.ko] undefined!

The xhci-rcar driver has a reverse dependency with the xhci core, and it
depends on the UDC driver in turn. To untangle this, make the xhci-rcar.ko
driver a standalone module that just calls into the xhci-plat.ko module
like other drivers do.

This allows handling the dependency on the USB_RZV2M_USB3DRD driver to
only affect the xhci-rcar module and simplify the xhci-plat module.

It also allows leaving out the hacks for broken dma mask and nested
devices from the rcar side and keep that only in the generic xhci driver.

As a future cleanup, the marvell and dwc3 specific bits of xhci-plat.c
could be moved out as well, but that is not required for this bugfix.

Fixes: c52c9acc415e ("xhci: host: Add Renesas RZ/V2M SoC support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/Kconfig |   4 +-
 drivers/usb/host/Kconfig       |   9 ++-
 drivers/usb/host/Makefile      |  11 ++-
 drivers/usb/host/xhci-plat.c   | 127 +++++++++++++--------------------
 drivers/usb/host/xhci-plat.h   |   7 ++
 drivers/usb/host/xhci-rcar.c   | 102 ++++++++++++++++++++++++--
 drivers/usb/host/xhci-rcar.h   |  55 --------------
 7 files changed, 164 insertions(+), 151 deletions(-)
 delete mode 100644 drivers/usb/host/xhci-rcar.h

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 9b7a1681550f..20b477b2a080 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -182,8 +182,6 @@ config USB_RENESAS_USBHS_UDC
 config USB_RZV2M_USB3DRD
 	tristate 'Renesas USB3.1 DRD controller'
 	depends on ARCH_R9A09G011 || COMPILE_TEST
-	default USB_XHCI_RZV2M
-	default USB_RENESAS_USB3
 	help
 	   Renesas USB3.1 DRD controller is a USB DRD controller
 	   that supports both host and device switching.
@@ -194,8 +192,8 @@ config USB_RZV2M_USB3DRD
 config USB_RENESAS_USB3
 	tristate 'Renesas USB3.0 Peripheral controller'
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on USB_RZV2M_USB3DRD || !USB_RZV2M_USB3DRD
 	depends on EXTCON
-	select USB_RZV2M_USB3DRD if ARCH_R9A09G011
 	select USB_ROLE_SWITCH
 	help
 	   Renesas USB3.0 Peripheral controller is a USB peripheral controller
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 4b5c5b1feb40..cfcc0685b650 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -53,8 +53,6 @@ config USB_XHCI_PCI_RENESAS
 
 config USB_XHCI_PLATFORM
 	tristate "Generic xHCI driver for a platform device"
-	select USB_XHCI_RCAR if ARCH_RENESAS
-	select USB_XHCI_RZV2M if ARCH_R9A09G011
 	help
 	  Adds an xHCI host driver for a generic platform device, which
 	  provides a memory space and an irq.
@@ -92,15 +90,16 @@ config USB_XHCI_RCAR
 	tristate "xHCI support for Renesas R-Car SoCs"
 	depends on USB_XHCI_PLATFORM
 	depends on ARCH_RENESAS || COMPILE_TEST
+	default ARCH_RENESAS
 	help
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in Renesas R-Car ARM SoCs.
 
 config USB_XHCI_RZV2M
-	tristate "xHCI support for Renesas RZ/V2M SoC"
-	depends on USB_XHCI_PLATFORM
+	bool "xHCI support for Renesas RZ/V2M SoC"
+	depends on USB_XHCI_RCAR
 	depends on ARCH_R9A09G011 || COMPILE_TEST
-	select USB_RZV2M_USB3DRD
+	depends on USB_RZV2M_USB3DRD=y || (USB_RZV2M_USB3DRD=USB_XHCI_RCAR)
 	help
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in Renesas RZ/V2M SoC.
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 6b1f9317f116..5a13712f367d 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -25,17 +25,13 @@ xhci-plat-hcd-y := xhci-plat.o
 ifneq ($(CONFIG_USB_XHCI_MVEBU), )
 	xhci-plat-hcd-y		+= xhci-mvebu.o
 endif
-ifneq ($(CONFIG_USB_XHCI_RCAR), )
-	xhci-plat-hcd-y		+= xhci-rcar.o
-endif
-ifneq ($(CONFIG_USB_XHCI_RZV2M), )
-	xhci-plat-hcd-y		+= xhci-rzv2m.o
-endif
-
 ifneq ($(CONFIG_DEBUG_FS),)
 	xhci-hcd-y		+= xhci-debugfs.o
 endif
 
+xhci-rcar-hcd-y				+= xhci-rcar.o
+xhci-rcar-hcd-$(CONFIG_USB_XHCI_RZV2M)	+= xhci-rzv2m.o
+
 obj-$(CONFIG_USB_PCI)	+= pci-quirks.o
 
 obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
@@ -75,6 +71,7 @@ obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
 obj-$(CONFIG_USB_XHCI_PCI_RENESAS)	+= xhci-pci-renesas.o
 obj-$(CONFIG_USB_XHCI_PLATFORM) += xhci-plat-hcd.o
 obj-$(CONFIG_USB_XHCI_HISTB)	+= xhci-histb.o
+obj-$(CONFIG_USB_XHCI_RCAR)	+= xhci-rcar-hcd.o
 obj-$(CONFIG_USB_XHCI_MTK)	+= xhci-mtk-hcd.o
 obj-$(CONFIG_USB_XHCI_TEGRA)	+= xhci-tegra.o
 obj-$(CONFIG_USB_SL811_HCD)	+= sl811-hcd.o
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 57269f1f318e..cd17ccab6e00 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -24,8 +24,6 @@
 #include "xhci.h"
 #include "xhci-plat.h"
 #include "xhci-mvebu.h"
-#include "xhci-rcar.h"
-#include "xhci-rzv2m.h"
 
 static struct hc_driver __read_mostly xhci_plat_hc_driver;
 
@@ -116,21 +114,6 @@ static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
 	.init_quirk = xhci_mvebu_a3700_init_quirk,
 };
 
-static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
-	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V1)
-};
-
-static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
-	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
-};
-
-static const struct xhci_plat_priv xhci_plat_renesas_rzv2m = {
-	.quirks = XHCI_NO_64BIT_SUPPORT | XHCI_TRUST_TX_LENGTH |
-		  XHCI_SLOW_SUSPEND,
-	.init_quirk = xhci_rzv2m_init_quirk,
-	.plat_start = xhci_rzv2m_start,
-};
-
 static const struct xhci_plat_priv xhci_plat_brcm = {
 	.quirks = XHCI_RESET_ON_RESUME | XHCI_SUSPEND_RESUME_CLKS,
 };
@@ -149,30 +132,6 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	}, {
 		.compatible = "marvell,armada3700-xhci",
 		.data = &xhci_plat_marvell_armada3700,
-	}, {
-		.compatible = "renesas,xhci-r8a7790",
-		.data = &xhci_plat_renesas_rcar_gen2,
-	}, {
-		.compatible = "renesas,xhci-r8a7791",
-		.data = &xhci_plat_renesas_rcar_gen2,
-	}, {
-		.compatible = "renesas,xhci-r8a7793",
-		.data = &xhci_plat_renesas_rcar_gen2,
-	}, {
-		.compatible = "renesas,xhci-r8a7795",
-		.data = &xhci_plat_renesas_rcar_gen3,
-	}, {
-		.compatible = "renesas,xhci-r8a7796",
-		.data = &xhci_plat_renesas_rcar_gen3,
-	}, {
-		.compatible = "renesas,rcar-gen2-xhci",
-		.data = &xhci_plat_renesas_rcar_gen2,
-	}, {
-		.compatible = "renesas,rcar-gen3-xhci",
-		.data = &xhci_plat_renesas_rcar_gen3,
-	}, {
-		.compatible = "renesas,rzv2m-xhci",
-		.data = &xhci_plat_renesas_rzv2m,
 	}, {
 		.compatible = "brcm,xhci-brcm-v2",
 		.data = &xhci_plat_brcm,
@@ -185,11 +144,10 @@ static const struct of_device_id usb_xhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
 #endif
 
-static int xhci_plat_probe(struct platform_device *pdev)
+int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const struct xhci_plat_priv *priv_match)
 {
-	const struct xhci_plat_priv *priv_match;
 	const struct hc_driver	*driver;
-	struct device		*sysdev, *tmpdev;
+	struct device		*tmpdev;
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd, *usb3_hcd;
@@ -207,31 +165,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	/*
-	 * sysdev must point to a device that is known to the system firmware
-	 * or PCI hardware. We handle these three cases here:
-	 * 1. xhci_plat comes from firmware
-	 * 2. xhci_plat is child of a device from firmware (dwc3-plat)
-	 * 3. xhci_plat is grandchild of a pci device (dwc3-pci)
-	 */
-	for (sysdev = &pdev->dev; sysdev; sysdev = sysdev->parent) {
-		if (is_of_node(sysdev->fwnode) ||
-			is_acpi_device_node(sysdev->fwnode))
-			break;
-#ifdef CONFIG_PCI
-		else if (sysdev->bus == &pci_bus_type)
-			break;
-#endif
-	}
-
 	if (!sysdev)
 		sysdev = &pdev->dev;
 
-	if (WARN_ON(!sysdev->dma_mask))
-		/* Platform did not initialize dma_mask */
-		ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
-	else
-		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
+	ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
 	if (ret)
 		return ret;
 
@@ -293,11 +230,6 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_reg_clk;
 
-	if (pdev->dev.of_node)
-		priv_match = of_device_get_match_data(&pdev->dev);
-	else
-		priv_match = dev_get_platdata(&pdev->dev);
-
 	if (priv_match) {
 		priv = hcd_to_xhci_priv(hcd);
 		/* Just copy data for now */
@@ -411,8 +343,47 @@ static int xhci_plat_probe(struct platform_device *pdev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(xhci_plat_probe);
+
+static int xhci_generic_plat_probe(struct platform_device *pdev)
+{
+	const struct xhci_plat_priv *priv_match;
+	struct device *sysdev;
+	int ret;
+
+	/*
+	 * sysdev must point to a device that is known to the system firmware
+	 * or PCI hardware. We handle these three cases here:
+	 * 1. xhci_plat comes from firmware
+	 * 2. xhci_plat is child of a device from firmware (dwc3-plat)
+	 * 3. xhci_plat is grandchild of a pci device (dwc3-pci)
+	 */
+	for (sysdev = &pdev->dev; sysdev; sysdev = sysdev->parent) {
+		if (is_of_node(sysdev->fwnode) ||
+			is_acpi_device_node(sysdev->fwnode))
+			break;
+#ifdef CONFIG_PCI
+		else if (sysdev->bus == &pci_bus_type)
+			break;
+#endif
+	}
+
+	if (WARN_ON(!sysdev->dma_mask)) {
+		/* Platform did not initialize dma_mask */
+		ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
+		if (ret)
+			return ret;
+	}
+
+	if (pdev->dev.of_node)
+		priv_match = of_device_get_match_data(&pdev->dev);
+	else
+		priv_match = dev_get_platdata(&pdev->dev);
+
+	return xhci_plat_probe(pdev, sysdev, priv_match);
+}
 
-static int xhci_plat_remove(struct platform_device *dev)
+int xhci_plat_remove(struct platform_device *dev)
 {
 	struct usb_hcd	*hcd = platform_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
@@ -446,6 +417,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_plat_remove);
 
 static int __maybe_unused xhci_plat_suspend(struct device *dev)
 {
@@ -522,13 +494,14 @@ static int __maybe_unused xhci_plat_runtime_resume(struct device *dev)
 	return xhci_resume(xhci, 0);
 }
 
-static const struct dev_pm_ops xhci_plat_pm_ops = {
+const struct dev_pm_ops xhci_plat_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(xhci_plat_suspend, xhci_plat_resume)
 
 	SET_RUNTIME_PM_OPS(xhci_plat_runtime_suspend,
 			   xhci_plat_runtime_resume,
 			   NULL)
 };
+EXPORT_SYMBOL_GPL(xhci_plat_pm_ops);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id usb_xhci_acpi_match[] = {
@@ -539,8 +512,8 @@ static const struct acpi_device_id usb_xhci_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
 #endif
 
-static struct platform_driver usb_xhci_driver = {
-	.probe	= xhci_plat_probe,
+static struct platform_driver usb_generic_xhci_driver = {
+	.probe	= xhci_generic_plat_probe,
 	.remove	= xhci_plat_remove,
 	.shutdown = usb_hcd_platform_shutdown,
 	.driver	= {
@@ -555,13 +528,13 @@ MODULE_ALIAS("platform:xhci-hcd");
 static int __init xhci_plat_init(void)
 {
 	xhci_init_driver(&xhci_plat_hc_driver, &xhci_plat_overrides);
-	return platform_driver_register(&usb_xhci_driver);
+	return platform_driver_register(&usb_generic_xhci_driver);
 }
 module_init(xhci_plat_init);
 
 static void __exit xhci_plat_exit(void)
 {
-	platform_driver_unregister(&usb_xhci_driver);
+	platform_driver_unregister(&usb_generic_xhci_driver);
 }
 module_exit(xhci_plat_exit);
 
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 1fb149d1fbce..83b5b5aa9f8e 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -21,4 +21,11 @@ struct xhci_plat_priv {
 
 #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
 #define xhci_to_priv(x) ((struct xhci_plat_priv *)(x)->priv)
+
+int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev,
+		    const struct xhci_plat_priv *priv_match);
+
+int xhci_plat_remove(struct platform_device *dev);
+extern const struct dev_pm_ops xhci_plat_pm_ops;
+
 #endif	/* _XHCI_PLAT_H */
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index aef0258a7160..7f18509a1d39 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -10,12 +10,17 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/usb/phy.h>
 #include <linux/sys_soc.h>
 
 #include "xhci.h"
 #include "xhci-plat.h"
-#include "xhci-rcar.h"
+#include "xhci-rzv2m.h"
+
+#define XHCI_RCAR_FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
+#define XHCI_RCAR_FIRMWARE_NAME_V2	"r8a779x_usb3_v2.dlmem"
+#define XHCI_RCAR_FIRMWARE_NAME_V3	"r8a779x_usb3_v3.dlmem"
 
 /*
 * - The V3 firmware is for almost all R-Car Gen3 (except r8a7795 ES1.x)
@@ -108,7 +113,7 @@ static int xhci_rcar_is_gen2(struct device *dev)
 		of_device_is_compatible(node, "renesas,rcar-gen2-xhci");
 }
 
-void xhci_rcar_start(struct usb_hcd *hcd)
+static void xhci_rcar_start(struct usb_hcd *hcd)
 {
 	u32 temp;
 
@@ -203,7 +208,7 @@ static bool xhci_rcar_wait_for_pll_active(struct usb_hcd *hcd)
 }
 
 /* This function needs to initialize a "phy" of usb before */
-int xhci_rcar_init_quirk(struct usb_hcd *hcd)
+static int xhci_rcar_init_quirk(struct usb_hcd *hcd)
 {
 	/* If hcd->regs is NULL, we don't just call the following function */
 	if (!hcd->regs)
@@ -215,7 +220,7 @@ int xhci_rcar_init_quirk(struct usb_hcd *hcd)
 	return xhci_rcar_download_firmware(hcd);
 }
 
-int xhci_rcar_resume_quirk(struct usb_hcd *hcd)
+static int xhci_rcar_resume_quirk(struct usb_hcd *hcd)
 {
 	int ret;
 
@@ -225,3 +230,92 @@ int xhci_rcar_resume_quirk(struct usb_hcd *hcd)
 
 	return ret;
 }
+
+/*
+ * On R-Car Gen2 and Gen3, the AC64 bit (bit 0) of HCCPARAMS1 is set
+ * to 1. However, these SoCs don't support 64-bit address memory
+ * pointers. So, this driver clears the AC64 bit of xhci->hcc_params
+ * to call dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) in
+ * xhci_gen_setup() by using the XHCI_NO_64BIT_SUPPORT quirk.
+ *
+ * And, since the firmware/internal CPU control the USBSTS.STS_HALT
+ * and the process speed is down when the roothub port enters U3,
+ * long delay for the handshake of STS_HALT is neeed in xhci_suspend()
+ * by using the XHCI_SLOW_SUSPEND quirk.
+ */
+#define SET_XHCI_PLAT_PRIV_FOR_RCAR(firmware)				\
+	.firmware_name = firmware,					\
+	.quirks = XHCI_NO_64BIT_SUPPORT | XHCI_TRUST_TX_LENGTH |	\
+		  XHCI_SLOW_SUSPEND,					\
+	.init_quirk = xhci_rcar_init_quirk,				\
+	.plat_start = xhci_rcar_start,					\
+	.resume_quirk = xhci_rcar_resume_quirk,
+
+static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
+	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V1)
+};
+
+static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
+	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
+};
+
+static const struct xhci_plat_priv xhci_plat_renesas_rzv2m = {
+	.quirks = XHCI_NO_64BIT_SUPPORT | XHCI_TRUST_TX_LENGTH |
+		  XHCI_SLOW_SUSPEND,
+	.init_quirk = xhci_rzv2m_init_quirk,
+	.plat_start = xhci_rzv2m_start,
+};
+
+static const struct of_device_id usb_xhci_of_match[] = {
+	{
+		.compatible = "renesas,xhci-r8a7790",
+		.data = &xhci_plat_renesas_rcar_gen2,
+	}, {
+		.compatible = "renesas,xhci-r8a7791",
+		.data = &xhci_plat_renesas_rcar_gen2,
+	}, {
+		.compatible = "renesas,xhci-r8a7793",
+		.data = &xhci_plat_renesas_rcar_gen2,
+	}, {
+		.compatible = "renesas,xhci-r8a7795",
+		.data = &xhci_plat_renesas_rcar_gen3,
+	}, {
+		.compatible = "renesas,xhci-r8a7796",
+		.data = &xhci_plat_renesas_rcar_gen3,
+	}, {
+		.compatible = "renesas,rcar-gen2-xhci",
+		.data = &xhci_plat_renesas_rcar_gen2,
+	}, {
+		.compatible = "renesas,rcar-gen3-xhci",
+		.data = &xhci_plat_renesas_rcar_gen3,
+	}, {
+		.compatible = "renesas,rzv2m-xhci",
+		.data = &xhci_plat_renesas_rzv2m,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
+
+static int xhci_renesas_probe(struct platform_device *pdev)
+{
+	const struct xhci_plat_priv *priv_match;
+
+	priv_match = of_device_get_match_data(&pdev->dev);
+
+	return xhci_plat_probe(pdev, NULL, priv_match);
+}
+
+static struct platform_driver usb_xhci_renesas_driver = {
+	.probe	= xhci_renesas_probe,
+	.remove	= xhci_plat_remove,
+	.shutdown = usb_hcd_platform_shutdown,
+	.driver	= {
+		.name = "xhci-renesas-hcd",
+		.pm = &xhci_plat_pm_ops,
+		.of_match_table = of_match_ptr(usb_xhci_of_match),
+	},
+};
+module_platform_driver(usb_xhci_renesas_driver);
+
+MODULE_DESCRIPTION("xHCI Platform Host Controller Driver for Renesas R-Car and RZ");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/host/xhci-rcar.h b/drivers/usb/host/xhci-rcar.h
deleted file mode 100644
index 048ad3b8a6c7..000000000000
--- a/drivers/usb/host/xhci-rcar.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * drivers/usb/host/xhci-rcar.h
- *
- * Copyright (C) 2014 Renesas Electronics Corporation
- */
-
-#ifndef _XHCI_RCAR_H
-#define _XHCI_RCAR_H
-
-#define XHCI_RCAR_FIRMWARE_NAME_V1	"r8a779x_usb3_v1.dlmem"
-#define XHCI_RCAR_FIRMWARE_NAME_V2	"r8a779x_usb3_v2.dlmem"
-#define XHCI_RCAR_FIRMWARE_NAME_V3	"r8a779x_usb3_v3.dlmem"
-
-#if IS_ENABLED(CONFIG_USB_XHCI_RCAR)
-void xhci_rcar_start(struct usb_hcd *hcd);
-int xhci_rcar_init_quirk(struct usb_hcd *hcd);
-int xhci_rcar_resume_quirk(struct usb_hcd *hcd);
-#else
-static inline void xhci_rcar_start(struct usb_hcd *hcd)
-{
-}
-
-static inline int xhci_rcar_init_quirk(struct usb_hcd *hcd)
-{
-	return 0;
-}
-
-static inline int xhci_rcar_resume_quirk(struct usb_hcd *hcd)
-{
-	return 0;
-}
-#endif
-
-/*
- * On R-Car Gen2 and Gen3, the AC64 bit (bit 0) of HCCPARAMS1 is set
- * to 1. However, these SoCs don't support 64-bit address memory
- * pointers. So, this driver clears the AC64 bit of xhci->hcc_params
- * to call dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) in
- * xhci_gen_setup() by using the XHCI_NO_64BIT_SUPPORT quirk.
- *
- * And, since the firmware/internal CPU control the USBSTS.STS_HALT
- * and the process speed is down when the roothub port enters U3,
- * long delay for the handshake of STS_HALT is neeed in xhci_suspend()
- * by using the XHCI_SLOW_SUSPEND quirk.
- */
-#define SET_XHCI_PLAT_PRIV_FOR_RCAR(firmware)				\
-	.firmware_name = firmware,					\
-	.quirks = XHCI_NO_64BIT_SUPPORT | XHCI_TRUST_TX_LENGTH |	\
-		  XHCI_SLOW_SUSPEND,					\
-	.init_quirk = xhci_rcar_init_quirk,				\
-	.plat_start = xhci_rcar_start,					\
-	.resume_quirk = xhci_rcar_resume_quirk,
-
-#endif /* _XHCI_RCAR_H */
-- 
2.39.0

