Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0239C7067D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjEQMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjEQMS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:18:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A064510E9;
        Wed, 17 May 2023 05:18:26 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HAfi3G009720;
        Wed, 17 May 2023 12:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=tQX7Id68l9Gk/TKd3FdUInW21P4SEqvnF601zUlHbmc=;
 b=K0zlRg+BlpLe6jJC5hPNUBxxaLUCvnAGyZsSex4URKXwvSbk3PF2vv4YQkyfvyzefSd2
 2sXmBAPXJdKjIRTI3SK03Hg1cjE7x54LSGU1UyJiKLKoZOdSyJ41kPzsSHeETCxCEKIq
 qyZ8zUbymaLh8bbc1Y072wZF+V7QyePF2MpgsPiwIqCuUyCZfsnmwa5LmcPOKPXJxpf0
 AmWqPA4TYCWmhig/QuqcqQE6xI6O4K1XSJx8e/I0C+NzU+akO88wOD7FZsQI4U5nIC6L
 jjkm92V9n4l/Dpv1khdmPzDfLCHxYBCJDlC5nc/v0rh7pzWT4/noNoNJUa7l+n50UbY2 Bw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmk9m1dby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:18:22 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34HCIIQk022272;
        Wed, 17 May 2023 12:18:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qj3mk69qt-1;
        Wed, 17 May 2023 12:18:18 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HCIIRh022267;
        Wed, 17 May 2023 12:18:18 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34HCII2U022265;
        Wed, 17 May 2023 12:18:18 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id D35B84B3C; Wed, 17 May 2023 17:48:17 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, quic_vnivarth@quicinc.com,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
Subject: [PATCH v2 1/2] soc: qcom: geni-se: Add interfaces geni_se_tx_init_dma() and geni_se_rx_init_dma()
Date:   Wed, 17 May 2023 17:48:13 +0530
Message-Id: <1684325894-30252-2-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1684325894-30252-1-git-send-email-quic_vnivarth@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VCA8kBRl1IQATU5ZOfASJrXSVnlgeD2x
X-Proofpoint-ORIG-GUID: VCA8kBRl1IQATU5ZOfASJrXSVnlgeD2x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170100
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The geni_se_xx_dma_prep() interfaces necessarily do DMA mapping before
initiating DMA transfers. This is not suitable for spi where framework
is expected to handle map/unmap.

Expose new interfaces geni_se_xx_init_dma() which do only DMA transfer.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v1 -> v2:
- interfaces to take dma address as argument instead of its pointer
---
 drivers/soc/qcom/qcom-geni-se.c  | 67 +++++++++++++++++++++++++++++-----------
 include/linux/soc/qcom/geni-se.h |  4 +++
 2 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 795a2e1..dd50a25 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -682,6 +682,30 @@ EXPORT_SYMBOL(geni_se_clk_freq_match);
 #define GENI_SE_DMA_EOT_EN BIT(1)
 #define GENI_SE_DMA_AHB_ERR_EN BIT(2)
 #define GENI_SE_DMA_EOT_BUF BIT(0)
