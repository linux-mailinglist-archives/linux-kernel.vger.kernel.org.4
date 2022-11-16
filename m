Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0962B2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiKPFjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiKPFie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:38:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D016A1025
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:33 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so1363862pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULkwCXln6lxM8XLag0GHNaSgcab1VgWTlrPLPEn1RmQ=;
        b=WKM+2PzQbhMeOBeGQywY/g11Pnn37fKCeJCt+lwYnk221uHqyJTf2HoAQyuSvu64nO
         brBFlwq5l+XR8hlqRvjKYtb9hsQtQmyeupF7wTqWtL6ovpyDzxx/CR0TmRmccJ2ENp74
         CaRfmDhGkLcsG47C1XDf0+LG1i7+nUTJ7M0IGG6NHTDmvdZkDR6nOuvsxyWw3wQRixzZ
         RTozclXB95iYqCQaPK/PRoE/OFUcDNDDjP2hsVbYgO6qd2lNNa9sn8F+2m/qnwnUqk5v
         cVcH1Cd7m/3QTkeUpRFRxDU9njOzlNy9rJr5La6m0Ai2k5T9OlZ29M5h1k8XhfV0GMUi
         Em+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULkwCXln6lxM8XLag0GHNaSgcab1VgWTlrPLPEn1RmQ=;
        b=mbcAZtXKAUeKWonoeHPZqKRDX1oCJxwY2C2TqJN495F6KVudFKL3uEcQSEJbyzvnP2
         WtzSOLjqbusvgnuxUeQRhVa2fwZy4ZNha+ANC7sX3BDj/hlhyu1lsHkaJ2LGem20ttpl
         ah3uHTQFRRgnZMoMZY61JatMvW/mHfpjumLQtpCjl6pcpF+2kSA+2NABRU3w/AQHvP6N
         TgstspRuD8jJ7fP/EUcOhueQ3zrWJK930SRiGdLuo6ldDzDAns+zmoW16+A/LVyThEI4
         koDNKHYkOG24x/DKFPT7DgUt00dTobpSUund3ZhgZQeekbrESz4fAHuSEzw7ylA1r0kU
         HIjw==
X-Gm-Message-State: ANoB5pkCWmUP4ZxX9CQmPqf80y/ioef8raQNMNONJcfy8dsYaCsa5O7j
        srJ6h5yLBZBEs64TafqsvKE=
X-Google-Smtp-Source: AA0mqf5uVWst6sre4JVfG7hacQt648w/wagbo1T0Ve8WMKn0tELymV4vaRkGXceh0dDwV+YXo9CPkg==
X-Received: by 2002:a17:903:3311:b0:188:4ea8:a687 with SMTP id jk17-20020a170903331100b001884ea8a687mr7401524plb.120.1668577113192;
        Tue, 15 Nov 2022 21:38:33 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017834a6966csm10881038plb.176.2022.11.15.21.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:38:32 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 07/11] ASoC: tlv320aic32x4: switch to using gpiod API
Date:   Tue, 15 Nov 2022 21:38:13 -0800
Message-Id: <20221116053817.2929810-7-dmitry.torokhov@gmail.com>
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
 sound/soc/codecs/tlv320aic32x4.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 2dd0fe255ee6..36a3b3eb4d56 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -13,9 +13,9 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/pm.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
@@ -41,7 +41,7 @@ struct aic32x4_priv {
 	u32 power_cfg;
 	u32 micpga_routing;
 	bool swapdacs;
-	int rstn_gpio;
+	struct gpio_desc *reset_gpio;
 	const char *mclk_name;
 
 	struct regulator *supply_ldo;
@@ -1230,7 +1230,6 @@ static int aic32x4_parse_dt(struct aic32x4_priv *aic32x4,
 
 	aic32x4->swapdacs = false;
 	aic32x4->micpga_routing = 0;
-	aic32x4->rstn_gpio = of_get_named_gpio(np, "reset-gpios", 0);
 
 	if (of_property_read_u32_array(np, "aic32x4-gpio-func",
 				aic32x4_setup->gpio_func, 5) >= 0)
@@ -1365,16 +1364,16 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 		aic32x4->power_cfg = 0;
 		aic32x4->swapdacs = false;
 		aic32x4->micpga_routing = 0;
-		aic32x4->rstn_gpio = -1;
 		aic32x4->mclk_name = "mclk";
 	}
 
-	if (gpio_is_valid(aic32x4->rstn_gpio)) {
-		ret = devm_gpio_request_one(dev, aic32x4->rstn_gpio,
-				GPIOF_OUT_INIT_LOW, "tlv320aic32x4 rstn");
-		if (ret != 0)
-			return ret;
-	}
+	aic32x4->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						      GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(aic32x4->reset_gpio);
+	if (ret)
+		return ret;
+
+	gpiod_set_consumer_name(aic32x4->reset_gpio, "tlv320aic32x4 rstn");
 
 	ret = aic32x4_setup_regulators(dev, aic32x4);
 	if (ret) {
@@ -1382,9 +1381,9 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 		return ret;
 	}
 
-	if (gpio_is_valid(aic32x4->rstn_gpio)) {
+	if (aic32x4->reset_gpio) {
 		ndelay(10);
-		gpio_set_value_cansleep(aic32x4->rstn_gpio, 1);
+		gpiod_set_value_cansleep(aic32x4->reset_gpio, 0);
 		mdelay(1);
 	}
 
-- 
2.38.1.431.g37b22c650d-goog

