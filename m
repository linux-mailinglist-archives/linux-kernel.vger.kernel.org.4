Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBC5606A06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJTVEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJTVDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:03:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072BCCABC7;
        Thu, 20 Oct 2022 14:03:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a67so1365396edf.12;
        Thu, 20 Oct 2022 14:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxDfXjVat7Kys3E9Hetmxuq6ShOthTcFMt0dPFfzKbQ=;
        b=D8hXj+ChWswhe8UJrupSd4sNYASfYoDr07zqXfug9iPu9Ljxrsd/WQ84QMLzpJT46p
         IMwKw2MgZ103Ax6dPFPeJ+Vedme4vcFZUOdwa1l6Khkk2NItYJeIFc1Ve1e+d0XcCXml
         b+5qHBcLEwVlan/fAyjDXlV6qZnVKyLaPrfhQHA6k5mGpZZ2pKPEBmOramwK4Qwj7vrN
         q3rX54KOWu+u6DW3iZCG0iVPhddJOj+ZKeQMs/d7I77aiwzrkFVp/JOkM4LsotLW7n8i
         2fx+ZdVJOG6tW0EjS3mQv7hTTjNHv61NAVcToRYOriTrBUcXShIx+Zhh4doR9tjRGX0K
         iPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxDfXjVat7Kys3E9Hetmxuq6ShOthTcFMt0dPFfzKbQ=;
        b=RzKH8ykXPOxzYYFvx9koh5yb/0FAQ/H9PlJDdEo2t80dmpaJ2lideLYQOyuR0ZppQV
         kbRmShLAQMaj0yNwYElGIU4ERXXdomI4cjt1jud6YMqK0G0lgdgUqvhvcXpE4UAs+mfD
         U4CB5BU6+fyxbbV5ZqWzfXahw2TMWje5qzrRQV/NfZ+4BeuYoS7qE9PwOr2Ewe4x5hXI
         3pUb2yyeEYKk+r+m/d+JNUoLmu5ZikBnmfuLqaWDPccMyNNZuYuzh+lqMISuYlO8k0mX
         AGKWQeSO+WhKCerBUWiQBDipofjJur9WcfAadLCq1tFWTpKNZwxwzCrRFTaRSbMtNTrF
         NMVA==
X-Gm-Message-State: ACrzQf2iHvyoZtgOh0ifGkJqe59l2VFQsJzK7Xr0b3djR1gCKhViDjSd
        Kq/bih8u1lJe4pJkZJ0T1jk=
X-Google-Smtp-Source: AMsMyM7fmIolWQu5P5hRljBOaKGe/fWqGpMhwL4KbCOrpkKS/YAp8rcw6q3b6koeaLGzX/5Uy4TGsw==
X-Received: by 2002:a05:6402:148a:b0:459:2eab:9b0a with SMTP id e10-20020a056402148a00b004592eab9b0amr13877085edv.139.1666299826177;
        Thu, 20 Oct 2022 14:03:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c046-3500-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c046:3500::e63])
        by smtp.googlemail.com with ESMTPSA id 18-20020a170906211200b00779cde476e4sm10748721ejt.62.2022.10.20.14.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 14:03:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v2 4/4] hwmon: (jc42) Don't cache the temperature register
Date:   Thu, 20 Oct 2022 23:03:20 +0200
Message-Id: <20221020210320.1624617-5-martin.blumenstingl@googlemail.com>
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

