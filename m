Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CEA6D5C39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjDDJnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjDDJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:43:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E3A2D6D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:43:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x17so41651347lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680601398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbp5jveZuzO4r+Wb5Hve1cqOR9sHInUuZ3dFCFmIV6M=;
        b=soPMTVlcwLFSs/PtZ3xuloR1YprIJgq5gnITeQFsZZ0gFh8y81eUPT66DmPN1Ioph6
         ZwBOqwfx8CdK8ca/r3w2gNgIfi7tQzoVbuAxkFg+uo2Nc+DhRNA0cXXo7zQ52ILg8+/E
         aW2LqJCckiXThRcvxfrV7Tz6wakK5dDXqbUs8y/zAtswTW/RqkLtPIYxRnB9UB/pn/6+
         KHGGIZL0443cRzjzYCB2w4rkdnWVZbBLVpmf75qQRKZKjj4X1sj4F38KWomG9kk6HhDs
         eJdX8+4RaBVDgo4D21ZXyn84AYqQoCxu+fksVURS7Up9i008GG19+MEL9NjwDsVc8me3
         clVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbp5jveZuzO4r+Wb5Hve1cqOR9sHInUuZ3dFCFmIV6M=;
        b=EhhfWjQ1L3Ya5LWgfHKYXMhlXodqKtdh1WviL5u0EDwM2QK2Xo76JhEJsRrdLyHV9S
         qx7Xa50SXXh+YBojkR94DYbbTz8HUq/0bFCMyN70frVrvYXHGTuGhfWttOBRQ741Nuik
         5o3SmiRlVRwYBal2CjKe89FNMPmuB45AI6eO762j47+DAP6SPbAcDbmiG6zaGXYOHApc
         orHF2ewOyX42bn3KhVSQe6vDyE4HtmiM6iucEsVpVcc4L5aVtAnsdi5jYK4ubuThXv8U
         uLBF1hbI8DY61IEiXP9XcaZ9h6BivsWFH8M6pX5H5L/YSLvH5bUqdjvaX4P4M4oKYFrm
         8Rbg==
X-Gm-Message-State: AAQBX9eKCKQ9yVRTB+VVc7YL+LSfrvmNNIQ9XqFeZ23Sn2R/Zdm0Ziur
        Gvd+BS1B71ael+wut47JJgxKUQ==
X-Google-Smtp-Source: AKy350aaSf2WBwWmJ44plhwCi9IO+IsKnfCj7W2KXi50QhxuaoXCfqADvAQkBEz1VIBbYXmZlXoj7Q==
X-Received: by 2002:ac2:424d:0:b0:4d8:71dd:5c5e with SMTP id m13-20020ac2424d000000b004d871dd5c5emr409630lfl.37.1680601398122;
        Tue, 04 Apr 2023 02:43:18 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l25-20020a19c219000000b004eb258f73a9sm2218443lfc.163.2023.04.04.02.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 02:43:17 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 04 Apr 2023 11:43:10 +0200
Subject: [PATCH 8/9] pinctrl: stmfx: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-immutable-irqchips-v1-8-503788a7f6e6@linaro.org>
References: <20230403-immutable-irqchips-v1-0-503788a7f6e6@linaro.org>
In-Reply-To: <20230403-immutable-irqchips-v1-0-503788a7f6e6@linaro.org>
To:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to immutable irq-chip with a bit of
intuition.

This driver rolls it's own resource handling and does not
use GPIOCHIP_IRQ_RESOURCE_HELPERS.

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-stmfx.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index 1181c4b506b1..eba7d8d9c753 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -85,7 +85,6 @@ struct stmfx_pinctrl {
 	struct pinctrl_dev *pctl_dev;
 	struct pinctrl_desc pctl_desc;
 	struct gpio_chip gpio_chip;
-	struct irq_chip irq_chip;
 	struct mutex lock; /* IRQ bus lock */
 	unsigned long gpio_valid_mask;
 	/* Cache of IRQ_GPI_* registers for bus_lock */
@@ -427,6 +426,7 @@ static void stmfx_pinctrl_irq_mask(struct irq_data *data)
 	u32 mask = get_mask(data->hwirq);
 
 	pctl->irq_gpi_src[reg] &= ~mask;
+	gpiochip_disable_irq(gpio_chip, irqd_to_hwirq(data));
 }
 
 static void stmfx_pinctrl_irq_unmask(struct irq_data *data)
@@ -436,6 +436,7 @@ static void stmfx_pinctrl_irq_unmask(struct irq_data *data)
 	u32 reg = get_reg(data->hwirq);
 	u32 mask = get_mask(data->hwirq);
 
+	gpiochip_enable_irq(gpio_chip, irqd_to_hwirq(data));
 	pctl->irq_gpi_src[reg] |= mask;
 }
 
@@ -592,6 +593,26 @@ static irqreturn_t stmfx_pinctrl_irq_thread_fn(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void stmfx_pinctrl_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(d);
+	struct stmfx_pinctrl *pctl = gpiochip_get_data(gpio_chip);
+
+	seq_printf(p, dev_name(pctl->dev));
+}
+
+static const struct irq_chip stmfx_pinctrl_irq_chip = {
+	.irq_mask = stmfx_pinctrl_irq_mask,
+	.irq_unmask = stmfx_pinctrl_irq_unmask,
+	.irq_set_type = stmfx_pinctrl_irq_set_type,
+	.irq_bus_lock = stmfx_pinctrl_irq_bus_lock,
+	.irq_bus_sync_unlock = stmfx_pinctrl_irq_bus_sync_unlock,
+	.irq_request_resources = stmfx_gpio_irq_request_resources,
+	.irq_release_resources = stmfx_gpio_irq_release_resources,
+	.irq_print_chip = stmfx_pinctrl_irq_print_chip,
+	.flags = IRQCHIP_IMMUTABLE,
+};
+
 static int stmfx_pinctrl_gpio_function_enable(struct stmfx_pinctrl *pctl)
 {
 	struct pinctrl_gpio_range *gpio_range;
@@ -678,17 +699,8 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
 	pctl->gpio_chip.ngpio = pctl->pctl_desc.npins;
 	pctl->gpio_chip.can_sleep = true;
 
-	pctl->irq_chip.name = dev_name(pctl->dev);
-	pctl->irq_chip.irq_mask = stmfx_pinctrl_irq_mask;
-	pctl->irq_chip.irq_unmask = stmfx_pinctrl_irq_unmask;
-	pctl->irq_chip.irq_set_type = stmfx_pinctrl_irq_set_type;
-	pctl->irq_chip.irq_bus_lock = stmfx_pinctrl_irq_bus_lock;
-	pctl->irq_chip.irq_bus_sync_unlock = stmfx_pinctrl_irq_bus_sync_unlock;
-	pctl->irq_chip.irq_request_resources = stmfx_gpio_irq_request_resources;
-	pctl->irq_chip.irq_release_resources = stmfx_gpio_irq_release_resources;
-
 	girq = &pctl->gpio_chip.irq;
-	girq->chip = &pctl->irq_chip;
+	gpio_irq_chip_set_chip(girq, &stmfx_pinctrl_irq_chip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
@@ -710,7 +722,7 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(pctl->dev, irq, NULL,
 					stmfx_pinctrl_irq_thread_fn,
 					IRQF_ONESHOT,
-					pctl->irq_chip.name, pctl);
+					dev_name(pctl->dev), pctl);
 	if (ret) {
 		dev_err(pctl->dev, "cannot request irq%d\n", irq);
 		return ret;

-- 
2.34.1

