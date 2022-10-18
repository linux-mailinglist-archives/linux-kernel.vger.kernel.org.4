Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D315E6023E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiJRFln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJRFlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:41:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A62B9E2F6;
        Mon, 17 Oct 2022 22:41:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z20so12799393plb.10;
        Mon, 17 Oct 2022 22:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irh82m/Qp0GNkDByM4lA7WDy1dQieqAl2YHxexC44Os=;
        b=qM+7dUmyLkuLDovXyoDzXR4ZJpAmZEdJGbZmluNHy9gwL9ovsevbMseXwDgIpDBLyJ
         OZxzyzDmo1EDoIj/aW9A1oqy+N21Qkye+klde2LrJ6uWjtC3qpnnEDvasVjjKEf3NuUM
         yUeiw5Csgwv7NOsE+dF3orUttQy43BtzBpu4ioNjBBDvrKfBg7J0n0QVPKEn75jnJT5J
         fDOsFzSJnLNppTx+HtbLp/PyXmCfSivMTsfPryuqO211YBvr+qf5IRg3MEGtT1Q2khGG
         snrOs178pvUx1AVkNeSz6hhXFu4Uq3doCNrG6OhyBeXPDw/nY/cKN12J0zpBC/k9YvLi
         FDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irh82m/Qp0GNkDByM4lA7WDy1dQieqAl2YHxexC44Os=;
        b=XGja31BhtAdVg0zjACPqvSYTD/dsSwST2wRQ5RcjHJkOO7ntXeXORvJr8divPikFw8
         US5mpkFdUUNjBzUGpnVUVzGWsIH2sQp8MayJwEfhxEIXRxkxISMo6d04FPptX37tgcGO
         P+YvjQsU5tkYsiXkhWCuZ/gzXlvcxdnqQKGTE8fri9C6sieRNbTsZ/ZHKpwj4KefZZRK
         2lKnb6Pd1+IX1MkRbAEwUpyLcGMCDouogn3vh8Hj2VKff0Cr5mYtl4fVyzTD8VdPL102
         M8F74EGCMiY/DzfF4tcLyUbW5BomD1aY+ZIXfsizoqVJfPkxr0FsiyywJrvZ3GFBxfi6
         Y6OQ==
X-Gm-Message-State: ACrzQf1/3KXwtH/MSbxxFN1HeVpLRqaWQx6tmLcab1SY0UMg+Aqw0e32
        Nxx4+Xo5iI8UpM058YNSJf0=
X-Google-Smtp-Source: AMsMyM44JNbRgjz/ycKNs7oGzL14JzEH+ynshgXTVlDVyeaouBVbIzDLES45gV0ttfgxsmviubHGbg==
X-Received: by 2002:a17:90b:33cf:b0:20d:981a:a5b4 with SMTP id lk15-20020a17090b33cf00b0020d981aa5b4mr34749058pjb.137.1666071679676;
        Mon, 17 Oct 2022 22:41:19 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:f7bc:1bb5:e0b1:92cb])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b00172f4835f53sm7597435pla.192.2022.10.17.22.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:41:18 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 02/10] gpiolib: of: consolidate simple renames into a single quirk
Date:   Mon, 17 Oct 2022 22:41:03 -0700
Message-Id: <20221011-gpiolib-quirks-v3-2-eae9cc2ed0a1@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
References: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
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

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 183 ++++++++++++++++++----------------------------
 1 file changed, 71 insertions(+), 112 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index cef4f6634125..63c6fa3086f3 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -365,127 +365,90 @@ struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
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
+		/*
+		 * Compatible string can be set to NULL in case where
+		 * matching to a particular compatible is not practical,
+		 * but it should only be done for gpio names that have
+		 * vendor prefix to reduce risk of false positives.
+		 * Addition of such entries is strongly discouraged.
+		 */
+		const char *compatible;
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
@@ -525,11 +488,7 @@ typedef struct gpio_desc *(*of_find_gpio_quirk)(struct device_node *np,
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