Now that we're utilizing regmap and it's regcache for the
minimum/maximum/critical temperature registers the only cached register
that's left is the actual temperature register. Drop the custom cache
implementation as it just complicates things.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/hwmon/jc42.c | 59 ++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index 61311483a5c6..52a60eb0791b 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -203,13 +203,10 @@ static struct jc42_chips jc42_chips[] = {
 /* Each client has this additional data */
 struct jc42_data {
 	struct regmap	*regmap;
-	struct mutex	update_lock;	/* protect register access */
 	bool		extended;	/* true if extended range supported */
 	bool		valid;
-	unsigned long	last_updated;	/* In jiffies */
 	u16		orig_config;	/* original configuration */
 	u16		config;		/* current configuration */
-	u16		temp;		/* Cached temperature register value */
 };
 
 #define JC42_TEMP_MIN_EXTENDED	(-40000)
@@ -234,41 +231,20 @@ static int jc42_temp_from_reg(s16 reg)
 	return reg * 125 / 2;
 }
 
-static struct jc42_data *jc42_update_device(struct device *dev)
-{
-	struct jc42_data *data = dev_get_drvdata(dev);
-	unsigned int val;
-	int ret;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		ret = regmap_read(data->regmap, JC42_REG_TEMP, &val);
-		if (ret)
-			goto abort;
-
-		data->temp = val;
-		data->last_updated = jiffies;
-		data->valid = true;
-	}
-abort:
-	mutex_unlock(&data->update_lock);
-	return ret ? ERR_PTR(ret) : data;
-}
-
 static int jc42_read(struct device *dev, enum hwmon_sensor_types type,
 		     u32 attr, int channel, long *val)
 {
-	struct jc42_data *data = jc42_update_device(dev);
+	struct jc42_data *data = dev_get_drvdata(dev);
 	unsigned int regval;
 	int ret, temp, hyst;
 
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
 	switch (attr) {
 	case hwmon_temp_input:
-		*val = jc42_temp_from_reg(data->temp);
+		ret = regmap_read(data->regmap, JC42_REG_TEMP, &regval);
+		if (ret)
+			return ret;
+
+		*val = jc42_temp_from_reg(regval);
 		return 0;
 	case hwmon_temp_min:
 		ret = regmap_read(data->regmap, JC42_REG_TEMP_LOWER, &regval);
@@ -314,13 +290,25 @@ static int jc42_read(struct device *dev, enum hwmon_sensor_types type,
 		*val = temp - hyst;
 		return 0;
 	case hwmon_temp_min_alarm:
-		*val = (data->temp >> JC42_ALARM_MIN_BIT) & 1;
+		ret = regmap_read(data->regmap, JC42_REG_TEMP, &regval);
+		if (ret)
+			return ret;
+
+		*val = (regval >> JC42_ALARM_MIN_BIT) & 1;
 		return 0;
 	case hwmon_temp_max_alarm:
-		*val = (data->temp >> JC42_ALARM_MAX_BIT) & 1;
+		ret = regmap_read(data->regmap, JC42_REG_TEMP, &regval);
+		if (ret)
+			return ret;
+
+		*val = (regval >> JC42_ALARM_MAX_BIT) & 1;
 		return 0;
 	case hwmon_temp_crit_alarm:
-		*val = (data->temp >> JC42_ALARM_CRIT_BIT) & 1;
+		ret = regmap_read(data->regmap, JC42_REG_TEMP, &regval);
+		if (ret)
+			return ret;
+
+		*val = (regval >> JC42_ALARM_CRIT_BIT) & 1;
 		return 0;
 	default:
 		return -EOPNOTSUPP;
@@ -335,8 +323,6 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
 	int diff, hyst;
 	int ret;
 
-	mutex_lock(&data->update_lock);
-
 	switch (attr) {
 	case hwmon_temp_min:
 		ret = regmap_write(data->regmap, JC42_REG_TEMP_LOWER,
@@ -383,8 +369,6 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
 		break;
 	}
 
-	mutex_unlock(&data->update_lock);
-
 	return ret;
 }
 
@@ -521,7 +505,6 @@ static int jc42_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 
 	i2c_set_clientdata(client, data);
-	mutex_init(&data->update_lock);
 
 	ret = regmap_read(data->regmap, JC42_REG_CAP, &cap);
 	if (ret)
-- 
2.38.1

