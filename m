Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0B05BAC9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiIPLkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiIPLkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:40:02 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7203D3DF26;
        Fri, 16 Sep 2022 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663328400;
  x=1694864400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4yNTGVfkoVx35F4Rlaa4nrJcCFACuKVLiDINNr/ayco=;
  b=MMNLkZUOHNK0RhQXaN9n1tYxRH3kGsv2gBh2bO0Wxcladb/mm7jT9fsd
   oQPIIUx/PuKZVBMZo0EXkC1rRRgJcHrjUvSmZ50bYAxMi31aWtPh3VajA
   GBQShk1O8pufkPVXscDwizvjKF6I3ks5UyH6DWiYQfFr5K1o510mcEBYe
   Rx6UnP+O7tvTz5VUZxlgOGsM3QUX0rGoESHc4k9oUvx+JaVyzgizQH83h
   WIGXJXFN23oV2k8YQhbXtSy6RwNSUFg/7EIiqAe0nhAZg0bsu8HHpkX+z
   s1mghIlK+lPmXLaaWL2/1sihzJAWl3zKEt1TnK3q0GEluEkh1t88HgSKV
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
Subject: [PATCH 3/4] spi: Fix cache corruption due to DMA/PIO overlap
Date:   Fri, 16 Sep 2022 13:39:50 +0200
Message-ID: <20220916113951.228398-4-vincent.whitchurch@axis.com>
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

The SPI core DMA mapping support performs cache management once for the
entire message and not between transfers, and this leads to cache
corruption if a message has two or more RX transfers with both
transfers targeting the same cache line, and the controller driver
decides to handle one using DMA and the other using PIO (for example,
because one is much larger than the other).

Fix it by syncing before/after the actual transfers.  This also means
that we can skip the sync during the map/unmap of the message.

Fixes: 99adef310f682d6343 ("spi: Provide core support for DMA mapping transfers")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/spi/spi.c | 107 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 86 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a9134d062ff1..f7cd737bbf6f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1010,9 +1010,9 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 }
 
 #ifdef CONFIG_HAS_DMA
-int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
-		struct sg_table *sgt, void *buf, size_t len,
-		enum dma_data_direction dir)
+static int spi_map_buf_attrs(struct spi_controller *ctlr, struct device *dev,
+			     struct sg_table *sgt, void *buf, size_t len,
+			     enum dma_data_direction dir, unsigned long attrs)
 {
 	const bool vmalloced_buf = is_vmalloc_addr(buf);
 	unsigned int max_seg_size = dma_get_max_seg_size(dev);
@@ -1078,28 +1078,39 @@ int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
 		sg = sg_next(sg);
 	}
 
-	ret = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
-	if (!ret)
-		ret = -ENOMEM;
+	ret = dma_map_sgtable(dev, sgt, dir, attrs);
 	if (ret < 0) {
 		sg_free_table(sgt);
 		return ret;
 	}
 
-	sgt->nents = ret;
-
 	return 0;
 }
 
-void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
-		   struct sg_table *sgt, enum dma_data_direction dir)
+int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
+		struct sg_table *sgt, void *buf, size_t len,
+		enum dma_data_direction dir)
+{
+	return spi_map_buf_attrs(ctlr, dev, sgt, buf, len, dir, 0);
+}
+
+static void spi_unmap_buf_attrs(struct spi_controller *ctlr,
+				struct device *dev, struct sg_table *sgt,
+				enum dma_data_direction dir,
+				unsigned long attrs)
 {
 	if (sgt->orig_nents) {
-		dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
+		dma_unmap_sgtable(dev, sgt, dir, attrs);
 		sg_free_table(sgt);
 	}
 }
 
