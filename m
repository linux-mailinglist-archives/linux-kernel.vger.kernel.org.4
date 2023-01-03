Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF46C65C102
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjACNm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjACNmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:42:51 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AD610FF3;
        Tue,  3 Jan 2023 05:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1672753370;
  x=1704289370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SRMK9ZFIllFl+4lflyBvei6idrkhW9/rumwBK8/9S3g=;
  b=SCi+DDptFfzcA4cNYTK6sWeLOHUJ91fi5AaCBafUv9BCIU+qXNZ6lyj6
   fAegqXgZnrNup0YYgSckbvYpCCdNJmm4mqi7MZCe0iLZeWhJcGgBmy959
   bG0BelxJFbf+MHUf6uUKKKcLk1iSkA0A5CWjGA1vpMl1kXntP0FwAZHDS
   e+FF1UF8rGDhsLkK5z6u9hCMo+03byLNUOMQavdF/aBTgoqigh4x/KYGZ
   oLlC9ltmbqBhAlMXTJnDVDSmWzjJ+bheoi+DEJsR1qPknRcAwOid9Iux8
   CMcckam+aT1qchH28DPHCCd0sBHnd+soGAppJqhZcxM/4Lv/DXYrptTM7
   A==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jiri Valek - 2N <jiriv@axis.com>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Input: cap11xx - add support for cap1203, cap1293 and cap1298
Date:   Tue, 3 Jan 2023 14:41:05 +0100
Message-ID: <20230103134105.736346-3-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103134105.736346-1-jiriv@axis.com>
References: <20230103134105.736346-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail03w.axis.com
 (10.20.40.9)
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

Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
---
 drivers/input/keyboard/cap11xx.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 79afd0386e3f..ae226fb4fabd 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -99,6 +99,9 @@ enum {
 	CAP1126,
 	CAP1188,
 	CAP1206,
+	CAP1203,
+	CAP1293,
+	CAP1298
 };
 
 static const struct cap11xx_hw_model cap11xx_devices[] = {
@@ -106,6 +109,9 @@ static const struct cap11xx_hw_model cap11xx_devices[] = {
 	[CAP1126] = { .product_id = 0x53, .num_channels = 6, .num_leds = 2, .no_gain = false },
 	[CAP1188] = { .product_id = 0x50, .num_channels = 8, .num_leds = 8, .no_gain = false },
 	[CAP1206] = { .product_id = 0x67, .num_channels = 6, .num_leds = 0, .no_gain = true },
+	[CAP1203] = { .product_id = 0x6d, .num_channels = 3, .num_leds = 0, .no_gain = true },
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
@@ -390,7 +397,10 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 			dev_err(dev, "Invalid sensor-gain value %d\n", gain32);
 	}
 
-	if (id->driver_data != CAP1206) {
+	if ((id->driver_data != CAP1206) ||
+		(id->driver_data != CAP1203) ||
+		(id->driver_data != CAP1293) ||
+		(id->driver_data != CAP1298)) {
 		if (of_property_read_bool(node, "microchip,irq-active-high")) {
 			error = regmap_update_bits(priv->regmap,
 						   CAP11XX_REG_CONFIG2,
@@ -484,6 +494,9 @@ static const struct of_device_id cap11xx_dt_ids[] = {
 	{ .compatible = "microchip,cap1126", },
 	{ .compatible = "microchip,cap1188", },
 	{ .compatible = "microchip,cap1206", },
+	{ .compatible = "microchip,cap1203", },
+	{ .compatible = "microchip,cap1293", },
+	{ .compatible = "microchip,cap1298", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, cap11xx_dt_ids);
@@ -493,6 +506,9 @@ static const struct i2c_device_id cap11xx_i2c_ids[] = {
 	{ "cap1126", CAP1126 },
 	{ "cap1188", CAP1188 },
 	{ "cap1206", CAP1206 },
+	{ "cap1203", CAP1203 },
+	{ "cap1293", CAP1293 },
+	{ "cap1298", CAP1298 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, cap11xx_i2c_ids);
-- 
2.25.1

