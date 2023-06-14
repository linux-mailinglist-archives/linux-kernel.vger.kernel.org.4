Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8E730925
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjFNU0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjFNU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:26:10 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97C8211D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:26:08 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 9X49qJzAr4jPd9X49qRAft; Wed, 14 Jun 2023 22:26:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686774366;
        bh=K4LJUPD0skruLm7yHJrG7KQ6uvH9CtyWKlTfipvO1Lo=;
        h=From:To:Cc:Subject:Date;
        b=DdQVwEyCPQeNkV3XKl0QQvAdK7pKxp0g2BdKAipl5f/cV9Ov+swXrvCVzI50H+pV2
         DUhTKxRleH6bMIrcb+6tfEZ9ysf0AR0ISujujQzZB1WVic0MmkhdrNlNRghvAwQdi7
         42hYdVK6aCx7ilKuRy9H/uX/dgMAGqyv7nyHO2Kv/WP+Vz2ed5T65SWqq+iW8oNgqT
         ig8Mr7jORjkQDRSCDspHH/RSX3Qa9xdPD4XpXhPcFkCPnzARJHyCWPI7c4FbD/ocfp
         bTnzCIeO2tzMLgkgwl7Y9HnQxQ2BlAO6hO0/SzfXhBRFKksSpwTW5mCpkQyJgkLURd
         np/nhoI2Vi4Iw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 14 Jun 2023 22:26:06 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ad7192: Simplify using devm_clk_get_optional_enabled()
Date:   Wed, 14 Jun 2023 22:26:04 +0200
Message-Id: <7dbe973905f1fdae5d2f5ae5a3b01dd1d6a9925b.1686774340.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If st->mclk is not NULL, then st->clock_sel is either AD7192_CLK_EXT_MCLK2
or AD7192_CLK_EXT_MCLK1_2.

So devm_clk_get_optional_enabled() can be used instead of hand writing it.
This saves some line of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/adc/ad7192.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8685e0b58a83..5dcb257ad754 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -972,11 +972,6 @@ static void ad7192_reg_disable(void *reg)
 	regulator_disable(reg);
 }
 
-static void ad7192_clk_disable(void *clk)
-{
-	clk_disable_unprepare(clk);
-}
-
 static int ad7192_probe(struct spi_device *spi)
 {
 	struct ad7192_state *st;
@@ -1044,7 +1039,7 @@ static int ad7192_probe(struct spi_device *spi)
 
 	st->fclk = AD7192_INT_FREQ_MHZ;
 
-	st->mclk = devm_clk_get_optional(&spi->dev, "mclk");
+	st->mclk = devm_clk_get_optional_enabled(&spi->dev, "mclk");
 	if (IS_ERR(st->mclk))
 		return PTR_ERR(st->mclk);
 
@@ -1052,15 +1047,6 @@ static int ad7192_probe(struct spi_device *spi)
 
 	if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
 	    st->clock_sel == AD7192_CLK_EXT_MCLK2) {
-		ret = clk_prepare_enable(st->mclk);
-		if (ret < 0)
-			return ret;
-
-		ret = devm_add_action_or_reset(&spi->dev, ad7192_clk_disable,
-					       st->mclk);
-		if (ret)
-			return ret;
-
 		st->fclk = clk_get_rate(st->mclk);
 		if (!ad7192_valid_external_frequency(st->fclk)) {
 			dev_err(&spi->dev,
-- 
2.34.1

