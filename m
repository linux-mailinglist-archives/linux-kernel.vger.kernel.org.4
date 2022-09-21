Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DF35BFACE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiIUJYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiIUJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:24:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBEBE51
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:24:30 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b75so5324045pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=PTnOVQtMpzZbOk3PtwZjc/TmlJJF/c2LBJSqD167zbg=;
        b=Ho9/5hmMwoeuCRVOtD6iZKcCHuYZ0xOxY+cDQg4Qhiaq4eZ9VollwszCuo+D5IBgp2
         1VFLgfV0tXoNWReqmzdIGLwRYKcoSxJFM2i++shXBBLX1X4p/8aJ48g/xm7JkdCkoda6
         kxZJtPqdBUWHHFPKmB9mkrC1woJa01DZ6RP3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PTnOVQtMpzZbOk3PtwZjc/TmlJJF/c2LBJSqD167zbg=;
        b=FrDWqQrAhuig5q+YD2FojTXxqfsQyKMY39ICtSPwotk/hkbHuyeqCiLy8tmVA8QliG
         zRlPXDaZSwYd0aieRaPs0N4ei8wpUwCJ8W4xWcGWbOEJpa89wnZm+AMPwg4VOOlapkhm
         aIlV8gh7O56nHaooaovNjxLSizCd7fQnMra2eRvshT5IC/7ogXl0Tp8pgG5v+o0YnVSo
         EsTrZiGbvCMW3JQOEFY8BNasEbcc4giiypSsqEu6lbwb/vPpOx/W8yTSF8UcHsZSHQzK
         beqOXQoLcTqirWoeohLCYIlDCBX1L7OtYYxRK08sBTmFj1ncEdbi+6y8uDZc1gGAS/o5
         rlMg==
X-Gm-Message-State: ACrzQf2aTZYOXVbsDVDriUxDrvl2oiJkKVZPrUuHM2qN+jrs3CNgT9Cr
        hm65kciBf+4MmzQPFH0aSmcZGjDKXIme4w==
X-Google-Smtp-Source: AMsMyM7QGAVwzyPxUv6nHj796BKEdItM6huIRquf9ICHuDS2yL35ZL7wHBhVGGyvQ64LFVUIuo6A2Q==
X-Received: by 2002:aa7:97b4:0:b0:547:f861:1fc3 with SMTP id d20-20020aa797b4000000b00547f8611fc3mr27785033pfq.42.1663752270346;
        Wed, 21 Sep 2022 02:24:30 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:cc93:90d7:674f:156a])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001785dddc703sm1487582plb.120.2022.09.21.02.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:24:29 -0700 (PDT)
From:   Hidenori Kobayashi <hidenorik@chromium.org>
To:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Hidenori Kobayashi <hidenorik@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] media: ov8856: Add runtime PM callbacks
Date:   Wed, 21 Sep 2022 18:24:17 +0900
Message-Id: <20220921092417.2579126-1-hidenorik@chromium.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were no runtime PM callbacks registered, leaving regulators being
enabled while the device is suspended on DT systems. Adjust and register
existing power controlling functions to turn them off/on.

Signed-off-by: Hidenori Kobayashi <hidenorik@chromium.org>
---
V2 -> V3: Remove redundant wrappers (were added in V1)
V1 -> V2: Change argument of power controlling functions
---
 drivers/media/i2c/ov8856.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index a9728afc81d4..760611ee5485 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -2110,17 +2110,18 @@ static int ov8856_set_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 }
 
-static int __ov8856_power_on(struct ov8856 *ov8856)
+static int ov8856_power_on(struct device *dev)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct ov8856 *ov8856 = to_ov8856(sd);
 	int ret;
 
-	if (is_acpi_node(dev_fwnode(&client->dev)))
+	if (is_acpi_node(dev_fwnode(dev)))
 		return 0;
 
 	ret = clk_prepare_enable(ov8856->xvclk);
 	if (ret < 0) {
-		dev_err(&client->dev, "failed to enable xvclk\n");
+		dev_err(dev, "failed to enable xvclk\n");
 		return ret;
 	}
 
@@ -2132,7 +2133,7 @@ static int __ov8856_power_on(struct ov8856 *ov8856)
 	ret = regulator_bulk_enable(ARRAY_SIZE(ov8856_supply_names),
 				    ov8856->supplies);
 	if (ret < 0) {
-		dev_err(&client->dev, "failed to enable regulators\n");
+		dev_err(dev, "failed to enable regulators\n");
 		goto disable_clk;
 	}
 
@@ -2148,17 +2149,20 @@ static int __ov8856_power_on(struct ov8856 *ov8856)
 	return ret;
 }
 
-static void __ov8856_power_off(struct ov8856 *ov8856)
+static int ov8856_power_off(struct device *dev)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct ov8856 *ov8856 = to_ov8856(sd);
 
-	if (is_acpi_node(dev_fwnode(&client->dev)))
-		return;
+	if (is_acpi_node(dev_fwnode(dev)))
+		return 0;
 
 	gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(ov8856_supply_names),
 			       ov8856->supplies);
 	clk_disable_unprepare(ov8856->xvclk);
+
+	return 0;
 }
 
 static int __maybe_unused ov8856_suspend(struct device *dev)
@@ -2170,7 +2174,7 @@ static int __maybe_unused ov8856_suspend(struct device *dev)
 	if (ov8856->streaming)
 		ov8856_stop_streaming(ov8856);
 
-	__ov8856_power_off(ov8856);
+	ov8856_power_off(dev);
 	mutex_unlock(&ov8856->mutex);
 
 	return 0;
@@ -2184,7 +2188,7 @@ static int __maybe_unused ov8856_resume(struct device *dev)
 
 	mutex_lock(&ov8856->mutex);
 
-	__ov8856_power_on(ov8856);
+	ov8856_power_on(dev);
 	if (ov8856->streaming) {
 		ret = ov8856_start_streaming(ov8856);
 		if (ret) {
@@ -2451,7 +2455,7 @@ static int ov8856_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	mutex_destroy(&ov8856->mutex);
 
-	__ov8856_power_off(ov8856);
+	ov8856_power_off(&client->dev);
 
 	return 0;
 }
@@ -2477,7 +2481,7 @@ static int ov8856_probe(struct i2c_client *client)
 
 	full_power = acpi_dev_state_d0(&client->dev);
 	if (full_power) {
-		ret = __ov8856_power_on(ov8856);
+		ret = ov8856_power_on(&client->dev);
 		if (ret) {
 			dev_err(&client->dev, "failed to power on\n");
 			return ret;
@@ -2533,13 +2537,14 @@ static int ov8856_probe(struct i2c_client *client)
 	mutex_destroy(&ov8856->mutex);
 
 probe_power_off:
-	__ov8856_power_off(ov8856);
+	ov8856_power_off(&client->dev);
 
 	return ret;
 }
 
 static const struct dev_pm_ops ov8856_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ov8856_suspend, ov8856_resume)
+	SET_RUNTIME_PM_OPS(ov8856_power_off, ov8856_power_on, NULL)
 };
 
 #ifdef CONFIG_ACPI
-- 
2.37.3.968.ga6b4b080e4-goog

