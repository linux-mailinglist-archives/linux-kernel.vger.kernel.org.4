Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D4E72E3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242546AbjFMNB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242499AbjFMNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:01:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456D410E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:01:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f649db9b25so6691340e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686661272; x=1689253272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46KkCoyCaP4pL/jEPklf2fuk5AVWyAvfGth05Co0T18=;
        b=haQOPWKa3ER2duykMm+Sd0Nw4FfDB0m4UkrtopsZoLbZe5z0EQuBlcfaZjRcVf7oI7
         gSOYW1J5eCDYEE938vG6q9t9zkVV1LYsz1/P0Ya6BTaYoYiY2lRDk6SfKNE6FV+Qc1+D
         QK/hgXfh4ct2iLAwQgA0Z8UuyFOUsvcCdAGS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686661272; x=1689253272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46KkCoyCaP4pL/jEPklf2fuk5AVWyAvfGth05Co0T18=;
        b=EcOACeSCe7ROQKiIczjgQoFL0nDkecoJnz2O2LiJUnfb8xGx9TN0NdfpR6pQDHLUGG
         KSAUYEpdmzPVtBrA4HX1Iz/JZPBucRglMXKS2JX4HeGwcubTx1/awKy58uXIcxI7OqRF
         n2eypMQrkxfkg3GXH6RWHFW8seeNMcWz4XpsuNp9MSwWFatLfAFpw1AnVRRBTu0TNj1U
         thhdl+NhcQATe90GqfmXXryV9UsUGe+evbxyqYKOWDbMz5UfmTzishFZUq8AKOuxJZdu
         YXD30DUD/pRwOTwh71Zfa4UD/I7bT76YAkhLICk3rIeqqYLPebDQm32YDqhwbh+kwFw0
         WduA==
X-Gm-Message-State: AC+VfDy8mTidhPjNZh4rjT2Vm7twa/j1U7rsCtgphEfJscovopJ3/2Yr
        OgeCIg8dN6ENZYZnF3yjztCwxw==
X-Google-Smtp-Source: ACHHUZ73JuWNHjEuDGnIJzA9IFe0ASfyWKtlyLgVfjFM/EXl0T/cvjy8lsrXXCSpjHmDHJbHAFtFnQ==
X-Received: by 2002:a19:771d:0:b0:4f6:217a:561e with SMTP id s29-20020a19771d000000b004f6217a561emr5797407lfc.37.1686661272390;
        Tue, 13 Jun 2023 06:01:12 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u24-20020ac243d8000000b004f14ae5ded8sm1793786lfl.28.2023.06.13.06.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:01:11 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] rtc: isl12022: implement support for the #clock-cells DT property
Date:   Tue, 13 Jun 2023 15:00:10 +0200
Message-Id: <20230613130011.305589-9-linux@rasmusvillemoes.dk>
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
 drivers/rtc/rtc-isl12022.c | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 44603169e575..3e69f1a5dc12 100644
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
@@ -241,6 +245,37 @@ static const struct regmap_config regmap_config = {
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
+	/*
+	 * For now, only support a fixed clock of 32768Hz (the reset default).
+	 */
+	ret = regmap_update_bits(regmap, ISL12022_REG_INT, ISL12022_INT_FO_MASK, ISL12022_INT_FO_32K);
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
 static const u32 trip_level85[] = { 2125000, 2295000, 2550000, 2805000, 3060000, 4250000, 4675000 };
 static const u32 trip_level75[] = { 1875000, 2025000, 2250000, 2475000, 2700000, 3750000, 4125000 };
 
@@ -284,6 +319,7 @@ static int isl12022_probe(struct i2c_client *client)
 {
 	struct rtc_device *rtc;
 	struct regmap *regmap;
+	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -296,6 +332,10 @@ static int isl12022_probe(struct i2c_client *client)
 
 	dev_set_drvdata(&client->dev, regmap);
 
+	ret = isl12022_register_clock(&client->dev);
+	if (ret)
+		return ret;
+
 	isl12022_set_trip_levels(&client->dev);
 	isl12022_hwmon_register(&client->dev);
 
-- 
2.37.2

