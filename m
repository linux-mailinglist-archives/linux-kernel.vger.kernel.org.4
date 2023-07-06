Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D507493C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 04:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjGFC26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 22:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjGFC2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 22:28:53 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3B77DA;
        Wed,  5 Jul 2023 19:28:51 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8CxbeviJqZkHbQAAA--.347S3;
        Thu, 06 Jul 2023 10:28:50 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjiPhJqZktK8dAA--.49030S4;
        Thu, 06 Jul 2023 10:28:50 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 2/2] irqchip/loongson-eiointc: Simplify irq route on one eioi-node system
Date:   Thu,  6 Jul 2023 10:28:49 +0800
Message-Id: <20230706022849.1272591-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230706022849.1272591-1-maobibo@loongson.cn>
References: <20230706022849.1272591-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiPhJqZktK8dAA--.49030S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF1fKFWxJFyUCr18tFyrAFc_yoW7JrWUpF
        WUCas0qr48Jay5WrZakw4DZFyay3s3X3yDtF4fuayxAayY9a1qgF1FyFnrAF1jkryUAF1Y
        yF47XFy8uF1DAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
        6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU8EeHDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some LoongArch systems has only one eioi node such as 3A5000/2K2000
and qemu virt machine. If there is only one eioi node, all cpus can
access eioi register directly; if there is multiple eioi nodes, cpus
can only access specified eioi node, so anysend or ipi need be used
to configure irq routing. IRQ routing is simple on such system with
one node, hacking method like anysend is not necessary.

This patch is tested on 3A5000 board and qemu virt machine.

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

