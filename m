Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A34700DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjELRIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbjELRH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:07:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEC62D48;
        Fri, 12 May 2023 10:07:57 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CE0UQq010623;
        Fri, 12 May 2023 17:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=gHSB+INqMf3ISjpo/D0kG8TkRPoxfOI60cS8XSXB3Sg=;
 b=ViLNFgnipN3eQMiaZ2VbuPjE/LAU4RG2mhc5E8ZbbJ9BJLBlRrXGcRh1ZyHqBagEd/cv
 dfzAMnRVWwUrtln5nCtVzgZ+PTU5CSIG6dgBPGTXg7OwWZG2juGKj2pgObqzDNQi+aee
 wlnQMhgB+stp0WpvuctIx2w/ovDHq8cQUqUUSiNCK/qNAVg2+sCG+wom/Sw1LZVRrEto
 pnbeCc78LVjvS6l10/lR6cjyT5WzcjiQJzclvChXR1v847acpCPNSyo4DPnyHhZ4xiLj
 1bdZlzitzjfGx3otBUW0yKIw4IL+6oPVSlJd+CBjIAI7d6c7w5gqNLK+E/xEH+ymdGl/ zA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhpsdreqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 17:07:52 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34CH7oqb011287;
        Fri, 12 May 2023 17:07:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdy59v8q3-1;
        Fri, 12 May 2023 17:07:50 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CH7nXV011281;
        Fri, 12 May 2023 17:07:50 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34CH7nQk011274;
        Fri, 12 May 2023 17:07:49 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 36D574B21; Fri, 12 May 2023 22:37:49 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, quic_vnivarth@quicinc.com,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com, quic_ptalari@quicinc.com
Subject: [PATCH 2/2] spi: spi-geni-qcom: Do not do DMA map/unmap inside driver, use framework instead
Date:   Fri, 12 May 2023 22:37:45 +0530
Message-Id: <1683911265-3395-3-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683911265-3395-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1683911265-3395-1-git-send-email-quic_vnivarth@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QdQSLatNKJ9s8FvGQ2ycpYdYs4nev6WF
X-Proofpoint-ORIG-GUID: QdQSLatNKJ9s8FvGQ2ycpYdYs4nev6WF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 mlxlogscore=538 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120142
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi geni driver in SE DMA mode, unlike GSI DMA, is not making use of
DMA mapping functionality available in the framework.
The driver does mapping internally which makes dma buffer fields available
in spi_transfer struct superfluous while requiring additional members in
spi_geni_master struct.

Conform to the design by having framework handle map/unmap and do only
DMA transfer in the driver; this also simplifies code a bit.

