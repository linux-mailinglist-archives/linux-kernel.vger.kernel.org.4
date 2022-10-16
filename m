Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78261600465
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJPXn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJPXm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44DF3844D;
        Sun, 16 Oct 2022 16:42:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w18so15994876wro.7;
        Sun, 16 Oct 2022 16:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLNaaOsLr96TmggGShacOs0+QBHQK9LKPCnPOfIZ4M0=;
        b=XHEmXq0xose8BCxHQ7cp7eQEBOoG+00uP5Fqf1CATZbpmqd3XJkipc9ZiVNgCEO9ly
         /dgsR55qnGgGcI8V+aS4DzyWKCXlcr0pmEvGHmASNswkilZ8fS4LGHuySpzQcwyc2XNf
         GI+JlpHoVqiRYe2qdp52ZckEn9yaqF8lF8QR+CoXeb3q4tAX7tfEhe5mbFfLF9MfRO7r
         sHl4mJLhkRpsb/Px9i6RYM1HyZjERAdVy0IC45Z8xYbNIygY1QZpjbPgcqpVUrDwL8+t
         mPwx/xGLFSCNzb5mxDqC5PulNoz5x6CwublCKBzruLKwcy30ynyvC1J/Biqxv8WlriW2
         ZLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLNaaOsLr96TmggGShacOs0+QBHQK9LKPCnPOfIZ4M0=;
        b=6t21k77LkQyxCDpNkWEo5ELhzgZnxnhU/OfE2rcv5NSJFVdoP8e5vAlOPJ9B1r1n7U
         P7sDN7Fi/jAF6zFjarcVVP6LolIy82tqMYzVsbmbOxD5JGO1W2He8e9vHU7pYPt/eXT0
         4oVMbfx2MAnnQgsSgOnjZ5ltxbwjGIZDODu27SlmY58y9mD8tMJvhYroR+jOTA5fbt3p
         ByXKl9o1wJ/6r+iYE143rDTCTJP3ZypygerGkKRM/KA0ezKuvkAi+NvgFhZRJKCRPlgK
         iX9/gmRTyWEDZ8V6MMCldN55VcyZAMn9BvekAN2IAu4mWKJw14Z9DCIalchu43WWK3uH
         YqqQ==
X-Gm-Message-State: ACrzQf2XEte5KynSzcJCBwvGeBSw4czWo5yplfDExetHvheo3F240Ka9
        R5os3OAfQ4Vl16N7em560Ks=
X-Google-Smtp-Source: AMsMyM52GUJp+BCZmmlQDioN889uuJnt4eIbHt5nmnNOJVid/qznriWjERrYLQHlc4X7WlugEoHoig==
X-Received: by 2002:a5d:4535:0:b0:232:3648:7771 with SMTP id j21-20020a5d4535000000b0023236487771mr4602684wra.342.1665963752790;
        Sun, 16 Oct 2022 16:42:32 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id u7-20020adfed47000000b002286670bafasm7152829wro.48.2022.10.16.16.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:32 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 12/13] power: axp20x_battery: Support battery status without fuel gauge
Date:   Mon, 17 Oct 2022 00:43:34 +0100
Message-Id: <20221016234335.904212-13-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
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

Add a "has_fg" flag to indicate that the chip has a fuel gauge.
Report battery full status on chips with no fuel gauge using the
battery voltage.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/power/supply/axp20x_battery.c | 34 ++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 401779d84d2b..574c1d001556 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -69,6 +69,7 @@ struct axp_data {
 	 * must have AXP20X_CHRG_CTRL1_TGT_CURR+1 elements.
 	 */
 	const int *ccc_table;
+	bool	has_fg;
 	bool	has_fg_valid;
 	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
 	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
@@ -197,7 +198,7 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 				   union power_supply_propval *val)
 {
 	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
-	int ret = 0, reg, val1;
+	int ret = 0, reg, val1, val2;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -231,6 +232,34 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 			return 0;
 		}
 
+		/*
+		 * If the chip does not have a fuel gauge, we check battery full status
+		 * using voltage instead.
+		 */
+		if (!axp20x_batt->data->has_fg) {
+			ret = axp20x_batt->data->get_max_voltage(axp20x_batt, &val1);
+			if (ret)
+				return ret;
+
+			ret = iio_read_channel_processed(axp20x_batt->batt_v, &val2);
+			if (ret)
+				return ret;
+
+			/* IIO subsystem reports voltage in mV but we need uV */
+			val2 *= 1000;
+
+			/*
+			 * According to the AXP192 datasheet, charging will restart if
+			 * the battery voltage drops below V_rch = V_tgt - 0.1 V, so we
+			 * report the battery is full if its voltage is at least V_rch.
+			 */
+			if (val2 >= val1 - 100000)
+				val->intval = POWER_SUPPLY_STATUS_FULL;
+			else
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			break;
+		}
+
 		ret = regmap_read(axp20x_batt->regmap, AXP20X_FG_RES, &val1);
 		if (ret)
 			return ret;
@@ -552,6 +581,7 @@ static const struct power_supply_desc axp20x_batt_ps_desc = {
 static const struct axp_data axp209_data = {
 	.ccc_scale = 100000,
 	.ccc_offset = 300000,
+	.has_fg = true,
 	.get_max_voltage = axp20x_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
 };
@@ -559,6 +589,7 @@ static const struct axp_data axp209_data = {
 static const struct axp_data axp221_data = {
 	.ccc_scale = 150000,
 	.ccc_offset = 300000,
+	.has_fg = true,
 	.has_fg_valid = true,
 	.get_max_voltage = axp22x_battery_get_max_voltage,
 	.set_max_voltage = axp22x_battery_set_max_voltage,
@@ -567,6 +598,7 @@ static const struct axp_data axp221_data = {
 static const struct axp_data axp813_data = {
 	.ccc_scale = 200000,
 	.ccc_offset = 200000,
+	.has_fg = true,
 	.has_fg_valid = true,
 	.get_max_voltage = axp813_battery_get_max_voltage,
 	.set_max_voltage = axp20x_battery_set_max_voltage,
-- 
2.38.0

