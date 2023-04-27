Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473996F05DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243464AbjD0Mde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbjD0Mdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:33:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D00D4ECA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:33:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-556f4e20131so17568977b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682598805; x=1685190805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6Q/VO/y6Fq41tZ4izLIBk5IF+y5iSwGGeoALfMszCI=;
        b=7SF3AaYcSGoW/ypNoGCNNc3chh/C711C/2zAVabYkzWAjXS5uyIHJjMv2VhpJCI9gE
         Ry4FjZgURKjz7Orp7MNpjEeG+C+Ud35NeSimsViU8ifp/RZjHbUQoHR2KqcOcI73D27C
         KIMkrFI0jgZiBCRYSEOaW7GJo+hme96imkeLIPRGUp+zzoG9rX9fqexYwtdXAne8cxIY
         E1Izj/Lk3eB8spEO5RpQr2XxNYls/ajcmzrfrQCxYOUnjVzOsNkXQl5IPHQMp67aon4J
         2LojHEtH9Nkvr90LmeyKmUEzS6yaQ5RN4fuDox9tgy4P5j5DVnHnggAWctFk9STKNJQG
         0m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598805; x=1685190805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6Q/VO/y6Fq41tZ4izLIBk5IF+y5iSwGGeoALfMszCI=;
        b=cOWDzh4dzg59uzm4qavsaYpvzwfcNBUl6ZuDQNh+7BNaEPSV2VGMxgph0juKyot0RO
         vqgzdYHv5WMJ61r5afZvG07oGFkGC7AOGmBP3C+z8AHKacIcSLZmrAHO0UTILbujxXkS
         bEt/bxxuLRZxiLfecTRs4pqAIOI9TQe6kGgJe/B/6eN75oActiz+nbW/4ftwL70Zw1GF
         y8Qrxbf9Gt6yAThd89SAnvBTXEC3svixROZEnHzhyziDwUeiAMBxBUtbX03M3di89xob
         Sl3OoQUegmQqvzspIX/EdJu2kgzV84feY5fOXJ39qnDrpCuIQhy3Edlu2TfVGFjWDZyu
         kf2A==
X-Gm-Message-State: AC+VfDzOSJBz8HmWGesA+15i2JhQfAwQThNOcrotcjtkIG5k12WImLyg
        yOCRR49hBJ+6H+XX1okBo6S6i0hEcHB5UA==
X-Google-Smtp-Source: ACHHUZ59yN8E5dtSO5tzVDd5U2bsSoxWIN/Ukfp5B6oPJ3ymIlU4hZ+d1CGo5MLyBoRd1KMhlhK6Ee3naK8Mcg==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:690c:725:b0:54f:bb71:c7b3 with SMTP
 id bt5-20020a05690c072500b0054fbb71c7b3mr997276ywb.9.1682598805726; Thu, 27
 Apr 2023 05:33:25 -0700 (PDT)
Date:   Thu, 27 Apr 2023 12:33:10 +0000
In-Reply-To: <20230427123314.1997152-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230427123314.1997152-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427123314.1997152-2-joychakr@google.com>
Subject: [PATCH v9 1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
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

Add Support for AxSize = 4 bytes configuration from dw dma driver if
n_bytes i.e. number of bytes per write to fifo is 4.

Number of bytes written to fifo per write is depended on the bits/word
configuration being used which the DW core driver translates to n_bytes.
Hence, for bits per word values between 17 and 32 n_bytes should be
equal to 4.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
* tested on Baikal-T1 based system with DW SPI-looped back interface
transferring a chunk of data with DFS:8,12,16.
---
 drivers/spi/spi-dw-dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index ababb910b391..c1b42cb59965 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -208,12 +208,16 @@ static bool dw_spi_can_dma(struct spi_controller *master,
 
 static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 {
-	if (n_bytes == 1)
+	switch (n_bytes) {
+	case 1:
 		return DMA_SLAVE_BUSWIDTH_1_BYTE;
-	else if (n_bytes == 2)
+	case 2:
 		return DMA_SLAVE_BUSWIDTH_2_BYTES;
-
-	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	case 4:
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
+	default:
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	}
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
-- 
2.40.1.495.gc816e09b53d-goog

