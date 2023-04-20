Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51F6E89D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 07:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjDTFxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 01:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjDTFxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 01:53:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E599840EC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:52:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e63-20020a255042000000b00b953ca0cf4eso1384141ybb.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 22:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681969976; x=1684561976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xCBVt+yTzL9gm6ligFFQCFbRni90/tGiHt7eRsjBtY=;
        b=GYjayEHTH0DTFM7kLY9bVfMA2J7m/p62X4TtHqIrE81LrGEdzUtYqYo+3PqkGKe/PP
         xFKTLUmHAalIQMGpb5k7bntgsjNGP0pZPo4Na5+8sawig3szQDTNnx25Aq31dRhf41we
         m7XlLrEnhZfXFcS1Rwj1lnrvIoGm+j9yPTsQLQjZmDtx6mRbmAxSM2Pr+g3zYCQYPp2X
         MktbbEevw9lhMaNqnpy0Q4NgotUlEfww8ij7NuvbU2VHsEwHYKFhdpL/nipcBOvMGYwq
         SsQZO0hFLViLjndPQObcqY7+eZq9kXkjCRunkR5OxygH+N2I7Y9DYlohfTWdLtcRcvqx
         fcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681969976; x=1684561976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xCBVt+yTzL9gm6ligFFQCFbRni90/tGiHt7eRsjBtY=;
        b=GDdQGwpHEY6rYeyt+m3YA9xLSUHDJDSTWy1XvP3V0my8hawBl6ahltzQ+zl8tqgLPm
         NMnyHyciwiXTRcmOcOMobr4C2Hix+ms3GhbUYrEKdeiYRxdHyjg6FoGCvlhY52/+aUP7
         h4JZdxfQLUgC7o8JG/SLeHj0SiXMyUkGSJVjUJtYMvs7RPGs6BOOESZffBwX61N+8PPJ
         QrgfUJvIHCdTVNlyfzjdTgZ3S3Pr7H+HRBYpN6eJmcUOcQNuFtQAnBqMitibtVF8YP/P
         kjVzio7RKP40u03jPMELQguog91TeTFDYEIBYDhJG3E00qriBosSlu2xN8DSgbkMgPcJ
         4c4A==
X-Gm-Message-State: AAQBX9dDCF55aJaR0Hr1Q7dGT3hV66NKVDQpvN8KzElfX+pN2qYJ1PUy
        kX7zWvuRshWn/9YQjSwmae4mz8Wg9iekAA==
X-Google-Smtp-Source: AKy350ZPZBC7QCtpkWz4OAE8WRsC3sGRYmMChEsbN7/Q4y6a0qg4jQR8PY1s4trNZJzA5KgED/0yImjC1Fzf3w==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:1241:b0:b92:238b:574a with SMTP
 id t1-20020a056902124100b00b92238b574amr1547530ybu.0.1681969976120; Wed, 19
 Apr 2023 22:52:56 -0700 (PDT)
Date:   Thu, 20 Apr 2023 05:51:28 +0000
In-Reply-To: <20230420055131.2048959-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230420055131.2048959-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230420055131.2048959-3-joychakr@google.com>
Subject: [PATCH v8 2/5] spi: dw: Move dw_spi_can_dma()
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

Move dw_spi_can_dma() implementation below dw_spi_dma_convert_width()
for handing compile dependency in future patches.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
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
2.40.0.634.g4ca3ef3211-goog

