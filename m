Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBB95B6ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiIMODT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiIMODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:03:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07479205E8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:03:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e16so20971512wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Rmo2DUWc4Lh3Gy5bmxFzl72HuBNP/DuW7TZqaK4xQ8k=;
        b=fA9w6zKYwY0VcRTRjWEQ+CNhMGMCS4sZV/957ouGsp4YVIvGjK19wbSWHwX1O5c4eq
         JeP9MZqg+4LLxvK2jK84FfXCy64sQrKUnQ611eV+UqhwWqnq4d7ILZ+RFrfDaaz27a2j
         Zrtc5MeNxGXJxDFZ6bJQZX7WFz8WQln9SitCQje3USRLMAaamE4x5914mnBO8YzdwFCR
         4retLPv422/RcE5nXjeqzSh13+2AsOvOmcmHmOOkI8QoDDPneXquqGOIfC8sNmtdqntN
         ZnxnPVe6o0n1rtmmUMIFUmU4ucAD654AtqACFSeGP6QxnDQKtn82OT6jSf+Oz0F9iu7n
         wNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Rmo2DUWc4Lh3Gy5bmxFzl72HuBNP/DuW7TZqaK4xQ8k=;
        b=l/xCT+4sRDuUs6rSqveF37XhterL3vmJ4Mnw9plYFVBABzl0dPk6tLY9gWMBTDEmmc
         GrJwszuCs4A2IbGIduL8BfSQkiNUH4I9DFFH0/X6AxBAUgbJrWvmZIl3WvAvVCRc9cT9
         lmGt0NchJr++HqedYurY0kxMwAnz4d54IvCk+qhGUZ2Vrrqrj25Nbm8LU44xwfolNJER
         z0fdA/E2auDYqgzUlGdv/VW3S5ie3oLn7ETquLK30k6SnnxJbzurt2gaeUDXd8EKivjA
         L+yC0J0C9f5xqNbDEmzjUoHLq6o6PfH+bqej6D3qepYL7iXNZO5dUyk5aACpyipTe/jE
         8oHg==
X-Gm-Message-State: ACgBeo2URtfeH0NKUsFFercptbBN9UgZx82HDmUR5BHUTMj74HxKFBe0
        bGgAsze910HpIaB68OPrFHdpiw==
X-Google-Smtp-Source: AA6agR4dgCHXF74BDE5tzMI8vhXR7uAEUk3K3+Va/5xx/tDH2KLk4Ut7nDBUEBRHxDpxjcqaSqtaRg==
X-Received: by 2002:adf:ed44:0:b0:22a:a72d:5d62 with SMTP id u4-20020adfed44000000b0022aa72d5d62mr5173195wro.431.1663077792369;
        Tue, 13 Sep 2022 07:03:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:982:cbb0:44d0:d717:91e0:6f26])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d6906000000b00225239d9265sm10549187wru.74.2022.09.13.07.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:03:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] spi: meson-spicc: add support for DMA
Date:   Tue, 13 Sep 2022 16:03:03 +0200
Message-Id: <20220913140303.437994-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9644; h=from:subject; bh=TzjQXyxpjiqPN07WfDoB2CQFFRLNcZO6OJUnSR6bo8A=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBjII2B1RbVPRtjMS5JONJx1H4stj6b2TWuYfH1KLH3 /gyjV7mJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYyCNgQAKCRB33NvayMhJ0RhAD/ 9bm9taKrn9TR7revO/UTnxWKp1BY4VhgFOqFekIgylWij3SvkOLRX6uHljWiZBEy5lu/OvMpg8e/ZH GcjnUAeCkHJeiyuxTPIY3QVeA2Xd+LwRbEWQ6ipi1K8EPdxwWR5BlAHLxFnLdHPbEzR8gQcPod+n0I s/ZYK8f3tSaplJG7V1r+9oFKXWe+tgQ5PAEuoTr9HSfyNO+Ic2bBfKJMn/hvnVwKbcYgq/r1ejq2vx udHSJhqx/eLjrkojCqO+uwya57A5zGdGH5A5+lkfkibOB8k871OQC/qaZmV28GM3efWxpIzcmgfTFM HPIOqkNVnHCxPEeqtis7ZMZkNKgZAxs3bejgkwZBFQM6cR72FOgiBtLAzqo3NExqZSP7MXait0t4Co qG1zc6e3Tld48IMLwtFTm3ymQYHXCUqEy2g2pEbedVKUW8rCcl3bq41YuDivG9OZBFVkp+/rjh/Y4x KDoK9O0mDme5mOFULBd7WIgnrXC1oZLy9NpwgLi11Rq7+0csFZIlvuMsNknQsr/Fy5InW74oZsKH/t EJ+uO3xZjVe3Eq2HCxtCQbwZtns3kX/F7hUZtC7KWdOVQENbFYkoRpUj16uQ+B8AnS0Gfegvo0ujh0 /wEE467AZ5fIq2YyoWCXhlBzlTWLzVbN5jyHfBtuSdIY/FjFIUN6FwZJbxhQ==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic SPICC controller has an embedded DMA but suffers from some
drawbacks that makes it complex to use:
- the DMA can only load FIFO at each multiple of 8 bytes, thus only 64 bits
  per words transfers would work as expected.
