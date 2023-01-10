Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322446644D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjAJPaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbjAJP34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:29:56 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157EA2726;
        Tue, 10 Jan 2023 07:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673364568;
  x=1704900568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y9TFaBNCB2DZlBpUhclkx95oVenxfjVvcEEeJ14NYjM=;
  b=eevBbJR34FKLdiGa3nhhjG4He3cHT8IHcOwNE8GCLSrZauViP/ynvhCQ
   Wk7dEULvk3B7bY8ZYx4i+sAwtLV61bJ/yUXd27BFwx3ZXg+sNgzBSsX8B
   MqidddrfbAPL6rkwRrTlVTK3MpjlQTLR6bhCZU8y9g0DYsaSLxLXfVZ1W
   rN3x6Y++IN7QPr5+igQ0m1oNDOpdX1H363DbUDA+uJVD/apOfW5P3lA67
   DPU7SMiWFlxtdU510KKH9qJIwDpLWvuV1ny/a1kL/sqtb3lC+PC0EGIRT
   +8jK5UJp4KNJArIzxi4icVV3I5ormvfIN3LwnIwOMa+320NSJHZp1CBCm
   w==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <linux-input@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <jiriv@axis.com>
Subject: [PATCH v3 2/2] Input: cap11xx - add support for cap1203, cap1293 and cap1298
Date:   Tue, 10 Jan 2023 16:28:59 +0100
Message-ID: <20230110152859.295881-3-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110152859.295881-1-jiriv@axis.com>
References: <20230110152859.295881-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail07w.axis.com (10.20.40.13) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for more CAP1xxx sensors.
All models from CAP1xxx family are register-compatible.
Some advanced features are not used and disabled by default.

Reported-by: kernel test robot <lkp@xxxxxxxxx>
Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
---
Changes in v2:
  - Fixed if statement.
  
Changes in v3:
  - Model names sorted alphabetically.
  
 drivers/input/keyboard/cap11xx.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 79afd0386e3f..ce27168302a8 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -98,14 +98,20 @@ enum {
 	CAP1106,
 	CAP1126,
 	CAP1188,
+	CAP1203,
 	CAP1206,
+	CAP1293,
+	CAP1298
 };
 
 static const struct cap11xx_hw_model cap11xx_devices[] = {
 	[CAP1106] = { .product_id = 0x55, .num_channels = 6, .num_leds = 0, .no_gain = false },
 	[CAP1126] = { .product_id = 0x53, .num_channels = 6, .num_leds = 2, .no_gain = false },
 	[CAP1188] = { .product_id = 0x50, .num_channels = 8, .num_leds = 8, .no_gain = false },
+	[CAP1203] = { .product_id = 0x6d, .num_channels = 3, .num_leds = 0, .no_gain = true },
 	[CAP1206] = { .product_id = 0x67, .num_channels = 6, .num_leds = 0, .no_gain = true },
+	[CAP1293] = { .product_id = 0x6f, .num_channels = 3, .num_leds = 0, .no_gain = false },
+	[CAP1298] = { .product_id = 0x71, .num_channels = 8, .num_leds = 0, .no_gain = false },
 };
 
 static const struct reg_default cap11xx_reg_defaults[] = {
@@ -377,7 +383,8 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	if (error < 0)
 		return error;
 
-	dev_info(dev, "CAP11XX detected, revision 0x%02x\n", rev);
+	dev_info(dev, "CAP11XX detected, model %s, revision 0x%02x\n",
+			id->name, rev);
 	node = dev->of_node;
 
 	if (!of_property_read_u32(node, "microchip,sensor-gain", &gain32)) {
@@ -390,7 +397,9 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 			dev_err(dev, "Invalid sensor-gain value %d\n", gain32);
 	}
 
-	if (id->driver_data != CAP1206) {
+	if ((id->driver_data == CAP1106) ||
+		(id->driver_data == CAP1126) ||
+		(id->driver_data == CAP1188)) {
 		if (of_property_read_bool(node, "microchip,irq-active-high")) {
 			error = regmap_update_bits(priv->regmap,
 						   CAP11XX_REG_CONFIG2,
@@ -483,7 +492,10 @@ static const struct of_device_id cap11xx_dt_ids[] = {
 	{ .compatible = "microchip,cap1106", },
 	{ .compatible = "microchip,cap1126", },
 	{ .compatible = "microchip,cap1188", },
+	{ .compatible = "microchip,cap1203", },
 	{ .compatible = "microchip,cap1206", },
+	{ .compatible = "microchip,cap1293", },
+	{ .compatible = "microchip,cap1298", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, cap11xx_dt_ids);
@@ -492,7 +504,10 @@ static const struct i2c_device_id cap11xx_i2c_ids[] = {
 	{ "cap1106", CAP1106 },
 	{ "cap1126", CAP1126 },
 	{ "cap1188", CAP1188 },
+	{ "cap1203", CAP1203 },
 	{ "cap1206", CAP1206 },
+	{ "cap1293", CAP1293 },
+	{ "cap1298", CAP1298 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, cap11xx_i2c_ids);
-- 
2.25.1

