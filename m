Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692AD73D265
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjFYQaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjFYQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:29:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BAFE47
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9741caaf9d4so194412966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710536; x=1690302536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBwWVyiT1or6L/qAtYaBPHGSvXZlvDgrfYi37JFCZ9A=;
        b=QPMfHgMkgP1G4fF1llYySBCqeYS4EtgSTgIqSwonEoQJslqEOK3iRXl+ZBCpLQpjWm
         gcTiyfl+RCObIBJJVzDP42TPlz7Vw8+HmcS9fJ9f1H8rt3Ew9IhEjY+KMruiDE5cyoj9
         TbTL5m33RNK+vdADYbLrldRcvEcguiJ9pFhd93bvy7JldyrRzpR4B0k6RiHdR1R44zNv
         krMEMtY/e69Pufm/yc2V3ZzCFx6NoF05hxOLL3G6X8o8/K/McPbdLG7b+49LMK9bIcV1
         QrRe1U6V4cXUixc682+ITuHi5n/UGh8W1k4Eexr2VDLDbOYpodKa/PdhVnqJHNkCPI3D
         QXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710536; x=1690302536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBwWVyiT1or6L/qAtYaBPHGSvXZlvDgrfYi37JFCZ9A=;
        b=eo+2t1dqRKvRN2aSwntKxwg+e3xVDbqQLfdggvVblA3WjSgjD09+OjHchD9i9ExLDq
         5UEQUkAAz/feJZRsGlzQbrexGmVQlX6IHyZPyu/W1zRZpThi6S0LYQEx0yqATqGii0Kw
         MLv1sbeUlgotx+0Mbs/XnO/46JQhu25mchqXP0ktZsr9yZsNF4GjmOcrikyKwG1I2X80
         LD9LYNIqJxtsDFDqVBgbkQCDiGOkPwfBJz9+7wQTua7olZ9qLUs3XKMJSzGyjlOLV0pm
         QxRTTVCitmtSUdfU2PIOVS1VkObUmy00TWxpjZ0+twUaFqCsjk6YYwCEiiUkaZOfx5Oy
         tITw==
X-Gm-Message-State: AC+VfDypCBRTrrWl192C3prTGMSo4fmxHlnYK9x4moFs+lYCxQgsbgBn
        K+DJjJSotpz2fHPH4kJMK3Kd7Q==
X-Google-Smtp-Source: ACHHUZ56u1JEBMpCzlL4LAGuaJ/ZlB0XiRh/kGy0YbXR8oi78PJ6a/l7ly6YbZewI7R4JBzJKWIp3Q==
X-Received: by 2002:a17:906:6a25:b0:989:40a9:505d with SMTP id qw37-20020a1709066a2500b0098940a9505dmr14530283ejc.0.1687710536045;
        Sun, 25 Jun 2023 09:28:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:28:55 -0700 (PDT)
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
Subject: [PATCH v4 18/24] Input: silead - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:28:11 +0200
Message-Id: <20230625162817.100397-19-krzysztof.kozlowski@linaro.org>
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
 drivers/input/touchscreen/silead.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 9e28f962e059..62f562ad5026 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -706,11 +706,9 @@ static int silead_ts_probe(struct i2c_client *client)
 
 	/* Power GPIO pin */
 	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
-	if (IS_ERR(data->gpio_power)) {
-		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
-			dev_err(dev, "Shutdown GPIO request failed\n");
-		return PTR_ERR(data->gpio_power);
-	}
+	if (IS_ERR(data->gpio_power))
+		return dev_err_probe(dev, PTR_ERR(data->gpio_power),
+				     "Shutdown GPIO request failed\n");
 
 	error = silead_ts_setup(client);
 	if (error)
-- 
2.34.1

