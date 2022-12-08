Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC748646EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLHLkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiLHLkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:40:08 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA169325;
        Thu,  8 Dec 2022 03:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670499607; x=1702035607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SXgXKN1INOLiOr03fMta7P4w+3K6ZAXMlIImpfrLuB8=;
  b=CnNaHB/v8Wnzm02PRypDoQbP1VxO9CUy7aRozuJEIbAKiG8hANSB48Y4
   Lm/pJiWnjIFZRfkVgAJ2U4bI8NfarX22OodwlJaxzDuyDs8CpPxYzvcTb
   V3IInepo5Fx+C3kVT31/6blPz3ua0R8166S2tWHOeA7EigU8FXgxOjnRd
   BofnUD4gTPIpRFhbdqw/Cr7OMBFNDgWJM5WBTRZicaBaJEok9JgORLr9K
   i/s8WsNcwaBdiU49ICAmQAwRAo8wvP+QjwOVR0gBk5s6NDmC5rsGV2ltx
   0WfUWZ8nGv1iai1eOSewEzww7+FEhNM5Ao/OC8ZHS61zrsUEfJKgRxSOO
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="127111681"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2022 04:40:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Dec 2022 04:40:04 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 8 Dec 2022 04:40:02 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] memory: atmel-sdramc: remove the driver
Date:   Thu, 8 Dec 2022 13:45:14 +0200
Message-ID: <20221208114515.35179-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221208114515.35179-1-claudiu.beznea@microchip.com>
References: <20221208114515.35179-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver does only clock request + enable for DDR clocks. DDR clocks are
enabled by bootloader and need to stay that way in Linux. To avoid having
these clocks disabled by clock subsystem in case there are no Linux
consumers for them the clocks were marked as critical in clock drivers.
With this, there is no need to have a separate driver that only does
clock request + enable.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/memory/Makefile       |  1 -
 drivers/memory/atmel-sdramc.c | 76 -----------------------------------
 2 files changed, 77 deletions(-)
 delete mode 100644 drivers/memory/atmel-sdramc.c

diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index e148f636c082..d1836be010ec 100644
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
index 9c49d00c2a96..000000000000
--- a/drivers/memory/atmel-sdramc.c
+++ /dev/null
@@ -1,76 +0,0 @@
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
-		clk = devm_clk_get(&pdev->dev, "ddrck");
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-		clk_prepare_enable(clk);
-	}
-
-	if (caps->has_mpddr_clk) {
-		clk = devm_clk_get(&pdev->dev, "mpddr");
-		if (IS_ERR(clk)) {
-			pr_err("AT91 RAMC: couldn't get mpddr clock\n");
-			return PTR_ERR(clk);
-		}
-		clk_prepare_enable(clk);
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

