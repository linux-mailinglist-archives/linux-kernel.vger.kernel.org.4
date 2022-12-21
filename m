Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8317652A38
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiLUADQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiLUADC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:03:02 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E531EEFD;
        Tue, 20 Dec 2022 16:03:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y16so13456624wrm.2;
        Tue, 20 Dec 2022 16:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za2L0CKEB7yf2ik8Iuj/BZryf3LCWxSxvd2XuC3OlRk=;
        b=X/t0b3H3+hjQwrCd7kME8ld6CwGzkx1Sjj3O8mKERT01ouSPCaqiklUT3UTBUCKSIh
         k8wZX0/dK4zJmDFAsw/LGHkn3BdI037YIjGcDUK6auDDqVPa6Z+Fjy2UyhVGpkvVmgAa
         rYeogGch+W0v2/YhTtRU5SLw55o8De8tcZUokc8bWTooFiVDsdXSBHfpLUwhPq9VpdNB
         rdYC0vRcXWsKsHMry5T5tis1+J7IrLaQUQEcvcvQme9stNtSFZaLbRCsRKxdSXJYg+wa
         LgTjrWdVzL3jpo5toTCT0Jl3v+FEkzuPs/Oyk5daqj9zgbwKqxBl6bENjndXS9kAskQF
         8Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za2L0CKEB7yf2ik8Iuj/BZryf3LCWxSxvd2XuC3OlRk=;
        b=dAr+guZ5RhInNn3FOrf9laFPw1QcNorI2k3eCAQxWhIYxXvlM9FxdH977ak1pv85OD
         u9TZhLMuhakTmXUplWp0928MyV1CcomF+6hs06X3g77TaLCVJlNBB0oN+JrraTrPoaNw
         5nMUSYqwo5XDySZAQDRzAea6OrL+fLMPIcGtOZdCaCwFNcQTqdpbu7DWBnCEfBIU7ob1
         6ZE5scxFE1JSJhLKATfcBnQUlXi6xIKacJBf7kuy4Zw4xdW/Nf8bSiry4LcbHX2ePhTv
         1f0hZKJoMZT4tbk28N5o1tWK5RCwlD/vgI1uID/eDdKw4KUTahuRIc6DKhuvH9w1U48O
         ksrw==
X-Gm-Message-State: AFqh2kpj+RfdraKLiqjVjxy75umz08K1BmtcMAgzkZuvSkFmRdKhioOO
        1lb8wAAAS8nZT18MEwuI6D4=
X-Google-Smtp-Source: AMrXdXu6jEh2mcbeZvR7xwuBfasOURRH24VBC4lgSlkhlPru3BjcxJmCfN4Lda+xirYzlxyl5+iX3w==
X-Received: by 2002:a05:6000:819:b0:242:192c:9b34 with SMTP id bt25-20020a056000081900b00242192c9b34mr2762999wrb.59.1671580979914;
        Tue, 20 Dec 2022 16:02:59 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1595:a48c:95a8:15e0])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002362f6fcaf5sm13740150wrt.48.2022.12.20.16.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 16:02:59 -0800 (PST)
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
Subject: [PATCH v2 3/9] irqchip: irq-renesas-rzg2l: Skip mapping NMI interrupt as part of hierarchy domain
Date:   Wed, 21 Dec 2022 00:02:36 +0000
Message-Id: <20221221000242.340202-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

NMI interrupt is not an external interrupt as compared to the IRQ0-7 and
TINT0-31, this means we need to install the irq handler for NMI in the
IRQC driver and not include it as part of IRQ domain.

This patch skips mapping NMI interrupt as part of the IRQ domain
hierarchy.

Fixes: 3fed09559cd8 ("irqchip: Add RZ/G2L IA55 Interrupt Controller driver")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1 -> v2
* New patch
---
 drivers/irqchip/irq-renesas-rzg2l.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 25fd8ee66565..7918fe201218 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -23,7 +23,8 @@
 #define IRQC_IRQ_COUNT			8
 #define IRQC_TINT_START			(IRQC_IRQ_START + IRQC_IRQ_COUNT)
 #define IRQC_TINT_COUNT			32
-#define IRQC_NUM_IRQ			(IRQC_TINT_START + IRQC_TINT_COUNT)
+					/* IRQ0-7 + TINT0-31 */
+#define IRQC_NUM_HIERARCHY_IRQ		(IRQC_TINT_START + IRQC_TINT_COUNT - 1)
 
 #define ISCR				0x10
 #define IITSR				0x14
@@ -58,7 +59,8 @@
 
 struct rzg2l_irqc_priv {
 	void __iomem *base;
-	struct irq_fwspec fwspec[IRQC_NUM_IRQ];
+	/* IRQ0-7 + TINT0-31 will be part of hierarchy domain */
+	struct irq_fwspec fwspec[IRQC_NUM_HIERARCHY_IRQ];
 	raw_spinlock_t lock;
 };
 
@@ -99,7 +101,7 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 	raw_spin_lock(&priv->lock);
 	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
 		rzg2l_irq_eoi(d);
-	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
+	else if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_NUM_HIERARCHY_IRQ)
 		rzg2l_tint_eoi(d);
 	raw_spin_unlock(&priv->lock);
 	irq_chip_eoi_parent(d);
@@ -109,7 +111,7 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
 {
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
-	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
+	if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_NUM_HIERARCHY_IRQ) {
 		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 		u32 offset = hw_irq - IRQC_TINT_START;
 		u32 tssr_offset = TSSR_OFFSET(offset);
@@ -129,7 +131,7 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 {
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
-	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
+	if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_NUM_HIERARCHY_IRQ) {
 		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 		unsigned long tint = (uintptr_t)d->chip_data;
 		u32 offset = hw_irq - IRQC_TINT_START;
@@ -228,7 +230,7 @@ static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type)
 
 	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
 		ret = rzg2l_irq_set_type(d, type);
-	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
+	else if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_NUM_HIERARCHY_IRQ)
 		ret = rzg2l_tint_set_edge(d, type);
 	if (ret)
 		return ret;
@@ -280,7 +282,7 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 			return -EINVAL;
 	}
 
-	if (hwirq > (IRQC_NUM_IRQ - 1))
+	if (!hwirq || hwirq > IRQC_NUM_HIERARCHY_IRQ)
 		return -EINVAL;
 
 	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &irqc_chip,
@@ -288,7 +290,7 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret)
 		return ret;
 
-	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &priv->fwspec[hwirq]);
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &priv->fwspec[hwirq - 1]);
 }
 
 static const struct irq_domain_ops rzg2l_irqc_domain_ops = {
@@ -304,12 +306,12 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
 	unsigned int i;
 	int ret;
 
-	for (i = 0; i < IRQC_NUM_IRQ; i++) {
+	for (i = 1; i <= IRQC_NUM_HIERARCHY_IRQ; i++) {
 		ret = of_irq_parse_one(np, i, &map);
 		if (ret)
 			return ret;
 		of_phandle_args_to_fwspec(np, map.args, map.args_count,
-					  &priv->fwspec[i]);
+					  &priv->fwspec[i - 1]);
 	}
 
 	return 0;
@@ -366,7 +368,7 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 
 	raw_spin_lock_init(&priv->lock);
 
-	irq_domain = irq_domain_add_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
+	irq_domain = irq_domain_add_hierarchy(parent_domain, 0, IRQC_NUM_HIERARCHY_IRQ,
 					      node, &rzg2l_irqc_domain_ops,
 					      priv);
 	if (!irq_domain) {
-- 
2.25.1

