Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55E870C0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjEVO0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjEVO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:26:30 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A052A3;
        Mon, 22 May 2023 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684765588;
  x=1716301588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zp9g6LGMcrNga0LDQCnxSABwd8l8hW09UrHEcEB+7N8=;
  b=XoXlMLrHRjm0jCyihZNJCDRGRDwDm3QuXQyO/pjTIGYuFolZSgwLjT9W
   BtZuHTQ31zTsNzp4vCvoP+RVVJiKqpIfUZgltv0rYdVOUhv+EYEICd/o3
   9L0hhmtMIRowjlOiNzAXpK+7RldJFaTB1oxIJXhqaThUFsoqq7y3sQsCW
   RV+5hABc/Yyfwn9QxYLhNNql37KmW5daSEBP7t/tBvJzPGDcxl8pOpw3z
   yvAlura1Bkmb8231q5hjlBPSj4ieTvsGIkNbm2n6l/zK1J7HU9zKiFSJI
   TxrfX2YS9rLCG0Tc2Rka9SLj/DB9aCpxdgdvnwUS8RCtrAiqBV+w/Ua5S
   Q==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v4 1/7] iio: light: vcnl4000: Add proximity irq for vcnl4200
Date:   Mon, 22 May 2023 16:26:15 +0200
Message-ID: <20230522142621.1680563-2-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522142621.1680563-1-astrid.rost@axis.com>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proximity interrupt support for vcnl4200 (similar to vcnl4040).
Add support to configure proximity sensor interrupts and threshold
limits. If an interrupt is detected an event will be pushed to the
event interface.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 drivers/iio/light/vcnl4000.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 56d3963d3d66..565b9c9ea470 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -65,6 +65,7 @@
 #define VCNL4200_PS_DATA	0x08 /* Proximity data */
 #define VCNL4200_AL_DATA	0x09 /* Ambient light data */
 #define VCNL4040_INT_FLAGS	0x0b /* Interrupt register */
+#define VCNL4200_INT_FLAGS	0x0d /* Interrupt register */
 #define VCNL4200_DEV_ID		0x0e /* Device ID, slave address and version */
 
 #define VCNL4040_DEV_ID		0x0c /* Device ID and version */
@@ -164,6 +165,7 @@ struct vcnl4000_chip_spec {
 	int (*set_power_state)(struct vcnl4000_data *data, bool on);
 	irqreturn_t (*irq_thread)(int irq, void *priv);
 	irqreturn_t (*trig_buffer_func)(int irq, void *priv);
+	u8 int_reg;
 };
 
 static const struct i2c_device_id vcnl4000_id[] = {
@@ -1005,7 +1007,7 @@ static irqreturn_t vcnl4040_irq_thread(int irq, void *p)
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = i2c_smbus_read_word_data(data->client, VCNL4040_INT_FLAGS);
+	ret = i2c_smbus_read_word_data(data->client, data->chip_spec->int_reg);
 	if (ret < 0)
 		return IRQ_HANDLED;
 
@@ -1314,6 +1316,7 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.num_channels = ARRAY_SIZE(vcnl4040_channels),
 		.info = &vcnl4040_info,
 		.irq_thread = vcnl4040_irq_thread,
+		.int_reg = VCNL4040_INT_FLAGS,
 	},
 	[VCNL4200] = {
 		.prod = "VCNL4200",
@@ -1321,9 +1324,11 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.measure_light = vcnl4200_measure_light,
 		.measure_proximity = vcnl4200_measure_proximity,
 		.set_power_state = vcnl4200_set_power_state,
-		.channels = vcnl4000_channels,
+		.channels = vcnl4040_channels,
 		.num_channels = ARRAY_SIZE(vcnl4000_channels),
-		.info = &vcnl4000_info,
+		.info = &vcnl4040_info,
+		.irq_thread = vcnl4040_irq_thread,
+		.int_reg = VCNL4200_INT_FLAGS,
 	},
 };
 
-- 
2.30.2

