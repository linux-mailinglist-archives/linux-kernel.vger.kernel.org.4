Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031A45ECE43
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiI0USi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiI0UR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:17:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C632611A02;
        Tue, 27 Sep 2022 13:17:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l18so4679781wrw.9;
        Tue, 27 Sep 2022 13:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Fe4GQNVB1A7iFCJKJMseiaTdxx0FAnIQydpGRM+fpi8=;
        b=BSlMaw0ZEOh6wFueEoPzRFbYPReMLXZin82DHQYl7nUbSNv0NA/cRuh7l8RMDYtUG7
         orPv2I8b2b+ZlhXqoWJzhAn+WuDxqFeJZyCz7iTHBrneqFw4u27cJtNj0cXCXd6XUPLx
         +7UQtnAMgPoqf4WHkF+Jm86DdmJo+A6MtjePRgcClSaogljlfwU2LIQLWo/OoM9P219Z
         JGJdhEz1vMk1dniCwmqSXgopX+rSe4APnfiJ8CUrIu+8s933NImPqMRkdYZeIzJ6yNXK
         qnaIhvSzooyV9ZwkL+ss9PZ3b7nLv1Vazrl/6VENJ1YnO4j1IPf24NrTpwDQtUEPakDD
         0hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Fe4GQNVB1A7iFCJKJMseiaTdxx0FAnIQydpGRM+fpi8=;
        b=WnYjsBkdv4R835a85lJ07IHE4uBq5KyIdtYvgNPI0vkii77+t2jelPAixPVHmJXKEE
         xDUqq08vnAOiw+x0yXlwBUyQV0H9lyau7HLC0uCiPH4jjcLkEQcQnsm1SeQfbyJ4lkBg
         0AvdE5Wo0bJJnWxZmjMCxbuN2y8Oo44foqlzwAgzdNuD9XgIbQlB8ZZZ0EA4wM0bSSit
         3FQeNHhz2KP9h3wp+LY1CknNjfmuVkwt02UcErg2fwUvSCC8sZxpgM18bfGuMG7nWbAZ
         qjGhTEB/BAXvgUDtt2ZI7cEpVR/XQlFHLoTcs7oL/aHKWMA+jlCk812clnXIqxtjfz8R
         gY7w==
X-Gm-Message-State: ACrzQf0Q9IcxLP59YZZej91FThbF2v9UbFOMpriRRZ2z2hYyU87BKk5W
        GdYJCSIJZ9Gs6sYObV+Au1NZZ9p62rzRcw==
X-Google-Smtp-Source: AMsMyM6mQvNxv9RYj9Awfl+1STZPbAy1PdTu4TWr/tE7KkwlyKu2nXLm8bN6vPosGPSATzyTK/2Dlw==
X-Received: by 2002:adf:e4cc:0:b0:22a:d755:aaf7 with SMTP id v12-20020adfe4cc000000b0022ad755aaf7mr18190753wrm.692.1664309819209;
        Tue, 27 Sep 2022 13:16:59 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:c6a:3c62:baf6:511c])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c320400b003b4de550e34sm2453162wmp.40.2022.09.27.13.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:16:58 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] media: i2c: ov5645: Use runtime PM
