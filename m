Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3F600447
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJPXmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJPXm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3990B27170;
        Sun, 16 Oct 2022 16:42:25 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u10so16023042wrq.2;
        Sun, 16 Oct 2022 16:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVesUdRnr++muKO+nw0A5YMx26afNvf+61fP6zkLiKQ=;
        b=IAugVCKWS8iu1mYNPo7x624yhvrgIbtP4XXrcNoyhYsWL3fAto3oNqli2TXyB82xk/
         cs/poUkH7S4M18Cnc4r1cbLGzuED9ahz8gXJyOyxSGXTYc6aBMhTpvLUcZyLKEgcGSbJ
         WQ9db97LwXTqDoli21SimAFakj5iYX0AGbydVjJoSHrdk7MfTazxj4wmsrkmR0c0x1p2
         oYQEh33SVn/qiTaaFXssYuPo4l6htg/fd0dXcNIn+liiPqb2rYFTjyj21Z+Tn6+dnvev
         YKznxwc0Sy9i7i0vCVykDNCD6cNi+DcMUBOFlBSJVyBzJkB0ZGUyk0koMUu9pN/aqCM2
         KwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVesUdRnr++muKO+nw0A5YMx26afNvf+61fP6zkLiKQ=;
        b=CceJCXhfrmw3X6S2owhK+XWh6hEYQhT9wgLBPX5nyf8nC6C6pZzZwrvVrXcHix7dK2
         t/+CdXOFygG4HCKkQ/1hguQUODPwsSyPs6E8vdnpT0jOV11ELQkIhxb10kqN2wMBXD9O
         ii3tKzp8Ioq5RRLr82Fmm1GDMnFzaYO7wH+1miOdkO8v5N2WIrxXtlvcGz+68ltOEK+2
         qgngVWET/ubxJPysecdiby5OyFGPNLDinVBGF+cENYEp9gyWBK8UHUwmSvcHcwrpPQ+c
         fFbSzeIThZPk85bEX9wqlUm+oaw5l/I/NHGDyqo2AZ98dpFwNBVaxnfZd7UbLK1Ko7Tv
         sLxg==
X-Gm-Message-State: ACrzQf2k1EBoOi/Ms7Bik9p4s7qHylWwcFxlGS2wx8eK8X0okI8JG9Ef
        KQGG6pq0ir0KvgiJC5EvVc4=
X-Google-Smtp-Source: AMsMyM4XDjA6tZsosCtyFk8qFfnYu7/f7jyhaepXkKvxEqSvxPuZk/FXL4D6qrucXdegd75bfisbiw==
X-Received: by 2002:a5d:660d:0:b0:22e:57b6:ebd with SMTP id n13-20020a5d660d000000b0022e57b60ebdmr4657441wru.674.1665963743632;
        Sun, 16 Oct 2022 16:42:23 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c311000b003c6237e867esm8788653wmo.0.2022.10.16.16.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:23 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/13] regulator: axp20x: Add support for AXP192
Date:   Mon, 17 Oct 2022 00:43:28 +0100
Message-Id: <20221016234335.904212-7-aidanmacdonald.0x0@gmail.com>
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

Add support for the AXP192 PMIC.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/regulator/axp20x-regulator.c | 100 ++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index d260c442b788..ee79a9ed0249 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -27,6 +27,29 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 
+#define AXP192_GPIO0_FUNC_MASK		GENMASK(2, 0)
+
+#define AXP192_IO_ENABLED		0x02
+#define AXP192_IO_DISABLED		0x06
+
+#define AXP192_WORKMODE_DCDC1_MASK	BIT_MASK(3)
+#define AXP192_WORKMODE_DCDC2_MASK	BIT_MASK(2)
+#define AXP192_WORKMODE_DCDC3_MASK	BIT_MASK(1)
+
+#define AXP192_DCDC1_V_OUT_MASK		GENMASK(6, 0)
+#define AXP192_DCDC2_V_OUT_MASK		GENMASK(5, 0)
+#define AXP192_DCDC3_V_OUT_MASK		GENMASK(6, 0)
+#define AXP192_LDO2_V_OUT_MASK		GENMASK(7, 4)
+#define AXP192_LDO3_V_OUT_MASK		GENMASK(3, 0)
+#define AXP192_LDO_IO0_V_OUT_MASK	GENMASK(7, 4)
+
+#define AXP192_PWR_OUT_EXTEN_MASK	BIT_MASK(6)
+#define AXP192_PWR_OUT_DCDC2_MASK	BIT_MASK(4)
+#define AXP192_PWR_OUT_LDO3_MASK	BIT_MASK(3)
+#define AXP192_PWR_OUT_LDO2_MASK	BIT_MASK(2)
+#define AXP192_PWR_OUT_DCDC3_MASK	BIT_MASK(1)
+#define AXP192_PWR_OUT_DCDC1_MASK	BIT_MASK(0)
+
 #define AXP20X_GPIO0_FUNC_MASK		GENMASK(3, 0)
 #define AXP20X_GPIO1_FUNC_MASK		GENMASK(3, 0)
 
