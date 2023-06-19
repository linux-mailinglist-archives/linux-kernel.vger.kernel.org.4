Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C2873593F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjFSONT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFSONQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:13:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED0599
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:13:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51a2c8e5a2cso5023094a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1687183992; x=1689775992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZZvuUg/XJppy1RQPzIvzHMS06C+pQD8xRtk2Ai4foU=;
        b=NzscS+z2Afd9uBqEqkAty/34jFNErBTkXTRKILnq/lKMpEqiZbRbWzWVArRQJQqj56
         SRmVzl84OC9RaUWQaUC9/NmY9QhHVkue5RGZNwtIHglAR7SDY2CEl1fGL3DyGSx9Khbi
         plEhh5etCtzE9e4LLmRUykkqB2NTEd9TdVByizZbvak7sIDlnuLL5fwlTMDOsmerKOIh
         Hi6Jqjb2qtPQSPZfg8W+ZaLBJvGJ7+77hfwtQUPegXtGhyIfHaa6t27MugkPR1j28ixD
         2Sy1IdhonaqvuFbnE99ON0SQlXojXihSnWa28PA7CNxj4wR5YE9UzjFQC5EiZLo425HB
         ckEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687183992; x=1689775992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZZvuUg/XJppy1RQPzIvzHMS06C+pQD8xRtk2Ai4foU=;
        b=iamf/Rc7Q/DbsbewHGCd3Th7I4+ULcw9x/sR5RwA3itQgEZJsS9++BWcwrlTnAutJ6
         fhs53cXxsozkSWJzTs/EbYmS6GvcOkqzOD/Jjzjh1nlkqGiKJQXpzuQipPv2PjdSbzZT
         98xIYWcgr88gpj/QU+4jOS+C3Pe8xXg/AYxQwn94QKQFQUKVLU+cj7Pq6w00oJlSEid3
         Sh64Rj2ePf4P11Ln9NXJb/JMFoxnWSf616L0xxqputBkHtTnygOm4xunuSKHQjMqfsSK
         /6v7mHU1B8PM+VURzzmeL6xX+TU370jeZYL68669HVYRFnBmNt+k5akiabHwUzOOakvC
         K37w==
X-Gm-Message-State: AC+VfDxhQ25g/HSddkL2e64bvuYmYd4aVYImP8vXjgT+mJiuZdqXPI9a
        EM9rLOireKC6yX4ok3etztFbFq7g0DNN6oGEexM=
X-Google-Smtp-Source: ACHHUZ5cAAjNf4xsxv8uDi3DvjzpJ43DHxy310s4QeIFunCXApaRQRFdekzGFVZP+e7+2P0C9IUBfA==
X-Received: by 2002:a05:6402:545:b0:51a:5abc:668d with SMTP id i5-20020a056402054500b0051a5abc668dmr1987364edx.3.1687183992326;
        Mon, 19 Jun 2023 07:13:12 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id m1-20020aa7d341000000b0051a44a5636asm2788489edr.44.2023.06.19.07.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:13:12 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marc Titinger <mtitinger@baylibre.com>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ina2xx: avoid NULL pointer dereference on OF device match
Date:   Mon, 19 Jun 2023 16:12:39 +0200
Message-Id: <20230619141239.2257392-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The affected lines were resulting in a NULL pointer dereference on our
platform because the device tree contained the following list of
compatible strings:

    power-sensor@40 {
        compatible = "ti,ina232", "ti,ina231";
        ...
    };

Since the driver doesn't declare a compatible string "ti,ina232", the OF
matching succeeds on "ti,ina231". But the I2C device ID info is
populated via the first compatible string, cf. modalias population in
of_i2c_get_board_info(). Since there is no "ina232" entry in the legacy
I2C device ID table either, the struct i2c_device_id *id pointer in the
probe function is NULL.

Fix this by using the already populated type variable instead, which
points to the proper driver data. Since the name is also wanted, add a
generic one to the ina2xx_config table.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Fixes: c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monitors")
---
 drivers/iio/adc/ina2xx-adc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 213526c1592f..aea83f369437 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -124,6 +124,7 @@ static const struct regmap_config ina2xx_regmap_config = {
 enum ina2xx_ids { ina219, ina226 };
 
 struct ina2xx_config {
+	const char *name;
 	u16 config_default;
 	int calibration_value;
 	int shunt_voltage_lsb;	/* nV */
@@ -155,6 +156,7 @@ struct ina2xx_chip_info {
 
 static const struct ina2xx_config ina2xx_config[] = {
 	[ina219] = {
+		.name = "ina219",
 		.config_default = INA219_CONFIG_DEFAULT,
 		.calibration_value = 4096,
 		.shunt_voltage_lsb = 10000,
@@ -164,6 +166,7 @@ static const struct ina2xx_config ina2xx_config[] = {
 		.chip_id = ina219,
 	},
 	[ina226] = {
+		.name = "ina226",
 		.config_default = INA226_CONFIG_DEFAULT,
 		.calibration_value = 2048,
 		.shunt_voltage_lsb = 2500,
@@ -996,7 +999,7 @@ static int ina2xx_probe(struct i2c_client *client)
 	/* Patch the current config register with default. */
 	val = chip->config->config_default;
 
-	if (id->driver_data == ina226) {
+	if (type == ina226) {
 		ina226_set_average(chip, INA226_DEFAULT_AVG, &val);
 		ina226_set_int_time_vbus(chip, INA226_DEFAULT_IT, &val);
 		ina226_set_int_time_vshunt(chip, INA226_DEFAULT_IT, &val);
@@ -1015,7 +1018,7 @@ static int ina2xx_probe(struct i2c_client *client)
 	}
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (id->driver_data == ina226) {
+	if (type == ina226) {
 		indio_dev->channels = ina226_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ina226_channels);
 		indio_dev->info = &ina226_info;
@@ -1024,7 +1027,7 @@ static int ina2xx_probe(struct i2c_client *client)
 		indio_dev->num_channels = ARRAY_SIZE(ina219_channels);
 		indio_dev->info = &ina219_info;
 	}
-	indio_dev->name = id->name;
+	indio_dev->name = id ? id->name : chip->config->name;
 
 	ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
 					  &ina2xx_setup_ops);
-- 
2.40.0

