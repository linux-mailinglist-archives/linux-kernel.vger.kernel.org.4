Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC24473D252
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjFYQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjFYQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:29:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E8410F4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98bcc533490so292286666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710530; x=1690302530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFr85Va+I3JFQ/CS1AHNqQf8ybLG0IaDbtC5ESPVDI4=;
        b=P4/793FflPwuLOra9+yrjA1oii1q+mVvOCozzGq6xWF1CWxQa5aZaBBkMLzabIuC62
         Yvd4/yFuCpxebdB1dgr8lR14V4yBjqIr5vrShuzX7UtrZ6Xmj6TDNHeJDvsL540s/0kh
         jg1bjAJJlDKifdR5vSy9w+PBoKbOBp2JmHYqnkWjUeuxy5lMtNflQkL/YHpfyMBTx6Sr
         /xf8EdttzMS2cRAbvHLzP3cnSiWJMPbRAEDoeBCXxOqfw9uBus9Wio2VRQxTTEMdrYES
         53N507f6V0yvEqvE8EnkwGCgxv9U0V2LkZJHk1M1Kzl9vCqW1qNzKUhQ3uUJEEIM6rb6
         g9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710530; x=1690302530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFr85Va+I3JFQ/CS1AHNqQf8ybLG0IaDbtC5ESPVDI4=;
        b=B6mW/9LDIJXI/8RHdt2+kfK9vVqh6QrZeXBpT6nVXEsGOa4euoEHmbyZlF4pVwJIuE
         qfp4F0tAodAGVgXAA2XfjYoVfI0NdcZyozBxH3H0ljOqvflE81VTNv7GGMpCD+uYSB6L
         tNzTwLlvTYa8SZ0RGYXdgSnaowewyynaOl4f6+InyUmkAQsNEhqFWn9SCQk0CNWa6NTJ
         cCOTCxtJyU/IoEK4RjabSm7QmS4RaXtpRqPbsCpdn6a6/f1qXoJtv7GrPGuTUdX3/rxN
         caHUkyMypCRtF8JVsxpygy9a2h/nbeqENjTq7lFJjTtQALJ5ulTBAvpTyGUF6TOeOv1Y
         p2iQ==
X-Gm-Message-State: AC+VfDxS5o+F2iVQYl56rjtPqaQL6e83xlDhKh8+Z++Pg5ruKcdd261G
        1FductXs24vOqD3mC0j5SxprIw==
X-Google-Smtp-Source: ACHHUZ4iIpuVAQ8JeSeF/0XeL1REszISpgqSO7v4nyUS+OWRO4inwAZIh67lnuhSqW8mMFQdRGOTpg==
X-Received: by 2002:a17:907:3e88:b0:97d:cdf4:719f with SMTP id hs8-20020a1709073e8800b0097dcdf4719fmr25395707ejc.68.1687710530492;
        Sun, 25 Jun 2023 09:28:50 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:28:50 -0700 (PDT)
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
Subject: [PATCH v4 15/24] Input: pixcir_i2c_ts - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:28:08 +0200
Message-Id: <20230625162817.100397-16-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
References: <20230625162817.100397-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 drivers/input/touchscreen/pixcir_i2c_ts.c | 38 +++++++----------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 554e179c2e48..0b4576091dac 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -515,41 +515,27 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client)
 	input_set_drvdata(input, tsdata);
 
 	tsdata->gpio_attb = devm_gpiod_get(dev, "attb", GPIOD_IN);
-	if (IS_ERR(tsdata->gpio_attb)) {
-		error = PTR_ERR(tsdata->gpio_attb);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Failed to request ATTB gpio: %d\n",
-				error);
-		return error;
-	}
+	if (IS_ERR(tsdata->gpio_attb))
+		return dev_err_probe(dev, PTR_ERR(tsdata->gpio_attb),
+				     "Failed to request ATTB gpio\n");
 
 	tsdata->gpio_reset = devm_gpiod_get_optional(dev, "reset",
 						     GPIOD_OUT_LOW);
-	if (IS_ERR(tsdata->gpio_reset)) {
-		error = PTR_ERR(tsdata->gpio_reset);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Failed to request RESET gpio: %d\n",
-				error);
-		return error;
-	}
+	if (IS_ERR(tsdata->gpio_reset))
+		return dev_err_probe(dev, PTR_ERR(tsdata->gpio_reset),
+				     "Failed to request RESET gpio\n");
 
 	tsdata->gpio_wake = devm_gpiod_get_optional(dev, "wake",
 						    GPIOD_OUT_HIGH);
-	if (IS_ERR(tsdata->gpio_wake)) {
-		error = PTR_ERR(tsdata->gpio_wake);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get wake gpio: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(tsdata->gpio_wake))
+		return dev_err_probe(dev, PTR_ERR(tsdata->gpio_wake),
+				     "Failed to get wake gpio\n");
 
 	tsdata->gpio_enable = devm_gpiod_get_optional(dev, "enable",
 						      GPIOD_OUT_HIGH);
-	if (IS_ERR(tsdata->gpio_enable)) {
-		error = PTR_ERR(tsdata->gpio_enable);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get enable gpio: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(tsdata->gpio_enable))
+		return dev_err_probe(dev, PTR_ERR(tsdata->gpio_enable),
+				     "Failed to get enable gpio\n");
 
 	if (tsdata->gpio_enable)
 		msleep(100);
-- 
2.34.1

