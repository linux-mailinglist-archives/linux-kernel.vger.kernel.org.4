Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADA16E22D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDNMGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjDNMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:05:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18019AD27
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:05:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 188-20020a2504c5000000b00b8f6f5dca5dso1638002ybe.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681473940; x=1684065940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mmE5jy/83AbiExum2uWOlw9WgET/yaio4sgA6DKa4Xo=;
        b=CRnOvexc4uGaJtlXBpBxwAWjNrG2u375+vOuoxlfqXISvkbR4BgeLVDUT99nIw2Uy6
         mwS8LAsYjm1VzgPyAPlrQt+NEim2Bcw48d1C0xYxN6Eq3+zRRfDdmD20DFxn6eRMPzgv
         klohmurUf0OZJ9ZGBoNOdxSkQFMHRqt7VFZ7YG6sTclCI43BYxTvdApYKOHOuGNe0Uuc
         jvI94OIMQBVfv5hzMM+bDRy4FB9sEtW2FR5WHn3nRNcYzVsnvBTnHNpWgRculEvIwbs/
         0LEnvMaNJJQDN5W0n7z7r88h8q67/zikyGBNTl7BbSTxp7GwtHe7dSuzswJ9GKyzkigo
         nVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681473940; x=1684065940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmE5jy/83AbiExum2uWOlw9WgET/yaio4sgA6DKa4Xo=;
        b=VxzvLG2KPQvBq638J2fojUTuFvEhQq5BozJ/oMAfpN29l4wiZU+MNwHqZeSxtPY0iU
         EuxymaM8P1GAaeQzr8gqWKKuh8THSGCckFicIxOie1bnMJh0iBTKhBobIbySGqhr0pSh
         2v2NbUaRsSCneiEO4A6EGHj7FgJPFwpGUn49cFBEll0I5GXKR+NS6Huv9oMecA3OvVBX
         oXn8rsfhnt+2UrxNuSH6ux87jynRpqT6+rFYjfTHlkMJqyvVBs1fMrV1mipLVFc/U2Rp
         UKpeO+WXZWDzIZbB0y/sb5fQWmHloiIwXb8D1rtyQcqLh9j+ocdQPA6chyPz4dm/uToa
         Bzjg==
X-Gm-Message-State: AAQBX9cpE4ZMfMo36nlMkKyOyCeqrZ748r5siV0qihcOhKm7bNgSSdmL
        E1Jw6kqImL5TQBVXFyLc58rCcLbt5q9pIg==
X-Google-Smtp-Source: AKy350bZPbwaevptDno+qvPHOfr8KublJAUevFp8oBFM9cbUZujqK/KKIYxuICd9/bEGrNo0rrEDI6cNiwW7Mw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:da43:0:b0:b8a:7b2d:6556 with SMTP id
 n64-20020a25da43000000b00b8a7b2d6556mr3624830ybf.8.1681473940307; Fri, 14 Apr
 2023 05:05:40 -0700 (PDT)
Date:   Fri, 14 Apr 2023 12:05:18 +0000
In-Reply-To: <20230414120520.360291-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230414120520.360291-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230414120520.360291-4-joychakr@google.com>
Subject: [PATCH v6 3/5] spi: dw: Add DMA directional capability check
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
index 75e1b11af7c9..e1dd13fe4fd0 100644
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

