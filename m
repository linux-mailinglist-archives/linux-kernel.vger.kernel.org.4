Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66E47315F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbjFOK7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjFOK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:58:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739FB2967
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:58:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f764e92931so2949811e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686826731; x=1689418731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guPKntobdnOXU3BYd6z8xQJYVopEOSCbah3uJeL+Sfw=;
        b=TEHAhgNm41CCRwEVD8tBtQTviwEd/ignaLVJWRkWLDVKPmae6V133qtn9YFXa8tk4n
         VO7KHvcb/mC7MddDywgjRsid1Ro49PtUNuzEq1MGncUjwITeqHJiK0HuCXx6yw4647Xc
         M/9m2nrHUKo4NAYIN1uGgRfwzvtgPDzw58UgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686826731; x=1689418731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guPKntobdnOXU3BYd6z8xQJYVopEOSCbah3uJeL+Sfw=;
        b=IWd1hOqQg8k0RicrbWzkq/n8bdCF5yhzAv8XYBSY15ht3bTYdzmANzF7gaP5iE09sK
         qRWryNF4OkD5hj0LCz1xmv2+Ab80QIRno+HAXsoZ284MPYQdQGzlKpIsnUEjipXvRkeP
         oaLOizVE4+flLOolYt2qZCFyytSRsaD/yzatKXQYtcsuwlF0LSegVG0ajJ7pV+FYpdAU
         4ad9nZddzYL7IrQ9ig90FTT6/UjJmbxTROMs2oPwpUcQS5l6FxjTnYaAuFNcQGmiA3JC
         2ktnYJ5CG9D4q2FT6ghv0xdrRjEVyvoG8D+M/KdHAWwSAT/BX6OpYOxzzONnL3TSBfvV
         o2CA==
X-Gm-Message-State: AC+VfDyQ8ClewhswcIW402djGu485YUxcZMM17YiVqjQ9PpoVH1s3Grs
        Gl1p4FpbTUYIkH7v2q4kvQh21g==
X-Google-Smtp-Source: ACHHUZ6cP/1mx3rG6mCoceJ9Evt/5HsBXHmUVs8oH0mPAJ2eLChokCNNCJMmK0dwCKlxpnttwIgEuQ==
X-Received: by 2002:a19:5045:0:b0:4f6:8156:f6e with SMTP id z5-20020a195045000000b004f681560f6emr7771691lfj.53.1686826730778;
        Thu, 15 Jun 2023 03:58:50 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h7-20020ac25967000000b004f13f4ec267sm165364lfp.186.2023.06.15.03.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:58:50 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] rtc: isl12022: implement support for the #clock-cells DT property
Date:   Thu, 15 Jun 2023 12:58:26 +0200
Message-Id: <20230615105826.411953-9-linux@rasmusvillemoes.dk>
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
 drivers/rtc/rtc-isl12022.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 916879b0388c..05f50ab0e69a 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -10,6 +10,7 @@
 
 #include <linux/bcd.h>
 #include <linux/bitfield.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/i2c.h>
@@ -44,6 +45,9 @@
 #define ISL12022_SR_LBAT75	(1 << 1)
 
 #define ISL12022_INT_WRTC	(1 << 6)
+#define ISL12022_INT_FO_MASK	GENMASK(3, 0)
+#define ISL12022_INT_FO_OFF	0x0
+#define ISL12022_INT_FO_32K	0x1
 
 #define ISL12022_REG_VB85_MASK	GENMASK(5, 3)
 #define ISL12022_REG_VB75_MASK	GENMASK(2, 0)
@@ -242,6 +246,41 @@ static const struct regmap_config regmap_config = {
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
+		regmap_update_bits(regmap, ISL12022_REG_INT, ISL12022_INT_FO_MASK,
+				   ISL12022_INT_FO_OFF);
+
+		return 0;
+	}
+
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		return 0;
+
+	/*
+	 * For now, only support a fixed clock of 32768Hz (the reset default).
+	 */
+	ret = regmap_update_bits(regmap, ISL12022_REG_INT,
+				 ISL12022_INT_FO_MASK, ISL12022_INT_FO_32K);
+	if (ret)
+		return ret;
+
+	hw = devm_clk_hw_register_fixed_rate(dev, "isl12022", NULL, 0, 32768);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
 static const u32 trip_levels[2][7] = {
 	{ 2125000, 2295000, 2550000, 2805000, 3060000, 4250000, 4675000 },
 	{ 1875000, 2025000, 2250000, 2475000, 2700000, 3750000, 4125000 },
@@ -288,6 +327,7 @@ static int isl12022_probe(struct i2c_client *client)
 {
 	struct rtc_device *rtc;
 	struct regmap *regmap;
+	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -300,6 +340,10 @@ static int isl12022_probe(struct i2c_client *client)
 
 	dev_set_drvdata(&client->dev, regmap);
 
+	ret = isl12022_register_clock(&client->dev);
+	if (ret)
+		return ret;
+
 	isl12022_set_trip_levels(&client->dev);
 	isl12022_hwmon_register(&client->dev);
 
-- 
2.37.2

