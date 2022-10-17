Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ACF6005AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiJQDUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiJQDUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:20:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2508F42E40
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E00A60F05
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC42EC433D7;
        Mon, 17 Oct 2022 03:20:30 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH] irqchip/loongson-htvec: Add ACPI init support
Date:   Mon, 17 Oct 2022 11:18:47 +0800
Message-Id: <20221017031847.2407930-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HTVECINTC stands for "HyperTransport Interrupts" that described in
Section 14.3 of "Loongson 3A5000 Processor Reference Manual". For more
information please refer Documentation/loongarch/irq-chip-model.rst.

Though the extended model is the recommended one, there are still some
legacy model machines. So we add ACPI init support for HTVECINTC.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/irq.h       |   2 +-
 drivers/irqchip/Kconfig                |   1 +
 drivers/irqchip/irq-loongson-htvec.c   | 145 +++++++++++++++++++------
 drivers/irqchip/irq-loongson-liointc.c |  21 +++-
 4 files changed, 133 insertions(+), 36 deletions(-)

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index d06d4542b634..9d3d36e41afe 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -93,7 +93,7 @@ int liointc_acpi_init(struct irq_domain *parent,
 int eiointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_eio_pic *acpi_eiointc);
 
-struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
+int htvec_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_ht_pic *acpi_htvec);
 int pch_lpc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lpc_pic *acpi_pchlpc);
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7ef9f5e696d3..17396e6e42fc 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -576,6 +576,7 @@ config IRQ_LOONGARCH_CPU
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select LOONGSON_HTVEC
 	select LOONGSON_LIOINTC
 	select LOONGSON_EIOINTC
 	select LOONGSON_PCH_PIC
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 60a335d7e64e..1bb414ec6e78 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -20,7 +20,6 @@
 /* Registers */
 #define HTVEC_EN_OFF		0x20
 #define HTVEC_MAX_PARENT_IRQ	8
-
 #define VEC_COUNT_PER_REG	32
 #define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
 #define VEC_REG_BIT(irq_id)	((irq_id) % VEC_COUNT_PER_REG)
@@ -32,6 +31,8 @@ struct htvec {
 	raw_spinlock_t		htvec_lock;
 };
 
+static struct htvec *htvec_priv;
+
 static void htvec_irq_dispatch(struct irq_desc *desc)
 {
 	int i;
@@ -155,64 +156,140 @@ static void htvec_reset(struct htvec *priv)
 	}
 }
 
-static int htvec_of_init(struct device_node *node,
-				struct device_node *parent)
+static int htvec_init(phys_addr_t addr, unsigned long size,
+		int num_parents, int parent_irq[], struct fwnode_handle *domain_handle)
 {
+	int i;
 	struct htvec *priv;
-	int err, parent_irq[8], i;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->num_parents = num_parents;
+	priv->base = ioremap(addr, size);
 	raw_spin_lock_init(&priv->htvec_lock);
-	priv->base = of_iomap(node, 0);
-	if (!priv->base) {
-		err = -ENOMEM;
-		goto free_priv;
-	}
-
-	/* Interrupt may come from any of the 8 interrupt lines */
-	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
-		parent_irq[i] = irq_of_parse_and_map(node, i);
-		if (parent_irq[i] <= 0)
-			break;
-
-		priv->num_parents++;
-	}
-
-	if (!priv->num_parents) {
-		pr_err("Failed to get parent irqs\n");
-		err = -ENODEV;
-		goto iounmap_base;
-	}
 
-	priv->htvec_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+	/* Setup IRQ domain */
+	priv->htvec_domain = irq_domain_create_linear(domain_handle,
 					(VEC_COUNT_PER_REG * priv->num_parents),
 					&htvec_domain_ops, priv);
 	if (!priv->htvec_domain) {
-		pr_err("Failed to create IRQ domain\n");
-		err = -ENOMEM;
-		goto irq_dispose;
+		pr_err("loongson-htvec: cannot add IRQ domain\n");
+		goto iounmap_base;
 	}
 
 	htvec_reset(priv);
 
