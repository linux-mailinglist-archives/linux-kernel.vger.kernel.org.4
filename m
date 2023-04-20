Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ED16E89D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 07:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjDTFxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 01:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjDTFxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 01:53:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CC559DA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:53:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 84-20020a251457000000b00b8f59a09e1fso1394739ybu.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681969985; x=1684561985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pw11IJF74xsEjxmIFJb01azmaJEP3MTEgikPdGTfV0=;
        b=Ghdjh7vA1YPqlAZpZKBCngCnmwyCqEnfPR3DWXDkkfIn5X9nZY7Cm2lQCb5PBIXRma
         nBj2ld7j3BXfFLqsWYVXAVfuRaBlCLDXVsDiem8dshSSwvY+DOvGotlqaer6eF3ujaao
         V9pGdoJqZp1yvMmDhnNzv8b1aWngib70WDj0h77MgymbkKIFESsdG3019rClpkpWj53v
         7jRDPe1+eNJHSyNSyz5sDRVRrXs8ueAQy/l1+pN0aKlr/e66XCA+RdiMxCyR8TTVueFi
         wM9QojpXSDE9EaXtMNllPxU3HTe/hbe82gr6VtjUromEji66LTWH3RfFrX1/++liNklN
         gyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681969985; x=1684561985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pw11IJF74xsEjxmIFJb01azmaJEP3MTEgikPdGTfV0=;
        b=AHHuItYNUYM70I+CxEX/QUdszBqZfMM1sB6zEhAb/kdRTuTuMQOz6atoaCQakdYIJn
         zffJ4LTho21SoaO8rtYqUF5husBShK1EGqJ9wo4WF2avMhKraYVFhlDYVbsWd/+rNbI2
         34+RdYjYmqxbDLwkTd8YwCyAkK+DkI2jwXcnWooGyVZkAVDu2PFuRfzE3bsGVqsea00M
         UNbqmxPuNkHTd187S+Og0ZETKum5FFtzrdw1P2cGoD89FeCmPvqE2pLhAn2DXlwUQW8J
         jALmgtMC9yn4ZCAhatnCT6N0aY6v9bTRl4BIEmaiB7yw0KeptOfY9hrNK2sMAkMbHdNl
         siWw==
X-Gm-Message-State: AAQBX9cIoWj5BuJnF7Jrm3u2O3C48C+xtOWIi5bmWYKEYhMdkIWoBorV
        Q5stRxEYdvtn1N7geqiiQ3ZiswKaOuoacw==
X-Google-Smtp-Source: AKy350aHEAmQUugbZRgWImjQc/pmpAOgcunt234vDef1PlbRapAYOq9br9v/OAOdB0HSKG0Ghr4THwRqnfKvXg==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:ca4a:0:b0:b96:7fb0:f927 with SMTP id
 a71-20020a25ca4a000000b00b967fb0f927mr309752ybg.12.1681969985826; Wed, 19 Apr
 2023 22:53:05 -0700 (PDT)
Date:   Thu, 20 Apr 2023 05:51:30 +0000
In-Reply-To: <20230420055131.2048959-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230420055131.2048959-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230420055131.2048959-5-joychakr@google.com>
Subject: [PATCH v8 4/5] spi: dw: Add DMA address widths capability check
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

Store address width capabilities of DMA controller during init and check
the same per transfer to make sure the bits/word requirement can be met.

Current DW DMA driver requires both tx and rx channel to be configured
and functional hence a subset of both tx and rx channel address width
capability is checked with the width requirement(n_bytes) for a
transfer.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 17 ++++++++++++++++-
 drivers/spi/spi-dw.h     |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 22d0727a3789..df819652901a 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -97,6 +97,15 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
 		dws->dma_sg_burst = rx.max_sg_burst;
 	else
 		dws->dma_sg_burst = 0;
+
+	/*
+	 * Assuming both channels belong to the same DMA controller hence the
+	 * peripheral side address width capabilities most likely would be
+	 * the same.
+	 */
+	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+
+	return 0;
 }
 
 static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
@@ -237,8 +246,14 @@ static bool dw_spi_can_dma(struct spi_controller *master,
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

