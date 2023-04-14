Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730556E2544
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDNOHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjDNOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:07:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3413DB46A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:06:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b40so3061713lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681481187; x=1684073187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwKMQO59szubKjzAdKHEDn1K/Q985iFYjG/Q5Lazatw=;
        b=mm0rr2AisyJEnTpKc9Hr0PYo572bFIgvK8ACB4Fbl/s+SP3JafUTM5HlUzmReRlGzy
         Qz6m+HXHUuQjwLas5K1jl1Nxk4Q1hUnScpZb7TCDnMmCbEvQ6Rela6mR2MB+BNSikv14
         gRpiW5IbP9FbU8MhmRGeF/Jssf5d+xfoepDpb5vyV1Ts4mhMV1/0uaaWuciRQWpIO1xI
         aZMemNF0thY6aPcF1ER9jRoN2MD/zy5YCBPJT9AaMIhbPJ/pbs5iqQyWaSx0VxjuaJnJ
         PNszgyJimK0l6a9/Kqzmq9T4CsxK4zy8727wqsvhL/pehW93STmCcyHlLzD9VciIKlUb
         d+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481187; x=1684073187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwKMQO59szubKjzAdKHEDn1K/Q985iFYjG/Q5Lazatw=;
        b=c2my044KjaoKIXeJbu923atBjsZbmH0iRxQeA9glff1Uip/8poCITrGv62GVNgyzx5
         SX5i9UgFL6ez6F55Uj6bVXZ4xdjgl3g4Qm2aQXR+Yq+30WAWAUokCiGGetWUV08bMUCM
         g2lYuZrBMOkwQUBB5cjpyUj/RqQpnFN5sD8UC91ahDj+zYAnXQ0/1Xa6DSl6Lv4LgYAv
         WelWq3YoyS90UIVEtxd/YDeghb7yJhIOKzMnhj6dk8zt4j16gOJxWpd1MWUfcukQ/LU/
         wiLXdCclh3kJrT+oYXk197ZlaOQOi2L+Z8gooH1YtJott+MA252OSLguvNaZxIgEJoPb
         kPGA==
X-Gm-Message-State: AAQBX9f1F79nOA7y1poUT3IrxPNbMIhxsoHqS0mTcBuxkQxY8NNpHZnQ
        Yu7qrZj6PLhLiw6pBJoEDA0u8Q==
X-Google-Smtp-Source: AKy350YSax85PxfLld3Ri3/VZQe0xlhnNS5YwnHqcsrgGfse9vuxSyHLRMVGj+cCYor97ISObyJgfg==
X-Received: by 2002:a05:6512:488:b0:4e0:fe29:9313 with SMTP id v8-20020a056512048800b004e0fe299313mr2025656lfq.15.1681481187013;
        Fri, 14 Apr 2023 07:06:27 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id b10-20020ac25e8a000000b004d856fe5121sm808794lfq.194.2023.04.14.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:06:26 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Apr 2023 16:06:21 +0200
Subject: [PATCH 5/6] pinctrl: qcom ssbi-mpp: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-immutable-irqchips-2-v1-5-6b59a5186b00@linaro.org>
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
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c | 35 +++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 86f66cb8bf30..b5aed540f07e 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -126,7 +126,6 @@ struct pm8xxx_mpp {
 	struct regmap *regmap;
 	struct pinctrl_dev *pctrl;
 	struct gpio_chip chip;
-	struct irq_chip irq;
 
 	struct pinctrl_desc desc;
 	unsigned npins;
@@ -778,6 +777,32 @@ static int pm8xxx_mpp_child_to_parent_hwirq(struct gpio_chip *chip,
 	return 0;
 }
 
+static void pm8xxx_mpp_irq_disable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
+}
+
+static void pm8xxx_mpp_irq_enable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
+}
+
+static const struct irq_chip pm8xxx_mpp_irq_chip = {
+	.name = "ssbi-mpp",
+	.irq_mask_ack = irq_chip_mask_ack_parent,
+	.irq_unmask = irq_chip_unmask_parent,
+	.irq_disable = pm8xxx_mpp_irq_disable,
+	.irq_enable = pm8xxx_mpp_irq_enable,
+	.irq_set_type = irq_chip_set_type_parent,
+	.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE |
+		IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static const struct of_device_id pm8xxx_mpp_of_match[] = {
 	{ .compatible = "qcom,pm8018-mpp", .data = (void *) 6 },
 	{ .compatible = "qcom,pm8038-mpp", .data = (void *) 6 },
@@ -871,14 +896,8 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
 	if (!parent_domain)
 		return -ENXIO;
 
-	pctrl->irq.name = "ssbi-mpp";
-	pctrl->irq.irq_mask_ack = irq_chip_mask_ack_parent;
-	pctrl->irq.irq_unmask = irq_chip_unmask_parent;
-	pctrl->irq.irq_set_type = irq_chip_set_type_parent;
-	pctrl->irq.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
-
 	girq = &pctrl->chip.irq;
-	girq->chip = &pctrl->irq;
+	gpio_irq_chip_set_chip(girq, &pm8xxx_mpp_irq_chip);
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_level_irq;
 	girq->fwnode = dev_fwnode(pctrl->dev);

-- 
2.34.1