-	for (i = 0; i < priv->num_parents; i++)
+	for (i = 0; i < priv->num_parents; i++) {
 		irq_set_chained_handler_and_data(parent_irq[i],
 						 htvec_irq_dispatch, priv);
+	}
+
+	htvec_priv = priv;
 
 	return 0;
 
-irq_dispose:
-	for (; i > 0; i--)
-		irq_dispose_mapping(parent_irq[i - 1]);
 iounmap_base:
 	iounmap(priv->base);
-free_priv:
 	kfree(priv);
 
-	return err;
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+
+static int htvec_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	int i, err;
+	int parent_irq[8];
+	int num_parents = 0;
+	struct resource res;
+
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+
+	/* Interrupt may come from any of the 8 interrupt lines */
+	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++) {
+		parent_irq[i] = irq_of_parse_and_map(node, i);
+		if (parent_irq[i] <= 0)
+			break;
+
+		num_parents++;
+	}
+
+	err = htvec_init(res.start, resource_size(&res),
+			num_parents, parent_irq, of_node_to_fwnode(node));
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+static int __init
+pch_pic_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
+
+	return pch_pic_acpi_init(htvec_priv->htvec_domain, pchpic_entry);
+}
+
+static int __init
+pch_msi_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
+
+	return pch_msi_acpi_init(htvec_priv->htvec_domain, pchmsi_entry);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
+			      pch_pic_parse_madt, 0);
+	acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
+			      pch_msi_parse_madt, 0);
+	return 0;
+}
+
+int __init htvec_acpi_init(struct irq_domain *parent,
+				   struct acpi_madt_ht_pic *acpi_htvec)
+{
+	int i, ret;
+	int num_parents, parent_irq[8];
+	struct fwnode_handle *domain_handle;
+
+	if (!acpi_htvec)
+		return -EINVAL;
+
+	num_parents = HTVEC_MAX_PARENT_IRQ;
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_htvec);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return -ENOMEM;
+	}
+
+	/* Interrupt may come from any of the 8 interrupt lines */
+	for (i = 0; i < HTVEC_MAX_PARENT_IRQ; i++)
+		parent_irq[i] = irq_create_mapping(parent, acpi_htvec->cascade[i]);
+
+	ret = htvec_init(acpi_htvec->address, acpi_htvec->size,
+			num_parents, parent_irq, domain_handle);
+
+	if (ret == 0)
+		acpi_cascade_irqdomain_init();
+	else
+		irq_domain_free_fwnode(domain_handle);
+
+	return ret;
+}
+
+#endif
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 0da8716f8f24..ddf23b1114cb 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -349,6 +349,22 @@ IRQCHIP_DECLARE(loongson_liointc_2_0, "loongson,liointc-2.0", liointc_of_init);
 #endif
 
 #ifdef CONFIG_ACPI
+static int __init htintc_parse_madt(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct acpi_madt_ht_pic *htintc_entry = (struct acpi_madt_ht_pic *)header;
+	struct irq_domain *parent = irq_find_matching_fwnode(liointc_handle, DOMAIN_BUS_ANY);
+
+	return htvec_acpi_init(parent, htintc_entry);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_HT_PIC,
+			      htintc_parse_madt, 0);
+	return 0;
+}
+
 int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic *acpi_liointc)
 {
 	int ret;
@@ -365,9 +381,12 @@ int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic
 		pr_err("Unable to allocate domain handle\n");
 		return -ENOMEM;
 	}
+
 	ret = liointc_init(acpi_liointc->address, acpi_liointc->size,
 			   1, domain_handle, NULL);
-	if (ret)
+	if (ret == 0)
+		acpi_cascade_irqdomain_init();
+	else
 		irq_domain_free_fwnode(domain_handle);
 
 	return ret;
-- 
2.31.1

