Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E456E253D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjDNOHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDNOHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:07:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686A3A5C1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:06:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i26so23879416lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681481184; x=1684073184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HANrBatD66XHrbynSUb+/d3zU2tkPBuvtN1APBMREqs=;
        b=vmS8y1HoE3osnmSlFtEzioX6TV5Um9jP0ExIdP3zFRLiSZW6+sRf5ERlXDRKWWEBx/
         fTivZmIt9xt9gE01HBFaWbuMcAq158o4uWc4udD6AFn5gRS4dwlCQhKN4o4kISiFQGXL
         LqCuczJt6lpfI1bWxF/ub8BSg+qk8PI4FoJ2z+475a+y2LiBYM9ncWzV1juQmh44WhpO
         CJQvVbz6ZORpvmZhPvl88e2t6M3tSRGKeCdbRNKvuE8n2QK32R57LvkIJxrjqGCQSAbL
         BH590BAv8/RfVSA5wo595UDxqGt/cdrTFVNmwNCR0aqfmyXl3cTpOHGluf/rR9y8pDbh
         I+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481184; x=1684073184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HANrBatD66XHrbynSUb+/d3zU2tkPBuvtN1APBMREqs=;
        b=A09IEu4EdUtaSoi2ZmP4v4yuZ4pYxKp/8oNpPhis7D3BJd7I+09k7myzhN26KV9Ju0
         +MCrnFfJGJ51XYIttqHYHDmGx6izB8KxS0ILrtH1bbmILqOxvfeqllVfBd496ZyX/Zvy
         ZLAuwBf8vSDt3AwB7oBOp7XblO4zTjqPt1d3Ra4WH4hpfbgwaansTH4UwOMM4ISd90B8
         Fmsq6ZZb49Qx74bx3zkG9a/qUXLYbY68upL7NAWIo7sk5koxrNUWL3jRQA/YpygkqQtc
         yPH9Yo6m8RX+2gvx2tgArgzTXLknEG/auXDMgVSbrhWAShPPsjyMhD0Em6AW5npnl+C2
         /7Kw==
X-Gm-Message-State: AAQBX9eN1haV30WQPX3WtHWhK/LKFMCGZ4rSJdk6TME/1iO89wF/zf+5
        MAcES8XOXfk/SKzQBkoUu8aL7A==
X-Google-Smtp-Source: AKy350ZXNx9gUpKotPMlL4TZIccFfIfntAQ6+DMyC3z1S7xiZNKxTlSI+yACE1Foc5Bc8CHs7KMgZg==
X-Received: by 2002:a19:5208:0:b0:4e8:16e8:88b with SMTP id m8-20020a195208000000b004e816e8088bmr1761984lfb.29.1681481184186;
        Fri, 14 Apr 2023 07:06:24 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id b10-20020ac25e8a000000b004d856fe5121sm808794lfq.194.2023.04.14.07.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:06:23 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Apr 2023 16:06:18 +0200
Subject: [PATCH 2/6] pinctrl: pistachio: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-immutable-irqchips-2-v1-2-6b59a5186b00@linaro.org>
References: <20230414-immutable-irqchips-2-v1-0-6b59a5186b00@linaro.org>
In-Reply-To: <20230414-immutable-irqchips-2-v1-0-6b59a5186b00@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-pistachio.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-pistachio.c b/drivers/pinctrl/pinctrl-pistachio.c
index 7ca4ecb6eb8d..53408344927a 100644
--- a/drivers/pinctrl/pinctrl-pistachio.c
+++ b/drivers/pinctrl/pinctrl-pistachio.c
@@ -17,6 +17,7 @@
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -93,10 +94,10 @@ struct pistachio_pin_group {
 struct pistachio_gpio_bank {
 	struct pistachio_pinctrl *pctl;
 	void __iomem *base;
+	int instance;
 	unsigned int pin_base;
 	unsigned int npins;
 	struct gpio_chip gpio_chip;
-	struct irq_chip irq_chip;
 };
 
 struct pistachio_pinctrl {
@@ -1228,12 +1229,14 @@ static void pistachio_gpio_irq_mask(struct irq_data *data)
 	struct pistachio_gpio_bank *bank = irqd_to_bank(data);
 
 	gpio_mask_writel(bank, GPIO_INTERRUPT_EN, data->hwirq, 0);
+	gpiochip_disable_irq(&bank->gpio_chip, irqd_to_hwirq(data));
 }
 
 static void pistachio_gpio_irq_unmask(struct irq_data *data)
 {
 	struct pistachio_gpio_bank *bank = irqd_to_bank(data);
 
+	gpiochip_enable_irq(&bank->gpio_chip, irqd_to_hwirq(data));
 	gpio_mask_writel(bank, GPIO_INTERRUPT_EN, data->hwirq, 1);
 }
 
@@ -1312,6 +1315,7 @@ static void pistachio_gpio_irq_handler(struct irq_desc *desc)
 
 #define GPIO_BANK(_bank, _pin_base, _npins)				\
 	{								\
+		.instance = (_bank),					\
 		.pin_base = _pin_base,					\
 		.npins = _npins,					\
 		.gpio_chip = {						\
@@ -1326,14 +1330,6 @@ static void pistachio_gpio_irq_handler(struct irq_desc *desc)
 			.base = _pin_base,				\
 			.ngpio = _npins,				\
 		},							\
-		.irq_chip = {						\
-			.name = "GPIO" #_bank,				\
-			.irq_startup = pistachio_gpio_irq_startup,	\
-			.irq_ack = pistachio_gpio_irq_ack,		\
-			.irq_mask = pistachio_gpio_irq_mask,		\
-			.irq_unmask = pistachio_gpio_irq_unmask,	\
-			.irq_set_type = pistachio_gpio_irq_set_type,	\
-		},							\
 	}
 
 static struct pistachio_gpio_bank pistachio_gpio_banks[] = {
@@ -1345,6 +1341,25 @@ static struct pistachio_gpio_bank pistachio_gpio_banks[] = {
 	GPIO_BANK(5, PISTACHIO_PIN_MFIO(80), 10),
 };
 
+static void pistachio_gpio_irq_print_chip(struct irq_data *data,
+					  struct seq_file *p)
+{
+	struct pistachio_gpio_bank *bank = irqd_to_bank(data);
+
+	seq_printf(p, "GPIO%d", bank->instance);
+}
+
+static const struct irq_chip pistachio_gpio_irq_chip = {
+	.irq_startup = pistachio_gpio_irq_startup,
+	.irq_ack = pistachio_gpio_irq_ack,
+	.irq_mask = pistachio_gpio_irq_mask,
+	.irq_unmask = pistachio_gpio_irq_unmask,
+	.irq_set_type = pistachio_gpio_irq_set_type,
+	.irq_print_chip = pistachio_gpio_irq_print_chip,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
 {
 	struct pistachio_gpio_bank *bank;
@@ -1394,7 +1409,7 @@ static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
 		bank->gpio_chip.fwnode = child;
 
 		girq = &bank->gpio_chip.irq;
-		girq->chip = &bank->irq_chip;
+		gpio_irq_chip_set_chip(girq, &pistachio_gpio_irq_chip);
 		girq->parent_handler = pistachio_gpio_irq_handler;
 		girq->num_parents = 1;
 		girq->parents = devm_kcalloc(pctl->dev, 1,

-- 
2.34.1

