Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6B46A4CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjB0VAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0VAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:00:33 -0500
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 13:00:27 PST
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de [80.67.31.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF82528D;
        Mon, 27 Feb 2023 13:00:27 -0800 (PST)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1pWkSL-0006TA-3S; Mon, 27 Feb 2023 21:50:45 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
To:     Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH 2/2] Input: atmel_mxt_ts - support capacitive keys
Date:   Mon, 27 Feb 2023 21:50:35 +0100
Message-Id: <20230227205035.18551-2-git@apitzsch.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230227205035.18551-1-git@apitzsch.eu>
References: <20230227205035.18551-1-git@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for touch keys found in some Atmel touch controller
configurations.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 85 ++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 996bf434e1cb..eb368dd1abf0 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -55,6 +55,7 @@
 #define MXT_TOUCH_KEYARRAY_T15		15
 #define MXT_TOUCH_PROXIMITY_T23		23
 #define MXT_TOUCH_PROXKEY_T52		52
+#define MXT_TOUCH_PTC_KEYS_T97		97
 #define MXT_PROCI_GRIPFACE_T20		20
 #define MXT_PROCG_NOISE_T22		22
 #define MXT_PROCI_ONETOUCH_T24		24
@@ -326,9 +327,13 @@ struct mxt_data {
 	u16 T71_address;
 	u8 T9_reportid_min;
 	u8 T9_reportid_max;
+	u8 T15_reportid_min;
+	u8 T15_reportid_max;
 	u16 T18_address;
 	u8 T19_reportid;
 	u16 T44_address;
+	u8 T97_reportid_min;
+	u8 T97_reportid_max;
 	u8 T100_reportid_min;
 	u8 T100_reportid_max;
 
@@ -344,6 +349,9 @@ struct mxt_data {
 	u32 *t19_keymap;
 	unsigned int t19_num_keys;
 
+	u32 *t15_keymap;
+	unsigned int t15_num_keys;
+
 	enum mxt_suspend_mode suspend_mode;
 
 	u32 wakeup_method;
@@ -375,6 +383,7 @@ static bool mxt_object_readable(unsigned int type)
 	case MXT_TOUCH_KEYARRAY_T15:
 	case MXT_TOUCH_PROXIMITY_T23:
 	case MXT_TOUCH_PROXKEY_T52:
+	case MXT_TOUCH_PTC_KEYS_T97:
 	case MXT_TOUCH_MULTITOUCHSCREEN_T100:
 	case MXT_PROCI_GRIPFACE_T20:
 	case MXT_PROCG_NOISE_T22:
@@ -891,6 +900,25 @@ static void mxt_proc_t9_message(struct mxt_data *data, u8 *message)
 	data->update_input = true;
 }
 
+static void mxt_proc_t15_messages(struct mxt_data *data, u8 *message)
+{
+	struct input_dev *input_dev = data->input_dev;
+	unsigned long keystates = get_unaligned_le32(&message[2]);
+	int key;
+
+	for (key = 0; key < data->t15_num_keys; key++) {
+		input_report_key(input_dev, data->t15_keymap[key],
+			!!(keystates & BIT(key)));
+	}
+
+	data->update_input = true;
+}
+
+static void mxt_proc_t97_messages(struct mxt_data *data, u8 *message)
+{
+	mxt_proc_t15_messages(data, message);
+}
+
 static void mxt_proc_t100_message(struct mxt_data *data, u8 *message)
 {
 	struct device *dev = &data->client->dev;
@@ -1017,6 +1045,12 @@ static int mxt_proc_message(struct mxt_data *data, u8 *message)
 	} else if (report_id >= data->T9_reportid_min &&
 		   report_id <= data->T9_reportid_max) {
 		mxt_proc_t9_message(data, message);
+	} else if (report_id >= data->T15_reportid_min &&
+		   report_id <= data->T15_reportid_max) {
+		mxt_proc_t15_messages(data, message);
+	} else if (report_id >= data->T97_reportid_min &&
+		   report_id <= data->T97_reportid_max) {
+		mxt_proc_t97_messages(data, message);
 	} else if (report_id >= data->T100_reportid_min &&
 		   report_id <= data->T100_reportid_max) {
 		mxt_proc_t100_message(data, message);
@@ -1689,9 +1723,13 @@ static void mxt_free_object_table(struct mxt_data *data)
 	data->T71_address = 0;
 	data->T9_reportid_min = 0;
 	data->T9_reportid_max = 0;
+	data->T15_reportid_min = 0;
+	data->T15_reportid_max = 0;
 	data->T18_address = 0;
 	data->T19_reportid = 0;
 	data->T44_address = 0;
+	data->T97_reportid_min = 0;
+	data->T97_reportid_max = 0;
 	data->T100_reportid_min = 0;
 	data->T100_reportid_max = 0;
 	data->max_reportid = 0;
@@ -1764,6 +1802,10 @@ static int mxt_parse_object_table(struct mxt_data *data,
 						object->num_report_ids - 1;
 			data->num_touchids = object->num_report_ids;
 			break;
+		case MXT_TOUCH_KEYARRAY_T15:
+			data->T15_reportid_min = min_id;
+			data->T15_reportid_max = max_id;
+			break;
 		case MXT_SPT_COMMSCONFIG_T18:
 			data->T18_address = object->start_address;
 			break;
@@ -1773,6 +1815,10 @@ static int mxt_parse_object_table(struct mxt_data *data,
 		case MXT_SPT_GPIOPWM_T19:
 			data->T19_reportid = min_id;
 			break;
+		case MXT_TOUCH_PTC_KEYS_T97:
+			data->T97_reportid_min = min_id;
+			data->T97_reportid_max = max_id;
+			break;
 		case MXT_TOUCH_MULTITOUCHSCREEN_T100:
 			data->multitouch = MXT_TOUCH_MULTITOUCHSCREEN_T100;
 			data->T100_reportid_min = min_id;
@@ -2050,6 +2096,7 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 	int error;
 	unsigned int num_mt_slots;
 	unsigned int mt_flags = 0;
+	int i;
 
 	switch (data->multitouch) {
 	case MXT_TOUCH_MULTI_T9:
@@ -2095,6 +2142,10 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 	input_dev->open = mxt_input_open;
 	input_dev->close = mxt_input_close;
 
+	input_dev->keycode = data->t15_keymap;
+	input_dev->keycodemax = data->t15_num_keys;
+	input_dev->keycodesize = sizeof(data->t15_keymap[0]);
+
 	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
 
 	/* For single touch */
@@ -2162,6 +2213,12 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 				     0, 255, 0, 0);
 	}
 
+	/* For T15 and T97 Key Array */
+	if (data->T15_reportid_min || data->T97_reportid_min) {
+		for (i = 0; i < data->t15_num_keys; i++)
+			input_set_capability(input_dev, EV_KEY, data->t15_keymap[i]);
+	}
+
 	input_set_drvdata(input_dev, data);
 
 	error = input_register_device(input_dev);
@@ -3080,8 +3137,10 @@ static void mxt_input_close(struct input_dev *dev)
 static int mxt_parse_device_properties(struct mxt_data *data)
 {
 	static const char keymap_property[] = "linux,gpio-keymap";
+	static const char buttons_property[] = "linux,keycodes";
 	struct device *dev = &data->client->dev;
 	u32 *keymap;
+	u32 *buttonmap;
 	int n_keys;
 	int error;
 
@@ -3111,6 +3170,32 @@ static int mxt_parse_device_properties(struct mxt_data *data)
 		data->t19_num_keys = n_keys;
 	}
 
+	if (device_property_present(dev, buttons_property)) {
+		n_keys = device_property_count_u32(dev, buttons_property);
+		if (n_keys <= 0) {
+			error = n_keys < 0 ? n_keys : -EINVAL;
+			dev_err(dev, "invalid/malformed '%s' property: %d\n",
+				buttons_property, error);
+			return error;
+		}
+
+		buttonmap = devm_kmalloc_array(dev, n_keys, sizeof(*buttonmap),
+					       GFP_KERNEL);
+		if (!buttonmap)
+			return -ENOMEM;
+
+		error = device_property_read_u32_array(dev, buttons_property,
+						       buttonmap, n_keys);
+		if (error) {
+			dev_err(dev, "failed to parse '%s' property: %d\n",
+				buttons_property, error);
+			return error;
+		}
+
+		data->t15_keymap = buttonmap;
+		data->t15_num_keys = n_keys;
+	}
+
 	return 0;
 }
 
-- 
2.39.2

