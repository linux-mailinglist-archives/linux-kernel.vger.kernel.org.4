Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0066E89D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 07:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjDTFxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 01:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjDTFxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 01:53:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214334200
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:53:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 188-20020a2504c5000000b00b8f6f5dca5dso1393198ybe.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681969981; x=1684561981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Suw/5ECmRYhQu6IA1gmyYkwu6OL87LNt9wtEORwfKxU=;
        b=Nic2FQHT1rZcir8AOnmbrVQPU6NAfnIjYV4nIHCfkVKQ/GoGbaNkbxtwGkF5Om1bYv
         V6+uX0yYKgWBiNd9F78J/n+s6PyxBNJXg4LkdJcVUPRmgGAEBmeqIC+zwvTTD5D5M181
         ZlTGroz/DAtZMujsWNJ983a47tVbO9qmPah4pS3s9yldeH2ZWuq6rVgQo6RdfcAqtzY1
         bHnv7Alw7+AnTco490Jm5j0ql4RFj27sUppjmdlMYnTHjF3wkGFanlbRuPMwlHWV84ZY
         4rjkPUeogytWmy9OebXbApw2ftvCJty+sqj4lF1H2tD+fYAumBWj/H9o+OBlMa7fpyfX
         kNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681969981; x=1684561981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Suw/5ECmRYhQu6IA1gmyYkwu6OL87LNt9wtEORwfKxU=;
        b=ld4PciWqxLt+oUYa0UmMIQJ81hLvooFDO9AgsigLxf01u8D3EWSwTxJ9lSo/r/NX7S
         4/QBeOO8pH9tb5uzp38AaDcGhhW3rbA8dRR6Xlpb4WV2naIcClCNUctmzp5873GNkekB
         xMz2YuvtMOvipGZ8/bK2qcidYg6R/9mcyTOuBDXbfdk+kCIoVfbBfBRdFDtcA/7Nd9ov
         ByjM5Ey+xo6fRHK6wsBWz2zgimzw1Udc6rmXdGdBkvnQx82ctOuPBZA/zOfqSKRtEyeU
         ujeSXoNYsE+If4oxhfVUGFzb5lJ48y4zPwWVvpTW1otxHUaRjucjbzHUJ9cldLtRahC2
         7pfQ==
X-Gm-Message-State: AAQBX9eJsqXjRd4OBVsYXdrnsbjctJ7HJP4bTH1DJV5kvdjS7W9+quVX
        zTpfEN3CnoH+Tmx225JXYy9JcFvKScFOTg==
X-Google-Smtp-Source: AKy350ay/+o35VVgLfkm1KU5oZXdmcYctJBH3H9ps3Kkq5rgHGfsM7OemGOqjFNEJ2EPDGX6C9R3yUPdRzUA8g==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:b625:0:b0:541:693f:cdd1 with SMTP id
 u37-20020a81b625000000b00541693fcdd1mr3450551ywh.9.1681969981044; Wed, 19 Apr
 2023 22:53:01 -0700 (PDT)
Date:   Thu, 20 Apr 2023 05:51:29 +0000
In-Reply-To: <20230420055131.2048959-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230420055131.2048959-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230420055131.2048959-4-joychakr@google.com>
Subject: [PATCH v8 3/5] spi: dw: Add DMA directional capability check
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check capabilities of DMA controller during init to make sure it is
capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel.

Current DW DMA driver requires both tx and rx channel to be configured
and functional for any kind of transfers to take effect including
half duplex. Hence, check for both tx and rx direction and fail on
unavailbility of either.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index f19c092920a1..22d0727a3789 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -72,12 +72,22 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
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
@@ -95,6 +105,7 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;
 	struct pci_dev *dma_dev;
 	dma_cap_mask_t mask;
+	int ret = -EBUSY;
 
 	/*
 	 * Get pci device for DMA controller, currently it could only
@@ -124,20 +135,25 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
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
@@ -163,12 +179,17 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 
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
-- 
2.40.0.634.g4ca3ef3211-goog

