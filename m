Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C227280D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbjFHNCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjFHNCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:02:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843451BCE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:02:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6549df4321aso480656b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 06:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1686229330; x=1688821330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr7qFKla7ah6JbnEELuOA7uWn8ojmtA0e2WLzBHM1Do=;
        b=SyBSCPHikj8dMbiuAtY5QTeMPExmSxmHARZuvnR3p3D9EP+kTpT5fGCB0WrXgYrSr1
         iwGCJsfBkp/X4JCYrA5YBl38hoigm2BTjdcl4Dj7pjhAlJJ/UrT+sqXz9CxXreY5oyvv
         priIRTGQ739eTZAwzxa1kd/t1ouWI9fBCem75lJd85hmQluOFevbWa+U+H/68wcse0wC
         y5Bj+rxP8QCn3aNUw55v/9wmLLiBbKdq32Tf0jnQyEU/l+XgFMxm2tVzMWNIAqYpH4U+
         zegFgq77c7qGukiMxQQcwNKLLHm9aVNTE3pIEc+nlV7WC6X2JbR4PBJK539gKxQ9DUO5
         lPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686229330; x=1688821330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rr7qFKla7ah6JbnEELuOA7uWn8ojmtA0e2WLzBHM1Do=;
        b=i+SvBLLJCdnGjxPziiaTkzE7VhnlJzhTmQ85/zXz+txSCy8OBhkc7OrkxfdndBSU04
         dPvGVXMaoPx9MUQvmGiRcDX9g/z4qItuTiVZ+sRvJgZ16eypUQueD/wrpyPfZgPrknUE
         gbyMmx9P7ViIUs2Hb47w4HVGlAtBRQ/sIxAnz1+Doh5RDg2u3oprGL7eP5GDbNLa0W5k
         K3qx6vyRc1DNOGc3/H2c0h3IN1VJSnMh1A5bYTkpYKhp6Jy4ksM9btTFsK9gzJxmOCEV
         A46W9RHs7EP1PcWzAZzvOLtX8Nsm8LbUUVEOvbXqwqMWqDRoA0UNCbcKZ6gVA7ZOkQxg
         vbgg==
X-Gm-Message-State: AC+VfDxUEgPXKg+E19J/UEJsgigk10d1Hoq/impx9FzibWHZuUs+2fV+
        5ucvlzDmJbQ2GEaSo99dqRU322LM1rj40Mq3mTM=
X-Google-Smtp-Source: ACHHUZ69hMnJYjVL4lhiAv1kB3A2hivI5Bf8vWLWCsJPoBF0ymRcowxCGaxUHg3tJs/AR7UX8baE8A==
X-Received: by 2002:a05:6a00:2d09:b0:658:8eae:a8de with SMTP id fa9-20020a056a002d0900b006588eaea8demr10426297pfb.4.1686229329266;
        Thu, 08 Jun 2023 06:02:09 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id g12-20020a62e30c000000b0065438394fa4sm1111371pfh.90.2023.06.08.06.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:02:08 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v4 2/2] HID: i2c-hid: elan: Add ili9882t timing
Date:   Thu,  8 Jun 2023 21:01:47 +0800
Message-Id: <20230608130147.2835818-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608130147.2835818-1-yangcong5@huaqin.corp-partner.google.com>
References: <20230608130147.2835818-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Beacuse ilitek9882 touchscrgeen is a panel follower, and
needs to use vccio-supply instead of vcc33-supply, so set
it "null" to ili9882t_chip_data, then using dummy regulator.

[1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium.org

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 33 +++++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 76ddc8be1cbb..40e6b8ebe8d1 100644
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
@@ -52,8 +54,8 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *ops)
 		msleep(ihid_elan->chip_data->post_power_delay_ms);
 
 	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
-	if (ihid_elan->chip_data->post_gpio_reset_delay_ms)
-		msleep(ihid_elan->chip_data->post_gpio_reset_delay_ms);
+	if (ihid_elan->chip_data->post_gpio_reset_on_delay_ms)
+		msleep(ihid_elan->chip_data->post_gpio_reset_on_delay_ms);
 
 	return 0;
 }
@@ -64,6 +66,9 @@ static void elan_i2c_hid_power_down(struct i2chid_ops *ops)
 		container_of(ops, struct i2c_hid_of_elan, ops);
 
 	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
+	if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
+		msleep(ihid_elan->chip_data->post_gpio_reset_off_delay_ms);
+
 	regulator_disable(ihid_elan->vccio);
 	regulator_disable(ihid_elan->vcc33);
 }
@@ -89,24 +94,38 @@ static int i2c_hid_of_elan_probe(struct i2c_client *client)
 	if (IS_ERR(ihid_elan->vccio))
 		return PTR_ERR(ihid_elan->vccio);
 
-	ihid_elan->vcc33 = devm_regulator_get(&client->dev, "vcc33");
+	ihid_elan->chip_data = device_get_match_data(&client->dev);
+
+	ihid_elan->vcc33 = devm_regulator_get(&client->dev, ihid_elan->chip_data->main_supply_name);
 	if (IS_ERR(ihid_elan->vcc33))
 		return PTR_ERR(ihid_elan->vcc33);
 
-	ihid_elan->chip_data = device_get_match_data(&client->dev);
-
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
+	/* this touchscreen is tightly integrated with the panel and assumes
+	 * that the relevant power rails (other than the IO rail) have already
+	 * been turned on by the panel driver because we're a panel follower.
+	 */
+	.main_supply_name = "null",
 };
 
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
+	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);
-- 
2.25.1

