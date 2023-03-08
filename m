Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA1C6B01E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCHIo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjCHIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:44:40 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6219F067;
        Wed,  8 Mar 2023 00:44:39 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ec29so31767239edb.6;
        Wed, 08 Mar 2023 00:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678265077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt0rP56ZVICJXZOyWcT1Og4PPdYTw7SSYjSP/fByF9w=;
        b=q4jDMXjbnN11ZJAbkD1K3MPkAEmb7KJT9Syk3m40F8SthEU/wy5ivzobAFc7jLuLdn
         Sp+76WjLsufxK8FxW+bqXlr59Us4r3k3qqRIkdxMaeuKQkYHbOP8PfvTxFgns4CYHR3T
         w5SIXGD7hpHTE6oDLsSSMAn6oZj0pmOtcNboOUr2NAroAWYdDjgxGmd+KnI4WOj4zQyq
         uHj1w4Y8orQ9y6T28/gMEZAq3SBdZeEKijZ3Qiiv0Zmd4X+w3zb/xGgK8oKgvwz4/Z30
         VYb6S2UubuL1DicrTTsXYmYCS7TF8kagHYV1DwC/KlxEbqdRb6BV9Og8RX0vBOIcKM1m
         bkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bt0rP56ZVICJXZOyWcT1Og4PPdYTw7SSYjSP/fByF9w=;
        b=i3eZLC4EyV1S1gd93D/47vKxE0Nffe5oNugDMOFDhIugtN2Ydsol+TjaDSzeuaOXHT
         w42nIMHRjQJU3PrKdeQzyXdbvaYLYJhuVWkKc/fUbHLykM42+ATVPHVbgOjXOykn01qv
         hVocWgKQXrAb6lBfF72Nur5bCZEdI7Ft31S0PJ9NxW2X09f19fLZDl+89WDvU4rj1/Zq
         VszEWhlikDnS5FSNoMQ1zrtQh+Gp3gFQRa6w1olNwrvdt/iWILHexMGyulvMm2ZtNO0B
         vyn8mdxQxTvGmp9UmiODY9MYx+uSsY4LciA94X5I5sYUbaYeDNw+k/KUEwF2ahH6KbUp
         fdEA==
X-Gm-Message-State: AO0yUKXKQankySWoL82fhbLiu2jM++0Swe0MIge8CPvTbTLQzIhedcx/
        2WP87kugxTjUJ9HTIscFToE=
X-Google-Smtp-Source: AK7set9w4xe0l2DA2T2YXSTNptqTRXa6rFYbyI3xApG9MdT2T3iw5Xg1Zl7QA4HyNMWshKpnVCy7iw==
X-Received: by 2002:a17:906:b1cc:b0:8b1:7684:dfab with SMTP id bv12-20020a170906b1cc00b008b17684dfabmr19005757ejb.38.1678265077771;
        Wed, 08 Mar 2023 00:44:37 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906838800b008ee95ccfe06sm7163891ejx.119.2023.03.08.00.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:44:37 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] power: max17040: get thermal data from adc if available
Date:   Wed,  8 Mar 2023 10:44:19 +0200
Message-Id: <20230308084419.11934-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308084419.11934-1-clamor95@gmail.com>
References: <20230308084419.11934-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since fuel gauge does not support thermal monitoring,
some vendors may couple this fuel gauge with thermal/adc
sensor to monitor battery cell exact temperature.

Add this feature by adding optional iio thermal channel.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/supply/max17040_battery.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 6dfce7b1309e..8c743c26dc6e 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -18,6 +18,7 @@
 #include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/iio/consumer.h>
 
 #define MAX17040_VCELL	0x02
 #define MAX17040_SOC	0x04
@@ -143,6 +144,7 @@ struct max17040_chip {
 	struct power_supply		*battery;
 	struct power_supply_battery_info	*batt_info;
 	struct chip_data		data;
+	struct iio_channel		*channel_temp;
 
 	/* battery capacity */
 	int soc;
@@ -416,6 +418,11 @@ static int max17040_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		val->intval = chip->batt_info->charge_full_design_uah;
 		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		iio_read_channel_raw(chip->channel_temp,
+				     &val->intval);
+		val->intval *= 10;
+		break;
 	case POWER_SUPPLY_PROP_TEMP_MIN:
 		if (chip->batt_info->temp_min == INT_MIN)
 			return -ENODATA;
@@ -452,6 +459,7 @@ static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_TEMP_MIN,
 	POWER_SUPPLY_PROP_TEMP_MAX,
 };
@@ -560,9 +568,24 @@ static int max17040_probe(struct i2c_client *client)
 		}
 	}
 
+	if (of_property_read_bool(client->dev.of_node, "io-channels")) {
+		chip->channel_temp = iio_channel_get(&client->dev, "temp");
+		if (IS_ERR(chip->channel_temp))
+			return dev_err_probe(&client->dev, PTR_ERR(chip->channel_temp),
+					     "failed to get temp\n");
+	};
+
 	return 0;
 }
 
+static void max17040_remove(struct i2c_client *client)
+{
+	struct max17040_chip *chip = i2c_get_clientdata(client);
+
+	if (chip->channel_temp)
+		iio_channel_release(chip->channel_temp);
+}
+
 #ifdef CONFIG_PM_SLEEP
 
 static int max17040_suspend(struct device *dev)
@@ -642,6 +665,7 @@ static struct i2c_driver max17040_i2c_driver = {
 		.pm	= MAX17040_PM_OPS,
 	},
 	.probe_new	= max17040_probe,
+	.remove		= max17040_remove,
 	.id_table	= max17040_id,
 };
 module_i2c_driver(max17040_i2c_driver);
-- 
2.37.2

