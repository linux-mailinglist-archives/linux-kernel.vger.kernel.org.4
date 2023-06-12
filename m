Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4950672C338
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjFLLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjFLLiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:38:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C536584
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f649db9b25so4857691e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686569469; x=1689161469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF8XkEzBn2bI8HNyXckNnxzb/f1aF1cm8iChUnH2MYQ=;
        b=iGaBlcQHbQKwQEkolODsOCPsDLgnefvvS+vIL7gyjiXNj6hoJ4CTU4x6g60FsJywt4
         W6qfm3d1pRzijQHQ1LD2X7v7gjk3H80d5bgSHg2aMqgfaNGWq6e3mb/rgHLcnvPRIyaQ
         1ovayB1mEWZ7+R6EF4N43+7JwiylhiIKRza7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686569469; x=1689161469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF8XkEzBn2bI8HNyXckNnxzb/f1aF1cm8iChUnH2MYQ=;
        b=G+0xS82dHeah/2NNAMHytRt9jGQbOUW7SgZe3iJy5HhOp+sTOyP/LyqoxYyMKHU3Wq
         x0zqxBM3CU3bZbj0XmUgxSFaLAuQ4biv1s4bFsxRGo+AD9TDBP5U08oF1nrmVnTSwPT1
         s8PLrO47l8dLb7u+ClwivEUQqpnbjALSVov0KNw1Q0uMxKYaP6JzkxQN0lBYk0cbNKfe
         DsavkHk2DZI1Vsu33lvwzULR5q2bSccC+HFHuijwzM4kFL1zOjwEGgFwVQxocvEz4JLO
         5QbbwCKMuupdJg13djuuBtwcIoQ9Be6HbQA/YORTgHpdnYERbz/ITjYUqbLU9HWGD8W0
         iePA==
X-Gm-Message-State: AC+VfDw1Jsz4oz7M+G3UC2Oejwq5LsS/0JJ0CZ6IDPgGbfru4shHyWBF
        8tL79y4E4FVkarMeKXQfqsktng==
X-Google-Smtp-Source: ACHHUZ4hOCIN8xKvfoizozIxAJRqo5eCUyzL8mIenSNp8hPEvMwHUDV7qgJAMeF19sXoZyOIvRrI+g==
X-Received: by 2002:a19:d611:0:b0:4f7:434b:70b4 with SMTP id n17-20020a19d611000000b004f7434b70b4mr1470471lfg.41.1686569469275;
        Mon, 12 Jun 2023 04:31:09 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w26-20020a19c51a000000b004edb8fac1cesm1399320lfe.215.2023.06.12.04.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 04:31:07 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] rtc: isl12022: add support for trip level DT bindings
Date:   Mon, 12 Jun 2023 13:30:54 +0200
Message-Id: <20230612113059.247275-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/rtc/rtc-isl12022.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index ebd66b835cef..cb8f1d92e116 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -31,6 +31,8 @@
 #define ISL12022_REG_SR		0x07
 #define ISL12022_REG_INT	0x08
 
+#define ISL12022_REG_PWR_VBAT	0x0a
+
 #define ISL12022_REG_BETA	0x0d
 #define ISL12022_REG_TEMP_L	0x28
 
@@ -42,6 +44,9 @@
 
 #define ISL12022_INT_WRTC	(1 << 6)
 
+#define ISL12022_REG_VB85_MASK	GENMASK(5, 3)
+#define ISL12022_REG_VB75_MASK	GENMASK(2, 0)
+
 #define ISL12022_BETA_TSE	(1 << 7)
 
 static umode_t isl12022_hwmon_is_visible(const void *data,
@@ -209,6 +214,35 @@ static const struct regmap_config regmap_config = {
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
+	for (x85 = 0; x85 < ARRAY_SIZE(trip_level85) - 1; ++x85)
+		if (level85 <= trip_level85[x85])
+			break;
+
+	for (x75 = 0; x75 < ARRAY_SIZE(trip_level75) - 1; ++x75)
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
@@ -225,6 +259,7 @@ static int isl12022_probe(struct i2c_client *client)
 
 	dev_set_drvdata(&client->dev, regmap);
 
+	isl12022_set_trip_levels(&client->dev);
 	isl12022_hwmon_register(&client->dev);
 
 	rtc = devm_rtc_allocate_device(&client->dev);
-- 
2.37.2

