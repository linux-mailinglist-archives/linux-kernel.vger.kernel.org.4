Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC4763962B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiKZNe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiKZNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC501DA47
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:38 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5U0P5TaU1DGDn8AO5JOG+QP7KEOXfHS3jJyhhzIqRJY=;
        b=1SiD1yLSMc3nD5okHfv76Uo66zaghbzQ8zAP+0hLx2pDwDobceVd3CfLnxb46lsRo9rbDV
        94CMaxHYN4wO0rvh4ayshZeNDsLrC/qJptqtA+TGlQLhnfhuArIBIRYEbjLZUPTXoy2ks5
        fMzdr7o4iVrz+v9Tz2sWtfkB63+PjIGFj5yZMpjElsc56aRI4TeYZtO7xYzCXeZMUSm6UR
        5AIZWKRtzlzMl4BYg2q0hAW8abQkvDwQdqYBnPz+HXHZYJQJ/GGPpdHt3Aunk0Yink26SV
        7o1uMCfc55ub9/0xYyf1T+PkJ1yLqpUD2xREMteWQ4w7MfJvPDPE3743A+e1xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469677;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5U0P5TaU1DGDn8AO5JOG+QP7KEOXfHS3jJyhhzIqRJY=;
        b=ntuFOKfRZXdE+hlVVSvNWaqpVdWeArcjzXaEnWmhicHEBz8neDw7jf1s4aFLppXW+2deDP
        6a7tDqjB1Zx+IFAw==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-pch-lpc: Add
 suspend/resume support
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221020073527.541845-5-chenhuacai@loongson.cn>
References: <20221020073527.541845-5-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <166946967598.4906.8330183421538666371.tip-bot2@tip-bot2>
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

Commit-ID:     c7c75e32f8a61854c38326aef276e3a58dc7fd08
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c7c75e32f8a61854c38326aef276e3a58dc7fd08
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Thu, 20 Oct 2022 15:35:27 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:12:13 

irqchip/loongson-pch-lpc: Add suspend/resume support

Add suspend/resume support for PCH-LPC irqchip, which is needed for
upcoming suspend/hibernation.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221020073527.541845-5-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-pch-lpc.c | 25 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loongson-pch-lpc.c
index bf23249..9b35492 100644
--- a/drivers/irqchip/irq-loongson-pch-lpc.c
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -13,6 +13,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/syscore_ops.h>
 
 /* Registers */
 #define LPC_INT_CTL		0x00
@@ -34,6 +35,7 @@ struct pch_lpc {
 	u32			saved_reg_pol;
 };
 
+static struct pch_lpc *pch_lpc_priv;
 struct fwnode_handle *pch_lpc_handle;
 
 static void lpc_irq_ack(struct irq_data *d)
@@ -147,6 +149,26 @@ static int pch_lpc_disabled(struct pch_lpc *priv)
 			(readl(priv->base + LPC_INT_STS) == 0xffffffff);
 }
 
+static int pch_lpc_suspend(void)
+{
+	pch_lpc_priv->saved_reg_ctl = readl(pch_lpc_priv->base + LPC_INT_CTL);
+	pch_lpc_priv->saved_reg_ena = readl(pch_lpc_priv->base + LPC_INT_ENA);
+	pch_lpc_priv->saved_reg_pol = readl(pch_lpc_priv->base + LPC_INT_POL);
+	return 0;
+}
+
+static void pch_lpc_resume(void)
+{
+	writel(pch_lpc_priv->saved_reg_ctl, pch_lpc_priv->base + LPC_INT_CTL);
+	writel(pch_lpc_priv->saved_reg_ena, pch_lpc_priv->base + LPC_INT_ENA);
+	writel(pch_lpc_priv->saved_reg_pol, pch_lpc_priv->base + LPC_INT_POL);
+}
+
+static struct syscore_ops pch_lpc_syscore_ops = {
+	.suspend = pch_lpc_suspend,
+	.resume = pch_lpc_resume,
+};
+
 int __init pch_lpc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lpc_pic *acpi_pchlpc)
 {
@@ -191,7 +213,10 @@ int __init pch_lpc_acpi_init(struct irq_domain *parent,
 	parent_irq = irq_create_fwspec_mapping(&fwspec);
 	irq_set_chained_handler_and_data(parent_irq, lpc_irq_dispatch, priv);
 
+	pch_lpc_priv = priv;
 	pch_lpc_handle = irq_handle;
+	register_syscore_ops(&pch_lpc_syscore_ops);
+
 	return 0;
 
 free_irq_handle:
