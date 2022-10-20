Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E6C6065C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJTQ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJTQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:26:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1996E167F4C;
        Thu, 20 Oct 2022 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666283194; x=1697819194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tLH6McL/k+1AdtQX5dfk1xHgIg0bo2xOAuTSBmeqVyU=;
  b=OLkAyH1f1cy6f2e9pWrUH1vFOivoZSCeIV9GPgwADqxKnfVfocH6XS2q
   TEnSRBzFcRuUazMWcDv02lPHAVImez8m6DyJ6bGEAUCV4BycBOdeJIBSh
   2352f8MpSIksTicBDHfO5XOrBcFEBDkeyORhhwyEbSGpJxNiN4cIBpXmq
   TLWD8nAlqFv+5iMJmrlpY4U3ji4v7feWcuX6W5LtPSmIRdwaKYKSAJAug
   eu08rl/3ZDhhYzGYyK5LtjFxwvIopNYgNp7gFWmq4cz6MCysaxP+sDNqB
   pvHZrbQPOcoOrWyr4MV2ubwdWrtCZu/futpWluprunkGt9sUglj0Z5vy5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="393065809"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="393065809"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:26:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="663149970"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="663149970"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2022 09:26:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B78033F9; Thu, 20 Oct 2022 19:26:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 2/5] spi: pxa2xx: Remove no more needed PCI ID table
Date:   Thu, 20 Oct 2022 19:26:28 +0300
Message-Id: <20221020162631.68914-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020162631.68914-1-andriy.shevchenko@linux.intel.com>
References: <20221020162631.68914-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the PCI enumerated devices provide a property with SSP type,
there is no more necessity to bear the copy of the ID table here.
Remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 117 +--------------------------------------
 1 file changed, 2 insertions(+), 115 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 857732a54ca7..1d36d055a9d6 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -20,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
-#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -1335,121 +1334,17 @@ static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
 #endif
 
