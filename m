Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502B36C973B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 19:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjCZRfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 13:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjCZRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 13:35:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A4E76BF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:35:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54476ef9caeso65871407b3.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679852132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nn4CcHQY6f+/osyumFS4D5ECgTVcbf5phTsNY5AT6p0=;
        b=k4kHzLdN8mTqnSbEjYsbLNlAdV6ivn1Z2rwI5i0IVaunclsP2emP9cVoURmNh6CwTz
         GbqJFm8xvGbqNJDtvIxHnkOnKU5ruOnmB1jfFOpq8/+4F/vmT/lrTo/dy4dbS9P0/I79
         BnP0XC2Q87IqI7OkENQ0VkwDIb/zoUbLHSAv7AciRDtcTO966x1rSI07FjUYNvIDONBt
         UTj2xf/puFEbErf4/kSHXkzMoWEJqcjJW878TQ+KmeUoF5F1rGAnivk3Jl8S5WbEnMLb
         NiRU35HyHvx1BN9cMqWsQxz+CMDHpMLPpR8rkdt54yEgv+NuKBR/2+ZQAAatxGjrjt2J
         BT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679852132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nn4CcHQY6f+/osyumFS4D5ECgTVcbf5phTsNY5AT6p0=;
        b=YiSKxp3m2HjzFyO/dN+RcQw3M9BehgpA0HkdjeefQGdsAap3XxJ6OkJaGzbahLAY0u
         rnSwZCHagrQQ6ur91O8CLqWAa/7CCVzKC2zrLplQBkyLQVlJS6CV2iEqHUWU8jX9H4e7
         ts4tsyNAi6TZLEQBeJZI28OUaBZdimyId8P7t5r/+gAXtX/MQSXCFh3NLPfgnf+SfncX
         3KW6FCxrFbIiFIYMhyJAmGAuSJOc3NiaWEVknW1EXReCk5pW+Vwo3q+9C69kugJzcmf7
         Mw+HCLR+ohKPxupMIyZ0dpMAUsN6HUP1OWKDwKsCxofocy7DcVllQFVCsLygdYWG+Y9w
         0r4w==
X-Gm-Message-State: AAQBX9fi8kaxY1pyufzniBGiGqcwu8TUhqlBw0Qf4Hrgh0uSNvx8ZzLi
        zE84PdtWI7HhlUBEvFjBMSwOd4NKtrcRfQ==
X-Google-Smtp-Source: AKy350bIA6FTKaMx1Lr3Votg49I5qPynF31thJcEImjQCfaxTRC+Wx9FwvL2T2TDbzQAd6coUEPUffEYZnKb8Q==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:10c3:b0:b77:97d9:f096 with SMTP
 id w3-20020a05690210c300b00b7797d9f096mr5340906ybu.10.1679852132297; Sun, 26
 Mar 2023 10:35:32 -0700 (PDT)
Date:   Sun, 26 Mar 2023 17:35:11 +0000
In-Reply-To: <20230326173511.710749-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230326173511.710749-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230326173511.710749-3-joychakr@google.com>
Subject: [PATCH v3 2/2] spi: dw: Add dma controller capability checks
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
index b3a88bb75907..5a642ec9c269 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -23,6 +23,8 @@
 #define DW_SPI_TX_BUSY		1
 #define DW_SPI_TX_BURST_LEVEL	16
 
+static inline enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
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

