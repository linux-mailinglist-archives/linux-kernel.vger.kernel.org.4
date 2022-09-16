Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D285BAEAE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIPN53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIPN50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:57:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E192EF3C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:57:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oZBqJ-0002SU-TD; Fri, 16 Sep 2022 15:57:19 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oZBqK-0015yN-Kk; Fri, 16 Sep 2022 15:57:19 +0200
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oZBqI-000bS0-7l; Fri, 16 Sep 2022 15:57:18 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        laurent.pinchart+renesas@ideasonboard.com, akinobu.mita@gmail.com,
        jacopo+renesas@jmondi.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] media: mt9m111: add V4L2_CID_LINK_FREQ support
Date:   Fri, 16 Sep 2022 15:57:11 +0200
Message-Id: <20220916135713.143890-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

Add support to report the link frequency.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
The v1 of this small series can be found here:
https://lore.kernel.org/all/20220818144712.997477-1-m.felsch@pengutronix.de/

Thanks a lot to Jacopo for the review feedback on my v1.

Changelog:

v2:
- use V4L2_CID_LINK_FREQ instead of V4L2_CID_PIXEL_RATE
---
 drivers/media/i2c/mt9m111.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
index afc86efa9e3e..52be1c310455 100644
--- a/drivers/media/i2c/mt9m111.c
+++ b/drivers/media/i2c/mt9m111.c
@@ -1249,6 +1249,8 @@ static int mt9m111_probe(struct i2c_client *client)
 {
 	struct mt9m111 *mt9m111;
 	struct i2c_adapter *adapter = client->adapter;
+	static s64 extclk_rate;
+	struct v4l2_ctrl *ctrl;
 	int ret;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
@@ -1271,6 +1273,13 @@ static int mt9m111_probe(struct i2c_client *client)
 	if (IS_ERR(mt9m111->clk))
 		return PTR_ERR(mt9m111->clk);
 
+	ret = clk_prepare_enable(mt9m111->clk);
+	if (ret < 0)
+		return ret;
+
+	extclk_rate = clk_get_rate(mt9m111->clk);
+	clk_disable_unprepare(mt9m111->clk);
+
 	mt9m111->regulator = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(mt9m111->regulator)) {
 		dev_err(&client->dev, "regulator not found: %ld\n",
@@ -1285,7 +1294,7 @@ static int mt9m111_probe(struct i2c_client *client)
 	mt9m111->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
 				 V4L2_SUBDEV_FL_HAS_EVENTS;
 
-	v4l2_ctrl_handler_init(&mt9m111->hdl, 7);
+	v4l2_ctrl_handler_init(&mt9m111->hdl, 8);
 	v4l2_ctrl_new_std(&mt9m111->hdl, &mt9m111_ctrl_ops,
 			V4L2_CID_VFLIP, 0, 1, 1, 0);
 	v4l2_ctrl_new_std(&mt9m111->hdl, &mt9m111_ctrl_ops,
@@ -1309,6 +1318,16 @@ static int mt9m111_probe(struct i2c_client *client)
 				BIT(V4L2_COLORFX_NEGATIVE) |
 				BIT(V4L2_COLORFX_SOLARIZATION)),
 			V4L2_COLORFX_NONE);
+	/*
+	 * The extclk rate equals the link freq. if reg default values are used,
+	 * which is the case. This must be adapted as soon as we don't use the
+	 * default values anymore.
+	 */
+	ctrl = v4l2_ctrl_new_int_menu(&mt9m111->hdl, &mt9m111_ctrl_ops,
+				      V4L2_CID_LINK_FREQ, 0, 0, &extclk_rate);
+	if (ctrl)
+		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
 	mt9m111->subdev.ctrl_handler = &mt9m111->hdl;
 	if (mt9m111->hdl.error) {
 		ret = mt9m111->hdl.error;
-- 
2.30.2

