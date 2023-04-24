Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D796ECC49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjDXMtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjDXMtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:49:40 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78FF23C2D;
        Mon, 24 Apr 2023 05:49:38 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.110.102])
        by gateway (Coremail) with SMTP id _____8CxlfDhekZklQoAAA--.112S3;
        Mon, 24 Apr 2023 20:49:37 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.110.102])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxHLPdekZkMNA4AA--.11292S4;
        Mon, 24 Apr 2023 20:49:36 +0800 (CST)
From:   Binbin Zhou <zhoubinbin@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH V4 2/2] irqchip/loongson-eiointc: Add DT init support
Date:   Mon, 24 Apr 2023 20:49:12 +0800
Message-Id: <e299c299095a9e32e3a4596b4e1c2c0864e5a01a.1682328016.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1682328016.git.zhoubinbin@loongson.cn>
References: <cover.1682328016.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxHLPdekZkMNA4AA--.11292S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3JFyktr43Xr45CF4DArWUurg_yoWxCry7pF
        WUCF98trWrXFy7WrW5ta1DX34ayws5urW7Xa4fWFWftanrCryUGF1FyF1qkryjk3yrXF4a
        vF4UZr1Uu3W5Kw7anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EIOINTC irqchip DT support, which is needed for Loongson chips
based on DT and supporting EIOINTC, such as the Loongson-2K0500 SOC.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 129 ++++++++++++++++++-------
 1 file changed, 95 insertions(+), 34 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index d15fd38c1756..cfeb40daf1d7 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -39,6 +39,7 @@ static int nr_pics;
 
 struct eiointc_priv {
 	u32			node;
+	u32			vec_count;
 	nodemask_t		node_map;
 	cpumask_t		cpuspan_map;
 	struct fwnode_handle	*domain_handle;
@@ -156,18 +157,18 @@ static int eiointc_router_init(unsigned int cpu)
 	if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) == 0) {
 		eiointc_enable();
 
-		for (i = 0; i < VEC_COUNT / 32; i++) {
+		for (i = 0; i < eiointc_priv[0]->vec_count / 32; i++) {
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
@@ -178,7 +179,7 @@ static int eiointc_router_init(unsigned int cpu)
 			iocsr_write32(data, EIOINTC_REG_ROUTE + i * 4);
 		}
 
-		for (i = 0; i < VEC_COUNT / 32; i++) {
+		for (i = 0; i < eiointc_priv[0]->vec_count / 32; i++) {
 			data = 0xffffffff;
 			iocsr_write32(data, EIOINTC_REG_ENABLE + i * 4);
 			iocsr_write32(data, EIOINTC_REG_BOUNCE + i * 4);
@@ -198,7 +199,7 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	for (i = 0; i < VEC_REG_COUNT; i++) {
+	for (i = 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
 		pending = iocsr_read64(EIOINTC_REG_ISR + (i << 3));
 		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
 		while (pending) {
@@ -316,7 +317,7 @@ static void eiointc_resume(void)
 	eiointc_router_init(0);
 
 	for (i = 0; i < nr_pics; i++) {
-		for (j = 0; j < VEC_COUNT; j++) {
+		for (j = 0; j < eiointc_priv[0]->vec_count; j++) {
 			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
 			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
 				raw_spin_lock(&desc->lock);
@@ -373,11 +374,44 @@ static int __init acpi_cascade_irqdomain_init(void)
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
@@ -391,39 +425,20 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
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
 
@@ -435,3 +450,49 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 
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
+	parent_irq = irq_of_parse_and_map(of_node, 0);
+	if (parent_irq <= 0) {
+		ret = -ENODEV;
+		goto out_free_priv;
+	}
+
+	ret = irq_set_handler_data(parent_irq, priv);
+	if (ret < 0)
+		goto out_free_priv;
+
+	/*
+	 * In particular, the number of devices supported by the LS2K0500
+	 * extended I/O interrupt vector is 128.
+	 */
+	if (of_device_is_compatible(of_node, "loongson,ls2k0500-eiointc"))
+		priv->vec_count = 128;
+	else
+		priv->vec_count = VEC_COUNT;
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
+IRQCHIP_DECLARE(loongson_ls2k0500_eiointc, "loongson,ls2k0500-eiointc", eiointc_of_init);
+IRQCHIP_DECLARE(loongson_ls2k2000_eiointc, "loongson,ls2k2000-eiointc", eiointc_of_init);
-- 
2.39.1