- the DMA loads the FIFO in little-endian, producing little-endian bus output,
  and it doesn't seem this can be changed

Nevertheless it's always good to have a DMA accelerated SPI transfer mode.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/spi/spi-meson-spicc.c | 197 +++++++++++++++++++++++++++++++---
 1 file changed, 181 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 6974a1c947aa..5efd5396020d 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -11,6 +11,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -33,6 +34,11 @@
  * - CS management is dumb, and goes UP between every burst, so is really a
  *   "Data Valid" signal than a Chip Select, GPIO link should be used instead
  *   to have a CS go down over the full transfer
+ * DMA support:
+ * - the DMA can only load FIFO at each multiple of 8 bytes, thus only 64 bits
+ *   per words transfers would work as expected.
+ * - the DMA loads the FIFO in little-endian, producing little-endian bus output,
+ *   and it doesn't seem this can be changed
  */
 
 #define SPICC_MAX_BURST	128
@@ -128,6 +134,14 @@
 
 #define SPICC_DWADDR	0x24	/* Write Address of DMA */
 
+#define SPICC_LD_CNTL0	0x28
+#define DMA_READ_COUNTER_EN		BIT(4)
+#define DMA_WRITE_COUNTER_EN		BIT(5)
+
+#define SPICC_LD_CNTL1	0x2c
+#define DMA_READ_COUNTER		GENMASK(15, 0)
+#define DMA_WRITE_COUNTER		GENMASK(31, 16)
+
 #define SPICC_ENH_CTL0	0x38	/* Enhanced Feature */
 #define SPICC_ENH_CLK_CS_DELAY_MASK	GENMASK(15, 0)
 #define SPICC_ENH_DATARATE_MASK		GENMASK(23, 16)
