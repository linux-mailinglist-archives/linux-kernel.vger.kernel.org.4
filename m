Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2707D6C6A04
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjCWNxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjCWNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:52:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FB428E63;
        Thu, 23 Mar 2023 06:52:52 -0700 (PDT)
Received: from koko.localdomain ([89.1.213.94]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mof1D-1qHA1O1nWz-00p4pQ; Thu, 23 Mar 2023 14:52:47 +0100
From:   Maximilian Weigand <mweigand@mweigand.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 6/6] Input: cyttsp5: implement proper sleep and wakeup procedures
Date:   Thu, 23 Mar 2023 14:52:05 +0100
Message-Id: <20230323135205.1160879-7-mweigand@mweigand.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323135205.1160879-1-mweigand@mweigand.net>
References: <20230323135205.1160879-1-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zzLyeqflRm7UGravOHiW9xcOiaMBdEHtUyUJZy+G19EFiSvwZEy
 bB1uFk0Icuov9zFJw5z94J7ZfVW46ZVUEh2+9+1PwidmBZu2lsEzBiXsECNj43pGOJoR/14
 l6beIwi8usfnUL0JTV5KAP1rCOoJtFJu7WXVLgZgnlhcYtlRz0SMWIXOUxWBGT387o4bSAb
 S0CBmfK1ip2o7cuE13Ivg==
UI-OutboundReport: notjunk:1;M01:P0:dbSg3Nw2nDA=;psUiAgzFxzslLiHCkMxlFn64goY
 wlu+imSNWjE1s6slWUg6OJns53Pe8gnVrUdYlaIHM/a6+q1xoSNcb/Zg0MGsvvGjDAN/Ps2Vt
 XNVmglUZeusYMtIZZyRviCz21ZyfKSQwU4SChKboc0yqTW1SiUkK3a+KXbSheaDn7KUcIsDry
 NomUVJsDZgWmHu03+IF9HoYKpNnvXeX7e6h7jn04ihq4twrKm075QBwfVeD+Txgo3Sews9YN1
 gtvLdwgKImv5AL9xx3PDJZq4zHlZA9cM96aZgWJoM0oqeK1kvieEAgvs6VVFHn4x6hP/mHMhg
 KUGEMGU/ru4Fj25l5ktJVLqBKOEjhknOSkES7Il46ctAOGfRJBUY1UyL8O9xQzpE43qVMfKc6
 j/ynA9I8ulQjbWs8W/AoGVT94WsuMBAzY2YST3XJyU/9hR68UDUkIaMmQaazlO0//fO9a8Slp
 8w6n9fwPDvFFGOHF32WJuq6m09sRukTk2EkrFDmny6kVg/FSOH21AjikQRTdzw+5h1ktpALzz
 Tj7gQqBwOjFL2GkE9q7Yh7M8H6lDKU7MYmstQkNYBVsMeOVe0cY9SrmmbqO690DxyRethv1iY
 d8ou9y/kcN30787xFt9rBQMtvqe6TYkH0JOvUs9POsLhgHBU+2Ll6rwYrbHWyztna/EqoHdBm
 hqSXjZy1keh61fCDM4V9+zeDfaAfD/MQsmZuY/CjPQ==
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The touchscreen can be put into a deep sleep state that prevents it from
emitting touch irqs. Put the touchscreen into deep sleep during suspend
if it is not marked as a wakeup source.

This also fixes a problem with the touchscreen getting unresponsive after
system resume because it pulled the interrupt line low during sleep in
response to a touch event, thereby effectively disabling the interrupt
handling (which triggers on the falling edge).

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/input/touchscreen/cyttsp5.c | 129 +++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 01dd10a596ab..3e8387f6347c 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -43,6 +43,7 @@
 #define HID_DESC_REG				0x1
 #define HID_INPUT_REG				0x3
 #define HID_OUTPUT_REG				0x4
+#define HID_COMMAND_REG             0x5
 
 #define REPORT_ID_TOUCH				0x1
 #define REPORT_ID_BTN				0x3
