Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A299E5EC123
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiI0LXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiI0LXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:23:03 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C5613A951;
        Tue, 27 Sep 2022 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664277702;
  x=1695813702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TrQtsuqQ4EnLgm0F7EqTy/mbaX8OOSSxYGg4dteSuwI=;
  b=EX9w+PF1n6PQ+dm4r/EnyxJBqxrgQ9yW6ZOWwDXUAjaJ5fkO/ipDbNNV
   /Pj6D67jGqBgeDpjKjOeuu4OqfmvFKmjp226snUg7TjDDSC8GoVwwxOGs
   bk8pEabpSBP5kK8DeRCjbwGsDPo7K7QWOblViIrqz3/tvTzSdHrsbxFVL
   6b6wDMTXFNSt2iv5fvg0v6G8LPkmrVQm5eKuHEn+/N+TjDyatfhviLbQ6
   MsrCFJvwgl66q1RpU8aoNmayrFW0ZnH9k+GDqRqpC07/MqblQY+yXg4JI
   HAbuApAwGbeae8ToB3pn8ZtRr7GBQZBxj5lIWHYvrdLe6R4gDWdNq5MKG
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <broonie@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <andi@etezian.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <alim.akhtar@samsung.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 4/4] spi: s3c64xx: Fix large transfers with DMA
Date:   Tue, 27 Sep 2022 13:21:17 +0200
Message-ID: <20220927112117.77599-5-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927112117.77599-1-vincent.whitchurch@axis.com>
References: <20220927112117.77599-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The COUNT_VALUE in the PACKET_CNT register is 16-bit so the maximum
value is 65535.  Asking the driver to transfer a larger size currently
leads to the DMA transfer timing out.  Implement ->max_transfer_size()
and have the core split the transfer as needed.

Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/spi/spi-s3c64xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 651c35dd9124..71d324ec9a70 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -84,6 +84,7 @@
 #define S3C64XX_SPI_ST_TX_FIFORDY		(1<<0)
 
 #define S3C64XX_SPI_PACKET_CNT_EN		(1<<16)
+#define S3C64XX_SPI_PACKET_CNT_MASK		GENMASK(15, 0)
 
 #define S3C64XX_SPI_PND_TX_UNDERRUN_CLR		(1<<4)
 #define S3C64XX_SPI_PND_TX_OVERRUN_CLR		(1<<3)
@@ -711,6 +712,13 @@ static int s3c64xx_spi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
+static size_t s3c64xx_spi_max_transfer_size(struct spi_device *spi)
+{
+	struct spi_controller *ctlr = spi->controller;
+
+	return ctlr->can_dma ? S3C64XX_SPI_PACKET_CNT_MASK : SIZE_MAX;
+}
+
 static int s3c64xx_spi_transfer_one(struct spi_master *master,
 				    struct spi_device *spi,
 				    struct spi_transfer *xfer)
@@ -1152,6 +1160,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware = s3c64xx_spi_unprepare_transfer;
 	master->prepare_message = s3c64xx_spi_prepare_message;
 	master->transfer_one = s3c64xx_spi_transfer_one;
+	master->max_transfer_size = s3c64xx_spi_max_transfer_size;
 	master->num_chipselect = sci->num_cs;
 	master->use_gpio_descriptors = true;
 	master->dma_alignment = 8;
-- 
2.34.1

