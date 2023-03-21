Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEA16C3117
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCUL7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjCUL7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:59:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA4816AF2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:59:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e20-20020a25d314000000b00b33355abd3dso15978095ybf.14
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679399945;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r8A+qj8whaa2EVpkeoxnnh/JzSlsp2fevSoVTdtS9NA=;
        b=FHQCwsAW8fqwW3qGdSmkBeKZRwCBfzkqolPbAv31wLjIIw6kRYe+ei6tVVhL9K1Woy
         ltpIynSNN4Az+JJIpalXS26/Rq8SsT1ZjpOao2W3wjmFwspyl5NiH7g8QttxH/seA7zX
         tE0uQCXVZCdgWUXr+tVOtr9ZtjWqlu7TZCRXRuP2UWPdqcuH7WwO4BZ/CsQX/7DOwuIa
         iWkIcRdaz6PD7huMjKK+irzdzjTtQwY0r5hdvUH9Lrl8di1JQ6nCNa5DVdRTSoMBMqhd
         tgoZt6+ON+L4fVHfMV2nQ417zB8i35Zx+2+ulkhCMX7pclxf9TZWjlp5419kZxQ0AOzZ
         biJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399945;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r8A+qj8whaa2EVpkeoxnnh/JzSlsp2fevSoVTdtS9NA=;
        b=yiP2MwiVAnYgInsdSzqbgAaGlvRAT4IkhuejbUexShYpm0SYIdoxkhFkEII8xt7Qv0
         PpS515MYxzD8H450KBzfd7cZo7PKRwRj92mYmQQrQtamKbC7IOJ1CKi8qcq21g93Pr4S
         edhuJ+i2m9LbXMeaP3B2xh0dOFrYg9taJFBv6cXdH8tQ+aMl5ybCLqgl5IoEIJVMLb6H
         5WqenzjsBtrsklSRI28iO4SMMOEthFG+MdGK6BQ59AjxaRfCxnHLDNcXW47gOLmG2tXe
         /F6kbt2gSDkT2LbysHnHBVJcSsXSZoz9FISDZ2sc+qZnf6y0ARcJiM59pFBLGzPBBZc5
         xazg==
X-Gm-Message-State: AAQBX9fPepF+1FFu/5zyR7mvzSXob6PIjLoB0avTgvzZCtysSDIMMUo4
        BVgajyzneJ/eE6xCO+j6p2VyOav7Rqf9DA==
X-Google-Smtp-Source: AKy350bcv35XCLD/YwBf/zYbbuW/VK4IOexHg+oZOgcpzwF9LW/+8TF8PnhwPAvl59Ik/aktxYjExneqKdSdkw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:8a0e:0:b0:b30:8d4b:230e with SMTP id
 g14-20020a258a0e000000b00b308d4b230emr1006235ybl.7.1679399945431; Tue, 21 Mar
 2023 04:59:05 -0700 (PDT)
Date:   Tue, 21 Mar 2023 11:58:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230321115843.2688472-1-joychakr@google.com>
Subject: [PATCH v2] spi: dw: Add 32 bpw support to DW DMA Controller
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DW Controller is capable of a maximum of 32 bits per word then SW or
DMA controller has to write up to 32bit or 4byte data to the FIFO at a
time.

This Patch adds support for AxSize = 4 bytes configuration from dw dma
driver if n_bytes i.e. number of bytes per write to fifo is 3 or 4.
It also checks to see if the dma controller is capable of satisfying the
width requirement to achieve a particular bits/word requirement per
transfer.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 37 ++++++++++++++++++++++++++++++++-----
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index ababb910b391..9ac3a1c25e2d 100644
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
@@ -89,6 +91,16 @@ static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
 		dws->dma_sg_burst = 0;
 }
 
+static void dw_spi_dma_addr_widths_init(struct dw_spi *dws)
+{
+	struct dma_slave_caps tx = {0}, rx = {0};
+
+	dma_get_slave_caps(dws->txchan, &tx);
+	dma_get_slave_caps(dws->rxchan, &rx);
+
+	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+}
+
 static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 {
 	struct dw_dma_slave dma_tx = { .dst_id = 1 }, *tx = &dma_tx;
@@ -128,6 +140,8 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
 	dw_spi_dma_sg_burst_init(dws);
 
+	dw_spi_dma_addr_widths_init(dws);
+
 	pci_dev_put(dma_dev);
 
 	return 0;
@@ -167,6 +181,8 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 
 	dw_spi_dma_sg_burst_init(dws);
 
+	dw_spi_dma_addr_widths_init(dws);
+
 	return 0;
 
 free_rxchan:
@@ -202,18 +218,29 @@ static bool dw_spi_can_dma(struct spi_controller *master,
 			   struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
+	enum dma_slave_buswidth dma_bus_width;
 
-	return xfer->len > dws->fifo_len;
+	if (xfer->len > dws->fifo_len) {
+		dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
+		if (dws->dma_addr_widths & BIT(dma_bus_width))
+			return true;
+	}
+	return false;
 }
 
 static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 {
-	if (n_bytes == 1)
+	switch (n_bytes) {
+	case 1:
 		return DMA_SLAVE_BUSWIDTH_1_BYTE;
-	else if (n_bytes == 2)
+	case 2:
 		return DMA_SLAVE_BUSWIDTH_2_BYTES;
-
-	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	case 3:
+	case 4:
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
+	default:
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	}
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
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
2.40.0.rc1.284.g88254d51c5-goog

