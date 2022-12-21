Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B385C652A39
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiLUADU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiLUADC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:03:02 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F8C1EEF0;
        Tue, 20 Dec 2022 16:03:01 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id co23so13445167wrb.4;
        Tue, 20 Dec 2022 16:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCfRvbbOD2D27Yei+Ee5t2Ldffe1NcizZHQtkKVsvFA=;
        b=Z3QXuzSAH+aXUB4psYxh2X7MVJ8ucTq0yUEvm+70ttsTLOwSTR33wPfhZbHg7VPZf4
         pyzVXUhramQTJU/XQVsMy6t3Up65ccrKDiBuIO8jP5WqVkL5q6TiVUNnWFktuLXVVQvS
         qEPosa3PxAX/DuuMHV6Qd4944WILphlqOlxcNMlG6ZKNzfoB2M4g26l67ndJso3EQOcD
         lGq53WgcxYjnYArej4gn0rVxfsURKA7QNODVDCdiRu7bPMKQfgEFFLJT81bPRSW81sES
         TSfBDdJKzMAu4wiry7o6FiFOTaVdZ9ORb2khquAuJNd5tgAbz1N9QW/HYxUz/nNFf9tP
         aMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCfRvbbOD2D27Yei+Ee5t2Ldffe1NcizZHQtkKVsvFA=;
        b=gc2V8T+7iDndkdnybFHjctAK2gw3JbmcwE1j1ipHK8letqkO4ecdcNhu/gLOwEk3Yo
         2KLw9EzMvk/AgHhgKPmR7a6Do6jMn/riUy6bBK8+Rd3SEvUVprq3fbXdOlNhEuKp2gyN
         N8VXZ5RL94ie0fz9aq4m5OgW6xqweQNxszcThe+7rJvD2iGApf1vT2rl8CeOjID0qYq+
         FrJUIa64WgN6BKAMQ9yygNPUmvjRHUjc36LwLHKhYTvkfRxxA4ufT01t8MiAvzO4skOX
         R6Il/gALSLbZTBgyMvzXj4HyZDwxH4ySQBMhSVY2bu39SUlT6fYi5nYg6xegFkQ1YibM
         y0hw==
X-Gm-Message-State: AFqh2kqeJyQtedG0Y59ppKcXSTYn4vueuNoVlBri2lWgYHyteqEleVQz
        GoBPDbIaREsSaufN6Vf6GyaB9qNFfTSSIcpo
X-Google-Smtp-Source: AMrXdXu0DEjfbtMPh3b8k1OlUhuL/EcStKWzHWPjgufRmXBCbeHIufjD2XkSfTDOP0j24jASYeRjGQ==
X-Received: by 2002:a5d:574a:0:b0:26a:5040:78f6 with SMTP id q10-20020a5d574a000000b0026a504078f6mr400675wrw.46.1671580980975;
        Tue, 20 Dec 2022 16:03:00 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1595:a48c:95a8:15e0])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002362f6fcaf5sm13740150wrt.48.2022.12.20.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 16:03:00 -0800 (PST)
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
Subject: [PATCH v2 4/9] irqchip: irq-renesas-rzg2l: Add support for RZ/G2UL SoC
Date:   Wed, 21 Dec 2022 00:02:37 +0000
Message-Id: <20221221000242.340202-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The IRQC block on RZ/G2UL SoC is almost identical to one found on the
RZ/G2L SoC the only difference being it can support BUS_ERR_INT for
which it has additional registers.

This patch adds a new entry for "renesas,rzg2ul-irqc" compatible string
and now that we have interrupt-names property the driver code parses the
interrupts based on names and for backward compatibility we fallback to
parse interrupts based on index.

For now we will be using rzg2l_irqc_init() as a callback for RZ/G2UL SoC
too and in future when the interrupt handler will be registered for
BUS_ERR_INT we will have to implement a new callback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1 -> v2
* New patch
---
 drivers/irqchip/irq-renesas-rzg2l.c | 80 ++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 7918fe201218..5bdf0106ef51 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -299,19 +299,86 @@ static const struct irq_domain_ops rzg2l_irqc_domain_ops = {
 	.translate = irq_domain_translate_twocell,
 };
 
-static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
-				       struct device_node *np)
+static int rzg2l_irqc_parse_interrupt_to_fwspec(struct rzg2l_irqc_priv *priv,
+						struct device_node *np,
+						unsigned int index,
+						unsigned int fwspec_index)
 {
 	struct of_phandle_args map;
+	int ret;
+
+	ret = of_irq_parse_one(np, index, &map);
+	if (ret)
+		return ret;
+
+	of_phandle_args_to_fwspec(np, map.args, map.args_count,
+				  &priv->fwspec[fwspec_index]);
+
+	return 0;
+}
+
+static int rzg2l_irqc_parse_interrupt_by_name_to_fwspec(struct rzg2l_irqc_priv *priv,
+							struct device_node *np,
+							char *irq_name,
+							unsigned int fwspec_index)
+{
+	int index;
+
+	index = of_property_match_string(np, "interrupt-names", irq_name);
+	if (index < 0)
+		return index;
+
+	return rzg2l_irqc_parse_interrupt_to_fwspec(priv, np, index, fwspec_index);
+}
+
+/* Parse hierarchy domain interrupts ie only IRQ0-7 and TINT0-31 */
+static int rzg2l_irqc_parse_hierarchy_interrupts(struct rzg2l_irqc_priv *priv,
+						 struct device_node *np)
+{
+	struct property *pp;
 	unsigned int i;
 	int ret;
 
+	/*
+	 * first check if interrupt-names property exists if so parse them by name
+	 * or else parse them by index for backward compatibility.
+	 */
+	pp = of_find_property(np, "interrupt-names", NULL);
+	if (pp) {
+		char *irq_name;
+
+		/* parse IRQ0-7 */
+		for (i = 0; i < IRQC_IRQ_COUNT; i++) {
+			irq_name = kasprintf(GFP_KERNEL, "irq%d", i);
+			if (!irq_name)
+				return -ENOMEM;
+
+			ret = rzg2l_irqc_parse_interrupt_by_name_to_fwspec(priv, np, irq_name, i);
+			kfree(irq_name);
+			if (ret)
+				return ret;
+		}
+
+		/* parse TINT0-31 */
+		for (i = 0; i < IRQC_TINT_COUNT; i++) {
+			irq_name = kasprintf(GFP_KERNEL, "tint%d", i);
+			if (!irq_name)
+				return -ENOMEM;
+
+			ret = rzg2l_irqc_parse_interrupt_by_name_to_fwspec(priv, np, irq_name,
+									   i + IRQC_IRQ_COUNT);
+			kfree(irq_name);
+			if (ret)
+				return ret;
+		}
+
+		return 0;
+	}
+
 	for (i = 1; i <= IRQC_NUM_HIERARCHY_IRQ; i++) {
-		ret = of_irq_parse_one(np, i, &map);
+		ret = rzg2l_irqc_parse_interrupt_to_fwspec(priv, np, i, i - 1);
 		if (ret)
 			return ret;
-		of_phandle_args_to_fwspec(np, map.args, map.args_count,
-					  &priv->fwspec[i - 1]);
 	}
 
 	return 0;
@@ -343,7 +410,7 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	ret = rzg2l_irqc_parse_interrupts(priv, node);
+	ret = rzg2l_irqc_parse_hierarchy_interrupts(priv, node);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
 		return ret;
@@ -389,6 +456,7 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
 IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
+IRQCHIP_MATCH("renesas,rzg2ul-irqc", rzg2l_irqc_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
-- 
2.25.1

