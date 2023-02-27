Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2079A6A4C79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjB0Uvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0Uvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:51:38 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E71EFEF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:51:37 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cy6so31175683edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e124E0pr34PAN91uKXPAbGtavFgIogfWrydKthVEf0E=;
        b=Msljfd0DAOSV1Ng8uIK/mnFUzcITqVx7VNkBOQVwfqu7nD/mLOXNK+QL9hurrXRwFn
         W22/+c8iLbrDPOIExuNn6xorlSdGmNDZocrV4NhDMD8Dm3bnuuyL2lwLSBJiZQs3BAqF
         EYXQKn9EBAsLGT8Z+8bQyvV+taV8ZMcm7P5ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e124E0pr34PAN91uKXPAbGtavFgIogfWrydKthVEf0E=;
        b=jeXQz6cEhF0CCy5XhhsXB2+IA9/p2oFeJqagxTnqNA8lShLjL8uwV+pjtkKFChViMe
         rRtzX6diXaHPR1gBPAISkBv+CszagKdmPtXVJc/lJLM/oclTMvb6fbjXf1AbrQwb1Hz3
         n3I6nGLY5yEoNMsxxSwbNw3W5r886dyKdQqy7b6SNl5Wy9KvASPmWos7Ej/F/JZANKTR
         5jqZXaiTBdT3yEOiJU98aF3s6H9wELi3ZA+LCO1IAgPS1osclxwksSz/pYoO3RklP7j8
         eFiNCXtYnKFQfTKxlV9CRAzN8ftOjct5YMzgy8lR5HsPmZBndRY6h/4tpvYPRRBmY082
         8JPQ==
X-Gm-Message-State: AO0yUKW+t++iQWNILZstIDb3yQfp6U82k8410GyY5sn7GYvB4CZ/ja1Y
        ku26448g2YScESBNKTxbQDv5fUV17ReCH7n4R2w=
X-Google-Smtp-Source: AK7set/09hUebX3TUSz8Zk89YxuS48cruhUseyV6cCooMrzGlOnaU2lz/zSmizCZH80dS8HxpvF7Kg==
X-Received: by 2002:aa7:d98d:0:b0:4ad:5950:3f47 with SMTP id u13-20020aa7d98d000000b004ad59503f47mr963127eds.9.1677531095698;
        Mon, 27 Feb 2023 12:51:35 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-22-12.retail.telecomitalia.it. [82.56.22.12])
        by smtp.gmail.com with ESMTPSA id i26-20020a50871a000000b004af70a660a9sm3578032edb.75.2023.02.27.12.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 12:51:35 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] pinctrl: stm32: use dynamic allocation of GPIO base
Date:   Mon, 27 Feb 2023 21:51:31 +0100
Message-Id: <20230227205131.2104082-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 502df79b860563d7 ("gpiolib: Warn on drivers still using static
gpiobase allocation"), one or more warnings are printed during boot on
systems where static allocation of GPIO base is used:

[    0.197707] gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.199942] stm32f429-pinctrl soc:pinctrl@40020000: GPIOA bank added
[    0.200711] gpio gpiochip1: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.202855] stm32f429-pinctrl soc:pinctrl@40020000: GPIOB bank added
[    0.203591] gpio gpiochip2: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.205704] stm32f429-pinctrl soc:pinctrl@40020000: GPIOC bank added
[    0.206338] gpio gpiochip3: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.208448] stm32f429-pinctrl soc:pinctrl@40020000: GPIOD bank added
[    0.209182] gpio gpiochip4: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.211282] stm32f429-pinctrl soc:pinctrl@40020000: GPIOE bank added
[    0.212094] gpio gpiochip5: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.214270] stm32f429-pinctrl soc:pinctrl@40020000: GPIOF bank added
[    0.215005] gpio gpiochip6: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.217110] stm32f429-pinctrl soc:pinctrl@40020000: GPIOG bank added
[    0.217845] gpio gpiochip7: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.219959] stm32f429-pinctrl soc:pinctrl@40020000: GPIOH bank added
[    0.220602] gpio gpiochip8: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.222714] stm32f429-pinctrl soc:pinctrl@40020000: GPIOI bank added
[    0.223483] gpio gpiochip9: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.225594] stm32f429-pinctrl soc:pinctrl@40020000: GPIOJ bank added
[    0.226336] gpio gpiochip10: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    0.228490] stm32f429-pinctrl soc:pinctrl@40020000: GPIOK bank added

So let's follow the suggestion and use dynamic allocation.

Tested on STM32F429I-DISC1 board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/pinctrl/stm32/pinctrl-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index cb33a23ab0c1..04ace4c7bd58 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1330,7 +1330,7 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 	if (fwnode_property_read_u32(fwnode, "st,bank-ioport", &bank_ioport_nr))
 		bank_ioport_nr = bank_nr;
 
-	bank->gpio_chip.base = bank_nr * STM32_GPIO_PINS_PER_BANK;
+	bank->gpio_chip.base = -1;
 
 	bank->gpio_chip.ngpio = npins;
 	bank->gpio_chip.fwnode = fwnode;
-- 
2.32.0

