Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA49F6FC1A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjEIIXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjEIIXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:23:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20CE74
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:23:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba2b9ecfadaso4133167276.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683620579; x=1686212579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/nzvqAVbvzYABlQomy5DkIxe057QBPgKkXg3X4iNsvg=;
        b=74iCI0aYEzxSweD/pJ6VE2M74d5b5ftirpEnpTpbs9MEwCxIV/Tu6pihyaVK9ctw0r
         fHXB7XWQLlttYkPQt2ql0qbKubqogTjwIqG7j+4rvdYp+wr+JrZ4adA+xZHBQSuGAARz
         nmtROMY+GjM40ZR/6YUQLcxFKZfjjXZTxiQVSt78NNV4x5veI/j7gqeBvjpd6h5e1TQE
         zwzfmqBvLrIOSXDy2iB6gvgtyhdVxG2q4o6wrNzXcXjQ/aBbSbSUGzdlASXO+/IHgtVM
         GhfyjN358hfST2G6VdFiRSURlpG4a+WxmhcG7YpCiUZLnffGa3Ws0MYsBbfKQ1SJVmPF
         NoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620579; x=1686212579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nzvqAVbvzYABlQomy5DkIxe057QBPgKkXg3X4iNsvg=;
        b=hedOAtzefDxr1JijgPb6nwb22D+PDWKRO2EEF+3nsuwn3s6co91qIUxjpBwNiOSLK4
         52oHdX+dwM6Dv3etMvIGQNzwIv8uDSNGUU4AGrTxdBEeqQHCHCUd302XmjIDyyA5ikV+
         it2j2eR48BmM17jWhxXYjtMjHCqsTDfrRqgKvoUeafYb9EMwAc4azGE5yb4G8U7N5VRT
         nhQVb+pFIABIhyrWdASSA9CGOQTFqJbiGJgBEJ7EIeDRDBPPR8NWtYp/TxbiqQFrl7yW
         cWsKbop6Hs8Y/FV6Z/7LKONcgrYtrBufIqHAPE5Sr+H1t1Aa6Sj+CVoqn0RkeDc7l/SO
         v9kQ==
X-Gm-Message-State: AC+VfDyqyhCu2/SJ9tpzxAHvV7BnMe5FQgsr4r4/GE2N6NexCq9cBvoy
        Tm2RwgTM9HNFBBpw11fnVM9RUOV7kNNFnw==
X-Google-Smtp-Source: ACHHUZ5DNQpfNmGZyChoGWce/GXfQ0cokFwLzZ4T+lZuMJ4/yM1j1/owHCndVBMgWz6Kk5k8YRiYzFZ3Q6fsIg==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:d34b:0:b0:b8f:47c4:58ed with SMTP id
 e72-20020a25d34b000000b00b8f47c458edmr8460356ybf.9.1683620579716; Tue, 09 May
 2023 01:22:59 -0700 (PDT)
Date:   Tue,  9 May 2023 08:22:41 +0000
In-Reply-To: <20230509082244.1069623-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230509082244.1069623-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230509082244.1069623-3-joychakr@google.com>
Subject: [PATCH v10 2/5] spi: dw: Move dw_spi_can_dma()
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

Move dw_spi_can_dma() implementation below dw_spi_dma_convert_width()
for handing compile dependency in future patches.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
* tested on Baikal-T1 based system with DW SPI-looped back interface
transferring a chunk of data with DFS:8,12,16.
---
 drivers/spi/spi-dw-dma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index c1b42cb59965..f19c092920a1 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -198,14 +198,6 @@ static irqreturn_t dw_spi_dma_transfer_handler(struct dw_spi *dws)
 	return IRQ_HANDLED;
 }
 
-static bool dw_spi_can_dma(struct spi_controller *master,
-			   struct spi_device *spi, struct spi_transfer *xfer)
-{
-	struct dw_spi *dws = spi_controller_get_devdata(master);
-
-	return xfer->len > dws->fifo_len;
-}
-
 static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 {
 	switch (n_bytes) {
@@ -220,6 +212,14 @@ static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 	}
 }
 
+static bool dw_spi_can_dma(struct spi_controller *master,
+			   struct spi_device *spi, struct spi_transfer *xfer)
+{
+	struct dw_spi *dws = spi_controller_get_devdata(master);
+
+	return xfer->len > dws->fifo_len;
+}
+
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
 {
 	unsigned long long ms;
-- 
2.40.1.521.gf1e218fcd8-goog

