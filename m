Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0DA6F2FBE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjEAJFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 05:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjEAJFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 05:05:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7AB10F3
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 02:05:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4edb26f762dso2816483e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 02:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682931925; x=1685523925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWK3/AsROodb0RDVek27Kktb6s+ppm3PtIa2ZoQnl4g=;
        b=sV3g+73NYEh5B8/4DU+3wHTeYlQQ+/KGc4ORCezfBE7nh04hw3uwPKmmZ7CI1tbn+A
         lHm2Ozi21CLsn35z0O+ich/iX6afRbz3J2EkHt3Rfvul2uSsdkA1uLKZEeXmgduIcfjk
         yuSVIVaWh0qzDjrrtvbBv4GODOj2j38NqAIhkMoKaIaDCQhFn7kHKb8Tm0+7+i22ECsf
         340LpvqDEE5mwTdweJmqmf1yHFcO9pKq8keeWu4AWUSsSFnv7ZanuLx+XTqQsHg6Q/nr
         H+kTfNUSkSFDm/D6m6762I8mDLLom7BFS+Ma+Vm898ilR9JgYkq7mnA2SKpd8+9IWY0A
         wAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931925; x=1685523925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWK3/AsROodb0RDVek27Kktb6s+ppm3PtIa2ZoQnl4g=;
        b=Qc3TkqmuSvejcubYST6U57s7RlSzzsIMK30lFid5HZHGGQVZs9QVq0LCTRUpzToaOL
         XJCOuKUfCye1JKjEhjMQzRhBUtIMxIj0a3SDm/TGuf19gFavnfg1j6M37bet1jT973vK
         tW6WjFhfRuFwv2s1cB9mXN4kWSFVyZ9KA0y8k4YLdZrRlhNCZElZ3DCUySM+kp+eOn0y
         tlEXz+vu/O5Q+qXeV1jS4Qy30QahI9LXZmtbb4nOI0ozu0gipxp3hGlOlOgXwIB3fLbB
         yevNWoWp0HgwtHxePIZ2XkLA/dIAsULej79j79m+5Lrv15JMXmWf/0MJlO0iGqibRkte
         d4mw==
X-Gm-Message-State: AC+VfDyEFD1vivxEZ3o6vrLxzxIb7KnOYokIWQNpgbQRva8xO2aK9BPx
        GpzNIt/x6Pnh2bTR4Gj5wANdxg==
X-Google-Smtp-Source: ACHHUZ7Rj4aid8nlRPd+LYmCruDpqgvT0sk/kIQEeiehBTPEfQr67tNgGYb0f37LOnTRBJdTPpKQhg==
X-Received: by 2002:ac2:48ad:0:b0:4e8:5e39:6238 with SMTP id u13-20020ac248ad000000b004e85e396238mr3710163lfg.42.1682931925716;
        Mon, 01 May 2023 02:05:25 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f21-20020ac251b5000000b004eb554a1711sm4601208lfk.51.2023.05.01.02.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 02:05:24 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 01 May 2023 11:05:22 +0200
Subject: [PATCH 2/3] ARM: omap2: Get USB hub reset GPIO from descriptor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230430-omap2-pdata-quirks-v1-2-e015f3a3ea46@linaro.org>
References: <20230430-omap2-pdata-quirks-v1-0-e015f3a3ea46@linaro.org>
In-Reply-To: <20230430-omap2-pdata-quirks-v1-0-e015f3a3ea46@linaro.org>
To:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Lee Jones <lee@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the USB hub GPIO reset line handling in the
OMAP2 pdata quirks over to using GPIO descriptors to avoid using
the global GPIO numberspace.

Since the GPIOs are exported and assumedly used by some kind
of userspace we cannot simply use hogs in the device tree.

Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap2/pdata-quirks.c | 50 ++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index c363ad8d6a06..3264c4e77a8a 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -98,31 +98,43 @@ static struct iommu_platform_data omap3_iommu_isp_pdata = {
 };
 #endif
 
-static void __init omap3_sbc_t3x_usb_hub_init(int gpio, char *hub_name)
+static void __init omap3_sbc_t3x_usb_hub_init(char *hub_name, int idx)
 {
-	int err = gpio_request_one(gpio, GPIOF_OUT_INIT_LOW, hub_name);
+	struct gpio_desc *d;
 
-	if (err) {
-		pr_err("SBC-T3x: %s reset gpio request failed: %d\n",
-			hub_name, err);
+	/* This asserts the RESET line (reverse polarity) */
+	d = gpiod_get_index(NULL, "reset", idx, GPIOD_OUT_HIGH);
+	if (IS_ERR(d)) {
+		pr_err("Unable to get T3x USB reset GPIO descriptor\n");
 		return;
 	}
-
-	gpiod_export(gpio_to_desc(gpio), 0);
-
+	gpiod_set_consumer_name(d, hub_name);
+	gpiod_export(d, 0);
 	udelay(10);
-	gpio_set_value(gpio, 1);
+	/* De-assert RESET */
+	gpiod_set_value(d, 0);
 	msleep(1);
 }
 
+static struct gpiod_lookup_table omap3_sbc_t3x_usb_gpio_table = {
+	.dev_id = NULL,
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-160-175", 7, "reset", 0,
+				GPIO_ACTIVE_LOW),
+		{ }
+	},
+};
+
 static void __init omap3_sbc_t3730_legacy_init(void)
 {
-	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
+	gpiod_add_lookup_table(&omap3_sbc_t3x_usb_gpio_table);
+	omap3_sbc_t3x_usb_hub_init("sb-t35 usb hub", 0);
 }
 
 static void __init omap3_sbc_t3530_legacy_init(void)
 {
-	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
+	gpiod_add_lookup_table(&omap3_sbc_t3x_usb_gpio_table);
+	omap3_sbc_t3x_usb_hub_init("sb-t35 usb hub", 0);
 }
 
 static void __init omap3_evm_legacy_init(void)
@@ -187,10 +199,22 @@ static void __init omap3_sbc_t3517_wifi_init(void)
 	gpio_set_value(cm_t3517_wlan_gpios[1].gpio, 0);
 }
 
+static struct gpiod_lookup_table omap3_sbc_t3517_usb_gpio_table = {
+	.dev_id = NULL,
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-144-159", 8, "reset", 0,
+				GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-96-111", 2, "reset", 1,
+				GPIO_ACTIVE_LOW),
+		{ }
+	},
+};
+
 static void __init omap3_sbc_t3517_legacy_init(void)
 {
-	omap3_sbc_t3x_usb_hub_init(152, "cm-t3517 usb hub");
-	omap3_sbc_t3x_usb_hub_init(98, "sb-t35 usb hub");
+	gpiod_add_lookup_table(&omap3_sbc_t3517_usb_gpio_table);
+	omap3_sbc_t3x_usb_hub_init("cm-t3517 usb hub", 0);
+	omap3_sbc_t3x_usb_hub_init("sb-t35 usb hub", 1);
 	am35xx_emac_reset();
 	hsmmc2_internal_input_clk();
 	omap3_sbc_t3517_wifi_init();

-- 
2.34.1

