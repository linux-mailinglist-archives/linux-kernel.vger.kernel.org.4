Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9563192A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiKUEVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKUEU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:20:57 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F7183BA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:20:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669004435; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=EIYjPyf3w9DhOjCCV/thJnwy7+qR8H6OPg0QKLaSKnCByoEPMqWcaSrrEfl8jpnzZDVqlRh1cSpDS6xmL/fnhKjaLBWXxnZnHYFfihO5Wl1Ibo8G9ipQ+AcIX8poprNpQtWKlpu3gYh5DamF+3yKQhvCrpVQj/Xf1wzcq7umLfo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669004435; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Fn9irMP7okWvGngWT9Yen8/hGTg+Lf8+wdc49FOs54U=; 
        b=SQdrkthZ3zNdQjTsWZiarcl7C48MQI+M6Db1b0yo+k+5UCytb/FPeFw5WNe2+V7e66CXHVS3N8vrCpHpQyrR9ThUJDrOWJxk44GuLS1hJa1ACAeIvZuxHUhoeVrECw8sZM0LlkrANOLKv9+8zZHDj7pjbe5/hE5cI9EsQY36xx0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669004435;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=Fn9irMP7okWvGngWT9Yen8/hGTg+Lf8+wdc49FOs54U=;
        b=IrhV21Qk8cneeCv3AilZlbff9rhfx5nIAlv3U6oM8R+nmzFhwKOylK0+Fg2OerRF
        XCmRfC/dNKHQNzMylKI+WbiNR3w6kh2m1wI28VmHw5DJooGYSlB5UJpGmbEaAbsmiSR
        ATgK5+gyFK2EVRmb3gCgqDoF1MN6/TGN9xYkThjg=
Received: from edelgard.fodlan.icenowy.me (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 1669004435056302.11536882473524; Sun, 20 Nov 2022 20:20:35 -0800 (PST)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] irqchip/sifive-plic: drop quirk for two-cell variant
Date:   Mon, 21 Nov 2022 12:20:26 +0800
Message-Id: <20221121042026.419383-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the special handling of edge-triggered interrupts are defined in the
PLIC spec, we can assume it's not a quirk, but a feature of the PLIC
spec; thus making it a quirk and use quirk-based codepath is not so
necessary.

Move to a #interrupt-cells-based practice which will allow both device
trees without interrupt flags and with interrupt flags work for all
compatible strings.

In addition, this addresses a stable version DT binding violation --
Linux v5.19 comes with "thead,c900-plic" with #interrupt-cells defined to
be 1 instead of 2, this commit will allow DTs that complies to Linux
v5.19 binding work (although no such DT is devliered to the public now).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/irqchip/irq-sifive-plic.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 2f4784860df5..219e4f1b62f0 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -67,6 +67,7 @@ struct plic_priv {
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
 	unsigned long plic_quirks;
+	u32 interrupt_cells;
 };
 
 struct plic_handler {
@@ -208,7 +209,7 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
-	if (!test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
+	if (priv->interrupt_cells < 2)
 		return IRQ_SET_MASK_OK_NOCOPY;
 
 	switch (type) {
@@ -246,7 +247,7 @@ static int plic_irq_domain_translate(struct irq_domain *d,
 {
 	struct plic_priv *priv = d->host_data;
 
-	if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
+	if (priv->interrupt_cells >= 2)
 		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
 
 	return irq_domain_translate_onecell(d, fwspec, hwirq, type);
@@ -357,6 +358,10 @@ static int __init __plic_init(struct device_node *node,
 	}
 
 	error = -EINVAL;
+	of_property_read_u32(node, "#interrupt-cells", &priv->interrupt_cells);
+	if (WARN_ON(!priv->interrupt_cells))
+		goto out_iounmap;
+
 	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
@@ -479,12 +484,5 @@ static int __init plic_init(struct device_node *node,
 
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
-
-static int __init plic_edge_init(struct device_node *node,
-				 struct device_node *parent)
-{
-	return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
-}
-
-IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
-IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
+IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_init);
+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init);
-- 
2.37.1

