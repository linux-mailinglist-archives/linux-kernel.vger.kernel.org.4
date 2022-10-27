Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1113F60F0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiJ0G6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiJ0G5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:57:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1889A15F308;
        Wed, 26 Oct 2022 23:55:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso5441515pjc.0;
        Wed, 26 Oct 2022 23:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5caREDVOfT0kOXjQKhISr51b9vOW0WUHzcpIRu8O1ag=;
        b=NnevMi5+lNqoI31gdky5PsDyRMQqxvujv4E4p0KZ6jRnnVDhU1FLMQ8OoVpt0cBeQn
         PtFkqs+XQXBeoWSXACPrhF/NfYCx3UMbU5f3TxkmX/FGykOH6tHUa5mlkIvIe/IvCLpQ
         YLxmM8Hh2mUenQq7aOqwFNjtq2vlBCO//pYLmmB9jHw1NEZ/stkU6gOilikXfbg8BNJz
         bZ4L5Q+P+Xv/j+PoWEi1mnxlFa1y0TAeC4BkVczGHeana/Aau9XABk1JMUG3eo3ZLb0h
         Q7hhdgLq3nRIIb70izKbZi1BVtVi1UJq1aeKGKpglYUQhqXLe7v+mkEQq5xLASXvvS5j
         s+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5caREDVOfT0kOXjQKhISr51b9vOW0WUHzcpIRu8O1ag=;
        b=3LvsSkadUX6ihMztYiH+1DGPKu4HkHa/pOxkVJM0arYW4tKjxoHqGkt3VasYjonw0z
         W5MYioSLaOksGDLMDvzolsy5vQ1MUzi0BRDgynVjFWRArEAJSV+qFzaGuEiAUHmgX9cw
         EBUkbWpVoMz8KEYGc9OUUbJW3stLKs35k77YN6k/YGyHZrS3QpVpK5CspP6ILWWgZNxX
         nX0pqnfRzmaghU8IOu2Boo8O5tshUhTP6IIGiA+1DQVhyZjY38cpvTylkxZ+DUfCI2w1
         hkOHdd+l7IunTe0D8cphCU/qlieBYK643UkKyoMn7VBLlzBK4e09jJOMsEmJwJnpfyxO
         +hEg==
X-Gm-Message-State: ACrzQf1kNoGP9cVGh4XDk8bXfzPzdQi+uLsincskx3DOhsPOxEGfNzoj
        XR3XBpNUyCJ9KeIair1OmirRoEXzLSc=
X-Google-Smtp-Source: AMsMyM4Gd8JPEBNRI0g1BfmugAAX/NmfqJ30Glhh9quFUst/plLb4UPR+La3lCVXTNsuheOVK3TxiQ==
X-Received: by 2002:a17:902:e80b:b0:183:7463:f628 with SMTP id u11-20020a170902e80b00b001837463f628mr48204663plg.19.1666853757533;
        Wed, 26 Oct 2022 23:55:57 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090a710700b00213202d77d9sm405482pjk.43.2022.10.26.23.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 23:55:56 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] gpiolib: of: factor out quirk setting polarity via separate property
Date:   Wed, 26 Oct 2022 23:55:52 -0700
Message-Id: <20221027065553.801153-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
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

Several legacy bindings use a separate property to specify polarity of
GPIOs instead of specifying it directly in the GPIO property. Factor
out this code to make it easier to add more such cases.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 98 +++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 45 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 52616848a37c..331744c75faf 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -186,33 +186,68 @@ static void of_gpio_try_fixup_polarity(const struct device_node *np,
 	}
 }
 
