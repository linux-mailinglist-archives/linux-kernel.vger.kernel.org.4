Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890F2692D6C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 03:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBKCl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 21:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKCly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 21:41:54 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC2E315570;
        Fri, 10 Feb 2023 18:41:51 -0800 (PST)
Received: from loongson.cn (unknown [112.20.108.204])
        by gateway (Coremail) with SMTP id _____8BxLutuAOdjYRsRAA--.33874S3;
        Sat, 11 Feb 2023 10:41:50 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.108.204])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxjb5tAOdjVNwwAA--.30227S2;
        Sat, 11 Feb 2023 10:41:50 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH] irqchip/loongson-eiointc: Add DT init support
Date:   Sat, 11 Feb 2023 10:41:56 +0800
Message-Id: <20230211024156.3530526-1-zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxjb5tAOdjVNwwAA--.30227S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Xr15XrWktw4UJr1fJw4ruFg_yoWxXr4Dpa
        yUAF98trWrXFy7WrWftw4DX343Aws5u3y7Xa4fWFWftFsrCry8GF1FyFyqkryjk3yrXF4a
        vF4UZF1Uu3W5KaUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2
        AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xF
        xVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_
        Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUcVWlDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT support for EIOINTC irqchip, which is needed for the Loongson-2K
series, e.g. Loongson-2K500 soc.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 119 ++++++++++++++++++-------
 1 file changed, 85 insertions(+), 34 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index d15fd38c1756..d5e1ee6aada6 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -39,6 +39,7 @@ static int nr_pics;
 
 struct eiointc_priv {
 	u32			node;
+	u32			vec_count;
 	nodemask_t		node_map;
 	cpumask_t		cpuspan_map;
 	struct fwnode_handle	*domain_handle;
@@ -156,18 +157,19 @@ static int eiointc_router_init(unsigned int cpu)
 	if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) == 0) {
 		eiointc_enable();
 
-		for (i = 0; i < VEC_COUNT / 32; i++) {
+		for (i = 0; i < eiointc_priv[0]->vec_count / 32; i++) {
+			pr_info("");
 			data = (((1 << (i * 2 + 1)) << 16) | (1 << (i * 2)));
 			iocsr_write32(data, EIOINTC_REG_NODEMAP + i * 4);
 		}
 
-		for (i = 0; i < VEC_COUNT / 32 / 4; i++) {
+		for (i = 0; i < eiointc_priv[0]->vec_count / 32 / 4; i++) {
 			bit = BIT(1 + index); /* Route to IP[1 + index] */
 			data = bit | (bit << 8) | (bit << 16) | (bit << 24);
 			iocsr_write32(data, EIOINTC_REG_IPMAP + i * 4);
 		}
 
-		for (i = 0; i < VEC_COUNT / 4; i++) {
+		for (i = 0; i < eiointc_priv[0]->vec_count / 4; i++) {
 			/* Route to Node-0 Core-0 */
 			if (index == 0)
 				bit = BIT(cpu_logical_map(0));
@@ -178,7 +180,7 @@ static int eiointc_router_init(unsigned int cpu)
 			iocsr_write32(data, EIOINTC_REG_ROUTE + i * 4);
 		}
 
-		for (i = 0; i < VEC_COUNT / 32; i++) {
+		for (i = 0; i < eiointc_priv[0]->vec_count / 32; i++) {
 			data = 0xffffffff;
 			iocsr_write32(data, EIOINTC_REG_ENABLE + i * 4);
 			iocsr_write32(data, EIOINTC_REG_BOUNCE + i * 4);
@@ -198,7 +200,7 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	for (i = 0; i < VEC_REG_COUNT; i++) {
+	for (i = 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
 		pending = iocsr_read64(EIOINTC_REG_ISR + (i << 3));
 		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
 		while (pending) {
@@ -316,7 +318,7 @@ static void eiointc_resume(void)
 	eiointc_router_init(0);
 
 	for (i = 0; i < nr_pics; i++) {
-		for (j = 0; j < VEC_COUNT; j++) {
+		for (j = 0; j < eiointc_priv[i]->vec_count; j++) {
 			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
 			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
 				raw_spin_lock(&desc->lock);
@@ -373,11 +375,44 @@ static int __init acpi_cascade_irqdomain_init(void)
 	return 0;
 }
 
+static int __init eiointc_init(struct eiointc_priv *priv, int parent_irq,
+			       u64 node_map)
+{
+	int i;
+
+	node_map = node_map ? node_map : -1ULL;
+	for_each_possible_cpu(i) {
+		if (node_map & (1ULL << (cpu_to_eio_node(i)))) {
+			node_set(cpu_to_eio_node(i), priv->node_map);
+			cpumask_or(&priv->cpuspan_map, &priv->cpuspan_map,
+				   cpumask_of(i));
+		}
+	}
+
+	priv->eiointc_domain = irq_domain_create_linear(priv->domain_handle,
+							priv->vec_count,
+							&eiointc_domain_ops,
+							priv);
+	if (!priv->eiointc_domain) {
+		pr_err("loongson-extioi: cannot add IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	eiointc_priv[nr_pics++] = priv;
+	eiointc_router_init(0);
+	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
+	register_syscore_ops(&eiointc_syscore_ops);
+	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
+				  "irqchip/loongarch/intc:starting",
+				  eiointc_router_init, NULL);
+
+	return 0;
+}
+
 int __init eiointc_acpi_init(struct irq_domain *parent,
 				     struct acpi_madt_eio_pic *acpi_eiointc)
 {
-	int i, ret, parent_irq;
-	unsigned long node_map;
+	int parent_irq, ret;
 	struct eiointc_priv *priv;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -391,39 +426,20 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 		goto out_free_priv;
 	}
 
+	priv->vec_count = VEC_COUNT;
 	priv->node = acpi_eiointc->node;
-	node_map = acpi_eiointc->node_map ? : -1ULL;
-
-	for_each_possible_cpu(i) {
-		if (node_map & (1ULL << cpu_to_eio_node(i))) {
-			node_set(cpu_to_eio_node(i), priv->node_map);
-			cpumask_or(&priv->cpuspan_map, &priv->cpuspan_map, cpumask_of(i));
-		}
-	}
-
-	/* Setup IRQ domain */
-	priv->eiointc_domain = irq_domain_create_linear(priv->domain_handle, VEC_COUNT,
-					&eiointc_domain_ops, priv);
-	if (!priv->eiointc_domain) {
-		pr_err("loongson-eiointc: cannot add IRQ domain\n");
-		goto out_free_handle;
-	}
-
-	eiointc_priv[nr_pics++] = priv;
-
-	eiointc_router_init(0);
-
 	parent_irq = irq_create_mapping(parent, acpi_eiointc->cascade);
-	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
 
-	register_syscore_ops(&eiointc_syscore_ops);
-	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
-				  "irqchip/loongarch/intc:starting",
-				  eiointc_router_init, NULL);
+	ret = eiointc_init(priv, parent_irq, acpi_eiointc->node_map);
+	if (ret < 0)
+		goto out_free_handle;
 
 	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
 	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
+
 	ret = acpi_cascade_irqdomain_init();
+	if (ret < 0)
+		goto out_free_handle;
 
 	return ret;
 
@@ -435,3 +451,39 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 
 	return -ENOMEM;
 }
+
+static int __init eiointc_of_init(struct device_node *of_node,
+				  struct device_node *parent)
+{
+	int parent_irq, ret;
+	struct eiointc_priv *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	parent_irq = of_irq_get_byname(of_node, "cascade");
+	if (parent_irq <= 0) {
+		ret = -ENODEV;
+		goto out_free_priv;
+	}
+
+	ret = of_property_read_u32(of_node, "vec_count", &priv->vec_count);
+	if (ret < 0)
+		goto out_free_priv;
+
+	priv->node = 0;
+	priv->domain_handle = of_node_to_fwnode(of_node);
+
+	ret = eiointc_init(priv, parent_irq, 0);
+	if (ret < 0)
+		goto out_free_priv;
+
+	return 0;
+
+out_free_priv:
+	kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(loongson_eiointc, "loongson,eiointc", eiointc_of_init);
-- 
2.39.0

