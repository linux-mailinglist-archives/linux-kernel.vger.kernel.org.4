Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E905EE9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiI1XAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiI1XA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:00:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0647588DD2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:00:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y136so13795207pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=aRmvPLbVqyeYfR8jrKggHhDgI4BOBfgErJLYPQEf8zo=;
        b=jyY5Do7EG3BP4efMc0KAzEnwd6T7Lft+Gr75P0+BUGlg6osxxZnay+JA5t/1aYJiv2
         bPQW/lDElLZK8Mz1kceDbWikHaVO3JdVtGOK/1ohFlqx2fW0L8yzOiAYl+jk0rHxw72A
         mHWv66INXWtEguDbR4sZmvsCFi3oeiVlJF2W+Hc+YtbBLLo633/f6mPms2wzxgi7Pm+R
         Lc6j7+51w3gqMElDI0Cwx+CUKWTlcCVRTkaAGI507rG+ZC/JbEgBJJVH3fPxnbB8Symz
         yT8TmqzTDu3L57mFyLfkJ0aNQaqxNtG7+QG76/6dTN2LfIQx6Nc1dOE8koC8Jnr0STs7
         HMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=aRmvPLbVqyeYfR8jrKggHhDgI4BOBfgErJLYPQEf8zo=;
        b=hcZFzhwLd7uZ2o9tmaFURLPy/+4++ITgrQPlFSxCgveT+Y9+NxG3XK1znzVnGMBfGD
         KBr1MI1eDz14V5JJ3gffYRQaCLPEfX6Czh2C9c0ZRoY4XFVz9TpX2xJl9Ur1vp3DrIWA
         2oSrUAtQWuodSpE9OJ/xb8f6Qay8e6Q2k0WyCciuNYi2j2iJ6BlAiWnqIrKlmjVZeSsO
         MjSwlg9TaIhFhxI450QNd+nltsK8A/XhE22RFckt+5toGYvrignEoNMejmKL7xsjx+Ig
         rz+viNv02R6iaYmTgl+36pjQilkQewWJJ+bvRvPAoADf8G9LOWU8ALcPFruJ63B+CP8N
         od4A==
X-Gm-Message-State: ACrzQf3bHoch4QHSD9knGOTTFzLJ/RvKBSAN9fNAvQFWvs4ow940Rv9d
        JJV/jlJah9IkBL0uNNP03e8=
X-Google-Smtp-Source: AMsMyM672WkdpF+Fr+/dBERjTMv7DVJOVMorvKJjf9aWXck+J6sr7PTWpW333Sd/zP0ESJRe3lh7nA==
X-Received: by 2002:a05:6a00:1410:b0:528:5a5a:d846 with SMTP id l16-20020a056a00141000b005285a5ad846mr229341pfu.9.1664406022342;
        Wed, 28 Sep 2022 16:00:22 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:1a91:59b8:faf:7b4f])
        by smtp.gmail.com with ESMTPSA id 195-20020a6216cc000000b0055a9c9cfc63sm2737309pfw.201.2022.09.28.16.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 16:00:21 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: rawnand: lpc32xx_mlc: switch to using gpiod API
Date:   Wed, 28 Sep 2022 16:00:18 -0700
Message-Id: <20220928230019.2140896-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the driver from legacy gpio API to a newer gpiod API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mtd/nand/raw/lpc32xx_mlc.c | 36 ++++++++++++++++--------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 452ecaf7775a..306e2c216501 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -25,7 +25,7 @@
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mtd/lpc32xx_mlc.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -122,7 +122,6 @@ struct lpc32xx_nand_cfg_mlc {
 	uint32_t rd_low;
 	uint32_t wr_high;
 	uint32_t wr_low;
-	int wp_gpio;
 	struct mtd_partition *parts;
 	unsigned num_parts;
 };
@@ -177,6 +176,7 @@ struct lpc32xx_nand_host {
 	struct nand_chip	nand_chip;
 	struct lpc32xx_mlc_platform_data *pdata;
 	struct clk		*clk;
+	struct gpio_desc	*wp_gpio;
 	void __iomem		*io_base;
 	int			irq;
 	struct lpc32xx_nand_cfg_mlc	*ncfg;
@@ -370,8 +370,8 @@ static int lpc32xx_waitfunc(struct nand_chip *chip)
  */
 static void lpc32xx_wp_enable(struct lpc32xx_nand_host *host)
 {
-	if (gpio_is_valid(host->ncfg->wp_gpio))
-		gpio_set_value(host->ncfg->wp_gpio, 0);
+	if (host->wp_gpio)
+		gpiod_set_value_cansleep(host->wp_gpio, 1);
 }
 
 /*
@@ -379,8 +379,8 @@ static void lpc32xx_wp_enable(struct lpc32xx_nand_host *host)
  */
 static void lpc32xx_wp_disable(struct lpc32xx_nand_host *host)
 {
-	if (gpio_is_valid(host->ncfg->wp_gpio))
-		gpio_set_value(host->ncfg->wp_gpio, 1);
+	if (host->wp_gpio)
+		gpiod_set_value_cansleep(host->wp_gpio, 0);
 }
 
 static void lpc32xx_dma_complete_func(void *completion)
@@ -636,8 +636,6 @@ static struct lpc32xx_nand_cfg_mlc *lpc32xx_parse_dt(struct device *dev)
 		return NULL;
 	}
 
-	ncfg->wp_gpio = of_get_named_gpio(np, "gpios", 0);
-
 	return ncfg;
 }
 
@@ -713,14 +711,18 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 			"Missing or bad NAND config from device tree\n");
 		return -ENOENT;
 	}
-	if (host->ncfg->wp_gpio == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-	if (gpio_is_valid(host->ncfg->wp_gpio) &&
-			gpio_request(host->ncfg->wp_gpio, "NAND WP")) {
-		dev_err(&pdev->dev, "GPIO not available\n");
-		return -EBUSY;
+
+	/* Start with WP disabled, if available */
+	host->wp_gpio = gpiod_get_optional(&pdev->dev, NULL, GPIOD_OUT_LOW);
+	res = PTR_ERR_OR_ZERO(host->wp_gpio);
+	if (res) {
+		if (res != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "WP GPIO is not available: %d\n",
+				res);
+		return res;
 	}
-	lpc32xx_wp_disable(host);
+
+	gpiod_set_consumer_name(host->wp_gpio, "NAND WP");
 
 	host->pdata = dev_get_platdata(&pdev->dev);
 
@@ -817,7 +819,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	clk_put(host->clk);
 free_gpio:
 	lpc32xx_wp_enable(host);
-	gpio_free(host->ncfg->wp_gpio);
+	gpiod_put(host->wp_gpio);
 
 	return res;
 }
@@ -843,7 +845,7 @@ static int lpc32xx_nand_remove(struct platform_device *pdev)
 	clk_put(host->clk);
 
 	lpc32xx_wp_enable(host);
-	gpio_free(host->ncfg->wp_gpio);
+	gpiod_put(host->wp_gpio);
 
 	return 0;
 }
-- 
2.38.0.rc1.362.ged0d419d3c-goog

