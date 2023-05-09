Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DAA6FC1AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjEIIXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjEIIXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:23:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14F7A244
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:23:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba2b9ecfadaso4133359276.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683620589; x=1686212589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEl/ebklkKS4o01vG1eIpzniBnuA2urT/Tj2wNhU8Co=;
        b=qMMaRgFkwtCu3WTiH6Xcj3y05BVLosur4TdWR4cdbWaK8Yeo6AzJvfnwVOZObtkgIh
         lvB5saSwuLoXmapUFLdMuCrCRSeqgr/kvsHm8khWp10DIMzb3Ssgeo6mr7SZDTY5hsf3
         5f5OO0unt09oLnbBKqb+wF/4DjCbAiXIA46f0Nh51pbQflCT4aQ4EZo0y8zlUON8cM/x
         LLv3WxLJLOR4IR+qUGenK5KcM5RFfU+uKpedI5QIy6TdrtW+7xfhDl+dfamVCOR2IX0l
         V9vdXIAl0kq63Qpse1lBDC8oEI4+8ykXxve/MYcd+LXtmhCLUFe3iocFXISnhKRi17cJ
         zQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620589; x=1686212589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEl/ebklkKS4o01vG1eIpzniBnuA2urT/Tj2wNhU8Co=;
        b=NVYD0tIGCr0MhMW7aax4rs1ZO59MmRtQoL4Nn6LIHcPwU/3fVGRsPVCkiQQTDPPnaf
         LkfEEELeEcgUoMv+eL9qeZyHSeo/S+QF1zhMRrX0uIcrgF+LBBBQPN8CWydCn/UwT4Vv
         pAN7k4/T0lFqN7bflLvcfu3786wVlmzl+WHTQIz7IkibiA+ZtLhkAbA9yTeNLFgwRDpd
         t/z1p2RGw+xey4Dtczjts9XpYOCLlzzpVjt4uKJhdI+7RHLbhuRKhdSRe3xUK1TzXSmP
         +3rxiV8V8XFKms/vgXsCY1O8aKg1jpt5lQAayWY7SsBe3sYAbQGR4oqBtmy2p3wlQjrR
         XCIQ==
X-Gm-Message-State: AC+VfDzn8VAITcgtjxpVvmzg/CquUiTVtb/+IK2d+M60AvCIIPm5h132
        3kXBPXekTwlhLbOgfZyhoVT0HU9sxn2JFw==
X-Google-Smtp-Source: ACHHUZ4ut1ENLFwSZagCJcakA6qC3fueDQ6170UYRgz+XEsG3gRG9OhLosz9MmFGoRouyQ0KRlMwj8BufM8jew==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:12d5:0:b0:ba1:af7b:b88d with SMTP id
 204-20020a2512d5000000b00ba1af7bb88dmr8574837ybs.2.1683620589048; Tue, 09 May
 2023 01:23:09 -0700 (PDT)
Date:   Tue,  9 May 2023 08:22:43 +0000
In-Reply-To: <20230509082244.1069623-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230509082244.1069623-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230509082244.1069623-5-joychakr@google.com>
Subject: [PATCH v10 4/5] spi: dw: Add DMA address widths capability check
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
2.40.1.521.gf1e218fcd8-goog