Date:   Tue, 27 Sep 2022 21:16:34 +0100
Message-Id: <20220927201634.750141-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Switch to using runtime PM for power management.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/Kconfig  |   2 +-
 drivers/media/i2c/ov5645.c | 135 +++++++++++++++++++------------------
 2 files changed, 69 insertions(+), 68 deletions(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 7806d4b81716..c0edd1017fe8 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -459,7 +459,7 @@ config VIDEO_OV5640
 config VIDEO_OV5645
 	tristate "OmniVision OV5645 sensor support"
 	depends on OF
-	depends on I2C && VIDEO_DEV
+	depends on I2C && PM && VIDEO_DEV
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 81e4e87e1821..3c3b30338328 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -108,7 +109,6 @@ struct ov5645 {
 	u8 timing_tc_reg21;
 
 	struct mutex power_lock; /* lock to protect power state */
-	int power_count;
 
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *rst_gpio;
@@ -635,8 +635,24 @@ static int ov5645_set_register_array(struct ov5645 *ov5645,
 	return 0;
 }
 
-static int ov5645_set_power_on(struct ov5645 *ov5645)
+static int ov5645_set_power_off(struct device *dev)
 {
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct ov5645 *ov5645 = to_ov5645(sd);
+
+	ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
+	gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
+	gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
+	clk_disable_unprepare(ov5645->xclk);
+	regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
+
+	return 0;
+}
+
+static int ov5645_set_power_on(struct device *dev)
+{
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct ov5645 *ov5645 = to_ov5645(sd);
 	int ret;
 
 	ret = regulator_bulk_enable(OV5645_NUM_SUPPLIES, ov5645->supplies);
@@ -658,57 +674,19 @@ static int ov5645_set_power_on(struct ov5645 *ov5645)
 
 	msleep(20);
 
-	return 0;
-}
-
-static void ov5645_set_power_off(struct ov5645 *ov5645)
-{
-	gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
-	gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
-	clk_disable_unprepare(ov5645->xclk);
-	regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
-}
-
-static int ov5645_s_power(struct v4l2_subdev *sd, int on)
-{
-	struct ov5645 *ov5645 = to_ov5645(sd);
-	int ret = 0;
-
-	mutex_lock(&ov5645->power_lock);
-
-	/* If the power count is modified from 0 to != 0 or from != 0 to 0,
-	 * update the power state.
-	 */
-	if (ov5645->power_count == !on) {
-		if (on) {
-			ret = ov5645_set_power_on(ov5645);
-			if (ret < 0)
-				goto exit;
-
-			ret = ov5645_set_register_array(ov5645,
-					ov5645_global_init_setting,
+	ret = ov5645_set_register_array(ov5645, ov5645_global_init_setting,
 					ARRAY_SIZE(ov5645_global_init_setting));
-			if (ret < 0) {
-				dev_err(ov5645->dev,
-					"could not set init registers\n");
-				ov5645_set_power_off(ov5645);
-				goto exit;
-			}
-
-			usleep_range(500, 1000);
-		} else {
-			ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
-			ov5645_set_power_off(ov5645);
-		}
+	if (ret < 0) {
+		dev_err(ov5645->dev, "could not set init registers\n");
+		goto exit;
 	}
 
-	/* Update the power count. */
-	ov5645->power_count += on ? 1 : -1;
-	WARN_ON(ov5645->power_count < 0);
+	usleep_range(500, 1000);
 
-exit:
-	mutex_unlock(&ov5645->power_lock);
+	return 0;
 
+exit:
+	ov5645_set_power_off(dev);
 	return ret;
 }
 
@@ -795,7 +773,7 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
 	int ret;
 
 	mutex_lock(&ov5645->power_lock);
-	if (!ov5645->power_count) {
+	if (!pm_runtime_get_if_in_use(ov5645->dev)) {
 		mutex_unlock(&ov5645->power_lock);
 		return 0;
 	}
@@ -827,6 +805,7 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
+	pm_runtime_put_autosuspend(ov5645->dev);
 	mutex_unlock(&ov5645->power_lock);
 
 	return ret;
@@ -991,6 +970,10 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 	int ret;
 
 	if (enable) {
+		ret = pm_runtime_resume_and_get(ov5645->dev);
+		if (ret < 0)
+			return ret;
+
 		ret = ov5645_set_register_array(ov5645,
 					ov5645->current_mode->data,
 					ov5645->current_mode->data_size);
@@ -998,22 +981,22 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 			dev_err(ov5645->dev, "could not set mode %dx%d\n",
 				ov5645->current_mode->width,
 				ov5645->current_mode->height);
-			return ret;
+			goto err_rpm_put;
 		}
 		ret = v4l2_ctrl_handler_setup(&ov5645->ctrls);
 		if (ret < 0) {
 			dev_err(ov5645->dev, "could not sync v4l2 controls\n");
-			return ret;
+			goto err_rpm_put;
 		}
 
 		ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x45);
 		if (ret < 0)
-			return ret;
+			goto err_rpm_put;
 
 		ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
 				       OV5645_SYSTEM_CTRL0_START);
 		if (ret < 0)
-			return ret;
+			goto err_rpm_put;
 	} else {
 		ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
 		if (ret < 0)
@@ -1023,14 +1006,15 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 				       OV5645_SYSTEM_CTRL0_STOP);
 		if (ret < 0)
 			return ret;
+		pm_runtime_put(ov5645->dev);
 	}
 
 	return 0;
-}
 
