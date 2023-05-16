Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052DA70463F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjEPHYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjEPHYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:24:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A975926A0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684221852; x=1715757852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2F9Utu5YQDCEKLYx5u0CBx0KPHY2vCWKQxloUhX0fo4=;
  b=N+o2S+iYRZrA6VGJSEaVTIJbQJkmCUWQL5d6YK92GeE1OkDY1PFTFZx5
   31wRQ2MvfTKmzod6uJnXxkJQEdoy7YSInSesVCuGSXSQa+u17PasijJYb
   g0m3h53j6Tx4m0Bi1xtTaxvFszdmATkjXjg5bAiefFsacHZrNIPY2eWso
   4IIt2gUgo97q4TUOm6Uxl2h6DiuueEfdoql6STPe7DFONQ93KC1Vhhpje
   Cnrg66u3TLcXBTQ5IofL34bKpFOhjtfYlgUHFRnjI+EcbONhSncpyNNNK
   S0eJxinzWAWuB4qKhPZqQlumvpReVY6GfSoG2egvEHvp1I7Yc2/ASWQNi
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="scan'208";a="225500427"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 00:24:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 00:24:11 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 16 May 2023 00:24:09 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux@armlinux.org.uk>,
        <krzysztof.kozlowski@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] memory: atmel-sdramc: remove the driver
Date:   Tue, 16 May 2023 10:24:05 +0300
Message-ID: <20230516072405.2696225-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver does only clock request + enable for DDR clocks. DDR clocks are
enabled by bootloader and need to stay that way in Linux. To avoid having
these clocks disabled by clock subsystem in case there are no Linux
consumers for them the clocks were marked as critical in clock drivers
(in commit 68b3b6f1773d ("clk: at91: mark ddr clocks as critical")).
With this, there is no need to have a separate driver that only does
clock request + enable.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Changes in v2:
- remove ATMEL_SDRAMC references in Kconfigs
- the patch was initially part of this series:
  https://lore.kernel.org/all/20221208114515.35179-1-claudiu.beznea@microchip.com/

 arch/arm/mach-at91/Kconfig    |  4 --
 drivers/memory/Kconfig        | 11 ------
 drivers/memory/Makefile       |  1 -
 drivers/memory/atmel-sdramc.c | 74 -----------------------------------
 4 files changed, 90 deletions(-)
 delete mode 100644 drivers/memory/atmel-sdramc.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 3dd9e718661b..a8c022b4c053 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -97,7 +97,6 @@ config SOC_AT91SAM9
 	depends on ARCH_MULTI_V5
 	select ATMEL_AIC_IRQ
 	select ATMEL_PM if PM
-	select ATMEL_SDRAMC
 	select CPU_ARM926T
 	select HAVE_AT91_SMD
 	select HAVE_AT91_USB_CLK
@@ -131,7 +130,6 @@ config SOC_SAM9X60
 	depends on ARCH_MULTI_V5
 	select ATMEL_AIC5_IRQ
 	select ATMEL_PM if PM
-	select ATMEL_SDRAMC
 	select CPU_ARM926T
 	select HAVE_AT91_USB_CLK
 	select HAVE_AT91_GENERATED_CLK
@@ -213,7 +211,6 @@ config SOC_SAMA5
 	bool
 	select ATMEL_AIC5_IRQ
 	select ATMEL_PM if PM
-	select ATMEL_SDRAMC
 	select MEMORY
 	select SOC_SAM_V7
 	select SRAM if PM
@@ -234,7 +231,6 @@ config SOC_SAMA7
 	bool
 	select ARM_GIC
 	select ATMEL_PM if PM
-	select ATMEL_SDRAMC
 	select MEMORY
 	select SOC_SAM_V7
 	select SRAM if PM
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 91774e6ee624..8efdd1f97139 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -30,17 +30,6 @@ config ARM_PL172_MPMC
 	  If you have an embedded system with an AMBA bus and a PL172
 	  controller, say Y or M here.
 
