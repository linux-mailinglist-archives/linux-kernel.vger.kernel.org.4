Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60633720407
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbjFBOLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjFBOLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:11:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DE8E48
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:10:59 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-52867360efcso1201778a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1685715058; x=1688307058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NafLjDBYefQHH3Gad7ICKC/rnUp/PXcgqV+CuJGbaps=;
        b=G7kmqJz8jCezobMbu8i6NSsiDBWE8Nu5IDJjwICyJCFL907aGO+ZpuBmM25Jc9wHxt
         5t9IsVzcivgt4rjzub87CWfsaVBo2HcHdoCiD9yFiQeRdSm+swaAc/g2qyVOZ3HV8JZS
         NNsuEJJlOitgLpuBovi8lrgqY5tD3gufcNCuRuA0SV+sLPHcY12jMlN5dAFpvYiw3UnV
         5i0XsbSwU5T4NDTM4dQD7tQaYdmlu/p4Y933wxKq0ojC89ZArNWlT3wGXMy6FhrT9SOz
         c4dTunGUi7SeU2mRS861ndMLUszrJ/Q6cvWR/lf5lLPw/rhu4tYqhSaxCLKXM+FWvuwy
         iOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685715058; x=1688307058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NafLjDBYefQHH3Gad7ICKC/rnUp/PXcgqV+CuJGbaps=;
        b=HRvepSF5mFrleqJ6aqtTgQY7F+Ucv13rs7Pc5gF+H0GrPp/0+CDyuLbGbMS+voeBMh
         EveOB1QusiI5xFKGsdyiMg0/QGnnshRqmwQs1ZRULWV8TBWHw6Y8S4D3ao4yeoamgImP
         A+mr50BcHs3W9mT+aHEvqdo5g/wdNful+bbmE39b8mom97y1VcA1J/YNXd/wKTw4+4ew
         F6aEjQfSvhs1WFoNQmeqp7Jwf6566PHlxojY8FGKZTkP2UowPQd3FfpGDsZwu//4R7Fl
         F13r05FSLlrTlkkTE/FV92k+7Zv0aLHgU7gwGMONFzRolubCpA9Dt6QHSnGjMtuwuiHO
         Q0lA==
X-Gm-Message-State: AC+VfDwfxpLc21nKL1fQHfYIsWjZVDv39qVMkoMs4DsxCsTdayLxAE1x
        HDfkVBVmofDLam45vX9Y6rjDdA==
X-Google-Smtp-Source: ACHHUZ52BrujIzK6kYeA5tQXGF1lbCqUIvbRUYtUuz8q4fWfpA/Mfde3UrbPhhQNlxYJEXzviP9IfA==
X-Received: by 2002:a17:902:a3ce:b0:1b0:34a1:9946 with SMTP id q14-20020a170902a3ce00b001b034a19946mr66110plb.46.1685715058598;
        Fri, 02 Jun 2023 07:10:58 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902d48b00b0019e60c645b1sm1370878plg.305.2023.06.02.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:10:58 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH 2/2] HID: i2c-hid: elan: Add ili9882t timing
Date:   Fri,  2 Jun 2023 22:09:48 +0800
Message-Id: <20230602140948.2138668-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602140948.2138668-1-yangcong5@huaqin.corp-partner.google.com>
References: <20230602140948.2138668-1-yangcong5@huaqin.corp-partner.google.com>
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

