Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E45FF338
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiJNRzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiJNRys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:54:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751C327143;
        Fri, 14 Oct 2022 10:54:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 70so5563652pjo.4;
        Fri, 14 Oct 2022 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YV6Nxa393Zempvv48DGSX3qqsS8tBZ+cvvfhAdg2hN8=;
        b=hwC+mpYbil+uUfrrGEvi6q5Oh8PUE3JdtPxYi+K/8CTb842BUQ8RKXbwcPRmk6LcLE
         06fqPcitEvEnh1os3P0z6agizAe9Deq4xAZ30T2wH647kIPkjh5I44n16FDPadB1H1rD
         w5MaAbTRkAi8LbHFtGq/8NUJl4plyS2YhyMaVepHko7xDpJljO6CyjzDS73F4tHyDCUL
         Lq6XZJGEC0IKVDNqAfBksg8iZwwj8AI4F9UehOCtO3lNFWrbxthPLbiknRH9Fq+wwsXQ
         QK4GxMso3gnnhY9NLG/v9bnDG+eqNEHjut2fJPEVCvczUSc/EcJsFwVGCzV8RFhgpD4e
         6NCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YV6Nxa393Zempvv48DGSX3qqsS8tBZ+cvvfhAdg2hN8=;
        b=QzidiDYuE6LKEI2zE0VdxEZDqG0wZ5JN2kH2VDmHfo9xQZDh3n9soJhve70pp7fiKO
         fjPdabaKDZjoecmIsUIfe1jfRQipQdKEcc073+7kjXz7dMH8h3fAeouwKnSKNaXZrkPF
         6oOdUGTMv+fhRGEih9/sAXliIzJCObZFm72VH/0Fz0MLtKg/bvJLH/bRyJJTRcalsHTt
         MC1fGqw262vhFjGTlnOcvzebF4hlKoE2Ufv8HbZXkRvDXhTkUxHit1oZhNMlKI8BbnVZ
         SC2REgRnx4prn0FDi6bRhBMSWaXizgZOBI8njtOLct16DIgLPYO8vwERMkUWmnw0HjQO
         p7gQ==
X-Gm-Message-State: ACrzQf2EAK4tGErNKWRKAe/274uhgj2hUSvJKl0jz/zyj9ZpJ32Mmw5E
        CmKsajI8VpEH2hJz7SOwLZo=
X-Google-Smtp-Source: AMsMyM4UJN/MfIJhz+fb45nTKPD8eMsnAGrApUkaCX+Tmu1QtkZTx79R7xkFMxVviLuT0TKQANgcvQ==
X-Received: by 2002:a17:902:ec81:b0:185:3cea:6326 with SMTP id x1-20020a170902ec8100b001853cea6326mr6596411plg.24.1665770084657;
        Fri, 14 Oct 2022 10:54:44 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:da06:5604:594f:f6af])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b0017f7819732dsm2011780plb.77.2022.10.14.10.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 10:54:44 -0700 (PDT)
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
Subject: [PATCH v2 4/9] gpiolib: of: add quirk for locating reset lines with legacy bindings
Date:   Fri, 14 Oct 2022 10:54:28 -0700
Message-Id: <20221011-gpiolib-quirks-v2-4-73cb7176fd94@gmail.com>
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

Some legacy mappings used "gpio[s]-reset" instead of "reset-gpios",
add a quirk so that gpiod API will still work on unmodified DTSes.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 7d4bbf6484bc..2b5d1b3095c7 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -382,9 +382,18 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		 */
 		const char *compatible;
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
 
 		/*
 		 * Some regulator bindings happened before we managed to
@@ -399,6 +408,13 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		{ "wlf,ldo2ena", NULL,		NULL }, /* WM8994 */
 #endif
 
+#if IS_ENABLED(CONFIG_SND_SOC_TLV320AIC3X)
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3x" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic33" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3007" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3104" },
+		{ "reset",	"gpio-reset",	"ti,tlv320aic3106" },
+#endif
 #if IS_ENABLED(CONFIG_SPI_GPIO)
 		/*
 		 * The SPI GPIO bindings happened before we managed to

-- 
b4 0.11.0-dev-5166b
