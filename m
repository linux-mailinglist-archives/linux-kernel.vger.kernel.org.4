Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B73B72FC62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbjFNL2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbjFNL2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:28:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966B11BE9;
        Wed, 14 Jun 2023 04:28:18 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EBLDKh002031;
        Wed, 14 Jun 2023 11:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=tBDdYFBw2QSwTa8jz5kx4XAg6O/UYTxpL/gTvAvEcqY=;
 b=kkEyTziu4026yiz0GTsn2ryU+qYoz5h1NuKHDnNRxB3qYbZD9ZaA2pPmRql5E5dMCbKJ
 h0EMtR0ZK2c+UDVt4XHl4jKg3gqbH6w5F+oQyIeyNTWQr1FxaYwAfTIbEXFQRpMlzLvc
 8y3RvgvNNddT5h8X+hEEQl1FPCIF1Cbn26haRMHczb4YQlYgKnx62udQ3joqfZbIeVa/
 Zyifdgot43U+mA71tOsryRXGmHa6sAySEAnHnFf7yEVCukS19aKcZvqtw+H9cwglUdMU
 N/5LPXLMzxCatSJbrKAyLiUewMa3pNNJ3eSypR8F7IvzdqTJokddnYD79TSgHjn4NF/u yQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7cka00bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:28:14 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35EBSASB017409;
        Wed, 14 Jun 2023 11:28:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3r7271hrex-1;
        Wed, 14 Jun 2023 11:28:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EBSAJ8017403;
        Wed, 14 Jun 2023 11:28:10 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 35EBSAA1017402;
        Wed, 14 Jun 2023 11:28:10 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 622404BD2; Wed, 14 Jun 2023 16:58:09 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v2] soc: qcom: geni-se: Do not bother about enable/disable of interrupts in secondary sequencer
Date:   Wed, 14 Jun 2023 16:58:07 +0530
Message-Id: <1686742087-30731-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -7HLvOpGYe_NcvAPym6_lTyh3OV10Xve
X-Proofpoint-ORIG-GUID: -7HLvOpGYe_NcvAPym6_lTyh3OV10Xve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_07,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=400 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140098
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The select_fifo/dma_mode() functions in geni driver enable/disable
interrupts (secondary included) conditionally for non-uart modes, while
uart is supposed to manage this internally.
However, only uart uses secondary IRQs while spi, i2c do not care about
these at all making their enablement (or disablement) totally unnecessary
for these protos.
Similarly, select_gpi_mode() also does disable s_irq and its useless again.

Drop enabling/disabling secondary IRQs.
This doesn't solve any observed problem but only gets rid of code pieces
that are not required.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v1 -> v2:
- apply similar changes to select_gpi_mode()
- modified commit message accordingly
---
 drivers/soc/qcom/qcom-geni-se.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index dd50a25..ba78876 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -281,27 +281,14 @@ static void geni_se_select_fifo_mode(struct geni_se *se)
 
 	geni_se_irq_clear(se);
 
-	/*
-	 * The RX path for the UART is asynchronous and so needs more
-	 * complex logic for enabling / disabling its interrupts.
-	 *
-	 * Specific notes:
-	 * - The done and TX-related interrupts are managed manually.
-	 * - We don't RX from the main sequencer (we use the secondary) so
-	 *   we don't need the RX-related interrupts enabled in the main
-	 *   sequencer for UART.
-	 */
+	/* UART driver manages enabling / disabling interrupts internally */
 	if (proto != GENI_SE_UART) {
+		/* Non-UART use only primary sequencer so dont bother about S_IRQ */
 		val_old = val = readl_relaxed(se->base + SE_GENI_M_IRQ_EN);
 		val |= M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN;
 		val |= M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN;
 		if (val != val_old)
 			writel_relaxed(val, se->base + SE_GENI_M_IRQ_EN);
-
-		val_old = val = readl_relaxed(se->base + SE_GENI_S_IRQ_EN);
-		val |= S_CMD_DONE_EN;
-		if (val != val_old)
-			writel_relaxed(val, se->base + SE_GENI_S_IRQ_EN);
 	}
 
 	val_old = val = readl_relaxed(se->base + SE_GENI_DMA_MODE_EN);
@@ -317,17 +304,14 @@ static void geni_se_select_dma_mode(struct geni_se *se)
 
 	geni_se_irq_clear(se);
 
+	/* UART driver manages enabling / disabling interrupts internally */
 	if (proto != GENI_SE_UART) {
+		/* Non-UART use only primary sequencer so dont bother about S_IRQ */
 		val_old = val = readl_relaxed(se->base + SE_GENI_M_IRQ_EN);
 		val &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
 		val &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
 		if (val != val_old)
 			writel_relaxed(val, se->base + SE_GENI_M_IRQ_EN);
-
-		val_old = val = readl_relaxed(se->base + SE_GENI_S_IRQ_EN);
-		val &= ~S_CMD_DONE_EN;
-		if (val != val_old)
-			writel_relaxed(val, se->base + SE_GENI_S_IRQ_EN);
 	}
 
 	val_old = val = readl_relaxed(se->base + SE_GENI_DMA_MODE_EN);
@@ -344,10 +328,6 @@ static void geni_se_select_gpi_mode(struct geni_se *se)
 
 	writel(0, se->base + SE_IRQ_EN);
 
-	val = readl(se->base + SE_GENI_S_IRQ_EN);
-	val &= ~S_CMD_DONE_EN;
-	writel(val, se->base + SE_GENI_S_IRQ_EN);
-
 	val = readl(se->base + SE_GENI_M_IRQ_EN);
 	val &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN |
 		 M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

