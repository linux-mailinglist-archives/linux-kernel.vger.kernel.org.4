Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E3864322B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiLETYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiLETYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:24:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E772C111
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:19:40 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gh17so891499ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxBW8yp9uVxjnMmLtiQH8YKJ4OzTSN8FpMGVyjSKVsU=;
        b=EgfF4L9WnVGuj5kiAv6q10Bm41y9KAvnDik2cbYyS7TA+fNQM5spcaL7JwOPbXXrjO
         yC61N8TXxMYM5UUEbfArcLLdQ0eazVnG5EV/vPY1KAMRxhpJOJlBsETKq+K8joqjQ9uE
         vvKxrvbfqOl5ELFBYnKO1zbu0jNkBsYkRzqtJDxSmKLqaA01aarWmK/rh/DR7uvxL33T
         yt4ZOBNGABqP06YK7HsM35mObRz2bAcfKdV5KY41yK6gdVf6wHU+MYGjrpvVWM/dJTPI
         ulBh/3APVS5U4QIv7M2ETTgS1WGup2Q/DGsXjjKY92ObesgR8LV/xlRFoDmWLi2pBfyL
         1tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxBW8yp9uVxjnMmLtiQH8YKJ4OzTSN8FpMGVyjSKVsU=;
        b=cOqh42wSYlQRxVvxvTwFfPX6bvX81Qz6DyH7V2pacd2Fb7rcm08py177i/pkCHlxBS
         N3qDZIvdDQ893gmvv08FT8TvKcuyqzvqPlAlBNj0Mc4r2/v2C3bD7MuDPHkRBlTWykUO
         ryzGJqUcrrlEBPevFwKKFV/syUg8vHyjBN1NmAP2hU8Lxn/io+EXAJHbFkioENPWvQlg
         p92ifGdxj8NYw3RklMgKOt8uJuYLrWgPNuUT6UfN75J9AkoRgbqmWp/fhGTPc2zU7Axi
         /h1kYF9SXx1EsznRx4aMoUSnfzjspI3wrcAaqqYn+ny7K8T0Csm69gEWVJZj9xq6gSzW
         paKg==
X-Gm-Message-State: ANoB5pkO8/Glx00F6/TGHWN16om+l2WdJ7R0WnZa/W/VsRb1IEZnN2Ol
        +OY5KL4/w9XjpQuM3JVx394dUg==
X-Google-Smtp-Source: AA0mqf53fCQueU6/b/N/g3O7wxIDQTfhZlPfRRo+hdaDy4APtFYIOy/XilGhgzMGkxICwkQj7O3SAg==
X-Received: by 2002:a17:906:79c4:b0:778:e3e2:8311 with SMTP id m4-20020a17090679c400b00778e3e28311mr57786836ejo.342.1670267979453;
        Mon, 05 Dec 2022 11:19:39 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id t16-20020aa7db10000000b0045cf4f72b04sm112739eds.94.2022.12.05.11.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:19:39 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v6 2/5] hwmon: (pmbus/core): Notify hwmon events
Date:   Mon,  5 Dec 2022 20:19:13 +0100
Message-Id: <20221205191917.2614603-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221205191917.2614603-1-Naresh.Solanki@9elements.com>
References: <20221205191917.2614603-1-Naresh.Solanki@9elements.com>
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

Notify hwmon events using the pmbus irq handler.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 95 ++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 244fd2597252..b005a1c8ad7e 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2781,18 +2781,43 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
 	},
 };
 
