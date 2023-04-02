Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E56D3A5C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 22:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjDBU63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDBU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 16:58:28 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D805393D9
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 13:58:26 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id j4mJp3wID985Cj4mJp2a4R; Sun, 02 Apr 2023 22:58:24 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Apr 2023 22:58:24 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: accel: bmi088: Correctly compute the address of the struct spi_device
Date:   Sun,  2 Apr 2023 22:58:18 +0200
Message-Id: <8da05ad95015e048e3058f275bd57d382420b46f.1680469082.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bmi088_regmap_spi_write() is said to be similar to the SPI generic write
function.
However, regmap_spi_write() calls to_spi_device() in order to find the
reference to the "struct spi_device", instead of considering that 'context'
is already the correct value.

This works because "struct device	dev" is the first entry of
"struct spi_device".

Align bmi088_regmap_spi_write() and regmap_spi_write() to be more
future proof, should "struct spi_device" be shuffled one day.

Also update bmi088_regmap_spi_read() in the same way.

Fixes: c19ae6be7555 ("iio: accel: Add support for the Bosch-Sensortec BMI088")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: do the same for bmi088_regmap_spi_read()
---
 drivers/iio/accel/bmi088-accel-spi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index ee540edd8412..79e4b5392312 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -15,7 +15,8 @@
 
 static int bmi088_regmap_spi_write(void *context, const void *data, size_t count)
 {
-	struct spi_device *spi = context;
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
 
 	/* Write register is same as generic SPI */
 	return spi_write(spi, data, count);
@@ -24,7 +25,8 @@ static int bmi088_regmap_spi_write(void *context, const void *data, size_t count
 static int bmi088_regmap_spi_read(void *context, const void *reg,
 				size_t reg_size, void *val, size_t val_size)
 {
-	struct spi_device *spi = context;
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
 	u8 addr[2];
 
 	addr[0] = *(u8 *)reg;
-- 
2.34.1