-config ATMEL_SDRAMC
-	bool "Atmel (Multi-port DDR-)SDRAM Controller"
-	default y if ARCH_AT91
-	depends on ARCH_AT91 || COMPILE_TEST
-	depends on OF
-	help
-	  This driver is for Atmel SDRAM Controller or Atmel Multi-port
-	  DDR-SDRAM Controller available on Atmel AT91SAM9 and SAMA5 SoCs.
-	  Starting with the at91sam9g45, this controller supports SDR, DDR and
-	  LP-DDR memories.
-
 config ATMEL_EBI
 	bool "Atmel EBI driver"
 	default y if ARCH_AT91
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index ae14ded464a8..d2e6ca9abbe0 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -8,7 +8,6 @@ ifeq ($(CONFIG_DDR),y)
 obj-$(CONFIG_OF)		+= of_memory.o
 endif
 obj-$(CONFIG_ARM_PL172_MPMC)	+= pl172.o
-obj-$(CONFIG_ATMEL_SDRAMC)	+= atmel-sdramc.o
 obj-$(CONFIG_ATMEL_EBI)		+= atmel-ebi.o
 obj-$(CONFIG_BRCMSTB_DPFE)	+= brcmstb_dpfe.o
 obj-$(CONFIG_BRCMSTB_MEMC)	+= brcmstb_memc.o
diff --git a/drivers/memory/atmel-sdramc.c b/drivers/memory/atmel-sdramc.c
deleted file mode 100644
index ea6e9e1eaf04..000000000000
--- a/drivers/memory/atmel-sdramc.c
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Atmel (Multi-port DDR-)SDRAM Controller driver
- *
- * Author: Alexandre Belloni <alexandre.belloni@free-electrons.com>
- *
- * Copyright (C) 2014 Atmel
- */
-
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-
-struct at91_ramc_caps {
-	bool has_ddrck;
-	bool has_mpddr_clk;
-};
-
-static const struct at91_ramc_caps at91rm9200_caps = { };
-
-static const struct at91_ramc_caps at91sam9g45_caps = {
-	.has_ddrck = 1,
-	.has_mpddr_clk = 0,
-};
-
-static const struct at91_ramc_caps sama5d3_caps = {
-	.has_ddrck = 1,
-	.has_mpddr_clk = 1,
-};
-
-static const struct of_device_id atmel_ramc_of_match[] = {
-	{ .compatible = "atmel,at91rm9200-sdramc", .data = &at91rm9200_caps, },
-	{ .compatible = "atmel,at91sam9260-sdramc", .data = &at91rm9200_caps, },
-	{ .compatible = "atmel,at91sam9g45-ddramc", .data = &at91sam9g45_caps, },
-	{ .compatible = "atmel,sama5d3-ddramc", .data = &sama5d3_caps, },
-	{},
-};
-
-static int atmel_ramc_probe(struct platform_device *pdev)
-{
-	const struct at91_ramc_caps *caps;
-	struct clk *clk;
-
-	caps = of_device_get_match_data(&pdev->dev);
-
-	if (caps->has_ddrck) {
-		clk = devm_clk_get_enabled(&pdev->dev, "ddrck");
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-	}
-
-	if (caps->has_mpddr_clk) {
-		clk = devm_clk_get_enabled(&pdev->dev, "mpddr");
-		if (IS_ERR(clk)) {
-			pr_err("AT91 RAMC: couldn't get mpddr clock\n");
-			return PTR_ERR(clk);
-		}
-	}
-
-	return 0;
-}
-
-static struct platform_driver atmel_ramc_driver = {
-	.probe		= atmel_ramc_probe,
-	.driver		= {
-		.name	= "atmel-ramc",
-		.of_match_table = atmel_ramc_of_match,
-	},
-};
-
-builtin_platform_driver(atmel_ramc_driver);
-- 
2.34.1

