Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F11626A38
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiKLP32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLP31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:29:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496EFC773;
        Sat, 12 Nov 2022 07:29:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so6745535wmi.1;
        Sat, 12 Nov 2022 07:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6cp5m3ImBZ7KTnMToLeEU95rkG7mRiWgSX6Mnz0HUk=;
        b=H+Nveg/mN09Lol3Pj5k/TN2le7XBMJrVS9lbYMnNLnVf7GBxofVa3Xw9d3DVFQfVhG
         9tkWET348ZrYG9lTdWhZP/eUdc5tJPvvqxF7YBw2xzddToJ9V0zvlDGR0rK/Xsne8wQq
         rctCQOJjlsdZ9+q/K/Q9vpP3sYcHXzkynAkFwmGKrl8mXPCcL7ZhGc01tKnBz5FZOYOE
         lFb2Z4FhCv5inyRZlLTY60b05+7wxKV3a03Z10xrV8SV3yfa5h4bx4K42Mdap269JdQl
         iZP5T9WAqergBfAQ+6NlwsLVvfewREtVz7iJsJQpGol9kp8fQG59oBFlBGsSz79IYneA
         knCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6cp5m3ImBZ7KTnMToLeEU95rkG7mRiWgSX6Mnz0HUk=;
        b=si0iFLTB0rAgFLM6H71QuFiFQipxuuqhxsSltwg02UAGOlvJgeTehLTEHtU3W3gdNU
         GvxVG7qmZhL+VzRonsJOHLBGg5bcCiBSGvkMtJdUY9qzmGSY4IKKYb6dPU6jOY0ioaHM
         ovhO0pJagx5BKxYgmka47X0ddH3OqoiSsYoBMrdQwgTgiHAp2V6piBQgt4HVXqXu6a6w
         5Zuvd01Sba5jjIT2reyVC6JNGRe67dHQC36ybVb+Orm5o0uLHpOpovxEraoH1ovdq6UV
         eGYCwPQzgFZwn+tmDdAkNJUZXCF6C7Agg6zl++/f91uRjWrQw9aLdMm+9EthyyIniGYh
         Ohbg==
X-Gm-Message-State: ANoB5pmXLomNRfdLvGNKXb9VKolsVax+nXUKl1Lg/Jf8AksW5nBS9pyY
        Qri7YfCPAP1fzWMR5k5dXlg=
X-Google-Smtp-Source: AA0mqf4a1Xsu5Xu8InLxUgzkkFe3OpJUFq99qZEQD1uWwZxOmYllCX7IOeZAVLLkjHesYiFI5WryPA==
X-Received: by 2002:a05:600c:348e:b0:3cf:6e78:e2aa with SMTP id a14-20020a05600c348e00b003cf6e78e2aamr4154643wmq.121.1668266964921;
        Sat, 12 Nov 2022 07:29:24 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b003c6f426467fsm13646045wmq.40.2022.11.12.07.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:29:24 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: sl28cpld: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:29:28 +0000
Message-Id: <20221112152928.42204-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove use of the deprecated mask_invert flag. Inverted mask
registers (where a '1' bit enables an IRQ) can be described more
directly as an unmask register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/gpio/gpio-sl28cpld.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
index 52404736ac86..2195f88c2048 100644
--- a/drivers/gpio/gpio-sl28cpld.c
+++ b/drivers/gpio/gpio-sl28cpld.c
@@ -70,8 +70,7 @@ static int sl28cpld_gpio_irq_init(struct platform_device *pdev,
 	irq_chip->num_irqs = ARRAY_SIZE(sl28cpld_gpio_irqs);
 	irq_chip->num_regs = 1;
 	irq_chip->status_base = base + GPIO_REG_IP;
-	irq_chip->mask_base = base + GPIO_REG_IE;
-	irq_chip->mask_invert = true;
+	irq_chip->unmask_base = base + GPIO_REG_IE;
 	irq_chip->ack_base = base + GPIO_REG_IP;
 
 	ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
-- 
2.38.1

