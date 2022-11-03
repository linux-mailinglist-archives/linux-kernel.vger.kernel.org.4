Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE3617882
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKCIQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKCIQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:16:23 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 01:16:22 PDT
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8985FAD;
        Thu,  3 Nov 2022 01:16:22 -0700 (PDT)
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 104815827E;
        Thu,  3 Nov 2022 08:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1667462464; bh=AxBdGD11GmXU93SjZlmfOt6f3j2/0l1361xkEdsg1iY=;
        h=From:To:Cc:Subject:Date;
        b=MItX3BnDqsJI383c0+PBt/GME0eDbQLDxRiavRuKSNAy/yQpifuYqntqZYZY4xU8w
         +L4mJtyxMKjUDBl9CfhtrsoG5TM2ZqQ145mOVW46Y4uKXA6Y2/lZ85ZmRfBNSdQr7y
         wYHJDxLX70KD/05Vf1D9SjdxSOr6tn7hBIt7bVhCGLb11TNl0rtN4G5FDP0rk9PtgD
         OKhZVlTaf8/VzC6Va67o7OV7G/dZEZ9zcz25LJa70BNLagI6dtXlfkv20iOWNTKCYH
         GokLqv+abyfNy7MBBLu508XAjUPreBF54rQHx/7KwQxobCPWq+W/gDv22xxCCZk/hs
         lXWo8gAr6H5rQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: stm32: fix stm32_spi_prepare_mbr() that halves spi clk for every run
Date:   Thu,  3 Nov 2022 09:00:42 +0100
Message-Id: <20221103080043.3033414-1-sean@geanix.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When this driver is used with a driver that uses preallocated spi_transfer
structs. The speed_hz is halved by every run. This results in:

spi_stm32 44004000.spi: SPI transfer setup failed
ads7846 spi0.0: SPI transfer failed: -22

Example when running with DIV_ROUND_UP():
- First run; speed_hz = 1000000, spi->clk_rate 125000000
  div 125 -> mbrdiv = 7, cur_speed = 976562
- Second run; speed_hz = 976562
  div 128,00007 (roundup to 129) -> mbrdiv = 8, cur_speed = 488281
- Third run; speed_hz = 488281
  div 256,000131072067109 (roundup to 257) and then -EINVAL is returned.

Use DIV_ROUND_CLOSEST to allow to round down and allow us to keep the
set speed.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 6fe617b445a5..d6833361409d 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -434,7 +434,7 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
 	u32 div, mbrdiv;
 
 	/* Ensure spi->clk_rate is even */
-	div = DIV_ROUND_UP(spi->clk_rate & ~0x1, speed_hz);
+	div = DIV_ROUND_CLOSEST(spi->clk_rate & ~0x1, speed_hz);
 
 	/*
 	 * SPI framework set xfer->speed_hz to master->max_speed_hz if
-- 
2.38.1

