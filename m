Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6F974ED98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjGKMIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGKMIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:08:13 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A735AE5C;
        Tue, 11 Jul 2023 05:08:09 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8DxfesoRq1kjH8DAA--.7411S3;
        Tue, 11 Jul 2023 20:08:08 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfSMnRq1k+6goAA--.1095S4;
        Tue, 11 Jul 2023 20:08:08 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 2/2] irqchip/loongson-eiointc: Simplify irq routing on some platforms
Date:   Tue, 11 Jul 2023 20:08:07 +0800
Message-Id: <20230711120807.1805186-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230711120807.1805186-1-maobibo@loongson.cn>
References: <20230711120807.1805186-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfSMnRq1k+6goAA--.1095S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKFykCr13Xw18KFyxCF4rZwc_yoW7GrWxpF
        WUGas0qr48Ja15WrZakw4DZFyayr93X3yDtF4fua97AFWY9w4jgF1FyFnrAF1jk34UAF1Y
        yF4UXFy8uFn8AacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
        Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
        IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
        Ja73UjIFyTuYvjxU4AhLUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some LoongArch systems have only one eiointc node such as 3A5000/2K2000
and qemu virt-machine. If there is only one eiointc node, all cpus can
access eiointc registers directly; if there is multiple eiointc nodes, each
cpu can only access eiointc belonging to specified node group, so anysend
or ipi needs to be used to configure irq routing. IRQ routing is simple on
such systems with one node, hacking method like anysend is not necessary.

This patch provides simpile IRQ routing method for systems with one eiointc
node, and is tested on 3A5000 board and qemu virt-machine.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 79 ++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 1c5a5b59f199..5c15a582075d 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -127,6 +127,48 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
 	return IRQ_SET_MASK_OK;
 }
 
+static int eiointc_single_set_irq_affinity(struct irq_data *d,
+				const struct cpumask *affinity, bool force)
+{
+	unsigned int cpu;
+	unsigned long flags;
+	uint32_t vector, regaddr, data, coremap;
+	struct cpumask mask;
+	struct eiointc_priv *priv = d->domain->host_data;
+
+	cpumask_and(&mask, affinity, cpu_online_mask);
+	cpumask_and(&mask, &mask, &priv->cpuspan_map);
+	if (cpumask_empty(&mask))
+		return -EINVAL;
+
+	cpu = cpumask_first(&mask);
+	vector = d->hwirq;
+	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
+	data = ~BIT(vector & 0x1F);
+	coremap = BIT(cpu_logical_map(cpu) % CORES_PER_EIO_NODE);
+
+	/*
+	 * simplify for only one eio node
+	 * access eio registers directly rather than
+	 * use any_send hack method here
+	 */
+	raw_spin_lock_irqsave(&affinity_lock, flags);
+	iocsr_write32(EIOINTC_ALL_ENABLE & data, regaddr);
+	/*
+	 * get irq route info for continuous 4 vectors
+	 * and set affinity for specified vector
+	 */
+	data = iocsr_read32(EIOINTC_REG_ROUTE + (vector & ~3));
+	data &=  ~(0xff << ((vector & 3) * 8));
+	data |= coremap << ((vector & 3) * 8);
+	iocsr_write32(data, EIOINTC_REG_ROUTE + (vector & ~3));
+	iocsr_write32(EIOINTC_ALL_ENABLE, regaddr);
+	raw_spin_unlock_irqrestore(&affinity_lock, flags);
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+	return IRQ_SET_MASK_OK;
+}
+
 static int eiointc_index(int node)
 {
 	int i;
@@ -237,22 +279,39 @@ static struct irq_chip eiointc_irq_chip = {
 	.irq_set_affinity	= eiointc_set_irq_affinity,
 };
 
+static struct irq_chip eiointc_irq_chipi_single = {
+	.name			= "EIOINTC-S",
+	.irq_ack		= eiointc_ack_irq,
+	.irq_mask		= eiointc_mask_irq,
+	.irq_unmask		= eiointc_unmask_irq,
+#ifdef CONFIG_SMP
+	.irq_set_affinity       = eiointc_single_set_irq_affinity,
+#endif
+};
+
 static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
 	int ret;
 	unsigned int i, type;
 	unsigned long hwirq = 0;
-	struct eiointc *priv = domain->host_data;
+	struct eiointc_priv *priv = domain->host_data;
+	struct irq_chip *chip;
 
 	ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < nr_irqs; i++) {
-		irq_domain_set_info(domain, virq + i, hwirq + i, &eiointc_irq_chip,
+	/*
+	 * use simple irq route method for single node eiointc
+	 */
+	if ((nr_pics == 1) && (nodes_weight(priv->node_map) == 1))
+		chip = &eiointc_irq_chipi_single;
+	else
+		chip = &eiointc_irq_chip;
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, hwirq + i, chip,
 					priv, handle_edge_irq, NULL, NULL);
-	}
 
 	return 0;
 }
@@ -309,6 +368,7 @@ static void eiointc_resume(void)
 	int i, j;
 	struct irq_desc *desc;
 	struct irq_data *irq_data;
+	struct irq_chip *chip;
 
 	eiointc_router_init(0);
 
@@ -318,7 +378,8 @@ static void eiointc_resume(void)
 			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
 				raw_spin_lock(&desc->lock);
 				irq_data = irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
-				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
+				chip = irq_data_get_irq_chip(irq_data);
+				chip->irq_set_affinity(irq_data, irq_data->common->affinity, 0);
 				raw_spin_unlock(&desc->lock);
 			}
 		}
@@ -496,7 +557,13 @@ static int __init eiointc_of_init(struct device_node *of_node,
 	priv->node = 0;
 	priv->domain_handle = of_node_to_fwnode(of_node);
 
-	ret = eiointc_init(priv, parent_irq, 0);
+	/*
+	 * 2k0500 and 2k2000 has only one eio node
+	 * set nodemap as 1 for simple irq routing
+	 * what about for future embedded board more than 4 cpus??
+	 * nodemap and node need be added in dts like acpi table
+	 */
+	ret = eiointc_init(priv, parent_irq, 1);
 	if (ret < 0)
 		goto out_free_priv;
 
-- 
2.27.0