-static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+#define to_dev_attr(_dev_attr) \
+	container_of(_dev_attr, struct device_attribute, attr)
+
+static void pmbus_notify(struct pmbus_data *data, int page, int reg, int flags)
+{
+	int i;
+
+	for (i = 0; i < data->num_attributes; i++) {
+		struct device_attribute *da = to_dev_attr(data->group.attrs[i]);
+		struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+		int index = attr->index;
+		u16 smask = pb_index_to_mask(index);
+		u8 spage = pb_index_to_page(index);
+		u16 sreg = pb_index_to_reg(index);
+
+		if (reg == sreg && page == spage && (smask & flags)) {
+			dev_dbg(data->dev, "sysfs notify: %s", da->attr.name);
+			sysfs_notify(&data->dev->kobj, NULL, da->attr.name);
+			kobject_uevent(&data->dev->kobj, KOBJ_CHANGE);
+			flags &= ~smask;
+		}
+
+		if (!flags)
+			break;
+	}
+}
+
+static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error,
+				    bool notify)
 {
-	int i, status;
 	const struct pmbus_regulator_status_category *cat;
 	const struct pmbus_regulator_status_assoc *bit;
-	struct device *dev = rdev_get_dev(rdev);
-	struct i2c_client *client = to_i2c_client(dev->parent);
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	u8 page = rdev_get_id(rdev);
+	struct i2c_client *client = to_i2c_client(data->dev);
 	int func = data->info->func[page];
+	int i, status, ret;
 
-	*flags = 0;
+	*error = 0;
 
 	mutex_lock(&data->update_lock);
 
@@ -2803,14 +2828,17 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 
 		status = _pmbus_read_byte_data(client, page, cat->reg);
 		if (status < 0) {
-			mutex_unlock(&data->update_lock);
-			return status;
+			ret = status;
+			goto unlock;
 		}
 
 		for (bit = cat->bits; bit->pflag; bit++) {
 			if (status & bit->pflag)
-				*flags |= bit->rflag;
+				*error |= bit->rflag;
 		}
+
+		if (notify && status)
+			pmbus_notify(data, page, cat->reg, status);
 	}
 
 	/*
@@ -2823,36 +2851,53 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	 * REGULATOR_ERROR_<foo>_WARN.
 	 */
 	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
-	mutex_unlock(&data->update_lock);
-	if (status < 0)
-		return status;
 
-	if (pmbus_regulator_is_enabled(rdev)) {
+	if (status < 0) {
+		ret = status;
+		goto unlock;
+	}
+
+	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
+	if (ret < 0)
+		goto unlock;
+
+	if (ret & PB_OPERATION_CONTROL_ON) {
 		if (status & PB_STATUS_OFF)
-			*flags |= REGULATOR_ERROR_FAIL;
+			*error |= REGULATOR_ERROR_FAIL;
 
 		if (status & PB_STATUS_POWER_GOOD_N)
-			*flags |= REGULATOR_ERROR_REGULATION_OUT;
+			*error |= REGULATOR_ERROR_REGULATION_OUT;
 	}
 	/*
 	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
 	 * defined strictly as fault indicators (not warnings).
 	 */
 	if (status & PB_STATUS_IOUT_OC)
-		*flags |= REGULATOR_ERROR_OVER_CURRENT;
+		*error |= REGULATOR_ERROR_OVER_CURRENT;
 	if (status & PB_STATUS_VOUT_OV)
-		*flags |= REGULATOR_ERROR_REGULATION_OUT;
+		*error |= REGULATOR_ERROR_REGULATION_OUT;
 
 	/*
 	 * If we haven't discovered any thermal faults or warnings via
 	 * PMBUS_STATUS_TEMPERATURE, map PB_STATUS_TEMPERATURE to a warning as
 	 * a (conservative) best-effort interpretation.
 	 */
-	if (!(*flags & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
+	if (!(*error & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
 	    (status & PB_STATUS_TEMPERATURE))
-		*flags |= REGULATOR_ERROR_OVER_TEMP_WARN;
+		*error |= REGULATOR_ERROR_OVER_TEMP_WARN;
 
-	return 0;
+unlock:
+	mutex_unlock(&data->update_lock);
+	return ret;
+}
+
+static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+{
+	struct device *dev = rdev_get_dev(rdev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
 }
 
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
@@ -3082,10 +3127,14 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 {
 	struct pmbus_data *data = pdata;
 	struct i2c_client *client = to_i2c_client(data->dev);
-	int i, status;
+	int i, status, ret;
 
 	for (i = 0; i < data->info->pages; i++) {
 
+		ret = pmbus_get_flags(data, i, &status, true);
+		if (ret)
+			return ret;
+
 		mutex_lock(&data->update_lock);
 		status = pmbus_read_status_word(client, i);
 		if (status < 0) {
@@ -3099,7 +3148,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 		mutex_unlock(&data->update_lock);
 	}
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
-- 
2.37.3

