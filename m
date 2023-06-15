Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795EA73119A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244146AbjFOH7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbjFOH7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:59:05 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0443199;
        Thu, 15 Jun 2023 00:59:02 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F6ZvHV016185;
        Thu, 15 Jun 2023 09:58:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=dREvsyw7HQDk5hfPxgU2KifXDGqOvti1Ji90FByaN20=;
 b=NZkS0Ob4MF2/P3GLosEvaBeVR0d9dS6K544enlPB0QkTfgtB456TeUbYzfp25xOwBnPK
 z7W0yj4zez7eyRhTZQs0SKZdLxfs9aOxcWkpFkdmOqW3gtqEikoH4ckgA5GmDIu4XXLx
 sKtlQNtK8aeJXz8zSBapxtzUlTrUX8K0C5A8V0N0v5ps/sZFEeuur9XcNfXqTJHwEemo
 bmpnFl+NW2Krvuo7FmWUIW7LTn0WJVzZOp0Na+2OZoQxq8ku8IBHnwE6/Vr2/zIyahCV
 uQEFckRQ6TRRkQ/0SB2RHL0f3wvTw3b2QPokHCpjopWwfgVsotM+gYlD8JJDHRLPNMqm ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7wgx0trq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 09:58:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C618D10002A;
        Thu, 15 Jun 2023 09:58:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC83C21682B;
        Thu, 15 Jun 2023 09:58:47 +0200 (CEST)
Received: from localhost (10.252.8.64) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 09:58:47 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v3 1/4] spi: stm32: renaming of spi_master into spi_controller
Date:   Thu, 15 Jun 2023 09:58:12 +0200
Message-ID: <20230615075815.310261-2-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615075815.310261-1-valentin.caron@foss.st.com>
References: <20230615075815.310261-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.8.64]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_04,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@foss.st.com>

Preparing introduction of SPI device, rename the spi_master structure
into spi_controller. This doesn't have any functional impact since
spi_master was already a macro for spi_controller.
Referring now to ctrl instead of master since the spi_controller
structure might not be used as a master controller only.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/spi/spi-stm32.c | 154 ++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index d6598e4116bd..5d9439ae1c09 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// STMicroelectronics STM32 SPI Controller driver (master mode only)
+// STMicroelectronics STM32 SPI Controller driver
 //
 // Copyright (C) 2017, STMicroelectronics - All Rights Reserved
 // Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
