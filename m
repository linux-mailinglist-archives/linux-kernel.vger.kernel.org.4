Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F00734E52
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFSIqL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jun 2023 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjFSIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:45:46 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575CB1991;
        Mon, 19 Jun 2023 01:44:05 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D8A338485;
        Mon, 19 Jun 2023 16:35:19 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 16:35:19 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Mon, 19 Jun 2023 16:35:19 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v3 2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
Date:   Mon, 19 Jun 2023 16:35:16 +0800
Message-ID: <20230619083517.415597-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619083517.415597-1-william.qiu@starfivetech.com>
References: <20230619083517.415597-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306022017.UbwjjWRN-lkp@intel.com/
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202306040644.6ZHs55x4-lkp@intel.com/
---
 drivers/spi/spi-cadence-quadspi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 6ddb2dfc0f00..8774f9aaff61 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -63,6 +63,8 @@ struct cqspi_st {
 	struct platform_device	*pdev;
 	struct spi_master	*master;
 	struct clk		*clk;
+	struct clk_bulk_data	*clks;
+	int			num_clks;
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

