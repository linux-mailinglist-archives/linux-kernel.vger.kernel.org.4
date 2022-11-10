Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC24E624830
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKJRUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiKJRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:20:26 -0500
X-Greylist: delayed 81179 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 09:20:20 PST
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624F0A4;
        Thu, 10 Nov 2022 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1668100809; bh=vZWdl4U5AIVvqtvaInt8viyZUhV0hsuZo7TtEgTSbBE=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=ky3PU+IRyZfUu/ZeE9r7bSdzq8mBI9fPXo4BXfaoFC80J1zLeA8zQzfS+v0WeZSsA
         KtRLMzN1mkXgxYwUMV6TGZqPk+OloKNco6xpCiRO17jreLqMJUkXhTxOvGaPS+W4Dv
         CzfveUKZAV/CsJ2tWhhu3AijzjwM8AHScTLi4wZo=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Thu, 10 Nov 2022 18:20:09 +0100 (CET)
X-EA-Auth: xuvYD7bLq1ZEZG8yiJC4uzcXUmjumj407oSW8cgqC8cDlnWNOLsGn9ctkKv/TLXhkmKRof840q39uuQJxhX2JhoyOUH6AcG6TPnRm10Yh3k=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     w.david0@protonmail.com, stephan@gerhold.net,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 1/5] Input: msg2638 - Set max finger number and irqhandler from driver data
Date:   Thu, 10 Nov 2022 18:19:44 +0100
Message-Id: <20221110171952.34207-2-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110171952.34207-1-vincent.knecht@mailoo.org>
References: <20221110171952.34207-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow us to add other MStar touchscreen variants' support.
No functional change.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/input/touchscreen/msg2638.c | 40 +++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/msg2638.c b/drivers/input/touchscreen/msg2638.c
index 75536bc88969..222adedf78bf 100644
--- a/drivers/input/touchscreen/msg2638.c
+++ b/drivers/input/touchscreen/msg2638.c
@@ -26,23 +26,28 @@
 
 #define MODE_DATA_RAW			0x5A
 
-#define MAX_SUPPORTED_FINGER_NUM	5
+#define MSG2638_MAX_FINGERS		5
 
 #define CHIP_ON_DELAY_MS		15
 #define FIRMWARE_ON_DELAY_MS		50
 #define RESET_DELAY_MIN_US		10000
 #define RESET_DELAY_MAX_US		11000
 
-struct packet {
+struct msg_chip_data {
+	irq_handler_t irq_handler;
+	unsigned int max_fingers;
+};
+
+struct msg2638_packet {
 	u8	xy_hi; /* higher bits of x and y coordinates */
 	u8	x_low;
 	u8	y_low;
 	u8	pressure;
 };
 
-struct touch_event {
+struct msg2638_touch_event {
 	u8	mode;
-	struct	packet pkt[MAX_SUPPORTED_FINGER_NUM];
+	struct	msg2638_packet pkt[MSG2638_MAX_FINGERS];
 	u8	proximity;
 	u8	checksum;
 };
@@ -53,6 +58,7 @@ struct msg2638_ts_data {
 	struct touchscreen_properties prop;
 	struct regulator_bulk_data supplies[2];
 	struct gpio_desc *reset_gpiod;
+	int max_fingers;
 };
 
 static u8 msg2638_checksum(u8 *data, u32 length)
@@ -71,7 +77,7 @@ static irqreturn_t msg2638_ts_irq_handler(int irq, void *msg2638_handler)
 	struct msg2638_ts_data *msg2638 = msg2638_handler;
 	struct i2c_client *client = msg2638->client;
 	struct input_dev *input = msg2638->input_dev;
-	struct touch_event touch_event;
+	struct msg2638_touch_event touch_event;
 	u32 len = sizeof(touch_event);
 	struct i2c_msg msg[] = {
 		{
@@ -81,7 +87,7 @@ static irqreturn_t msg2638_ts_irq_handler(int irq, void *msg2638_handler)
 			.buf	= (u8 *)&touch_event,
 		},
 	};
-	struct packet *p;
+	struct msg2638_packet *p;
 	u16 x, y;
 	int ret;
 	int i;
@@ -103,7 +109,7 @@ static irqreturn_t msg2638_ts_irq_handler(int irq, void *msg2638_handler)
 		goto out;
 	}
 
-	for (i = 0; i < MAX_SUPPORTED_FINGER_NUM; i++) {
+	for (i = 0; i < msg2638->max_fingers; i++) {
 		p = &touch_event.pkt[i];
 
 		/* Ignore non-pressed finger data */
@@ -215,7 +221,7 @@ static int msg2638_init_input_dev(struct msg2638_ts_data *msg2638)
 		return -EINVAL;
 	}
 
-	error = input_mt_init_slots(input_dev, MAX_SUPPORTED_FINGER_NUM,
+	error = input_mt_init_slots(input_dev, msg2638->max_fingers,
 				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
 	if (error) {
 		dev_err(dev, "Failed to initialize MT slots: %d\n", error);
@@ -233,6 +239,7 @@ static int msg2638_init_input_dev(struct msg2638_ts_data *msg2638)
 
 static int msg2638_ts_probe(struct i2c_client *client)
 {
+	const struct msg_chip_data *chip_data;
 	struct device *dev = &client->dev;
 	struct msg2638_ts_data *msg2638;
 	int error;
@@ -249,6 +256,14 @@ static int msg2638_ts_probe(struct i2c_client *client)
 	msg2638->client = client;
 	i2c_set_clientdata(client, msg2638);
 
+	chip_data = device_get_match_data(&client->dev);
+	if (!chip_data || !chip_data->max_fingers) {
+		dev_err(dev, "Invalid or missing chip data\n");
+		return -EINVAL;
+	}
+
+	msg2638->max_fingers = chip_data->max_fingers;
+
 	msg2638->supplies[0].supply = "vdd";
 	msg2638->supplies[1].supply = "vddio";
 	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(msg2638->supplies),
@@ -272,7 +287,7 @@ static int msg2638_ts_probe(struct i2c_client *client)
 	}
 
 	error = devm_request_threaded_irq(dev, client->irq,
-					  NULL, msg2638_ts_irq_handler,
+					  NULL, chip_data->irq_handler,
 					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					  client->name, msg2638);
 	if (error) {
@@ -316,8 +331,13 @@ static int __maybe_unused msg2638_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(msg2638_pm_ops, msg2638_suspend, msg2638_resume);
 
+static const struct msg_chip_data msg2638_data = {
+	.irq_handler = msg2638_ts_irq_handler,
+	.max_fingers = MSG2638_MAX_FINGERS,
+};
+
 static const struct of_device_id msg2638_of_match[] = {
-	{ .compatible = "mstar,msg2638" },
+	{ .compatible = "mstar,msg2638", .data = &msg2638_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, msg2638_of_match);
-- 
2.38.1