@@ -158,6 +172,8 @@ struct meson_spicc_device {
 	struct clk			*pclk;
 	struct clk_divider		pow2_div;
 	struct clk			*clk;
+	bool				using_dma;
+	bool				is_dma_mapped;
 	struct spi_message		*message;
 	struct spi_transfer		*xfer;
 	const struct meson_spicc_data	*data;
@@ -171,6 +187,96 @@ struct meson_spicc_device {
 
 #define pow2_clk_to_spicc(_div) container_of(_div, struct meson_spicc_device, pow2_div)
 
+static int meson_spicc_dma_map(struct meson_spicc_device *spicc,
+			       struct spi_transfer *t)
+{
+	struct device *dev = spicc->master->dev.parent;
+
+	if (t->tx_buf) {
+		t->tx_dma = dma_map_single(dev, (void *)t->tx_buf, t->len,
+					   DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, t->tx_dma)) {
+			dev_err(dev, "tx_dma map failed\n");
+			return -ENOMEM;
+		}
+	}
+
+	if (t->rx_buf) {
+		t->rx_dma = dma_map_single(dev, t->rx_buf, t->len,
+					   DMA_FROM_DEVICE);
+		if (dma_mapping_error(dev, t->rx_dma)) {
+			if (t->tx_buf)
+				dma_unmap_single(dev, t->tx_dma, t->len,
+						 DMA_TO_DEVICE);
+			dev_err(dev, "rx_dma map failed\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static void meson_spicc_dma_unmap(struct meson_spicc_device *spicc,
+				  struct spi_transfer *t)
+{
+	struct device *dev = spicc->master->dev.parent;
+
+	if (t->tx_buf)
+		dma_unmap_single(dev, t->tx_dma, t->len, DMA_TO_DEVICE);
+	if (t->rx_buf)
+		dma_unmap_single(dev, t->rx_dma, t->len, DMA_FROM_DEVICE);
+}
+
+static void meson_spicc_setup_dma_burst(struct meson_spicc_device *spicc)
+{
+	unsigned int words;
+	unsigned int count_en = 0;
+	unsigned int txfifo_thres = 0;
+	unsigned int read_req = 1;
+	unsigned int rxfifo_thres = 31;
+	unsigned int write_req = 1;
+	unsigned int ld_ctr1 = 0;
+
+	words = min_t(unsigned int,
+		      spicc->xfer_remain / spicc->bytes_per_word,
+		      spicc->data->fifo_size);
+
+	writel_bits_relaxed(SPICC_BURSTLENGTH_MASK,
+			FIELD_PREP(SPICC_BURSTLENGTH_MASK,
+				words - 1),
+			spicc->base + SPICC_CONREG);
+
+	/* Setup Xfer variables */
+	spicc->xfer_remain -= words * spicc->bytes_per_word;
+
+	if (spicc->tx_buf) {
+		count_en |= DMA_WRITE_COUNTER_EN;
+		txfifo_thres = spicc->bytes_per_word - 1;
+		write_req = words - 1;
+		ld_ctr1 |= FIELD_PREP(DMA_WRITE_COUNTER, 1);
+	}
+
+	if (spicc->rx_buf) {
+		count_en |= DMA_READ_COUNTER_EN;
+		rxfifo_thres = words - 1;
+		read_req = words - 1;
+		ld_ctr1 |= FIELD_PREP(DMA_READ_COUNTER, 1);
+	}
+
+	/* Enable DMA write/read counter */
+	writel_relaxed(count_en, spicc->base + SPICC_LD_CNTL0);
+
+	/* Setup burst length */
+	writel_relaxed(ld_ctr1, spicc->base + SPICC_LD_CNTL1);
+
+	writel_relaxed(SPICC_DMA_ENABLE | SPICC_DMA_URGENT |
+		       FIELD_PREP(SPICC_TXFIFO_THRESHOLD_MASK, txfifo_thres) |
+		       FIELD_PREP(SPICC_READ_BURST_MASK, read_req) |
+		       FIELD_PREP(SPICC_RXFIFO_THRESHOLD_MASK, rxfifo_thres) |
+		       FIELD_PREP(SPICC_WRITE_BURST_MASK, write_req),
+		       spicc->base + SPICC_DMAREG);
+}
+
 static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
 {
 	u32 conf;
@@ -273,25 +379,52 @@ static irqreturn_t meson_spicc_irq(int irq, void *data)
 {
 	struct meson_spicc_device *spicc = (void *) data;
 
-	writel_bits_relaxed(SPICC_TC, SPICC_TC, spicc->base + SPICC_STATREG);
+	/* Sometimes, TC gets triggered while the RX fifo isn't fully flushed */
+	if (spicc->using_dma) {
+		unsigned int rxfifo_count = FIELD_GET(SPICC_RXCNT_MASK,
+				readl_relaxed(spicc->base + SPICC_TESTREG));
+
+		if (rxfifo_count)
+			return IRQ_HANDLED;
+	}
+
+	writel_relaxed(SPICC_TC, spicc->base + SPICC_STATREG);
 
 	/* Empty RX FIFO */
-	meson_spicc_rx(spicc);
+	if (!spicc->using_dma)
+		meson_spicc_rx(spicc);
 
 	if (!spicc->xfer_remain) {
 		/* Disable all IRQs */
 		writel(0, spicc->base + SPICC_INTREG);
 
+		if (spicc->using_dma) {
+			/* Disable DMA transfer */
+			spicc->using_dma = 0;
+			writel_relaxed(0, spicc->base + SPICC_DMAREG);
+			writel_relaxed(0, spicc->base + SPICC_LD_CNTL0);
+			writel_relaxed(0, spicc->base + SPICC_LD_CNTL1);
+
+			/* Unmap DMA if was locally remapped */
+			if (!spicc->is_dma_mapped)
+				meson_spicc_dma_unmap(spicc, spicc->xfer);
+		}
+
 		spi_finalize_current_transfer(spicc->master);
 
 		return IRQ_HANDLED;
 	}
 
-	/* Setup burst */
-	meson_spicc_setup_burst(spicc);
+	if (spicc->using_dma) {
+		/* Setup burst */
+		meson_spicc_setup_dma_burst(spicc);
+	} else {
+		/* Setup burst */
+		meson_spicc_setup_burst(spicc);
 
-	/* Start burst */
-	writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
+		/* Start burst */
+		writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -387,6 +520,9 @@ static int meson_spicc_transfer_one(struct spi_master *master,
 {
 	struct meson_spicc_device *spicc = spi_master_get_devdata(master);
 
+	if (xfer->bits_per_word % 8 || xfer->bits_per_word > 64)
+		return -EINVAL;
+
 	/* Store current transfer */
 	spicc->xfer = xfer;
 
@@ -407,11 +543,40 @@ static int meson_spicc_transfer_one(struct spi_master *master,
 
 	meson_spicc_reset_fifo(spicc);
 
-	/* Setup burst */
-	meson_spicc_setup_burst(spicc);
-
-	/* Start burst */
-	writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
+	/* By default, disable DMA transfer */
+	spicc->using_dma = 0;
+	writel_relaxed(0, spicc->base + SPICC_DMAREG);
+	writel_relaxed(0, spicc->base + SPICC_LD_CNTL0);
+	writel_relaxed(0, spicc->base + SPICC_LD_CNTL1);
+
+	/* DMA transfer can only operate 64bits words in Little-Endian */
+	if (xfer->bits_per_word == 64 &&
+	    (spi->mode & SPI_LSB_FIRST) == SPI_LSB_FIRST &&
+	    (spicc->is_dma_mapped || !meson_spicc_dma_map(spicc, xfer))) {
+		spicc->using_dma = 1;
+
+		/* Write DMA addresses */
+		writel_relaxed(xfer->tx_dma, spicc->base + SPICC_DRADDR);
+		writel_relaxed(xfer->rx_dma, spicc->base + SPICC_DWADDR);
+
+		/* Setup DMA period */
+		writel_relaxed(xfer->speed_hz >> 25,
+			       spicc->base + SPICC_PERIODREG);
+
+		/* Setup burst */
+		meson_spicc_setup_dma_burst(spicc);
+
+		/* Enable DMA transfers */
+		writel_bits_relaxed(SPICC_SMC, SPICC_SMC,
+				    spicc->base + SPICC_CONREG);
+	} else if(xfer->bits_per_word < 64 && !(spi->mode & SPI_LSB_FIRST)) {
+		/* Setup burst */
+		meson_spicc_setup_burst(spicc);
+
+		/* Start burst */
+		writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
+	} else
+		return -EINVAL;
 
 	/* Enable interrupts */
 	writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
@@ -471,6 +636,9 @@ static int meson_spicc_prepare_message(struct spi_master *master,
 
 	writel_bits_relaxed(SPICC_LBC_W1, 0, spicc->base + SPICC_TESTREG);
 
+	/* Store current message */
+	spicc->is_dma_mapped = message->is_dma_mapped;
+
 	return 0;
 }
 
@@ -802,11 +970,8 @@ static int meson_spicc_probe(struct platform_device *pdev)
 
 	master->num_chipselect = 4;
 	master->dev.of_node = pdev->dev.of_node;
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH;
-	master->bits_per_word_mask = SPI_BPW_MASK(32) |
-				     SPI_BPW_MASK(24) |
-				     SPI_BPW_MASK(16) |
-				     SPI_BPW_MASK(8);
+	/* SPI_LSB_FIRST is for DMA mode only */
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST;
 	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
 	master->min_speed_hz = spicc->data->min_speed_hz;
 	master->max_speed_hz = spicc->data->max_speed_hz;
-- 
2.25.1

