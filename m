Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06447472A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjGDNV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjGDNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:21:20 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCDDF10E6;
        Tue,  4 Jul 2023 06:21:10 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8BxpPDFHKRkvQYAAA--.103S3;
        Tue, 04 Jul 2023 21:21:09 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbSPEHKRk7zYbAA--.34335S4;
        Tue, 04 Jul 2023 21:21:08 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH 2/2] irqchip/loongson-eiointc: simplify irq route on one eioi-node system
Date:   Tue,  4 Jul 2023 21:21:08 +0800
Message-Id: <20230704132108.1096940-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230704132108.1096940-1-maobibo@loongson.cn>
References: <20230704132108.1096940-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxbSPEHKRk7zYbAA--.34335S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF1kJrWUCw48ur18ZrWxZrc_yoWrZr4xpF
        WUGas0qr48Xay5XrZ3Gw4kZFyay3s3X3yDtF4fua97AFWY9a1vgF1FyFnrAF1jkryUAF1j
        yF43XFy8uF1DAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
        WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
        XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
        vjDU0xZFpf9x07jz2NtUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some LoongArch systems has only one eioi node such as 3A5000 machine
and qemu virt-machine. If there is only one eioi node, all cpus can
access eioi register directly; if there is multiple eioi nodes, cpus
can only access specified eioi node, so anysend or ipi need be used
to configure irq routing. IRQ routing is simple on such system with
one node, hacking method like anysend is not necessary.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Change-Id: I351e615ab15b79a1a3a4b96943a32c0ff5df2b13
---
 drivers/irqchip/irq-loongson-eiointc.c | 71 ++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 1c5a5b59f199..4759c0ae8edb 100644
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
+	if (nodes_weight(priv->node_map) == 1)
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
-- 
2.27.0

