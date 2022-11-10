Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9A9624832
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiKJRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiKJRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:20:30 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C208A4;
        Thu, 10 Nov 2022 09:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1668100819; bh=BfMnzoCXhU0WRxUZKEPynpBofOMASUhpqpPL7tHyjf8=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=gUmm+U8u9/xOjYhulH+CKNCe7G5zeSobyUD6cytzrQxhiXxoaNTrbnlG32W9rWBwe
         RBPQ7HSU5lAugLiGZvxkeKyHEcj2voNMJqtuOXDWa/OltknKFMEMsQgbgOE4EH9Tmu
         Ft0c8CGcbq5XKl2vOHcnZk85WRSxKgACLCPHf5/A=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Thu, 10 Nov 2022 18:20:19 +0100 (CET)
X-EA-Auth: CEwPyxhJgWkM9+ozqN5+L4Grm/OGTtQepuqi1ltfBBjPhYf2gumhRWVN7pPBc9WZBoZcH/6M7ObfE6KEV3wKJmaV4FL8q8T4X3PxZdX+6YA=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     w.david0@protonmail.com, stephan@gerhold.net,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 3/5] Input: msg2638 - Add support for msg2138
Date:   Thu, 10 Nov 2022 18:19:46 +0100
Message-Id: <20221110171952.34207-4-vincent.knecht@mailoo.org>
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

msg2138 only supports 2 fingers presses, and needs different processing
since second finger press is encoded as a delta position wrt. first one
and the packet/touch_event structs are not the same as msg2638.

Add support for it by implementing distinct structs and irq handler.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/input/touchscreen/msg2638.c | 93 +++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/input/touchscreen/msg2638.c b/drivers/input/touchscreen/msg2638.c
index 222adedf78bf..73e1b4d550fb 100644
--- a/drivers/input/touchscreen/msg2638.c
+++ b/drivers/input/touchscreen/msg2638.c
@@ -26,6 +26,7 @@
 
 #define MODE_DATA_RAW			0x5A
 
+#define MSG2138_MAX_FINGERS		2
 #define MSG2638_MAX_FINGERS		5
 
 #define CHIP_ON_DELAY_MS		15
@@ -38,6 +39,18 @@ struct msg_chip_data {
 	unsigned int max_fingers;
 };
 
+struct msg2138_packet {
+	u8	xy_hi; /* higher bits of x and y coordinates */
+	u8	x_low;
+	u8	y_low;
+};
+
+struct msg2138_touch_event {
+	u8	magic;
+	struct	msg2138_packet pkt[MSG2138_MAX_FINGERS];
+	u8	checksum;
+};
+
 struct msg2638_packet {
 	u8	xy_hi; /* higher bits of x and y coordinates */
 	u8	x_low;
@@ -72,6 +85,80 @@ static u8 msg2638_checksum(u8 *data, u32 length)
 	return (u8)((-sum) & 0xFF);
 }
 
+static irqreturn_t msg2138_ts_irq_handler(int irq, void *msg2638_handler)
+{
+	struct msg2638_ts_data *msg2638 = msg2638_handler;
+	struct i2c_client *client = msg2638->client;
+	struct input_dev *input = msg2638->input_dev;
+	struct msg2138_touch_event touch_event;
+	u32 len = sizeof(touch_event);
+	struct i2c_msg msg[] = {
+		{
+			.addr	= client->addr,
+			.flags	= I2C_M_RD,
+			.len	= sizeof(touch_event),
+			.buf	= (u8 *)&touch_event,
+		},
+	};
+	struct msg2138_packet *p0, *p1;
+	u16 x, y, delta_x, delta_y;
+	int ret;
+
+	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret != ARRAY_SIZE(msg)) {
+		dev_err(&client->dev,
+			"Failed I2C transfer in irq handler: %d\n",
+			ret < 0 ? ret : -EIO);
+		goto out;
+	}
+
+	if (msg2638_checksum((u8 *)&touch_event, len - 1) !=
+						touch_event.checksum) {
+		dev_err(&client->dev, "Failed checksum!\n");
+		goto out;
+	}
+
+	p0 = &touch_event.pkt[0];
+	p1 = &touch_event.pkt[1];
+
+	/* Ignore non-pressed finger data */
+	if (p0->xy_hi == 0xFF && p0->x_low == 0xFF && p0->y_low == 0xFF)
+		goto report;
+
+	x = (((p0->xy_hi & 0xF0) << 4) | p0->x_low);
+	y = (((p0->xy_hi & 0x0F) << 8) | p0->y_low);
+
+	input_mt_slot(input, 0);
+	input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
+	touchscreen_report_pos(input, &msg2638->prop, x, y, true);
+
+	/* Ignore non-pressed finger data */
+	if (p1->xy_hi == 0xFF && p1->x_low == 0xFF && p1->y_low == 0xFF)
+		goto report;
+
+	/* Second finger is reported as a delta position */
+	delta_x = (((p1->xy_hi & 0xF0) << 4) | p1->x_low);
+	delta_y = (((p1->xy_hi & 0x0F) << 8) | p1->y_low);
+
+	/* Ignore second finger if both deltas equal 0 */
+	if (delta_x == 0 && delta_y == 0)
+		goto report;
+
+	x += delta_x;
+	y += delta_y;
+
+	input_mt_slot(input, 1);
+	input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
+	touchscreen_report_pos(input, &msg2638->prop, x, y, true);
+
+report:
+	input_mt_sync_frame(msg2638->input_dev);
+	input_sync(msg2638->input_dev);
+
+out:
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t msg2638_ts_irq_handler(int irq, void *msg2638_handler)
 {
 	struct msg2638_ts_data *msg2638 = msg2638_handler;
@@ -331,12 +418,18 @@ static int __maybe_unused msg2638_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(msg2638_pm_ops, msg2638_suspend, msg2638_resume);
 
+static const struct msg_chip_data msg2138_data = {
+	.irq_handler = msg2138_ts_irq_handler,
+	.max_fingers = MSG2138_MAX_FINGERS,
+};
+
 static const struct msg_chip_data msg2638_data = {
 	.irq_handler = msg2638_ts_irq_handler,
 	.max_fingers = MSG2638_MAX_FINGERS,
 };
 
 static const struct of_device_id msg2638_of_match[] = {
+	{ .compatible = "mstar,msg2138", .data = &msg2138_data },
 	{ .compatible = "mstar,msg2638", .data = &msg2638_data },
 	{ }
 };
-- 
2.38.1



