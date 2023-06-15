Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0364B7315EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbjFOK66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343756AbjFOK6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:58:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D012711
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:58:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f841b7a697so1020973e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686826719; x=1689418719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYfZJ0PxZixY0dLK5zmM+/mrSboE1mU7I13VvIoENDw=;
        b=PmuxOTSVjQn1kT6lIyY95Bndpk5NDtK6UeKpy3xHbzizb3puAVukBDCtUxEPKQQjHA
         rQ3dN0xutz377HnXe/t98WxB455hiS0Ot4M2IwFEzX3had6VAfBEGlmSmP1509pLvZXp
         WJqGClZ0ivwsespZ3HxA/nCKE0l3PKt4bEwKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686826719; x=1689418719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYfZJ0PxZixY0dLK5zmM+/mrSboE1mU7I13VvIoENDw=;
        b=H9zd+4NfNhhsLc9demv7pa6NvwZGKqES5FMmJpVqjEYQjjuaWjwdl8aJJ2Z3Q2MrRL
         R6BD5W+Q/8LXCBbMpDWH1SnLg6tWarqeDa+DvQwjSQ0TGzclfIG67MKWGdyubiVyOPVR
         K3Y045o3ijHm0xon2YaTdFNhIQZKIIkN5LGrgq5bqnBxTNRgVTTLZXY5gGRuOPn5n/pv
         80Q2amfnMsAGNwyfABnemPTvS+3hJl07+HXk3QGq5b5WjuGIcaNzhmVKwqtlzU3OjHus
         leSVjzCI3lnIEnzwXGf49zZnGhMrBwMXBSSyRmfhxvnKLs9Qa3dzjH5V6yF5VqQKYQzG
         WPdA==
X-Gm-Message-State: AC+VfDzkLD6mptYv2207QYFQW6rNZBWCd6TEZo7CgbuQr8FUbRiKM8i+
        VjQuPSbdLQiXk0akKdMYdtb9VA==
X-Google-Smtp-Source: ACHHUZ4Ki/3UyNWljzTgPUtV1FL38EtSQGnHyLqfoIZ+0hG7grzuUa8EpnVtVNvrik6Id4QlmX/GMA==
X-Received: by 2002:a19:5007:0:b0:4f6:29b2:f92a with SMTP id e7-20020a195007000000b004f629b2f92amr10870918lfb.21.1686826719087;
        Thu, 15 Jun 2023 03:58:39 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h7-20020ac25967000000b004f13f4ec267sm165364lfp.186.2023.06.15.03.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:58:38 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] rtc: isl12022: add support for trip level DT binding
Date:   Thu, 15 Jun 2023 12:58:22 +0200
Message-Id: <20230615105826.411953-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230615105826.411953-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230615105826.411953-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for using the values given in the
isil,battery-trip-levels-microvolt property to set appropriate values
in the VB85TP/VB75TP bits in the PWR_VBAT register.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index ebd66b835cef..6a757f0a4736 100644
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
@@ -209,6 +215,38 @@ static const struct regmap_config regmap_config = {
 	.use_single_write = true,
 };
 
+static const u32 trip_levels[2][7] = {
+	{ 2125000, 2295000, 2550000, 2805000, 3060000, 4250000, 4675000 },
+	{ 1875000, 2025000, 2250000, 2475000, 2700000, 3750000, 4125000 },
+};
+
+static void isl12022_set_trip_levels(struct device *dev)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	u32 levels[2] = {0, 0};
+	int ret, i, j, x[2];
+	u8 val, mask;
+
+	device_property_read_u32_array(dev, "isil,battery-trip-levels-microvolt",
+				       levels, 2);
+
+	for (i = 0; i < 2; i++) {
+		for (j = 0; j < ARRAY_SIZE(trip_levels[i]) - 1; j++) {
+			if (levels[i] <= trip_levels[i][j])
+				break;
+		}
+		x[i] = j;
+	}
+
+	val = FIELD_PREP(ISL12022_REG_VB85_MASK, x[0]) |
+		FIELD_PREP(ISL12022_REG_VB75_MASK, x[1]);
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
@@ -225,6 +263,7 @@ static int isl12022_probe(struct i2c_client *client)
 
 	dev_set_drvdata(&client->dev, regmap);
 
+	isl12022_set_trip_levels(&client->dev);
 	isl12022_hwmon_register(&client->dev);
 
 	rtc = devm_rtc_allocate_device(&client->dev);
-- 
2.37.2

