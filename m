Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3295BAEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiIPN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIPN50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:57:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323A3AB1A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:57:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oZBqJ-0002ST-Qg; Fri, 16 Sep 2022 15:57:19 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oZBqK-0015yK-Bt; Fri, 16 Sep 2022 15:57:18 +0200
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oZBqI-000bS5-9I; Fri, 16 Sep 2022 15:57:18 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        laurent.pinchart+renesas@ideasonboard.com, akinobu.mita@gmail.com,
        jacopo+renesas@jmondi.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] media: mt9m111: don't turn on the output while powering it
Date:   Fri, 16 Sep 2022 15:57:13 +0200
Message-Id: <20220916135713.143890-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220916135713.143890-1-m.felsch@pengutronix.de>
References: <20220916135713.143890-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the .s_power() turn on/off the device and enables/disables the
sensor output. This is wrong since it should only handle the power not
not the sensor output behaviour. Enabling the sensor output should be
part of the .s_stream() callback.

Fix this by adding mt9m111_set_output() which gets called by the
.s_stream() callback and remove the output register bits from
mt9m111_resume/suspend.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog:

v2:
- new patch, replaces: "media: mt9m111: remove .s_power callback"
---
 drivers/media/i2c/mt9m111.c | 38 ++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
index 8de93ab99cbc..2cc0b0da7636 100644
--- a/drivers/media/i2c/mt9m111.c
+++ b/drivers/media/i2c/mt9m111.c
@@ -426,10 +426,25 @@ static int mt9m111_setup_geometry(struct mt9m111 *mt9m111, struct v4l2_rect *rec
 	return ret;
 }
 
-static int mt9m111_enable(struct mt9m111 *mt9m111)
+static int mt9m111_set_output(struct mt9m111 *mt9m111, int on)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&mt9m111->subdev);
-	return reg_write(RESET, MT9M111_RESET_CHIP_ENABLE);
+	int ret;
+
+	if (on) {
+		ret = reg_clear(RESET, MT9M111_RESET_OUTPUT_DISABLE);
+		if (ret)
+			return ret;
+
+		return reg_set(RESET, MT9M111_RESET_CHIP_ENABLE);
+	}
+
+	/* disable */
+	ret = reg_set(RESET, MT9M111_RESET_OUTPUT_DISABLE);
+	if (ret)
+		return ret;
+
+	return reg_clear(RESET, MT9M111_RESET_CHIP_ENABLE);
 }
 
 static int mt9m111_reset(struct mt9m111 *mt9m111)
@@ -927,10 +942,7 @@ static int mt9m111_suspend(struct mt9m111 *mt9m111)
 	ret = reg_set(RESET, MT9M111_RESET_RESET_MODE);
 	if (!ret)
 		ret = reg_set(RESET, MT9M111_RESET_RESET_SOC |
-			      MT9M111_RESET_OUTPUT_DISABLE |
 			      MT9M111_RESET_ANALOG_STANDBY);
-	if (!ret)
-		ret = reg_clear(RESET, MT9M111_RESET_CHIP_ENABLE);
 
 	return ret;
 }
@@ -951,9 +963,9 @@ static void mt9m111_restore_state(struct mt9m111 *mt9m111)
 
 static int mt9m111_resume(struct mt9m111 *mt9m111)
 {
-	int ret = mt9m111_enable(mt9m111);
-	if (!ret)
-		ret = mt9m111_reset(mt9m111);
+	int ret;
+
+	ret = mt9m111_reset(mt9m111);
 	if (!ret)
 		mt9m111_restore_state(mt9m111);
 
@@ -965,9 +977,7 @@ static int mt9m111_init(struct mt9m111 *mt9m111)
 	struct i2c_client *client = v4l2_get_subdevdata(&mt9m111->subdev);
 	int ret;
 
-	ret = mt9m111_enable(mt9m111);
-	if (!ret)
-		ret = mt9m111_reset(mt9m111);
+	ret = mt9m111_reset(mt9m111);
 	if (!ret)
 		ret = mt9m111_set_context(mt9m111, mt9m111->ctx);
 	if (ret)
@@ -1116,8 +1126,14 @@ static int mt9m111_enum_mbus_code(struct v4l2_subdev *sd,
 static int mt9m111_s_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct mt9m111 *mt9m111 = container_of(sd, struct mt9m111, subdev);
+	int ret;
+
+	ret = mt9m111_set_output(mt9m111, enable);
+	if (ret)
+		return ret;
 
 	mt9m111->is_streaming = !!enable;
+
 	return 0;
 }
 
-- 
2.30.2

