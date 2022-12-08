Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66A86471C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiLHO1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiLHO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:26:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6AD45A17;
        Thu,  8 Dec 2022 06:25:58 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8DJwAS031048;
        Thu, 8 Dec 2022 14:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=2x4FctKgQPV6Z/H0SPs68LZKyHxcfHZ0YWVpGUUlRgc=;
 b=lZhRpXsQWhGsRsHvj7A8Bv/LgXc70LUUlrSfsFgT+C5J8KrbcYSowz6B8JSL2z8QzqUd
 kimPXjXgEGMCAC9JbiEpJmJb4pPt25aXikA5vLCnb2fy4m4MW48CkjzJKfaTfZokR1nn
 ir088lNYMGZHFXv6hnNUCH10BQt6By+aSKK/V3EEnGZxTIddeYyEN8Tc6swb+mQ8Uw4s
 giwjRlZosuNuuPWOGtVt4V6ypvihtcBrWRbJmPbkz9dkZDM3YWeGB3WTNIaHKNyiQ80t
 tPu1ZUBL8kgJhzsUVNZiITn5MkDhTR6XkrvlmAq/BEBHm1u2Y7m/jIaOKZQMd9hiPjNH 0Q== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mb7bc9jqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 14:25:52 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2B8EPmWG013724;
        Thu, 8 Dec 2022 14:25:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3m8g0behce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 08 Dec 2022 14:25:48 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B8EPmcE013717;
        Thu, 8 Dec 2022 14:25:48 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vnivarth-hyd.qualcomm.com [10.213.111.166])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2B8EPm7r013716;
        Thu, 08 Dec 2022 14:25:48 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3994820)
        id 837584610; Thu,  8 Dec 2022 19:55:47 +0530 (+0530)
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com, vkoul@kernel.org,
        quic_arandive@quicinc.com, quic_ramkri@quicinc.com,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [V4] spi: spi-geni-qcom: Add support for SE DMA mode
Date:   Thu,  8 Dec 2022 19:55:44 +0530
Message-Id: <1670509544-15977-1-git-send-email-quic_vnivarth@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uYMcWZmUfxfmpQOI4KSvJkZRHMwxHAji
X-Proofpoint-ORIG-GUID: uYMcWZmUfxfmpQOI4KSvJkZRHMwxHAji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_07,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212080120
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SE DMA mode can be used for larger transfers and FIFO mode
for smaller transfers.

Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
---
v4 -> v3:
- remove cur_m_cmd field
- add dma_addr fields to spi_geni_master
- dont use dma_addr from xfer, use above
- dev_warn instead of dev_err in handle_timeout
- set xfer_mode to FIFO in set_cs

v2 -> v3:
- indentation change
- readability change

