Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7C060E250
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJZNjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiJZNiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:38:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA3DAC67
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:38:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f37so28587204lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eI8o795Jb/Xd0JX5X0dAOIZGLOgY2zaaFQjzYjdQZ90=;
        b=fXkGdLYT3p0Ama3RbXbEsBi2Y1t2pEbFMWVKt9h+4WEuKPFtMYFvJZXw5exwbYcvET
         ujTwZYv4rZ4Mxcj4vzPOGW/KqaPhoYFpHYpGeHgsPPFrCtDVMVlny3g479H6i852EXVV
         86BT8c+nbtHH5OMOE0SHKtElVYxRjtHetet88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eI8o795Jb/Xd0JX5X0dAOIZGLOgY2zaaFQjzYjdQZ90=;
        b=4KxSr62QDtpn2b+jKYAAnUrIGQBYaUcUYo++DPgJRxezEk9Vs9hUK7OUENcb8rHOMe
         HAvQ8apEQe9Gt35EAmY2wMpT+A0042ee/ukfhHtVHmFelEIuRI5oeZxOu/WjW9/tDogG
         nGtunThiZUdDHVFbvJzaQa1n2ZH2aIlDoW+/T7AlY6oYYLVY788ejR8gX20OWX47VWpa
         ghY5J6FDvpXEr73EqTHXMfn4SY8+Fz+8T4lQp9Ba8M3yoYFTSH8HcI2e90qNF7FRXCCA
         zlikLzRCoqCZJdeoRNA22FP+Mag1/72D04pUp913HlCnLcgwUVr/TbI2n1QLrG5eJKkM
         hhSA==
X-Gm-Message-State: ACrzQf1VtI6ZJYXjdIXYRVZybURWnm56+xLeVcgcjbY5doRd1q7SzOma
        pH7yny0dDHNVIPgBs97/y6T+Cbd8fAV17tuMs80=
X-Google-Smtp-Source: AMsMyM4zqMaSZDe9+cBAS4RhqwHtsZ8JxUb5nZ9a2dyZt5ICCWA4UaZQ2A9hj87QWH0Cfcb+d3L9bA==
X-Received: by 2002:a05:6512:3a86:b0:4ad:23ac:94de with SMTP id q6-20020a0565123a8600b004ad23ac94demr4754686lfu.70.1666791531911;
        Wed, 26 Oct 2022 06:38:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p11-20020a2eb10b000000b0026dc7b59d8esm949770ljl.22.2022.10.26.06.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:38:51 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH v3 9/9] rtc: isl12022: add support for temperature sensor
Date:   Wed, 26 Oct 2022 15:38:47 +0200
Message-Id: <20221026133847.1193422-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921114624.3250848-10-linux@rasmusvillemoes.dk>
References: <20220921114624.3250848-10-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v3: drop 0444 update_interval property.

v2 of patches 1-8 are already upstream (b1a1baa657c7 and parents).

 drivers/rtc/rtc-isl12022.c | 94 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index ca677c4265e6..a3b0de3393f5 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/hwmon.h>
 
 /* ISL register offsets */
 #define ISL12022_REG_SC		0x00
@@ -30,6 +31,9 @@
 #define ISL12022_REG_SR		0x07
 #define ISL12022_REG_INT	0x08
 
+#define ISL12022_REG_BETA	0x0d
+#define ISL12022_REG_TEMP_L	0x28
+
 /* ISL register bits */
 #define ISL12022_HR_MIL		(1 << 7)	/* military or 24 hour time */
 
@@ -38,6 +42,7 @@
 
 #define ISL12022_INT_WRTC	(1 << 6)
 
+#define ISL12022_BETA_TSE	(1 << 7)
 
 static struct i2c_driver isl12022_driver;
 
@@ -46,6 +51,93 @@ struct isl12022 {
 	struct regmap *regmap;
 };
 
+static umode_t isl12022_hwmon_is_visible(const void *data,
+					 enum hwmon_sensor_types type,
+					 u32 attr, int channel)
+{
+	if (type == hwmon_temp && attr == hwmon_temp_input)
+		return 0444;
+
+	return 0;
+}
+
+/*
+ * A user-initiated temperature conversion is not started by this function,
+ * so the temperature is updated once every ~60 seconds.
+ */
+static int isl12022_hwmon_read_temp(struct device *dev, long *mC)
+{
+	struct isl12022 *isl12022 = dev_get_drvdata(dev);
+	struct regmap *regmap = isl12022->regmap;
+	u8 temp_buf[2];
+	int temp, ret;
+
+	ret = regmap_bulk_read(regmap, ISL12022_REG_TEMP_L,
+			       temp_buf, sizeof(temp_buf));
+	if (ret)
+		return ret;
+	/*
+	 * Temperature is represented as a 10-bit number, unit half-Kelvins.
+	 */
+	temp = (temp_buf[1] << 8) | temp_buf[0];
+	temp *= 500;
+	temp -= 273000;
+
+	*mC = temp;
+
+	return 0;
+}
+
+static int isl12022_hwmon_read(struct device *dev,
+			       enum hwmon_sensor_types type,
+			       u32 attr, int channel, long *val)
+{
+	if (type == hwmon_temp && attr == hwmon_temp_input)
+		return isl12022_hwmon_read_temp(dev, val);
+
+	return -EOPNOTSUPP;
+}
+
+static const struct hwmon_channel_info *isl12022_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops isl12022_hwmon_ops = {
+	.is_visible = isl12022_hwmon_is_visible,
+	.read = isl12022_hwmon_read,
+};
+
+static const struct hwmon_chip_info isl12022_hwmon_chip_info = {
+	.ops = &isl12022_hwmon_ops,
+	.info = isl12022_hwmon_info,
+};
+
+static void isl12022_hwmon_register(struct device *dev)
+{
+	struct isl12022 *isl12022;
+	struct device *hwmon;
+	int ret;
+
+	if (!IS_REACHABLE(CONFIG_HWMON))
+		return;
+
+	isl12022 = dev_get_drvdata(dev);
+
+	ret = regmap_update_bits(isl12022->regmap, ISL12022_REG_BETA,
+				 ISL12022_BETA_TSE, ISL12022_BETA_TSE);
+	if (ret) {
+		dev_warn(dev, "unable to enable temperature sensor\n");
+		return;
+	}
+
+	hwmon = devm_hwmon_device_register_with_info(dev, "isl12022", isl12022,
+						     &isl12022_hwmon_chip_info,
+						     NULL);
+	if (IS_ERR(hwmon))
+		dev_warn(dev, "unable to register hwmon device: %pe\n", hwmon);
+}
+
 /*
  * In the routines that deal directly with the isl12022 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
@@ -160,6 +252,8 @@ static int isl12022_probe(struct i2c_client *client)
 		return PTR_ERR(isl12022->regmap);
 	}
 
+	isl12022_hwmon_register(&client->dev);
+
 	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(isl12022->rtc))
 		return PTR_ERR(isl12022->rtc);
-- 
2.37.2

