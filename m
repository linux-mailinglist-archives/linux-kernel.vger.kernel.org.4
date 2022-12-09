Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C8C6483E8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLIOiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiLIOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:38:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2910522536;
        Fri,  9 Dec 2022 06:38:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m4-20020a05600c3b0400b003d1cb516ce0so5900476wms.4;
        Fri, 09 Dec 2022 06:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A09qABb0ead7LLA+4pGxEwf93dXTPbgLlbgE44UEqoI=;
        b=hcoeDm5BMAsucMZXIIyUFZqQpMkQdA6hKitiSo57m/EPBWs/+EItLpiWeMyx9PkNuc
         4nadDV9bSHfJEhfg50MKuBCg5Q7eshOB8+/esaH3uMZlhU6/ZVjidsYdSd0k1UnDGMwH
         hM5jZ7AxG6HcFZZsCmiMLqocLhV5kjvMyzc9EvvU9dv//i6XUZnBR5OfbWyzjHYMuI9T
         W2qYS7vRsA4VXM2MfoFpeKbUoWuEjBcZVZuKYrUyQsK762Z9HX1UU1VFRfil5H2JilFL
         ef8A/0vdVUEXMbXoPh+I3KCTXl5/XVSFt7+qNgNyLh8Wm3N0P1ZqaXzLnA0Tv98Nx1m+
         OLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A09qABb0ead7LLA+4pGxEwf93dXTPbgLlbgE44UEqoI=;
        b=eSaahT4iYawMIYSdN+wxRMF5z2w2e2opq9NRCSsnv78W6+0rMI+8axdPxydj4XLADg
         V72DsctftnEfe7u4EUMvyKlmHi7IqEnshDQijE7gmMK4TLU9RUdExqtHmrV5cfts6ysw
         NBdZxrAcdH5aIUsYE1wT9TUBwMJjvq8RLE9brsz+RdBJkBnKr+a/7aA1HTGFtARHtgzR
         til3r/rBvistoZmAmwQ0ne5Ki048rq8ADKhXJagOj4wHEUhpPt6zgwgyUYoJV/bFRItt
         tWu3wU0eLgBDV7McX5qjTtDdtwn6XbWFXZX09qIksAbzMjTHw78pa/F/Wtgfx6SNVjyy
         imKA==
X-Gm-Message-State: ANoB5pnh6rXFIDeGqpnlP861qmNGsyTu5DVVTBmDSIlw0UeJQjirmVfp
        atV04ZkcT5g1rGLbbUv84v8=
X-Google-Smtp-Source: AA0mqf4BP+j3eYb6lYBG3Vq+E0x6EYeaDNVZccp1XNdhMHTnCXJCvO9OcTHBgCBzX0KlkkkAKCwdKg==
X-Received: by 2002:a7b:c417:0:b0:3c6:e63e:8155 with SMTP id k23-20020a7bc417000000b003c6e63e8155mr5100647wmi.12.1670596682659;
        Fri, 09 Dec 2022 06:38:02 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b003d1e3b1624dsm9645517wms.2.2022.12.09.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:38:02 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Lee Jackson <info@arducam.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] media: i2c: ak7375: Add regulator management
Date:   Fri,  9 Dec 2022 17:37:41 +0300
Message-Id: <20221209143741.214242-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209143741.214242-1-y.oudjana@protonmail.com>
References: <20221209143741.214242-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Make the driver get needed regulators on probe and enable/disable
them on runtime PM callbacks.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Tested-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/ak7375.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
index 1af9f698eecf..e7cec45bc271 100644
--- a/drivers/media/i2c/ak7375.c
+++ b/drivers/media/i2c/ak7375.c
@@ -6,6 +6,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 
@@ -23,17 +24,29 @@
  */
 #define AK7375_CTRL_STEPS	64
 #define AK7375_CTRL_DELAY_US	1000
+/*
+ * The vcm may take up 10 ms (tDELAY) to power on and start taking
+ * I2C messages. Based on AK7371 datasheet.
+ */
+#define AK7375_POWER_DELAY_US	10000
 
 #define AK7375_REG_POSITION	0x0
 #define AK7375_REG_CONT		0x2
 #define AK7375_MODE_ACTIVE	0x0
 #define AK7375_MODE_STANDBY	0x40
 
+static const char * const ak7375_supply_names[] = {
+	"vdd",
+	"vio",
+};
+
 /* ak7375 device structure */
 struct ak7375_device {
 	struct v4l2_ctrl_handler ctrls_vcm;
 	struct v4l2_subdev sd;
 	struct v4l2_ctrl *focus;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(ak7375_supply_names)];
+
 	/* active or standby mode */
 	bool active;
 };
@@ -133,12 +146,24 @@ static int ak7375_probe(struct i2c_client *client)
 {
 	struct ak7375_device *ak7375_dev;
 	int ret;
+	unsigned int i;
 
 	ak7375_dev = devm_kzalloc(&client->dev, sizeof(*ak7375_dev),
 				  GFP_KERNEL);
 	if (!ak7375_dev)
 		return -ENOMEM;
 
+	for (i = 0; i < ARRAY_SIZE(ak7375_supply_names); i++)
+		ak7375_dev->supplies[i].supply = ak7375_supply_names[i];
+
+	ret = devm_regulator_bulk_get(&client->dev,
+				      ARRAY_SIZE(ak7375_supply_names),
+				      ak7375_dev->supplies);
+	if (ret) {
+		dev_err_probe(&client->dev, ret, "Failed to get regulators\n");
+		return ret;
+	}
+
 	v4l2_i2c_subdev_init(&ak7375_dev->sd, client, &ak7375_ops);
 	ak7375_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	ak7375_dev->sd.internal_ops = &ak7375_int_ops;
@@ -208,6 +233,11 @@ static int __maybe_unused ak7375_vcm_suspend(struct device *dev)
 	if (ret)
 		dev_err(dev, "%s I2C failure: %d\n", __func__, ret);
 
+	ret = regulator_bulk_disable(ARRAY_SIZE(ak7375_supply_names),
+				     ak7375_dev->supplies);
+	if (ret)
+		return ret;
+
 	ak7375_dev->active = false;
 
 	return 0;
@@ -228,6 +258,14 @@ static int __maybe_unused ak7375_vcm_resume(struct device *dev)
 	if (ak7375_dev->active)
 		return 0;
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(ak7375_supply_names),
+				    ak7375_dev->supplies);
+	if (ret)
+		return ret;
+
+	/* Wait for vcm to become ready */
+	usleep_range(AK7375_POWER_DELAY_US, AK7375_POWER_DELAY_US + 500);
+
 	ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_CONT,
 		AK7375_MODE_ACTIVE, 1);
 	if (ret) {
-- 
2.38.1