@@ -68,6 +69,7 @@
 #define HID_APP_OUTPUT_REPORT_ID		0x2F
 #define HID_BL_RESPONSE_REPORT_ID		0x30
 #define HID_BL_OUTPUT_REPORT_ID			0x40
+#define HID_RESPONSE_REPORT_ID      0xF0
 
 #define HID_OUTPUT_RESPONSE_REPORT_OFFSET	2
 #define HID_OUTPUT_RESPONSE_CMD_OFFSET		4
@@ -78,9 +80,15 @@
 #define HID_SYSINFO_BTN_MASK			GENMASK(7, 0)
 #define HID_SYSINFO_MAX_BTN			8
 
+#define HID_CMD_SET_POWER           0x8
+
+#define HID_POWER_ON                0x0
+#define HID_POWER_SLEEP             0x1
+
 #define CY_HID_OUTPUT_TIMEOUT_MS		200
 #define CY_HID_OUTPUT_GET_SYSINFO_TIMEOUT_MS	3000
 #define CY_HID_GET_HID_DESCRIPTOR_TIMEOUT_MS	4000
+#define CY_HID_SET_POWER_TIMEOUT		500
 
 /* maximum number of concurrent tracks */
 #define TOUCH_REPORT_SIZE			10
@@ -100,6 +108,14 @@
 #define TOUCH_REPORT_USAGE_PG_MIN		0xFF010063
 #define TOUCH_COL_USAGE_PG			0x000D0022
 