v1 -> v2:
- replace writel_relaxed with writel
- corrected order of performing FSM reset and dma_unprep
- added more comments in geni_can_dma
- removed redundant change in spi_geni_init(DMA as default xfer_mode)
- removed redundant initialisations in setup_se_xfer
- removed redundant null checks in setup_se_xfer
- added dma_tx_prep failure handling(rx un_map) in setup_se_xfer
- move handing return of setip_se_xfer to transfer_one
- apply irq error handling for DMA mode too in geni_spi_isr
---
 drivers/spi/spi-geni-qcom.c | 211 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 165 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 4e83cc5..e1b2e0b 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -87,6 +87,8 @@ struct spi_geni_master {
 	struct completion cs_done;
 	struct completion cancel_done;
 	struct completion abort_done;
+	struct completion tx_reset_done;
+	struct completion rx_reset_done;
 	unsigned int oversampling;
 	spinlock_t lock;
 	int irq;
@@ -95,6 +97,8 @@ struct spi_geni_master {
 	struct dma_chan *tx;
 	struct dma_chan *rx;
 	int cur_xfer_mode;
+	dma_addr_t tx_se_dma;
+	dma_addr_t rx_se_dma;
 };
 
 static int get_spi_clk_cfg(unsigned int speed_hz,
@@ -129,23 +133,27 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 	return ret;
 }
 
-static void handle_fifo_timeout(struct spi_master *spi,
+static void handle_se_timeout(struct spi_master *spi,
 				struct spi_message *msg)
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 	unsigned long time_left;
 	struct geni_se *se = &mas->se;
+	const struct spi_transfer *xfer;
 
 	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->cancel_done);
-	writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+	if (mas->cur_xfer_mode == GENI_SE_FIFO)
+		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+
+	xfer = mas->cur_xfer;
 	mas->cur_xfer = NULL;
 	geni_se_cancel_m_cmd(se);
 	spin_unlock_irq(&mas->lock);
 
 	time_left = wait_for_completion_timeout(&mas->cancel_done, HZ);
 	if (time_left)
-		return;
+		goto unmap_if_dma;
 
 	spin_lock_irq(&mas->lock);
 	reinit_completion(&mas->abort_done);
@@ -162,6 +170,39 @@ static void handle_fifo_timeout(struct spi_master *spi,
 		 */
 		mas->abort_failed = true;
 	}
+
+unmap_if_dma:
+	if (mas->cur_xfer_mode == GENI_SE_DMA) {
+		if (xfer) {
+			if (xfer->tx_buf && mas->tx_se_dma) {
+				spin_lock_irq(&mas->lock);
+				reinit_completion(&mas->tx_reset_done);
+				writel(1, se->base + SE_DMA_TX_FSM_RST);
+				spin_unlock_irq(&mas->lock);
+				time_left = wait_for_completion_timeout(&mas->tx_reset_done, HZ);
+				if (!time_left)
+					dev_err(mas->dev, "DMA TX RESET failed\n");
+				geni_se_tx_dma_unprep(se, mas->tx_se_dma, xfer->len);
+			}
+			if (xfer->rx_buf && mas->rx_se_dma) {
+				spin_lock_irq(&mas->lock);
+				reinit_completion(&mas->rx_reset_done);
+				writel(1, se->base + SE_DMA_RX_FSM_RST);
+				spin_unlock_irq(&mas->lock);
+				time_left = wait_for_completion_timeout(&mas->rx_reset_done, HZ);
+				if (!time_left)
+					dev_err(mas->dev, "DMA RX RESET failed\n");
+				geni_se_rx_dma_unprep(se, mas->rx_se_dma, xfer->len);
+			}
+		} else {
+			/*
+			 * This can happen if a timeout happened and we had to wait
+			 * for lock in this function because isr was holding the lock
+			 * and handling transfer completion at that time.
+			 */
+			dev_warn(mas->dev, "Cancel/Abort on completed SPI transfer\n");
+		}
+	}
 }
 
 static void handle_gpi_timeout(struct spi_master *spi, struct spi_message *msg)
@@ -178,7 +219,8 @@ static void spi_geni_handle_err(struct spi_master *spi, struct spi_message *msg)
 
 	switch (mas->cur_xfer_mode) {
 	case GENI_SE_FIFO:
-		handle_fifo_timeout(spi, msg);
+	case GENI_SE_DMA:
+		handle_se_timeout(spi, msg);
 		break;
 	case GENI_GPI_DMA:
 		handle_gpi_timeout(spi, msg);
@@ -250,6 +292,8 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	}
 
 	mas->cs_flag = set_flag;
+	/* set xfer_mode to FIFO to complete cs_done in isr */
+	mas->cur_xfer_mode = GENI_SE_FIFO;
 	reinit_completion(&mas->cs_done);
 	if (set_flag)
 		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
@@ -260,7 +304,7 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	time_left = wait_for_completion_timeout(&mas->cs_done, HZ);
 	if (!time_left) {
 		dev_warn(mas->dev, "Timeout setting chip select\n");
-		handle_fifo_timeout(spi, NULL);
+		handle_se_timeout(spi, NULL);
 	}
 
 exit:
