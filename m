Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207CF6FDD30
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbjEJLwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbjEJLvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:51:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4995FC2;
        Wed, 10 May 2023 04:51:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f42bcf5df1so18708735e9.3;
        Wed, 10 May 2023 04:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683719509; x=1686311509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdCsH2d8zg6wheMJGk9jqr1Puc+kcdg3d/O4BTVakwc=;
        b=JMVjlHpkletbHyZMVIVo5SEiHVHe9HN5MHzA6s1NqWsBobJl97afhQnQWXnGWBbumW
         K1h8dMYJQqGP6mr5vJIlU/MfVEjkth194lBHpUWzmLV3qmMipBh8Lfrz4yLfoQnvl5SD
         VIc/cBxOlHOVtd4TrM/rhLDlaSKhyN8SExIy4OI3Nr1GBLskVJZjER9Fbw41GCtTqDj6
         UXWRoGRESgBJ2HqgwJuETWdJg7mJtD2/oL/aU0BjIrU2Jc2agJsHy2VpPdn6E7ozEuCC
         /XVK8wF6Bik/Up5iI2fd8PYRPeRUhHzsv7MEGsGl2wcNtrr2Bs4CgE2Hz6FdQ6NUhbP1
         Y5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683719509; x=1686311509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdCsH2d8zg6wheMJGk9jqr1Puc+kcdg3d/O4BTVakwc=;
        b=V85DZPZW/T0Eoe7zUCSWecaQc6CwCArqKZed4MIYvMlvoY6u+JLM1hE1/MVdZfxgrw
         Hwwbh2U6WZRPgcSk6c9y5HX8nw0K2PgZXtYE0Vo6fNVW1MyZRA5aD9bjURF5zNEiEWwm
         dBxamJ/6Q8HvsDCjHve2GiF1hKY49eiSRUv4yO9ljQE1HXtprFXWudKYZPdA2xvHmGCY
         +hEdPZnJpA+HERHQ3Ra140TZsr13ZWHoBvTMBgQSEmRMBe3z89k818XGh+6o6HAwrELW
         ghho1dnKYEefa0LuplndnNRIxi18kTeU86rw2iR9WCqySjfq4zLJ/5toaz3yyZaU/Z/9
         5Yeg==
X-Gm-Message-State: AC+VfDyOKJzDMjXnawGhRHV3d7KIohydNeE0TFCaB4xuZ0d5B+SRje3A
        +JzuOrmbFnBBpBhEmJw1Yc8=
X-Google-Smtp-Source: ACHHUZ4Xj7OSSzHMiupaFmcG2/P/M2LWRb3mUD1jUUBwSqCYQNP4LMoFCFZXnVflVgZt4hflenhjXg==
X-Received: by 2002:a7b:c449:0:b0:3f4:2d04:f3f0 with SMTP id l9-20020a7bc449000000b003f42d04f3f0mr3102760wmi.39.1683719508505;
        Wed, 10 May 2023 04:51:48 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c22c200b003f42328b5d9sm10525514wmg.39.2023.05.10.04.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:51:48 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/7] power: supply: axp20x_usb_power: Remove variant IDs from VBUS polling check
Date:   Wed, 10 May 2023 12:50:44 +0100
Message-Id: <20230510115046.963432-6-aidanmacdonald.0x0@gmail.com>
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

