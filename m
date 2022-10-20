Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8099E606A03
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJTVDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJTVDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:03:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ED6CABC4;
        Thu, 20 Oct 2022 14:03:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b2so2532088eja.6;
        Thu, 20 Oct 2022 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91jTp+vVBC1xOtBKmUzVXsrC90O9nlN7ucaxFP7eflw=;
        b=hYiKVyh8jRh+Q8Z+uKI1QnM+J+GZKFFzW995sNAH0k1n0J6RAGOkmFbrAfnXkOCtUu
         NoQFd4G93JmgZp6VB/8RIXBSGMKMsDW6q7qleTpWj3TVXLP11AWSH36gbEU9NAvbn1Si
         qn5s+MXslAElNnT67RIBd4PTVydhHCIv32bCunnlh8/OB0OCCU3i2VOoYsWXUEt+1irj
         fKnLmRxTi3yx4HBLcnQzzk+wpfeMYUgOiUAxMjgmo020wJqPSSG3x0NBzAKrE9/csQbB
         QHNaU+WJy3W88ZI6sw11gIk8J/tH//dT8i7AX2AGIDcXubtvD8LwkqHuUTp3BVD+05m5
         IxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91jTp+vVBC1xOtBKmUzVXsrC90O9nlN7ucaxFP7eflw=;
        b=FcW8r7VwHomsG8Q6EjUleWwCf+jhl4ZQPcZgqj5BXtMjqpD1gvPsxrze0Kp1wiRl1O
         jodPgVUVpd2r6R+YMSi4aC3uaS4yzq6e8CQ4OsOjVEWzTQjGAeDSPjeG266vo6DrdPTi
         8m9L6F7L7gnOgpUszWQHw+/z7oA/xs0kUQIUckGqOycAQe+fSNAAVa0ZMyt+5nhs96Bo
         sBruNMnyZPBx9dKTuZHswmUxNSvVVqumXIb+r6xgu7ubmCvBzNBbhApfTO510V81SkLh
         MPkjiLZ7eIE5mt9+rE9xG8fwCQgU0VG2M8V7Zcpt9kj+P4GEi2KOLSv9UWf8acDO8QTj
         kzvQ==
X-Gm-Message-State: ACrzQf0To4lnyfp4e7biT6amAg4ndD7vtGsReJZxaDv2DE/Wxoj6VPZA
        2xXFzBQgOvTv9jxqCD+hILt7WhLIS0I=
X-Google-Smtp-Source: AMsMyM7qec1p6lhMfzqbJ0J+8jmaMuL+DjIT0ye2Az0/DuVbluJ34AFkDTfe+dunJjcqJbzHucii7g==
X-Received: by 2002:a17:906:8447:b0:78d:776f:c544 with SMTP id e7-20020a170906844700b0078d776fc544mr12817470ejy.405.1666299823728;
        Thu, 20 Oct 2022 14:03:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c046-3500-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c046:3500::e63])
        by smtp.googlemail.com with ESMTPSA id 18-20020a170906211200b00779cde476e4sm10748721ejt.62.2022.10.20.14.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:03:43 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v2 2/4] hwmon: (jc42) Convert to regmap's built-in caching
Date:   Thu, 20 Oct 2022 23:03:18 +0200
Message-Id: <20221020210320.1624617-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
References: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move over to regmap's built-in caching instead of adding a custom
caching implementation. This works for JC42_REG_TEMP_UPPER,
JC42_REG_TEMP_LOWER and JC42_REG_TEMP_CRITICAL as these values never
change except when explicitly written. For JC42_REG_TEMP a cache
variable is still kept as regmap cannot cache this register (because
it's volatile, meaning it can change at any time).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/hwmon/jc42.c | 97 ++++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 43 deletions(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 329a80264556..3f524ab5451c 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -200,21 +200,6 @@ static struct jc42_chips jc42_chips[] = {
 	{ STM_MANID, STTS3000_DEVID, STTS3000_DEVID_MASK },
 };
 