+#define SET_CMD_LOW(byte, bits) \
+	((byte) = (((byte) & 0xF0) | ((bits) & 0x0F)))
+#define SET_CMD_HIGH(byte, bits)\
+	((byte) = (((byte) & 0x0F) | ((bits) & 0xF0)))
+#define SET_CMD_OPCODE(byte, opcode) SET_CMD_LOW(byte, opcode)
+#define SET_CMD_REPORT_TYPE(byte, type) SET_CMD_HIGH(byte, ((type) << 4))
+#define SET_CMD_REPORT_ID(byte, id) SET_CMD_LOW(byte, id)
+
 /* System Information interface definitions */
 struct cyttsp5_sensing_conf_data_dev {
 	u8 electrodes_x;
@@ -179,6 +195,7 @@ struct cyttsp5_hid_desc {
 struct cyttsp5 {
 	struct device *dev;
 	struct completion cmd_done;
+	struct completion cmd_command_done;
 	struct cyttsp5_sysinfo sysinfo;
 	struct cyttsp5_hid_desc hid_desc;
 	u8 cmd_buf[CYTTSP5_PREALLOCATED_CMD_BUFFER];
@@ -191,6 +208,7 @@ struct cyttsp5 {
 	struct regmap *regmap;
 	struct touchscreen_properties prop;
 	struct regulator *vdd;
+	bool is_wakeup_source;
 };
 
 /*
@@ -556,6 +574,84 @@ static int cyttsp5_hid_output_get_sysinfo(struct cyttsp5 *ts)
 	return cyttsp5_get_sysinfo_regs(ts);
 }
 
+static int cyttsp5_enter_sleep(struct cyttsp5 *ts)
+{
+	int rc;
+	u8 cmd[2];
+	u16 crc;
+
+	memset(cmd, 0, sizeof(cmd));
+
+	SET_CMD_REPORT_TYPE(cmd[0], 0);
+	SET_CMD_REPORT_ID(cmd[0], HID_POWER_SLEEP);
+	SET_CMD_OPCODE(cmd[1], HID_CMD_SET_POWER);
+
+	rc = cyttsp5_write(ts, HID_COMMAND_REG, cmd, 2);
+	if (rc) {
+		dev_err(ts->dev, "Failed to write command %d", rc);
+		return rc;
+	}
+
+	rc = wait_for_completion_interruptible_timeout(&ts->cmd_command_done,
+				msecs_to_jiffies(CY_HID_SET_POWER_TIMEOUT));
+	if (rc <= 0) {
+		dev_err(ts->dev, "HID output cmd execution timed out\n");
+		rc = -ETIMEDOUT;
+		return rc;
+	}
+
+	/* validate */
+	if ((ts->response_buf[2] != HID_RESPONSE_REPORT_ID)
+			|| ((ts->response_buf[3] & 0x3) != HID_POWER_SLEEP)
+			|| ((ts->response_buf[4] & 0xF) != HID_CMD_SET_POWER)) {
+		rc = -EINVAL;
+		dev_err(ts->dev, "Validation of the sleep response failed\n");
+		return rc;
+	}
+
+	return 0;
+
+}
+
+static int cyttsp5_wakeup(struct cyttsp5 *ts)
+{
+	int rc;
+	u8 cmd[2];
+	u16 crc;
+
+	memset(cmd, 0, sizeof(cmd));
+
+	SET_CMD_REPORT_TYPE(cmd[0], 0);
+	SET_CMD_REPORT_ID(cmd[0], HID_POWER_ON);
+	SET_CMD_OPCODE(cmd[1], HID_CMD_SET_POWER);
+
+	rc = cyttsp5_write(ts, HID_COMMAND_REG, cmd, 2);
+	if (rc) {
+		dev_err(ts->dev, "Failed to write command %d", rc);
+		return rc;
+	}
+
+	rc = wait_for_completion_interruptible_timeout(&ts->cmd_command_done,
+				msecs_to_jiffies(CY_HID_SET_POWER_TIMEOUT));
+	if (rc <= 0) {
+		dev_err(ts->dev, "HID output cmd execution timed out\n");
+		rc = -ETIMEDOUT;
+		return rc;
+	}
+
+	/* validate */
+	if ((ts->response_buf[2] != HID_RESPONSE_REPORT_ID)
+			|| ((ts->response_buf[3] & 0x3) != HID_POWER_ON)
+			|| ((ts->response_buf[4] & 0xF) != HID_CMD_SET_POWER)) {
+		rc = -EINVAL;
+		dev_err(ts->dev, "Validation of the sleep response failed\n");
+		return rc;
+	}
+
+	return 0;
+
+}
+
 static int cyttsp5_hid_output_bl_launch_app(struct cyttsp5 *ts)
 {
 	int rc;
@@ -670,6 +766,10 @@ static irqreturn_t cyttsp5_handle_irq(int irq, void *handle)
 	case HID_BTN_REPORT_ID:
 		cyttsp5_btn_attention(ts->dev);
 		break;
+	case HID_RESPONSE_REPORT_ID:
+		memcpy(ts->response_buf, ts->input_buf, size);
+		complete(&ts->cmd_command_done);
+		break;
 	default:
 		/* It is not an input but a command response */
 		memcpy(ts->response_buf, ts->input_buf, size);
@@ -784,6 +884,7 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 	dev_set_drvdata(dev, ts);
 
 	init_completion(&ts->cmd_done);
+	init_completion(&ts->cmd_command_done);
 
 	/* Power up the device */
 	ts->vdd = devm_regulator_get(dev, "vdd");
@@ -830,8 +931,11 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 		return error;
 	}
 
-	if (device_property_read_bool(dev, "wakeup-source"))
+	if (device_property_read_bool(dev, "wakeup-source")) {
 		device_init_wakeup(dev, true);
+		ts->is_wakeup_source = true;
+	} else
+		ts->is_wakeup_source = false;
 
 	error = cyttsp5_startup(ts);
 	if (error) {
@@ -884,6 +988,29 @@ static const struct i2c_device_id cyttsp5_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cyttsp5_i2c_id);
 
+static int __maybe_unused cyttsp5_suspend(struct device *dev)
+{
+	struct cyttsp5 *ts = dev_get_drvdata(dev);
+
+	if (!ts->is_wakeup_source)
+		cyttsp5_enter_sleep(ts);
+	return 0;
+}
+
+static int __maybe_unused cyttsp5_resume(struct device *dev)
+{
+	struct cyttsp5 *ts = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	int error;
+
+	if (!ts->is_wakeup_source)
+		cyttsp5_wakeup(ts);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(cyttsp5_pm, cyttsp5_suspend, cyttsp5_resume);
+
 static struct i2c_driver cyttsp5_i2c_driver = {
 	.driver = {
 		.name = CYTTSP5_NAME,
-- 
2.39.2

