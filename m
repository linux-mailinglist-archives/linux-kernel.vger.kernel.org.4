Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5E72E3A4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242518AbjFMNBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbjFMNBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:01:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04BFA6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:01:08 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f654d713c0so6292958e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686661267; x=1689253267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSH+Aow2U6ZzKr5DbKMcJzMIM4IZIKyfCdo88IJB1zw=;
        b=HxKZiFubc/qPuai6rMa1n2wUzrSLBL5XcZuD5oLg3maVgs1PL2fLtf4wCyTWr54OHl
         h+BBMXeBnnpn1klI7IgUDoHG+dIBYDsnYmmwcWLnWzSltTIesUgItp6ej/vAFxaP6V7J
         m5VLToxav9L/mSYxpXTinufbijyDOT/m3E6II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686661267; x=1689253267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSH+Aow2U6ZzKr5DbKMcJzMIM4IZIKyfCdo88IJB1zw=;
        b=UJMl/dXquHNxjjiSKzUN+R1iA4uLGXrHRg08pYjv56WPFsyHGZckxQC1ZxRup1IEhm
         OIQwiDdvEusG9OBFfrRR0fmWFfFISZg3RKzCNTCo8pvyRjIBuz+mQECy50N3kv3FnvVG
         OBYlBWKf/hot9V6cVk80RjECC6LVRZ17rAUXfJc3QXhWCic5avCRz9eY66GB4yyTpGp5
         3AmBc+3dprtZ3kuTTQ8xbNYBWXDPz5B8TC9CLcoB4eFCvmsc5WFuzPwiwEnxt2njBmeL
         l56a9Jp2EjZH4ghOrLH5+uBd/Nhf5R6Bmclnvp4UyYX1tYIex1SEBJmRrZxRVWprH2w/
         wuVQ==
X-Gm-Message-State: AC+VfDySSy0au7Nz2EZNs0nkx5gvoZZrhiw6X+47usN4Uh5snb5cb0fN
        lzR+zGjTY3A6n6TTzAiKFUhf8Q==
X-Google-Smtp-Source: ACHHUZ7h18EEeYiRz8Gdu9bLC4p2mbl7/n8BO0yWGIfrUkjcFq4JCSDyvQCIGrWT7+XY78y2HqXosw==
X-Received: by 2002:a19:4f06:0:b0:4f4:d41b:f42b with SMTP id d6-20020a194f06000000b004f4d41bf42bmr6275093lfb.32.1686661266375;
        Tue, 13 Jun 2023 06:01:06 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1793786lfl.28.2023.06.13.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:01:05 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] rtc: isl12022: add support for trip level DT bindings
Date:   Tue, 13 Jun 2023 15:00:06 +0200
Message-Id: <20230613130011.305589-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230613130011.305589-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for using the values given in the
isil,trip-level[87]5-microvolt properties to set appropriate values in
the VB[87]5TP bits in the PWR_VBAT register.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index ebd66b835cef..50bbd1fefad8 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/i2c.h>
@@ -31,6 +32,8 @@
 #define ISL12022_REG_SR		0x07
 #define ISL12022_REG_INT	0x08
 
+#define ISL12022_REG_PWR_VBAT	0x0a
+
 #define ISL12022_REG_BETA	0x0d
 #define ISL12022_REG_TEMP_L	0x28
 
@@ -42,6 +45,9 @@
 
 #define ISL12022_INT_WRTC	(1 << 6)
 
+#define ISL12022_REG_VB85_MASK	GENMASK(5, 3)
+#define ISL12022_REG_VB75_MASK	GENMASK(2, 0)
+
 #define ISL12022_BETA_TSE	(1 << 7)
 
 static umode_t isl12022_hwmon_is_visible(const void *data,
@@ -209,6 +215,35 @@ static const struct regmap_config regmap_config = {
 	.use_single_write = true,
 };
 
+static const u32 trip_level85[] = { 2125000, 2295000, 2550000, 2805000, 3060000, 4250000, 4675000 };
+static const u32 trip_level75[] = { 1875000, 2025000, 2250000, 2475000, 2700000, 3750000, 4125000 };
+
+static void isl12022_set_trip_levels(struct device *dev)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	u32 level85 = 0, level75 = 0;
+	int ret, x85, x75;
+	u8 val, mask;
+
+	device_property_read_u32(dev, "isil,trip-level85-microvolt", &level85);
+	device_property_read_u32(dev, "isil,trip-level75-microvolt", &level75);
+
+	for (x85 = 0; x85 < ARRAY_SIZE(trip_level85) - 1; x85++)
+		if (level85 <= trip_level85[x85])
+			break;
+
+	for (x75 = 0; x75 < ARRAY_SIZE(trip_level75) - 1; x75++)
+		if (level75 <= trip_level75[x75])
+			break;
+
+	val = FIELD_PREP(ISL12022_REG_VB85_MASK, x85) | FIELD_PREP(ISL12022_REG_VB75_MASK, x75);
+	mask = ISL12022_REG_VB85_MASK | ISL12022_REG_VB75_MASK;
+
+	ret = regmap_update_bits(regmap, ISL12022_REG_PWR_VBAT, mask, val);
+	if (ret)
+		dev_warn(dev, "unable to set battery alarm levels: %d\n", ret);
+}
+
 static int isl12022_probe(struct i2c_client *client)
 {
 	struct rtc_device *rtc;
@@ -225,6 +260,7 @@ static int isl12022_probe(struct i2c_client *client)
 
 	dev_set_drvdata(&client->dev, regmap);
 
+	isl12022_set_trip_levels(&client->dev);
 	isl12022_hwmon_register(&client->dev);
 
 	rtc = devm_rtc_allocate_device(&client->dev);
-- 
2.37.2

