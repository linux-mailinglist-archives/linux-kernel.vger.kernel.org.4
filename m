Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCFB7005F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbjELKst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbjELKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:48:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D917C13844
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:47:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7d92d0f7so17816599276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683888477; x=1686480477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXKFUpKr0w+nTlVz7d6efsfYj1wpJ5Pn5dWHxsHWrQ4=;
        b=2tPLx5Jn2d88GYhqypiMnQ2nPJnhEzg90y22Gv4K0TcTBV8rNgHMc1a3U1sXfd+LQq
         z5Ls5cmFRvVt8gwQeReN/GPkZo9/vhpQww15PjmkoGyKQkOtwM9X6Yji4b1aKSNfknb5
         h5EZHVF+d38m6iFRutc14n+dwx4SoJGiNz8XQNSlk86gC+ngVKNWMVECUejkDTX62zli
         FI1QqMk74Caf6djSkSfO0TKw3LQTheAW1oBhvdMi0pc/0PU/x1jSN+AhuFmXebl06JlE
         LjBcSLbVr6aAAGuacOuvV6IDEGDvq6V/2IcwV5/cczyY0xoEbLuD7rAf/ZTW4bZrZ3sJ
         iRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683888477; x=1686480477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXKFUpKr0w+nTlVz7d6efsfYj1wpJ5Pn5dWHxsHWrQ4=;
        b=ebF0MbdC9vu/pHAKjpBd5GgiS0yrPz/Cxp99K1MISGPF1C/OCxJK0erKq5Q54t1Sb/
         MfrlyqCl+9HG6UlzJPjfytOf+GwRj7fRBQ/04zK6x0ssVxax/LuNqbH3Ur21YNgyk1LH
         9EgR3oR1f6P3MyEzioJ6Cd9v60nNti8296jyzwRoG8/9E05Pf7MvvQb18Z3Eo/UIp1fb
         935QACtyET05RmxIO+0wHxSWpqFGudPLxY8n5aY8pYqW7Xr/YLjUNSsQ965XiP/pDCIH
         FcReyBg4rPiXV10rrtDEFRP/vHoU5vNKXi+gSmZGfjqXwjydwEB7oLmnr5ojYGAQLfYR
         Z8nA==
X-Gm-Message-State: AC+VfDxMdtzqpZg7h1nRsuWocu2TyApMZFU0dXANGshSmmephgcVVfDO
        iY0iqewdONuDi6z3ZYeuR939+p6wanaHkQ==
X-Google-Smtp-Source: ACHHUZ5DZpq6O0qfapM2kZvNLUUraxLwadXw3ripk4FhZBHvowP3EBUHy1cS3nlWegoik/bN6pkcnMYgfInKfw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:5454:0:b0:ba2:1a28:c852 with SMTP id
 i81-20020a255454000000b00ba21a28c852mr9966526ybb.7.1683888477042; Fri, 12 May
 2023 03:47:57 -0700 (PDT)
Date:   Fri, 12 May 2023 10:47:43 +0000
In-Reply-To: <20230512104746.1797865-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230512104746.1797865-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512104746.1797865-2-joychakr@google.com>
Subject: [PATCH v11 1/3] spi: dw: Add DMA directional capability check
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

Check capabilities of DMA controller during init to make sure it is
capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel.

Current DW DMA driver requires both tx and rx channel to be configured
and functional for any kind of transfers to take effect including
half duplex. Hence, check for both tx and rx direction and fail on
unavailbility of either.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
* tested on Baikal-T1 based system with DW SPI-looped back interface
transferring a chunk of data with DFS:8,12,16.
---
 drivers/spi/spi-dw-dma.c | 41 +++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index f19c092920a1..2363317a0dca 100644
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
 
-	dma_get_slave_caps(dws->txchan, &tx);
-	dma_get_slave_caps(dws->rxchan, &rx);
+	ret = dma_get_slave_caps(dws->rxchan, &rx);
+	if (ret)
+		return ret;
+
+	if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
+	      rx.directions & BIT(DMA_DEV_TO_MEM)))
+		return -ENXIO;
 
 	if (tx.max_sg_burst > 0 && rx.max_sg_burst > 0)
 		dws->dma_sg_burst = min(tx.max_sg_burst, rx.max_sg_burst);
@@ -87,6 +97,8 @@ static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
 		dws->dma_sg_burst = rx.max_sg_burst;
 	else
 		dws->dma_sg_burst = 0;
+
+	return 0;
 }
 
 static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
@@ -95,6 +107,7 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 	struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;
 	struct pci_dev *dma_dev;
 	dma_cap_mask_t mask;
+	int ret = -EBUSY;
 
 	/*
 	 * Get pci device for DMA controller, currently it could only
@@ -124,20 +137,25 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
 
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
@@ -163,12 +181,17 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
 
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
2.40.1.606.ga4b1b128d6-goog