-static const struct v4l2_subdev_core_ops ov5645_core_ops = {
-	.s_power = ov5645_s_power,
-};
+err_rpm_put:
+	pm_runtime_put(ov5645->dev);
+	return ret;
+}
 
 static const struct v4l2_subdev_video_ops ov5645_video_ops = {
 	.s_stream = ov5645_s_stream,
@@ -1046,7 +1030,6 @@ static const struct v4l2_subdev_pad_ops ov5645_subdev_pad_ops = {
 };
 
 static const struct v4l2_subdev_ops ov5645_subdev_ops = {
-	.core = &ov5645_core_ops,
 	.video = &ov5645_video_ops,
 	.pad = &ov5645_subdev_pad_ops,
 };
@@ -1188,11 +1171,9 @@ static int ov5645_probe(struct i2c_client *client)
 		goto free_ctrl;
 	}
 
-	ret = ov5645_s_power(&ov5645->sd, true);
-	if (ret < 0) {
-		dev_err(dev, "could not power up OV5645\n");
+	ret = ov5645_set_power_on(dev);
+	if (ret)
 		goto free_entity;
-	}
 
 	ret = ov5645_read_reg(ov5645, OV5645_CHIP_ID_HIGH, &chip_id_high);
 	if (ret < 0 || chip_id_high != OV5645_CHIP_ID_HIGH_BYTE) {
@@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
 
 	dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
 
+	pm_runtime_set_active(dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
+
 	ret = ov5645_read_reg(ov5645, OV5645_AEC_PK_MANUAL,
 			      &ov5645->aec_pk_manual);
 	if (ret < 0) {
 		dev_err(dev, "could not read AEC/AGC mode\n");
 		ret = -ENODEV;
-		goto power_down;
+		goto err_pm_runtime;
 	}
 
 	ret = ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG20,
@@ -1222,7 +1207,7 @@ static int ov5645_probe(struct i2c_client *client)
 	if (ret < 0) {
 		dev_err(dev, "could not read vflip value\n");
 		ret = -ENODEV;
-		goto power_down;
+		goto err_pm_runtime;
 	}
 
 	ret = ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG21,
@@ -1230,14 +1215,18 @@ static int ov5645_probe(struct i2c_client *client)
 	if (ret < 0) {
 		dev_err(dev, "could not read hflip value\n");
 		ret = -ENODEV;
-		goto power_down;
+		goto err_pm_runtime;
 	}
 
-	ov5645_s_power(&ov5645->sd, false);
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	ret = v4l2_async_register_subdev(&ov5645->sd);
 	if (ret < 0) {
 		dev_err(dev, "could not register v4l2 device\n");
+		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
 		goto free_entity;
 	}
 
@@ -1245,8 +1234,11 @@ static int ov5645_probe(struct i2c_client *client)
 
 	return 0;
 
+err_pm_runtime:
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
 power_down:
-	ov5645_s_power(&ov5645->sd, false);
+	ov5645_set_power_off(dev);
 free_entity:
 	media_entity_cleanup(&ov5645->sd.entity);
 free_ctrl:
@@ -1264,6 +1256,10 @@ static void ov5645_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(&ov5645->sd);
 	media_entity_cleanup(&ov5645->sd.entity);
 	v4l2_ctrl_handler_free(&ov5645->ctrls);
+	pm_runtime_disable(ov5645->dev);
+	if (!pm_runtime_status_suspended(ov5645->dev))
+		ov5645_set_power_off(ov5645->dev);
+	pm_runtime_set_suspended(ov5645->dev);
 	mutex_destroy(&ov5645->power_lock);
 }
 
@@ -1279,10 +1275,15 @@ static const struct of_device_id ov5645_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ov5645_of_match);
 
+static const struct dev_pm_ops ov5645_pm_ops = {
+	SET_RUNTIME_PM_OPS(ov5645_set_power_off, ov5645_set_power_on, NULL)
+};
+
 static struct i2c_driver ov5645_i2c_driver = {
 	.driver = {
 		.of_match_table = ov5645_of_match,
 		.name  = "ov5645",
+		.pm = &ov5645_pm_ops,
 	},
 	.probe_new = ov5645_probe,
 	.remove = ov5645_remove,
-- 
2.25.1

