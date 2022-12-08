Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F279A646ECA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLHLkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLHLkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:40:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453469312;
        Thu,  8 Dec 2022 03:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670499608; x=1702035608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2AhuNuw0hhvvoHkPSD7i53bD4Fb2nu00CbdeKoWjDE=;
  b=UJtw0GpVBZ0lF89aLO8XpuiYkNhUj/GBtviPQyP8bCOfy2bCpsbqXcQC
   a7kWP8JwGtGgqsIPhQ1R820K/0jVtgK0/q7o+yNnGR1z3HbDW/vg67rwr
   pCAWKN8cIkGaW7KX4Cmf++0MXjdZNHHZSg/FY4U0vnUuWFcge1ix50y6k
   ZSDBLp96kVzBbdmtYG68gsQW+0u15DPXFhXf6auuD8yNTTprLbko4sfv3
   1zT7FRKgTZQzFWyQZ5LLN6VS+zlrxXxGglRkN5t7vJmiteh5F9DhPh5oN
   SUMDbc6K3Im6vPyUS0IRQ+7xkDoe7BTz9wMHUF9vxf4JO2JpCOdfulahk
   A==;
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="127111689"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2022 04:40:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Dec 2022 04:40:07 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 8 Dec 2022 04:40:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] clk: at91: do not compile dt-compat.c for sama7g5 and sam9x60
Date:   Thu, 8 Dec 2022 13:45:15 +0200
Message-ID: <20221208114515.35179-4-claudiu.beznea@microchip.com>
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

There is no need to have dt-compat.c compiled for SAMA7G5 and SAM9X60
as there is no in kernel device tree that could use it. Thus avoid
compiling dt-compat.c for them.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 79301e1c1c36..89061b85e7d2 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -3,7 +3,7 @@
 # Makefile for at91 specific clk
 #
 
-obj-y += pmc.o sckc.o dt-compat.o
+obj-y += pmc.o sckc.o
 obj-y += clk-slow.o clk-main.o clk-pll.o clk-plldiv.o clk-master.o
 obj-y += clk-system.o clk-peripheral.o clk-programmable.o
 
@@ -15,12 +15,12 @@ obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
 obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
 obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
 obj-$(CONFIG_HAVE_AT91_SAM9X60_PLL)	+= clk-sam9x60-pll.o
-obj-$(CONFIG_SOC_AT91RM9200) += at91rm9200.o
-obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o at91sam9rl.o at91sam9x5.o
-obj-$(CONFIG_SOC_AT91SAM9) += at91sam9g45.o
-obj-$(CONFIG_SOC_AT91SAM9) += at91sam9n12.o at91sam9x5.o
+obj-$(CONFIG_SOC_AT91RM9200) += at91rm9200.o dt-compat.o
+obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o at91sam9rl.o at91sam9x5.o dt-compat.o
+obj-$(CONFIG_SOC_AT91SAM9) += at91sam9g45.o dt-compat.o
+obj-$(CONFIG_SOC_AT91SAM9) += at91sam9n12.o at91sam9x5.o dt-compat.o
 obj-$(CONFIG_SOC_SAM9X60) += sam9x60.o
-obj-$(CONFIG_SOC_SAMA5D3) += sama5d3.o
-obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o
-obj-$(CONFIG_SOC_SAMA5D2) += sama5d2.o
+obj-$(CONFIG_SOC_SAMA5D3) += sama5d3.o dt-compat.o
+obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o dt-compat.o
+obj-$(CONFIG_SOC_SAMA5D2) += sama5d2.o dt-compat.o
 obj-$(CONFIG_SOC_SAMA7G5) += sama7g5.o
-- 
2.34.1

