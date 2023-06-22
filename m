Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2610B73A29C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjFVOCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjFVOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:01:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C711FC0;
        Thu, 22 Jun 2023 07:01:13 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M6CkvC005911;
        Thu, 22 Jun 2023 14:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=krYAhHgqrBoE5itHvSAn1Ixy1e0v7yZp9JXyVdeUkaM=;
 b=TRNV4ejgAAZvOeY8h+owGM5xcGHf9dPkenoV1yi/sUJiWN8J5OVx2Erkse3mXcEYnwmJ
 Ie78O+XYQgMAoyQEKUyyXUwa3ROVHUP8vYmGkAWygF+o1U5ozyIxgmxGef/feXWVjbBI
 pyvOb6UNULoYmWNiTcHtUQlwJJJpShRyXAtrjj/gbN4ACwodp9yrY1jcgBv4IGoC1Jmh
 zJWGvHVCYXoyd0r08j/litSHJyVFmIQ0nCzw9Wvr/pTrOMASp95SPmziLT/LQ1HGX25X
 q+/3Q522YQx+2MtofGCyLmToM7vYuJjDKPIHxWHYch3+rHxpSLdnMf5AhDgGj06a1zPj Ww== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc359jndf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 14:01:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35ME13Ch026274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 14:01:05 GMT
Received: from hu-ptalari-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 22 Jun 2023 07:00:48 -0700
From:   Praveen Talari <quic_ptalari@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>,
        <quic_vnivarth@quicinc.com>, <quic_arandive@quicinc.com>,
        Praveen Talari <quic_ptalari@quicinc.com>
Subject: [PATCH v3 3/3] spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3
Date:   Thu, 22 Jun 2023 19:29:55 +0530
Message-ID: <20230622135955.941-4-quic_ptalari@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230622135955.941-1-quic_ptalari@quicinc.com>
References: <20230622135955.941-1-quic_ptalari@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FZSU-owjZni3uixpr1I-syxcAYvlt6Gt
X-Proofpoint-ORIG-GUID: FZSU-owjZni3uixpr1I-syxcAYvlt6Gt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_10,2023-06-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220118
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently spi geni driver supports only master mode operation.

Add spi device mode support to GENI based QuPv3.

Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
---
v2 -> v3:
- modified commit message to use device mode instead of slave mode

v1 -> v2
- modified the commit message
- added the code changes for code comments
---
---
 drivers/spi/spi-geni-qcom.c | 57 +++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 206cc04bb1ed..2170bd6b7eef 100644
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
@@ -99,6 +103,24 @@ struct spi_geni_master {
 	int cur_xfer_mode;
 };
 
+static struct spi_master *get_spi_master(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spi_master *spi = platform_get_drvdata(pdev);
+
+	return spi;
+}
+
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
@@ -140,12 +162,18 @@ static void handle_se_timeout(struct spi_master *spi,
 	const struct spi_transfer *xfer;
 
 	spin_lock_irq(&mas->lock);
-	reinit_completion(&mas->cancel_done);
 	if (mas->cur_xfer_mode == GENI_SE_FIFO)
 		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
 
 	xfer = mas->cur_xfer;
 	mas->cur_xfer = NULL;
+
+	if (spi->slave) {
+		spin_unlock_irq(&mas->lock);
+		goto unmap_if_dma;
+	}
+
+	reinit_completion(&mas->cancel_done);
 	geni_se_cancel_m_cmd(se);
 	spin_unlock_irq(&mas->lock);
 
@@ -542,6 +570,10 @@ static bool geni_can_dma(struct spi_controller *ctlr,
 	if (mas->cur_xfer_mode == GENI_GPI_DMA)
 		return true;
 
+	/* Set DMA mode for SPI slave. */
+	if (ctlr->slave)
+		return true;
+
 	len = get_xfer_len_in_words(xfer, mas);
 	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
 
@@ -619,6 +651,7 @@ static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
 
 static int spi_geni_init(struct spi_geni_master *mas)
 {
+	struct spi_master *spi = get_spi_master(mas->dev);
 	struct geni_se *se = &mas->se;
 	unsigned int proto, major, minor, ver;
 	u32 spi_tx_cfg, fifo_disable;
@@ -627,7 +660,14 @@ static int spi_geni_init(struct spi_geni_master *mas)
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
@@ -677,9 +717,11 @@ static int spi_geni_init(struct spi_geni_master *mas)
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
@@ -1072,6 +1114,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
 	pm_runtime_enable(dev);
 
+	if (device_property_read_bool(&pdev->dev, "qcom,slv-ctrl"))
+		spi->slave = true;
+
 	ret = geni_icc_get(&mas->se, NULL);
 	if (ret)
 		goto spi_geni_probe_runtime_disable;
@@ -1092,7 +1137,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	 * for dma (gsi) mode, the gsi will set cs based on params passed in
 	 * TRE
 	 */
-	if (mas->cur_xfer_mode == GENI_SE_FIFO)
+	if (!spi->slave && mas->cur_xfer_mode == GENI_SE_FIFO)
 		spi->set_cs = spi_geni_set_cs;
 
 	ret = request_irq(mas->irq, geni_spi_isr, 0, dev_name(dev), spi);
-- 
2.17.1

