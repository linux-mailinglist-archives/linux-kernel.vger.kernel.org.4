Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA572C33B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjFLLks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbjFLLiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:38:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6827EFC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f65779894eso4082206e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686569473; x=1689161473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVISWVLRgW0K7WAKXrrtHEIUr0IbbMXljAPQm1SU8cU=;
        b=GUirDWmfHeI1PQqvm31QSDtYOSZU83I1TUeXFUGgB/IDFtareX0LOnPd3d4MHo+SvB
         /LriIHBvcpXzsvClIDa/fc3We2zpJVGoy8P+UZa977vOiVipohu/T/bqQtLI3dndRweE
         fEQPS78uw6+XpzyHIeyu5jhU2lVehHPDZUZOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686569473; x=1689161473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVISWVLRgW0K7WAKXrrtHEIUr0IbbMXljAPQm1SU8cU=;
        b=L6RffE/rIYnFxiBXu6PAihLyGam+1HSo50FJ/Dw6bxa7SdTTaP1DOUANV9jS//2uY/
         CduGdq6yfKYX9ErjSb0VKWx4a4hiAktRoL6sVwiPpPm9oAYDR2ct1kKVQDdsFvvwhmJP
         V62tKawWaZe1JqbpiFbOyTk/x9PsGKHRRCRd5dSOLmfko9Todwzl99hOyqOOg3K2AGOK
         AiRU6CPr19ZKUchYHkjdMcR6380BShrJQTUyYQEpTu3/bAUSU5Zum4l6xxl6Vi6Edbxb
         kZkPaUh9JcRGAzg+KUn2IOMp/0JK/TSH1FMzy7MukOGN1Mex/YqsGWOzNr7faOG5+rc0
         DPTA==
X-Gm-Message-State: AC+VfDzUy08O1oMQ32q7ZisXb3mfFDFrfnv+3vQYCYbFaOC+qq7Xysn9
        ZVqj2pgkJcqDaCrAeCk7JBr4Dg==
X-Google-Smtp-Source: ACHHUZ4DO2f4AqARomXkmwy7A7bD4vgSbeOpkJmstbgRVEc/JnlEHVFXdAUVaNOIfvdiIbVhuxyX0g==
X-Received: by 2002:ac2:465d:0:b0:4f4:b28d:73e8 with SMTP id s29-20020ac2465d000000b004f4b28d73e8mr3067413lfo.17.1686569473683;
        Mon, 12 Jun 2023 04:31:13 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w26-20020a19c51a000000b004edb8fac1cesm1399320lfe.215.2023.06.12.04.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 04:31:13 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] rtc: isl12022: implement support for the #clock-cells DT property
Date:   Mon, 12 Jun 2023 13:30:58 +0200
Message-Id: <20230612113059.247275-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
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

If device tree implies that the chip's IRQ/F_OUT pin is used as a
clock, expose that in the driver. For now, pretend it is a
fixed-rate (32kHz) clock; if other use cases appear the driver can be
updated to provide its own clk_ops etc.

When the clock output is not used on a given board, one can prolong
the battery life by ensuring that the FOx bits are 0. For the hardware
I'm currently working on, the RTC draws 1.2uA with the FOx bits at
their default 0001 value, dropping to 0.88uA when those bits are
cleared.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 690dbb446d1a..0054300b744b 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/i2c.h>
@@ -43,6 +44,9 @@
 #define ISL12022_SR_LBAT75	(1 << 1)
 
 #define ISL12022_INT_WRTC	(1 << 6)
+#define ISL12022_INT_FO_MASK	GENMASK(3, 0)
+#define ISL12022_INT_FO_OFF	0x0
+#define ISL12022_INT_FO_32K	0x1
 
 #define ISL12022_REG_VB85_MASK	GENMASK(5, 3)
 #define ISL12022_REG_VB75_MASK	GENMASK(2, 0)
@@ -255,6 +259,38 @@ static const struct regmap_config regmap_config = {
 	.use_single_write = true,
 };
 
+static int isl12022_register_clock(struct device *dev)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	struct clk_hw *hw;
+	int ret;
+
+	if (!device_property_present(dev, "#clock-cells")) {
+		/*
+		 * Disabling the F_OUT pin reduces the power
+		 * consumption in battery mode by ~25%.
+		 */
+		ret = regmap_update_bits(regmap, ISL12022_REG_INT, ISL12022_INT_FO_MASK,
+					 ISL12022_INT_FO_OFF);
+		if (ret)
+			dev_warn(dev, "failed to clear FOx bits in INT register: %d", ret);
+		return 0;
+	}
+
+	/*
+	 * For now, only support a fixed clock of 32768Hz (the reset default).
+	 */
+	ret = regmap_update_bits(regmap, ISL12022_REG_INT, ISL12022_INT_FO_MASK, ISL12022_INT_FO_32K);
+	if (ret)
+		return ret;
+
+	hw = devm_clk_hw_register_fixed_rate(dev, "isl12022_32kHz", NULL, 0, 32768);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
 static const u32 trip_level85[] = { 2125000, 2295000, 2550000, 2805000, 3060000, 4250000, 4675000 };
 static const u32 trip_level75[] = { 1875000, 2025000, 2250000, 2475000, 2700000, 3750000, 4125000 };
 
@@ -305,6 +341,7 @@ static int isl12022_probe(struct i2c_client *client)
 {
 	struct rtc_device *rtc;
 	struct regmap *regmap;
+	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -317,6 +354,10 @@ static int isl12022_probe(struct i2c_client *client)
 
 	dev_set_drvdata(&client->dev, regmap);
 
+	ret = isl12022_register_clock(&client->dev);
+	if (ret)
+		return ret;
+
 	isl12022_set_trip_levels(&client->dev);
 	isl12022_hwmon_register(&client->dev);
 
-- 
2.37.2

