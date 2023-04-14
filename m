Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E26E2546
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjDNOH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjDNOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:07:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21A2B763
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:06:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o1so23557601lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681481188; x=1684073188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTAL+X79fFSg7Vdy2Php9Hw3wS0uqtZxqCJF6Zi/jeI=;
        b=YGQPsnba86DaMk0Jax3OQOs/A6b3ow03oOFnX+XJJDcL2QNnkKNIcWGwcnrJ7sn45H
         f3444NABSrf4kpRKA1kK95qZ2g63dJ8gsSsdVEmOQp9FkFTwqa1Gn3HNZ4HUndI/ilFs
         OhP89nob15jC8f9ro3WGj2ryAwI4n+KkfOfRfSVSjCDxRWrPpltvIyMeXuBHq0APUy4I
         /vKKpt//M0l65r2WFQupuwfBQCrEc4F08tgMhTrz8ylsAJ/5TiDhI47VXsKhjvvXB9ZU
         V1JaPb1PHPcFUtaZiZiPc3Jzvsp/Wq7AiAReEpKMY4mX/mJzIjLz5876C2MO3MCq+Fez
         hfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481188; x=1684073188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTAL+X79fFSg7Vdy2Php9Hw3wS0uqtZxqCJF6Zi/jeI=;
        b=POUIUToBo1dq0IS5kcW7FyirgEHOMoTA5tw7kNvMZZQrcAf3OTqNoWJUl2s1rHFfio
         MFpoEWRZW5KQfb3MEn9z3HqbiZ9b2t5UqNW6phHGU0W3pZzdEuiSYrYv+vVbAOraz6r6
         sc36FbYRR1FaTTV+kbYvKA1IsPF0DCvwv1EPVKshysf3eK708Prh1shNsGKsLJ5onE8D
         AwLAvEd9epo+ErqiCAGGNnGOrxfLo/UpizM8n6/lykFZ+x/gm4c7vI/7WkJYI6ISGR9H
         DONEOnnzevYZCp4BOAJ05n2qyrAaJfEvWkFsO82Dax1I5Plg5TvaN8lUirLYfM/gwmRr
         d+KA==
X-Gm-Message-State: AAQBX9co4NWe6uTGQ7cReRetivmVu9SGBiXQfkjb2uv0F0U2fqXyUyFS
        G1qOonlx8Aoi6H26JfFs3xfzhA==
X-Google-Smtp-Source: AKy350YW1tq7RlVAbMysRMGGwpO123vxwnoXAyGTOLxIgY81ErunoKL5Dlr4nWwny/5PkWJnupMGuQ==
X-Received: by 2002:a05:6512:b83:b0:4dc:8049:6f36 with SMTP id b3-20020a0565120b8300b004dc80496f36mr2567531lfv.1.1681481188014;
        Fri, 14 Apr 2023 07:06:28 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id b10-20020ac25e8a000000b004d856fe5121sm808794lfq.194.2023.04.14.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:06:27 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Apr 2023 16:06:22 +0200
Subject: [PATCH 6/6] pinctrl: qcom ssbi-gpio: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-immutable-irqchips-2-v1-6-6b59a5186b00@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index e973001e5c88..dec1ffc49ffd 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -652,12 +652,30 @@ static int pm8xxx_pin_populate(struct pm8xxx_gpio *pctrl,
 	return 0;
 }
 
-static struct irq_chip pm8xxx_irq_chip = {
+static void pm8xxx_irq_disable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
+}
+
+static void pm8xxx_irq_enable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
+}
+
+static const struct irq_chip pm8xxx_irq_chip = {
 	.name = "ssbi-gpio",
 	.irq_mask_ack = irq_chip_mask_ack_parent,
 	.irq_unmask = irq_chip_unmask_parent,
+	.irq_disable = pm8xxx_irq_disable,
+	.irq_enable = pm8xxx_irq_enable,
 	.irq_set_type = irq_chip_set_type_parent,
-	.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
+	.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE |
+		IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static int pm8xxx_domain_translate(struct irq_domain *domain,
@@ -788,7 +806,7 @@ static int pm8xxx_gpio_probe(struct platform_device *pdev)
 		return -ENXIO;
 
 	girq = &pctrl->chip.irq;
-	girq->chip = &pm8xxx_irq_chip;
+	gpio_irq_chip_set_chip(girq, &pm8xxx_irq_chip);
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_level_irq;
 	girq->fwnode = dev_fwnode(pctrl->dev);

-- 
2.34.1