@@ -482,8 +526,12 @@ static bool geni_can_dma(struct spi_controller *ctlr,
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(slv->master);
 
-	/* check if dma is supported */
-	return mas->cur_xfer_mode != GENI_SE_FIFO;
+	/*
+	 * Return true if transfer needs to be mapped prior to
+	 * calling transfer_one which is the case only for GPI_DMA.
+	 * For SE_DMA mode, map/unmap is done in geni_se_*x_dma_prep.
+	 */
+	return mas->cur_xfer_mode == GENI_GPI_DMA;
 }
 
 static int spi_geni_prepare_message(struct spi_master *spi,
@@ -494,6 +542,7 @@ static int spi_geni_prepare_message(struct spi_master *spi,
 
 	switch (mas->cur_xfer_mode) {
 	case GENI_SE_FIFO:
+	case GENI_SE_DMA:
 		if (spi_geni_is_abort_still_pending(mas))
 			return -EBUSY;
 		ret = setup_fifo_params(spi_msg->spi, spi);
@@ -597,7 +646,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			break;
 		}
 		/*
-		 * in case of failure to get dma channel, we can still do the
+		 * in case of failure to get gpi dma channel, we can still do the
 		 * FIFO mode, so fallthrough
 		 */
 		dev_warn(mas->dev, "FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode\n");
@@ -716,12 +765,12 @@ static void geni_spi_handle_rx(struct spi_geni_master *mas)
 	mas->rx_rem_bytes -= rx_bytes;
 }
 
-static void setup_fifo_xfer(struct spi_transfer *xfer,
+static int setup_se_xfer(struct spi_transfer *xfer,
 				struct spi_geni_master *mas,
 				u16 mode, struct spi_master *spi)
 {
 	u32 m_cmd = 0;
-	u32 len;
+	u32 len, fifo_size;
 	struct geni_se *se = &mas->se;
 	int ret;
 
@@ -748,7 +797,7 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 	/* Speed and bits per word can be overridden per transfer */
 	ret = geni_spi_set_clock_and_bw(mas, xfer->speed_hz);
 	if (ret)
-		return;
+		return ret;
 
 	mas->tx_rem_bytes = 0;
 	mas->rx_rem_bytes = 0;
@@ -772,17 +821,50 @@ static void setup_fifo_xfer(struct spi_transfer *xfer,
 		mas->rx_rem_bytes = xfer->len;
 	}
 
+	/* Select transfer mode based on transfer length */
+	fifo_size = mas->tx_fifo_depth * mas->fifo_width_bits / mas->cur_bits_per_word;
+	mas->cur_xfer_mode = (len <= fifo_size) ? GENI_SE_FIFO : GENI_SE_DMA;
+	geni_se_select_mode(se, mas->cur_xfer_mode);
+
 	/*
 	 * Lock around right before we start the transfer since our
 	 * interrupt could come in at any time now.
 	 */
 	spin_lock_irq(&mas->lock);
 	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
-	if (m_cmd & SPI_TX_ONLY) {
+
+	if (mas->cur_xfer_mode == GENI_SE_DMA) {
+		if (m_cmd & SPI_RX_ONLY) {
+			ret =  geni_se_rx_dma_prep(se, xfer->rx_buf,
+				xfer->len, &mas->rx_se_dma);
+			if (ret) {
+				dev_err(mas->dev, "Failed to setup Rx dma %d\n", ret);
+				mas->rx_se_dma = 0;
+				goto unlock_and_return;
+			}
+		}
+		if (m_cmd & SPI_TX_ONLY) {
+			ret =  geni_se_tx_dma_prep(se, (void *)xfer->tx_buf,
+				xfer->len, &mas->tx_se_dma);
+			if (ret) {
+				dev_err(mas->dev, "Failed to setup Tx dma %d\n", ret);
+				mas->tx_se_dma = 0;
+				if (m_cmd & SPI_RX_ONLY) {
+					/* Unmap rx buffer if duplex transfer */
+					geni_se_rx_dma_unprep(se, mas->rx_se_dma, xfer->len);
+					mas->rx_se_dma = 0;
+				}
+				goto unlock_and_return;
+			}
+		}
+	} else if (m_cmd & SPI_TX_ONLY) {
 		if (geni_spi_handle_tx(mas))
 			writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
 	}
+
+unlock_and_return:
 	spin_unlock_irq(&mas->lock);
+	return ret;
 }
 
 static int spi_geni_transfer_one(struct spi_master *spi,
@@ -790,6 +872,7 @@ static int spi_geni_transfer_one(struct spi_master *spi,
 				struct spi_transfer *xfer)
 {
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
+	int ret;
 
 	if (spi_geni_is_abort_still_pending(mas))
 		return -EBUSY;
@@ -798,9 +881,12 @@ static int spi_geni_transfer_one(struct spi_master *spi,
 	if (!xfer->len)
 		return 0;
 
-	if (mas->cur_xfer_mode == GENI_SE_FIFO) {
-		setup_fifo_xfer(xfer, mas, slv->mode, spi);
-		return 1;
+	if (mas->cur_xfer_mode == GENI_SE_FIFO || mas->cur_xfer_mode == GENI_SE_DMA) {
+		ret = setup_se_xfer(xfer, mas, slv->mode, spi);
+		/* SPI framework expects +ve ret code to wait for transfer complete */
+		if (!ret)
+			ret = 1;
+		return ret;
 	}
 	return setup_gsi_xfer(xfer, mas, slv, spi);
 }
@@ -823,39 +909,70 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 
 	spin_lock(&mas->lock);
 
-	if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
-		geni_spi_handle_rx(mas);
-
-	if (m_irq & M_TX_FIFO_WATERMARK_EN)
-		geni_spi_handle_tx(mas);
-
-	if (m_irq & M_CMD_DONE_EN) {
-		if (mas->cur_xfer) {
+	if (mas->cur_xfer_mode == GENI_SE_FIFO) {
+		if ((m_irq & M_RX_FIFO_WATERMARK_EN) || (m_irq & M_RX_FIFO_LAST_EN))
+			geni_spi_handle_rx(mas);
+
+		if (m_irq & M_TX_FIFO_WATERMARK_EN)
+			geni_spi_handle_tx(mas);
+
+		if (m_irq & M_CMD_DONE_EN) {
+			if (mas->cur_xfer) {
+				spi_finalize_current_transfer(spi);
+				mas->cur_xfer = NULL;
+				/*
+				 * If this happens, then a CMD_DONE came before all the
+				 * Tx buffer bytes were sent out. This is unusual, log
+				 * this condition and disable the WM interrupt to
+				 * prevent the system from stalling due an interrupt
+				 * storm.
+				 *
+				 * If this happens when all Rx bytes haven't been
+				 * received, log the condition. The only known time
+				 * this can happen is if bits_per_word != 8 and some
+				 * registers that expect xfer lengths in num spi_words
+				 * weren't written correctly.
+				 */
+				if (mas->tx_rem_bytes) {
+					writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
+					dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
+						mas->tx_rem_bytes, mas->cur_bits_per_word);
+				}
+				if (mas->rx_rem_bytes)
+					dev_err(mas->dev, "Premature done. rx_rem = %d bpw%d\n",
+						mas->rx_rem_bytes, mas->cur_bits_per_word);
+			} else {
+				complete(&mas->cs_done);
+			}
+		}
+	} else if (mas->cur_xfer_mode == GENI_SE_DMA) {
+		const struct spi_transfer *xfer = mas->cur_xfer;
+		u32 dma_tx_status = readl_relaxed(se->base + SE_DMA_TX_IRQ_STAT);
+		u32 dma_rx_status = readl_relaxed(se->base + SE_DMA_RX_IRQ_STAT);
+
+		if (dma_tx_status)
+			writel(dma_tx_status, se->base + SE_DMA_TX_IRQ_CLR);
+		if (dma_rx_status)
+			writel(dma_rx_status, se->base + SE_DMA_RX_IRQ_CLR);
+		if (dma_tx_status & TX_DMA_DONE)
+			mas->tx_rem_bytes = 0;
+		if (dma_rx_status & RX_DMA_DONE)
+			mas->rx_rem_bytes = 0;
+		if (dma_tx_status & TX_RESET_DONE)
+			complete(&mas->tx_reset_done);
+		if (dma_rx_status & RX_RESET_DONE)
+			complete(&mas->rx_reset_done);
+		if (!mas->tx_rem_bytes && !mas->rx_rem_bytes && xfer) {
+			if (xfer->tx_buf && mas->tx_se_dma) {
+				geni_se_tx_dma_unprep(se, mas->tx_se_dma, xfer->len);
+				mas->tx_se_dma = 0;
+			}
+			if (xfer->rx_buf && mas->rx_se_dma) {
+				geni_se_rx_dma_unprep(se, mas->rx_se_dma, xfer->len);
+				mas->rx_se_dma = 0;
+			}
 			spi_finalize_current_transfer(spi);
 			mas->cur_xfer = NULL;
-			/*
-			 * If this happens, then a CMD_DONE came before all the
-			 * Tx buffer bytes were sent out. This is unusual, log
-			 * this condition and disable the WM interrupt to
-			 * prevent the system from stalling due an interrupt
-			 * storm.
-			 *
-			 * If this happens when all Rx bytes haven't been
-			 * received, log the condition. The only known time
-			 * this can happen is if bits_per_word != 8 and some
-			 * registers that expect xfer lengths in num spi_words
-			 * weren't written correctly.
-			 */
-			if (mas->tx_rem_bytes) {
-				writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
-				dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
-					mas->tx_rem_bytes, mas->cur_bits_per_word);
-			}
-			if (mas->rx_rem_bytes)
-				dev_err(mas->dev, "Premature done. rx_rem = %d bpw%d\n",
-					mas->rx_rem_bytes, mas->cur_bits_per_word);
-		} else {
-			complete(&mas->cs_done);
 		}
 	}
 
@@ -949,6 +1066,8 @@ static int spi_geni_probe(struct platform_device *pdev)
 	init_completion(&mas->cs_done);
 	init_completion(&mas->cancel_done);
 	init_completion(&mas->abort_done);
+	init_completion(&mas->tx_reset_done);
+	init_completion(&mas->rx_reset_done);
 	spin_lock_init(&mas->lock);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.

