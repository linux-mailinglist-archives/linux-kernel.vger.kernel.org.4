Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0898619516
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 12:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiKDLDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 07:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiKDLCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:02:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE172CCB7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 04:02:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k2so12341448ejr.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qsrjmAB2bc2yZOLis4WUU4zk1hVdcgBYDjuUdZNYJA=;
        b=Q0ouS1ZTGKV2jT9hNgwTXGwSTy8uz5eBnuEvnM5BR9n4JtOT+WWokoUvZjpgbRK+OZ
         KNuVSQ+XZMbtxGIeMNz07+RulsNwkIj62SCEf/WgUVRTO/gBEDA66HGWOXC9Eycj4SA7
         I9QLRE9SbZDZdxuo+AWlxnmJt3QcPBPWWk+Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qsrjmAB2bc2yZOLis4WUU4zk1hVdcgBYDjuUdZNYJA=;
        b=u00xuYIt4jzPQj9fRkNmKdVXMSAmGZ9JwPQZYjXmkgDE0BXciLIKfQqeo395ZK7xna
         iHF5yPUQwsvduCwbx89xmHPejLBUTmKfvT/ZAwJhsb1Unm6tqv6RqNfeh9HPrFW4b8PU
         CcnWJ1XaA+LLCLnBDWfCm+SYR0AJwLbMily45lF2mCjeYTpEx8a3nM+z25s7DssQ0gmV
         85D6+JzoJLPFP6GChZ1OHPIeqX8yAvmrb6UiUZvQRwfq2OkI7bsh3+ZpKs3SDNMEY2YH
         +wXWGCZLlEyt+/c5gXq0ppL13DblniVkZEkAgDPSUFC2FurXg6nvU1oI/PHXgErcwLkI
         sq6g==
X-Gm-Message-State: ACrzQf3+tPiSGxPeV3ZYtbeq7yzOLG0hUdSu5VKz/3zQbEaeHf1EVFuI
        VAK3mFn/vXonrkkbILAjHHrriA==
X-Google-Smtp-Source: AMsMyM7rPtx7R3xBAq3mAhmYoFuzglY0OrjxSCxDNSArUyvCF4XzPOlpRmGiNBPGszAIp9JtZATw4A==
X-Received: by 2002:a17:907:7244:b0:78d:cedc:7a9e with SMTP id ds4-20020a170907724400b0078dcedc7a9emr33822938ejc.600.1667559748911;
        Fri, 04 Nov 2022 04:02:28 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id n28-20020a5099dc000000b004619f024864sm1777833edb.81.2022.11.04.04.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:02:28 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH v4] rtc: isl12022: add support for temperature sensor
Date:   Fri,  4 Nov 2022 12:02:25 +0100
Message-Id: <20221104110225.2219761-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221026133847.1193422-1-linux@rasmusvillemoes.dk>
References: <20221026133847.1193422-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isl12022 has built-in temperature compensation effective over the
range -40C to +85C. It exposes the average of the last two temperature
measurements as a 10-bit value in half-Kelvins. Make this available
via the hwmon framework.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v4: add a real commit log, include Guenter's R-b.

v3 at https://lore.kernel.org/lkml/20221026133847.1193422-1-linux@rasmusvillemoes.dk/

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

