Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB668A6D3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 00:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjBCXN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 18:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjBCXNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 18:13:54 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240708D634;
        Fri,  3 Feb 2023 15:13:53 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n2so4816195pfo.3;
        Fri, 03 Feb 2023 15:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHbHNdg7pHAZm+iH1umTf2t8yLyMxQ4O1NYUoM8SKQ4=;
        b=GH1GgjQZNFEmvuBmSymoXZd3w+dMuweEQssS5Sv0HcRz1X3P4GV6YymXJheadYKSSB
         5/bhs3nVBE7BnbD0iGQ9VX+MDfp1oLJldRwcISktoB9IJfM3Xf/dZk4nDLhFAtdLyjZ8
         IEPYimOB9brCQJ5fclnP74q+AnER8hOsOHpSRa6D//iM9HA917XbAVXQc8qN0lhcyi2x
         +doKrQHfVAzgMmaEdbvZmHqQJO0cDBqI1fU+gpMAaanzseDHR2N//dl2A3+8P3PbZ1R+
         +wOUgZENewKDlU21i0cubU7YKCCfgUJsp/rgH6mjHsgdu0d4qiz+8on6LHEj5zj2C54y
         USHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHbHNdg7pHAZm+iH1umTf2t8yLyMxQ4O1NYUoM8SKQ4=;
        b=AavPbVU+ZzwqmG/3wOOniiQ0rsoSvbjc5ICsRGj6GsKDKl4+0bCm3UtccaitkDc5TK
         BNgPwg7CDNGOgzcQnV0U3OpVE8U0j6eCl+ptMCQYD2GXHnPacHL68JEQs2N1siSM/nxh
         SxKxmUTCura6hbPJAarHx/EUu4rQj8ekajD8yKL7cz1DBtJSt5AlbijIbztqDSd1D4Yz
         gliJ/GLlaO4NEfdV72Ghh+7VI4JFkVS+hmPM9CgUbb1+dXup50X+hEW7y7NIgYnHTKmt
         p04XahYXfxwAIdvUp/9TlGd4LPJKw3RTpETWG/TQiqCl6zfvxmFTuisLpDHzzwYMksQD
         TiSQ==
X-Gm-Message-State: AO0yUKVGSUJBqzcd4zubHmVCuZftouvgACzqmapiGGw8m6SRk7nuIiyt
        o8rGLmyVCCijRxjYNEaNvok=
X-Google-Smtp-Source: AK7set/vkmoUxiQSouNiHnlki72tZjyhwr744ylOZKXLzwrJGtL6LgNiXFtHiBarLCY0WTauLkNiyQ==
X-Received: by 2002:a05:6a00:330d:b0:587:8d47:acdd with SMTP id cq13-20020a056a00330d00b005878d47acddmr11019138pfb.34.1675466032436;
        Fri, 03 Feb 2023 15:13:52 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6e90:bb76:2b36:4df2])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b0056b4c5dde61sm2441207pfa.98.2023.02.03.15.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 15:13:51 -0800 (PST)
Date:   Fri, 3 Feb 2023 15:13:48 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liang He <windhl@126.com>, Wan Jiabing <wanjiabing@vivo.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: c8sectpfe: switch to using gpiod API
Message-ID: <Y92VLGLQJZ/UDRx1@google.com>
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

This switches the driver from using legacy gpio API and to the newer
gpiod API. Since ordinary gpiod APIs operate on logical and not
electrical levels, handling of the reset GPIO is adjusted accordingly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../st/sti/c8sectpfe/c8sectpfe-core.c         | 31 ++++++++-----------
 .../st/sti/c8sectpfe/c8sectpfe-core.h         |  4 ++-
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
index c38b62d4f1ae..dd8141e0828d 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
@@ -16,8 +16,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/dvb/dmx.h>
 #include <linux/dvb/frontend.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -812,30 +814,23 @@ static int c8sectpfe_probe(struct platform_device *pdev)
 		}
 		of_node_put(i2c_bus);
 
-		tsin->rst_gpio = of_get_named_gpio(child, "reset-gpios", 0);
-
-		ret = gpio_is_valid(tsin->rst_gpio);
-		if (!ret) {
-			dev_err(dev,
-				"reset gpio for tsin%d not valid (gpio=%d)\n",
-				tsin->tsin_id, tsin->rst_gpio);
-			ret = -EINVAL;
-			goto err_node_put;
-		}
-
-		ret = devm_gpio_request_one(dev, tsin->rst_gpio,
-					GPIOF_OUT_INIT_LOW, "NIM reset");
+		/* Acquire reset GPIO and activate it */
+		tsin->rst_gpio = devm_fwnode_gpiod_get(dev,
+						       of_fwnode_handle(child),
+						       "reset", GPIOD_OUT_HIGH,
+						       "NIM reset");
+		ret = PTR_ERR_OR_ZERO(tsin->rst_gpio);
 		if (ret && ret != -EBUSY) {
-			dev_err(dev, "Can't request tsin%d reset gpio\n"
-				, fei->channel_data[index]->tsin_id);
+			dev_err(dev, "Can't request tsin%d reset gpio\n",
+				fei->channel_data[index]->tsin_id);
 			goto err_node_put;
 		}
 
 		if (!ret) {
-			/* toggle reset lines */
-			gpio_direction_output(tsin->rst_gpio, 0);
+			/* wait for the chip to reset */
 			usleep_range(3500, 5000);
-			gpio_direction_output(tsin->rst_gpio, 1);
+			/* release the reset line */
+			gpiod_set_value_cansleep(tsin->rst_gpio, 0);
 			usleep_range(3000, 5000);
 		}
 
diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
index c9d6021904cd..bf377cc82225 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
@@ -16,6 +16,8 @@
 
 #define C8SECTPFE_MAX_TSIN_CHAN 8
 
+struct gpio_desc;
+
 struct channel_info {
 
 	int tsin_id;
@@ -25,7 +27,7 @@ struct channel_info {
 	int i2c;
 	int dvb_card;
 
-	int rst_gpio;
+	struct gpio_desc *rst_gpio;
 
 	struct i2c_adapter  *i2c_adapter;
 	struct i2c_adapter  *tuner_i2c;
-- 
2.39.1.519.gcb327c4b5f-goog


-- 
Dmitry
