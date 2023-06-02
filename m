Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E347208DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbjFBSNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjFBSNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:13:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6D9123;
        Fri,  2 Jun 2023 11:13:46 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352Dg9Rw029446;
        Fri, 2 Jun 2023 18:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=UE2Rx1irt7g58Lw65av8HRXfkxaMlYFe/H8y1ZB0miQ=;
 b=EEBowLTeDOi23kCV6ogPf76qKhh/f3fkLD2wj173SgWhGMNWYsefgY52RT9TaxQtSdH4
 b+UJ2Yb3S9XkGGNM9w2po2mNGAyTLZ5xYwF5Txm4gqo/QWDKIlUeRSYxTpHrzNbQYqtv
 Xgpk/1lV1lempWCYVdzCwtpDfMuc/ciDWXt4LLJ12YkSnJOyQgfungYYVCijsy6eN8pT
 DRW290KeGKP0cABQzjUKBb5UM2+b3/TA34oLArekg9FncytNH4TK0I+raLEQ5sMnG5dP
 j6vksAckQH1sKBKR8zs1SJ3yp9YF4L5l8vHujxDPb0qLiCJCLQbjn1MIFqgYiCaUs1in jw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qybqeheke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 18:13:41 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 352IACvG008476;
        Fri, 2 Jun 2023 18:13:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3quaxknu2p-1;
        Fri, 02 Jun 2023 18:13:37 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 352IDbxj011176;
        Fri, 2 Jun 2023 18:13:37 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 352IDbIc011175;
        Fri, 02 Jun 2023 18:13:37 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id A82284B62; Fri,  2 Jun 2023 23:43:36 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH] soc: qcom: geni-se: Do not bother about enable/disable of interrupts in secondary sequencer for non-uart modes
Date:   Fri,  2 Jun 2023 23:43:29 +0530
Message-Id: <1685729609-26871-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xILEjNoPTC-f7nFT4HVfjCt609Rl4del
X-Proofpoint-GUID: xILEjNoPTC-f7nFT4HVfjCt609Rl4del
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_13,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=410 mlxscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020139
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

Drop enabling/disabling secondary IRQs for non-uart modes.
This doesn't solve any observed problem but only gets rid of code pieces
that are not required.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 795a2e1..7111661 100644
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
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

