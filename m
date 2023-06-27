Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B917C73FC16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjF0Mjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjF0Mji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:39:38 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F9CDD;
        Tue, 27 Jun 2023 05:39:37 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R9hmpI017215;
        Tue, 27 Jun 2023 14:39:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=++8nkaCbYJRjEk4/xiM70BALnWisNUyizeXBtAiu6ZU=;
 b=ZBs/gkJU3kseVP2hyxMcy9ho8eiK/BwsxzMidexTqX+SjniqYuP1R/j/JUpUGincMNJo
 CX6rpoPkruwDq5cbEAzlZcnJssLFj+Xvk+ZhVL/l2gHPDXIWfo4NXZx4ewiTCylv2IfT
 pz9XnwyqfHFQrG1lXnZ3k61z6HNgSU2tOF063vzPjw3Z9qI7kTiW5HUw7Zb9LlGTPK1F
 g3DwRXjkA1hmrDaAK+Zdiwym83DaRdTZjHU2naj0eXamzacUPpD6lmajHicZgz2KHbJh
 noS+wPnPDgM02AHy+kZRZY15jYPHe2jY6pjdkK9QVjvMxInrXAR+WIWyhBSSMejndhjM jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rfu65ach1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 14:39:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D8CD4100057;
        Tue, 27 Jun 2023 14:39:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 07013231514;
        Tue, 27 Jun 2023 14:39:13 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 27 Jun
 2023 14:39:12 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2] spi: stm32: disable device mode with st,stm32f4-spi compatible
Date:   Tue, 27 Jun 2023 14:39:06 +0200
Message-ID: <20230627123906.147029-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_08,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 SPI driver is not capable to handle device mode with stm32f4 soc.
Stop probing if this case happens, and print an error with involved
compatible.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
Changes since v1:
- Replace of_match_device()->data by of_device_get_match_data()

 drivers/spi/spi-stm32.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 6d10fa4ab783..0de56441f72e 100644
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
@@ -1798,8 +1802,16 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	bool device_mode;
 	int ret;
+	const char *compatible =
+		of_match_device(pdev->dev.driver->of_match_table, &pdev->dev)->compatible;
+	const struct stm32_spi_cfg *cfg = (const struct stm32_spi_cfg *)
+		of_device_get_match_data(&pdev->dev);
 
 	device_mode = of_property_read_bool(np, "spi-slave");
+	if (!cfg->has_device_mode && device_mode) {
+		dev_err(&pdev->dev, "spi-slave not yet supported with %s\n", compatible);
+		return -EPERM;
+	}
 
 	if (device_mode)
 		ctrl = devm_spi_alloc_slave(&pdev->dev, sizeof(struct stm32_spi));
@@ -1817,9 +1829,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
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

