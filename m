Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C575EE9CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiI1XAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI1XA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:00:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655A2876BD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:00:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso4186193pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xyqBAfgMbKsG1bS9uEwWZcTc5tk+jlmU9fHypf3OEa8=;
        b=qMlo9j6pwVeIXEkAqDxCLVfOQMlsJyt9JqKdiPj4tVyYOukDxmo7KPJTVSOVb3Ct5/
         b9SeT7Tkpj0kN2nTqKhl9LXmHDkh+dzst1c39jqqISYEncYKk4kcsEAuhYkfKu4lqz9T
         uQNxzE6MCKbyitvpyqhtAYC3XcitXtuaU3YnXt6aPFn9vrT+ayQlcavjLD+BAwCk30aW
         Des3aeC/VmClpav5U1vm3DGda5wrtA8EGIIwZ+HTSc2bMIJvzOr2hJwb9TjFKYd833eN
         gBhkvevEiaww9GmFBM9EhdUNWEL3Bail3KjZ6YTkmIWBruhQwmnN4dD7+ZuwzO9qiOr1
         m6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xyqBAfgMbKsG1bS9uEwWZcTc5tk+jlmU9fHypf3OEa8=;
        b=tTnJ6wYKDjzm2Q3pjZi3FagwqCfgjTONmTx6WclzT9zX9dGfUA1LKAZ8bpVXvVJUuN
         RU8PPmq9aIzMl0WeEdgxXNhPxp4/w2i1SKHIIEPDwwKfe8Wd6kVXrf660kvh5Z4nf3jo
         AOccZZESKF+pppGZsUGQraF6iHXfnq0jwpK2U8QJ8jpjVwUDVqk72zZO9aL8dUFP/2EN
         bRJsKRIorFt85/rKwptVcoU1v3QSq0vQlrWS8R1fUrqFpdU3tFmkXxIRimDmUY6A2YP8
         JmuMb5lHAMiV0csp16G4RgwOQHqm+LToJ4H1vbL7G0QlZRhxFlhWnEaGxk3vHtN2heyW
         bjiw==
X-Gm-Message-State: ACrzQf2msZBp7lRUs00SBJXRuRg0b5cIIzBSwVssJcBRpi1SSOvSSv/R
        8f0v2DNbJxvqz+TPWoYK5I0=
X-Google-Smtp-Source: AMsMyM4K00C1K9/RwNv26xbu6eFrQCL0UdWQJ9PWWJc0wRHtpsPsuIVgcMdBqNA7IUd7lckZty0ebA==
X-Received: by 2002:a17:90b:3ec2:b0:202:b123:29cc with SMTP id rm2-20020a17090b3ec200b00202b12329ccmr13094369pjb.167.1664406023559;
        Wed, 28 Sep 2022 16:00:23 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:1a91:59b8:faf:7b4f])
        by smtp.gmail.com with ESMTPSA id 195-20020a6216cc000000b0055a9c9cfc63sm2737309pfw.201.2022.09.28.16.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 16:00:23 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mtd: rawnand: lpc32xx_slc: switch to using gpiod API
Date:   Wed, 28 Sep 2022 16:00:19 -0700
Message-Id: <20220928230019.2140896-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220928230019.2140896-1-dmitry.torokhov@gmail.com>
References: <20220928230019.2140896-1-dmitry.torokhov@gmail.com>
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
 drivers/mtd/nand/raw/lpc32xx_slc.c | 33 +++++++++++++++---------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 6b7269cfb7d8..4702577f74e5 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -23,9 +23,8 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/mtd/lpc32xx_slc.h>
 
 #define LPC32XX_MODNAME		"lpc32xx-nand"
@@ -208,7 +207,6 @@ struct lpc32xx_nand_cfg_slc {
 	uint32_t rwidth;
 	uint32_t rhold;
 	uint32_t rsetup;
-	int wp_gpio;
 	struct mtd_partition *parts;
 	unsigned num_parts;
 };
@@ -217,6 +215,7 @@ struct lpc32xx_nand_host {
 	struct nand_chip	nand_chip;
 	struct lpc32xx_slc_platform_data *pdata;
 	struct clk		*clk;
+	struct gpio_desc	*wp_gpio;
 	void __iomem		*io_base;
 	struct lpc32xx_nand_cfg_slc *ncfg;
 
@@ -309,8 +308,8 @@ static int lpc32xx_nand_device_ready(struct nand_chip *chip)
  */
 static void lpc32xx_wp_enable(struct lpc32xx_nand_host *host)
 {
-	if (gpio_is_valid(host->ncfg->wp_gpio))
-		gpio_set_value(host->ncfg->wp_gpio, 0);
+	if (host->wp_gpio)
+		gpiod_set_value_cansleep(host->wp_gpio, 1);
 }
 
 /*
@@ -318,8 +317,8 @@ static void lpc32xx_wp_enable(struct lpc32xx_nand_host *host)
  */
 static void lpc32xx_wp_disable(struct lpc32xx_nand_host *host)
 {
-	if (gpio_is_valid(host->ncfg->wp_gpio))
-		gpio_set_value(host->ncfg->wp_gpio, 1);
+	if (host->wp_gpio)
+		gpiod_set_value_cansleep(host->wp_gpio, 0);
 }
 
 /*
@@ -764,8 +763,6 @@ static struct lpc32xx_nand_cfg_slc *lpc32xx_parse_dt(struct device *dev)
 		return NULL;
 	}
 
-	ncfg->wp_gpio = of_get_named_gpio(np, "gpios", 0);
-
 	return ncfg;
 }
 
@@ -852,14 +849,18 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 			"Missing or bad NAND config from device tree\n");
 		return -ENOENT;
 	}
-	if (host->ncfg->wp_gpio == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-	if (gpio_is_valid(host->ncfg->wp_gpio) && devm_gpio_request(&pdev->dev,
-			host->ncfg->wp_gpio, "NAND WP")) {
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
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

