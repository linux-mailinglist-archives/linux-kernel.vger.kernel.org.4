Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67905BF8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiIUIRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiIUIQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:16:51 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705A589807
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:16:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d82so5151827pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6u+cAdAmPBAAF5tI7aiYbbN3pu0OppiPxIKSVaZJ6S8=;
        b=JqYH7+lblF122JxcdV3qjDN9ByBOysgHJpmsDYsXNfh3Tzqjyx/MEYS+UsE0a6ck/j
         9oRoNEw2umq8JD/9Q99Jzc6ZSv3Q9w6PGv6GY7VQ7ujXDLzkw8x89xTEvfP49CTVLnnQ
         oAWJPwKd7xXpsb62SKi3EStgpE67vEFUR4Jl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6u+cAdAmPBAAF5tI7aiYbbN3pu0OppiPxIKSVaZJ6S8=;
        b=FNPvF0hfcqy/kIdsrw5M5eZgJ9GNpriMKi/3ePi7fjxPnzDeWSxMVRQwcbNnLL/zxp
         oh9RfgGZkhxHxEdvOu9gmYWoQlkM92uvcSAm0rk7Vl4k+8RfcSIxq2WFtVKwXSu7Vm/Z
         uOGGXIkYpEqjd0w4rgbRNhw/mQLu31TXO5TmeDXrlD/4CXJGcZYNMMDA3n7Lf7sMFjGK
         4cE3GzRm5wmcvS/WfSThMDh4tSalwBH71tbD2DKonJ+wtzl+yY+PnNii6wgh5f+a9C3Y
         nK5KHRgDzimfUvVZeLqgk5WoTQiuyB85yQT03ATii8+nFtbCEqFoX2bifKPnRUUGy7E6
         smTg==
X-Gm-Message-State: ACrzQf2YgzcupDLuHb7C4kYAkJMfd4G18z0+VkZNtT97FxLxnzbZx361
        Nq/iYWr/n207o/eUGcx0mpaa/w==
X-Google-Smtp-Source: AMsMyM62PWSeVI9Kiu2yThPrMA0ISbBCb1FjSmZDPuYnW72WVKmQZzzFhmrfFDcsSWfQ4+CdZ/pGlg==
X-Received: by 2002:a63:d915:0:b0:43a:20d5:9112 with SMTP id r21-20020a63d915000000b0043a20d59112mr12037014pgg.460.1663748165672;
        Wed, 21 Sep 2022 01:16:05 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:cc93:90d7:674f:156a])
        by smtp.gmail.com with ESMTPSA id c79-20020a624e52000000b00553b37c7736sm450763pfb.25.2022.09.21.01.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:16:05 -0700 (PDT)
From:   Hidenori Kobayashi <hidenorik@chromium.org>
To:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Hidenori Kobayashi <hidenorik@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: ov8856: Add runtime PM callbacks
Date:   Wed, 21 Sep 2022 17:15:35 +0900
Message-Id: <20220921081536.2551789-1-hidenorik@chromium.org>
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
enabled while the device is suspended on DT systems. Add callbacks that
call existing power controlling functions to turn them off/on.

To simplify the code with this addition, change the argument of the
power controlling functions.

Signed-off-by: Hidenori Kobayashi <hidenorik@chromium.org>
---
V1 -> V2: Change argument of power controlling functions
---
 drivers/media/i2c/ov8856.c | 41 ++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index a9728afc81d4..188699455fdf 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -2110,17 +2110,18 @@ static int ov8856_set_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 }
 
-static int __ov8856_power_on(struct ov8856 *ov8856)
+static int __ov8856_power_on(struct device *dev)
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
 
@@ -2148,11 +2149,12 @@ static int __ov8856_power_on(struct ov8856 *ov8856)
 	return ret;
 }
 
-static void __ov8856_power_off(struct ov8856 *ov8856)
+static void __ov8856_power_off(struct device *dev)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
+	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct ov8856 *ov8856 = to_ov8856(sd);
 
-	if (is_acpi_node(dev_fwnode(&client->dev)))
+	if (is_acpi_node(dev_fwnode(dev)))
 		return;
 
 	gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
@@ -2170,7 +2172,7 @@ static int __maybe_unused ov8856_suspend(struct device *dev)
 	if (ov8856->streaming)
 		ov8856_stop_streaming(ov8856);
 
-	__ov8856_power_off(ov8856);
+	__ov8856_power_off(dev);
 	mutex_unlock(&ov8856->mutex);
 
 	return 0;
@@ -2184,7 +2186,7 @@ static int __maybe_unused ov8856_resume(struct device *dev)
 
 	mutex_lock(&ov8856->mutex);
 
-	__ov8856_power_on(ov8856);
+	__ov8856_power_on(dev);
 	if (ov8856->streaming) {
 		ret = ov8856_start_streaming(ov8856);
 		if (ret) {
@@ -2200,6 +2202,18 @@ static int __maybe_unused ov8856_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused ov8856_runtime_suspend(struct device *dev)
+{
+	__ov8856_power_off(dev);
+
+	return 0;
+}
+
+static int __maybe_unused ov8856_runtime_resume(struct device *dev)
+{
+	return __ov8856_power_on(dev);
+}
+
 static int ov8856_set_format(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_state *sd_state,
 			     struct v4l2_subdev_format *fmt)
@@ -2451,7 +2465,7 @@ static int ov8856_remove(struct i2c_client *client)
 	pm_runtime_disable(&client->dev);
 	mutex_destroy(&ov8856->mutex);
 
-	__ov8856_power_off(ov8856);
+	__ov8856_power_off(&client->dev);
 
 	return 0;
 }
@@ -2477,7 +2491,7 @@ static int ov8856_probe(struct i2c_client *client)
 
 	full_power = acpi_dev_state_d0(&client->dev);
 	if (full_power) {
-		ret = __ov8856_power_on(ov8856);
+		ret = __ov8856_power_on(&client->dev);
 		if (ret) {
 			dev_err(&client->dev, "failed to power on\n");
 			return ret;
@@ -2533,13 +2547,14 @@ static int ov8856_probe(struct i2c_client *client)
 	mutex_destroy(&ov8856->mutex);
 
 probe_power_off:
-	__ov8856_power_off(ov8856);
+	__ov8856_power_off(&client->dev);
 
 	return ret;
 }
 
 static const struct dev_pm_ops ov8856_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ov8856_suspend, ov8856_resume)
+	SET_RUNTIME_PM_OPS(ov8856_runtime_suspend, ov8856_runtime_resume, NULL)
 };
 
 #ifdef CONFIG_ACPI
-- 
2.37.3.968.ga6b4b080e4-goog

