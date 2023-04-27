Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514C76F05D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbjD0Mdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbjD0Mdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:33:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3BC5BAD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:33:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f32cc8c31so14480233276.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682598819; x=1685190819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLvnCO6evlKbK+xj/d2Id6gaw49UQ3nh6G31gbqAkCk=;
        b=3DLTZ423zj75HZE3dLX2ol2fkvJhx+OfxNx9TMkA1hLwBabuiMsxVL4wEmuUfF45UQ
         +i0GLG+Em2uXwmyHcJLuJRz+vWS5vYw+EdRJvVSn8prLzEyev1YSa/j+nCoeGTno7mIi
         56DwSlzeCplHTll72n8yKAasRvyfeO6rsIFX5krBUDP7yXf9nWgwyHjFnGAR7KN3XITs
         ggptjW7770nyYfIoSP2/MyjD9plolbqIVxbccmGTDnK3ijXt0EvYQzVSbjIXOrCmvRyb
         SThdIXn6S3njt7z3q77aTsYuoeW9Bbf8L+UTaIWZAOdV+J1f4sLYODoPz9ZCNsw1QcgN
         7UJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598819; x=1685190819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLvnCO6evlKbK+xj/d2Id6gaw49UQ3nh6G31gbqAkCk=;
        b=j67E6NB1gugK4sJN8b+uioFrzantLKMWXF4dDiO1nvX7GoUSa4Kv3KimzutpL8SF0w
         KjYBlmZ+c3825vi/GpzWENMrh1VkrzjJwyyr5NeqMX/lkub3iclig1wkRbwKtIghwn+J
         bgLUa/lqarSPPW6NvgQrMSYd2bZpO2lwzaP7wQ2ft8cSxXnzgkt9DEBbGK6Y91M4l19k
         +wzsCcMz+regdgkSc277NgQUfQWLZW0oYbrobty7YXwh3L/bSoXizsHhGqouTss8L9We
         XQDP0sBFI6THlImaBX4SLSXuDwgCWBpPxC5zWHg42hVCaLkwa/HL7RTT4GHCFGd2y1gT
         I7dg==
X-Gm-Message-State: AC+VfDy2RLIJ+ey2Yx+1D39mzZzstYJLDis/5wspwTOzH0Big5YblsDI
        rVo+pugGkrsnWUKtSOzC1Im3WXISaRVjyg==
X-Google-Smtp-Source: ACHHUZ5LevSsh6HRBrQnVClBVBi411VD4CTn+FuRBCwVXmH1Jd1eK9ZdJzQVk/QPxH/fkPxKFPxWpQzlebhKeA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:5843:0:b0:b99:df0b:cb1e with SMTP id
 m64-20020a255843000000b00b99df0bcb1emr501204ybb.4.1682598819554; Thu, 27 Apr
 2023 05:33:39 -0700 (PDT)
Date:   Thu, 27 Apr 2023 12:33:13 +0000
In-Reply-To: <20230427123314.1997152-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230427123314.1997152-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427123314.1997152-5-joychakr@google.com>
Subject: [PATCH v9 4/5] spi: dw: Add DMA address widths capability check
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
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
* tested on Baikal-T1 based system with DW SPI-looped back interface
transferring a chunk of data with DFS:8,12,16.
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
2.40.1.495.gc816e09b53d-goog

