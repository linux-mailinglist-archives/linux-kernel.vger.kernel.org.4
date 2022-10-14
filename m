Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17B5FF33C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiJNRy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJNRyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:54:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2281A237;
        Fri, 14 Oct 2022 10:54:43 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f193so4976653pgc.0;
        Fri, 14 Oct 2022 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWZ+aGOI9zXRffRicNGgT9n+AHk/SzmN5RkqWoKLfug=;
        b=fOuoZbM/KjXQtLJpXmlUZdf0h5Nn6/Px2oC5XUiQn9ZydwR3x4nYk6bH+rwzR5dPbm
         SgLxRAhCzrDPIM3ABgllWBkdEDMqpe5P1q/j05LWtiH0IfnlVlLfJHV/CEKctMuVLmBX
         lljNk27Nac8Jm7tB01ebLFIokCWjW11F5iEqF9Zuk+LBAhVz3BCQoeoPTYRVPS66tSoO
         LvzjCgHO1oX1UamlmU1uoelQkiPDHKmsc37EsElMWeAigXtFJivGPnFeO2fgDpAR0byB
         rqNp0sp1B8ZTfSi9hmmlN16nYt5/899wmkZgmqHf4qC65cD5+UsaCrhffmMgJK3cDIa/
         PD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWZ+aGOI9zXRffRicNGgT9n+AHk/SzmN5RkqWoKLfug=;
        b=M0MwgGtQckY6WlVSVW8+StNAzo9uTTvSb/vBYZkJLgYWTmlk1rd0HIm+YSB24yc+4O
         /yWqZkh/NQjzudGXrPlE9nyKyLytOuxZHfkuWc9H6G4JkVfiC6jOQeGfPZXzDBu8Ggni
         XMOR7Rz3ifJQvsma17ypYZyt7cy9paOWOOIfeNq5botf2QBVxMRPc1ZtLP3k6L2JpaF4
         N3onaivtTSHaD/+q7DiULPBpYynSgcZACbulkgh2wBETVCGgeSuD/dfvicGqnAUJRln3
         rHbjUqqiPK6VeQc08TqVZBGhaDKGQbdEBKby0lo7tN9+mvVtwNkIXwkCu1QrcuRWOD5E
         8Zuw==
X-Gm-Message-State: ACrzQf0kLhzFQzJZRiBkA1xWVRu0tZvi6w9XGf55R4sby+zHYHrNgYdk
        DGM/TozxeAoz/+naWH0VDyrnw4TuMhQ=
X-Google-Smtp-Source: AMsMyM4bLYjTWsvcYEUC1J7AnVhPw7i51eFEiThG8nor2ElbLxXeKrJsQH1s4tSLb7eLWUt1sd3vtg==
X-Received: by 2002:a63:4e18:0:b0:43c:2fc7:2eea with SMTP id c24-20020a634e18000000b0043c2fc72eeamr5688379pgb.119.1665770082916;
        Fri, 14 Oct 2022 10:54:42 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:da06:5604:594f:f6af])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b0017f7819732dsm2011780plb.77.2022.10.14.10.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:54:42 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 3/9] gpiolib: of: tighten selection of gpio renaming quirks
Date:   Fri, 14 Oct 2022 10:54:27 -0700
Message-Id: <20221011-gpiolib-quirks-v2-3-73cb7176fd94@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221011-gpiolib-quirks-v2-0-73cb7176fd94@gmail.com>
References: <20221011-gpiolib-quirks-v2-0-73cb7176fd94@gmail.com>
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

Tighten selection of legacy gpio renaming quirks so that they only
considered on more relevant configurations.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 63c6fa3086f3..7d4bbf6484bc 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -385,18 +385,21 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 #if IS_ENABLED(CONFIG_MFD_ARIZONA)
 		{ "wlf,reset",	NULL,		NULL },
 #endif
-#if IS_ENABLED(CONFIG_REGULATOR)
+
 		/*
 		 * Some regulator bindings happened before we managed to
 		 * establish that GPIO properties should be named
 		 * "foo-gpios" so we have this special kludge for them.
 		 */
+#if IS_ENABLED(CONFIG_REGULATOR_ARIZONA_LDO1)
 		{ "wlf,ldoena",  NULL,		NULL }, /* Arizona */
+#endif
+#if IS_ENABLED(CONFIG_REGULATOR_WM8994)
 		{ "wlf,ldo1ena", NULL,		NULL }, /* WM8994 */
 		{ "wlf,ldo2ena", NULL,		NULL }, /* WM8994 */
 #endif
-#if IS_ENABLED(CONFIG_SPI_MASTER)
 
+#if IS_ENABLED(CONFIG_SPI_GPIO)
 		/*
 		 * The SPI GPIO bindings happened before we managed to
 		 * establish that GPIO properties should be named
@@ -405,6 +408,7 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		{ "miso",	"gpio-miso",	"spi-gpio" },
 		{ "mosi",	"gpio-mosi",	"spi-gpio" },
 		{ "sck",	"gpio-sck",	"spi-gpio" },
+#endif
 
 		/*
 		 * The old Freescale bindings use simply "gpios" as name
@@ -412,10 +416,14 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		 * all other SPI hardware. Allow this specifically for
 		 * Freescale and PPC devices.
 		 */
+#if IS_ENABLED(CONFIG_SPI_FSL_SPI)
 		{ "cs",		"gpios",	"fsl,spi" },
 		{ "cs",		"gpios",	"aeroflexgaisler,spictrl" },
+#endif
+#if IS_ENABLED(CONFIG_SPI_PPC4xx)
 		{ "cs",		"gpios",	"ibm,ppc4xx-spi" },
 #endif
+
 #if IS_ENABLED(CONFIG_TYPEC_FUSB302)
 		/*
 		 * Fairchild FUSB302 host is using undocumented "fcs,int_n"

-- 
b4 0.11.0-dev-5166b
