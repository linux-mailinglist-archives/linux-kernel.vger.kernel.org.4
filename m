Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229FF5FBDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJKWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJKWTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:19:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3437F10FEA;
        Tue, 11 Oct 2022 15:19:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso278198pjf.2;
        Tue, 11 Oct 2022 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1NwOj/1yvWDq1i4eyj2xHmv/XFz6FaWZBWaVM7wyu0=;
        b=QnJ3DkOqZb9+TAxfrrY/yJZgX9BlizlN23aZk0peWJQqkfSjwVYTilHLwwz7eotgFD
         pLfAIPuEbODQpFNZsGYpKFM+/imh52QZn4ifSgqOX0ZsbSBUHoE/7aq6UkFHB22bJ/tk
         QGtuYF6dQO1UNw8I3BiH3OBnrcg3N/oZwx01p6yX/uwbyOM8qfhj0BxpqESpbyyj/p9R
         7KrvKjUyZuGhKyXNttL3he42d3+LE4smfpiw9NY8ycWBFcWJFGGtvq6rE0FDVY0Mm3R6
         vFvAdEwJgP4bRnHkHjsm5Dj0iJNv/WQyAvkCDi/Q/VhTO/ViNodqPd1fKcBjJEhA+Iqi
         LDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1NwOj/1yvWDq1i4eyj2xHmv/XFz6FaWZBWaVM7wyu0=;
        b=1z9e9Bm4tztqDBDtJV4pW6KRY89iD3uaYND726wfKS4Xld7W73oCuhtqWK67JXWJgN
         EBweO+0EYwY7Y3c3dOy3DZdihH9ybG4Gc1PZRuA3i2EBbWVimEu/nN7MX/gjchGgA8Yg
         1zB97cKvw6fPjILJSVia5HhwBSViI04j0er5Ruz/1kjF59+ImRUY1QWgUlQDzZuv72vm
         Jb/WEpWKHnXARY0rWCfPbxQx0rz1jtJ+srxQXHETjivhT9ZkKmhgJ0xgKUufmE0fnkta
         H9WMrXwEStdQoqeTxashCy6rWMBeEVniRvumx+gdpJCv97b2p0PLkiu5eDjotJ3gFkN8
         6flw==
X-Gm-Message-State: ACrzQf0uEzEw7S09wFp9t5NQFdFK2/rMxzevyJIkEj6glwJB3kVUWAtI
        twvynDQoNdH4kdTPCUVLr8A=
X-Google-Smtp-Source: AMsMyM67VBVHeAxNNooJjkK0PyaA6elXhQFtVi8kxrLNLHJe9zDpYIGxr6dY/4+x2BRZV8n5mJwFrA==
X-Received: by 2002:a17:902:d4ce:b0:178:1e39:3218 with SMTP id o14-20020a170902d4ce00b001781e393218mr26303122plg.144.1665526784393;
        Tue, 11 Oct 2022 15:19:44 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:becc:db10:eb45:dc35])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090ab70600b0020d39ffe987sm60151pjr.50.2022.10.11.15.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:19:43 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 3/7] gpiolib: of: add quirk for locating reset lines with legacy bindings
Date:   Tue, 11 Oct 2022 15:19:31 -0700
Message-Id: <20221011-gpiolib-quirks-v1-3-e01d9d3e7b29@gmail.com>
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

Some legacy mappings used "gpio[s]-reset" instead of "reset-gpios",
add a quirk so that gpiod API will still work on unmodified DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 619aae0c5476..576f2f0c3432 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -375,9 +375,18 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		const char *legacy_id;	/* NULL - same as con_id */
 		const char *compatible; /* NULL - don't check */
 	} gpios[] = {
+#if !IS_ENABLED(CONFIG_LCD_HX8357)
+		/* Himax LCD controllers used "gpios-reset" */
+		{ "reset",	"gpios-reset",	"himax,hx8357" },
+		{ "reset",	"gpios-reset",	"himax,hx8369" },
+#endif
 #if IS_ENABLED(CONFIG_MFD_ARIZONA)
 		{ "wlf,reset",	NULL,		NULL },
 #endif
+#if !IS_ENABLED(CONFIG_PCI_LANTIQ)
+		/* MIPS Lantiq PCI */
+		{ "reset",	"gpios-reset",	"lantiq,pci-xway" },
+#endif
 #if IS_ENABLED(CONFIG_REGULATOR)
 		/*
 		 * Some regulator bindings happened before we managed to
@@ -388,8 +397,14 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		{ "wlf,ldo1ena", NULL,		NULL }, /* WM8994 */
 		{ "wlf,ldo2ena", NULL,		NULL }, /* WM8994 */
 #endif
+#if IS_ENABLED(CONFIG_SND_SOC_TLV320AIC3X)
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3x" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic33" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3007" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3104" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3106" },
+#endif
 #if IS_ENABLED(CONFIG_SPI_MASTER)
-
 		/*
 		 * The SPI GPIO bindings happened before we managed to
 		 * establish that GPIO properties should be named

-- 
b4 0.11.0-dev-5166b
