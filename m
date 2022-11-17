Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D2862D889
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiKQKyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiKQKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:53:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D942E5ADE2;
        Thu, 17 Nov 2022 02:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668682390; x=1700218390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IV3iY/5nH2v6r5LMDzPfNG3LT1Nn/MAxR36s7csPy5k=;
  b=U9kX07y6nRcNudQwmHcO4ZBs1IB8awZk2TdS44EIWq32WbLdjGt0we0/
   0UMb/QjkbrCkk7T4ByizojGgYFdEGl+DygYDHu8RsChRhXIvkiaz5SZGc
   RZ1IMN9o+xfXORuhUNgmA8wjuOZ4RIc1mzrN/jslijHdcTVX+2Y2hsQy5
   +zceDMnnPqWE2HXZOcZW2ASBAnKepI/BPB8kNqk6zUzQJ+7ksY6KQfebq
   q7Q6Nr3luWoo3MSJ7iNWcnM9D2SQ4PqnqBMR6ITKU6ss304cy+D6UeA+1
   TllPLZ1t8M2fKG6NWHnZq16qLm10nqaMUaed6nQuWhNi9NP97nEXoPVjF
   A==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="183965627"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 03:53:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 03:53:05 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 03:53:02 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 4/8] spi: atmel-quadspi: Add support for configuring CS timing
Date:   Thu, 17 Nov 2022 12:52:45 +0200
Message-ID: <20221117105249.115649-5-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117105249.115649-1-tudor.ambarus@microchip.com>
References: <20221117105249.115649-1-tudor.ambarus@microchip.com>
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

The at91 QSPI IP uses a default value of half of the period of the QSPI
clock period for the cs-setup time, which is not always enough, an example
being the sst26vf064b SPI NOR flash which requires a minimum cs-setup time
of 5 ns. It was observed that none of the at91 SoCs can fulfill the
minimum CS setup time for the aforementioned flash, as they operate at
high frequencies and half a period does not suffice for the required CS
setup time. Add support for configuring the CS timing in the controller.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 976a217e356d..70637e46290a 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -510,6 +510,39 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static int atmel_qspi_set_cs_timing(struct spi_device *spi)
+{
+	struct spi_controller *ctrl = spi->master;
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
+	unsigned long clk_rate;
+	u32 cs_setup;
+	int delay;
+	int ret;
+
+	delay = spi_delay_to_ns(&spi->cs_setup, NULL);
+	if (delay <= 0)
+		return delay;
+
+	clk_rate = clk_get_rate(aq->pclk);
+	if (!clk_rate)
+		return -EINVAL;
+
+	cs_setup = DIV_ROUND_UP((delay * DIV_ROUND_UP(clk_rate, 1000000)),
+				1000);
+
+	ret = pm_runtime_resume_and_get(ctrl->dev.parent);
+	if (ret < 0)
+		return ret;
+
+	aq->scr |= QSPI_SCR_DLYBS(cs_setup);
+	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
+
+	pm_runtime_mark_last_busy(ctrl->dev.parent);
+	pm_runtime_put_autosuspend(ctrl->dev.parent);
+
+	return 0;
+}
+
 static void atmel_qspi_init(struct atmel_qspi *aq)
 {
 	/* Reset the QSPI controller */
@@ -555,6 +588,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
 	ctrl->setup = atmel_qspi_setup;
+	ctrl->set_cs_timing = atmel_qspi_set_cs_timing;
 	ctrl->bus_num = -1;
 	ctrl->mem_ops = &atmel_qspi_mem_ops;
 	ctrl->num_chipselect = 1;
-- 
2.25.1

