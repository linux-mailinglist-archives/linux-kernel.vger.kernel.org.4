Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E114569BBEF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBRUuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBRUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:49:57 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB7C1420D;
        Sat, 18 Feb 2023 12:49:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j27so1052671wms.3;
        Sat, 18 Feb 2023 12:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWpn+xWGvtGBH62qOXih/XCmqiF9B5PS3ayiTGHqtfM=;
        b=UKuBerBaLV/EDCGvEVXWrIxbbQtQBHoiC5Kvd5FYL1vS2r2L5WSq3oC3SbFEXZI5GC
         z3DMGF+lSkKgIn3Ng2qpFHIL9Be/eCset6N+xFPhGHB6zMRwEvMqso1RxzsFwSIhjgy5
         xd0bttjAQziQW16ecEvcRhgqaiWimYtL8GN8OKXOYgOUyO2kXJvUzNSr681fMZeGtH0f
         AXxfewAPLbmB5cQh8hitmQOfCTQT5s8l3EQiZO7GKJa8kCaUyexP8taA+cy0a77fG/fr
         BEjKpWVHPEKoXy5Dlow/PdnIfurtkAqrnKvEoj7HRqriPUKZ/bn9ytYCsE16Z9Qybu3y
         bNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWpn+xWGvtGBH62qOXih/XCmqiF9B5PS3ayiTGHqtfM=;
        b=TMrIqW/slk0DBtiOKikd2WclBA9DIvtsi9ttmQOg/vAHT5bWQTUrUtcUnx+HAcAaIf
         yHiVui4ydPdpDcIoZeGCg+EuSPhpg6uMgaLTINJRQK/fr979YOnFS56r2jcpF8pAsDFD
         yl+hXfXGJZV16+6uZC+V7NRdaPZ3oKGh+vhZKjLyruBkV45TS7Zzb8gawgl9BB9lu+V5
         5jSk7AUCKD57q+thS19V9iw7WcoZx2FgqYRO2RRzvSPQSFUIDXiMFaROvVYJT+p1eGvo
         SbDlZPD1P9KOQNmQogfDZ8zlDCycyEqr5i4m/Mxv6Pjt4DwSW77zzWK+VjV/4Qj9VDdK
         g/3g==
X-Gm-Message-State: AO0yUKW7v/+/nFOANt41H67wGP6po7KyUlkSkrGXYtECCkPQV2ZD3/Hv
        Y2GpDALamy1CmA48d5pUH/0=
X-Google-Smtp-Source: AK7set+zzA0ivuueg4C6yt+gQFMPyg5ZmE5h3MeaycUFJwdOUvSuTGG3hi93P5oOug719WWzZVmTLg==
X-Received: by 2002:a05:600c:4b29:b0:3e2:147f:ac1a with SMTP id i41-20020a05600c4b2900b003e2147fac1amr6993905wmp.21.1676753395078;
        Sat, 18 Feb 2023 12:49:55 -0800 (PST)
Received: from localhost (94.197.47.81.threembb.co.uk. [94.197.47.81])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003e2059c7978sm10160847wmq.36.2023.02.18.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 12:49:54 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] power: supply: axp20x_usb_power: Use regmap fields for USB BC feature
Date:   Sat, 18 Feb 2023 20:49:44 +0000
Message-Id: <20230218204946.106316-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230218204946.106316-1-aidanmacdonald.0x0@gmail.com>
References: <20230218204946.106316-1-aidanmacdonald.0x0@gmail.com>
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

