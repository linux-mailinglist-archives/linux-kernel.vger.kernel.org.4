Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95330680E90
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjA3NKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjA3NKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:10:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B327D11671;
        Mon, 30 Jan 2023 05:10:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C272B810B3;
        Mon, 30 Jan 2023 13:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CECC433EF;
        Mon, 30 Jan 2023 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675084207;
        bh=bZA+wZr8NdCCPrh2rvo5BbcTdhiDb0tNcViWpZHHSXQ=;
        h=From:To:Cc:Subject:Date:From;
        b=soqa2bDobZh0j+klshJUgTokPs/tiAaXd7xgN/pvhIgN1i63K+wcslJsMvSHsf0Cx
         s0gKXrHchYiZgOWOMQRsnEeQGe/JX5GA9fESpmdsgVMzpRfK/tFWg85YeRSq7LXUB3
         U4u1swXhRK1sAP/KSO/zhaA4iHlBSy0hy1m1cN0/pOKY0UK+mB6CQu8UCGB8u9oxVe
         u8OfoAk1MdhSsQBK1yrbPBcBwSKjAY1leK/5gxJMr4p4bzWAy6lzAK1sTs8iIMQjm4
         id7tHX34c5wMtDgBH+SpzqjbtbBE3O1vcQOn8zE3n0VGwo5sXwcA2bLniZPQKGBKoI
         Mla4/YvUqwuyg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: c8sectpfe: convert to gpio descriptors
Date:   Mon, 30 Jan 2023 14:09:47 +0100
Message-Id: <20230130131003.668888-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The gpio usage in the function is fairly straightforward,
but the normal gpiod_get() interface cannot be used here
since the gpio is referenced by a child node of the device.

Using devm_fwnode_gpiod_get_index() is the best alternative
here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../st/sti/c8sectpfe/c8sectpfe-core.c         | 30 ++++++++-----------
 .../st/sti/c8sectpfe/c8sectpfe-core.h         |  2 +-
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
index c38b62d4f1ae..86a2c77c5471 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
@@ -22,7 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -812,30 +812,24 @@ static int c8sectpfe_probe(struct platform_device *pdev)
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
+		tsin->rst_gpio = devm_fwnode_gpiod_get_index(dev,
+							     of_node_to_fwnode(child),
+							     "reset-gpios",
+							     0, GPIOD_OUT_LOW,
+							     "NIM reset");
+		ret = PTR_ERR_OR_ZERO(tsin->rst_gpio);
 		if (ret && ret != -EBUSY) {
-			dev_err(dev, "Can't request tsin%d reset gpio\n"
-				, fei->channel_data[index]->tsin_id);
+			dev_err_probe(dev, ret,
+				      "reset gpio for tsin%d not valid\n",
+				      tsin->tsin_id);
 			goto err_node_put;
 		}
 
 		if (!ret) {
 			/* toggle reset lines */
-			gpio_direction_output(tsin->rst_gpio, 0);
+			gpiod_direction_output(tsin->rst_gpio, 0);
 			usleep_range(3500, 5000);
-			gpio_direction_output(tsin->rst_gpio, 1);
+			gpiod_direction_output(tsin->rst_gpio, 1);
 			usleep_range(3000, 5000);
 		}
 
diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
index c9d6021904cd..f2a6991e064e 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
@@ -25,7 +25,7 @@ struct channel_info {
 	int i2c;
 	int dvb_card;
 
-	int rst_gpio;
+	struct gpio_desc *rst_gpio;
 
 	struct i2c_adapter  *i2c_adapter;
 	struct i2c_adapter  *tuner_i2c;
-- 
2.39.0

