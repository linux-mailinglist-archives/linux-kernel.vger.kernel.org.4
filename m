Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1DC65B791
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjABWSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjABWSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:18:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BCA9597;
        Mon,  2 Jan 2023 14:18:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y8so27536360wrl.13;
        Mon, 02 Jan 2023 14:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H15gyDSpUXGDZrye0xN/l+xb3zKX71oopvUZ32rfgtQ=;
        b=mFYQJWtLQZKDfkCEytqAMWEieSB655zyyJkPCBlTtjlniCU4e4/PhLrnnlSro+etMT
         b+0GTh5QF3ZNKKiZcWvweAGoYkJRp9oNwWYoBnPV5upOFrJjoS61dj6jiw7V5dgUIxaL
         6ZbLSsWR+EjiX3j+R7PEhqZmY1ao2Tv5UQTP86Zcq7iHTaCX4/YlmCkutBce4uQcl0k+
         J7FcOg1/uCPSeuUXjtbbAudIUxLighpAcfNhJdpJhT0cSwvzKAidvHeXV9Pp31lieA53
         RFmpPh4r3dFnvYpRBoNg+55npG1oC3ta0z/80A7IWyGQqfnchm43L113+xqhl2vgBjce
         Ul7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H15gyDSpUXGDZrye0xN/l+xb3zKX71oopvUZ32rfgtQ=;
        b=Tz0JVfcyHORCNNteACTn2Z+FhjN03dq6OT9PYQRBbwdHygP+vI6+Z056XSk2lTteqa
         j0wmbTPc4MICByrb14LPKK36gl1+MUsaHXqV/LcK8fa+0efQjWwjLhhEdtr4FqkcD1pG
         OQNZzpgpM9JlGRe2yPDR24sQ95Vjnzp+RnMR4e8IlxlCY05H6VNHolWnrp/PhsujKZ+Z
         eo7RZWL6mSfpC3TRj4MrNzpBDk21YkDBiipz2g3EDOwYAXSOvG2xHmxBGgOvITCU3YHp
         RGdND/1YEJ/fsHRjbYcHop/YnmKEfSVho771COsPc+Hpc0nfR9a1A/fLmRk4uzozNZmK
         eOTg==
X-Gm-Message-State: AFqh2kp0xalqVBAkWchy5/VcnX21Oi4iCrHSQT6OztP+k/sPOTWn2VKm
        8UdQEm313BR4slIRXcQwy58=
X-Google-Smtp-Source: AMrXdXstyOj31GZuLxe3FVT4gShMarTI16z2Heq/dCjoJUmYH1CqdhQ5bxsj0IuOEVb189u02VTPnw==
X-Received: by 2002:adf:e284:0:b0:29d:f817:42c1 with SMTP id v4-20020adfe284000000b0029df81742c1mr973584wri.54.1672697907832;
        Mon, 02 Jan 2023 14:18:27 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:8a7:e535:b020:566a])
        by smtp.gmail.com with ESMTPSA id n14-20020adfe34e000000b002366dd0e030sm29872463wrj.68.2023.01.02.14.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 14:18:27 -0800 (PST)
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
Subject: [PATCH v3 2/6] pinctrl: renesas: rzg2l: Fix configuring the GPIO pins as interrupts
Date:   Mon,  2 Jan 2023 22:18:11 +0000
Message-Id: <20230102221815.273719-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v2 -> v3
* No change

v1 -> v2
* Fixed comments pointed by Geert for variable naming
* Added RB tag
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 5aa3836dbc22..6f762097557a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -130,6 +130,7 @@ struct rzg2l_dedicated_configs {
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u32 *port_pin_configs;
+	unsigned int n_ports;
 	struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
@@ -1124,7 +1125,7 @@ static struct {
 	}
 };
 
-static int rzg2l_gpio_get_gpioint(unsigned int virq)
+static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_data *data)
 {
 	unsigned int gpioint;
 	unsigned int i;
@@ -1133,13 +1134,13 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq)
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
@@ -1239,7 +1240,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 	unsigned long flags;
 	int gpioint, irq;
 
-	gpioint = rzg2l_gpio_get_gpioint(child);
+	gpioint = rzg2l_gpio_get_gpioint(child, pctrl->data);
 	if (gpioint < 0)
 		return gpioint;
 
@@ -1313,8 +1314,8 @@ static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
 		port = offset / 8;
 		bit = offset % 8;
 
-		if (port >= ARRAY_SIZE(rzg2l_gpio_configs) ||
-		    bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
+		if (port >= pctrl->data->n_ports ||
+		    bit >= RZG2L_GPIO_PORT_GET_PINCNT(pctrl->data->port_pin_configs[port]))
 			clear_bit(offset, valid_mask);
 	}
 }
@@ -1519,6 +1520,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
+	.n_ports = ARRAY_SIZE(r9a07g043_gpio_configs),
 	.dedicated_pins = rzg2l_dedicated_pins.common,
 	.n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
@@ -1527,6 +1529,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = rzg2l_gpio_configs,
+	.n_ports = ARRAY_SIZE(rzg2l_gpio_configs),
 	.dedicated_pins = rzg2l_dedicated_pins.common,
 	.n_port_pins = ARRAY_SIZE(rzg2l_gpio_names),
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
-- 
2.25.1

