Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E457382E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjFUL43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjFUL4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:56:20 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2DF1731;
        Wed, 21 Jun 2023 04:56:16 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L9T89i026287;
        Wed, 21 Jun 2023 13:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=lQTcJI2yH3aZLIvv+1GOSfF0PqFT/I/N8lRqjd5MfH0=;
 b=eBTeRDcfs5GmlMiTco4J2o5ZVQhAGJwoxXPFx0xUmUKzuu0CYM8ZSLfB32Fv90y8go1B
 DK3B9MR7vkxMcO4g/BM2Ud4z7dCQtKP+QURvUPRkyhcKvZOkMcqOVJ6XuGF4oSHVGXXI
 Uj7MbvLy5lwyZk/PedtUCCY0LGtVC753WhADysZ+qayiEi6pyTutpDtgfsjO2vaInSW4
 EmvI9E4hEf2ck4r+Ab0YXQLRMmX6kXEumFXTPH97sYbW7M5jVjfgEgq9lBw56FI0wJ08
 kOp0KXBm6eIpIojoBJv1vD3W/Dl5nELY+YxHOr9WbwepyI9qn+uNvIYo+sRPYt/hIDMS /w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rbxm3rygm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:55:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DADA810006A;
        Wed, 21 Jun 2023 13:55:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CE9F6237D9A;
        Wed, 21 Jun 2023 13:55:54 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 21 Jun
 2023 13:55:54 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH 1/2] spi: stm32: disable device mode with st,stm32f4-spi compatible
Date:   Wed, 21 Jun 2023 13:55:22 +0200
Message-ID: <20230621115523.923176-2-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621115523.923176-1-valentin.caron@foss.st.com>
References: <20230621115523.923176-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 SPI driver is not capable to handle device mode with stm32f4/f7 soc.
Stop probing if this case happens.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/spi/spi-stm32.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 6d10fa4ab783..f71712af43d4 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -238,6 +238,7 @@ struct stm32_spi;
  * @baud_rate_div_min: minimum baud rate divisor
  * @baud_rate_div_max: maximum baud rate divisor
  * @has_fifo: boolean to know if fifo is used for driver
+ * @has_device_mode: is this compatible capable to switch on device mode
  * @flags: compatible specific SPI controller flags used at registration time
  */
 struct stm32_spi_cfg {
@@ -259,6 +260,7 @@ struct stm32_spi_cfg {
 	unsigned int baud_rate_div_min;
 	unsigned int baud_rate_div_max;
 	bool has_fifo;
+	bool has_device_mode;
 	u16 flags;
 };
 
@@ -1750,6 +1752,7 @@ static const struct stm32_spi_cfg stm32f4_spi_cfg = {
 	.baud_rate_div_min = STM32F4_SPI_BR_DIV_MIN,
 	.baud_rate_div_max = STM32F4_SPI_BR_DIV_MAX,
 	.has_fifo = false,
+	.has_device_mode = false,
 	.flags = SPI_MASTER_MUST_TX,
 };
 
@@ -1774,6 +1777,7 @@ static const struct stm32_spi_cfg stm32h7_spi_cfg = {
 	.baud_rate_div_min = STM32H7_SPI_MBR_DIV_MIN,
 	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,
 	.has_fifo = true,
+	.has_device_mode = true,
 };
 
 static const struct of_device_id stm32_spi_of_match[] = {
@@ -1798,8 +1802,15 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	bool device_mode;
 	int ret;
+	const struct of_device_id *of_match =
+		of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
+	const struct stm32_spi_cfg *cfg = (const struct stm32_spi_cfg *)of_match->data;
 
 	device_mode = of_property_read_bool(np, "spi-slave");
+	if (!cfg->has_device_mode && device_mode) {
+		dev_err(&pdev->dev, "spi-slave not yet supported with %s\n", of_match->compatible);
+		return -EPERM;
+	}
 
 	if (device_mode)
 		ctrl = devm_spi_alloc_slave(&pdev->dev, sizeof(struct stm32_spi));
@@ -1817,9 +1828,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	spi->device_mode = device_mode;
 	spin_lock_init(&spi->lock);
 
-	spi->cfg = (const struct stm32_spi_cfg *)
-		of_match_device(pdev->dev.driver->of_match_table,
-				&pdev->dev)->data;
+	spi->cfg = cfg;
 
 	spi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(spi->base))
-- 
2.25.1

