Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A93774AA4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjGGFRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjGGFRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:17:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490711FF5;
        Thu,  6 Jul 2023 22:17:26 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367425Sj021861;
        Fri, 7 Jul 2023 05:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Q8cQRa/rgqutN38FfVOHsY0BTjw+Ml/nme9A3W3iGP4=;
 b=SICCtSMgbigGTzaKtH1ORfeGvM1wJUwwviAs5lLwnJbXxwabZ6UxD6Ab5UQQnYZ4+j1i
 LrMe201rM/38M+fDRSn2uLuJsSLR+JOqUaOh84ySRm1gpvqtTAJK2AR+nja3KEMt90Xa
 0GuhAhVCyMgq7xxpma3VaAnQG0PnZ+TfqJ1PcQ8JBI/5sg0pZJqsXq1M7FhL00tKuMCq
 J3UQTdQJRJXqV24Cy9x9xVE/vriwIaNUPlIDg4iXz5tx5FOP4ehwStPLerWinmXDGLMd
 229rSDR6Nf5d5lKNy3XC5YjdgfNoV4MRLlx3PzPuP5cFYn2Esw8OHz75pXCYSQI38/cK Cg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rntctt5n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 05:17:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3675HLOE018053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 05:17:21 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 22:17:18 -0700
From:   Praveen Talari <quic_ptalari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH v5 2/2] spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3
Date:   Fri, 7 Jul 2023 10:46:36 +0530
Message-ID: <20230707051636.5301-3-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230707051636.5301-1-quic_ptalari@quicinc.com>
References: <20230707051636.5301-1-quic_ptalari@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k2JPrqspKqdxIPD3z6UEl4OJqYYDGf-n
X-Proofpoint-ORIG-GUID: k2JPrqspKqdxIPD3z6UEl4OJqYYDGf-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_17,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070048
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently spi geni driver supports only master mode operation.

Add spi device mode support to GENI based QuPv3.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
v4 -> v5:
- added code comments
- dropped get_spi_master api.

v3 -> v4:
- Used existing property spi-slave.

v2 -> v3:
- modified commit message to use device mode instead of slave mode

v1 -> v2
- modified the commit message
- added the code changes for code comments
---
 drivers/spi/spi-geni-qcom.c | 53 ++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 206cc04bb1ed..06b114f3f21a 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/soc/qcom/geni-se.h>
 #include <linux/spi/spi.h>
 #include <linux/spinlock.h>
@@ -52,6 +53,9 @@
 #define SPI_CS_CLK_DELAY_MSK		GENMASK(19, 10)
 #define SPI_CS_CLK_DELAY_SHFT		10
 
+#define SE_SPI_SLAVE_EN				(0x2BC)
+#define SPI_SLAVE_EN				BIT(0)
+
 /* M_CMD OP codes for SPI */
 #define SPI_TX_ONLY		1
 #define SPI_RX_ONLY		2
@@ -99,6 +103,16 @@ struct spi_geni_master {
 	int cur_xfer_mode;
 };
 
+static void spi_slv_setup(struct spi_geni_master *mas)
+{
+	struct geni_se *se = &mas->se;
+
+	writel(SPI_SLAVE_EN, se->base + SE_SPI_SLAVE_EN);
+	writel(GENI_IO_MUX_0_EN, se->base + GENI_OUTPUT_CTRL);
+	writel(START_TRIGGER, se->base + SE_GENI_CFG_SEQ_START);
+	dev_dbg(mas->dev, "spi slave setup done\n");
+}
+
 static int get_spi_clk_cfg(unsigned int speed_hz,
 			struct spi_geni_master *mas,
 			unsigned int *clk_idx,
@@ -140,12 +154,22 @@ static void handle_se_timeout(struct spi_master *spi,
 	const struct spi_transfer *xfer;
 
 	spin_lock_irq(&mas->lock);
-	reinit_completion(&mas->cancel_done);
 	if (mas->cur_xfer_mode == GENI_SE_FIFO)
 		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
 
 	xfer = mas->cur_xfer;
 	mas->cur_xfer = NULL;
+
+	if (spi->slave) {
+		/*
+		 * skip CMD Cancel sequnece since spi slave
+		 * doesn`t support CMD Cancel sequnece
+		 */
+		spin_unlock_irq(&mas->lock);
+		goto unmap_if_dma;
+	}
+
+	reinit_completion(&mas->cancel_done);
 	geni_se_cancel_m_cmd(se);
 	spin_unlock_irq(&mas->lock);
 
@@ -542,6 +566,10 @@ static bool geni_can_dma(struct spi_controller *ctlr,
 	if (mas->cur_xfer_mode == GENI_GPI_DMA)
 		return true;
 
+	/* Set SE DMA mode for SPI slave. */
+	if (ctlr->slave)
+		return true;
+
 	len = get_xfer_len_in_words(xfer, mas);
 	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
 
@@ -619,6 +647,7 @@ static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
 
 static int spi_geni_init(struct spi_geni_master *mas)
 {
+	struct spi_master *spi = dev_get_drvdata(mas->dev);
 	struct geni_se *se = &mas->se;
 	unsigned int proto, major, minor, ver;
 	u32 spi_tx_cfg, fifo_disable;
@@ -627,7 +656,14 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	pm_runtime_get_sync(mas->dev);
 
 	proto = geni_se_read_proto(se);
-	if (proto != GENI_SE_SPI) {
+
+	if (spi->slave) {
+		if (proto != GENI_SE_SPI_SLAVE) {
+			dev_err(mas->dev, "Invalid proto %d\n", proto);
+			goto out_pm;
+		}
+		spi_slv_setup(mas);
+	} else if (proto != GENI_SE_SPI) {
 		dev_err(mas->dev, "Invalid proto %d\n", proto);
 		goto out_pm;
 	}
@@ -677,9 +713,11 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	}
 
 	/* We always control CS manually */
-	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
-	spi_tx_cfg &= ~CS_TOGGLE;
-	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
+	if (!spi->slave) {
+		spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
+		spi_tx_cfg &= ~CS_TOGGLE;
+		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
+	}
 
 out_pm:
 	pm_runtime_put(mas->dev);
@@ -1072,6 +1110,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
 	pm_runtime_enable(dev);
 
+	if (device_property_read_bool(&pdev->dev, "spi-slave"))
+		spi->slave = true;
+
 	ret = geni_icc_get(&mas->se, NULL);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
@@ -1092,7 +1133,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	 * for dma (gsi) mode, the gsi will set cs based on params passed in
 	 * TRE
 	 */
-	if (mas->cur_xfer_mode == GENI_SE_FIFO)
+	if (!spi->slave && mas->cur_xfer_mode == GENI_SE_FIFO)
 		spi->set_cs = spi_geni_set_cs;
 
 	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
-- 
2.17.1

