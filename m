Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E9D7005FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbjELKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240332AbjELKsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:48:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793AD13861
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:48:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba22ced2e95so8771711276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683888481; x=1686480481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAZjFxFUrm9OtcOgH4xOlH5bZ5I2tEQhGA86p1DuNqo=;
        b=ioq3uuIcfu+Q081SaVe+zrdtTTXwoa94fq3eQbzWahm+lfuDG6BcmyqPBMHVij789J
         QHsE56ld/XaGkM4n4LlkhLdpezbh1IrDwmq89Kez5Xv5409xZ1/G5x4B0pL1q6hne7MM
         ZXSClIb0um0b+Rz6jCRTdY1EOzpDML4kB5tXpaLgsQKfpsMhzOdmM26MXKrHi5Wk9bgT
         uuYXbZFUSAgsackXoWkOJxzn39jr+QFXSSGt6Zj39lB9erac3MPp32m3DeleSzKTazBj
         5PFfc39a7Q4H45LWvibSjwOCteIlRj9a/QxvxftuXk7dVtM/a9iPEJ+vGPQYu8KZQtzN
         gPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683888481; x=1686480481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAZjFxFUrm9OtcOgH4xOlH5bZ5I2tEQhGA86p1DuNqo=;
        b=YoZNUwB3YcLy1pcp2+4sa0646Uh8ks8TGdFnZ33n5y2SYCeZVfcmmBr521S16PlLfI
         KNbZv/Lrg7KACJ0d53CPuILC/EfPSiFdsnAmYju1XrG7jXL17LN7U/dz7mmJaPhHW20P
         yZq6+92WRh1Hvw70VFKSkvg2W4/JxDZg6yEnaiJWdnsrN6eLvSXv621NJgt6W7GqluoR
         HmMKoldLV39QgmRrMQxC8VcXwYG5KkscY26tm/yhLoUasLYyUVrDb9D9ZDLSqCylgrSu
         gUknUEsCtpWZ9KhVMpoHqqs5NKXMvh12dm/yyLP1QfinRc/XZzKVrkY9q8DHh/OCJUgB
         kzpQ==
X-Gm-Message-State: AC+VfDweusg0TLbLYx4iHyXzt5mz3/PEAvkLSJINLR9X9PNtbVpOEm7X
        qdALvJmWxaTFbU//aeaYxwnAQqs7a6XbLQ==
X-Google-Smtp-Source: ACHHUZ57Upq1TxKoISuKFrHa+p8XwC5sFntv3OhF8jD7L7ECAASaSM90VROxg4ZdTR8bI/LMBfS1lLSXwMuubQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:9ac5:0:b0:ba7:1499:e202 with SMTP id
 t5-20020a259ac5000000b00ba71499e202mr830400ybo.7.1683888481591; Fri, 12 May
 2023 03:48:01 -0700 (PDT)
Date:   Fri, 12 May 2023 10:47:44 +0000
In-Reply-To: <20230512104746.1797865-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230512104746.1797865-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512104746.1797865-3-joychakr@google.com>
Subject: [PATCH v11 2/3] spi: dw: Add DMA address widths capability check
From:   Joy Chakraborty <joychakr@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Joy Chakraborty <joychakr@google.com>,
        Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store address width capabilities of DMA controller during init and check
the same per transfer to make sure the bits/word requirement can be met.

Current DW DMA driver requires both tx and rx channel to be configured
and functional hence a subset of both tx and rx channel address width
capability is checked with the width requirement(n_bytes) for a
transfer.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
* tested on Baikal-T1 based system with DW SPI-looped back interface
transferring a chunk of data with DFS:8,12,16.
---
 drivers/spi/spi-dw-dma.c | 15 ++++++++++++++-
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 2363317a0dca..df819652901a 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -98,6 +98,13 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
 	else
 		dws->dma_sg_burst = 0;
 
+	/*
+	 * Assuming both channels belong to the same DMA controller hence the
+	 * peripheral side address width capabilities most likely would be
+	 * the same.
+	 */
+	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+
 	return 0;
 }
 
@@ -239,8 +246,14 @@ static bool dw_spi_can_dma(struct spi_controller *master,
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
2.40.1.606.ga4b1b128d6-goog

