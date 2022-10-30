Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A8612758
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 05:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJ3Eky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 00:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3Ekw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 00:40:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A1813E9A;
        Sat, 29 Oct 2022 21:40:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so7742137pjd.4;
        Sat, 29 Oct 2022 21:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pRAS1l5HUBJOvjS7imdI68KIF+eyQhg+QZ+KkL+P+2g=;
        b=IW9IszOFSfXje3HQJOXnxwyZYF4wUAUfPHNakB1YleZg72SbG1Pz/OFHDVUHJ5zTwT
         QCpemUlLKZUFcy/eIzKNGrNTQ2uLfqjXYI2PzecUs5XAqioyZpqeGv9dIGYe3pXXyR/O
         st+Op5VRNYQovygrZ4vkNObGPhpR2MDfC38CZLdV4qktwd0Wa6aewwuwDMPLfH2T2rFC
         H9EUvsIZRFe0TMBUXoToVielRXiXtxc3BIpWZRErAZks0S9t33pgegBdqK2GCDpoPE5z
         A1iqiR5o3hhNgSEZR0MQDby7yfwSbFH6CCYaty/K2HLynacTs0ojFjISpJLI052wAq1j
         LHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRAS1l5HUBJOvjS7imdI68KIF+eyQhg+QZ+KkL+P+2g=;
        b=qApEGcqw+Xbnj7UUMSkY7UzVM53HDDmtGU/B0S4THNZ2qfS/k/Gtpm3t8QiE191OEG
         BBj4tb3VeRgc3zHOrXS4w9VDgQtIGpN3L1pzsOTttQ23C3NA3Hc3/3wOdWKGFsJq23Ms
         8yrQPwOOLs/ddoda5gFFAH+Nt6FxeqrnKriYsVOAJcXkKSpy6q3JoiLg7lmglNpAsyeA
         kLrWMU7IU9qT5AGlRYSNJkfdrw4QBibPKGJGNHDEWpO/iJewtlF/eY3vfh+7gJIB0m/S
         Zxb8wQAe0tMhKzk17fr2zaH52/TxDl2qGqUaB7ftQlx82CQ8895h/3jPFUVGlOVtjELm
         0c/Q==
X-Gm-Message-State: ACrzQf1PvYZnI91lskM9jBB39q71aIFJLFKZDz5eOpiBjYDFgdEJXueK
        QtNCLvNmoS7JYMX9ya7vq2pudPdWCao=
X-Google-Smtp-Source: AMsMyM4CSaO+jNssXNCIVPQXFzmKShnItlMqAlcGru/fmbXaUQlSc6Qk5FXKxevY95imon1PrdiakA==
X-Received: by 2002:a17:902:ab89:b0:186:7cfc:cde8 with SMTP id f9-20020a170902ab8900b001867cfccde8mr7693100plr.9.1667104851363;
        Sat, 29 Oct 2022 21:40:51 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b0018123556931sm2029632plh.204.2022.10.29.21.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 21:40:50 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] gpiolib: of: factor out quirk setting polarity via separate property
Date:   Sat, 29 Oct 2022 21:40:46 -0700
Message-Id: <20221030044047.423859-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
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

v2: no changes

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
2.38.1.273.g43a17bfeac-goog

