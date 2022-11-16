Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84F762B2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiKPFiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiKPFid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:38:33 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B656255
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id v17so15469340plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwwwsx9jfrJYamHfIH6HX3vvIu1imMZZ+4VMVekHngI=;
        b=Rz/H6Ys2b4kWwW4r+rY3Jxp4B3laBIYMyVHy+ATKWcjmUG6PH8ujJdN8Fi/r9jAO6M
         zXmJUNicma4dyKgKg7LASOVGFUZ5nuYwk3YNKQ3yqEGHLcAVDb5FF8XBSdfWOeqIf+qP
         MxutMrZhNcpgQLhQNUK4Ds57v2FY6T/uFnq8r0RpFNN35QPG4adlGJo2hlyKRwYVwkd6
         aFiVWAkUxmHqw//S4QM9JYBRZGwP9/DiToLBd1477MPMIzzW4QhM5CU+Z7djk/4DobR2
         9PHSXED1uBKmfG91qTCVmZljBbLQ6NZMdE/Fr8ILkV3lB2ecEmECyatxEo1kbcwvwdrh
         Q6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwwwsx9jfrJYamHfIH6HX3vvIu1imMZZ+4VMVekHngI=;
        b=LBDnCoDACPoZB5d+ACUbvg9I/hVivT5zVuu25m1UPriqzPZs+E/4XF3Mx2lzLY/gah
         kPjIroAQ4+S8ndUQP6yn6jIGT05F6glZis7CqhEGgNgjUQtYl5QzW/kvdJNVbgDh0JBE
         eddsFh7rtM3Ia8lGjorc6V/FYLd6xH4lKII2ubmjFpomhCcMZfHVsRY2I+jOlTlcN77M
         fx+tUhboGS7+OdKJ7/SeTx3bf3AtRglFeBoS6ffo02drTfq8DiwVJ+UneqsL8EWd5NdZ
         GRfFA9h8M/EF/Nf1YQycwgh7LxPoqyzDmqtUxG9l60UjBidhpCZyjZADGqbTcMkfcFgD
         ooUA==
X-Gm-Message-State: ANoB5pnNj/d6CfnkcxG+rEgxe1N1hN8w6ynSRQHvjCri5YR2EdoVMgVi
        MoLojBQEyL/Tud0NGaLyMMM=
X-Google-Smtp-Source: AA0mqf5l1i6JvOL677NV16OYZ271oU6KdmQuaLgLz6SgdGOyQljKX6FdQNZvo2/6XxEUOK0zI/8Aqg==
X-Received: by 2002:a17:902:900b:b0:17f:8544:e0dd with SMTP id a11-20020a170902900b00b0017f8544e0ddmr7619256plp.34.1668577111537;
        Tue, 15 Nov 2022 21:38:31 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017834a6966csm10881038plb.176.2022.11.15.21.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:38:30 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 06/11] ASoC: tlv320aic32x4: remove support for platform data
Date:   Tue, 15 Nov 2022 21:38:12 -0800
Message-Id: <20221116053817.2929810-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
References: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users of aic32x4_pdata in the mainline kernel, remove it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/sound/tlv320aic32x4.h    | 52 --------------------------------
 sound/soc/codecs/tlv320aic32x4.c | 14 +++------
 sound/soc/codecs/tlv320aic32x4.h | 27 +++++++++++++++++
 3 files changed, 32 insertions(+), 61 deletions(-)
 delete mode 100644 include/sound/tlv320aic32x4.h

