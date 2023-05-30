Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8C7163F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjE3O0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjE3OZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:25:40 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2F410D2;
        Tue, 30 May 2023 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1685456686;
  x=1716992686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zp9g6LGMcrNga0LDQCnxSABwd8l8hW09UrHEcEB+7N8=;
  b=E95LMJ9tVkjQKRrN3edu1tOQs2C11JGynPv2yN7RgKkeBqapSesL7Sab
   K0fAozlGupN7S2Kxf9UlHxqIXSqJe2bre7CzUoZJvEp2Mpx1nAu9KZTJZ
   WU2PfNdSi6e7rTM2WVk4s13KyKp/8bPsy8g9lwCrMTIskMzs8aGbC6ad4
   tCpCY8ejRGfP4G44EX6Ua2aLZ6kXBiQ09FhzZzDllBpKDgnGW+X1rBtb6
   3SQdP4Sns/Ipw8PH7tRjBkNpoE17GOmTug3Gp6NXh+E4tHd8x6sswhGli
   SNcs9H8iDpmAsStayubjLWNhCO+Hh0FukxnhH0xOF7vMjjG5Io0TBoOO2
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v5 1/7] iio: light: vcnl4000: Add proximity irq for vcnl4200
Date:   Tue, 30 May 2023 16:23:59 +0200
Message-ID: <20230530142405.1679146-2-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230530142405.1679146-1-astrid.rost@axis.com>
References: <20230530142405.1679146-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

