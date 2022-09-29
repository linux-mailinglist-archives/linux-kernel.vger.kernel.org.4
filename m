Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2D5EF66B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 15:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiI2N0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 09:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbiI2NZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 09:25:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6F6D4AB7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:25:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n10so2169462wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=CSBZWqW7//v4iXWGEGEutgUwmaJRKtXI6U897ZX85Y0=;
        b=FujityHcptcJW88hNSbsdh3MYJ+9JzYo4Z8WUkppbZhiIavFnKQHd5m39Aze1Q98N6
         Dfx9ZRXdSbMtKHZS95hDH866k5oG8hZbmjSi7zYjk4sMQpqOteakD3lfXeZoKVvpMMMP
         0FI8AtXWrMcYLOi+yYN415Po3ygt08v2mJebQ6o2BlcAAy1ykwVfCSTkydrqb9fkO/+f
         DXS3R8w3h4FT4adRFvnPszLbo9brS8L87kFQPxolegRs+hpCsackWvAHbrYhII31sPlh
         mwZJLLcQh3toU9TiKdCDK/+KRDF9YrZDwKXgTKGFl3OsBsO4kXJzARK38rrezx5EZQYq
         n5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CSBZWqW7//v4iXWGEGEutgUwmaJRKtXI6U897ZX85Y0=;
        b=Jcw7qOFRAs19wYAU+rLYI4bGuEQ1e/TfUI/cyL2FEpS7gGni5eAPOEAhJUm/p1EhFc
         9CSev+KycwPSoXVWOcrCgaK4EYZwyjsd1zlY6xn900ObrwdWJ65AriA121Gu7Q78/Akl
         km0s5GZpH/RIgyrIZhNugCuGQdmYTXpPTuvUWQgQnQprE5+xs3otLlKSYow04WwZe1Xd
         FmB9H4/8bRBf2XHUYqutFqPqEYWIQzy79lOvgtGdKL+9USb8H/M47+aACCc/Hi8aeZt9
         /V/VhOfCw2DFgiTT+s+wVBOSUG9wYYqAAII1QGI7CnEZ82AKmb1L0y0kFfS2g/q83mmu
         pUaw==
X-Gm-Message-State: ACrzQf2C5fhtc/Ev+DnD2vmdXM1JmHpq3CuFAD7BhQuZvvUmU376wjbM
        pTjVvvkH7Su8HOd5D+f3DlqiBw==
X-Google-Smtp-Source: AMsMyM5Tx6vaz+8YppGgwEp6nvwnzjw/Y02BR7opk3EDVArYrwbjAwfgd3NRzf46j4L5JA5uP0I9pg==
X-Received: by 2002:adf:de0b:0:b0:22a:c7f7:8eb4 with SMTP id b11-20020adfde0b000000b0022ac7f78eb4mr2327705wrm.195.1664457936221;
        Thu, 29 Sep 2022 06:25:36 -0700 (PDT)
Received: from localhost.localdomain (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id bu24-20020a056000079800b00226dedf1ab7sm7032222wrb.76.2022.09.29.06.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 06:25:35 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, msp@baylibre.com,
        Jerome Neanne <jneanne@baylibre.com>
Subject: [PATCH 1/2] regulator: gpio: Add input_supply support in gpio_regulator_config
Date:   Thu, 29 Sep 2022 15:25:25 +0200
Message-Id: <20220929132526.29427-2-jneanne@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929132526.29427-1-jneanne@baylibre.com>
References: <20220929132526.29427-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is simillar as fixed-regulator.
Used to extract regulator parent from the device tree.

Without that property used, the parent regulator can be shut down (if not an always on).
Thus leading to inappropriate behavior:
On am62-SP-SK this fix is required to avoid tps65219 ldo1 (SDMMC rail) to be shut down after boot completion.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 drivers/regulator/gpio-regulator.c       | 15 +++++++++++++++
 include/linux/regulator/gpio-regulator.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 5927d4f3ea..95e61a2f43 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -220,6 +220,9 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 				 regtype);
 	}
 
+	if (of_find_property(np, "vin-supply", NULL))
+		config->input_supply = "vin";
+
 	return config;
 }
 
@@ -259,6 +262,18 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 
 	drvdata->gpiods = devm_kzalloc(dev, sizeof(struct gpio_desc *),
 				       GFP_KERNEL);
+
+	if (config->input_supply) {
+		drvdata->desc.supply_name = devm_kstrdup(&pdev->dev,
+							 config->input_supply,
+							 GFP_KERNEL);
+		if (!drvdata->desc.supply_name) {
+			dev_err(&pdev->dev,
+				"Failed to allocate input supply\n");
+			return -ENOMEM;
+		}
+	}
+
 	if (!drvdata->gpiods)
 		return -ENOMEM;
 	for (i = 0; i < config->ngpios; i++) {
diff --git a/include/linux/regulator/gpio-regulator.h b/include/linux/regulator/gpio-regulator.h
index fdeb312cda..c223e50ff9 100644
--- a/include/linux/regulator/gpio-regulator.h
+++ b/include/linux/regulator/gpio-regulator.h
@@ -42,6 +42,7 @@ struct gpio_regulator_state {
 /**
  * struct gpio_regulator_config - config structure
  * @supply_name:	Name of the regulator supply
+ * @input_supply:	Name of the input regulator supply
  * @enabled_at_boot:	Whether regulator has been enabled at
  *			boot or not. 1 = Yes, 0 = No
  *			This is used to keep the regulator at
@@ -62,6 +63,7 @@ struct gpio_regulator_state {
  */
 struct gpio_regulator_config {
 	const char *supply_name;
+	const char *input_supply;
 
 	unsigned enabled_at_boot:1;
 	unsigned startup_delay;
-- 
2.17.1

