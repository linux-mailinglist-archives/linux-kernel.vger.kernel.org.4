Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49221721DD8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjFEGGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFEGGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:06:01 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74935DE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:05:58 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-392116b8f31so2236810b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1685945157; x=1688537157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NafLjDBYefQHH3Gad7ICKC/rnUp/PXcgqV+CuJGbaps=;
        b=bYsw33Yw4q4Fc/XuiRKnniS7T8cCWejB2X4rnmMacWbnQjwtHSD+hZEmOfKjZAMOx5
         hyvg8ajElijvJS6m5SfIRPij/V1L5CST6egio3Pu0zUENUTSz73yEDu1Kd867+/13hmx
         +tXd35KwbsoMhYDglfK6RapqEwvTRRfd7WHtPDrB79Y4Y+3dqidngVBOfEzKdD1UpMxu
         IEh3SG9tdY9qT8Dj7AyFUmIqxTIBBVtunj2FD1TKVeKKjnLe0sZDxVEiXwvX1wwVqJP+
         MAF5/FQSekHxg75ZAKwbSNPwCis35hwaiWAmI03FwKZyssxnnhMCZ10hR2ZBoo/yOO5H
         hOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685945157; x=1688537157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NafLjDBYefQHH3Gad7ICKC/rnUp/PXcgqV+CuJGbaps=;
        b=H/LDN1ZzqwPp9I20Ar5DhcRFeO7UbtCPWxXRwTEGTNV6nGMfEanMCIsa1EDyahXBj3
         tqD8MkCobWEKSMpS7naoZOfWd64J2YdsmVk4qpKh5JPQDdA2pRyMHUandeWAM0QnIhiP
         wLlrBFacl5iKElucyVFTeyE5tiPEvJKKUrip5XCsoFkLWqZqqOaVcwHYb+K2WskvsNL0
         SyLE3mLIhuS8zn6fepV74wCI0W+k1UJbRgeS1pbCgvw8raFiUa8i3JwOPqcRUNeQX0qZ
         SiOjAe8j1MNu5OqyG7vFdG98kzzkfk4r6jDm5oKxU+tfJc9g3F/JuElfIKXSRwM81CFt
         iTQw==
X-Gm-Message-State: AC+VfDzGLFif1d8csKMb2P0OYkwbdSKTcrqjVt8Hu4eb/7FTzNEb1CtY
        ab8exB5jlBY9cIAS5/SttTi34g==
X-Google-Smtp-Source: ACHHUZ55zMj/HVRzMaN8WfmCHJjg81JjjNRWwiQ6+/v8ENDHdZY37NOWgrcJ0d+tJm9E5tWpNAkGHA==
X-Received: by 2002:a05:6358:e91d:b0:129:c4a6:8892 with SMTP id gk29-20020a056358e91d00b00129c4a68892mr638202rwb.17.1685945157177;
        Sun, 04 Jun 2023 23:05:57 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id 128-20020a630786000000b0053ba104c113sm5031379pgh.72.2023.06.04.23.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 23:05:56 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v2 2/2] HID: i2c-hid: elan: Add ili9882t timing
Date:   Mon,  5 Jun 2023 14:05:24 +0800
Message-Id: <20230605060524.1178164-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
References: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
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

The ili9882t is a TDDI IC (Touch with Display Driver). The datasheet
specifies there should be 60ms between touch SDA sleep and panel RESX.
Doug's series[1] allows panels and touchscreens to power on/off together,
so we can add the 65 ms delay in i2c_hid_core_suspend before panel_unprepare.

[1]: https: //lore.kernel.org/all/20230523193017.4109557-1-dianders@chromium.org/

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 76ddc8be1cbb..411d7ea2725d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -18,7 +18,8 @@
 #include "i2c-hid.h"
 
 struct elan_i2c_hid_chip_data {
-	unsigned int post_gpio_reset_delay_ms;
+	unsigned int post_gpio_reset_on_delay_ms;
+	unsigned int post_gpio_reset_off_delay_ms;
 	unsigned int post_power_delay_ms;
 	u16 hid_descriptor_address;
 };
@@ -52,8 +53,8 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *ops)
 		msleep(ihid_elan->chip_data->post_power_delay_ms);
 
 	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
-	if (ihid_elan->chip_data->post_gpio_reset_delay_ms)
-		msleep(ihid_elan->chip_data->post_gpio_reset_delay_ms);
+	if (ihid_elan->chip_data->post_gpio_reset_on_delay_ms)
+		msleep(ihid_elan->chip_data->post_gpio_reset_on_delay_ms);
 
 	return 0;
 }
@@ -64,6 +65,9 @@ static void elan_i2c_hid_power_down(struct i2chid_ops *ops)
 		container_of(ops, struct i2c_hid_of_elan, ops);
 
 	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
+	if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
+		msleep(ihid_elan->chip_data->post_gpio_reset_off_delay_ms);
+
 	regulator_disable(ihid_elan->vccio);
 	regulator_disable(ihid_elan->vcc33);
 }
@@ -101,12 +105,20 @@ static int i2c_hid_of_elan_probe(struct i2c_client *client)
 
 static const struct elan_i2c_hid_chip_data elan_ekth6915_chip_data = {
 	.post_power_delay_ms = 1,
-	.post_gpio_reset_delay_ms = 300,
+	.post_gpio_reset_on_delay_ms = 300,
+	.hid_descriptor_address = 0x0001,
+};
+
+static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data = {
+	.post_power_delay_ms = 1,
+	.post_gpio_reset_on_delay_ms = 200,
+	.post_gpio_reset_off_delay_ms = 65,
 	.hid_descriptor_address = 0x0001,
 };
 
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
+	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);
-- 
2.25.1