-static void of_gpio_flags_quirks(const struct device_node *np,
-				 const char *propname,
-				 enum of_gpio_flags *flags,
-				 int index)
+static void of_gpio_set_polarity_by_property(const struct device_node *np,
+					     const char *propname,
+					     enum of_gpio_flags *flags)
 {
-	of_gpio_try_fixup_polarity(np, propname, flags);
+	static const struct {
+		const char *compatible;
+		const char *gpio_propname;
+		const char *polarity_propname;
+	} gpios[] = {
+#if IS_ENABLED(CONFIG_FEC)
+		/* Freescale Fast Ethernet Controller */
+		{ "fsl,imx25-fec",   "phy-reset-gpios", "phy-reset-active-high" },
+		{ "fsl,imx27-fec",   "phy-reset-gpios", "phy-reset-active-high" },
+		{ "fsl,imx28-fec",   "phy-reset-gpios", "phy-reset-active-high" },
+		{ "fsl,imx6q-fec",   "phy-reset-gpios", "phy-reset-active-high" },
+		{ "fsl,mvf600-fec",  "phy-reset-gpios", "phy-reset-active-high" },
+		{ "fsl,imx6sx-fec",  "phy-reset-gpios", "phy-reset-active-high" },
+		{ "fsl,imx6ul-fec",  "phy-reset-gpios", "phy-reset-active-high" },
+		{ "fsl,imx8mq-fec",  "phy-reset-gpios", "phy-reset-active-high" },
+		{ "fsl,imx8qm-fec",  "phy-reset-gpios", "phy-reset-active-high" },
+		{ "fsl,s32v234-fec", "phy-reset-gpios", "phy-reset-active-high" },
+#endif
 
-	/*
-	 * Some GPIO fixed regulator quirks.
-	 * Note that active low is the default.
-	 */
-	if (IS_ENABLED(CONFIG_REGULATOR) &&
-	    (of_device_is_compatible(np, "regulator-fixed") ||
-	     of_device_is_compatible(np, "reg-fixed-voltage") ||
-	     (!(strcmp(propname, "enable-gpio") &&
-		strcmp(propname, "enable-gpios")) &&
-	      of_device_is_compatible(np, "regulator-gpio")))) {
-		bool active_high = of_property_read_bool(np,
-							 "enable-active-high");
 		/*
 		 * The regulator GPIO handles are specified such that the
 		 * presence or absence of "enable-active-high" solely controls
 		 * the polarity of the GPIO line. Any phandle flags must
 		 * be actively ignored.
 		 */
-		of_gpio_quirk_polarity(np, active_high, flags);
+#if IS_ENABLED(CONFIG_REGULATOR_FIXED_VOLTAGE)
+		{ "regulator-fixed",   "gpios",        "enable-active-high" },
+		{ "regulator-fixed",   "gpio",         "enable-active-high" },
+		{ "reg-fixed-voltage", "gpios",        "enable-active-high" },
+		{ "reg-fixed-voltage", "gpio",         "enable-active-high" },
+#endif
+#if IS_ENABLED(CONFIG_REGULATOR_GPIO)
+		{ "regulator-gpio",    "enable-gpio",  "enable-active-high" },
+		{ "regulator-gpio",    "enable-gpios", "enable-active-high" },
+#endif
+	};
+	unsigned int i;
+	bool active_high;
+
+	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
+		if (of_device_is_compatible(np, gpios[i].compatible) &&
+		    !strcmp(propname, gpios[i].gpio_propname)) {
+			active_high = of_property_read_bool(np,
+						gpios[i].polarity_propname);
+			of_gpio_quirk_polarity(np, active_high, flags);
+			break;
+		}
 	}
+}
+
+static void of_gpio_flags_quirks(const struct device_node *np,
+				 const char *propname,
+				 enum of_gpio_flags *flags,
+				 int index)
+{
+	of_gpio_try_fixup_polarity(np, propname, flags);
+	of_gpio_set_polarity_by_property(np, propname, flags);
+
 	/*
 	 * Legacy open drain handling for fixed voltage regulators.
 	 */
@@ -267,33 +302,6 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 	    !strcmp(propname, "snps,reset-gpio") &&
 	    of_property_read_bool(np, "snps,reset-active-low"))
 		*flags |= OF_GPIO_ACTIVE_LOW;
-
-	/*
-	 * Freescale Fast Ethernet Controller uses a separate property to
-	 * describe polarity of the phy reset line.
-	 */
-	if (IS_ENABLED(CONFIG_FEC)) {
-		static const char * const fec_devices[] = {
-			"fsl,imx25-fec",
-			"fsl,imx27-fec",
-			"fsl,imx28-fec",
-			"fsl,imx6q-fec",
-			"fsl,mvf600-fec",
-			"fsl,imx6sx-fec",
-			"fsl,imx6ul-fec",
-			"fsl,imx8mq-fec",
-			"fsl,imx8qm-fec",
-			"fsl,s32v234-fec",
-			NULL
-		};
-
-		if (!strcmp(propname, "phy-reset-gpios") &&
-		    of_device_compatible_match(np, fec_devices)) {
-			bool active_high = of_property_read_bool(np,
-						"phy-reset-active-high");
-			of_gpio_quirk_polarity(np, active_high, flags);
-		}
-	}
 }
 
 /**
-- 
2.38.0.135.g90850a2211-goog

