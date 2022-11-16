Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1897362CC71
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiKPVRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKPVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:16:53 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E94C252;
        Wed, 16 Nov 2022 13:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1668633404; bh=6QWf1e37RKMi/NppJ/3MucFfE4jrBDyDhAJ97tQJVK4=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=D4eEUyrFpZ8MwSnUBuBpszXuvGwqgwUz12uFA1lrUPYUHEwYdPMQm+ziOFGzmKum4
         tnTp2hHGarXUr0OrYg/WGHH/kOIzxQzNiIGklD/JSJY7JRhxffGjnAAmSU7kMYuyQ5
         TH8yEbuCAqIbJqhfwDxZzaAINyK5Ga9JjUamTnD0=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Wed, 16 Nov 2022 22:16:44 +0100 (CET)
X-EA-Auth: etheqqxzNFNYrkvcIQ/XJIbcaNqOOYP22hsCy0hlOGv4HajHNvd6SgFJgUhshWnQ4Vl+Z67iBEL0NsVZChOKozKPgNGXUhYLN+wtZs+p9jM=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     w.david0@protonmail.com, stephan@gerhold.net,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v6 2/2] Input: msg2638 - Add support for msg2138 key events
Date:   Wed, 16 Nov 2022 22:16:17 +0100
Message-Id: <20221116211622.2155747-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116211622.2155747-1-vincent.knecht@mailoo.org>
References: <20221116211622.2155747-1-vincent.knecht@mailoo.org>
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
 drivers/input/touchscreen/msg2638.c | 57 +++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/msg2638.c b/drivers/input/touchscreen/msg2638.c
index 95b18563326a..c5f8174e1685 100644
--- a/drivers/input/touchscreen/msg2638.c
+++ b/drivers/input/touchscreen/msg2638.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -29,6 +30,8 @@
 #define MSG2138_MAX_FINGERS		2
 #define MSG2638_MAX_FINGERS		5
 
+#define MAX_BUTTONS			4
+
 #define CHIP_ON_DELAY_MS		15
 #define FIRMWARE_ON_DELAY_MS		50
 #define RESET_DELAY_MIN_US		10000
@@ -72,6 +75,8 @@ struct msg2638_ts_data {
 	struct regulator_bulk_data supplies[2];
 	struct gpio_desc *reset_gpiod;
 	int max_fingers;
+	u32 keycodes[MAX_BUTTONS];
+	int num_keycodes;
 };
 
 static u8 msg2638_checksum(u8 *data, u32 length)
@@ -85,6 +90,18 @@ static u8 msg2638_checksum(u8 *data, u32 length)
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
+		input_report_key(msg2638->input_dev, msg2638->keycodes[i], keys & BIT(i));
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
 
 	x = ((p0->xy_hi & 0xF0) << 4) | p0->x_low;
 	y = ((p0->xy_hi & 0x0F) << 8) | p0->y_low;
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
 
@@ -367,9 +396,23 @@ static int msg2638_ts_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = msg2638_init_input_dev(msg2638);
+	msg2638->num_keycodes = device_property_count_u32(dev, "linux,keycodes");
+	if (msg2638->num_keycodes == -EINVAL) {
+		msg2638->num_keycodes = 0;
+	} else if (msg2638->num_keycodes < 0) {
+		dev_err(dev, "Unable to parse linux,keycodes property: %d\n",
+			msg2638->num_keycodes);
+		return msg2638->num_keycodes;
+	} else if (msg2638->num_keycodes > ARRAY_SIZE(msg2638->keycodes)) {
+		dev_warn(dev, "Found %d linux,keycodes but max is %zd, ignoring the rest\n",
+			 msg2638->num_keycodes, ARRAY_SIZE(msg2638->keycodes));
+		msg2638->num_keycodes = ARRAY_SIZE(msg2638->keycodes);
+	}
+
+	error = device_property_read_u32_array(dev, "linux,keycodes", msg2638->keycodes,
+					       msg2638->num_keycodes);
 	if (error) {
-		dev_err(dev, "Failed to initialize input device: %d\n", error);
+		dev_err(dev, "Unable to read linux,keycodes values: %d\n", error);
 		return error;
 	}
 
@@ -382,6 +425,12 @@ static int msg2638_ts_probe(struct i2c_client *client)
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



