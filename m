Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F9B62B2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiKPFjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiKPFip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:38:45 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE42F3B1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:41 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 6so15679745pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1IwnG/hkjmxOvKDimBi/CuJjoVrJcOnhShxdmIQmZM=;
        b=AJH+sKrgK8wjc0DzG0SIQ7l1SSdtx55kH1AEFOqUsobc7Y7+O7Z44slvWjjsdTpVLE
         rRI7V8xfg0yqJZef/dCf41xX8Rpc2rgwEOZU8Hfg4hGt5LWXz+sDnLhs0NcG63BJKnMI
         UhxI0dTqPhc0b3X42PNLFigo/BQNY0g+ZRZt8CKy9CT2P1qk49ESs7VINIvMnRiwiqkw
         rU6DAMgSR2x9ygBn9BOzq2IJIUr/3EZMWzuwE+rN34PZ0f3rTHTjkmD4dn/KhFKJ+MbD
         QyeMz2cgGtcXis+IdLypKJgofMzjCDmYAxPtrv7XWDcGSmR2ZQqAmkjNvd96VPx6/HHE
         s0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1IwnG/hkjmxOvKDimBi/CuJjoVrJcOnhShxdmIQmZM=;
        b=YdEjACWvfdjkHeA7hATbgEc4BlDV3t213PXDs9Dp1AnGhmgJwu+1e5F4hc1bpOVDBJ
         UC0vQNgnVy+COosFUR3xf3Kc9ERVcPTcxhU7ufUaBEqomBk/Z5X0p+N0/L/4fY6e54b5
         jyu0dBxzP/DtlXU3vEh64p+VJ/LWLRSWwgNkzGk+hsV7vW+mMFcUBkJ8w2fT1gXVwwnB
         up7kaMY6f8b4ce3B9LselOOMaVo/oNeGXgF/remuRMqvB0CTcqTEdGfVafKvCwMuOQVA
         gBUz0/kUUlwOLigojDzY8u8qb+c1g5FCmcdnJ1mAQC1XooiZT7bGqb64RljQ42M5W7F0
         UupQ==
X-Gm-Message-State: ANoB5pmldAtAMULd4TXPVQSU4RUptdMn9PDQgYOP8CA200ixCHxTo4TA
        K5WvGp3xPVftgkeTY7ZgF9S3CD0ntqw=
X-Google-Smtp-Source: AA0mqf6NXcALMKPdpbXz4RgcSqvLnP/6gMKWXgP7QBDEKte7NKuqA15W/jE79PCse92kRUTjqGLFWA==
X-Received: by 2002:a62:7955:0:b0:56b:e64c:5c7e with SMTP id u82-20020a627955000000b0056be64c5c7emr21484613pfc.18.1668577120853;
        Tue, 15 Nov 2022 21:38:40 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017834a6966csm10881038plb.176.2022.11.15.21.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:38:40 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 11/11] ASoC: wcd938x: switch to using gpiod API
Date:   Tue, 15 Nov 2022 21:38:17 -0800
Message-Id: <20221116053817.2929810-11-dmitry.torokhov@gmail.com>
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

Switch the driver from legacy gpio API that is deprecated to the newer
gpiod API that respects line polarities described in ACPI/DT.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/codecs/wcd938x.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index aca06a4026f3..b85bc750c7e0 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -6,12 +6,14 @@
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pm_runtime.h>
 #include <linux/component.h>
 #include <sound/tlv.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
@@ -194,7 +196,7 @@ struct wcd938x_priv {
 	int flyback_cur_det_disable;
 	int ear_rx_path;
 	int variant;
-	int reset_gpio;
+	struct gpio_desc *reset_gpio;
 	struct gpio_desc *us_euro_gpio;
 	u32 micb1_mv;
 	u32 micb2_mv;
@@ -4234,18 +4236,19 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 	struct wcd_mbhc_config *cfg = &wcd938x->mbhc_cfg;
 	int ret;
 
-	wcd938x->reset_gpio = of_get_named_gpio(dev->of_node, "reset-gpios", 0);
-	if (wcd938x->reset_gpio < 0) {
-		dev_err(dev, "Failed to get reset gpio: err = %d\n",
-			wcd938x->reset_gpio);
-		return wcd938x->reset_gpio;
+	wcd938x->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);
+	ret = PTR_ERR_OR_ZERO(wcd938x->reset_gpio);
+	if (ret) {
+		dev_err(dev, "Failed to get reset gpio: err = %d\n", ret);
+		return ret;
 	}
 
 	wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro",
 						GPIOD_OUT_LOW);
-	if (IS_ERR(wcd938x->us_euro_gpio)) {
+	ret = PTR_ERR_OR_ZERO(wcd938x->us_euro_gpio);
+	if (ret) {
 		dev_err(dev, "us-euro swap Control GPIO not found\n");
-		return PTR_ERR(wcd938x->us_euro_gpio);
+		return ret;
 	}
 
 	cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
@@ -4285,11 +4288,11 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
 
 static int wcd938x_reset(struct wcd938x_priv *wcd938x)
 {
-	gpio_direction_output(wcd938x->reset_gpio, 0);
-	/* 20us sleep required after pulling the reset gpio to LOW */
+	gpiod_set_value_cansleep(wcd938x->reset_gpio, 1);
+	/* 20us sleep required after asserting the reset gpio */
 	usleep_range(20, 30);
-	gpio_set_value(wcd938x->reset_gpio, 1);
-	/* 20us sleep required after pulling the reset gpio to HIGH */
+	gpiod_set_value_cansleep(wcd938x->reset_gpio, 0);
+	/* 20us sleep required after releasing the reset gpio */
 	usleep_range(20, 30);
 
 	return 0;
-- 
2.38.1.431.g37b22c650d-goog

