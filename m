Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E421C6C9A92
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 06:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjC0Eet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 00:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjC0Eeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 00:34:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E3C4EE5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 21:34:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a25230b000000b00b6871c296bdso7511306ybj.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 21:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679891682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VG/HvUw/PP37KI/XKQFqpADZ9ObCJ4VT1NOEIFfNK/E=;
        b=pM+LwhD3ggqo9bgMbnbO9Yva/UyIsOxTmO21qvA6luLZ6U2cgzwdZFLYFPgSHPVlUQ
         tsdfgUYVKJE95VuIUqaj8h2J+aj214dZiWkLtqjImSFPcAio5QdK7+D6jrNM8QiZ7AVh
         c38ix9D/3Vc6ysQ06X5/iwmWDywPlItycIrdBPaFUNNl5HNp7nbV3aYr+bvIeSmYXhh2
         qN6m+DKRIbV2489BIVWmJ8Mz4DtpGREiw6qlBpbtDrSzhKhbyigs2sezKJby13iI6GnL
         HdQCaOD2J4ppt4j4zMlcIf/NsAlz6OdNsrW8bNBbJ73BVKrhA7z7TBJnyG8uQ5p+pfpp
         CjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679891682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG/HvUw/PP37KI/XKQFqpADZ9ObCJ4VT1NOEIFfNK/E=;
        b=2dKCe+2Qi4i9uIu/vy7+X5CQUqt33oOF4vd9ePJgnLi+Orhof2ITpIBtUOT4iKh7/d
         n0WdKVgc0IBe7ayiKk2YPnvX6nk3nsWxwl4eiW48mVJFAxcj8WXHjbe2XNS4XBdl1jrt
         VLda2LGEggq8znSKtqz8uUW4HesCqrvLRBFKvcZRro/1j5mePy7xbjhWgwIEBSyitbze
         TVy9wM+mFIJp/Skatff3/ET9uZArXKFMgRROpM//r3xEVc0FUOJrSZgKcgo3r0JR2bQJ
         iXWwPSjTfZ9kSOBd7xfbLZ9n/8nuOWE8HBKLBN+Bzex6GWHQTbTq4evoCvGFeDUcgFs8
         6KKw==
X-Gm-Message-State: AAQBX9cEovQbdgp304IBu1tRDEntYBut/ohfESe920y0Gt3YiU2idArI
        rdzaN60R36KMhDj7+MKG5SpObiDfQ4Eayw==
X-Google-Smtp-Source: AKy350ZXJZviXm8HfwB9YHoi/CVb2Kj7hlgiEXU+jU13sutzvwfU4OxECvQ5ljqC3Aq8ORFQfuchjMCeAe+Y7g==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:168d:b0:b26:47f3:6cb with SMTP
 id bx13-20020a056902168d00b00b2647f306cbmr4767865ybb.4.1679891681999; Sun, 26
 Mar 2023 21:34:41 -0700 (PDT)
Date:   Mon, 27 Mar 2023 04:34:05 +0000
In-Reply-To: <20230327043405.881645-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230327043405.881645-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230327043405.881645-3-joychakr@google.com>
Subject: [PATCH v4 2/2] spi: dw: Add dma controller capability checks
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
 drivers/spi/spi-dw-dma.c | 54 ++++++++++++++++++++++++++++++++--------
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index b3a88bb75907..f47483ec369f 100644
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
@@ -72,12 +74,15 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 	dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
 }
 
-static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
+static int dw_spi_dma_caps_init(struct dw_spi *dws)
 {
+	int ret;
 	struct dma_slave_caps tx = {0}, rx = {0};
 
-	dma_get_slave_caps(dws->txchan, &tx);
-	dma_get_slave_caps(dws->rxchan, &rx);
+	ret = dma_get_slave_caps(dws->txchan, &tx);
+	ret |= dma_get_slave_caps(dws->rxchan, &rx);
+	if (ret)
+		return ret;
 
 	if (tx.max_sg_burst > 0 && rx.max_sg_burst > 0)
 		dws->dma_sg_burst = min(tx.max_sg_burst, rx.max_sg_burst);
@@ -87,6 +92,18 @@ static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
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
+	if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
+	      rx.directions & BIT(DMA_DEV_TO_MEM)))
+		return -ENXIO;
+
+	return 0;
 }
 
 static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
@@ -95,6 +112,7 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;
 	struct pci_dev *dma_dev;
 	dma_cap_mask_t mask;
+	int ret = -EBUSY;
 
 	/*
 	 * Get pci device for DMA controller, currently it could only
@@ -124,20 +142,24 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 	init_completion(&dws->dma_completion);
 
-	dw_spi_dma_maxburst_init(dws);
+	ret = dw_spi_dma_caps_init(dws);
+	if (ret)
+		goto free_txchan;
 
-	dw_spi_dma_sg_burst_init(dws);
+	dw_spi_dma_maxburst_init(dws);
 
 	pci_dev_put(dma_dev);
 
 	return 0;
-
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
@@ -163,12 +185,16 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 
 	init_completion(&dws->dma_completion);
 
-	dw_spi_dma_maxburst_init(dws);
+	ret = dw_spi_dma_caps_init(dws);
+	if (ret)
+		goto free_txchan;
 
-	dw_spi_dma_sg_burst_init(dws);
+	dw_spi_dma_maxburst_init(dws);
 
 	return 0;
-
+free_txchan:
+	dma_release_channel(dws->txchan);
+	dws->txchan = NULL;
 free_rxchan:
 	dma_release_channel(dws->rxchan);
 	dws->rxchan = NULL;
@@ -202,8 +228,14 @@ static bool dw_spi_can_dma(struct spi_controller *master,
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
2.40.0.348.gf938b09366-goog

