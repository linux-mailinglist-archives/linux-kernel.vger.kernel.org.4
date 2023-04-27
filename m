Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2CE6F05DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbjD0Mdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243695AbjD0Mdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:33:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D26526F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:33:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6eeea78cso4370822276.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682598815; x=1685190815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8GsQCBaZJI/kD+802nQ+4grvsSl0JkV2Q+XulPct0A=;
        b=CIwS7rv0Bt1NRSpeLAH2zHX1mFDLuSSyyWHxoyQnbpJ6drNZh7T5je0G8bmM11LmtV
         sL2mbhnvGL7nmxnTE6+xDc4VfwbDWu/5t1acHTsWuPeOvHsVRykoUE6+pvz8q6BaKzym
         td3aouq+E4LHEGNotLcWdg+FDtThdDALNOnC8q5SnosK4pGYp5t0MGHPgfknsNEIVqSE
         EtAEPpGLrbirluU/9g7gyc2fpsW0t48xDoA4+qCWWt0zzax/0JchhEaVOcaFUPYF2FT4
         D/GdvuTD+e422rsRMt+nW8BTLCXrybYZ1nCdgL6dzfzTMh+57+xMBcbVtNNg46RCkZX2
         +lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598815; x=1685190815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8GsQCBaZJI/kD+802nQ+4grvsSl0JkV2Q+XulPct0A=;
        b=Cc4q6Ha3ueEev8uPAVyZ4CvyQeinLnaTGlaPFJvmJPCV/stLbq4nc6+WRqLgUGAP3H
         c/9dXl/u78QdCt2fWJePOsXKhqAeTcQOAmYHEwm6i4A90/Hluoi6wWqRoR3hvlgDb3Og
         xL1Iev7SY4mbprUBboqrDKyjYuH56xKNio9zmAyQadIc0J3KSQNZ1JkaD/gvdNlMoIRx
         PKry2n31K7eLeHaXGQP8+3fB/X1wcjQmug9QSjmw0iKXaQHInItNm6iplJnA3HNwpW4N
         iRGq1FjrA2znDBP2hWnvlTPFzIdCr8cvcr7lrnR+d5o8kCWEJC/k9s2DpYuquLAIQsZI
         zxww==
X-Gm-Message-State: AC+VfDxXN6LIZMMpmG4d39g46TuHI7N+KrBZlEczOcajOgP9urNU3Myb
        0HLb6SIgLr/yHCCQU0GXkqh85xLVvHBcVQ==
X-Google-Smtp-Source: ACHHUZ7dGt3m0BH4d6R7Es7xe/L3JTq8vbJ+EbpYa0o9nvD4cehchfM9KGMPtjXE8smT3s/sOphJXPEOZ3PWWw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a5b:ac5:0:b0:b8f:5b11:6d6c with SMTP id
 a5-20020a5b0ac5000000b00b8f5b116d6cmr3736264ybr.1.1682598815226; Thu, 27 Apr
 2023 05:33:35 -0700 (PDT)
Date:   Thu, 27 Apr 2023 12:33:12 +0000
In-Reply-To: <20230427123314.1997152-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230427123314.1997152-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427123314.1997152-4-joychakr@google.com>
Subject: [PATCH v9 3/5] spi: dw: Add DMA directional capability check
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
2.40.1.495.gc816e09b53d-goog

