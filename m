Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC96C65170D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiLTAGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 19:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiLTAFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:05:49 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F2C37
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:05:48 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3b10392c064so149768257b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLlc7QfWYSwhEPXevanfM/J17xcjG7QbxYgYWgfuSbs=;
        b=L6fludGALr816IQEcsLG5CKJL99qb7vbg9Za3eDAXs31j7Z4+mej3LnSey8IvNKQUW
         KGn9kDOFk6YegAX5kFF8xNBuiAOjdZynbmQOX0VvlTDm1lRiv6hgBJGuiJc8GodiKg68
         QfeLOcbeAJG0RPs+MvH+TetN/fSrn3Xv6x/JxFDxVmWQe2egMHt32vYzQU5xTl+XG27z
         gm5GqIoQeLN72/mX7VFwG8p8mwoHB3NAbHjKnEIUHxkwG1hbGgIt1oOfovBcCrJAB4fm
         nErLujaoPwbKFtS600ER+TxQnYZPsKeWgKWtEw6zeqsMtsJ7T+zwXV2aJsoUdnwLPnQP
         E8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLlc7QfWYSwhEPXevanfM/J17xcjG7QbxYgYWgfuSbs=;
        b=YhL1NsIpmQ47hhYzqjAQym2vkz3ZJK/djX63E5EmEOPFwucv/UpoUEpM3AyrywjezF
         Xh7hEEHJvL7OKGEkXNWl5mHqaNK/YjrPm49yVwZqs1/2aFEFkpuOzn6IsT59n9piTcou
         vlVWIN8zUFoCBj5LIQnmZzxqurV9Dv1bG7rcRwuE/fiBrn51rIMZbjV2e1E0KvrgBrFt
         z0Ry7qYHiMslxLiVMMeWjZX2l4s1WYOjhWhilTDGO0bmqVvVWqTS5bFgF5iI8Bqrcj6m
         C5Vl6vcMLQFAeB68xN8JA3Fv+Amu0uwkpEy84rJ1s5yFzaRTdLduPifV2So2ua6LbNLw
         Rllw==
X-Gm-Message-State: AFqh2krEAZv6dNVjTSAlcCGB50h836xOoHx0uDdQyH35FII0XGRLaeLh
        1XZ2GvKIz2Xo7Rsqq+MPMNCBMA==
X-Google-Smtp-Source: AMrXdXtq6B2lyfUWipnsaxJbnCjl3OmnmZxDDLAMGMiW2C7JTWrPi7OmxPJzwoOHN1GMu0imH3aylA==
X-Received: by 2002:a81:4e57:0:b0:38f:91bf:7783 with SMTP id c84-20020a814e57000000b0038f91bf7783mr8802927ywb.25.1671494747189;
        Mon, 19 Dec 2022 16:05:47 -0800 (PST)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id o70-20020a374149000000b006e702033b15sm7721430qka.66.2022.12.19.16.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:05:46 -0800 (PST)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     linux-hwmon@vger.kernel.org
Cc:     John Pruitt <jpruitt@criticallink.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH v2 4/4] hwmon: ltc2945: Fix possible overflows
Date:   Mon, 19 Dec 2022 19:04:57 -0500
Message-Id: <20221220000457.1163446-5-jcormier@criticallink.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220000457.1163446-1-jcormier@criticallink.com>
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221220000457.1163446-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Pruitt <jpruitt@criticallink.com>

Use 64-bit values for intermediate calculations. Check for
overflows and return INT_MAX if overflows happened.

Signed-off-by: John Pruitt <jpruitt@criticallink.com>
Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
---
 drivers/hwmon/ltc2945.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index fc7d399b2c85..7239422fc6db 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -126,6 +126,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 		}
 		val *= 1000;
 		val = DIV_ROUND_CLOSEST_ULL(val, shunt_resistor);
+		/* check for overflow, use MAX value if it happened */
+		if (val > INT_MAX)
+			val = INT_MAX;
+
 		break;
 	case LTC2945_VIN_H:
 	case LTC2945_MAX_VIN_H:
@@ -159,12 +163,14 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 }

 static int ltc2945_val_to_reg(struct device *dev, u8 reg,
-			      unsigned long val)
+			      unsigned long val_32)
 {
 	struct ltc2945_data *data = dev_get_drvdata(dev);
 	struct regmap *regmap = data->regmap;
 	u32 shunt_resistor = data->shunt_resistor;
 	unsigned int control;
+	/* use 64-bit val for intermediate calculations */
+	unsigned long long val = val_32;
 	int ret;

 	switch (reg) {
@@ -184,7 +190,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 		if (control & CONTROL_MULT_SELECT) {
 			/* 25 mV * 25 uV = 0.625 uV resolution. */
 			val *= shunt_resistor;
-			val = DIV_ROUND_CLOSEST(val, 625 * 1000);
+			val = DIV_ROUND_CLOSEST_ULL(val, 625LL * 1000LL);
 		} else {
 			/*
 			 * 0.5 mV * 25 uV = 0.0125 uV resolution.
@@ -192,7 +198,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 			 * accept loss of accuracy.
 			 */
 			val *= shunt_resistor;
-			val = DIV_ROUND_CLOSEST(val, 25 * 1000) * 2;
+			val = DIV_ROUND_CLOSEST_ULL(val, 25LL * 1000LL) * 2;
 		}
 		break;
 	case LTC2945_VIN_H:
@@ -201,7 +207,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	case LTC2945_MAX_VIN_THRES_H:
 	case LTC2945_MIN_VIN_THRES_H:
 		/* 25 mV resolution. */
-		val /= 25;
+		val = DIV_ROUND_CLOSEST_ULL(val, 25LL);
 		break;
 	case LTC2945_ADIN_H:
 	case LTC2945_MAX_ADIN_H:
@@ -218,11 +224,15 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	case LTC2945_MIN_SENSE_THRES_H:
 		/* 25 uV resolution. Convert to  mA. */
 		val *= shunt_resistor;
-		val = DIV_ROUND_CLOSEST(val, 25 * 1000);
+		val = DIV_ROUND_CLOSEST_ULL(val, 25LL * 1000LL);
 		break;
 	default:
 		return -EINVAL;
 	}
+	/* If val is too large, just return the max value */
+	if (val > INT_MAX)
+		return INT_MAX;
+
 	return val;
 }

--
2.25.1
