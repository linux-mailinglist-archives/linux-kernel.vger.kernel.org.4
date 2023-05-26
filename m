Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08D5711FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242182AbjEZGZv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 May 2023 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbjEZGZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:25:42 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E9413D;
        Thu, 25 May 2023 23:25:38 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4F5AC24E1BE;
        Fri, 26 May 2023 14:25:32 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 26 May
 2023 14:25:32 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 26 May 2023 14:25:31 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v1 2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
Date:   Fri, 26 May 2023 14:25:28 +0800
Message-ID: <20230526062529.46747-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526062529.46747-1-william.qiu@starfivetech.com>
References: <20230526062529.46747-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
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
 drivers/spi/spi-cadence-quadspi.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 6ddb2dfc0f00..c6430fb3a0a4 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1624,6 +1624,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 static int cqspi_probe(struct platform_device *pdev)
 {
 	const struct cqspi_driver_platdata *ddata;
+	struct clk *qspi_ahb, *qspi_apb;
 	struct reset_control *rstc, *rstc_ocp, *rstc_ref;
 	struct device *dev = &pdev->dev;
 	struct spi_master *master;
@@ -1715,6 +1716,32 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi")) {
+		qspi_ahb = devm_clk_get(dev, "qspi-ahb");
+		if (IS_ERR(qspi_ahb)) {
+			dev_err(dev, "Cannot claim QSPI_AHB clock.\n");
+			ret = PTR_ERR(qspi_ahb);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(qspi_ahb);
+		if (ret) {
+			dev_err(dev, "Cannot enable QSPI AHB clock.\n");
+			goto probe_clk_failed;
+		}
+
+		qspi_apb = devm_clk_get(dev, "qspi-apb");
+		if (IS_ERR(qspi_apb)) {
+			dev_err(dev, "Cannot claim QSPI_APB clock.\n");
+			ret = PTR_ERR(qspi_apb);
+			return ret;
+		}
+
+		ret = clk_prepare_enable(qspi_apb);
+		if (ret) {
+			dev_err(dev, "Cannot enable QSPI APB clock.\n");
+			goto probe_clk_failed;
+		}
+
 		rstc_ref = devm_reset_control_get_optional_exclusive(dev, "rstc_ref");
 		if (IS_ERR(rstc_ref)) {
 			ret = PTR_ERR(rstc_ref);
-- 
2.34.1

