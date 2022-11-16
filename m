Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3EF62B2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiKPFjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiKPFii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:38:38 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE804AE4B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:37 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l6so15599318pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTyuvgruJxkGjK2lPmWOPAqXK8rk+Mma5cjclFSB/P4=;
        b=isKr2CHWgMPKfi62JRy35GEXHE5fa0vHOmDyfUegLY1FC8fuXQTi14lkZ/Gr1JWyqp
         apNloEjjEmXw7M4yebsCw0DkxcZtGuUQvYT2z6GJNsEQbKbPJSGLTrWt0gZgauQ5RSyS
         pZS/0BrY0+rd8pRdk2lxCxsOUIUm53iOeRTpgulfwpPvgT9xrh6s6AJpOyc2K8e47dod
         jkAzUlTVwKflYnao+eZWJ0bxf7nxTWI9ACCIsO7G4YT/6sC7K9P4byJCz+nePkePvYB+
         Izq9DLBzzVD55oEnvQjvHDMuvtMVfDHAjHk3yJmrvjBuXtw/X4dqqN2ORECgAbfL5xYE
         Nj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTyuvgruJxkGjK2lPmWOPAqXK8rk+Mma5cjclFSB/P4=;
        b=hOqghfS4RAbaxeJo8RSPWEH2uFRoV/fqpkyfivsRhHxWqjqoWL769yPdoB9h+yxaGe
         UGYb4a5RVZ3OTGoq51/t8AEx9PAB+aKUhTFcvXK6bMlBjVTx/o/Sfhfl3/HkCkijpfmu
         QcZoyjhuLUS1A6HfaQkDozO4PipFsO1Wfk5h0K0l73ZOcGg+HQky53A7wKW/V8McaL6c
         QoWdUV/Lqhd2Yy9h9Q1fFbiUSeoptWcpFMQVjMIJBQcV1I7JUys5Xskg9bmVYwyn8OR7
         dIMA5A1JO9Et9Uxfi0rSU/L1jLKatBgbMEp1GsUoS4BPb82dNkBXE1bVPve7TXQpSpEG
         IvgQ==
X-Gm-Message-State: ANoB5pk9C8TSpxaunSY3NTWmVva8hI4+TtTZa+KiF9tfJL1T3AXuG9LY
        rWetO+C/A0zdWpVbSFDIfWfcVoEsXXY=
X-Google-Smtp-Source: AA0mqf7T9R9bl1VF3b67lvjkzgbb0ZPUNJ3DTdNrfya/g9dsluA4pZrfvDVx2bshz7znLR5EfemOyg==
X-Received: by 2002:a17:902:b781:b0:186:8a1e:5055 with SMTP id e1-20020a170902b78100b001868a1e5055mr7368084pls.116.1668577117200;
        Tue, 15 Nov 2022 21:38:37 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017834a6966csm10881038plb.176.2022.11.15.21.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:38:36 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 09/11] ASoC: wcd9335: switch to using gpiod API
Date:   Tue, 15 Nov 2022 21:38:15 -0800
Message-Id: <20221116053817.2929810-9-dmitry.torokhov@gmail.com>
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

Also the old code did not actually request the reset line, but was
toggling it directly; this has been fixed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/codecs/wcd9335.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index d2548fdf9ae5..27cbec3e6763 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -11,12 +11,13 @@
 #include <linux/regulator/consumer.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/slimbus.h>
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 #include <sound/soc-dapm.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <sound/tlv.h>
@@ -329,7 +330,7 @@ struct wcd9335_codec {
 	int comp_enabled[COMPANDER_MAX];
 
 	int intr1;
-	int reset_gpio;
+	struct gpio_desc *reset_gpio;
 	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
 
 	unsigned int rx_port_value[WCD9335_RX_MAX];
@@ -5032,25 +5033,27 @@ static const struct regmap_irq_chip wcd9335_regmap_irq1_chip = {
 static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
 {
 	struct device *dev = wcd->dev;
-	struct device_node *np = dev->of_node;
 	int ret;
 
-	wcd->reset_gpio = of_get_named_gpio(np,	"reset-gpios", 0);
-	if (wcd->reset_gpio < 0) {
-		dev_err(dev, "Reset GPIO missing from DT\n");
-		return wcd->reset_gpio;
+	wcd->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	ret = PTR_ERR_OR_ZERO(wcd->reset_gpio);
+	if (ret) {
+		dev_err(dev, "failed to request reset GPIO: %d\n", ret);
+		return ret;
 	}
 
 	wcd->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(wcd->mclk)) {
-		dev_err(dev, "mclk not found\n");
-		return PTR_ERR(wcd->mclk);
+	ret = PTR_ERR_OR_ZERO(wcd->mclk);
+	if (ret) {
+		dev_err(dev, "mclk not found: %d\n", ret);
+		return ret;
 	}
 
 	wcd->native_clk = devm_clk_get(dev, "slimbus");
-	if (IS_ERR(wcd->native_clk)) {
-		dev_err(dev, "slimbus clock not found\n");
-		return PTR_ERR(wcd->native_clk);
+	ret = PTR_ERR_OR_ZERO(wcd->native_clk);
+	if (ret) {
+		dev_err(dev, "slimbus clock not found: %d\n", ret);
+		return ret;
 	}
 
 	wcd->supplies[0].supply = "vdd-buck";
@@ -5088,9 +5091,9 @@ static int wcd9335_power_on_reset(struct wcd9335_codec *wcd)
 	 */
 	usleep_range(600, 650);
 
-	gpio_direction_output(wcd->reset_gpio, 0);
+	gpiod_set_value_cansleep(wcd->reset_gpio, 1);
 	msleep(20);
-	gpio_set_value(wcd->reset_gpio, 1);
+	gpiod_set_value_cansleep(wcd->reset_gpio, 0);
 	msleep(20);
 
 	return 0;
-- 
2.38.1.431.g37b22c650d-goog

