Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BEC68AF89
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 12:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBELaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 06:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBEL37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:29:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EF91E5E6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 03:29:58 -0800 (PST)
Date:   Sun, 05 Feb 2023 11:29:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675596595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=alT5Kd/19UZgs2bfOZk3m/lY2NavrDyjDOJ9aLH0ePk=;
        b=EadOCspRS8foyETLGSXEC3PMwBfcYOwcAsLL3yfmjIbflCFIbFp8XUzSbzDvVVTqHMP0cn
        NW5jssWunKu07oUqbjO+/fxBbGXaEvMiEX7vZB+t9ItVkcAUWR1KM+6UFNLz99xNn4pPUb
        e5rbxE38P4AhfpNy1tO4Cwug5b3KnVZOdlHFSBYndJXUaamw2qU9GggvFW5YxQfmqzl/wW
        Lds71qNFuhFr3S2yc/VkROA4AmRsHbrpN7aM4ZlChRPoKHozVbA8Wx1YAmG3WGiNaVw0IQ
        bJIAZ4T5KtdXXG3baA/C6eExhaoYjdeftwPo4STEyjzNheD+wla8KiBRWgBKnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675596595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=alT5Kd/19UZgs2bfOZk3m/lY2NavrDyjDOJ9aLH0ePk=;
        b=jaV8aqC2eWXcajykuZrEDWOzgDQ3YEKPwkBKn+1rt1w714fq2EOYuete/zjBxBbmnNrYDz
        g8S3bORTpBpLMRCQ==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-liointc: Save/restore
 int_edge/int_pol registers during S3/S4
Cc:     Yingkun Meng <mengyingkun@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221207140643.1600743-1-chenhuacai@loongson.cn>
References: <20221207140643.1600743-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <167559659472.4906.2586833215028000234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     fc98adb9a8435cdb4e8349138ac0b728df80ade9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fc98adb9a8435cdb4e8349138ac0b728df80ade9
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Wed, 07 Dec 2022 22:06:43 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 05 Feb 2023 10:55:19 

irqchip/loongson-liointc: Save/restore int_edge/int_pol registers during S3/S4

If int_edge/int_pol registers are configured to not be the default values, we
should save/restore them during S3/S4.

Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221207140643.1600743-1-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-liointc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 85b754f..8d00a9a 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -55,6 +55,8 @@ struct liointc_priv {
 	struct liointc_handler_data	handler[LIOINTC_NUM_PARENT];
 	void __iomem			*core_isr[LIOINTC_NUM_CORES];
 	u8				map_cache[LIOINTC_CHIP_IRQ];
+	u32				int_pol;
+	u32				int_edge;
 	bool				has_lpc_irq_errata;
 };
 
@@ -138,6 +140,14 @@ static int liointc_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
+static void liointc_suspend(struct irq_chip_generic *gc)
+{
+	struct liointc_priv *priv = gc->private;
+
+	priv->int_pol = readl(gc->reg_base + LIOINTC_REG_INTC_POL);
+	priv->int_edge = readl(gc->reg_base + LIOINTC_REG_INTC_EDGE);
+}
+
 static void liointc_resume(struct irq_chip_generic *gc)
 {
 	struct liointc_priv *priv = gc->private;
@@ -150,6 +160,8 @@ static void liointc_resume(struct irq_chip_generic *gc)
 	/* Restore map cache */
 	for (i = 0; i < LIOINTC_CHIP_IRQ; i++)
 		writeb(priv->map_cache[i], gc->reg_base + i);
+	writel(priv->int_pol, gc->reg_base + LIOINTC_REG_INTC_POL);
+	writel(priv->int_edge, gc->reg_base + LIOINTC_REG_INTC_EDGE);
 	/* Restore mask cache */
 	writel(gc->mask_cache, gc->reg_base + LIOINTC_REG_INTC_ENABLE);
 	irq_gc_unlock_irqrestore(gc, flags);
@@ -269,6 +281,7 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 	gc->private = priv;
 	gc->reg_base = base;
 	gc->domain = domain;
+	gc->suspend = liointc_suspend;
 	gc->resume = liointc_resume;
 
 	ct = gc->chip_types;