+void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
+		   struct sg_table *sgt, enum dma_data_direction dir)
+{
+	spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
+}
+
 static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 {
 	struct device *tx_dev, *rx_dev;
@@ -1124,24 +1135,30 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 		rx_dev = ctlr->dev.parent;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		/* The sync is done before each transfer. */
+		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
+
 		if (!ctlr->can_dma(ctlr, msg->spi, xfer))
 			continue;
 
 		if (xfer->tx_buf != NULL) {
-			ret = spi_map_buf(ctlr, tx_dev, &xfer->tx_sg,
-					  (void *)xfer->tx_buf, xfer->len,
-					  DMA_TO_DEVICE);
+			ret = spi_map_buf_attrs(ctlr, tx_dev, &xfer->tx_sg,
+						(void *)xfer->tx_buf,
+						xfer->len, DMA_TO_DEVICE,
+						attrs);
 			if (ret != 0)
 				return ret;
 		}
 
 		if (xfer->rx_buf != NULL) {
-			ret = spi_map_buf(ctlr, rx_dev, &xfer->rx_sg,
-					  xfer->rx_buf, xfer->len,
-					  DMA_FROM_DEVICE);
+			ret = spi_map_buf_attrs(ctlr, rx_dev, &xfer->rx_sg,
+						xfer->rx_buf, xfer->len,
+						DMA_FROM_DEVICE, attrs);
 			if (ret != 0) {
-				spi_unmap_buf(ctlr, tx_dev, &xfer->tx_sg,
-					      DMA_TO_DEVICE);
+				spi_unmap_buf_attrs(ctlr, tx_dev,
+						&xfer->tx_sg, DMA_TO_DEVICE,
+						attrs);
+
 				return ret;
 			}
 		}
@@ -1164,17 +1181,52 @@ static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
 		return 0;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		/* The sync has already been done after each transfer. */
+		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
+
 		if (!ctlr->can_dma(ctlr, msg->spi, xfer))
 			continue;
 
-		spi_unmap_buf(ctlr, rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
-		spi_unmap_buf(ctlr, tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
+		spi_unmap_buf_attrs(ctlr, rx_dev, &xfer->rx_sg,
+				    DMA_FROM_DEVICE, attrs);
+		spi_unmap_buf_attrs(ctlr, tx_dev, &xfer->tx_sg,
+				    DMA_TO_DEVICE, attrs);
 	}
 
 	ctlr->cur_msg_mapped = false;
 
 	return 0;
 }
+
+static void spi_dma_sync_for_device(struct spi_controller *ctlr,
+				    struct spi_transfer *xfer)
+{
+	struct device *rx_dev = ctlr->cur_rx_dma_dev;
+	struct device *tx_dev = ctlr->cur_tx_dma_dev;
+
+	if (!ctlr->cur_msg_mapped)
+		return;
+
+	if (xfer->tx_sg.orig_nents)
+		dma_sync_sgtable_for_device(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
+	if (xfer->rx_sg.orig_nents)
+		dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
+}
+
+static void spi_dma_sync_for_cpu(struct spi_controller *ctlr,
+				 struct spi_transfer *xfer)
+{
+	struct device *rx_dev = ctlr->cur_rx_dma_dev;
+	struct device *tx_dev = ctlr->cur_tx_dma_dev;
+
+	if (!ctlr->cur_msg_mapped)
+		return;
+
+	if (xfer->rx_sg.orig_nents)
+		dma_sync_sgtable_for_cpu(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
+	if (xfer->tx_sg.orig_nents)
+		dma_sync_sgtable_for_cpu(tx_dev, &xfer->tx_sg, DMA_TO_DEVICE);
+}
 #else /* !CONFIG_HAS_DMA */
 static inline int __spi_map_msg(struct spi_controller *ctlr,
 				struct spi_message *msg)
@@ -1187,6 +1239,14 @@ static inline int __spi_unmap_msg(struct spi_controller *ctlr,
 {
 	return 0;
 }
+
+void spi_dma_sync_for_device(struct spi_controller *ctrl, struct spi_transfer *xfer)
+{
+}
+
+void spi_dma_sync_for_cpu(struct spi_controller *ctrl, struct spi_transfer *xfer)
+{
+}
 #endif /* !CONFIG_HAS_DMA */
 
 static inline int spi_unmap_msg(struct spi_controller *ctlr,
@@ -1444,8 +1504,11 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 			reinit_completion(&ctlr->xfer_completion);
 
 fallback_pio:
+			spi_dma_sync_for_device(ctlr, xfer);
 			ret = ctlr->transfer_one(ctlr, msg->spi, xfer);
 			if (ret < 0) {
+				spi_dma_sync_for_cpu(ctlr, xfer);
+
 				if (ctlr->cur_msg_mapped &&
 				   (xfer->error & SPI_TRANS_FAIL_NO_START)) {
 					__spi_unmap_msg(ctlr, msg);
@@ -1468,6 +1531,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				if (ret < 0)
 					msg->status = ret;
 			}
+
+			spi_dma_sync_for_cpu(ctlr, xfer);
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,
-- 
2.34.1

