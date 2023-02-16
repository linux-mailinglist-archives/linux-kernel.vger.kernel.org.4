Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B6B699005
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBPJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjBPJhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:37:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5979D4DBDC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id c20so2024331lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXmJn+K3Vz/15Sqwyaox25jzy6Vyc7x15lGcSP8/NaY=;
        b=x9R24WT7DLFj5wDQ2WTnH9aFyJaEV4l8z7iYVqag/tu3hR12ACANpeBqKenMIbmHnc
         zVKOTOiASbVkg+B+5i/dGYpFVb6ERiZfwahT6KLQfutXUWoqaM25sfOf/q8thr6ObVNX
         W46iyg8o7oZbHUcj8ZKOSLeoLOQ5Z/P3t+WsacKTjSDbNPE1pUTcV/sQslkY9MQujRAn
         24FSu0r9zjALfDvTvMY846sQkkRprAOHI2irYCGLxeBtQ+JoCD6KELQ+FfvUN16f8mpV
         ZIDh0uJG3UjKAw8CYbxJDIsQsKWN6KnfiDTKPAI8pBGE4FGtt3QZuhK3cdFAIFNgfxxI
         7y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXmJn+K3Vz/15Sqwyaox25jzy6Vyc7x15lGcSP8/NaY=;
        b=esVJAmTHmdp1deI+WqnVls275Vi7WJwuCJxUAZN6H0s9BHXoQoEYYwLqpPfrDEYE4f
         5oxie6UG1GNG/BgTDchMiQYr+YCo8eBPXuKeToRo6bf0sGL9+Q2y8LnqbuTXKmYSRLFb
         v8jb65Z5gRtKdDHGoJTqyZhH28FAygk17WEdckyuhYo8UsJm//kclB1ljRW/I15P+MlZ
         zwfKIJNpshG4d38tMCzq3vefS+uAvMFPzFfGed2ph6YBUnM7FyhT//Ra08DfUB+qdKlK
         3Z6elK6gDZXCBCk7fS506On7HraT6a9ARexW8ZiEKKAt2wzWzMNln6r7nees3Su3ZBEE
         POCQ==
X-Gm-Message-State: AO0yUKWj0SCXp/qW2UrnEI5qTtNVlDQV1O5esuEwFuARjIFdpoKG/31w
        pzDW+E1HKYAc4GFay1vkJtiwfg==
X-Google-Smtp-Source: AK7set/Qg+iCjoZIonXJorB86cSD9ymfHRNOJfe6JHtzB9TKu4paeS/zJBXOWbcs8vGzLo48G7yruw==
X-Received: by 2002:a05:6512:501:b0:4b5:83b8:2c49 with SMTP id o1-20020a056512050100b004b583b82c49mr1398648lfb.1.1676540233907;
        Thu, 16 Feb 2023 01:37:13 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.219])
        by smtp.gmail.com with ESMTPSA id r3-20020a19ac43000000b004d8758a452asm229069lfc.288.2023.02.16.01.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 01:37:13 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Feb 2023 10:37:09 +0100
Subject: [PATCH 08/17] gpio: hisi: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-immutable-chips-v1-8-51a8f224a5d0@linaro.org>
References: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
In-Reply-To: <20230215-immutable-chips-v1-0-51a8f224a5d0@linaro.org>
To:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

The IRQ chip was unnamed which seems unwise, so we just
assign the name "HISI-GPIO".

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-hisi.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-hisi.c b/drivers/gpio/gpio-hisi.c
index 55bd69043bf4..29a03de37fd8 100644
--- a/drivers/gpio/gpio-hisi.c
+++ b/drivers/gpio/gpio-hisi.c
@@ -37,7 +37,6 @@ struct hisi_gpio {
 	struct device		*dev;
 	void __iomem		*reg_base;
 	unsigned int		line_num;
-	struct irq_chip		irq_chip;
 	int			irq;
 };
 
@@ -100,12 +99,14 @@ static void hisi_gpio_irq_set_mask(struct irq_data *d)
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
 
 	hisi_gpio_write_reg(chip, HISI_GPIO_INTMASK_SET_WX, BIT(irqd_to_hwirq(d)));
+	gpiochip_disable_irq(chip, irqd_to_hwirq(d));
 }
 
 static void hisi_gpio_irq_clr_mask(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
 
+	gpiochip_enable_irq(chip, irqd_to_hwirq(d));
 	hisi_gpio_write_reg(chip, HISI_GPIO_INTMASK_CLR_WX, BIT(irqd_to_hwirq(d)));
 }
 
@@ -191,20 +192,24 @@ static void hisi_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irq_c, desc);
 }
 
+static const struct irq_chip hisi_gpio_irq_chip = {
+	.name = "HISI-GPIO",
+	.irq_ack = hisi_gpio_set_ack,
+	.irq_mask = hisi_gpio_irq_set_mask,
+	.irq_unmask = hisi_gpio_irq_clr_mask,
+	.irq_set_type = hisi_gpio_irq_set_type,
+	.irq_enable = hisi_gpio_irq_enable,
+	.irq_disable = hisi_gpio_irq_disable,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static void hisi_gpio_init_irq(struct hisi_gpio *hisi_gpio)
 {
 	struct gpio_chip *chip = &hisi_gpio->chip;
 	struct gpio_irq_chip *girq_chip = &chip->irq;
 
-	/* Set hooks for irq_chip */
-	hisi_gpio->irq_chip.irq_ack = hisi_gpio_set_ack;
-	hisi_gpio->irq_chip.irq_mask = hisi_gpio_irq_set_mask;
-	hisi_gpio->irq_chip.irq_unmask = hisi_gpio_irq_clr_mask;
-	hisi_gpio->irq_chip.irq_set_type = hisi_gpio_irq_set_type;
-	hisi_gpio->irq_chip.irq_enable = hisi_gpio_irq_enable;
-	hisi_gpio->irq_chip.irq_disable = hisi_gpio_irq_disable;
-
-	girq_chip->chip = &hisi_gpio->irq_chip;
+	gpio_irq_chip_set_chip(girq_chip, &hisi_gpio_irq_chip);
 	girq_chip->default_type = IRQ_TYPE_NONE;
 	girq_chip->num_parents = 1;
 	girq_chip->parents = &hisi_gpio->irq;

-- 
2.34.1

