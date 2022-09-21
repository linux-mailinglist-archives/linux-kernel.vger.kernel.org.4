Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73055BFD44
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiIULre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIULrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:47:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B495AD1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i26so8695560lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4RHBks34HLeSc7CjE4OmjukDfKagdpXGucbBixwNsEk=;
        b=jQeVjUORFQkiQ1g9rO+9flDQjaKQBkQ58OKNbg2hDBLmKKGKgJ4L5yez2cceTckKYe
         YHdskTdMi6WVQRp0B7UCGXXqOrFIisNJGrJWAMAg4h8yXHZvzh66qffsY6IPfeLqxo/C
         UnPSIarg7PpHukqYs4xn0IMMzp5Z5BxP3t/nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4RHBks34HLeSc7CjE4OmjukDfKagdpXGucbBixwNsEk=;
        b=ZzEaXxnUc1qRMnmbaaWudCHxo2kg6Tmn0Y1tgbf3Jas4QnwPZSPjoW4I077EZrwAr/
         wM+b8OGaTOQ0SlZLTzopjtIIsUTfMiG3ui/yKvIGODnRGjJlHz82bZvtACiS/y35rNZF
         NqkPpBZwVz4tnjzEQhdfDcYiXvwfDwjtqJFyKQQQ5E1mbCq9sa4gK2/rfbx3gg0D9BPp
         BneMDL0KohZpT7GuqkneS/42cRzIgwHpET6xIRWDqTxIQONCzOwyW/2Uu9v3IK9D/KQB
         nACQS04q5Ks9rTj3cu8LBUfHp490IycmE17xHlAKbmGAFfjEo2bQ9IpqHr0qNpQTNYPh
         2SGw==
X-Gm-Message-State: ACrzQf3txpAMKnAwxL2L7si4pP0Tl9psZWRT3LquoMDAsYM8OMdw/Ga/
        lFZ0p7mEdCIcM1jG4gELK+ODBQKr+p1iZj+cWSo=
X-Google-Smtp-Source: AMsMyM52W5QkNicQxybqR3JQJBjbfbZjuNryoCgR13QN8MU4YXQYZfAW7ByhW4Z9KqzDiEXFoFVX6w==
X-Received: by 2002:a19:f60f:0:b0:49f:4ec7:21ed with SMTP id x15-20020a19f60f000000b0049f4ec721edmr10608737lfe.77.1663760802540;
        Wed, 21 Sep 2022 04:46:42 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00494618889c0sm405713lfr.42.2022.09.21.04.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:46:41 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH v2 9/9] rtc: isl12022: add support for temperature sensor
Date:   Wed, 21 Sep 2022 13:46:24 +0200
Message-Id: <20220921114624.3250848-10-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 104 +++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index ca677c4265e6..f3efe61c81e5 100644
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
 
@@ -46,6 +51,103 @@ struct isl12022 {
 	struct regmap *regmap;
 };
 
+static umode_t isl12022_hwmon_is_visible(const void *data,
+					 enum hwmon_sensor_types type,
+					 u32 attr, int channel)
+{
+	if (type == hwmon_chip && attr == hwmon_chip_update_interval)
+		return 0444;
+
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
+	if (type == hwmon_chip && attr == hwmon_chip_update_interval) {
+		*val = 60000;
+		return 0;
+	}
+
+	if (type == hwmon_temp && attr == hwmon_temp_input) {
+		return isl12022_hwmon_read_temp(dev, val);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const struct hwmon_channel_info *isl12022_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
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
@@ -160,6 +262,8 @@ static int isl12022_probe(struct i2c_client *client)
 		return PTR_ERR(isl12022->regmap);
 	}
 
+	isl12022_hwmon_register(&client->dev);
+
 	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(isl12022->rtc))
 		return PTR_ERR(isl12022->rtc);
-- 
2.37.2

