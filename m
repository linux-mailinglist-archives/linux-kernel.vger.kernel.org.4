Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2E614194
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiJaXWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJaXWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:22:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004BD15819;
        Mon, 31 Oct 2022 16:22:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b20-20020a05600c4e1400b003cc28585e2fso8985693wmq.1;
        Mon, 31 Oct 2022 16:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdWVp8VKApnfegQEOrjaVUnNIwV9nr2tqU0d5pk0pbY=;
        b=aVYZykcQRdCNhljn6y2lG2hREcVaK6h7Y9tlwECutf18hy2Xq5a2QfW1vMzgeV9mKw
         1mTjtFHPy836OtHRKd93eUAE5yKBfocaQETKWEilmEW0yN2DRSGoKx/98blsReyBZxtg
         rhD3xPrM3DYzaX4uxQFuYkFH+XMHsI+11OSuCSbYzvqjvfpbrtJULWjlYJ5YlZkwJQ77
         DkXm1o+8BvuBW0EGeMhh0t3FJhCGFfiF5JB7aGNSBaFB+arnCyCtj1EFtQBuQsEmU3x2
         KelZrDwwaeZc4mxMVuNLprEf/y+G9PDySKogLFJ35fwCs6LI8lvYcXKxiU1MXTuvt5RT
         +zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdWVp8VKApnfegQEOrjaVUnNIwV9nr2tqU0d5pk0pbY=;
        b=V2JLpOpyYD3xuMHxdlSDbeDX652EeyupdhMeTS7gRm8f6Iy3E3n/NomLsneIjjbYqm
         g1bh/edQVI7UvnBHzoc/qZYbKG9W0i2zYN9KrJaD76kRULexPs8xt9kJ/t7pRqG748l7
         xJqVskCEnyX9ppy34dnTNqI2i4HJqsBTDYQY6Rmn++UmLXjhEzX4vTmd4FbOfXZjKJAW
         KLG/Ta30BrDxxrRnggLsl3i8S5NpQGzUsuoTxp+c4kO1OLEJ/B2OmwgOG4xRhDCvZ9Wt
         S+uYYKUOW6hHoAVI5tTcTc0PotTeSckUJZn0KyEr5hJ37wdKJpaAgUVQZb4IzejvVaYa
         FCPA==
X-Gm-Message-State: ACrzQf2vyoRFrVDybxEOolAVmlPhWo5sG5G1absZuYD/A2CWaMjCKE/N
        RRausqT1IJCoCp9AqoRhpgM=
X-Google-Smtp-Source: AMsMyM55AZpk7lKS6zqkZ5m+nxrCYfO5A1HzB5ycOj0l2bC7+SYyD6GBmeVHyjlI4YCVxe8b/oWIkA==
X-Received: by 2002:a05:600c:2150:b0:3cf:6c05:b4ab with SMTP id v16-20020a05600c215000b003cf6c05b4abmr6846876wml.161.1667258534320;
        Mon, 31 Oct 2022 16:22:14 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:15da:d6ab:ec79:436])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003cf7928e731sm2190343wme.9.2022.10.31.16.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:22:13 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 6/9] media: i2c: ov5645: Use runtime PM
Date:   Mon, 31 Oct 2022 23:21:59 +0000
Message-Id: <20221031232202.131945-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3->v4
* Fixed comments pointed by Sakari

v2->v3
* Jumped to err_pm_runtime label in case of sd register failure
* Now calling pm_runtime_mark_last_busy() before pm_runtime_put_autosuspend()
  call
* Now calling pm_runtime_put_sync() in case s_stream(1) fails
* In s_stream(0) no calling pm_runtime_mark_last_busy() and
  pm_runtime_put_autosuspend()
* Included RB tag from Laurent.

v1->v2
* Moved pm_runtime_*_autosuspend() calls after registering the subdev.
---
 drivers/media/i2c/ov5645.c | 133 +++++++++++++++++++------------------
 1 file changed, 68 insertions(+), 65 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 47451238ca05..2e6135d0a31a 100644
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
@@ -827,6 +805,8 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
+	pm_runtime_mark_last_busy(ov5645->dev);
+	pm_runtime_put_autosuspend(ov5645->dev);
 	mutex_unlock(&ov5645->power_lock);
 
 	return ret;
@@ -991,6 +971,10 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 	int ret;
 
 	if (enable) {
+		ret = pm_runtime_resume_and_get(ov5645->dev);
+		if (ret < 0)
+			return ret;
+
 		ret = ov5645_set_register_array(ov5645,
 					ov5645->current_mode->data,
 					ov5645->current_mode->data_size);
@@ -998,22 +982,22 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
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
@@ -1023,14 +1007,17 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 				       OV5645_SYSTEM_CTRL0_STOP);
 		if (ret < 0)
 			return ret;
+
+		pm_runtime_mark_last_busy(ov5645->dev);
+		pm_runtime_put_autosuspend(ov5645->dev);
 	}
 
 	return 0;
-}
 
-static const struct v4l2_subdev_core_ops ov5645_core_ops = {
-	.s_power = ov5645_s_power,
-};
+err_rpm_put:
+	pm_runtime_put_sync(ov5645->dev);
+	return ret;
+}
 
 static const struct v4l2_subdev_video_ops ov5645_video_ops = {
 	.s_stream = ov5645_s_stream,
@@ -1046,7 +1033,6 @@ static const struct v4l2_subdev_pad_ops ov5645_subdev_pad_ops = {
 };
 
 static const struct v4l2_subdev_ops ov5645_subdev_ops = {
-	.core = &ov5645_core_ops,
 	.video = &ov5645_video_ops,
 	.pad = &ov5645_subdev_pad_ops,
 };
@@ -1188,11 +1174,9 @@ static int ov5645_probe(struct i2c_client *client)
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
@@ -1233,20 +1217,30 @@ static int ov5645_probe(struct i2c_client *client)
 		goto power_down;
 	}
 
-	ov5645_s_power(&ov5645->sd, false);
+	pm_runtime_set_active(dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_enable(dev);
 
 	ret = v4l2_async_register_subdev(&ov5645->sd);
 	if (ret < 0) {
 		dev_err(dev, "could not register v4l2 device\n");
-		goto free_entity;
+		goto err_pm_runtime;
 	}
 
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	ov5645_entity_init_cfg(&ov5645->sd, NULL);
 
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
@@ -1264,6 +1258,10 @@ static void ov5645_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(&ov5645->sd);
 	media_entity_cleanup(&ov5645->sd.entity);
 	v4l2_ctrl_handler_free(&ov5645->ctrls);
+	pm_runtime_disable(ov5645->dev);
+	if (!pm_runtime_status_suspended(ov5645->dev))
+		ov5645_set_power_off(ov5645->dev);
+	pm_runtime_set_suspended(ov5645->dev);
 	mutex_destroy(&ov5645->power_lock);
 }
 
@@ -1279,10 +1277,15 @@ static const struct of_device_id ov5645_of_match[] = {
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

