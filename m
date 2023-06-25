Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E8473D226
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFYQ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjFYQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:28:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC59194
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:28:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98e1d3be004so115156066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687710504; x=1690302504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZvbC3ZPt55NmPj9EWoBgNDeYcxlZ+9WZ1c1ZpUtvDs=;
        b=V3MOXov53g3ZDu8LrcB6yeY3mCKfLjTgv8aERjwD6ZwjRyP74+miUwM/OWlxgCKtyN
         y5wq3vW9LNqZVFmyctn9GDTylK7ShRLmGWcdy+i+YlPhORyLkho48YWmPhhCleBCCCOk
         lwwtwGBnoej1wmCBzbqv7hFR+DTmWUo3VXJUSeq1HsyCcGTx70//ycUCBodR3Pj0qrWG
         ym3Q1M+U8QonDF9G5KdwgsFkRYl4/qvsnZLaKo2u00CCq7gRiYZCc5Co46UzgreV43Q8
         J3NwB5fTLMaoAlsrWzVbnhIYn6kQHgU6/s1zvgFnLSXw15nBxsibJAo+WA3HqzDn3IIk
         HTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710504; x=1690302504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZvbC3ZPt55NmPj9EWoBgNDeYcxlZ+9WZ1c1ZpUtvDs=;
        b=FTliZXt4QCjxlQjtPwmb/2t4cRgwNhkLgiSIGbjDGjmLhpyiTmCufwf7D7Vg+eal99
         vYpprLkcnxfdGw6qMi35bGGQZ5j+Z6jqV2jo0CMJwjKGnP5YotG2Bo8LjFtI3N7VLzoY
         qcZSi19b0uaVS1x7WYRt2ee/2ksYBNtTfDc6oRHdslDx1v9lLm5MNd+6HeZ6fONn2hM0
         7jqbndjUKtVr+kqrCNKf8OVvsspGP8g//HORTEzU4i7bzdksuHKvfuptGf5efICrVF9/
         qJTis7LJLVyUWOfi8Yr6rKKWWKWR3o6HkjU0l8innz9VHqBQYRmuSutxQN8mPVpNnLFX
         f24w==
X-Gm-Message-State: AC+VfDxpu7M/tdG3CVNbPQkAoOna5KBJYLfxq1GQgnct5KDgATRDESuY
        0SrUrdq+4ylB7IJ5AGmO/L81Hw==
X-Google-Smtp-Source: ACHHUZ7LwF/EkwHPQat94JubUk3MHUNZkHDbypKquqibnFIEfO4pVx/UQakxKBC+rYD5qsC2uKy9nw==
X-Received: by 2002:a17:907:8688:b0:973:e349:43c8 with SMTP id qa8-20020a170907868800b00973e34943c8mr23825334ejc.69.1687710504335;
        Sun, 25 Jun 2023 09:28:24 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b00982be08a9besm2277731ejb.172.2023.06.25.09.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 09:28:23 -0700 (PDT)
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
Subject: [PATCH v4 01/24] Input: gpio_keys_polled - Simplify with dev_err_probe()
Date:   Sun, 25 Jun 2023 18:27:54 +0200
Message-Id: <20230625162817.100397-2-krzysztof.kozlowski@linaro.org>
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
 drivers/input/keyboard/gpio_keys_polled.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index c3937d2fc744..ba00ecfbd343 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -299,13 +299,9 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 							     NULL, GPIOD_IN,
 							     button->desc);
 			if (IS_ERR(bdata->gpiod)) {
-				error = PTR_ERR(bdata->gpiod);
-				if (error != -EPROBE_DEFER)
-					dev_err(dev,
-						"failed to get gpio: %d\n",
-						error);
 				fwnode_handle_put(child);
-				return error;
+				return dev_err_probe(dev, PTR_ERR(bdata->gpiod),
+						     "failed to get gpio\n");
 			}
 		} else if (gpio_is_valid(button->gpio)) {
 			/*
-- 
2.34.1

