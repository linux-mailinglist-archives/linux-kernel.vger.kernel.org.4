Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F93473D268
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjFYQaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjFYQ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:29:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A721A172A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98df69cacd1so73207666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710542; x=1690302542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eG4JxfUU5OHHCechxQb+4pnO54NYHWPt20ucibo4lY=;
        b=vpgYRQDgbfrJZi4G3H9i5osvGe/QUrJCZaBZ6brT2dDynlvhwjMrnarKaXvQSmkDu9
         LEf0QicKYroQPJbEbe8927u7FbOzTMS/wcQkObAqvj/husrdLsBZHJC7X5A1CHZ2WHFy
         YkCMHJ9y9YZGBx+HbYiXVRkKH0WnYvrch4cXyVbRLa8MdEQckIob+hkQ5TznlSu1so4c
         CaZEG4/CvA2BQhDPT0N+C63/IHMVKQsKtS3btGTxZCq+JzALBAoG2SJt+zK65FsY02jF
         MVZdNKSnzqfDmtNZUQqK8But8lp/IA5oAJ6FmtYWQOOnccakW78mF+0hd90Wto2V7pDD
         M1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710542; x=1690302542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eG4JxfUU5OHHCechxQb+4pnO54NYHWPt20ucibo4lY=;
        b=kX06CJZM+fU9dcCnb5YoKuip3oBu93Bxv4W1z5aG35hdZDyV4PmUciQ2hfglguOl4s
         MIRxJL5FvP59DKzDBXJEfLT5cCeJqL2LL/nQ1I7hgZvxjU/RNnsShuAeTtd+vRnwP7w9
         Xs/zjMf7uAUcf0bKqVvuCKkfndqGUCc0cTpEZsdmwnaVTpdupv4nu81JrxHhhwILqUJo
         jzcq9qZM2GkXdmt7JHwlmeUtkvv+gEPkG1CPVuN7/5LjdglK3t0pgfbCV/4IRP25l8cw
         HtDACBF2cYJlaxAvGF42+UXeMVsa1ivA469rs8kRN27P1st5shSeGvp6pjwH/SrscMdN
         KrIA==
X-Gm-Message-State: AC+VfDw8W2R3IRrjSxD0VQhxBPRbFyaBiZAMoIOxYsO1O57wAefVv05k
        K/g2qpZK+WVuM05qFmk+ZuJjd/VGOxU7Uv2ePII=
X-Google-Smtp-Source: ACHHUZ7Nfjp+egfAHh54srSRxyVh2PA3trwxm/iteOotlhhb/2Fm2fOdwsIIa4LhyHwcJMlWjUNuNg==
X-Received: by 2002:a17:907:7811:b0:98d:9dfe:e9b3 with SMTP id la17-20020a170907781100b0098d9dfee9b3mr4531048ejc.24.1687710541832;
        Sun, 25 Jun 2023 09:29:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:29:01 -0700 (PDT)
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
Subject: [PATCH v4 21/24] Input: sx8643 - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:28:14 +0200
Message-Id: <20230625162817.100397-22-krzysztof.kozlowski@linaro.org>
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
 drivers/input/touchscreen/sx8654.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 0293c493bc79..f5c5881cef6b 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -323,13 +323,9 @@ static int sx8654_probe(struct i2c_client *client)
 
 	sx8654->gpio_reset = devm_gpiod_get_optional(&client->dev, "reset",
 						     GPIOD_OUT_HIGH);
-	if (IS_ERR(sx8654->gpio_reset)) {
-		error = PTR_ERR(sx8654->gpio_reset);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev, "unable to get reset-gpio: %d\n",
-				error);
-		return error;
-	}
+	if (IS_ERR(sx8654->gpio_reset))
+		return dev_err_probe(&client->dev, PTR_ERR(sx8654->gpio_reset),
+				     "unable to get reset-gpio\n");
 	dev_dbg(&client->dev, "got GPIO reset pin\n");
 
 	sx8654->data = device_get_match_data(&client->dev);
-- 
2.34.1

