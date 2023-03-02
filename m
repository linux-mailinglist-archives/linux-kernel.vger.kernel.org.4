Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EEE6A8054
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCBKwc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Mar 2023 05:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCBKw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:52:29 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3937930197;
        Thu,  2 Mar 2023 02:52:26 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 052EA24E3E0;
        Thu,  2 Mar 2023 18:52:24 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 2 Mar
 2023 18:52:23 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 2 Mar 2023 18:52:23 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        William Qiu <william.qiu@starfivetech.com>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH v1 2/2] spi: cadence-quadspi: Add support for StarFive JH7110 QSPI
Date:   Thu, 2 Mar 2023 18:52:21 +0800
Message-ID: <20230302105221.197421-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302105221.197421-1-william.qiu@starfivetech.com>
References: <20230302105221.197421-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QSPI reset operation in device probe and add RISCV support to
QUAD SPI Kconfig.

Co-developed-by: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 drivers/spi/Kconfig               |  2 +-
 drivers/spi/spi-cadence-quadspi.c | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3b1c0878bb85..c64edea53af6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -230,7 +230,7 @@ config SPI_CADENCE
 
 config SPI_CADENCE_QUADSPI
 	tristate "Cadence Quad SPI controller"
-	depends on OF && (ARM || ARM64 || X86 || COMPILE_TEST)
+	depends on OF && (ARM || ARM64 || X86 || RISCV || COMPILE_TEST)
 	help
 	  Enable support for the Cadence Quad SPI Flash controller.
 
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 676313e1bdad..d9795e108ec5 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1583,7 +1583,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 static int cqspi_probe(struct platform_device *pdev)
 {
 	const struct cqspi_driver_platdata *ddata;
-	struct reset_control *rstc, *rstc_ocp;
+	struct reset_control *rstc, *rstc_ocp, *rstc_ref;
 	struct device *dev = &pdev->dev;
 	struct spi_master *master;
 	struct resource *res_ahb;
@@ -1673,6 +1673,17 @@ static int cqspi_probe(struct platform_device *pdev)
 		goto probe_reset_failed;
 	}
 
+	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi")) {
+		rstc_ref = devm_reset_control_get_optional_exclusive(dev, "rstc_ref");
+		if (IS_ERR(rstc_ref)) {
+			ret = PTR_ERR(rstc_ref);
+			dev_err(dev, "Cannot get QSPI REF reset.\n");
+			goto probe_reset_failed;
+		}
+		reset_control_assert(rstc_ref);
+		reset_control_deassert(rstc_ref);
+	}
+
 	reset_control_assert(rstc);
 	reset_control_deassert(rstc);
 
@@ -1825,6 +1836,10 @@ static const struct cqspi_driver_platdata versal_ospi = {
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
 
+static const struct cqspi_driver_platdata jh7110_qspi = {
+	.quirks = CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1850,6 +1865,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "intel,socfpga-qspi",
 		.data = &socfpga_qspi,
 	},
+	{
+		.compatible = "starfive,jh7110-qspi",
+		.data = &jh7110_qspi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.34.1

