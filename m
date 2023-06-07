Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9169F726166
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbjFGNfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240878AbjFGNfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:35:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8221FD7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:35:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b1806264e9so38344715ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1686144926; x=1688736926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKwUqHo5Vcp6qEMOdr+qgbBliBp4lX8cCeTzjjNJbpw=;
        b=vDexOXu2iIzDnbzJeHisiv80zH3JeZTpzRW3zRFkaQhe/QD9qIDmnUrEREOvWE2T3s
         TLVOMm1jlZK0nVBbYQ7wZVGj/pUa2TgmCYFpCboteWPAPQxpjrycjRxm3vQaQ/Y8dkcB
         mTO6G111vPXh+lNvDB7z7ZhGtwzUC/e8Q06nIhiW8Sqg0D5EsZg9s9xQNlxcg1CO+wck
         OU3hr92/PINnL1N/kcM9wGd0KwJ7m8TeYfOA6rYlCRH7ey8R/FwUzoJlFDMb8vK02g0I
         09VIvog7Cw1ZiXT2T0Pvekq25iSaSiktEz0D22am7pfPyAFHSUGDluChWauQd2glW+WX
         CbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144926; x=1688736926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKwUqHo5Vcp6qEMOdr+qgbBliBp4lX8cCeTzjjNJbpw=;
        b=lHsLjlDp1NUC48MdEXQL1i8vWFTOh7KE/0Pbr6+Fmy8pkfuN6PaOGMpI2ermJb5N3G
         BWh7qGPkxfjbrf5V4CQA7fJ0DBHvDPvOgmW+WU7GXnp2O/R3RGSNkJAcf303IYIJ3TvJ
         ETqFcu0VTm79JyyL1S8/1l8aCQiV1nmHOQQKmsqERJRYKbmLoe8X6eWGFv1gXi08woip
         jWkik5/2D7dDd83VqUl2oK3VKtKRyyLffI/LTzqUfE8uVfIJiS4xuxPvhOzTwPtir87j
         mVsw2H+nMj8A/y9nBxX3+E6DZBwB4KVUQnY837nvzDiRLQzyyijT9givgFTfYnLryB3l
         C1lg==
X-Gm-Message-State: AC+VfDwluHOYwmlKI6OOs85TqxrIbHxc0m6ONzGlgwJyc7jioP7CI88i
        z2Qo8tv5pMds6/4a9foR7LRk2w==
X-Google-Smtp-Source: ACHHUZ4cx6vLE/wpixupF2+hfTcl4jtltVB8iMsN060sd7EriDE/221A7qPMluKKOsGTqKO0I8kKyw==
X-Received: by 2002:a17:902:9888:b0:1af:ffda:855a with SMTP id s8-20020a170902988800b001afffda855amr2195158plp.9.1686144926260;
        Wed, 07 Jun 2023 06:35:26 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b001b034faf49csm10405680plb.285.2023.06.07.06.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:35:25 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v3 2/2] HID: i2c-hid: elan: Add ili9882t timing
Date:   Wed,  7 Jun 2023 21:34:58 +0800
Message-Id: <20230607133458.4075667-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607133458.4075667-1-yangcong5@huaqin.corp-partner.google.com>
References: <20230607133458.4075667-1-yangcong5@huaqin.corp-partner.google.com>
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