-enum temp_index {
-	t_input = 0,
-	t_crit,
-	t_min,
-	t_max,
-	t_num_temp
-};
-
-static const u8 temp_regs[t_num_temp] = {
-	[t_input] = JC42_REG_TEMP,
-	[t_crit] = JC42_REG_TEMP_CRITICAL,
-	[t_min] = JC42_REG_TEMP_LOWER,
-	[t_max] = JC42_REG_TEMP_UPPER,
-};
-
 /* Each client has this additional data */
 struct jc42_data {
 	struct regmap	*regmap;
@@ -224,7 +209,7 @@ struct jc42_data {
 	unsigned long	last_updated;	/* In jiffies */
 	u16		orig_config;	/* original configuration */
 	u16		config;		/* current configuration */
-	u16		temp[t_num_temp];/* Temperatures */
+	u16		temp;		/* Cached temperature register value */
 };
 
 #define JC42_TEMP_MIN_EXTENDED	(-40000)
@@ -252,18 +237,17 @@ static int jc42_temp_from_reg(s16 reg)
 static struct jc42_data *jc42_update_device(struct device *dev)
 {
 	struct jc42_data *data = dev_get_drvdata(dev);
-	unsigned int i, val;
+	unsigned int val;
 	int ret;
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		for (i = 0; i < t_num_temp; i++) {
-			ret = regmap_read(data->regmap, temp_regs[i], &val);
-			if (ret)
-				goto abort;
-			data->temp[i] = val;
-		}
+		ret = regmap_read(data->regmap, JC42_REG_TEMP, &val);
+		if (ret)
+			goto abort;
+
+		data->temp = val;
 		data->last_updated = jiffies;
 		data->valid = true;
 	}
@@ -276,44 +260,67 @@ static int jc42_read(struct device *dev, enum hwmon_sensor_types type,
 		     u32 attr, int channel, long *val)
 {
 	struct jc42_data *data = jc42_update_device(dev);
-	int temp, hyst;
+	unsigned int regval;
+	int ret, temp, hyst;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
 	switch (attr) {
 	case hwmon_temp_input:
-		*val = jc42_temp_from_reg(data->temp[t_input]);
+		*val = jc42_temp_from_reg(data->temp);
 		return 0;
 	case hwmon_temp_min:
-		*val = jc42_temp_from_reg(data->temp[t_min]);
+		ret = regmap_read(data->regmap, JC42_REG_TEMP_LOWER, &regval);
+		if (ret)
+			return ret;
+
+		*val = jc42_temp_from_reg(regval);
 		return 0;
 	case hwmon_temp_max:
-		*val = jc42_temp_from_reg(data->temp[t_max]);
+		ret = regmap_read(data->regmap, JC42_REG_TEMP_UPPER, &regval);
+		if (ret)
+			return ret;
+
+		*val = jc42_temp_from_reg(regval);
 		return 0;
 	case hwmon_temp_crit:
-		*val = jc42_temp_from_reg(data->temp[t_crit]);
+		ret = regmap_read(data->regmap, JC42_REG_TEMP_CRITICAL,
+				  &regval);
+		if (ret)
+			return ret;
+
+		*val = jc42_temp_from_reg(regval);
 		return 0;
 	case hwmon_temp_max_hyst:
-		temp = jc42_temp_from_reg(data->temp[t_max]);
+		ret = regmap_read(data->regmap, JC42_REG_TEMP_UPPER, &regval);
+		if (ret)
+			return ret;
+
+		temp = jc42_temp_from_reg(regval);
 		hyst = jc42_hysteresis[(data->config & JC42_CFG_HYST_MASK)
 						>> JC42_CFG_HYST_SHIFT];
 		*val = temp - hyst;
 		return 0;
 	case hwmon_temp_crit_hyst:
-		temp = jc42_temp_from_reg(data->temp[t_crit]);
+		ret = regmap_read(data->regmap, JC42_REG_TEMP_CRITICAL,
+				  &regval);
+		if (ret)
+			return ret;
+
+		temp = jc42_temp_from_reg(regval);
 		hyst = jc42_hysteresis[(data->config & JC42_CFG_HYST_MASK)
 						>> JC42_CFG_HYST_SHIFT];
 		*val = temp - hyst;
 		return 0;
 	case hwmon_temp_min_alarm:
-		*val = (data->temp[t_input] >> JC42_ALARM_MIN_BIT) & 1;
+		*val = (data->temp >> JC42_ALARM_MIN_BIT) & 1;
 		return 0;
 	case hwmon_temp_max_alarm:
-		*val = (data->temp[t_input] >> JC42_ALARM_MAX_BIT) & 1;
+		*val = (data->temp >> JC42_ALARM_MAX_BIT) & 1;
 		return 0;
 	case hwmon_temp_crit_alarm:
-		*val = (data->temp[t_input] >> JC42_ALARM_CRIT_BIT) & 1;
+		*val = (data->temp >> JC42_ALARM_CRIT_BIT) & 1;
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -324,6 +331,7 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long val)
 {
 	struct jc42_data *data = dev_get_drvdata(dev);
+	unsigned int regval;
 	int diff, hyst;
 	int ret;
 
@@ -331,21 +339,23 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
 
 	switch (attr) {
 	case hwmon_temp_min:
-		data->temp[t_min] = jc42_temp_to_reg(val, data->extended);
-		ret = regmap_write(data->regmap, temp_regs[t_min],
-				   data->temp[t_min]);
+		ret = regmap_write(data->regmap, JC42_REG_TEMP_LOWER,
+				   jc42_temp_to_reg(val, data->extended));
 		break;
 	case hwmon_temp_max:
-		data->temp[t_max] = jc42_temp_to_reg(val, data->extended);
-		ret = regmap_write(data->regmap, temp_regs[t_max],
-				   data->temp[t_max]);
+		ret = regmap_write(data->regmap, JC42_REG_TEMP_UPPER,
+				   jc42_temp_to_reg(val, data->extended));
 		break;
 	case hwmon_temp_crit:
-		data->temp[t_crit] = jc42_temp_to_reg(val, data->extended);
-		ret = regmap_write(data->regmap, temp_regs[t_crit],
-				   data->temp[t_crit]);
+		ret = regmap_write(data->regmap, JC42_REG_TEMP_CRITICAL,
+				   jc42_temp_to_reg(val, data->extended));
 		break;
 	case hwmon_temp_crit_hyst:
+		ret = regmap_read(data->regmap, JC42_REG_TEMP_CRITICAL,
+				  &regval);
+		if (ret)
+			return ret;
+
 		/*
 		 * JC42.4 compliant chips only support four hysteresis values.
 		 * Pick best choice and go from there.
@@ -353,7 +363,7 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
 		val = clamp_val(val, (data->extended ? JC42_TEMP_MIN_EXTENDED
 						     : JC42_TEMP_MIN) - 6000,
 				JC42_TEMP_MAX);
-		diff = jc42_temp_from_reg(data->temp[t_crit]) - val;
+		diff = jc42_temp_from_reg(regval) - val;
 		hyst = 0;
 		if (diff > 0) {
 			if (diff < 2250)
@@ -491,6 +501,7 @@ static const struct regmap_config jc42_regmap_config = {
 	.writeable_reg = jc42_writable_reg,
 	.readable_reg = jc42_readable_reg,
 	.volatile_reg = jc42_volatile_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int jc42_probe(struct i2c_client *client)
-- 
2.38.1