diff --git a/include/sound/tlv320aic32x4.h b/include/sound/tlv320aic32x4.h
deleted file mode 100644
index 0abf74d7edbd..000000000000
--- a/include/sound/tlv320aic32x4.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * tlv320aic32x4.h  --  TLV320AIC32X4 Soc Audio driver platform data
- *
- * Copyright 2011 Vista Silicon S.L.
- *
- * Author: Javier Martin <javier.martin@vista-silicon.com>
- */
-
-#ifndef _AIC32X4_PDATA_H
-#define _AIC32X4_PDATA_H
-
-#define AIC32X4_PWR_MICBIAS_2075_LDOIN		0x00000001
-#define AIC32X4_PWR_AVDD_DVDD_WEAK_DISABLE	0x00000002
-#define AIC32X4_PWR_AIC32X4_LDO_ENABLE		0x00000004
-#define AIC32X4_PWR_CMMODE_LDOIN_RANGE_18_36	0x00000008
-#define AIC32X4_PWR_CMMODE_HP_LDOIN_POWERED	0x00000010
-
-#define AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K	0x00000001
-#define AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K	0x00000002
-
-/* GPIO API */
-#define AIC32X4_MFPX_DEFAULT_VALUE	0xff
-
-#define AIC32X4_MFP1_DIN_DISABLED	0
-#define AIC32X4_MFP1_DIN_ENABLED	0x2
-#define AIC32X4_MFP1_GPIO_IN		0x4
-
-#define AIC32X4_MFP2_GPIO_OUT_LOW	0x0
-#define AIC32X4_MFP2_GPIO_OUT_HIGH	0x1
-
-#define AIC32X4_MFP_GPIO_ENABLED	0x4
-
-#define AIC32X4_MFP5_GPIO_DISABLED	0x0
-#define AIC32X4_MFP5_GPIO_INPUT		0x8
-#define AIC32X4_MFP5_GPIO_OUTPUT	0xc
-#define AIC32X4_MFP5_GPIO_OUT_LOW	0x0
-#define AIC32X4_MFP5_GPIO_OUT_HIGH	0x1
-
-struct aic32x4_setup_data {
-	unsigned int gpio_func[5];
-};
-
-struct aic32x4_pdata {
-	struct aic32x4_setup_data *setup;
-	u32 power_cfg;
-	u32 micpga_routing;
-	bool swapdacs;
-	int rstn_gpio;
-};
-
-#endif
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index ffe1828a4b7e..2dd0fe255ee6 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -22,7 +22,6 @@
 #include <linux/of_clk.h>
 #include <linux/regulator/consumer.h>
 
-#include <sound/tlv320aic32x4.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -33,6 +32,10 @@
 
 #include "tlv320aic32x4.h"
 
+struct aic32x4_setup_data {
+	unsigned int gpio_func[5];
+};
+
 struct aic32x4_priv {
 	struct regmap *regmap;
 	u32 power_cfg;
@@ -1336,7 +1339,6 @@ static int aic32x4_setup_regulators(struct device *dev,
 int aic32x4_probe(struct device *dev, struct regmap *regmap)
 {
 	struct aic32x4_priv *aic32x4;
-	struct aic32x4_pdata *pdata = dev->platform_data;
 	struct device_node *np = dev->of_node;
 	int ret;
 
@@ -1353,13 +1355,7 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 
 	dev_set_drvdata(dev, aic32x4);
 
-	if (pdata) {
-		aic32x4->power_cfg = pdata->power_cfg;
-		aic32x4->swapdacs = pdata->swapdacs;
-		aic32x4->micpga_routing = pdata->micpga_routing;
-		aic32x4->rstn_gpio = pdata->rstn_gpio;
-		aic32x4->mclk_name = "mclk";
-	} else if (np) {
+	if (np) {
 		ret = aic32x4_parse_dt(aic32x4, np);
 		if (ret) {
 			dev_err(dev, "Failed to parse DT node\n");
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 4de5bd9e8cc5..f0724b6b17ee 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -232,4 +232,31 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
 #define AIC32X4_MAX_CODEC_CLKIN_FREQ    110000000
 #define AIC32X4_MAX_PLL_CLKIN		20000000
 
+#define AIC32X4_PWR_MICBIAS_2075_LDOIN		0x00000001
+#define AIC32X4_PWR_AVDD_DVDD_WEAK_DISABLE	0x00000002
+#define AIC32X4_PWR_AIC32X4_LDO_ENABLE		0x00000004
+#define AIC32X4_PWR_CMMODE_LDOIN_RANGE_18_36	0x00000008
+#define AIC32X4_PWR_CMMODE_HP_LDOIN_POWERED	0x00000010
+
+#define AIC32X4_MICPGA_ROUTE_LMIC_IN2R_10K	0x00000001
+#define AIC32X4_MICPGA_ROUTE_RMIC_IN1L_10K	0x00000002
+
+/* GPIO API */
+#define AIC32X4_MFPX_DEFAULT_VALUE	0xff
+
+#define AIC32X4_MFP1_DIN_DISABLED	0
+#define AIC32X4_MFP1_DIN_ENABLED	0x2
+#define AIC32X4_MFP1_GPIO_IN		0x4
+
+#define AIC32X4_MFP2_GPIO_OUT_LOW	0x0
+#define AIC32X4_MFP2_GPIO_OUT_HIGH	0x1
+
+#define AIC32X4_MFP_GPIO_ENABLED	0x4
+
+#define AIC32X4_MFP5_GPIO_DISABLED	0x0
+#define AIC32X4_MFP5_GPIO_INPUT		0x8
+#define AIC32X4_MFP5_GPIO_OUTPUT	0xc
+#define AIC32X4_MFP5_GPIO_OUT_LOW	0x0
+#define AIC32X4_MFP5_GPIO_OUT_HIGH	0x1
+
 #endif				/* _TLV320AIC32X4_H */
-- 
2.38.1.431.g37b22c650d-goog

