Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AE36CFBB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjC3GfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjC3GfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:35:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA106EAC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:35:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z31-20020a25a122000000b00b38d2b9a2e9so17646287ybh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680158110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzZwH9dx6YYRbHyGgT/KwAafiDr7gE6Ub/HAeGpi8so=;
        b=PtX3mfZr5CTIsFKLYUeNTY7i6yuYbZzXZyEvyS5af/OL4PtfP6iGECY2k8vNwe3I6D
         v8/GZMbMY8NDl4YMHPAiyJ1sMDvig88wm4/J6+PqVX0pHUxleuNOHvb87doWo4uHjR9I
         UoO7rj68iwAFcnQHIASR6pFayWY1OAEpZGWdFUOvUx9FhiLtXP19K78MOunEVEdHJNQS
         h/3xP4QsNHqpVdODvoIYMs1/pzym+PT7ijthoKs1WG/RwcDacd0JMf0N4DcltxloPcSc
         QpBjZL8GrYoFtYsLiz6tMWyclOm7efrIAJBfth0BwK1UDI5A6NWPATquSo6k5dSJLy3q
         SeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680158110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzZwH9dx6YYRbHyGgT/KwAafiDr7gE6Ub/HAeGpi8so=;
        b=e5Uzd8tsWXOmh84DwEfq/vN3kPdPfLqUujjzgvp8zEK6fIS6o39o7xGw3F86cpY01f
         EYyd6i4i1nmiI4tw05uoq1sPfIlzRKVz0q1Nt6KIET7zjYiKlFcnqGDgQatSBjOMBO3e
         uvQY9vD7NXeLO8TGFxN87t/DCtk3DN4VngKIZeH8jWZhpe8BZqdd3h0fM0oQTZNkzhjk
         b0h6ULacTzGSXdh0aAhl0jcE6MPRueNNhwWBVxtwsA1Pbi9yWdVcMyVeOcOURV4vI7L2
         ++fU9Gi7HIuVoGaspEstmp6NRBxWCnK7tfnziDRwXMnkYNCLslec2/zXJG/ra4UpEMg2
         sC/w==
X-Gm-Message-State: AAQBX9fQ6h9GKdBrV3T1O2hr4nBq1eHunDMKv7jQ5MuNRBkTsvNQU4ck
        z57Gj+r7MjADJLetFf+Y65HsjsEo5dENiw==
X-Google-Smtp-Source: AKy350Y9+srSle9Ll1/Reg2XLW+yt5Zuzpzkco+pqyJAzqdh7viXgRsPSpja27yVqImKqgvFhTfwY4Skw53uKg==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:ad21:0:b0:545:62cb:3bcf with SMTP id
 l33-20020a81ad21000000b0054562cb3bcfmr10984799ywh.2.1680158110414; Wed, 29
 Mar 2023 23:35:10 -0700 (PDT)
Date:   Thu, 30 Mar 2023 06:34:50 +0000
In-Reply-To: <20230330063450.2289058-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230330063450.2289058-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
Message-ID: <20230330063450.2289058-3-joychakr@google.com>
Subject: [PATCH v5 2/2] spi: dw: Add dma controller capability checks
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check capabilities of DMA controller during init to make sure it is
capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel
and store addr_width capabilities to check per transfer to make sure the
bits/word requirement can be met for that transfer.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 57 +++++++++++++++++++++++++++++++++-------
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index b3a88bb75907..31e40b054c82 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -23,6 +23,8 @@
 #define DW_SPI_TX_BUSY		1
 #define DW_SPI_TX_BURST_LEVEL	16
 
+static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
+
 static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *s = param;
@@ -72,12 +74,22 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 	dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
 }
 
-static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
+static int dw_spi_dma_caps_init(struct dw_spi *dws)
 {
-	struct dma_slave_caps tx = {0}, rx = {0};
+	struct dma_slave_caps tx, rx;
+	int ret;
+
+	ret = dma_get_slave_caps(dws->txchan, &tx);
+	if (ret)
+		return ret;
+
+	ret = dma_get_slave_caps(dws->rxchan, &rx);
+	if (ret)
+		return ret;
 
-	dma_get_slave_caps(dws->txchan, &tx);
-	dma_get_slave_caps(dws->rxchan, &rx);
+	if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
+	      rx.directions & BIT(DMA_DEV_TO_MEM)))
+		return -ENXIO;
 
 	if (tx.max_sg_burst > 0 && rx.max_sg_burst > 0)
 		dws->dma_sg_burst = min(tx.max_sg_burst, rx.max_sg_burst);
@@ -87,6 +99,14 @@ static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
 		dws->dma_sg_burst = rx.max_sg_burst;
 	else
 		dws->dma_sg_burst = 0;
+
+	/*
+	 * Assuming both channels belong to the same DMA controller hence the
+	 * address width capabilities most likely would be the same.
+	 */
+	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+
+	return 0;
 }
 
 static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
@@ -95,6 +115,7 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;
 	struct pci_dev *dma_dev;
 	dma_cap_mask_t mask;
+	int ret = -EBUSY;
 
 	/*
 	 * Get pci device for DMA controller, currently it could only
@@ -124,20 +145,25 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 	init_completion(&dws->dma_completion);
 
-	dw_spi_dma_maxburst_init(dws);
+	ret = dw_spi_dma_caps_init(dws);
+	if (ret)
+		goto free_txchan;
 
-	dw_spi_dma_sg_burst_init(dws);
+	dw_spi_dma_maxburst_init(dws);
 
 	pci_dev_put(dma_dev);
 
 	return 0;
 
+free_txchan:
+	dma_release_channel(dws->txchan);
+	dws->txchan = NULL;
 free_rxchan:
 	dma_release_channel(dws->rxchan);
 	dws->rxchan = NULL;
 err_exit:
 	pci_dev_put(dma_dev);
-	return -EBUSY;
+	return ret;
 }
 
 static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
@@ -163,12 +189,17 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 
 	init_completion(&dws->dma_completion);
 
-	dw_spi_dma_maxburst_init(dws);
+	ret = dw_spi_dma_caps_init(dws);
+	if (ret)
+		goto free_txchan;
 
-	dw_spi_dma_sg_burst_init(dws);
+	dw_spi_dma_maxburst_init(dws);
 
 	return 0;
 
+free_txchan:
+	dma_release_channel(dws->txchan);
+	dws->txchan = NULL;
 free_rxchan:
 	dma_release_channel(dws->rxchan);
 	dws->rxchan = NULL;
@@ -202,8 +233,14 @@ static bool dw_spi_can_dma(struct spi_controller *master,
 			   struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
+	enum dma_slave_buswidth dma_bus_width;
+
+	if (xfer->len <= dws->fifo_len)
+		return false;
+
+	dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
 
-	return xfer->len > dws->fifo_len;
+	return dws->dma_addr_widths & BIT(dma_bus_width);
 }
 
 static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 9e8eb2b52d5c..3962e6dcf880 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -190,6 +190,7 @@ struct dw_spi {
 	struct dma_chan		*rxchan;
 	u32			rxburst;
 	u32			dma_sg_burst;
+	u32			dma_addr_widths;
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;
-- 
2.40.0.423.gd6c402a77b-goog

