Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341BA652A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiLUADZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiLUADF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:03:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9361EEFD;
        Tue, 20 Dec 2022 16:03:03 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a17so12270011wrt.11;
        Tue, 20 Dec 2022 16:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjd5YDPhn942L8jKBVO5rptp/aSFWfLH0S6vcuBxa1o=;
        b=MAWwVA5ZqYcEQHuO7lddEIMZ+eZa9SJUgRafWpUin47IlTQ0uODzZ1Uu3gSM7R7c7t
         8S3NsYttU4t4D/WrqPQm97OdSxK8OjlJLsDeK8D/K0maIzhWLTCxuYaqs+NoHTwypsyb
         6+DA9X/XqjbM4MLvb5nyT05mDY7oa/b//+g//bI1F4bwMW0nHMNP5I+qFP6RBEMfup73
         OddWQ6sJeBQ0uL4gdAMfJuSrJpScwIrAni2X30MnqXnw8nQ7ab3S2ZX/bqzzdJtE2jLv
         pvaNpwnwq8e39Nt1mck77ytkGOoWwI4nJYQ9TknSsRaHhOsxOBcov75CM6B/4YbVXYpY
         PXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjd5YDPhn942L8jKBVO5rptp/aSFWfLH0S6vcuBxa1o=;
        b=3iTuy7NpQ1JKU5VzSWg9gZdDpi//w56bn/6B4coUQe1X8LQpFfdcazITRrAhnhaa6m
         u0s9340W3RZ688RmG6cwvHiupJ6j2XwhBXsXsEOTQPFcbmDyQtDaG2rnqz0uc4tA32Nd
         vKgxOQjEoEsa4ckMZz4LbdbGZCKrzBUWkN7BScvwx+3b2X5qF2aJe/ZIOoUADpbTBTgi
         BPaAMUoBkThhd5J+YRVcaaBfpH7uwP3Q23CbtJRMjvQntc5HS3SCif0Z7SLOpp59C22T
         lmCr3D5XUea4h6N4yZRtPpDnqWOGx9yirU6lPv0fqrhsbqLQAaP/tp4spq+l28oyBcXX
         2rgw==
X-Gm-Message-State: AFqh2kpeS5sWvzMD9ollWWhrKbxRSBOkMrvKeQtwers7Qvq0C5OHo96i
        VgSjM2JYCTWW9unGsRJ6yMo=
X-Google-Smtp-Source: AMrXdXuiLD+CQEuTZAWD6gq9auAmNhVIMsylO30/cwcrDlnzgKed5ffnq+Jzvn0QZoXkOzQQeYduSA==
X-Received: by 2002:adf:e281:0:b0:26a:cede:b651 with SMTP id v1-20020adfe281000000b0026acedeb651mr122759wri.36.1671580982064;
        Tue, 20 Dec 2022 16:03:02 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1595:a48c:95a8:15e0])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002362f6fcaf5sm13740150wrt.48.2022.12.20.16.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 16:03:01 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 5/9] pinctrl: renesas: rzg2l: Fix configuring the GPIO pins as interrupts
Date:   Wed, 21 Dec 2022 00:02:38 +0000
Message-Id: <20221221000242.340202-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On the RZ/G2UL SoC we have less number of pins compared to RZ/G2L and also
the pin configs are completely different. This patch makes sure we use the
appropriate pin configs for each SoC (which is passed as part of the OF
data) while configuring the GPIO pin as interrupts instead of using
rzg2l_gpio_configs[] for all the SoCs.

Fixes: bfc69bdbaad1 ("pinctrl: renesas: rzg2l: Add RZ/G2UL support")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1 -> v2
* Fixed comments pointed by Geert for variable naming
* Added RB tag
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 4e79b2961232..03e9462f39b1 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -127,6 +127,7 @@ struct rzg2l_dedicated_configs {
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u32 *port_pin_configs;
+	unsigned int n_ports;
 	struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
@@ -1121,7 +1122,7 @@ static struct {
 	}
 };
 
-static int rzg2l_gpio_get_gpioint(unsigned int virq)
+static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_data *data)
 {
 	unsigned int gpioint;
 	unsigned int i;
@@ -1130,13 +1131,13 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq)
 	port = virq / 8;
 	bit = virq % 8;
 
-	if (port >= ARRAY_SIZE(rzg2l_gpio_configs) ||
-	    bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
+	if (port >= data->n_ports ||
+	    bit >= RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[port]))
 		return -EINVAL;
 
 	gpioint = bit;
 	for (i = 0; i < port; i++)
-		gpioint += RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]);
+		gpioint += RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[i]);
 
 	return gpioint;
 }
@@ -1236,7 +1237,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 	unsigned long flags;
 	int gpioint, irq;
 
-	gpioint = rzg2l_gpio_get_gpioint(child);
+	gpioint = rzg2l_gpio_get_gpioint(child, pctrl->data);
 	if (gpioint < 0)
 		return gpioint;
 
@@ -1310,8 +1311,8 @@ static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
 		port = offset / 8;
 		bit = offset % 8;
 
-		if (port >= ARRAY_SIZE(rzg2l_gpio_configs) ||
-		    bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
+		if (port >= pctrl->data->n_ports ||
+		    bit >= RZG2L_GPIO_PORT_GET_PINCNT(pctrl->data->port_pin_configs[port]))
 			clear_bit(offset, valid_mask);
 	}
 }
@@ -1516,6 +1517,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
+	.n_ports = ARRAY_SIZE(r9a07g043_gpio_configs),
 	.dedicated_pins = rzg2l_dedicated_pins.common,
 	.n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
@@ -1524,6 +1526,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = rzg2l_gpio_configs,
+	.n_ports = ARRAY_SIZE(rzg2l_gpio_configs),
 	.dedicated_pins = rzg2l_dedicated_pins.common,
 	.n_port_pins = ARRAY_SIZE(rzg2l_gpio_names),
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
-- 
2.25.1