+
+/**
+ * geni_se_tx_init_dma() - Initiate TX DMA transfer on the serial engine
+ * @se:			Pointer to the concerned serial engine.
+ * @iova:		Mapped DMA address.
+ * @len:		Length of the TX buffer.
+ *
+ * This function is used to initiate DMA TX transfer.
+ */
+void geni_se_tx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len)
+{
+	u32 val;
+
+	val = GENI_SE_DMA_DONE_EN;
+	val |= GENI_SE_DMA_EOT_EN;
+	val |= GENI_SE_DMA_AHB_ERR_EN;
+	writel_relaxed(val, se->base + SE_DMA_TX_IRQ_EN_SET);
+	writel_relaxed(lower_32_bits(iova), se->base + SE_DMA_TX_PTR_L);
+	writel_relaxed(upper_32_bits(iova), se->base + SE_DMA_TX_PTR_H);
+	writel_relaxed(GENI_SE_DMA_EOT_BUF, se->base + SE_DMA_TX_ATTR);
+	writel(len, se->base + SE_DMA_TX_LEN);
+}
+EXPORT_SYMBOL(geni_se_tx_init_dma);
+
 /**
  * geni_se_tx_dma_prep() - Prepare the serial engine for TX DMA transfer
  * @se:			Pointer to the concerned serial engine.
@@ -697,7 +721,6 @@ int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
 			dma_addr_t *iova)
 {
 	struct geni_wrapper *wrapper = se->wrapper;
-	u32 val;
 
 	if (!wrapper)
 		return -EINVAL;
@@ -706,17 +729,34 @@ int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
 	if (dma_mapping_error(wrapper->dev, *iova))
 		return -EIO;
 
+	geni_se_tx_init_dma(se, *iova, len);
+	return 0;
+}
+EXPORT_SYMBOL(geni_se_tx_dma_prep);
+
+/**
+ * geni_se_rx_init_dma() - Initiate RX DMA transfer on the serial engine
+ * @se:			Pointer to the concerned serial engine.
+ * @iova:		Mapped DMA address.
+ * @len:		Length of the RX buffer.
+ *
+ * This function is used to initiate DMA RX transfer.
+ */
+void geni_se_rx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len)
+{
+	u32 val;
+
 	val = GENI_SE_DMA_DONE_EN;
 	val |= GENI_SE_DMA_EOT_EN;
 	val |= GENI_SE_DMA_AHB_ERR_EN;
-	writel_relaxed(val, se->base + SE_DMA_TX_IRQ_EN_SET);
-	writel_relaxed(lower_32_bits(*iova), se->base + SE_DMA_TX_PTR_L);
-	writel_relaxed(upper_32_bits(*iova), se->base + SE_DMA_TX_PTR_H);
-	writel_relaxed(GENI_SE_DMA_EOT_BUF, se->base + SE_DMA_TX_ATTR);
-	writel(len, se->base + SE_DMA_TX_LEN);
-	return 0;
+	writel_relaxed(val, se->base + SE_DMA_RX_IRQ_EN_SET);
+	writel_relaxed(lower_32_bits(iova), se->base + SE_DMA_RX_PTR_L);
+	writel_relaxed(upper_32_bits(iova), se->base + SE_DMA_RX_PTR_H);
+	/* RX does not have EOT buffer type bit. So just reset RX_ATTR */
+	writel_relaxed(0, se->base + SE_DMA_RX_ATTR);
+	writel(len, se->base + SE_DMA_RX_LEN);
 }
-EXPORT_SYMBOL(geni_se_tx_dma_prep);
+EXPORT_SYMBOL(geni_se_rx_init_dma);
 
 /**
  * geni_se_rx_dma_prep() - Prepare the serial engine for RX DMA transfer
@@ -733,7 +773,6 @@ int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
 			dma_addr_t *iova)
 {
 	struct geni_wrapper *wrapper = se->wrapper;
-	u32 val;
 
 	if (!wrapper)
 		return -EINVAL;
@@ -742,15 +781,7 @@ int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
 	if (dma_mapping_error(wrapper->dev, *iova))
 		return -EIO;
 
-	val = GENI_SE_DMA_DONE_EN;
-	val |= GENI_SE_DMA_EOT_EN;
-	val |= GENI_SE_DMA_AHB_ERR_EN;
-	writel_relaxed(val, se->base + SE_DMA_RX_IRQ_EN_SET);
-	writel_relaxed(lower_32_bits(*iova), se->base + SE_DMA_RX_PTR_L);
-	writel_relaxed(upper_32_bits(*iova), se->base + SE_DMA_RX_PTR_H);
-	/* RX does not have EOT buffer type bit. So just reset RX_ATTR */
-	writel_relaxed(0, se->base + SE_DMA_RX_ATTR);
-	writel(len, se->base + SE_DMA_RX_LEN);
+	geni_se_rx_init_dma(se, *iova, len);
 	return 0;
 }
 EXPORT_SYMBOL(geni_se_rx_dma_prep);
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index c55a0bc..821a191 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -490,9 +490,13 @@ int geni_se_clk_freq_match(struct geni_se *se, unsigned long req_freq,
 			   unsigned int *index, unsigned long *res_freq,
 			   bool exact);
 
+void geni_se_tx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len);
+
 int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
 			dma_addr_t *iova);
 
+void geni_se_rx_init_dma(struct geni_se *se, dma_addr_t iova, size_t len);
+
 int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
 			dma_addr_t *iova);
 
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

