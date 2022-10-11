Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346A55FBDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJKWT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJKWTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:19:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76868FD24;
        Tue, 11 Oct 2022 15:19:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 10so14602270pli.0;
        Tue, 11 Oct 2022 15:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwnaXCxUHw/pDFGM82u7rAsDp6VoYC273VUZqkeLBvA=;
        b=JqiV2UsuEvzkU3JGSCFbS7pqYjkpSPMJtXpHwIAYCTLBflCoLy5Bgwe/LLzpTe1oou
         iGKUUo7edg3rs028AofuMh6Inia6fDJjjBzpt7ZEAgCyTFt5Z2G1cUk4UD4+cPQUMKcy
         CCgfumGrjzcSRwElNYDQuCR+f7HvJCG8oC8Uuv2R+hdLLYsZGJQxwLjv5MDcoSRbBuC5
         IVSdC65ngzuHLeiMVqdVLbt2ETY0GzMlmPho1fOFgW35LpC2o55Fas55vH22g9uTQyMc
         g9U1ifp573wWd5TBGGQFQk6aITak1nPDESWfe2lIK/EcdSHalTsKV2KIhHhDVdRrlI0x
         pj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwnaXCxUHw/pDFGM82u7rAsDp6VoYC273VUZqkeLBvA=;
        b=jYm+SVzMsi+Fe1XYN2gG60ZyHxoyYlrijvaA8+DwFCIDcsCSToRvxznTC6NRAeFl/m
         O139Ym9jIvzO3/XMD8No4rEQGBwP6PozhkA5QWNFSnVZYvDcvIqx8XC5VBebh1+wbVQj
         hBfvlP8LB+hxuqdKuVtyyMVjyCpfnXwr35JiMrmqaNBnsg/1alBeiGnpy4XFS8K3LIw1
         xm2mev6u66i0+0bDz2qHshjWkxQ5+0ds4lGyZ2BF4wIcdaNz9DsuYm7JVS4ZhcV2IY4J
         /IHtvJWrBOr2u32Bg/NH1ev0+OzGVWTKFNqzNv27w79aNikM4zOsPlba1RAG/Fp7o0Nw
         hV8A==
X-Gm-Message-State: ACrzQf32fUgHoK0yGy02cD1NO8wfteG/uebcT+BgY2CYiCM2uubOe/za
        rZl5yXYoKaX/qZP2ZbYZt80=
X-Google-Smtp-Source: AMsMyM6CBhzwUNnE45hKHUnLSlf6DbALwhzI18cG3CaCg7Kl/0eFPEfjbq96yDq7vJQPYCC2vkLVqQ==
X-Received: by 2002:a17:902:70c4:b0:178:54cf:d397 with SMTP id l4-20020a17090270c400b0017854cfd397mr25533511plt.24.1665526782811;
        Tue, 11 Oct 2022 15:19:42 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:becc:db10:eb45:dc35])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090ab70600b0020d39ffe987sm60151pjr.50.2022.10.11.15.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:19:42 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 2/7] gpiolib: of: consolidate simple renames into a single quirk
Date:   Tue, 11 Oct 2022 15:19:30 -0700
Message-Id: <20221011-gpiolib-quirks-v1-2-e01d9d3e7b29@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
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

This consolidates all quirks doing simple renames (either allowing
suffix-less names or trivial renames, when index changes are not
required) into a single quirk.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 176 +++++++++++++++++-----------------------------
 1 file changed, 64 insertions(+), 112 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index cef4f6634125..619aae0c5476 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -365,127 +365,83 @@ struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(gpiod_get_from_of_node);
 
