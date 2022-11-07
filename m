Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8227B61FC3B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiKGRze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiKGRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:54:14 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2A925E80;
        Mon,  7 Nov 2022 09:53:20 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r132-20020a1c448a000000b003cf4d389c41so513439wma.3;
        Mon, 07 Nov 2022 09:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zawac0oZnH0s6N9BmcF7Es7GdlbM3PMpMwX1yWYjaTo=;
        b=aeQJnX0X9lWc+v6rMuS4tfwYDkYFXsu44LTAppZXyQBnkadQsryxirALgvlogjSP5B
         QjgvOgPlCpmxYpzR5Q0mTb4CYhiEwn0nSmk8Q/O+7oxMEcxBBskM/F68NaLVCmhlunIn
         W1axb8Cj0SCHjsq9JIpP4CZ/zWlkYlCWgNFlkumNOrFUJTc0UcObXjJF3K1T+WsxGiML
         F6/QJwu25G/WEaY9hRZSZszc2zGsDC5TLKwqtXmekLksiAIhkwp6xE34ve58aIco6hYN
         UQ0a6gGqJe+ajnVNjLBAHn5hSqV18g6bwhKy/fLLPYx28fqGEsIevJgsvP8eq16Fe4Ho
         +ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zawac0oZnH0s6N9BmcF7Es7GdlbM3PMpMwX1yWYjaTo=;
        b=T/Dw69AUiL33EDrBmqFf3OY8a3vwRwzdQRWHx744BJSQ89yhjQjT3Dq/0rAxCBTLvC
         6SnZcQPdYp/KE53qMH2X2hLOb23zM5qS6L610BJELCx8ZItvXC6aPv0P7hNGVqUaMv2R
         TnmCqGlNiU1wcficIyEhuCWde9Rd3UnYGmv3HtWHderxPmkmTgVRPIq+3VeLoYQSOBOH
         wD478voIb9eeh5GEnnXojist8H/F4P4T5ufB8ZApXFlnLdUkuCBlwJ8URRbF8vaLShkL
         HqFn6thY1MwP3B/CLgbsqmlkB/br4y2fUp0DkW1Dvfsr75azmrh+7D+rhG71v4jenXmx
         VTqg==
X-Gm-Message-State: ANoB5pkmeWWJFmdmkYKsEX2GUiu4o2rO2gjVCRXHBtPKFQjBUxan1s7z
        7JjuXi9NOKm2t39JiXK+x58=
X-Google-Smtp-Source: AA0mqf7REocKiPJ0asC3HlX7IZ4u3H9qtKtXmlXF2DOaNOPJ9TEbdNfcmhQLbQNzh4obBQBvuE2iJw==
X-Received: by 2002:a05:600c:5250:b0:3cf:a56a:6c9e with SMTP id fc16-20020a05600c525000b003cfa56a6c9emr6626958wmb.50.1667843598760;
        Mon, 07 Nov 2022 09:53:18 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:9c45:7ed3:c12e:e25b])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d4a44000000b002365254ea42sm8072454wrs.1.2022.11.07.09.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:53:18 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 2/5] pinctrl: renesas: rzg2l: Fix configuring the GPIO pins as interrupts
Date:   Mon,  7 Nov 2022 17:53:02 +0000
Message-Id: <20221107175305.63975-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index a43824fd9505..dcc495baa678 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -127,6 +127,7 @@ struct rzg2l_dedicated_configs {
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u32 *port_pin_configs;
+	unsigned int n_port_pin_configs;
 	struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
@@ -1122,7 +1123,7 @@ static struct {
 	}
 };
 
-static int rzg2l_gpio_get_gpioint(unsigned int virq)
+static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_data *data)
 {
 	unsigned int gpioint;
 	unsigned int i;
@@ -1131,13 +1132,13 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq)
 	port = virq / 8;
 	bit = virq % 8;
 
-	if (port >= ARRAY_SIZE(rzg2l_gpio_configs) ||
-	    bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
+	if (port >= data->n_port_pin_configs ||
+	    bit >= RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[port]))
 		return -EINVAL;
 
 	gpioint = bit;
 	for (i = 0; i < port; i++)
-		gpioint += RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]);
+		gpioint += RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[i]);
 
 	return gpioint;
 }
@@ -1237,7 +1238,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 	unsigned long flags;
 	int gpioint, irq;
 
-	gpioint = rzg2l_gpio_get_gpioint(child);
+	gpioint = rzg2l_gpio_get_gpioint(child, pctrl->data);
 	if (gpioint < 0)
 		return gpioint;
 
@@ -1311,8 +1312,8 @@ static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
 		port = offset / 8;
 		bit = offset % 8;
 
-		if (port >= ARRAY_SIZE(rzg2l_gpio_configs) ||
-		    bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
+		if (port >= pctrl->data->n_port_pin_configs ||
+		    bit >= RZG2L_GPIO_PORT_GET_PINCNT(pctrl->data->port_pin_configs[port]))
 			clear_bit(offset, valid_mask);
 	}
 }
@@ -1517,6 +1518,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
+	.n_port_pin_configs = ARRAY_SIZE(r9a07g043_gpio_configs),
 	.dedicated_pins = rzg2l_dedicated_pins.common,
 	.n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
@@ -1525,6 +1527,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = rzg2l_gpio_configs,
+	.n_port_pin_configs = ARRAY_SIZE(rzg2l_gpio_configs),
 	.dedicated_pins = rzg2l_dedicated_pins.common,
 	.n_port_pins = ARRAY_SIZE(rzg2l_gpio_names),
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
-- 
2.25.1

