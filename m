Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072846F05D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbjD0Mdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbjD0Mdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:33:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1624C03
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:33:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a2abd8f7bso4215441276.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682598810; x=1685190810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Adm4j45gizFfC/DwqDNV4am9AZ8vYB5z8Xwbghf5BGo=;
        b=zsszPebuf3cwDmVN7gVllalvKOsKsT+K5wl7znryh8N/HuMkkoSIt3lbU+p0W3aYVh
         SSSaO27ReLEqOCzG3BSuuDNm2DML74Zfb99YQZlQWs65vMnUHWeMpPKTpa65fLps3gi2
         vSlUH4rS8Pu+gwunef7GF7styB0VyU+lahLQDrrM1XEL1K1PH+DfH0h555dj0y86CX4S
         lKaRbe6XIL1XAsx1lcGj5DnQdzwgD/3Qx6kdhWH5H24GnIS9WomZLqartGvw6G98OBZf
         1P06hkAeYdfaQtcpR4dTlCKGVVZ+Bs7kqxOzix3okyVRG7k5QpKflpKuUzNRhgNZeD0I
         XdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682598810; x=1685190810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Adm4j45gizFfC/DwqDNV4am9AZ8vYB5z8Xwbghf5BGo=;
        b=ZZDIGjurqAcPnt1fr+K7uELCTVgFMPNvKfitLyGWHf0Wy24NkQgCYe2KaHegbYlMOE
         uboimyC4L1IOzNoE+ZLPCb1uEWCSF1k4PYuGnmqoQAMGAg7Ttme6ZVjsZY04nIL9gr0U
         y6BatLcOlc5siyB67YIjVjI3x2/QPOMCEbovn/LgtSQyoKISsTsuko/RKH3gQv44HjoY
         mELLi9y7HcQa6WwiX0VHOixqJrXKb4q3f39c4NEnH9q0bg++lU8tWi7Jp/zVoClUBG5U
         gDdt4S3ogQ7PdKjsRSlil5n9TvDDvv5/H+6RG4dJaBgvmlGq5t4xwV1ltjJ/71GqTbN5
         s2LQ==
X-Gm-Message-State: AC+VfDxuXUugVHYhJYa+k31sc2cUJjKEdSmwGOrJ/907AKierR6jGt2J
        5k/UByCJ8BtA/+0r84ZAo9NBRRhESf9Gfg==
X-Google-Smtp-Source: ACHHUZ7M04scCze/HzlYDa0ELaHPi0YkisN5CNwzyTjHI34vXKspkNUPI/gWhSH8mErgeQAKSzNyVnx+go8Fyw==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:c041:0:b0:b96:5b8a:3c34 with SMTP id
 c62-20020a25c041000000b00b965b8a3c34mr441564ybf.11.1682598810419; Thu, 27 Apr
 2023 05:33:30 -0700 (PDT)
Date:   Thu, 27 Apr 2023 12:33:11 +0000
In-Reply-To: <20230427123314.1997152-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230427123314.1997152-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427123314.1997152-3-joychakr@google.com>
Subject: [PATCH v9 2/5] spi: dw: Move dw_spi_can_dma()
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
2.40.1.495.gc816e09b53d-goog

