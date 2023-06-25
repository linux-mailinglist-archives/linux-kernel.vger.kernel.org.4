Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8573D251
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFYQ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjFYQ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:29:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F53197
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso3428791a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710528; x=1690302528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzpB2JeeP/+5LJQoX+DM+hKB46MUVJk8x7crRJkVgqQ=;
        b=trHNOk0opvYLVYmVhzWT2Po6oKItnmcPPNCDu1Fx2rMr8oCf1DH/9UCFefDEAKU+Ky
         AKS4L4xB1IOig9scwrJH7yctsWIPoE4nIkf6I8UrGBlOx9Iu9SN/Xw7lJBRa6K4GH/OH
         ai8TkQzbEqsHroNbB1V3M9DD9yNwvK3tXiw/uXgT+Ogo5sbVW6g+oCYn2c453Nqd3zVB
         v9ShFIjp2rqleT3Iv8/HCuNFcvPIlU11NtGmdz5Et7PSZcxIfrcLU+ftp0EO3e6T6r+N
         6WSwG4pSp1v6Ve2gQL00M0XoZYf8+XE4FrWVhQJI0OHJqc+qYe8tu769sjRaZVsuSYxe
         Kb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710528; x=1690302528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzpB2JeeP/+5LJQoX+DM+hKB46MUVJk8x7crRJkVgqQ=;
        b=duuneWUcLXxbOwaFayXFm02FxPSAfp6RjZeNVvVBZawqZoT5joUErA52plwYy8eobb
         YILD2KWIJPUwM7mzHuelBsaCZg8yg7vRY6TLToZtCkX9e1UH9RhwS7myIB4Isyu2TWnR
         GdOXX22DcFNQ57CtIq91ZMPtNU2TBtsXdC6RPKpo8ErD+oyrRHFx6LENKDQ5LwCg/HsB
         WevxxZrfiNosUA2ZRsouufhvphwysa2Ck8BhYudZ7CRcY6cutw0gXwIYoHC5YmuNppoK
         RQS6B9Mo9+jT1JhKKwKGqhs6H+mLYxdzgm8hhibCYYQmPOJenOda8oqm4LDkbwfXRNbY
         Ig0Q==
X-Gm-Message-State: AC+VfDwJZFJkET1JusPZECB0NaNdyAnptgRhNtqoj2AgNv+wfwb/LrFm
        0q3vqENCbWrSkKjjLtxbkhGJ+g==
X-Google-Smtp-Source: ACHHUZ4KBfW7Fea7Y3FrHDdHbT5K0EUE07fzP91vtVhy9/tp4/vXfwQsSojK+LMA4y8QpGfb34uEiA==
X-Received: by 2002:a17:907:7256:b0:988:56d1:10d8 with SMTP id ds22-20020a170907725600b0098856d110d8mr19292632ejc.53.1687710528697;
        Sun, 25 Jun 2023 09:28:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:28:48 -0700 (PDT)
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
Subject: [PATCH v4 14/24] Input: melfas_mip4 - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:28:07 +0200
Message-Id: <20230625162817.100397-15-krzysztof.kozlowski@linaro.org>
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
 drivers/input/touchscreen/melfas_mip4.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 32896e5085bd..2ac4483fbc25 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -1451,13 +1451,8 @@ static int mip4_probe(struct i2c_client *client)
 
 	ts->gpio_ce = devm_gpiod_get_optional(&client->dev,
 					      "ce", GPIOD_OUT_LOW);
-	if (IS_ERR(ts->gpio_ce)) {
-		error = PTR_ERR(ts->gpio_ce);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get gpio: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->gpio_ce))
+		return dev_err_probe(&client->dev, PTR_ERR(ts->gpio_ce), "Failed to get gpio\n");
 
 	error = mip4_power_on(ts);
 	if (error)
-- 
2.34.1