-/*
- * The SPI GPIO bindings happened before we managed to establish that GPIO
- * properties should be named "foo-gpios" so we have this special kludge for
- * them.
- */
-static struct gpio_desc *of_find_spi_gpio(struct device_node *np,
-					  const char *con_id,
-					  unsigned int idx,
-					  enum of_gpio_flags *of_flags)
-{
-	char prop_name[32]; /* 32 is max size of property name */
-
-	/*
-	 * Hopefully the compiler stubs the rest of the function if this
-	 * is false.
-	 */
-	if (!IS_ENABLED(CONFIG_SPI_MASTER))
-		return ERR_PTR(-ENOENT);
-
-	/* Allow this specifically for "spi-gpio" devices */
-	if (!of_device_is_compatible(np, "spi-gpio") || !con_id)
-		return ERR_PTR(-ENOENT);
-
-	/* Will be "gpio-sck", "gpio-mosi" or "gpio-miso" */
-	snprintf(prop_name, sizeof(prop_name), "%s-%s", "gpio", con_id);
-
-	return of_get_named_gpiod_flags(np, prop_name, idx, of_flags);
-}
-
-/*
- * The old Freescale bindings use simply "gpios" as name for the chip select
- * lines rather than "cs-gpios" like all other SPI hardware. Account for this
- * with a special quirk.
- */
-static struct gpio_desc *of_find_spi_cs_gpio(struct device_node *np,
+static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 					     const char *con_id,
 					     unsigned int idx,
 					     enum of_gpio_flags *of_flags)
 {
-	if (!IS_ENABLED(CONFIG_SPI_MASTER))
-		return ERR_PTR(-ENOENT);
-
-	/* Allow this specifically for Freescale and PPC devices */
-	if (!of_device_is_compatible(np, "fsl,spi") &&
-	    !of_device_is_compatible(np, "aeroflexgaisler,spictrl") &&
-	    !of_device_is_compatible(np, "ibm,ppc4xx-spi"))
-		return ERR_PTR(-ENOENT);
-	/* Allow only if asking for "cs-gpios" */
-	if (!con_id || strcmp(con_id, "cs"))
-		return ERR_PTR(-ENOENT);
+	static const struct of_rename_gpio {
+		const char *con_id;
+		const char *legacy_id;	/* NULL - same as con_id */
+		const char *compatible; /* NULL - don't check */
+	} gpios[] = {
+#if IS_ENABLED(CONFIG_MFD_ARIZONA)
+		{ "wlf,reset",	NULL,		NULL },
+#endif
+#if IS_ENABLED(CONFIG_REGULATOR)
+		/*
+		 * Some regulator bindings happened before we managed to
+		 * establish that GPIO properties should be named
+		 * "foo-gpios" so we have this special kludge for them.
+		 */
+		{ "wlf,ldoena",  NULL,		NULL }, /* Arizona */
+		{ "wlf,ldo1ena", NULL,		NULL }, /* WM8994 */
+		{ "wlf,ldo2ena", NULL,		NULL }, /* WM8994 */
+#endif
+#if IS_ENABLED(CONFIG_SPI_MASTER)
 
-	/*
-	 * While all other SPI controllers use "cs-gpios" the Freescale
-	 * uses just "gpios" so translate to that when "cs-gpios" is
-	 * requested.
-	 */
-	return of_get_named_gpiod_flags(np, "gpios", idx, of_flags);
-}
+		/*
+		 * The SPI GPIO bindings happened before we managed to
+		 * establish that GPIO properties should be named
+		 * "foo-gpios" so we have this special kludge for them.
+		 */
+		{ "miso",	"gpio-miso",	"spi-gpio" },
+		{ "mosi",	"gpio-mosi",	"spi-gpio" },
+		{ "sck",	"gpio-sck",	"spi-gpio" },
 
-/*
- * Some regulator bindings happened before we managed to establish that GPIO
- * properties should be named "foo-gpios" so we have this special kludge for
- * them.
- */
-static struct gpio_desc *of_find_regulator_gpio(struct device_node *np,
-						const char *con_id,
-						unsigned int idx,
-						enum of_gpio_flags *of_flags)
-{
-	/* These are the connection IDs we accept as legacy GPIO phandles */
-	const char *whitelist[] = {
-		"wlf,ldoena", /* Arizona */
-		"wlf,ldo1ena", /* WM8994 */
-		"wlf,ldo2ena", /* WM8994 */
+		/*
+		 * The old Freescale bindings use simply "gpios" as name
+		 * for the chip select lines rather than "cs-gpios" like
+		 * all other SPI hardware. Allow this specifically for
+		 * Freescale and PPC devices.
+		 */
+		{ "cs",		"gpios",	"fsl,spi" },
+		{ "cs",		"gpios",	"aeroflexgaisler,spictrl" },
+		{ "cs",		"gpios",	"ibm,ppc4xx-spi" },
+#endif
+#if IS_ENABLED(CONFIG_TYPEC_FUSB302)
+		/*
+		 * Fairchild FUSB302 host is using undocumented "fcs,int_n"
+		 * property without the compulsory "-gpios" suffix.
+		 */
+		{ "fcs,int_n",	NULL,		"fcs,fusb302" },
+#endif
 	};
-	int i;
-
-	if (!IS_ENABLED(CONFIG_REGULATOR))
-		return ERR_PTR(-ENOENT);
+	struct gpio_desc *desc;
+	const char *legacy_id;
+	unsigned int i;
 
 	if (!con_id)
 		return ERR_PTR(-ENOENT);
 
-	i = match_string(whitelist, ARRAY_SIZE(whitelist), con_id);
-	if (i < 0)
-		return ERR_PTR(-ENOENT);
-
-	return of_get_named_gpiod_flags(np, con_id, idx, of_flags);
-}
-
-static struct gpio_desc *of_find_arizona_gpio(struct device_node *np,
-					      const char *con_id,
-					      unsigned int idx,
-					      enum of_gpio_flags *of_flags)
-{
-	if (!IS_ENABLED(CONFIG_MFD_ARIZONA))
-		return ERR_PTR(-ENOENT);
-
-	if (!con_id || strcmp(con_id, "wlf,reset"))
-		return ERR_PTR(-ENOENT);
-
-	return of_get_named_gpiod_flags(np, con_id, idx, of_flags);
-}
+	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
+		if (strcmp(con_id, gpios[i].con_id))
+			continue;
 
-static struct gpio_desc *of_find_usb_gpio(struct device_node *np,
-					  const char *con_id,
-					  unsigned int idx,
-					  enum of_gpio_flags *of_flags)
-{
-	/*
-	 * Currently this USB quirk is only for the Fairchild FUSB302 host
-	 * which is using an undocumented DT GPIO line named "fcs,int_n"
-	 * without the compulsory "-gpios" suffix.
-	 */
-	if (!IS_ENABLED(CONFIG_TYPEC_FUSB302))
-		return ERR_PTR(-ENOENT);
+		if (gpios[i].compatible &&
+		    !of_device_is_compatible(np, gpios[i].compatible))
+			continue;
 
-	if (!con_id || strcmp(con_id, "fcs,int_n"))
-		return ERR_PTR(-ENOENT);
+		legacy_id = gpios[i].legacy_id ?: gpios[i].con_id;
+		desc = of_get_named_gpiod_flags(np, legacy_id, idx, of_flags);
+		if (!gpiod_not_found(desc)) {
+			pr_info("%s uses legacy gpio name '%s' instead of '%s-gpios'\n",
+				of_node_full_name(np), legacy_id, con_id);
+			return desc;
+		}
+	}
 
-	return of_get_named_gpiod_flags(np, con_id, idx, of_flags);
+	return ERR_PTR(-ENOENT);
 }
 
 static struct gpio_desc *of_find_mt2701_gpio(struct device_node *np,
@@ -525,11 +481,7 @@ typedef struct gpio_desc *(*of_find_gpio_quirk)(struct device_node *np,
 						unsigned int idx,
 						enum of_gpio_flags *of_flags);
 static const of_find_gpio_quirk of_find_gpio_quirks[] = {
-	of_find_spi_gpio,
-	of_find_spi_cs_gpio,
-	of_find_regulator_gpio,
-	of_find_arizona_gpio,
-	of_find_usb_gpio,
+	of_find_gpio_rename,
 	of_find_mt2701_gpio,
 	NULL
 };

-- 
b4 0.11.0-dev-5166b
