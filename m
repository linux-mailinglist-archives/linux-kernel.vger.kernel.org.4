Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1D6FDD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbjEJLwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbjEJLvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:51:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEEE30F7;
        Wed, 10 May 2023 04:51:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso5541625e9.1;
        Wed, 10 May 2023 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683719507; x=1686311507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWpn+xWGvtGBH62qOXih/XCmqiF9B5PS3ayiTGHqtfM=;
        b=gekOZaVLpelaVYbt9IyjFaRxlz5FQFgaGlMVTj/7zDxb2YrKvCLzmkhTEpMchNxv99
         ytxazcVcCjcj42EfrsXjY6CYzfU2IuZuk9EW//rjl3+eon/safD/n78VHsaJ/2b+XqIm
         0s+VLWBkjSAzOCFpibmRECeCNR7PRUBH0TdR3Q9GH1p/20oEId/FH5KaBG1wRa5Iol9b
         dGEtECf9Sa1LJJA5d3svN9bpOwjQC9oZsLP2+vu9ZimL5VdwP4DcSk85j1NvX++BGK1B
         ru9NJQhEGnXYT4UwbOY8bIiPT9AmNCU/B1lEDFmTrK/mHD539LuSkpSo7tzKyfqg7i0Y
         kpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683719507; x=1686311507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWpn+xWGvtGBH62qOXih/XCmqiF9B5PS3ayiTGHqtfM=;
        b=IvZItMTHRDTOBI93/zJta5brpKBXFfoqELANBbS9bYUhVXbrQfoq/DdkUwd8WJ8wFf
         w/MG7zXbdhv+rmPWQ+FIRQif9Qu1VNOcwU48jRS6Men41IR8nRpu77T1HPN5zEDUNaMY
         cNPxXqbD2EMSGlbLfvDVewwDv6tzNqULJZyg5dvBTwqIioLcGqHsHJ5drArPJKIBm5uy
         Zk1J44gePLpN5H/08SY1hkQB2muoOy8NmuMFg5Acv4Io0Y6Lz6j8zRQfEScxJ/ZASMcn
         s1YXtNRtTCc1qdKeqmmGUU68F0Dvw96ecPgFlzTemFT/g6y5lUcZVv8PS1YNr0T4NOaw
         Rd0Q==
X-Gm-Message-State: AC+VfDz+1cxI+yl2Ii0XTeamSQr6pq50/KKJ6E2Hg0hkbAB2goiW9YCE
        H6iLPJgZVwfQQy9Un92vAPY=
X-Google-Smtp-Source: ACHHUZ5dF78IAovq4b7TJiIdk6ERvCzQos59Su2Y5a5MupK8sYzOzfsUX3kzqt2u9uMLzrbXi4OM2g==
X-Received: by 2002:a05:600c:c5:b0:3f4:2610:5cd0 with SMTP id u5-20020a05600c00c500b003f426105cd0mr6362397wmm.7.1683719506527;
        Wed, 10 May 2023 04:51:46 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003f4b6bcbd8bsm1285113wmi.31.2023.05.10.04.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:51:46 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] power: supply: axp20x_usb_power: Use regmap fields for USB BC feature
Date:   Wed, 10 May 2023 12:50:42 +0100
Message-Id: <20230510115046.963432-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
References: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of variant IDs with a regmap field, to reduce
dependence on variant IDs.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index b2049b7d95fe..20a76c19cfad 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -41,8 +41,6 @@
 #define AXP20X_ADC_EN1_VBUS_CURR	BIT(2)
 #define AXP20X_ADC_EN1_VBUS_VOLT	BIT(3)
 
-#define AXP813_BC_EN		BIT(0)
-
 /*
  * Note do not raise the debounce time, we must report Vusb high within
  * 100ms otherwise we get Vbus errors in musb.
@@ -58,6 +56,7 @@ struct axp_data {
 	struct reg_field		curr_lim_fld;
 	struct reg_field		vbus_valid_bit;
 	struct reg_field		vbus_mon_bit;
+	struct reg_field		usb_bc_en_bit;
 };
 
 struct axp20x_usb_power {
@@ -65,6 +64,7 @@ struct axp20x_usb_power {
 	struct regmap_field *curr_lim_fld;
 	struct regmap_field *vbus_valid_bit;
 	struct regmap_field *vbus_mon_bit;
+	struct regmap_field *usb_bc_en_bit;
 	struct power_supply *supply;
 	enum axp20x_variants axp20x_id;
 	const struct axp_data *axp_data;
@@ -433,6 +433,7 @@ static const struct axp_data axp813_data = {
 	.axp20x_id	= AXP813_ID,
 	.curr_lim_table = axp813_usb_curr_lim_table,
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
+	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -572,6 +573,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
+						 axp_data->usb_bc_en_bit,
+						 &power->usb_bc_en_bit);
+	if (ret)
+		return ret;
+
 	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
 					   axp20x_usb_power_poll_vbus);
 	if (ret)
@@ -592,10 +599,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	if (power->axp20x_id == AXP813_ID) {
+	if (power->usb_bc_en_bit) {
 		/* Enable USB Battery Charging specification detection */
-		ret = regmap_update_bits(axp20x->regmap, AXP288_BC_GLOBAL,
-				   AXP813_BC_EN, AXP813_BC_EN);
+		ret = regmap_field_write(power->usb_bc_en_bit, 1);
 		if (ret)
 			return ret;
 	}
-- 
2.39.2

