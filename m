Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD10D6B031F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCHJkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCHJko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:40:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB28B1B15;
        Wed,  8 Mar 2023 01:40:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j11so43650413edq.4;
        Wed, 08 Mar 2023 01:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678268438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7A7ncxskY+Crxu5hf4wRrmUlrJ73jGGH1lawChBwQk=;
        b=O3LGEKkH6fFEw+/snzPC4P8/QhOhtUN5oxoQjgXnsPfjvU2V3SJvvUUsymPK2zQ3QL
         PA4jzopDlVRSQg7O0UyU6eTrZC0nzWfpZncJ0PSzVjo6phyIRdOK8fS2qLdylSM5jq38
         v+jAHuk2a3kd74oocwONf3birziI0N7+Nj7UgNZm3HvRZununWwq5M81arPhdNh56UoI
         SDzQAzJ9tbC7bzY/j3mO8FuylJO371JEBDc4JNY+w9QJKSpBLQCoIkthZe+vtuOTzIQL
         Qlnmuynk8qWAZ1MK9GrglFmFX3uu6Q1rRy4WKNYrcL27ssyj0gctg4+DbHkNEx85ITJ9
         JUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678268438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7A7ncxskY+Crxu5hf4wRrmUlrJ73jGGH1lawChBwQk=;
        b=nAAvY+06QllyixNVmXwLd1h2AD4NM9CXPMygW35GF6gElU/oA3yD892FccxpNmgmpo
         I1jeYj3QjulyVP9HoQG//dE5wGpPYgWifrKzvD2jal1iSwM2jSTcDyyAkqtJDPsASwen
         E7E2wtnUeQI57AidK7zFLD+ZtCLKS6iVkbOlKnDCMGHzw1iInlR5+yHJOizOcG/4IP0t
         X1sx6+kB3rS3czAtFpL96QzU/huvyQNglunfTHYgUUkJHJGr7tFZno/+qwN6kOAbrUEO
         igZHq30TGMO2OOl3ImbsYiEmR4axH50rkZvXxaMsfAcTC//fO0lI2+E8EQT+fH70Jd78
         figw==
X-Gm-Message-State: AO0yUKXog6l5ObNCBjcKcBKK70opnuqzYizdgltrW+Wr/fSxxXPbSeL5
        wnLS1GPv9bq1hqTjHdCYOcs=
X-Google-Smtp-Source: AK7set+KZo+Cgej4nkrBm9aGQui0knAXbD7KZNW9pqTEFypofl8sVJ/oIO9ykXm2dbdaq7u2NWpUxg==
X-Received: by 2002:aa7:d60b:0:b0:4bd:94b9:b8a8 with SMTP id c11-20020aa7d60b000000b004bd94b9b8a8mr14864191edr.26.1678268438466;
        Wed, 08 Mar 2023 01:40:38 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id h17-20020a17090634d100b008ee5356801dsm7240014ejb.187.2023.03.08.01.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:40:38 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] hwmon: ina2xx: add optional regulator support
Date:   Wed,  8 Mar 2023 11:40:24 +0200
Message-Id: <20230308094024.14115-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308094024.14115-1-clamor95@gmail.com>
References: <20230308094024.14115-1-clamor95@gmail.com>
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

Some devices may need a specific supply provided
for this sensor to work properly, like p895 does.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/hwmon/ina2xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 00fc70305a89..4a3e2b1bbe8b 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -119,6 +119,7 @@ struct ina2xx_data {
 	long power_lsb_uW;
 	struct mutex config_lock;
 	struct regmap *regmap;
+	struct regulator *vdd_supply;
 
 	const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
 };
@@ -656,6 +657,17 @@ static int ina2xx_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 	}
 
+	data->vdd_supply = devm_regulator_get_optional(dev, "vdd");
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
+				     "failed to get vdd regulator\n");
+
+	ret = regulator_enable(data->vdd_supply);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable vdd power supply\n");
+		return ret;
+	}
+
 	ret = ina2xx_init(data);
 	if (ret < 0) {
 		dev_err(dev, "error configuring the device: %d\n", ret);
-- 
2.37.2

