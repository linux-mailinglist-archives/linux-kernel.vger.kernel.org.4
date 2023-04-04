Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC856D5C34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjDDJng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjDDJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:43:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B31B212D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:43:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j11so41569986lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680601396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZI0FMzsrAMmwpsYMT9sQehFdyel4tmSQAHLWGYELRs8=;
        b=WULO+ov5ZvN0aMdbSFLuRHF9Hg/nArG1Z86PpBV0FmeBEfJHhwhWpuirvHLQEj8yX1
         s6e2TO5fbOL42dXzptwaOszI/zOBZmLNSA+QEekdE2WUaTmO8cFjGrv4Lj0ry4sBrTaj
         TC0yQsgT2ENf3XxEPrPOZnXWAbkyzVhTcICME/O6u0W2JxdrY+BIXdqibYNnQpsAoKBV
         ocjTbmDv0t4TAa/xwGJKuJuP0/Whyp4sRVtOLTZSuQH+vpdkQErWF5wGTP6cwhXjn0CP
         3l5Gdryn9atZ9gPxMUIYgD/kql2Jdu76PrZmSX360TsFPr0iLD45f6PLc7wfvquKEquX
         5AxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI0FMzsrAMmwpsYMT9sQehFdyel4tmSQAHLWGYELRs8=;
        b=RQkY2yCDRmK6G4EIo8Kcy2XZeGWb8jpWgmiF2DOSDOb1U0LPRdT5R3MrV4dM1U8k9S
         luRXX7eu83D0EkKTj5h33QEDwYiMakOXHHUXht7WLFLRIOfVt1RZ38HmKvvInIxhU5+z
         AI2xTMsp6X8rm54VfG1nABQ8lA7guH2D4beBlUll3xLFn7vi/S+OnmRanQhtt+NggukD
         rlOxOj9GYgbcn8QGKslkkHUSllD0nkY2Hj+MAr1VHyAVsTzJ7JJt7ByqbK0Ir86dEmlR
         tF9orNvzwfFiKDS/6+bzDh+DLdDwZbG6AbBJDb8EMY8TZ8mvP/clGtrN2YFfYytjReKc
         X1jQ==
X-Gm-Message-State: AAQBX9eHAmJqF+PoH6o4/zpmP36oEPQno73XK1k4RGTcWGmSma4PLnPK
        FGq4tfXbf5gIboSUO5UaYiVyBA==
X-Google-Smtp-Source: AKy350Z2HFJtQJta6/+neaHmwGqoNe/plLSFJpnmh0+koaTH205JmdH3/LyK+YRNYhtTGY9axiebiA==
X-Received: by 2002:a05:6512:32ab:b0:4db:971:82cd with SMTP id q11-20020a05651232ab00b004db097182cdmr5913134lfe.17.1680601395927;
        Tue, 04 Apr 2023 02:43:15 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l25-20020a19c219000000b004eb258f73a9sm2218443lfc.163.2023.04.04.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 02:43:15 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 04 Apr 2023 11:43:08 +0200
Subject: [PATCH 6/9] pinctrl: mcp23s08: Convert to immutable irq_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-immutable-irqchips-v1-6-503788a7f6e6@linaro.org>
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

I switched to using irqd_to_hwirq() consistently while we
are at it.

Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 36 ++++++++++++++++++++++++++----------
 drivers/pinctrl/pinctrl-mcp23s08.h |  1 -
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 5f356edfd0fd..7b7764c04327 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <asm/byteorder.h>
 #include <linux/interrupt.h>
@@ -436,17 +437,19 @@ static void mcp23s08_irq_mask(struct irq_data *data)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
 	struct mcp23s08 *mcp = gpiochip_get_data(gc);
-	unsigned int pos = data->hwirq;
+	unsigned int pos = irqd_to_hwirq(data);
 
 	mcp_set_bit(mcp, MCP_GPINTEN, pos, false);
+	gpiochip_disable_irq(gc, pos);
 }
 
 static void mcp23s08_irq_unmask(struct irq_data *data)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
 	struct mcp23s08 *mcp = gpiochip_get_data(gc);
-	unsigned int pos = data->hwirq;
+	unsigned int pos = irqd_to_hwirq(data);
 
+	gpiochip_enable_irq(gc, pos);
 	mcp_set_bit(mcp, MCP_GPINTEN, pos, true);
 }
 
@@ -454,7 +457,7 @@ static int mcp23s08_irq_set_type(struct irq_data *data, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
 	struct mcp23s08 *mcp = gpiochip_get_data(gc);
-	unsigned int pos = data->hwirq;
+	unsigned int pos = irqd_to_hwirq(data);
 
 	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH) {
 		mcp_set_bit(mcp, MCP_INTCON, pos, false);
@@ -523,6 +526,25 @@ static int mcp23s08_irq_setup(struct mcp23s08 *mcp)
 	return 0;
 }
 
+static void mcp23s08_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct mcp23s08 *mcp = gpiochip_get_data(gc);
+
+	seq_printf(p, dev_name(mcp->dev));
+}
+
+static const struct irq_chip mcp23s08_irq_chip = {
+	.irq_mask = mcp23s08_irq_mask,
+	.irq_unmask = mcp23s08_irq_unmask,
+	.irq_set_type = mcp23s08_irq_set_type,
+	.irq_bus_lock = mcp23s08_irq_bus_lock,
+	.irq_bus_sync_unlock = mcp23s08_irq_bus_unlock,
+	.irq_print_chip = mcp23s08_irq_print_chip,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 /*----------------------------------------------------------------------*/
 
 int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
@@ -538,12 +560,6 @@ int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 	mcp->addr = addr;
 
 	mcp->irq_active_high = false;
-	mcp->irq_chip.name = dev_name(dev);
-	mcp->irq_chip.irq_mask = mcp23s08_irq_mask;
-	mcp->irq_chip.irq_unmask = mcp23s08_irq_unmask;
-	mcp->irq_chip.irq_set_type = mcp23s08_irq_set_type;
-	mcp->irq_chip.irq_bus_lock = mcp23s08_irq_bus_lock;
-	mcp->irq_chip.irq_bus_sync_unlock = mcp23s08_irq_bus_unlock;
 
 	mcp->chip.direction_input = mcp23s08_direction_input;
 	mcp->chip.get = mcp23s08_get;
@@ -603,7 +619,7 @@ int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 	if (mcp->irq && mcp->irq_controller) {
 		struct gpio_irq_chip *girq = &mcp->chip.irq;
 
-		girq->chip = &mcp->irq_chip;
+		gpio_irq_chip_set_chip(girq, &mcp23s08_irq_chip);
 		/* This will let us handle the parent IRQ in the driver */
 		girq->parent_handler = NULL;
 		girq->num_parents = 0;
diff --git a/drivers/pinctrl/pinctrl-mcp23s08.h b/drivers/pinctrl/pinctrl-mcp23s08.h
index b8d15939e0c2..b15516af7783 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.h
+++ b/drivers/pinctrl/pinctrl-mcp23s08.h
@@ -36,7 +36,6 @@ struct mcp23s08 {
 	struct mutex		lock;
 
 	struct gpio_chip	chip;
-	struct irq_chip		irq_chip;
 
 	struct regmap		*regmap;
 	struct device		*dev;

-- 
2.34.1

