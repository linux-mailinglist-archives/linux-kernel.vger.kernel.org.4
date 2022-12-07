Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D8164516D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLGBqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiLGBqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:46:07 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4112F4D5F6;
        Tue,  6 Dec 2022 17:46:02 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8CxZPBZ8I9jybQDAA--.8534S3;
        Wed, 07 Dec 2022 09:46:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_eFU8I9jo_omAA--.30148S2;
        Wed, 07 Dec 2022 09:46:00 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v1] irqchip: loongson-liointc: add hierarchy irq support
Date:   Wed,  7 Dec 2022 09:45:55 +0800
Message-Id: <20221207014555.22465-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_eFU8I9jo_omAA--.30148S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF43GF43GrW7Xr47Ar1UJrb_yoW8tryfpF
        4rAwnFvr45Jw42gw43CF1DX34akFWFqrZFyayfKF9rZFs8J3s5CF1ruFnF9r4akr1UG3WU
        ZFn7XFWruF45JaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b78Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
        6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
        UvcSsGvfC2KfnxnUUI43ZEXa7IU1tl1PUUUUU==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the irq of hierarchical interrupt chip was routed to liointc
that asked liointc driver to support hierarchy irq and this patch
was to add such support.

In addition, this patch only consider dts, and acpi hierarchy irq
support will be added later as required.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 0da8716f8f24..58e43a2cd02e 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -177,6 +177,32 @@ static const struct irq_domain_ops acpi_irq_gc_ops = {
 	.xlate	= liointc_domain_xlate,
 };
 
+#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+static int liointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_map_generic_chip(domain, virq + i, hwirq + i);
+
+	return 0;
+}
+
+static const struct irq_domain_ops of_irq_gc_ops = {
+	.translate	= irq_domain_translate_twocell,
+	.alloc		= liointc_domain_alloc,
+	.free		= irq_domain_free_irqs_top,
+};
+#endif
+
 static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 		struct fwnode_handle *domain_handle, struct device_node *node)
 {
@@ -218,8 +244,13 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
 					&acpi_irq_gc_ops, priv);
 	else
+#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
+					&of_irq_gc_ops, priv);
+#else
 		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
 					&irq_generic_chip_ops, priv);
+#endif
 	if (!domain) {
 		pr_err("loongson-liointc: cannot add IRQ domain\n");
 		goto out_iounmap;
-- 
2.31.1

