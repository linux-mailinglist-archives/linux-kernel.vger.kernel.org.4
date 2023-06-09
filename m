Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90DE729004
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbjFIGgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbjFIGgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:36:46 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37376271D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:36:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53482b44007so339950a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1686292601; x=1688884601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOfDaLrOZlpldUp3/P9HpXZktMDt/X5VfdiAMTIut08=;
        b=S8m7ykoqarbGu1wy8n2x38S8/Y5WEDUzdObdhCnwOVaJZ/iHzyowv7BojphhxUrw0Z
         eOgXo2A4DhKhspDerq8GXAsWAlf94ajXm4NUzGV9AP5jb0TULc9lgR0O50xvmXWPSmn0
         zKbsqe89Ojiy4KopKLLA/odV+BfJ/Ct6+aCYCFNg1+PRZDBK2JtINwhpHr47cGqyIaDZ
         ggHE500Y3mUCxEpJAqMJvW3bU5Edt7A5JavHaocgT77CLVHjIhuPyZ1zcxQtKOzh1R84
         OSNP6+0Jo3rDk9SIMR2UlU2qtL/yzw/YCHwhECN82ROriqfQsGG9h8tYRkJo0jeNd3Em
         RBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686292601; x=1688884601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOfDaLrOZlpldUp3/P9HpXZktMDt/X5VfdiAMTIut08=;
        b=OFzE7XSS36BSd8jMsJiY+CmoxZ7aZw7VZU0Pbe8EotONVpDrLQfIZCxgOUsV1nnCDC
         l8dXSb+64aqbcb7Qaedr3hy/JjZOYTPCg4MYBNLX7m41VxNOx9ZCxWRP96lAckxRT4Mm
         0WRzgeaB4uUnQrg9Q4pkN54zs5OY2eF2WH2FpYMh8mh7nLrb/4wMD90Wikc4dGNUS7Ox
         9GmT5JESTlxI2vk8aw3MIye9qa0NPRcZXDUFjt4qWkzMOqD0ORa+PwXcFaupUTaku+Bt
         O/61LHMhT4Z+DypKuR3bFVWhAnn6ow5+QC0n2ecDh/4Hc7UqNthYIK0sHGHeC9bPd1mT
         J5tQ==
X-Gm-Message-State: AC+VfDxsDvmCzbHuzn4kZ8BVDIzOIvGCwbtAE1Lk67D41S+5/wult1NH
        B1/Spr15bU5NeFloOFfWDTE1UQ==
X-Google-Smtp-Source: ACHHUZ6EkrmaOYmKhshdJT0Kx5qOo4WPN2JO2PMeex/u+c9aZg3SQqKBnckbl0TsSoXwY5g2Q/rWCQ==
X-Received: by 2002:a17:90a:8988:b0:259:bf40:b581 with SMTP id v8-20020a17090a898800b00259bf40b581mr305362pjn.37.1686292601674;
        Thu, 08 Jun 2023 23:36:41 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b211283294sm2445709plg.163.2023.06.08.23.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 23:36:41 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v5 2/2] HID: i2c-hid: elan: Add ili9882t timing
Date:   Fri,  9 Jun 2023 14:36:15 +0800
Message-Id: <20230609063615.758676-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609063615.758676-1-yangcong5@huaqin.corp-partner.google.com>
References: <20230609063615.758676-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ili9882t is a TDDI IC (Touch with Display Driver). The
datasheet specifies there should be 60ms between touch SDA
sleep and panel RESX. Doug's series[1] allows panels and
touchscreens to power on/off together, so we can add the 65 ms
delay in i2c_hid_core_suspend before panel_unprepare.

Because ili9882t touchscrgeen is a panel follower, and
needs to use vccio-supply instead of vcc33-supply, so set
it NULL to ili9882t_chip_data, then not use vcc33 regulator.

