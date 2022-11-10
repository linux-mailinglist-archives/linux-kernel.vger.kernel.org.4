Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C059C62483B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiKJRUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiKJRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:20:49 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABFCF594;
        Thu, 10 Nov 2022 09:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1668100832; bh=Kf0fNlGsDsRSuOjAAsDcc4gChjhmw9Z/lyP6jAa/dFA=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=fajgFlZhaaiXbLn7jT1pv3w2mXklLWRyqmN/a7uwL6sTKPFR1nUih3YozHVx7gxc7
         CePbAwQ6ITgrxFCG/mc1CSOLPgu3k4X1o+eJDA1s3RYvsQvaeLxbwY2JhQL+EWxTI1
         T2JUlGfuHLFswsFU+MsQG6buMnfzLAD6yQ3tKbIA=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Thu, 10 Nov 2022 18:20:31 +0100 (CET)
X-EA-Auth: lcPdtQDwbd5WixXkQaMO8eww4IHjNcYBnAZRusvFKb7KqcKeV38ldXy9DypC7TYRab1ocfB4+uOgl1VWkSVrXkhWvjNPaZhZMTp/gIubwGY=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     w.david0@protonmail.com, stephan@gerhold.net,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 5/5] Input: msg2638 - Add support for msg2138 key events
Date:   Thu, 10 Nov 2022 18:19:48 +0100
Message-Id: <20221110171952.34207-6-vincent.knecht@mailoo.org>
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

Some devices with msg2138 have back/menu/home keys.
Add support for them.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/input/touchscreen/msg2638.c | 53 +++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/msg2638.c b/drivers/input/touchscreen/msg2638.c
index 73e1b4d550fb..36069b30ab9b 100644
--- a/drivers/input/touchscreen/msg2638.c
+++ b/drivers/input/touchscreen/msg2638.c
@@ -29,6 +29,8 @@
 #define MSG2138_MAX_FINGERS		2
 #define MSG2638_MAX_FINGERS		5
 
+#define MAX_BUTTONS			4
+
 #define CHIP_ON_DELAY_MS		15
 #define FIRMWARE_ON_DELAY_MS		50
 #define RESET_DELAY_MIN_US		10000
@@ -72,6 +74,8 @@ struct msg2638_ts_data {
 	struct regulator_bulk_data supplies[2];
 	struct gpio_desc *reset_gpiod;
 	int max_fingers;
+	u32 keycodes[MAX_BUTTONS];
+	int num_keycodes;
 };
 
 static u8 msg2638_checksum(u8 *data, u32 length)
@@ -85,6 +89,19 @@ static u8 msg2638_checksum(u8 *data, u32 length)
 	return (u8)((-sum) & 0xFF);
 }
 
+static void msg2138_report_keys(struct msg2638_ts_data *msg2638, u8 keys)
+{
+	int i;
+
+	/* keys can be 0x00 or 0xff when all keys have been released */
+	if (keys == 0xff)
+		keys = 0;
+
+	for (i = 0; i < msg2638->num_keycodes; ++i)
+		input_report_key(msg2638->input_dev, msg2638->keycodes[i],
+				 !!(keys & BIT(i)));
+}
+
 static irqreturn_t msg2138_ts_irq_handler(int irq, void *msg2638_handler)
 {
 	struct msg2638_ts_data *msg2638 = msg2638_handler;
@@ -121,9 +138,12 @@ static irqreturn_t msg2138_ts_irq_handler(int irq, void *msg2638_handler)
 	p0 = &touch_event.pkt[0];
 	p1 = &touch_event.pkt[1];
 
-	/* Ignore non-pressed finger data */
-	if (p0->xy_hi == 0xFF && p0->x_low == 0xFF && p0->y_low == 0xFF)
+	/* Ignore non-pressed finger data, but check for key code */
+	if (p0->xy_hi == 0xFF && p0->x_low == 0xFF && p0->y_low == 0xFF) {
+		if (p1->xy_hi == 0xFF && p1->y_low == 0xFF)
+			msg2138_report_keys(msg2638, p1->x_low);
 		goto report;
+	}
 
 	x = (((p0->xy_hi & 0xF0) << 4) | p0->x_low);
 	y = (((p0->xy_hi & 0x0F) << 8) | p0->y_low);
@@ -283,6 +303,7 @@ static int msg2638_init_input_dev(struct msg2638_ts_data *msg2638)
 	struct device *dev = &msg2638->client->dev;
 	struct input_dev *input_dev;
 	int error;
+	int i;
 
 	input_dev = devm_input_allocate_device(dev);
 	if (!input_dev) {
@@ -299,6 +320,14 @@ static int msg2638_init_input_dev(struct msg2638_ts_data *msg2638)
 	input_dev->open = msg2638_input_open;
 	input_dev->close = msg2638_input_close;
 
+	if (msg2638->num_keycodes) {
+		input_dev->keycode = msg2638->keycodes;
+		input_dev->keycodemax = msg2638->num_keycodes;
+		input_dev->keycodesize = sizeof(msg2638->keycodes[0]);
+		for (i = 0; i < msg2638->num_keycodes; i++)
+			input_set_capability(input_dev, EV_KEY, msg2638->keycodes[i]);
+	}
+
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
 
@@ -367,10 +396,16 @@ static int msg2638_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = msg2638_init_input_dev(msg2638);
-	if (error) {
-		dev_err(dev, "Failed to initialize input device: %d\n", error);
-		return error;
+	msg2638->num_keycodes =
+		of_property_read_variable_u32_array(dev->of_node, "linux,keycodes",
+						    msg2638->keycodes, 0,
+						    ARRAY_SIZE(msg2638->keycodes));
+	if (msg2638->num_keycodes == -EINVAL) {
+		msg2638->num_keycodes = 0;
+	} else if (msg2638->num_keycodes < 0) {
+		dev_err(dev, "Unable to parse linux,keycodes property: %d\n",
+			msg2638->num_keycodes);
+		return msg2638->num_keycodes;
 	}
 
 	error = devm_request_threaded_irq(dev, client->irq,
@@ -382,6 +417,12 @@ static int msg2638_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
+	error = msg2638_init_input_dev(msg2638);
+	if (error) {
+		dev_err(dev, "Failed to initialize input device: %d\n", error);
+		return error;
+	}
+
 	return 0;
 }
 
-- 
2.38.1



