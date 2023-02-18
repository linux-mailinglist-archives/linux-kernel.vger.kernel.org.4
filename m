Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4333C69BBF4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBRUuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBRUuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:50:00 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4B614EA9;
        Sat, 18 Feb 2023 12:49:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k14-20020a05600c1c8e00b003e22107b7ccso814639wms.0;
        Sat, 18 Feb 2023 12:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdCsH2d8zg6wheMJGk9jqr1Puc+kcdg3d/O4BTVakwc=;
        b=Il5L5cPlhAHrh4Ia3DeD4zTlMK3BeZCon21HTwzfeskwaSTUGEV1jKUzcIAPj0Mj23
         MCE1Q+aweforLcOWJAobIWXh6UxedaTKYxldG5hlOzSv7T7VsgYPszTdAL2pkqMiV4Fm
         0KnpmtOq3K+pbMI+5SNUdm2QgKpZuiylL0gFs8h5esoEvfra0Qjyv2p2hkhempxFnCs1
         TF8wzTcFajRF9pMCZECGPBFt4mUOiIs32rdZyvdmJRnO1MxsoyjOToQeCam1oCg53MNG
         CpOyqH3XgDnWBG7C65TJ0TvaxWZY9pyJnoVt92ExvkwxfRWhGUskWyHNtmjVXyfjDfiU
         JfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdCsH2d8zg6wheMJGk9jqr1Puc+kcdg3d/O4BTVakwc=;
        b=rV1CeYr+mTD64ZLKJ3HRq4G5N4jckI0nDCsQ1RtTOU4Y/ixdo4kKZBDriT1772JKVP
         vxAjY8Zj1a9ShI/mLPwnczKwrjJOS2Ts356opOGeTreUBkEFbNlh/1pOJUJdNb0Rg3qu
         +J59z8cqWnNrrRz2Dx/LKbR1gTMgHMP+ukFmnhZ5heyEVHH4LhfTsKDHIUMu9mvUt1a7
         Y9dqRoQbXWrbzxxcx0xC8BujyJbsOztyIOGn4IJu74AxFq4dEBmNRDSgne3URxV3KqDx
         V7XwXu40Eu/M5y64FpSRKtAfbh81mz7aoWK7aHlo9bf63voeEfSW21dC2aY5RqUzYzCZ
         YsdQ==
X-Gm-Message-State: AO0yUKXTMsBnm3G1iKuPGlmr92x5/PXOlaBWS8QJRSWK+cIQ0gcBT/b4
        qm8lCFiInUz1dGZEBYnZJHXMRBsx3s8=
X-Google-Smtp-Source: AK7set+mexdiUZcpqfmOs9RlSu3rmMnyr9ejrMNHzIhZEfso0t0zrx7T4QrQ5F4R6w+7HUGfMtpLTA==
X-Received: by 2002:a05:600c:1695:b0:3e2:6dc:4d6e with SMTP id k21-20020a05600c169500b003e206dc4d6emr9508359wmn.31.1676753397393;
        Sat, 18 Feb 2023 12:49:57 -0800 (PST)
Received: from localhost (94.197.47.81.threembb.co.uk. [94.197.47.81])
        by smtp.gmail.com with ESMTPSA id s10-20020a7bc38a000000b003dc1a525f22sm8866551wmj.25.2023.02.18.12.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 12:49:57 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] power: supply: axp20x_usb_power: Remove variant IDs from VBUS polling check
Date:   Sat, 18 Feb 2023 20:49:46 +0000
Message-Id: <20230218204946.106316-6-aidanmacdonald.0x0@gmail.com>
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

Use an explicit boolean flag instead of a check based on the
variant ID. Since this is the last use of variant IDs in the
driver, also remove the IDs.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_usb_power.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 89f076615d2e..089fe837a4b2 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -48,13 +48,13 @@ struct axp_data {
 	const struct power_supply_desc	*power_desc;
 	const char * const		*irq_names;
 	unsigned int			num_irq_names;
-	enum axp20x_variants		axp20x_id;
 	const int			*curr_lim_table;
 	struct reg_field		curr_lim_fld;
 	struct reg_field		vbus_valid_bit;
 	struct reg_field		vbus_mon_bit;
 	struct reg_field		usb_bc_en_bit;
 	struct reg_field		vbus_disable_bit;
+	bool				vbus_needs_polling: 1;
 };
 
 struct axp20x_usb_power {
@@ -65,7 +65,6 @@ struct axp20x_usb_power {
 	struct regmap_field *usb_bc_en_bit;
 	struct regmap_field *vbus_disable_bit;
 	struct power_supply *supply;
-	enum axp20x_variants axp20x_id;
 	const struct axp_data *axp_data;
 	struct iio_channel *vbus_v;
 	struct iio_channel *vbus_i;
@@ -83,7 +82,7 @@ static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
 	 * present->absent transition implies an online->offline transition
 	 * and will trigger the VBUS_REMOVAL IRQ.
 	 */
-	if (power->axp20x_id >= AXP221_ID && !power->online)
+	if (power->axp_data->vbus_needs_polling && !power->online)
 		return true;
 
 	return false;
@@ -391,7 +390,6 @@ static const struct axp_data axp202_data = {
 	.power_desc	= &axp20x_usb_power_desc,
 	.irq_names	= axp20x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
-	.axp20x_id	= AXP202_ID,
 	.curr_lim_table = axp20x_usb_curr_lim_table,
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.vbus_valid_bit = REG_FIELD(AXP20X_USB_OTG_STATUS, 2, 2),
@@ -402,29 +400,29 @@ static const struct axp_data axp221_data = {
 	.power_desc	= &axp22x_usb_power_desc,
 	.irq_names	= axp22x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
-	.axp20x_id	= AXP221_ID,
 	.curr_lim_table = axp221_usb_curr_lim_table,
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
+	.vbus_needs_polling = true,
 };
 
 static const struct axp_data axp223_data = {
 	.power_desc	= &axp22x_usb_power_desc,
 	.irq_names	= axp22x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
-	.axp20x_id	= AXP223_ID,
 	.curr_lim_table = axp20x_usb_curr_lim_table,
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
+	.vbus_needs_polling = true,
 };
 
 static const struct axp_data axp813_data = {
 	.power_desc	= &axp22x_usb_power_desc,
 	.irq_names	= axp22x_irq_names,
 	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
-	.axp20x_id	= AXP813_ID,
 	.curr_lim_table = axp813_usb_curr_lim_table,
 	.curr_lim_fld   = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 0, 1),
 	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
 	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
+	.vbus_needs_polling = true,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -542,7 +540,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, power);
 
-	power->axp20x_id = axp_data->axp20x_id;
 	power->axp_data = axp_data;
 	power->regmap = axp20x->regmap;
 	power->num_irqs = axp_data->num_irq_names;
-- 
2.39.2