-/*
- * PCI IDs of compound devices that integrate both host controller and private
- * integrated DMA engine. Please note these are not used in module
- * autoloading and probing in this module but matching the LPSS SSP type.
- */
-static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
-	/* SPT-LP */
-	{ PCI_VDEVICE(INTEL, 0x9d29), LPSS_SPT_SSP },
-	{ PCI_VDEVICE(INTEL, 0x9d2a), LPSS_SPT_SSP },
-	/* SPT-H */
-	{ PCI_VDEVICE(INTEL, 0xa129), LPSS_SPT_SSP },
-	{ PCI_VDEVICE(INTEL, 0xa12a), LPSS_SPT_SSP },
-	/* KBL-H */
-	{ PCI_VDEVICE(INTEL, 0xa2a9), LPSS_SPT_SSP },
-	{ PCI_VDEVICE(INTEL, 0xa2aa), LPSS_SPT_SSP },
-	/* CML-V */
-	{ PCI_VDEVICE(INTEL, 0xa3a9), LPSS_SPT_SSP },
-	{ PCI_VDEVICE(INTEL, 0xa3aa), LPSS_SPT_SSP },
-	/* BXT A-Step */
-	{ PCI_VDEVICE(INTEL, 0x0ac2), LPSS_BXT_SSP },
-	{ PCI_VDEVICE(INTEL, 0x0ac4), LPSS_BXT_SSP },
-	{ PCI_VDEVICE(INTEL, 0x0ac6), LPSS_BXT_SSP },
-	/* BXT B-Step */
-	{ PCI_VDEVICE(INTEL, 0x1ac2), LPSS_BXT_SSP },
-	{ PCI_VDEVICE(INTEL, 0x1ac4), LPSS_BXT_SSP },
-	{ PCI_VDEVICE(INTEL, 0x1ac6), LPSS_BXT_SSP },
-	/* GLK */
-	{ PCI_VDEVICE(INTEL, 0x31c2), LPSS_BXT_SSP },
-	{ PCI_VDEVICE(INTEL, 0x31c4), LPSS_BXT_SSP },
-	{ PCI_VDEVICE(INTEL, 0x31c6), LPSS_BXT_SSP },
-	/* ICL-LP */
-	{ PCI_VDEVICE(INTEL, 0x34aa), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x34ab), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x34fb), LPSS_CNL_SSP },
-	/* EHL */
-	{ PCI_VDEVICE(INTEL, 0x4b2a), LPSS_BXT_SSP },
-	{ PCI_VDEVICE(INTEL, 0x4b2b), LPSS_BXT_SSP },
-	{ PCI_VDEVICE(INTEL, 0x4b37), LPSS_BXT_SSP },
-	/* JSL */
-	{ PCI_VDEVICE(INTEL, 0x4daa), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x4dab), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x4dfb), LPSS_CNL_SSP },
-	/* TGL-H */
-	{ PCI_VDEVICE(INTEL, 0x43aa), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x43ab), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x43fb), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x43fd), LPSS_CNL_SSP },
-	/* ADL-P */
-	{ PCI_VDEVICE(INTEL, 0x51aa), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x51ab), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x51fb), LPSS_CNL_SSP },
-	/* ADL-M */
-	{ PCI_VDEVICE(INTEL, 0x54aa), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x54ab), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x54fb), LPSS_CNL_SSP },
-	/* APL */
-	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
-	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
-	{ PCI_VDEVICE(INTEL, 0x5ac6), LPSS_BXT_SSP },
-	/* RPL-S */
-	{ PCI_VDEVICE(INTEL, 0x7a2a), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x7a2b), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x7a79), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x7a7b), LPSS_CNL_SSP },
-	/* ADL-S */
-	{ PCI_VDEVICE(INTEL, 0x7aaa), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x7aab), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x7af9), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x7afb), LPSS_CNL_SSP },
-	/* MTL-P */
-	{ PCI_VDEVICE(INTEL, 0x7e27), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x7e30), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x7e46), LPSS_CNL_SSP },
-	/* CNL-LP */
-	{ PCI_VDEVICE(INTEL, 0x9daa), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x9dab), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x9dfb), LPSS_CNL_SSP },
-	/* CNL-H */
-	{ PCI_VDEVICE(INTEL, 0xa32a), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0xa32b), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0xa37b), LPSS_CNL_SSP },
-	/* CML-LP */
-	{ PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
-	/* CML-H */
-	{ PCI_VDEVICE(INTEL, 0x06aa), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x06ab), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0x06fb), LPSS_CNL_SSP },
-	/* TGL-LP */
-	{ PCI_VDEVICE(INTEL, 0xa0aa), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0xa0ab), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0xa0de), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0xa0df), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0xa0fb), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0xa0fd), LPSS_CNL_SSP },
-	{ PCI_VDEVICE(INTEL, 0xa0fe), LPSS_CNL_SSP },
-	{ },
-};
-
 static const struct of_device_id pxa2xx_spi_of_match[] = {
 	{ .compatible = "marvell,mmp2-ssp", .data = (void *)MMP2_SSP },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
 
-#ifdef CONFIG_PCI
-
 static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
 {
 	return param == chan->device->dev;
 }
 
-#endif /* CONFIG_PCI */
-
 static struct pxa2xx_spi_controller *
 pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
@@ -1458,17 +1353,12 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct device *parent = dev->parent;
 	struct ssp_device *ssp;
 	struct resource *res;
-	struct pci_dev *pcidev = dev_is_pci(parent) ? to_pci_dev(parent) : NULL;
-	const struct pci_device_id *pcidev_id = NULL;
 	u32 value = SSP_UNDEFINED;
 	enum pxa_ssp_type type;
 	const void *match;
 	int status;
 	u64 uid;
 
-	if (pcidev)
-		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
-
 	/* Always try to read property */
 	device_property_read_u32(&pdev->dev, "intel,spi-pxa2xx-type", &value);
 
@@ -1477,8 +1367,6 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		type = (enum pxa_ssp_type)match;
 	else if (value > SSP_UNDEFINED && value < SSP_MAX)
 		type = (enum pxa_ssp_type)value;
-	else if (pcidev_id)
-		type = (enum pxa_ssp_type)pcidev_id->driver_data;
 	else
 		return ERR_PTR(-EINVAL);
 
@@ -1494,13 +1382,12 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
 	ssp->phys_base = res->start;
 
-#ifdef CONFIG_PCI
-	if (pcidev_id) {
+	/* Platforms with iDMA 64-bit */
+	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv")) {
 		pdata->tx_param = parent;
 		pdata->rx_param = parent;
 		pdata->dma_filter = pxa2xx_spi_idma_filter;
 	}
-#endif
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk))
-- 
2.35.1

