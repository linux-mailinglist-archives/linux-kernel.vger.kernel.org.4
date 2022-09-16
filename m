Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1180A5BAC95
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiIPLkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIPLj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:39:57 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39A227CC0;
        Fri, 16 Sep 2022 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663328396;
  x=1694864396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5gyRJMshptIEnXvFy/S2sxnAHY4n+uAltIvtK8WJPTI=;
  b=T0EL9QrklCuUoZu8crHKzLsYGXNRZ9dBdYQ/h+7zDD29OAbgLMLYVT3m
   EP9//+DH5WmQYF83/+vS8DNCbv8QgKyK8AY4EbvWPY/B2+hUFf+k/EDP+
   3ylxeSKpxKQIIYB4Yacm6jDDQL1PUoT4L4TO7i4S4lfwmAFdEU1uSeIKJ
   pw8Q0u6lFWabYkZRHCLWynHdoKA13ze98IpHg867yna+5iDQVablERiRI
   D5xk67b0VHK5zpL1JevgcQSPzqTG0g1HTko5FSGbK5PmeArYIl6yvXAkL
   h7/SgfAIissQKivjP3NFp1vXWy6q+2MkoslaWFEmagb9ohEiGixBSIUv/
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <broonie@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <andi@etezian.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <alim.akhtar@samsung.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/4] spi: Save current RX and TX DMA devices
Date:   Fri, 16 Sep 2022 13:39:49 +0200
Message-ID: <20220916113951.228398-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916113951.228398-1-vincent.whitchurch@axis.com>
References: <20220916113951.228398-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the current RX and TX DMA devices to avoid having to duplicate the
logic to pick them, since we'll need access to them in some more
functions to fix a bug in the cache handling.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/spi/spi.c       | 19 ++++---------------
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 32c01e684af3..a9134d062ff1 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1147,6 +1147,8 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 		}
 	}
 
+	ctlr->cur_rx_dma_dev = rx_dev;
+	ctlr->cur_tx_dma_dev = tx_dev;
 	ctlr->cur_msg_mapped = true;
 
 	return 0;
@@ -1154,26 +1156,13 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 
 static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
 {
+	struct device *rx_dev = ctlr->cur_rx_dma_dev;
+	struct device *tx_dev = ctlr->cur_tx_dma_dev;
 	struct spi_transfer *xfer;
-	struct device *tx_dev, *rx_dev;
 
 	if (!ctlr->cur_msg_mapped || !ctlr->can_dma)
 		return 0;
 
-	if (ctlr->dma_tx)
-		tx_dev = ctlr->dma_tx->device->dev;
-	else if (ctlr->dma_map_dev)
-		tx_dev = ctlr->dma_map_dev;
-	else
-		tx_dev = ctlr->dev.parent;
-
-	if (ctlr->dma_rx)
-		rx_dev = ctlr->dma_rx->device->dev;
-	else if (ctlr->dma_map_dev)
-		rx_dev = ctlr->dma_map_dev;
-	else
-		rx_dev = ctlr->dev.parent;
-
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (!ctlr->can_dma(ctlr, msg->spi, xfer))
 			continue;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f089ee1ead58..7466a171d7e5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -378,6 +378,8 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @cleanup: frees controller-specific state
  * @can_dma: determine whether this controller supports DMA
  * @dma_map_dev: device which can be used for DMA mapping
+ * @cur_rx_dma_dev: device which is currently used for RX DMA mapping
+ * @cur_tx_dma_dev: device which is currently used for TX DMA mapping
  * @queued: whether this controller is providing an internal message queue
  * @kworker: pointer to thread struct for message pump
  * @pump_messages: work struct for scheduling work to the message pump
@@ -610,6 +612,8 @@ struct spi_controller {
 					   struct spi_device *spi,
 					   struct spi_transfer *xfer);
 	struct device *dma_map_dev;
+	struct device *cur_rx_dma_dev;
+	struct device *cur_tx_dma_dev;
 
 	/*
 	 * These hooks are for drivers that want to use the generic
-- 
2.34.1