[1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium.org

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 50 ++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 76ddc8be1cbb..5e52027ab60a 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -18,9 +18,11 @@
 #include "i2c-hid.h"
 
 struct elan_i2c_hid_chip_data {
-	unsigned int post_gpio_reset_delay_ms;
+	unsigned int post_gpio_reset_on_delay_ms;
+	unsigned int post_gpio_reset_off_delay_ms;
 	unsigned int post_power_delay_ms;
 	u16 hid_descriptor_address;
+	const char *main_supply_name;
 };
 
 struct i2c_hid_of_elan {
@@ -38,9 +40,11 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *ops)
 		container_of(ops, struct i2c_hid_of_elan, ops);
 	int ret;
 
-	ret = regulator_enable(ihid_elan->vcc33);
-	if (ret)
-		return ret;
+	if (ihid_elan->vcc33) {
+		ret = regulator_enable(ihid_elan->vcc33);
+		if (ret)
+			return ret;
+	}
 
 	ret = regulator_enable(ihid_elan->vccio);
 	if (ret) {
@@ -52,8 +56,8 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *ops)
 		msleep(ihid_elan->chip_data->post_power_delay_ms);
 
 	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
-	if (ihid_elan->chip_data->post_gpio_reset_delay_ms)
-		msleep(ihid_elan->chip_data->post_gpio_reset_delay_ms);
+	if (ihid_elan->chip_data->post_gpio_reset_on_delay_ms)
+		msleep(ihid_elan->chip_data->post_gpio_reset_on_delay_ms);
 
 	return 0;
 }
@@ -64,8 +68,12 @@ static void elan_i2c_hid_power_down(struct i2chid_ops *ops)
 		container_of(ops, struct i2c_hid_of_elan, ops);
 
 	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
+	if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
+		msleep(ihid_elan->chip_data->post_gpio_reset_off_delay_ms);
+
 	regulator_disable(ihid_elan->vccio);
-	regulator_disable(ihid_elan->vcc33);
+	if (ihid_elan->vcc33)
+		regulator_disable(ihid_elan->vcc33);
 }
 
 static int i2c_hid_of_elan_probe(struct i2c_client *client)
@@ -89,24 +97,42 @@ static int i2c_hid_of_elan_probe(struct i2c_client *client)
 	if (IS_ERR(ihid_elan->vccio))
 		return PTR_ERR(ihid_elan->vccio);
 
-	ihid_elan->vcc33 = devm_regulator_get(&client->dev, "vcc33");
-	if (IS_ERR(ihid_elan->vcc33))
-		return PTR_ERR(ihid_elan->vcc33);
-
 	ihid_elan->chip_data = device_get_match_data(&client->dev);
 
+	if (ihid_elan->chip_data->main_supply_name) {
+		ihid_elan->vcc33 = devm_regulator_get(&client->dev,
+						      ihid_elan->chip_data->main_supply_name);
+		if (IS_ERR(ihid_elan->vcc33))
+			return PTR_ERR(ihid_elan->vcc33);
+	}
+
 	return i2c_hid_core_probe(client, &ihid_elan->ops,
 				  ihid_elan->chip_data->hid_descriptor_address, 0);
 }
 
 static const struct elan_i2c_hid_chip_data elan_ekth6915_chip_data = {
 	.post_power_delay_ms = 1,
-	.post_gpio_reset_delay_ms = 300,
+	.post_gpio_reset_on_delay_ms = 300,
+	.hid_descriptor_address = 0x0001,
+	.main_supply_name = "vcc33",
+};
+
+static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data = {
+	.post_power_delay_ms = 1,
+	.post_gpio_reset_on_delay_ms = 200,
+	.post_gpio_reset_off_delay_ms = 65,
 	.hid_descriptor_address = 0x0001,
+	/*
+	 * this touchscreen is tightly integrated with the panel and assumes
+	 * that the relevant power rails (other than the IO rail) have already
+	 * been turned on by the panel driver because we're a panel follower.
+	 */
+	.main_supply_name = NULL,
 };
 
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
+	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);
-- 
2.25.1

