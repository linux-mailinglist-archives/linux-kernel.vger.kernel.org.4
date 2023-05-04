Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0303C6F6ACC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjEDMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjEDMDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:03:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15060618E;
        Thu,  4 May 2023 05:03:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f19afc4f60so3014265e9.1;
        Thu, 04 May 2023 05:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683201814; x=1685793814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci2GOyOF6jSU8W/FguKXLUHH+zmeKnpa5iuvTWV/5Jo=;
        b=WOVXvJPOH0oyxdvsQbQaO+yXRSIi11rlfhb1dnB7cRJtIoS7Y+BEdu7M1mST7Vo8vj
         EzTifv9dydrt638b831QaKEo+cHR4uAhqzNfhA3ZD8MVMwv4XufWVH4Tk0G4JnLPbcHO
         U6eIsEsHZHz1BUHWDtW4H+ogX3AbK+ZEY9qlUl270CV2MaupOzKiXTHBs73ljb/hO8HV
         Gn3wCRQHwX3LRYqt+X02H73dEJ5iAUg/WURDvGzekguSkrPj8S0GsrGYEJjruba1VC+H
         P01LE4/waF0bs6zjAEDLsEya1RI0bKGD8WiGO6FoSWjk+vOkfqt/F4X1KmQlIj+sN0dN
         Kv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683201814; x=1685793814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ci2GOyOF6jSU8W/FguKXLUHH+zmeKnpa5iuvTWV/5Jo=;
        b=MMZGZdDRcUI+cVffKJfVxcl6t8xnjArIYSXGXK/6SAZvOA/SViwPQn27sEI2iW6rPq
         8OgRwWjjqxpBZ1Gv/LNJtFe6xSKNorOV8z5mtUeORMOsk2Cv3QV/cPUwaIsHikojlsrT
         2EBYdl22YG2FSWtAL51NRJcrv+YyESb1ho+5AwiaHZku4ACJRebNmGyDJ8dBjB8zHwOk
         4I175ceBmQiZS12acxs+0SjpeXPsPzyF3Fept3WUkLTu45YiqcTkFqkDhMUZBQYU+LZZ
         u6zNBj09e5/iDz1+lFo1n4jASsJ3jRAsbijPUWRVQ/WqTYJukL1x86FTq5/+55Dgk1NH
         whaw==
X-Gm-Message-State: AC+VfDyJyDEcpdf106tPNsUNwlcjevxW9ZxMqOAplVfhhEc+2vmWORUI
        XkDEdHH5D0OcuZPHm8evIbU=
X-Google-Smtp-Source: ACHHUZ4NUHUcqMuIsnV1+epKAIRwdH+vgxpTDzb82ymzLmgqX3mH9dg2WHlmMv4dY5nQxjpDuuM22g==
X-Received: by 2002:a05:6000:190:b0:2fe:c0ea:18b4 with SMTP id p16-20020a056000019000b002fec0ea18b4mr2257460wrx.24.1683201814475;
        Thu, 04 May 2023 05:03:34 -0700 (PDT)
Received: from koko.localdomain (cgn-89-1-213-9.nc.de. [89.1.213.9])
        by smtp.gmail.com with ESMTPSA id a7-20020adfdd07000000b003062db9cc21sm10942632wrm.92.2023.05.04.05.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 05:03:34 -0700 (PDT)
From:   Maximilian Weigand <mweigand2017@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 1/1] Input: cyttsp5 - implement proper sleep and wakeup procedures
Date:   Thu,  4 May 2023 14:03:16 +0200
Message-Id: <20230504120316.408687-2-mweigand2017@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504120316.408687-1-mweigand2017@gmail.com>
References: <20230504120316.408687-1-mweigand2017@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maximilian Weigand <mweigand@mweigand.net>

The touchscreen can be put into a deep sleep state that prevents it from
emitting touch irqs. Put the touchscreen into deep sleep during suspend
if it is not marked as a wakeup source.

This also fixes a problem with the touchscreen getting unresponsive after
system resume when a falling edge trigger is used for the interrupt.
When left on during suspend, the touchscreen would pull the interrupt
line down in response to touch events, leaving the interrupt effectively
disabled after resume.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
Reviewed-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/input/touchscreen/cyttsp5.c | 118 ++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index 30102cb80fac..bdb63eeed59c 100644
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
@@ -557,6 +573,82 @@ static int cyttsp5_hid_output_get_sysinfo(struct cyttsp5 *ts)
 	return cyttsp5_get_sysinfo_regs(ts);
 }

+static int cyttsp5_enter_sleep(struct cyttsp5 *ts)
+{
+	int rc;
+	u8 cmd[2];
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
+	rc = wait_for_completion_interruptible_timeout(&ts->cmd_done,
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
+	rc = wait_for_completion_interruptible_timeout(&ts->cmd_done,
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
+		dev_err(ts->dev, "Validation of the wakeup response failed\n");
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
@@ -675,6 +767,10 @@ static irqreturn_t cyttsp5_handle_irq(int irq, void *handle)
 	case HID_BTN_REPORT_ID:
 		cyttsp5_btn_attention(ts->dev);
 		break;
+	case HID_RESPONSE_REPORT_ID:
+		memcpy(ts->response_buf, ts->input_buf, size);
+		complete(&ts->cmd_done);
+		break;
 	default:
 		/* It is not an input but a command response */
 		memcpy(ts->response_buf, ts->input_buf, size);
@@ -886,10 +982,32 @@ static const struct i2c_device_id cyttsp5_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cyttsp5_i2c_id);

+static int __maybe_unused cyttsp5_suspend(struct device *dev)
+{
+	struct cyttsp5 *ts = dev_get_drvdata(dev);
+
+	if (!device_may_wakeup(dev))
+		cyttsp5_enter_sleep(ts);
+	return 0;
+}
+
+static int __maybe_unused cyttsp5_resume(struct device *dev)
+{
+	struct cyttsp5 *ts = dev_get_drvdata(dev);
+
+	if (!device_may_wakeup(dev))
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
 		.of_match_table = cyttsp5_of_match,
+		.pm     = &cyttsp5_pm,
 	},
 	.probe_new = cyttsp5_i2c_probe,
 	.id_table = cyttsp5_i2c_id,
--
2.39.2

