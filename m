Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6073D24E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjFYQ3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjFYQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:29:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02362269F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51d9124e1baso1476980a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710527; x=1690302527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/rzC2uY92Y7QjHEbrLYHKQpIVmtiRBB2yJYhOpPt9Y=;
        b=kWNVgHVXaDznJi3aUv40cg0WDHjPqeQbE7ooAhNpc2QVWxrle12iAqj9L+h1TWwXDk
         dtkI3ow6FX5XwNM2MAed6C8itsSEWMtYnbIJocwNd873waZ/vDuEnPIfCTdcgUwZM7Cl
         O+qvTaWV3lFRymsHglHnxKJhxBytkBk83943nXaapTsWi20aON/w+L1Wl0hcPzvfFXhD
         /OlecmPqtoZ9NICiamf4EhZWcMr7NqgEDXVoHqOWJu+xyh0hI2gSKxXB4uOnWywbCveZ
         D/XizEWkdsh50oE8aorQCbqCr6iWPg//rU0BnBlaG1jXMHaEztkDAJJylN6+CM+8AZYV
         /ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710527; x=1690302527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/rzC2uY92Y7QjHEbrLYHKQpIVmtiRBB2yJYhOpPt9Y=;
        b=EApmZJL/FYdnSzLJn1uSn/Q0RHZNTct3P+DnQ4HeE1rPE2kwkZZcO/eQc8AMkIPBUP
         +XFt0PqCAk0QtWKP4iD2I0SZ7+IUabe4h3hlfTTJDdaxG0Uassw1+7mryQtCwotHE73l
         Bo7wb6/RkzPFWL3uPm3PzOQaVIVYvoNhNDiAPSPTO4XFX7Qt4ncrCSeqENHdLUBWCnP+
         XVnC3CNGvTeuNcNJzIavY6HeGBdhvNW2KbSNovJAwdi4TPTMPeFcp99ZkUXK7oxlMeN4
         0s1jVHjLOT+CuT9HduokwD1nK1F1Gw3ugf1Bx7rk/js+GnbgJrY/o7XxxXTTuSfoovhO
         MCJg==
X-Gm-Message-State: AC+VfDwTmZk0YfELebvk/gmzfoFFW1WSisvfjDLjhCdJKxNVGvX6i01R
        smuGNptU+I3JgBbujTeo3fV48g==
X-Google-Smtp-Source: ACHHUZ4BOguJGgvQUdBr/7tJsm58YGWNa+vqxnxV1YpaTPhoPeHr/NE4gBjdMj0HYjBTCHK6qE943g==
X-Received: by 2002:a17:907:d0f:b0:94e:4489:f24d with SMTP id gn15-20020a1709070d0f00b0094e4489f24dmr26387029ejc.61.1687710526920;
        Sun, 25 Jun 2023 09:28:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:28:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 13/24] Input: goodix - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:28:06 +0200
Message-Id: <20230625162817.100397-14-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
References: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/input/touchscreen/goodix.c | 40 ++++++++----------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f5aa240739f9..85d4249f1065 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -935,7 +935,6 @@ static int goodix_add_acpi_gpio_mappings(struct goodix_ts_data *ts)
  */
 static int goodix_get_gpio_config(struct goodix_ts_data *ts)
 {
-	int error;
 	struct device *dev;
 	struct gpio_desc *gpiod;
 	bool added_acpi_mappings = false;
@@ -951,33 +950,20 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
 	ts->gpiod_rst_flags = GPIOD_IN;
 
 	ts->avdd28 = devm_regulator_get(dev, "AVDD28");
-	if (IS_ERR(ts->avdd28)) {
-		error = PTR_ERR(ts->avdd28);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev,
-				"Failed to get AVDD28 regulator: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->avdd28))
+		return dev_err_probe(dev, PTR_ERR(ts->avdd28), "Failed to get AVDD28 regulator\n");
 
 	ts->vddio = devm_regulator_get(dev, "VDDIO");
-	if (IS_ERR(ts->vddio)) {
-		error = PTR_ERR(ts->vddio);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev,
-				"Failed to get VDDIO regulator: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->vddio))
+		return dev_err_probe(dev, PTR_ERR(ts->vddio), "Failed to get VDDIO regulator\n");
 
 retry_get_irq_gpio:
 	/* Get the interrupt GPIO pin number */
 	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
-	if (IS_ERR(gpiod)) {
-		error = PTR_ERR(gpiod);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get %s GPIO: %d\n",
-				GOODIX_GPIO_INT_NAME, error);
-		return error;
-	}
+	if (IS_ERR(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod), "Failed to get %s GPIO\n",
+				     GOODIX_GPIO_INT_NAME);
+
 	if (!gpiod && has_acpi_companion(dev) && !added_acpi_mappings) {
 		added_acpi_mappings = true;
 		if (goodix_add_acpi_gpio_mappings(ts) == 0)
@@ -988,13 +974,9 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
 
 	/* Get the reset line GPIO pin number */
 	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_RST_NAME, ts->gpiod_rst_flags);
-	if (IS_ERR(gpiod)) {
-		error = PTR_ERR(gpiod);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get %s GPIO: %d\n",
-				GOODIX_GPIO_RST_NAME, error);
-		return error;
-	}
+	if (IS_ERR(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod), "Failed to get %s GPIO\n",
+				     GOODIX_GPIO_RST_NAME);
 
 	ts->gpiod_rst = gpiod;
 
-- 
2.34.1