@@ -258,7 +258,7 @@ struct stm32_spi_cfg {
 /**
  * struct stm32_spi - private data of the SPI controller
  * @dev: driver model representation of the controller
- * @master: controller master interface
+ * @ctrl: controller interface
  * @cfg: compatible configuration data
  * @base: virtual memory area
  * @clk: hw kernel clock feeding the SPI clock generator
@@ -283,7 +283,7 @@ struct stm32_spi_cfg {
  */
 struct stm32_spi {
 	struct device *dev;
-	struct spi_master *master;
+	struct spi_controller *ctrl;
 	const struct stm32_spi_cfg *cfg;
 	void __iomem *base;
 	struct clk *clk;
@@ -437,9 +437,9 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
 	div = DIV_ROUND_CLOSEST(spi->clk_rate & ~0x1, speed_hz);
 
 	/*
-	 * SPI framework set xfer->speed_hz to master->max_speed_hz if
-	 * xfer->speed_hz is greater than master->max_speed_hz, and it returns
-	 * an error when xfer->speed_hz is lower than master->min_speed_hz, so
+	 * SPI framework set xfer->speed_hz to ctrl->max_speed_hz if
+	 * xfer->speed_hz is greater than ctrl->max_speed_hz, and it returns
+	 * an error when xfer->speed_hz is lower than ctrl->min_speed_hz, so
 	 * no need to check it there.
 	 * However, we need to ensure the following calculations.
 	 */
@@ -714,19 +714,19 @@ static void stm32h7_spi_disable(struct stm32_spi *spi)
 
 /**
  * stm32_spi_can_dma - Determine if the transfer is eligible for DMA use
- * @master: controller master interface
+ * @ctrl: controller interface
  * @spi_dev: pointer to the spi device
  * @transfer: pointer to spi transfer
  *
  * If driver has fifo and the current transfer size is greater than fifo size,
  * use DMA. Otherwise use DMA for transfer longer than defined DMA min bytes.
  */
-static bool stm32_spi_can_dma(struct spi_master *master,
+static bool stm32_spi_can_dma(struct spi_controller *ctrl,
 			      struct spi_device *spi_dev,
 			      struct spi_transfer *transfer)
 {
 	unsigned int dma_size;
-	struct stm32_spi *spi = spi_master_get_devdata(master);
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 
 	if (spi->cfg->has_fifo)
 		dma_size = spi->fifo_size;
@@ -742,12 +742,12 @@ static bool stm32_spi_can_dma(struct spi_master *master,
 /**
  * stm32f4_spi_irq_event - Interrupt handler for SPI controller events
  * @irq: interrupt line
- * @dev_id: SPI controller master interface
+ * @dev_id: SPI controller ctrl interface
  */
 static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct stm32_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *ctrl = dev_id;
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 	u32 sr, mask = 0;
 	bool end = false;
 
@@ -830,14 +830,14 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 /**
  * stm32f4_spi_irq_thread - Thread of interrupt handler for SPI controller
  * @irq: interrupt line
- * @dev_id: SPI controller master interface
+ * @dev_id: SPI controller interface
  */
 static irqreturn_t stm32f4_spi_irq_thread(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct stm32_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *ctrl = dev_id;
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 
-	spi_finalize_current_transfer(master);
+	spi_finalize_current_transfer(ctrl);
 	stm32f4_spi_disable(spi);
 
 	return IRQ_HANDLED;
@@ -846,12 +846,12 @@ static irqreturn_t stm32f4_spi_irq_thread(int irq, void *dev_id)
 /**
  * stm32h7_spi_irq_thread - Thread of interrupt handler for SPI controller
  * @irq: interrupt line
- * @dev_id: SPI controller master interface
+ * @dev_id: SPI controller interface
  */
 static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 {
-	struct spi_master *master = dev_id;
-	struct stm32_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *ctrl = dev_id;
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 	u32 sr, ier, mask;
 	unsigned long flags;
 	bool end = false;
@@ -931,7 +931,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 
 	if (end) {
 		stm32h7_spi_disable(spi);
-		spi_finalize_current_transfer(master);
+		spi_finalize_current_transfer(ctrl);
 	}
 
 	return IRQ_HANDLED;
@@ -939,13 +939,13 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 
 /**
  * stm32_spi_prepare_msg - set up the controller to transfer a single message
- * @master: controller master interface
+ * @ctrl: controller interface
  * @msg: pointer to spi message
  */
-static int stm32_spi_prepare_msg(struct spi_master *master,
+static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 				 struct spi_message *msg)
 {
-	struct stm32_spi *spi = spi_master_get_devdata(master);
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 	struct spi_device *spi_dev = msg->spi;
 	struct device_node *np = spi_dev->dev.of_node;
 	unsigned long flags;
@@ -984,9 +984,9 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 	if (spi->cfg->set_number_of_data) {
 		int ret;
 
-		ret = spi_split_transfers_maxwords(master, msg,
-						   STM32H7_SPI_TSIZE_MAX,
-						   GFP_KERNEL | GFP_DMA);
+		ret = spi_split_transfers_maxsize(ctrl, msg,
+						  STM32H7_SPI_TSIZE_MAX,
+						  GFP_KERNEL | GFP_DMA);
 		if (ret)
 			return ret;
 	}
@@ -1016,7 +1016,7 @@ static void stm32f4_spi_dma_tx_cb(void *data)
 	struct stm32_spi *spi = data;
 
 	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
-		spi_finalize_current_transfer(spi->master);
+		spi_finalize_current_transfer(spi->ctrl);
 		stm32f4_spi_disable(spi);
 	}
 }
@@ -1031,7 +1031,7 @@ static void stm32_spi_dma_rx_cb(void *data)
 {
 	struct stm32_spi *spi = data;
 
-	spi_finalize_current_transfer(spi->master);
+	spi_finalize_current_transfer(spi->ctrl);
 	spi->cfg->disable(spi);
 }
 
@@ -1589,18 +1589,18 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 
 /**
  * stm32_spi_transfer_one - transfer a single spi_transfer
- * @master: controller master interface
+ * @ctrl: controller interface
  * @spi_dev: pointer to the spi device
  * @transfer: pointer to spi transfer
  *
  * It must return 0 if the transfer is finished or 1 if the transfer is still
  * in progress.
  */
-static int stm32_spi_transfer_one(struct spi_master *master,
+static int stm32_spi_transfer_one(struct spi_controller *ctrl,
 				  struct spi_device *spi_dev,
 				  struct spi_transfer *transfer)
 {
-	struct stm32_spi *spi = spi_master_get_devdata(master);
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 	int ret;
 
 	spi->tx_buf = transfer->tx_buf;
@@ -1608,8 +1608,8 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 	spi->tx_len = spi->tx_buf ? transfer->len : 0;
 	spi->rx_len = spi->rx_buf ? transfer->len : 0;
 
-	spi->cur_usedma = (master->can_dma &&
-			   master->can_dma(master, spi_dev, transfer));
+	spi->cur_usedma = (ctrl->can_dma &&
+			   ctrl->can_dma(ctrl, spi_dev, transfer));
 
 	ret = stm32_spi_transfer_one_setup(spi, spi_dev, transfer);
 	if (ret) {
@@ -1625,13 +1625,13 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 
 /**
  * stm32_spi_unprepare_msg - relax the hardware
- * @master: controller master interface
+ * @ctrl: controller interface
  * @msg: pointer to the spi message
  */
-static int stm32_spi_unprepare_msg(struct spi_master *master,
+static int stm32_spi_unprepare_msg(struct spi_controller *ctrl,
 				   struct spi_message *msg)
 {
-	struct stm32_spi *spi = spi_master_get_devdata(master);
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 
 	spi->cfg->disable(spi);
 
@@ -1758,22 +1758,22 @@ MODULE_DEVICE_TABLE(of, stm32_spi_of_match);
 
 static int stm32_spi_probe(struct platform_device *pdev)
 {
-	struct spi_master *master;
+	struct spi_controller *ctrl;
 	struct stm32_spi *spi;
 	struct resource *res;
 	struct reset_control *rst;
 	int ret;
 
-	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct stm32_spi));
-	if (!master) {
+	ctrl = devm_spi_alloc_master(&pdev->dev, sizeof(struct stm32_spi));
+	if (!ctrl) {
 		dev_err(&pdev->dev, "spi master allocation failed\n");
 		return -ENOMEM;
 	}
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, ctrl);
 
-	spi = spi_master_get_devdata(master);
+	spi = spi_controller_get_devdata(ctrl);
 	spi->dev = &pdev->dev;
-	spi->master = master;
+	spi->ctrl = ctrl;
 	spin_lock_init(&spi->lock);
 
 	spi->cfg = (const struct stm32_spi_cfg *)
@@ -1794,7 +1794,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, spi->irq,
 					spi->cfg->irq_handler_event,
 					spi->cfg->irq_handler_thread,
-					IRQF_ONESHOT, pdev->name, master);
+					IRQF_ONESHOT, pdev->name, ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "irq%d request failed: %d\n", spi->irq,
 			ret);
@@ -1843,19 +1843,19 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	master->dev.of_node = pdev->dev.of_node;
-	master->auto_runtime_pm = true;
-	master->bus_num = pdev->id;
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    SPI_3WIRE;
-	master->bits_per_word_mask = spi->cfg->get_bpw_mask(spi);
-	master->max_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_min;
-	master->min_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_max;
-	master->use_gpio_descriptors = true;
-	master->prepare_message = stm32_spi_prepare_msg;
-	master->transfer_one = stm32_spi_transfer_one;
-	master->unprepare_message = stm32_spi_unprepare_msg;
-	master->flags = spi->cfg->flags;
+	ctrl->dev.of_node = pdev->dev.of_node;
+	ctrl->auto_runtime_pm = true;
+	ctrl->bus_num = pdev->id;
+	ctrl->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST |
+			  SPI_3WIRE;
+	ctrl->bits_per_word_mask = spi->cfg->get_bpw_mask(spi);
+	ctrl->max_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_min;
+	ctrl->min_speed_hz = spi->clk_rate / spi->cfg->baud_rate_div_max;
+	ctrl->use_gpio_descriptors = true;
+	ctrl->prepare_message = stm32_spi_prepare_msg;
+	ctrl->transfer_one = stm32_spi_transfer_one;
+	ctrl->unprepare_message = stm32_spi_unprepare_msg;
+	ctrl->flags = spi->cfg->flags;
 
 	spi->dma_tx = dma_request_chan(spi->dev, "tx");
 	if (IS_ERR(spi->dma_tx)) {
@@ -1866,7 +1866,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 
 		dev_warn(&pdev->dev, "failed to request tx dma channel\n");
 	} else {
-		master->dma_tx = spi->dma_tx;
+		ctrl->dma_tx = spi->dma_tx;
 	}
 
 	spi->dma_rx = dma_request_chan(spi->dev, "rx");
@@ -1878,11 +1878,11 @@ static int stm32_spi_probe(struct platform_device *pdev)
 
 		dev_warn(&pdev->dev, "failed to request rx dma channel\n");
 	} else {
-		master->dma_rx = spi->dma_rx;
+		ctrl->dma_rx = spi->dma_rx;
 	}
 
 	if (spi->dma_tx || spi->dma_rx)
-		master->can_dma = stm32_spi_can_dma;
+		ctrl->can_dma = stm32_spi_can_dma;
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
 					 STM32_SPI_AUTOSUSPEND_DELAY);
@@ -1891,9 +1891,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(ctrl);
 	if (ret) {
-		dev_err(&pdev->dev, "spi master registration failed: %d\n",
+		dev_err(&pdev->dev, "spi controller registration failed: %d\n",
 			ret);
 		goto err_pm_disable;
 	}
@@ -1923,12 +1923,12 @@ static int stm32_spi_probe(struct platform_device *pdev)
 
 static void stm32_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct stm32_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *ctrl = platform_get_drvdata(pdev);
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 
 	pm_runtime_get_sync(&pdev->dev);
 
-	spi_unregister_master(master);
+	spi_unregister_controller(ctrl);
 	spi->cfg->disable(spi);
 
 	pm_runtime_disable(&pdev->dev);
@@ -1936,10 +1936,10 @@ static void stm32_spi_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
-	if (master->dma_tx)
-		dma_release_channel(master->dma_tx);
-	if (master->dma_rx)
-		dma_release_channel(master->dma_rx);
+	if (ctrl->dma_tx)
+		dma_release_channel(ctrl->dma_tx);
+	if (ctrl->dma_rx)
+		dma_release_channel(ctrl->dma_rx);
 
 	clk_disable_unprepare(spi->clk);
 
@@ -1949,8 +1949,8 @@ static void stm32_spi_remove(struct platform_device *pdev)
 
 static int __maybe_unused stm32_spi_runtime_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct stm32_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 
 	clk_disable_unprepare(spi->clk);
 
@@ -1959,8 +1959,8 @@ static int __maybe_unused stm32_spi_runtime_suspend(struct device *dev)
 
 static int __maybe_unused stm32_spi_runtime_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct stm32_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 	int ret;
 
 	ret = pinctrl_pm_select_default_state(dev);
@@ -1972,10 +1972,10 @@ static int __maybe_unused stm32_spi_runtime_resume(struct device *dev)
 
 static int __maybe_unused stm32_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	int ret;
 
-	ret = spi_master_suspend(master);
+	ret = spi_controller_suspend(ctrl);
 	if (ret)
 		return ret;
 
@@ -1984,15 +1984,15 @@ static int __maybe_unused stm32_spi_suspend(struct device *dev)
 
 static int __maybe_unused stm32_spi_resume(struct device *dev)
 {
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct stm32_spi *spi = spi_master_get_devdata(master);
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 	int ret;
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
-	ret = spi_master_resume(master);
+	ret = spi_controller_resume(ctrl);
 	if (ret) {
 		clk_disable_unprepare(spi->clk);
 		return ret;
-- 
2.25.1

