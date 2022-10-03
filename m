Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837865F329C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiJCPfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJCPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:35:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD55286F5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:35:10 -0700 (PDT)
Date:   Mon, 03 Oct 2022 15:35:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664811307;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3coyZAhFCnK8t9YcHdXaHUpwvVKD/zukHIc+FK6uGg4=;
        b=P0/CyOHJys2TcATNb5qpuY1XC6YaekjFDjz4WZ8Fa2yosFs2Qm9QBf5EUHtFUYfeV7bins
        VlzTN8BwiiZfICIMDDOZuGj1g37ehwi4zafLAYc1vk0kIErm7PcYMjDRAD/KuoLotYlcrV
        mtnTNrMzjrrkBt8cARjnNGHkGuMw1XsrKZXE+Jb7wUcZ9qYPoXCTbRQmlyN6HdP14qHSsU
        aA1FxH216r8TC5uxkvV7CFyvt2Nb6B70rw/LAmRmRTfJnS1EqAwd8trewdXLF4V7Gu9QZa
        O8Qlto80eFBzZNCN5+9wF/n4+cTQLmgPVT6xx40fhj3hw0UTTA5J7iRHL1O+1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664811307;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3coyZAhFCnK8t9YcHdXaHUpwvVKD/zukHIc+FK6uGg4=;
        b=GQtDVWUyS9A4uXsSCPUEisFlJO/kVSYc6AI5AlGgM9LETXqLmcMARjw9ycAenplrop2aQS
        9rYQb3QADBV9jGAQ==
From:   "irqchip-bot for Vladimir Oltean" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/ls-extirq: Fix invalid wait
 context by avoiding to use regmap
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220728144254.175385-1-vladimir.oltean@nxp.com>
References: <20220728144254.175385-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Message-ID: <166481130583.401.8575256351684594864.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     1b00adce8afdb842615a5bf3774510f14a9b769a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1b00adce8afdb842615a5bf3774510f14a9b769a
Author:        Vladimir Oltean <vladimir.oltean@nxp.com>
AuthorDate:    Thu, 28 Jul 2022 17:42:54 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 03 Oct 2022 16:29:17 +01:00

irqchip/ls-extirq: Fix invalid wait context by avoiding to use regmap

The irqchip->irq_set_type method is called by __irq_set_trigger() under
the desc->lock raw spinlock.

The ls-extirq implementation, ls_extirq_irq_set_type(), uses an MMIO
regmap created by of_syscon_register(), which uses plain spinlocks
(the kind that are sleepable on RT).

Therefore, this is an invalid locking scheme for which we get a kernel
splat stating just that ("[ BUG: Invalid wait context ]"), because the
context in which the plain spinlock may sleep is atomic due to the raw
spinlock. We need to go raw spinlocks all the way.

Make this driver ioremap its INTPCR register on its own, and stop
relying on syscon to provide a regmap.

Fixes: 0dcd9f872769 ("irqchip: Add support for Layerscape external interrupt lines")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
[maz: trimmed down commit log]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220728144254.175385-1-vladimir.oltean@nxp.com
---
 drivers/irqchip/irq-ls-extirq.c | 87 +++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 853b397..d8d48b1 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -6,8 +6,7 @@
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -16,13 +15,41 @@
 #define LS1021A_SCFGREVCR 0x200
 
 struct ls_extirq_data {
-	struct regmap		*syscon;
-	u32			intpcr;
+	void __iomem		*intpcr;
+	raw_spinlock_t		lock;
+	bool			big_endian;
 	bool			is_ls1021a_or_ls1043a;
 	u32			nirq;
 	struct irq_fwspec	map[MAXIRQ];
 };
 
+static void ls_extirq_intpcr_rmw(struct ls_extirq_data *priv, u32 mask,
+				 u32 value)
+{
+	u32 intpcr;
+
+	/*
+	 * Serialize concurrent calls to ls_extirq_set_type() from multiple
+	 * IRQ descriptors, making sure the read-modify-write is atomic.
+	 */
+	raw_spin_lock(&priv->lock);
+
+	if (priv->big_endian)
+		intpcr = ioread32be(priv->intpcr);
+	else
+		intpcr = ioread32(priv->intpcr);
+
+	intpcr &= ~mask;
+	intpcr |= value;
+
+	if (priv->big_endian)
+		iowrite32be(intpcr, priv->intpcr);
+	else
+		iowrite32(intpcr, priv->intpcr);
+
+	raw_spin_unlock(&priv->lock);
+}
+
 static int
 ls_extirq_set_type(struct irq_data *data, unsigned int type)
 {
@@ -51,7 +78,8 @@ ls_extirq_set_type(struct irq_data *data, unsigned int type)
 	default:
 		return -EINVAL;
 	}
-	regmap_update_bits(priv->syscon, priv->intpcr, mask, value);
+
+	ls_extirq_intpcr_rmw(priv, mask, value);
 
 	return irq_chip_set_type_parent(data, type);
 }
@@ -143,7 +171,6 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, struct device_node *node)
 static int __init
 ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 {
-
 	struct irq_domain *domain, *parent_domain;
 	struct ls_extirq_data *priv;
 	int ret;
@@ -151,40 +178,52 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("Cannot find parent domain\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_irq_find_host;
 	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->syscon = syscon_node_to_regmap(node->parent);
-	if (IS_ERR(priv->syscon)) {
-		ret = PTR_ERR(priv->syscon);
-		pr_err("Failed to lookup parent regmap\n");
-		goto out;
+	if (!priv) {
+		ret = -ENOMEM;
+		goto err_alloc_priv;
 	}
-	ret = of_property_read_u32(node, "reg", &priv->intpcr);
-	if (ret) {
-		pr_err("Missing INTPCR offset value\n");
-		goto out;
+
+	/*
+	 * All extirq OF nodes are under a scfg/syscon node with
+	 * the 'ranges' property
+	 */
+	priv->intpcr = of_iomap(node, 0);
+	if (!priv->intpcr) {
+		pr_err("Cannot ioremap OF node %pOF\n", node);
+		ret = -ENOMEM;
+		goto err_iomap;
 	}
 
 	ret = ls_extirq_parse_map(priv, node);
 	if (ret)
-		goto out;
+		goto err_parse_map;
 
+	priv->big_endian = of_device_is_big_endian(parent);
 	priv->is_ls1021a_or_ls1043a = of_device_is_compatible(node, "fsl,ls1021a-extirq") ||
 				      of_device_is_compatible(node, "fsl,ls1043a-extirq");
+	raw_spin_lock_init(&priv->lock);
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
 					  &extirq_domain_ops, priv);
-	if (!domain)
+	if (!domain) {
 		ret = -ENOMEM;
+		goto err_add_hierarchy;
+	}
 
-out:
-	if (ret)
-		kfree(priv);
+	return 0;
+
+err_add_hierarchy:
+err_parse_map:
+	iounmap(priv->intpcr);
+err_iomap:
+	kfree(priv);
+err_alloc_priv:
+err_irq_find_host:
 	return ret;
 }
 
