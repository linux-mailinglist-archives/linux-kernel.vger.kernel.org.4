Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6903D5EC126
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiI0LX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiI0LXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:23:09 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A081913E7DC;
        Tue, 27 Sep 2022 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664277713;
  x=1695813713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r9z94nHNbG/a3bIMb6JB09Z2qRd5LB6E0MBIYBQgOAE=;
  b=SoT9DtW2m2H2jeVrb/N8+U+iqGJFc2f2fBMM82CxZnPClXAWHdOsz/Jk
   knsbru/ncOM0CGg2biKkMyJS4u0mjQMYyjVGObC34ZjzjaIsi7y3bOdJK
   588WlhWJOfTKXIuyOMnxJN4wpjFitMr1xThC4fmhZ0HTe/eUYkq6pfPhE
   YSiDezPuaXcViOnADnOlhVbNQDR+E9tLWa4rp715u/t3tvIhK1zcI6xl4
   FdvMXKk5mDJgi9WnDOw/4NNeeS3PsZFXL5qPkD+lZifVf/niv4lRvy7Ku
   ZyZEQUc3z2UK1VSAqmCQkUIXgGlMKTaCTmX7PD+hHgYeUbMErR010YHR2
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <broonie@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <andi@etezian.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <alim.akhtar@samsung.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/4] spi: Save current RX and TX DMA devices
Date:   Tue, 27 Sep 2022 13:21:14 +0200
Message-ID: <20220927112117.77599-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927112117.77599-1-vincent.whitchurch@axis.com>
References: <20220927112117.77599-1-vincent.whitchurch@axis.com>
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
index ad254b94308e..dd885df23870 100644
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
index 6ea889df0813..fbf8c0d95968 100644
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

