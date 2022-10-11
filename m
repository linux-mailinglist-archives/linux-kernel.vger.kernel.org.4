Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55435FBDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJKWTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJKWTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:19:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7276EE3E;
        Tue, 11 Oct 2022 15:19:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f140so14817154pfa.1;
        Tue, 11 Oct 2022 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhyRfNRLvXdJqTEKmbHvJb0Krk3UyiSQItTbwFfBY0Q=;
        b=jekSfU6bSssvmSN6shHkFWzrkqwUP6Dh/I247pcSVjamDvq77Ri2F9VMB/FIyTDdU/
         w0sU/ojt3oZmKldccy4LMbsGFnOzpO5ycXuU3U7Qx+8NMcuNz7qV8uvgzCYxBLr5lnZ0
         kh397lLEPgMfrGz3Gv3JGpMrS5JvyMfMg2xj2KtgWiRelv0vlPbiIZx4W2EDhKe2KeAI
         qQ+t2OUCyW6ZmkjXGirtbFHctLXhqnZlNAx7EwIh/7SKTIs8vwioNVeObW5JcKoXXQBc
         13p8PQBW6YqrxYpNqBSniLLbFiNNcgsCa49FEhitXvBMudkU907TTa+zp87QM1kVNj5X
         cagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhyRfNRLvXdJqTEKmbHvJb0Krk3UyiSQItTbwFfBY0Q=;
        b=Ibm2zNMLIuqbemOFV3OU0hKcEDF0NVeYaW++cMMBZliLxxyy4t9Yl5T5MMTQukNdWf
         urfCkT/tK26iuEQbAj2IS2zhzeqkN3q6laKNsQoHfk6DcYS7yhjq7msMfJjuMe+zCGVj
         biU6Y8n9BlpaySQBcVkELsm8wr1g1cr+s6JqsFTPzk9hbONiN/4w1z4ZjFSyZNQmagJS
         ptqHaDSpXss7sEre2648ZrOUwEqC3nbjBpiGfu8rZHfugivlTC4jausUa46K9uTcbi5j
         SKZp0l9x9DF7YLH9rNXetKK3OEkxmXx1NCuqrKtpzVKh8kWORmQZuOdbZFH+zFiQ/Z4z
         E+hQ==
X-Gm-Message-State: ACrzQf3MLTxB/EXtcpTw5ngAofX2nOaQdA23MoGWNwCgzBiDUtI4GDyt
        ZcTD30Vq++PwTr5yjTvgA6Q=
X-Google-Smtp-Source: AMsMyM6LQqmkoRXYQmKJL9XWaaA+rIB+jKj+cYC4OTvZazSGvk1PtVlLhh+08LP/j2Coex+D1iWRHw==
X-Received: by 2002:a05:6a00:2392:b0:549:be0:cd3c with SMTP id f18-20020a056a00239200b005490be0cd3cmr27346862pfc.8.1665526781095;
        Tue, 11 Oct 2022 15:19:41 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:becc:db10:eb45:dc35])
        by smtp.gmail.com with ESMTPSA id l6-20020a17090ab70600b0020d39ffe987sm60151pjr.50.2022.10.11.15.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:19:40 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 1/7] gpiolib: of: add a quirk for legacy names in Mediatek mt2701-cs42448
Date:   Tue, 11 Oct 2022 15:19:29 -0700
Message-Id: <20221011-gpiolib-quirks-v1-1-e01d9d3e7b29@gmail.com>
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

The driver is using non-standard "i2s1-in-sel-gpio1" and
"i2s1-in-sel-gpio2" names to describe its gpios. In preparation to
converting to the standard naming (i2s1-in-sel-gpios) and switching the
driver to gpiod API add a quirk to gpiolib to keep compatibility with
existing DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 0e4e1291604d..cef4f6634125 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -488,6 +488,38 @@ static struct gpio_desc *of_find_usb_gpio(struct device_node *np,
 	return of_get_named_gpiod_flags(np, con_id, idx, of_flags);
 }
 
+static struct gpio_desc *of_find_mt2701_gpio(struct device_node *np,
+					     const char *con_id,
+					     unsigned int idx,
+					     enum of_gpio_flags *of_flags)
+{
+	struct gpio_desc *desc;
+	const char *legacy_id;
+
+	if (!IS_ENABLED(CONFIG_SND_SOC_MT2701_CS42448))
+		return ERR_PTR(-ENOENT);
+
+	if (!of_device_is_compatible(np, "mediatek,mt2701-cs42448-machine"))
+		return ERR_PTR(-ENOENT);
+
+	if (!con_id || strcmp(con_id, "i2s1-in-sel"))
+		return ERR_PTR(-ENOENT);
+
+	if (idx == 0)
+		legacy_id = "i2s1-in-sel-gpio1";
+	else if (idx == 1)
+		legacy_id = "i2s1-in-sel-gpio2";
+	else
+		return ERR_PTR(-ENOENT);
+
+	desc = of_get_named_gpiod_flags(np, legacy_id, 0, of_flags);
+	if (!gpiod_not_found(desc))
+		pr_info("%s is using legacy gpio name '%s' instead of '%s-gpios'\n",
+			of_node_full_name(np), legacy_id, con_id);
+
+	return desc;
+}
+
 typedef struct gpio_desc *(*of_find_gpio_quirk)(struct device_node *np,
 						const char *con_id,
 						unsigned int idx,
@@ -498,6 +530,7 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
 	of_find_regulator_gpio,
 	of_find_arizona_gpio,
 	of_find_usb_gpio,
+	of_find_mt2701_gpio,
 	NULL
 };
 

-- 
b4 0.11.0-dev-5166b
