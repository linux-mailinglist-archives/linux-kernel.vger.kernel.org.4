Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0D6B5AD1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCKLNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCKLNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:13:18 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E074EF92
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:13:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x3so30651916edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Au7/yL1zYXB6rvSIYm06fKqV/NjBkMA3JzAdMmyQAvA=;
        b=XmqQxqtI03WcyyadnLOzT3XankDqi0o94vgWekai5pN10TUTNXpJG22qM9lKhC1aCs
         3AnM7FDQ2hqBZ2vgJI4I4bI1qHt4vIZ7KebWNYV/4y0ExT4HSjx4Hv+TtODAieHn9X+B
         THGjLaP9Vbs+Ze7T8gd/edgHrH5CUzGxuGUv/OXThpUHqgUM27cHLF/nVQtl3vZ8hjb3
         zuBZ2LLF4ih3ffhR8eus5Xje1uFb3AWLoc4eRmnBxKaK0gZShkcuuTbowjJb/Qa/hjWu
         gfSubhUU8uz7BWULWG9RppHcQYHp6nlwLJOG4NZKvp6pasl5CAtk83XCC2j22cbSJ3gY
         ITHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Au7/yL1zYXB6rvSIYm06fKqV/NjBkMA3JzAdMmyQAvA=;
        b=wg8CjfN1jUDvwh6B9Yl96nmc9RonvuXZ/S5PAwFqkdXe4WiDNMI8g1XjbZbr0neG2o
         BVYOoVYTzBDw8tO65b30psAwzIv8EOo3q1tOaHyMlk1m2oPQKdpWkeYceGowtnY0BsEt
         PScBbkmTxTMyrx+xQuOmVXmcF3Lkw5BRtPKeYwOBdjYbfB3jOOZ9DfZMhRWPPy1R4sPF
         PXQ0b83GXl2+VhPqzt0AqnSrW177JyXz0Q9RtzILJDKl9aUzA9+E3tU7faLeFhuPzhEb
         05BnMMD4QOcgfOoTF9TdHwlqQjpR3Krhf1HyBlNDs4HYPl8mn1oECMuBw6cUe3RpfuUc
         SucA==
X-Gm-Message-State: AO0yUKXkOGYfkkQ8lZxzV50pVUIqo3IX8Kg2Ti9YQ2JuM79TVq2ma5NC
        xhq0Ljrnrq3HKZEgKv5vJqXHXQ==
X-Google-Smtp-Source: AK7set8iOl3WmX7WqLjnrxOQrqY8rpn1ZSUQAwX6L+oyJRwqyZmjK2u+y5kkGW9jsi6G9CtnL0hTrw==
X-Received: by 2002:a17:906:a4b:b0:88a:cbd1:e663 with SMTP id x11-20020a1709060a4b00b0088acbd1e663mr25443626ejf.6.1678533191998;
        Sat, 11 Mar 2023 03:13:11 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906bc4b00b008ee95ccfe06sm973189ejv.119.2023.03.11.03.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:13:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/8] gpio: rcar: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 12:13:02 +0100
Message-Id: <20230311111307.251123-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
References: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/gpio/gpio-rcar.c:435:34: error: ‘gpio_rcar_of_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 5b117f3bd322..2525adb52f4f 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -663,7 +663,7 @@ static struct platform_driver gpio_rcar_device_driver = {
 	.driver		= {
 		.name	= "gpio_rcar",
 		.pm     = &gpio_rcar_pm_ops,
-		.of_match_table = of_match_ptr(gpio_rcar_of_table),
+		.of_match_table = gpio_rcar_of_table,
 	}
 };
 
-- 
2.34.1

