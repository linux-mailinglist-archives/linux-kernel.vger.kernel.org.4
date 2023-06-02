Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221D271FC8B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjFBIuD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jun 2023 04:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjFBIte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:49:34 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4131E51;
        Fri,  2 Jun 2023 01:49:31 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1F96424E276;
        Fri,  2 Jun 2023 16:49:29 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 2 Jun
 2023 16:49:29 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 2 Jun 2023 16:49:28 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v2 2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
Date:   Fri, 2 Jun 2023 16:49:24 +0800
Message-ID: <20230602084925.215411-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602084925.215411-1-william.qiu@starfivetech.com>
References: <20230602084925.215411-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QSPI clock operation in device probe.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/spi/spi-cadence-quadspi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 6ddb2dfc0f00..21788472c7fb 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -63,6 +63,8 @@ struct cqspi_st {
 	struct platform_device	*pdev;
 	struct spi_master	*master;
 	struct clk		*clk;
+	struct clk_bulk_data	*clks;
+	unsigned int		num_clks;
 	unsigned int		sclk;
 
 	void __iomem		*iobase;
@@ -1715,6 +1717,16 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi")) {
+		cqspi->num_clks = devm_clk_bulk_get_all(dev, &cqspi->clks);
+		if (cqspi->num_clks < 0) {
+			dev_err(dev, "Cannot claim clock: %u\n", cqspi->num_clks);
+			return -EINVAL;
+		}
+
+		ret = clk_bulk_prepare_enable(cqspi->num_clks, cqspi->clks);
+		if (ret)
+			dev_err(dev, "Cannot enable clock clks\n");
+
 		rstc_ref = devm_reset_control_get_optional_exclusive(dev, "rstc_ref");
 		if (IS_ERR(rstc_ref)) {
 			ret = PTR_ERR(rstc_ref);
@@ -1816,6 +1828,9 @@ static void cqspi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(cqspi->clk);
 
+	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi"))
+		clk_bulk_disable_unprepare(cqspi->num_clks, cqspi->clks);
+
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
@@ -1831,6 +1846,9 @@ static int cqspi_suspend(struct device *dev)
 
 	clk_disable_unprepare(cqspi->clk);
 
+	if (of_device_is_compatible(dev->of_node, "starfive,jh7110-qspi"))
+		clk_bulk_disable_unprepare(cqspi->num_clks, cqspi->clks);
+
 	return ret;
 }
 
@@ -1840,6 +1858,8 @@ static int cqspi_resume(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 
 	clk_prepare_enable(cqspi->clk);
+	if (of_device_is_compatible(dev->of_node, "starfive,jh7110-qspi"))
+		clk_bulk_prepare_enable(cqspi->num_clks, cqspi->clks);
 	cqspi_wait_idle(cqspi);
 	cqspi_controller_init(cqspi);
 
-- 
2.34.1