Fixes: e5f0dfa78ac7 ("spi: spi-geni-qcom: Add support for SE DMA mode")
Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
 drivers/spi/spi-geni-qcom.c | 101 +++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 49 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index e423efc..bfe2a1a 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -97,8 +97,6 @@ struct spi_geni_master {
 	struct dma_chan *tx;
 	struct dma_chan *rx;
 	int cur_xfer_mode;
-	dma_addr_t tx_se_dma;
-	dma_addr_t rx_se_dma;
 };
 
 static int get_spi_clk_cfg(unsigned int speed_hz,
@@ -174,7 +172,7 @@ static void handle_se_timeout(struct spi_master *spi,
 unmap_if_dma:
 	if (mas->cur_xfer_mode == GENI_SE_DMA) {
 		if (xfer) {
-			if (xfer->tx_buf && mas->tx_se_dma) {
+			if (xfer->tx_buf) {
 				spin_lock_irq(&mas->lock);
 				reinit_completion(&mas->tx_reset_done);
 				writel(1, se->base + SE_DMA_TX_FSM_RST);
@@ -182,9 +180,8 @@ static void handle_se_timeout(struct spi_master *spi,
 				time_left = wait_for_completion_timeout(&mas->tx_reset_done, HZ);
 				if (!time_left)
 					dev_err(mas->dev, "DMA TX RESET failed\n");
-				geni_se_tx_dma_unprep(se, mas->tx_se_dma, xfer->len);
 			}
-			if (xfer->rx_buf && mas->rx_se_dma) {
+			if (xfer->rx_buf) {
 				spin_lock_irq(&mas->lock);
 				reinit_completion(&mas->rx_reset_done);
 				writel(1, se->base + SE_DMA_RX_FSM_RST);
@@ -192,7 +189,6 @@ static void handle_se_timeout(struct spi_master *spi,
 				time_left = wait_for_completion_timeout(&mas->rx_reset_done, HZ);
 				if (!time_left)
 					dev_err(mas->dev, "DMA RX RESET failed\n");
-				geni_se_rx_dma_unprep(se, mas->rx_se_dma, xfer->len);
 			}
 		} else {
 			/*
@@ -523,17 +519,36 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 	return 1;
 }
 
+static u32 get_xfer_len_in_words(struct spi_transfer *xfer,
+				struct spi_geni_master *mas)
+{
+	u32 len;
+
+	if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
+		len = xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word;
+	else
+		len = xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE + 1);
+	len &= TRANS_LEN_MSK;
+
+	return len;
+}
+
 static bool geni_can_dma(struct spi_controller *ctlr,
 			 struct spi_device *slv, struct spi_transfer *xfer)
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
+	u32 len, fifo_size;
 
-	/*
-	 * Return true if transfer needs to be mapped prior to
-	 * calling transfer_one which is the case only for GPI_DMA.
-	 * For SE_DMA mode, map/unmap is done in geni_se_*x_dma_prep.
-	 */
-	return mas->cur_xfer_mode == GENI_GPI_DMA;
+	if (mas->cur_xfer_mode == GENI_GPI_DMA)
+		return true;
+
+	len = get_xfer_len_in_words(xfer, mas);
+	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
+
+	if (len > fifo_size)
+		return true;
+	else
+		return false;
 }
 
 static int spi_geni_prepare_message(struct spi_master *spi,
@@ -772,7 +787,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 				u16 mode, struct spi_master *spi)
 {
 	u32 m_cmd = 0;
-	u32 len, fifo_size;
+	u32 len;
 	struct geni_se *se = &mas->se;
 	int ret;
 
@@ -804,11 +819,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 	mas->tx_rem_bytes = 0;
 	mas->rx_rem_bytes = 0;
 
-	if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
-		len = xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word;
-	else
-		len = xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE + 1);
-	len &= TRANS_LEN_MSK;
+	len = get_xfer_len_in_words(xfer, mas);
 
 	mas->cur_xfer = xfer;
 	if (xfer->tx_buf) {
@@ -823,9 +834,20 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 		mas->rx_rem_bytes = xfer->len;
 	}
 
-	/* Select transfer mode based on transfer length */
-	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
-	mas->cur_xfer_mode = (len <= fifo_size) ? GENI_SE_FIFO : GENI_SE_DMA;
+	/*
+	 * Select DMA mode if sgt are present; and with only 1 entry
+	 * This is not a serious limitation because the xfer buffers are
+	 * expected to fit into 1 entry almost always, and if any
+	 * doesn't for any reason, we fall back to FIFO mode anyway
+	 */
+	if (!xfer->tx_sg.nents && !xfer->rx_sg.nents)
+		mas->cur_xfer_mode = GENI_SE_FIFO;
+	else if (xfer->tx_sg.nents > 1 || xfer->rx_sg.nents > 1) {
+		dev_warn_once(mas->dev, "Doing FIFO, cannot handle tx_nents-%d, rx_nents-%d\n",
+			xfer->tx_sg.nents, xfer->rx_sg.nents);
+		mas->cur_xfer_mode = GENI_SE_FIFO;
+	} else
+		mas->cur_xfer_mode = GENI_SE_DMA;
 	geni_se_select_mode(se, mas->cur_xfer_mode);
 
 	/*
@@ -836,35 +858,24 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
 
 	if (mas->cur_xfer_mode == GENI_SE_DMA) {
+		dma_addr_t dma_ptr_sg;
+		unsigned int dma_len_sg;
+
 		if (m_cmd & SPI_RX_ONLY) {
-			ret =  geni_se_rx_dma_prep(se, xfer->rx_buf,
-				xfer->len, &mas->rx_se_dma);
-			if (ret) {
-				dev_err(mas->dev, "Failed to setup Rx dma %d\n", ret);
-				mas->rx_se_dma = 0;
-				goto unlock_and_return;
-			}
+			dma_ptr_sg = sg_dma_address(xfer->rx_sg.sgl);
+			dma_len_sg = sg_dma_len(xfer->rx_sg.sgl);
+			geni_se_rx_init_dma(se, &dma_ptr_sg, dma_len_sg);
 		}
 		if (m_cmd & SPI_TX_ONLY) {
-			ret =  geni_se_tx_dma_prep(se, (void *)xfer->tx_buf,
-				xfer->len, &mas->tx_se_dma);
-			if (ret) {
-				dev_err(mas->dev, "Failed to setup Tx dma %d\n", ret);
-				mas->tx_se_dma = 0;
-				if (m_cmd & SPI_RX_ONLY) {
-					/* Unmap rx buffer if duplex transfer */
-					geni_se_rx_dma_unprep(se, mas->rx_se_dma, xfer->len);
-					mas->rx_se_dma = 0;
-				}
-				goto unlock_and_return;
-			}
+			dma_ptr_sg = sg_dma_address(xfer->tx_sg.sgl);
+			dma_len_sg = sg_dma_len(xfer->tx_sg.sgl);
+			geni_se_tx_init_dma(se, &dma_ptr_sg, dma_len_sg);
 		}
 	} else if (m_cmd & SPI_TX_ONLY) {
 		if (geni_spi_handle_tx(mas))
 			writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
 	}
 
-unlock_and_return:
 	spin_unlock_irq(&mas->lock);
 	return ret;
 }
@@ -965,14 +976,6 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		if (dma_rx_status & RX_RESET_DONE)
 			complete(&mas->rx_reset_done);
 		if (!mas->tx_rem_bytes && !mas->rx_rem_bytes && xfer) {
-			if (xfer->tx_buf && mas->tx_se_dma) {
-				geni_se_tx_dma_unprep(se, mas->tx_se_dma, xfer->len);
-				mas->tx_se_dma = 0;
-			}
-			if (xfer->rx_buf && mas->rx_se_dma) {
-				geni_se_rx_dma_unprep(se, mas->rx_se_dma, xfer->len);
-				mas->rx_se_dma = 0;
-			}
 			spi_finalize_current_transfer(spi);
 			mas->cur_xfer = NULL;
 		}
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

