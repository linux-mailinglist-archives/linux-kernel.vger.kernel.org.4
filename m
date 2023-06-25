Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9892A73D244
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjFYQ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjFYQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:29:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D4310D3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9786fc23505so193117966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710523; x=1690302523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZfZ872GVOCcTPRjs89Uw4yCp3UorSm6QgpAUx4XVGY=;
        b=Uo1zyOlLpZL2UBUHHUOOzVncIJZUYyWyf+KewkL3fWr5uxxQ0uOaPw4Xv2hQwniSfc
         pgH2LSxOxvUXpNiE8EZ34eAw9p6xaJzvDkxghta3xsyyfzw2ezFfsCzELzjJiVXLIMwg
         d7TfoQp25dFYj7lLljcgxRHLH1gHGo4QytWJxa/4yRpHrVr6EoaVN8QYEHiL7yaznWYO
         jrMX6E9H5A7yRNPA0l2KKsaZgxBbATBGQlD2PNw60hFBp52zFrC5mdDGCZ7ECH1uxXd+
         8KSTb4Vlko3rV/Y7yE2emHAjZRLQoxLfyUaBQi2oK3y+zUmWbaIqvKGL8CV8IfL27L2m
         teZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710523; x=1690302523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZfZ872GVOCcTPRjs89Uw4yCp3UorSm6QgpAUx4XVGY=;
        b=gmUl3GqJQ0p2oQF9TIw3+g6kM6/T2bEV0c5ML72B6USjX7XpNgKsIh0zfuiKomm1pb
         2qeWl0IKJ26WXAIwWH5OI0Gf0WpJ0rhZUuMxHXKLgcj29apMqdJbYOZQuKBzRH57/F0J
         2rKXOCvGKgRUMo53CVWvSRPjOqRDywna/c39636B45zgkoGqogS2MNUyknX5CZjoLgbq
         FMmqcPtTw+btBrc7NC/UiTLLcWNfAdnc1zEjZndKdO+OuVKGfzax+gzIoqNJDlWY445v
         ZKNArlfavTx6wOdQkyQalIX+/qCRPVKmFKnqfeMWCM06Fyp5PUZlUwk3VXgg7P2AipMg
         1GIQ==
X-Gm-Message-State: AC+VfDwaxYIVmEiyNtIVBlVlzMncUhRAh3ia4NMUBw2tLFAqwTMSPe2x
        CY5T5tP7MEz3KgLvNL3xGVCvVQ==
X-Google-Smtp-Source: ACHHUZ4y90Vk1OH9umTel8HjlFcdquOy+Gq4wyj7Nqui5KfInqv/34x9nmNgY2AhqPNBhNprLPUCsw==
X-Received: by 2002:a17:907:3189:b0:974:2169:5f81 with SMTP id xe9-20020a170907318900b0097421695f81mr23050480ejb.22.1687710523442;
        Sun, 25 Jun 2023 09:28:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:28:43 -0700 (PDT)
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
Subject: [PATCH v4 11/24] Input: ektf2127 - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:28:04 +0200
Message-Id: <20230625162817.100397-12-krzysztof.kozlowski@linaro.org>
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
 drivers/input/touchscreen/ektf2127.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
index fd8724a3c19f..cc3103b9cbfb 100644
--- a/drivers/input/touchscreen/ektf2127.c
+++ b/drivers/input/touchscreen/ektf2127.c
@@ -264,12 +264,8 @@ static int ektf2127_probe(struct i2c_client *client)
 
 	/* This requests the gpio *and* turns on the touchscreen controller */
 	ts->power_gpios = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);
-	if (IS_ERR(ts->power_gpios)) {
-		error = PTR_ERR(ts->power_gpios);
-		if (error != -EPROBE_DEFER)
-			dev_err(dev, "Error getting power gpio: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->power_gpios))
+		return dev_err_probe(dev, PTR_ERR(ts->power_gpios), "Error getting power gpio\n");
 
 	input = devm_input_allocate_device(dev);
 	if (!input)
-- 
2.34.1

