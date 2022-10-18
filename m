Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E320A6023E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJRFlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiJRFlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:41:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6AEA344C;
        Mon, 17 Oct 2022 22:41:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so12986102pjf.5;
        Mon, 17 Oct 2022 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch1kkg4DviDr6cISnBueqNw+RVHy+3iDkYpvZ9QTu+8=;
        b=mHve54bc7ls4cCd6C+WM3vdDSNGdw+8I7tX818Y+FQd+0A1EfGoZp1Cu9SjKAkb8s3
         Mz6bLG0nCRdSFm8PoxRktOPdBxTSH/1gJ+psd/3tNwGufenYlwBHOHRkanuiFHnkpNbi
         qKTDWws9xj62X8nQs4UY3tIbcymrjuUmf4ng7BiDtgNfN/5CNBFnDncwzG+tmQfasCo8
         EMOl9ry8ZHYazcKg0NtcFqpURBiE/IcwXyv8od3GcSZ50/ViCKHX4Hv5ukC0a5reOb+Y
         EBu8Ag4Up1LyZ87fjL4Y/Qg9Hic/ClAL2eYp5ytA96PKAALHcXOMXHT+Xf1Vr8VqLTbg
         bVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ch1kkg4DviDr6cISnBueqNw+RVHy+3iDkYpvZ9QTu+8=;
        b=V25XIWm/413y8fw38/c/kKYX6ci7odKjkkukbkCWklhpkwSm00I8DQL8F0mgFAeh7f
         ry8FZfMxDKiaiLFu7rdTxy1lTTyEKQ4j5Klp7l2k5J5cyA0p6ON9AeyBAtzvusZqp3rv
         2im2sLjOutA3K3b+V0r5Qh84VnWQh6ds6Eph3kPlo+86ejBGr/oL7e/nwZiBqmgYck6G
         TzoMDUpd75gnQIi+JuQautlHUs8Z/p1WRUBUtxesMl8QIQTRMcRg3QZBwUEZFYuXFWDB
         ud+O7M9kvtEqpYqSrTQ5cYjJAqa/yGMhjWt3CoxUOhpdIqmGwYekdxpyg/ufbX1Wf1bS
         WAyQ==
X-Gm-Message-State: ACrzQf0yMio64LMOBScbZRmbYLrk119bd3MKtSt9b7HtA5LWgAGsimUj
        VwNPFy2ePt4hncs6VOkVcY0=
X-Google-Smtp-Source: AMsMyM7d59XGsjP6DygOpdlJU+BHF6POz0TjgtvZCukR/4f2RTioIXZcjn/vo/jVJHpfY2p3ENJHbA==
X-Received: by 2002:a17:903:11c3:b0:17a:e62:16e8 with SMTP id q3-20020a17090311c300b0017a0e6216e8mr1354374plh.137.1666071681430;
        Mon, 17 Oct 2022 22:41:21 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:f7bc:1bb5:e0b1:92cb])
        by smtp.gmail.com with ESMTPSA id z7-20020a1709027e8700b00172f4835f53sm7597435pla.192.2022.10.17.22.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:41:20 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 03/10] gpiolib: of: tighten selection of gpio renaming quirks
Date:   Mon, 17 Oct 2022 22:41:04 -0700
Message-Id: <20221011-gpiolib-quirks-v3-3-eae9cc2ed0a1@gmail.com>
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

Tighten selection of legacy gpio renaming quirks so that they only
considered on more relevant configurations.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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
