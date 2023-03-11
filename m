Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164EF6B5AD4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCKLNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCKLNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:13:21 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8AB13D7C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:13:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id r15so3535799edq.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq77vQWPmqN0P1uClqWDA1EHy5/jRECv7qlu+zNRs6E=;
        b=wZhAnnIZeT7MXdc2zrQmCUUtQSrHgd18EBJULNpexDsCm+kAnXxTsna2cYJudLEItk
         EVVR7jB0HWSsrGexv1t8WRVbDv5wiS5X//Q0Q9UMBICgstFHLykEeIsMc6nwZy9fen4c
         faYhgqvPZW1XIDNVoq6yAs+68/2LWZRambKNXfznY0FiBh5/u7OEEQjVU3BHVid3UbSA
         i4E/T8AhOCumDQaXRrE4rCMBDIWT83vVj77CAWwhZhc1AfVj2SKQQVno+4LUVO4sqpa3
         AauuUHbFYJBBWl52L0yEnst547gn9FOMwbwMk80vK54jc9rhgbqlUzyOp0Iwc6+g4UB3
         tAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aq77vQWPmqN0P1uClqWDA1EHy5/jRECv7qlu+zNRs6E=;
        b=hiOv8NoWot0IgMI0j0A13zEuLcOeuI6YpWbHpHtiZ8zrxQLx9kcAHZMScom4zNC5mI
         gKgEqNxEe0HC19KHEvq3ecrZOQ5AJLueWmuZUBHnL4lA3QFSNDxArGk7059zuc+rp1vs
         x0ljvkjKqj15qZ0TP2QJ6G+ndezm6R/6WPyAOv8CXbXtvxTStNcJeS1p8bdawsxbunjK
         CqROpIoP9VS5WBsGq6CILCILSvlrHJBjVNkoSH6byVghnx5ly22p3eeW9uIgC+oY89XL
         UuQGPGRMJNFBXKgVpVugkG7AXkvNwhjtvSSO4r9TER7lnSMB5bqxk6kVjdZnAMaGFh6S
         YHGg==
X-Gm-Message-State: AO0yUKXXlFrC1aBGg3sWNza03bZBJCDcpVpCtRV2dJAA6YqRI2pQeBiI
        tyBXPCwYWtg3iFdbXQxH0mDOuA==
X-Google-Smtp-Source: AK7set+/rTdizsglqbDuXDqPYxb8+Sz15WC2l2nH3OBdecIwjfF3xVJtNxtd/pcpj3MJ2dwtHbkMww==
X-Received: by 2002:a17:906:52ca:b0:8ae:b008:9b5a with SMTP id w10-20020a17090652ca00b008aeb0089b5amr27143452ejn.69.1678533193246;
        Sat, 11 Mar 2023 03:13:13 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906bc4b00b008ee95ccfe06sm973189ejv.119.2023.03.11.03.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:13:12 -0800 (PST)
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
Subject: [PATCH 4/8] gpio: visconti: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 12:13:03 +0100
Message-Id: <20230311111307.251123-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
References: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/gpio/gpio-visconti.c:187:34: error: ‘visconti_gpio_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-visconti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-visconti.c b/drivers/gpio/gpio-visconti.c
index 5e108ba9956a..10d9de41f29b 100644
--- a/drivers/gpio/gpio-visconti.c
+++ b/drivers/gpio/gpio-visconti.c
@@ -194,7 +194,7 @@ static struct platform_driver visconti_gpio_driver = {
 	.probe		= visconti_gpio_probe,
 	.driver		= {
 		.name	= "visconti_gpio",
-		.of_match_table = of_match_ptr(visconti_gpio_of_match),
+		.of_match_table = visconti_gpio_of_match,
 	}
 };
 module_platform_driver(visconti_gpio_driver);
-- 
2.34.1