@@ -375,25 +398,32 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 
 	switch (axp20x->variant) {
 	case AXP209_ID:
-		if (id == AXP20X_DCDC2) {
+		if (id == AXP20X_LDO3) {
 			slew_rates = axp209_dcdc2_ldo3_slew_rates;
 			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
 			reg = AXP20X_DCDC2_LDO3_V_RAMP;
-			mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
-			       AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
+			mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
+			       AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
 			enable = (ramp > 0) ?
-				 AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN : 0;
+				 AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN : 0;
 			break;
 		}
 
-		if (id == AXP20X_LDO3) {
+		fallthrough;
+
+	case AXP192_ID:
+		/*
+		 * AXP192 and AXP209 share the same DCDC2 ramp configuration
+		 */
+		if ((axp20x->variant == AXP209_ID && id == AXP20X_DCDC2) ||
+		    (axp20x->variant == AXP192_ID && id == AXP192_DCDC2)) {
 			slew_rates = axp209_dcdc2_ldo3_slew_rates;
 			rate_count = ARRAY_SIZE(axp209_dcdc2_ldo3_slew_rates);
 			reg = AXP20X_DCDC2_LDO3_V_RAMP;
-			mask = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE_MASK |
-			       AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK;
+			mask = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE_MASK |
+			       AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN_MASK;
 			enable = (ramp > 0) ?
-				 AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN : 0;
+				 AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_EN : 0;
 			break;
 		}
 
@@ -415,7 +445,8 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
 			if (ramp > slew_rates[i])
 				break;
 
-			if (id == AXP20X_DCDC2)
+			if ((axp20x->variant == AXP209_ID && id == AXP20X_DCDC2) ||
+			    (axp20x->variant == AXP192_ID && id == AXP192_DCDC2))
 				cfg = AXP20X_DCDC2_LDO3_V_RAMP_DCDC2_RATE(i);
 			else
 				cfg = AXP20X_DCDC2_LDO3_V_RAMP_LDO3_RATE(i);
@@ -511,6 +542,29 @@ static const struct regulator_ops axp20x_ops_sw = {
 	.is_enabled		= regulator_is_enabled_regmap,
 };
 
+static const struct regulator_desc axp192_regulators[] = {
+	AXP_DESC(AXP192, DCDC1, "dcdc1", "vin1", 700, 3500, 25,
+		 AXP192_DCDC1_V_OUT, AXP192_DCDC1_V_OUT_MASK,
+		 AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_DCDC1_MASK),
+	AXP_DESC(AXP192, DCDC2, "dcdc2", "vin2", 700, 2275, 25,
+		 AXP192_DCDC2_V_OUT, AXP192_DCDC2_V_OUT_MASK,
+		 AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_DCDC2_MASK),
+	AXP_DESC(AXP192, DCDC3, "dcdc3", "vin3", 700, 3500, 25,
+		 AXP192_DCDC3_V_OUT, AXP192_DCDC3_V_OUT_MASK,
+		 AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_DCDC3_MASK),
+	AXP_DESC_FIXED(AXP192, LDO1, "ldo1", "acin", 1250),
+	AXP_DESC(AXP192, LDO2, "ldo2", "ldoin", 1800, 3300, 100,
+		 AXP192_LDO2_3_V_OUT, AXP192_LDO2_V_OUT_MASK,
+		 AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_LDO2_MASK),
+	AXP_DESC(AXP192, LDO3, "ldo3", "ldoin", 1800, 3300, 100,
+		 AXP192_LDO2_3_V_OUT, AXP192_LDO3_V_OUT_MASK,
+		 AXP192_PWR_OUT_CTRL, AXP192_PWR_OUT_LDO3_MASK),
+	AXP_DESC_IO(AXP192, LDO_IO0, "ldo_io0", "ips", 700, 3300, 100,
+		    AXP192_LDO_IO0_V_OUT, AXP192_LDO_IO0_V_OUT_MASK,
+		    AXP192_GPIO0_CTRL, AXP192_GPIO0_FUNC_MASK,
+		    AXP192_IO_ENABLED, AXP192_IO_DISABLED),
+};
+
 static const struct linear_range axp20x_ldo4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1250000,
 			       AXP20X_LDO4_V_OUT_1250mV_START,
@@ -1008,6 +1062,12 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 	u32 min, max, def, step;
 
 	switch (axp20x->variant) {
+	case AXP192_ID:
+		min = 900;
+		max = 2025;
+		def = 1500;
+		step = 75;
+		break;
 	case AXP202_ID:
 	case AXP209_ID:
 		min = 750;
@@ -1100,6 +1160,24 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 	unsigned int mask;
 
 	switch (axp20x->variant) {
+	case AXP192_ID:
+		switch (id) {
+		case AXP192_DCDC1:
+			mask = AXP192_WORKMODE_DCDC1_MASK;
+			break;
+		case AXP192_DCDC2:
+			mask = AXP192_WORKMODE_DCDC2_MASK;
+			break;
+		case AXP192_DCDC3:
+			mask = AXP192_WORKMODE_DCDC3_MASK;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		workmode <<= ffs(mask) - 1;
+		break;
+
 	case AXP202_ID:
 	case AXP209_ID:
 		if ((id != AXP20X_DCDC2) && (id != AXP20X_DCDC3))
@@ -1220,6 +1298,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	bool drivevbus = false;
 
 	switch (axp20x->variant) {
+	case AXP192_ID:
+		regulators = axp192_regulators;
+		nregulators = AXP192_REG_ID_MAX;
+		break;
 	case AXP202_ID:
 	case AXP209_ID:
 		regulators = axp20x_regulators;
-- 
2.38.0

