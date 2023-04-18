Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7856E5893
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjDRF3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDRF3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:29:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99321658C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:29:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 8-20020a250f08000000b00b880000325bso1286731ybp.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681795766; x=1684387766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ULD/pG+rE68BAxC1WDHgKiKZL8SDfWGnG2YjCeWvC3k=;
        b=qwjLzEiux581S2bwXnijENgLs2i3vekPUCQxMzop5Vx0D89HCDCPGFyxAs2bVC5zK6
         jZUx8em8Gl0+gyvoF1TWJqxt1mPYUOoO1z3B+XnY/vXbVEuq0m5wTSUJHI4yipjdpX1t
         t3yoTSirJxVGnzV+L0hOlNUCbBErO5LgN3RatdWdCHSHqmQgrtxUs7ml06v2YFRBytDe
         7DtgyepGhLyY/Qc99jM1r5asfItKZ+1Ti+g7B3O1JUln4fDvjTNxNE6ePefnwQwNSjex
         qcNAJRM0ypXCInn8v1b9tFMflu2LbAhHn9kmCnEFg484BSiEitHf6CPsLcbOLchhp8SE
         JNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681795766; x=1684387766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULD/pG+rE68BAxC1WDHgKiKZL8SDfWGnG2YjCeWvC3k=;
        b=ln90ntjZjNo9vXxVkn/X/aTx9Mc7UhaaHy47MuRGA6P0n12BiyFGBxLiHgED87q4Xc
         lwMHzkZiwG9AcaspAQu95kDHkd5WBn5wZfVvtJOoIi3cMmbSsMyZB/Ss/4YJewJQXm5a
         qTo8VqibPgVrHbt0qM3YQu/KLiduCRjlZYntQjWiF6QFRfPcnoM2MmuBUeAUpEpp2Oo+
         EGT7SryG6nqjydO9DUuKOlVs5P8heYkpBJMrX8nsVFWynC1Nr8epuOLfood+pW8elpoJ
         OiSwNDKzzFazmVC3OjSmq44X5nYqHIEXdFrOat2gJ+cs3XhpQGYipwVQhuVIYJ5at41X
         SsvQ==
X-Gm-Message-State: AAQBX9e1maX8azkElp+SNEtGGyDSFajjO4YPfDBxPGj8Vi8tI7ohDYQp
        /9+R4UvbOKCesGH7gcpQIwiJzs8GzSFnnA==
X-Google-Smtp-Source: AKy350Zbxb/MLGxinwfLDVNWFu+GOJwfHCvNZ0wV6p7AE3/JXlFSnZFapdikxMFEUEgDt7vtMa2xUBQPSSUzKQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:4411:0:b0:54f:93c0:4ba8 with SMTP id
 r17-20020a814411000000b0054f93c04ba8mr11022458ywa.2.1681795766496; Mon, 17
 Apr 2023 22:29:26 -0700 (PDT)
Date:   Tue, 18 Apr 2023 05:29:01 +0000
In-Reply-To: <20230418052902.1336866-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230418052902.1336866-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418052902.1336866-5-joychakr@google.com>
Subject: [PATCH v7 4/5] spi: dw: Add DMA address widths capability check
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

Store address width capabilities of DMA controller during init and check
the same per transfer to make sure the bits/word requirement can be met.

Current DW DMA driver requires both tx and rx channel to be configured
and functional hence a subset of both tx and rx channel address width
capability is checked with the width requirement(n_bytes) for a
transfer.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 16 +++++++++++++++-
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 22d0727a3789..45980c46946d 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -97,6 +97,14 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
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
@@ -237,8 +245,14 @@ static bool dw_spi_can_dma(struct spi_controller *master,
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
2.40.0.634.g4ca3ef3211-goog

