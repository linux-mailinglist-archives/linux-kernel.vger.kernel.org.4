Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596A95E731B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIWEvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiIWEvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:51:42 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1AE1257B8;
        Thu, 22 Sep 2022 21:51:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v186so3396912pfv.11;
        Thu, 22 Sep 2022 21:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=b35zRPzYTW3YcMFjPUs7tbt9oJmqYvqFZz+zcYoQ4SA=;
        b=XpSM0Sf4ZC24Je5xMvD+SDVxbUX0lEnIkxsGtODtvE+eMRXNZzTdD3Ws9AwnsQQM3a
         Ic5NL0WAgNgzQTXp871xmt+DdbE6Q6NxORG/G+yKdHmoKWv7KH2MeCI4bGPJqKmeGri7
         1xgRW5y9D60FYZHeeQy/3xWAmqhKcdLXCwHatMIRAeGIf7/wVXfDyGh1b2Lx3TbbyPuj
         F3n2lb6WjM92NLzh+8QxjrDXRTbxrvuX6Jgzr9FYa1WL8W4nMtY7VwtRmmCWY95kc9pq
         kjcRkqOibrDvBC/KM9hFFnngPNXAstrdD5Pb7p8+OQz2sFmyvFskvfLe7GHMO2JN3AON
         J05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=b35zRPzYTW3YcMFjPUs7tbt9oJmqYvqFZz+zcYoQ4SA=;
        b=A5APAiK7ta+qZEvVtqbPbzuboTPySy7MSpOpuv+8O9kkh55okJCQpyfti6LzlvB23M
         et1IDhZE733ZxbPUobincZfOf1/mBZshv7wzaYjPL2kna5uAZKR3J36Gh7SpxTWE9O0T
         t6k51gBuA+mieil3Ti+UUFoQ1iV0o7EDrBavOiZQNLiUMHcrJYX3QZan/bT3TjvcX0oR
         WF9tOaXJLHyTQsXINqLBVcrFeMV1QsTHV8VRVjnQNs3ZK1fW3X3Cv/1JyVbP0qH3J6NL
         Msw0wlTYZraOI2bZfQ3jWEBFaIVf2dfWIH1QRcJH/Q6gHOHRWIWDngh1JLfO3VG370S0
         QA4g==
X-Gm-Message-State: ACrzQf0s0fqSRWTXvlleYXYViL0BipnxYYCeEI7MeXD6RyLF1JXZaEBE
        IrK9xqB9drIAXomwuTu0beKLYLMqDbE=
X-Google-Smtp-Source: AMsMyM6iGcFzVme/eCS5PUnUwsXSzLPtUfbNkfKMDz8cHzNprEyTkSBT3N1reKkidr+y5mmKuj9hjw==
X-Received: by 2002:a62:e911:0:b0:555:8c06:c9eb with SMTP id j17-20020a62e911000000b005558c06c9ebmr5089529pfh.52.1663908700891;
        Thu, 22 Sep 2022 21:51:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8b46:be3c:2c54:68a5])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090332c200b0017834a6966csm5156120plr.176.2022.09.22.21.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 21:51:40 -0700 (PDT)
Date:   Thu, 22 Sep 2022 21:51:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-mpc52xx: switch to using gpiod API
Message-ID: <Yy07WbMAG4bPgYNd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the driver to use gpiod API instead of legacy gpio API,
which will brings us close to removing of_get_gpio() and other
OF-specific old APIs.

No functional change intended beyond some differences in error messages.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/spi/spi-mpc52xx.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 97cdd6545ee1..cb075c1acbee 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
@@ -18,7 +19,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/io.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -90,7 +90,7 @@ struct mpc52xx_spi {
 	const u8 *tx_buf;
 	int cs_change;
 	int gpio_cs_count;
-	unsigned int *gpio_cs;
+	struct gpio_desc **gpio_cs;
 };
 
 /*
@@ -102,9 +102,10 @@ static void mpc52xx_spi_chipsel(struct mpc52xx_spi *ms, int value)
 
 	if (ms->gpio_cs_count > 0) {
 		cs = ms->message->spi->chip_select;
-		gpio_set_value(ms->gpio_cs[cs], value ? 0 : 1);
-	} else
+		gpiod_set_value(ms->gpio_cs[cs], value);
+	} else {
 		out_8(ms->regs + SPI_PORTDATA, value ? 0 : 0x08);
+	}
 }
 
 /*
@@ -386,10 +387,10 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 {
 	struct spi_master *master;
 	struct mpc52xx_spi *ms;
+	struct gpio_desc *gpio_cs;
 	void __iomem *regs;
 	u8 ctrl1;
 	int rc, i = 0;
-	int gpio_cs;
 
 	/* MMIO registers */
 	dev_dbg(&op->dev, "probing mpc5200 SPI device\n");
@@ -451,23 +452,16 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 		}
 
 		for (i = 0; i < ms->gpio_cs_count; i++) {
-			gpio_cs = of_get_gpio(op->dev.of_node, i);
-			if (!gpio_is_valid(gpio_cs)) {
-				dev_err(&op->dev,
-					"could not parse the gpio field in oftree\n");
-				rc = -ENODEV;
-				goto err_gpio;
-			}
-
-			rc = gpio_request(gpio_cs, dev_name(&op->dev));
+			gpio_cs = gpiod_get_index(&op->dev,
+						  NULL, i, GPIOD_OUT_LOW);
+			rc = PTR_ERR_OR_ZERO(gpio_cs);
 			if (rc) {
 				dev_err(&op->dev,
-					"can't request spi cs gpio #%d on gpio line %d\n",
-					i, gpio_cs);
+					"failed to get spi cs gpio #%d: %d\n",
+					i, rc);
 				goto err_gpio;
 			}
 
-			gpio_direction_output(gpio_cs, 1);
 			ms->gpio_cs[i] = gpio_cs;
 		}
 	}
@@ -508,7 +502,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	dev_err(&ms->master->dev, "initialization failed\n");
  err_gpio:
 	while (i-- > 0)
-		gpio_free(ms->gpio_cs[i]);
+		gpiod_put(ms->gpio_cs[i]);
 
 	kfree(ms->gpio_cs);
  err_alloc_gpio:
@@ -529,7 +523,7 @@ static int mpc52xx_spi_remove(struct platform_device *op)
 	free_irq(ms->irq1, ms);
 
 	for (i = 0; i < ms->gpio_cs_count; i++)
-		gpio_free(ms->gpio_cs[i]);
+		gpiod_put(ms->gpio_cs[i]);
 
 	kfree(ms->gpio_cs);
 	spi_unregister_master(master);
-- 
2.37.3.998.g577e59143f-goog


-- 
Dmitry
