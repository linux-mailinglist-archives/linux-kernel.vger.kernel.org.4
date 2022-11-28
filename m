Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4E163B284
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiK1Ttw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiK1Ttu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:49:50 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183A5FD8;
        Mon, 28 Nov 2022 11:49:49 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jn7so11208467plb.13;
        Mon, 28 Nov 2022 11:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6ZdZht5PmMc/aFtM8sYCOtZ7g120QGJF2Q+IqUbnJ0=;
        b=F6XfcMkHRj2nBR/wBV3AIZczYExMopppLupaNrO+32637r5aL2LeepzwDMsS/vZr3l
         8Ygu1Kb55cNsIGhHPmLf9cyBUZTdoKebkKd6suFTtx9FXt4LTOXFmhBy0iKhqC+w47V7
         zkhx8z41kAglWoBVTnnrqwMQZS5gj7qK0g+PNOePrB38Zm+eX0XuH0boQBTONOFrc6mg
         kszX/cuOCRIZCMvebgYvbFgmSTVa9TR41/6nRKYyMXcXcz03Inx/kdHbKZj8lXkS9HvS
         pUR+wIDRUypCe9cjEScVPFbaVKuhZh9kUTpumD2gefPhmecuxqFhPIN0KHWzQqAXvt90
         NZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6ZdZht5PmMc/aFtM8sYCOtZ7g120QGJF2Q+IqUbnJ0=;
        b=VcYccekEUGqy6rfi4yJwVOcA/gGzGssTxmLrVDjN3l8e/MpVmi/u4h0qFC1yxCpSL0
         /2Pf8GWNGyXvqhP5TGLe9pM57oJwk7c75dzY7hBYc/TopAfim9CQc/5AcYt03FCi2bpR
         6jxUCX9v/Ak0IYRFUgwtP72CHPFn8M+EoJT4WJp86g0nN9c4xsD4CEtR72vgkS45RrEq
         vc8UBJp9y/MBE5phKAJ8N338o3IviTi9kvOWQZ3eBsdA5a5Qsw0hsWznUygVdSWlA6sc
         mqmwniPP2El0011F5aIw9Q5Nt1EPmNa5ZZwy7n6QnE+xND4XssevgCDgtcNW9ATa++Cu
         i+6A==
X-Gm-Message-State: ANoB5pkrbIg6sm1Rdh6pPFH2n/weVVqF+3Xs/S1QVxhHhzvVymNdfPtI
        0Kzntq/C57//0+bQ9Ibupqg=
X-Google-Smtp-Source: AA0mqf4VrzzW8mg/hdY5d362uG8zAawbYCjoYxGgYvm3P6K21XFGTTpBFizT73C1EXbAG3oDsANT8w==
X-Received: by 2002:a17:90b:394a:b0:210:4438:2d40 with SMTP id oe10-20020a17090b394a00b0021044382d40mr7559564pjb.196.1669664988707;
        Mon, 28 Nov 2022 11:49:48 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fd7c:c075:f9ff:46c4])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001886ff82680sm9251979plh.127.2022.11.28.11.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:49:48 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:49:45 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2] media: i2c: s5c73m3: remove support for platform data
Message-ID: <Y4UQ2Wg/PcgfM84+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no existing users of s5c73m3_platform_data in the tree, and
new users should either be using device tree, ACPI, or static device
properties, so let's remove it from the driver.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: rebased on top of Linus' patch converting the driver to GPIOD API
    as requested by Hans
    https://patchwork.linuxtv.org/project/linux-media/patch/20221108100604.1500909-1-linus.walleij@linaro.org/

 drivers/media/i2c/s5c73m3/s5c73m3-core.c  | 20 +++--------
 drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c |  1 -
 drivers/media/i2c/s5c73m3/s5c73m3.h       |  1 -
 include/media/i2c/s5c73m3.h               | 41 -----------------------
 4 files changed, 5 insertions(+), 58 deletions(-)

diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
index 59b03b0860d5..318a4ec2d8a5 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
@@ -26,7 +26,6 @@
 #include <media/v4l2-device.h>
 #include <media/v4l2-subdev.h>
 #include <media/v4l2-mediabus.h>
-#include <media/i2c/s5c73m3.h>
 #include <media/v4l2-fwnode.h>
 
 #include "s5c73m3.h"
@@ -1522,25 +1521,16 @@ static const struct v4l2_subdev_ops oif_subdev_ops = {
 	.video	= &s5c73m3_oif_video_ops,
 };
 
-static int s5c73m3_get_platform_data(struct s5c73m3 *state)
+static int s5c73m3_get_dt_data(struct s5c73m3 *state)
 {
-	struct i2c_client *c = state->i2c_client;
-	struct device *dev = &c->dev;
-	const struct s5c73m3_platform_data *pdata = dev->platform_data;
+	struct device *dev = &state->i2c_client->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *node_ep;
 	struct v4l2_fwnode_endpoint ep = { .bus_type = 0 };
 	int ret;
 
-	if (!node) {
-		if (!pdata) {
-			dev_err(dev, "Platform data not specified\n");
-			return -EINVAL;
-		}
-
-		state->mclk_frequency = pdata->mclk_frequency;
-		return 0;
-	}
+	if (!node)
+		return -EINVAL;
 
 	state->clock = devm_clk_get(dev, S5C73M3_CLK_NAME);
 	if (IS_ERR(state->clock))
@@ -1603,7 +1593,7 @@ static int s5c73m3_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	state->i2c_client = client;
-	ret = s5c73m3_get_platform_data(state);
+	ret = s5c73m3_get_dt_data(state);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c b/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
index e3543ae384ed..1c8103670fa2 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c
@@ -23,7 +23,6 @@
 #include <media/v4l2-device.h>
 #include <media/v4l2-subdev.h>
 #include <media/v4l2-mediabus.h>
-#include <media/i2c/s5c73m3.h>
 
 #include "s5c73m3.h"
 
diff --git a/drivers/media/i2c/s5c73m3/s5c73m3.h b/drivers/media/i2c/s5c73m3/s5c73m3.h
index 1fc7df41c5ee..627e80cf5b72 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3.h
+++ b/drivers/media/i2c/s5c73m3/s5c73m3.h
@@ -16,7 +16,6 @@
 #include <media/v4l2-common.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-subdev.h>
-#include <media/i2c/s5c73m3.h>
 
 #define DRIVER_NAME			"S5C73M3"
 
diff --git a/include/media/i2c/s5c73m3.h b/include/media/i2c/s5c73m3.h
deleted file mode 100644
index df0769d64523..000000000000
--- a/include/media/i2c/s5c73m3.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * Samsung LSI S5C73M3 8M pixel camera driver
- *
- * Copyright (C) 2012, Samsung Electronics, Co., Ltd.
- * Sylwester Nawrocki <s.nawrocki@samsung.com>
- * Andrzej Hajda <a.hajda@samsung.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#ifndef MEDIA_S5C73M3__
-#define MEDIA_S5C73M3__
-
-#include <linux/videodev2.h>
-#include <media/v4l2-mediabus.h>
-
-/**
- * struct s5c73m3_platform_data - s5c73m3 driver platform data
- * @mclk_frequency: sensor's master clock frequency in Hz
- * @bus_type:    bus type
- * @nlanes:      maximum number of MIPI-CSI lanes used
- * @horiz_flip:  default horizontal image flip value, non zero to enable
- * @vert_flip:   default vertical image flip value, non zero to enable
- */
-
-struct s5c73m3_platform_data {
-	unsigned long mclk_frequency;
-
-	enum v4l2_mbus_type bus_type;
-	u8 nlanes;
-	u8 horiz_flip;
-	u8 vert_flip;
-};
-
-#endif /* MEDIA_S5C73M3__ */
-- 
2.38.1.584.g0f3c55d4c2-goog


-- 
Dmitry
