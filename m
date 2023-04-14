Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C1C6E2545
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjDNOHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDNOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:07:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A1B45A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:06:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x4so3629262lfr.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681481186; x=1684073186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BHCI/166BKjZ+FXcUih3BMF+v7LRQkg3jx37UcTFdA=;
        b=Rtev4/ouMtv+3Ed1LMSldMuZi7Jobjganjd2eiBngYCBR11LBhPlNuqD0oYCykYj8z
         hgK2yiOi9reFESjiXBFAuocR3eC5qVgfkbX9rIqfTmBiZPYeqB3c40dLsPTERtiWObjt
         r4lJCABTXAOdw5aQOaTx+o4jhXklmEuRxWv4urJxtFwjWNLf0v/u56mNqt2a7yR/O3dt
         8gtCdcEYkB2wsn6TtmRVIQLTZEr07XPZ89MH3XjwAPYqLEoOqQ64Q7rqOgNWCk++rrMC
         BCifHz4Kazh47gRnljH7yeWv1uAY7NsZI+hlf5gRfbLNHV1x/j7BrE+2jQuE3cs3ZTKV
         bmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681481186; x=1684073186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BHCI/166BKjZ+FXcUih3BMF+v7LRQkg3jx37UcTFdA=;
        b=lj176+BR2U0BMNQxC3W5wG2B67OmpDuAt4Dkv/s8+C4FH9rwW7D/FyQI8k3eVweBay
         4pgvy0wayOe0dPd7Y0tOj2wWDeltOMVEEzr9vXDoW+oJ6HaLZKtcRhjp1NIHozFEDmuH
         C2CMBENe1RUjanqBY61XPoZAR3mh/mDzGQB/b4It7CxYfHaMbnxLzkPOgMHBwNX9wya3
         Lwb42cOEIHzAH1kDOzOIW9m6t43+0KBVoYuC5PS1EXhp2HgDIMNhFMOYaUVx0kljEjbf
         djxG9IZBsrfzWBjc2J+yyt4iINOY9l7MzGo7K3AlT3ZYMqI/PSroVOChs5AjdHaaIepi
         0oJQ==
X-Gm-Message-State: AAQBX9cMsiNTbJSrbO9ObvJZU5qAWxrlVRrnLWA/vxFu+juCIkfGMFnA
        cuJGv9ZdxEeNZq2KP2vf/t3Q4MsKIuW8omrhwIw=
X-Google-Smtp-Source: AKy350YriwNgCGDtf5oV+RFjWvDkEL94w5t6irwr93Q8pCEGa96woZ1cRxPOwIE/JcEBXleGpR4rxQ==
X-Received: by 2002:ac2:5159:0:b0:4dd:a61c:8f71 with SMTP id q25-20020ac25159000000b004dda61c8f71mr1960530lfd.41.1681481186017;
        Fri, 14 Apr 2023 07:06:26 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id b10-20020ac25e8a000000b004d856fe5121sm808794lfq.194.2023.04.14.07.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:06:25 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Apr 2023 16:06:20 +0200
Subject: [PATCH 4/6] pinctrl: qcom spmi-mpp: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-immutable-irqchips-2-v1-4-6b59a5186b00@linaro.org>
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
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 38 ++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 644fb4a0e72a..fe0393829c20 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -143,7 +143,6 @@ struct pmic_mpp_state {
 	struct regmap	*map;
 	struct pinctrl_dev *ctrl;
 	struct gpio_chip chip;
-	struct irq_chip irq;
 };
 
 static const struct pinconf_generic_params pmic_mpp_bindings[] = {
@@ -823,6 +822,33 @@ static int pmic_mpp_child_to_parent_hwirq(struct gpio_chip *chip,
 	return 0;
 }
 
+static void pmic_mpp_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	irq_chip_mask_parent(d);
+	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
+}
+
+static void pmic_mpp_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+
+	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
+	irq_chip_unmask_parent(d);
+}
+
+static const struct irq_chip pmic_mpp_irq_chip = {
+	.name = "spmi-mpp",
+	.irq_ack = irq_chip_ack_parent,
+	.irq_mask = pmic_mpp_irq_mask,
+	.irq_unmask = pmic_mpp_irq_unmask,
+	.irq_set_type = irq_chip_set_type_parent,
+	.irq_set_wake = irq_chip_set_wake_parent,
+	.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int pmic_mpp_probe(struct platform_device *pdev)
 {
 	struct irq_domain *parent_domain;
@@ -915,16 +941,8 @@ static int pmic_mpp_probe(struct platform_device *pdev)
 	if (!parent_domain)
 		return -ENXIO;
 
-	state->irq.name = "spmi-mpp",
-	state->irq.irq_ack = irq_chip_ack_parent,
-	state->irq.irq_mask = irq_chip_mask_parent,
-	state->irq.irq_unmask = irq_chip_unmask_parent,
-	state->irq.irq_set_type = irq_chip_set_type_parent,
-	state->irq.irq_set_wake = irq_chip_set_wake_parent,
-	state->irq.flags = IRQCHIP_MASK_ON_SUSPEND,
-
 	girq = &state->chip.irq;
-	girq->chip = &state->irq;
+	gpio_irq_chip_set_chip(girq, &pmic_mpp_irq_chip);
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_level_irq;
 	girq->fwnode = dev_fwnode(state->dev);

-- 
2.34.1

