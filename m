Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B14647CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLIEJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 23:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLIEJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 23:09:02 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C5D36ACCF;
        Thu,  8 Dec 2022 20:08:50 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8Dx9vB_rJJjg1IEAA--.9934S3;
        Fri, 09 Dec 2022 11:33:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxd1d2rJJjbdsoAA--.16617S2;
        Fri, 09 Dec 2022 11:33:19 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn
Subject: [PATCH v2] irqchip: loongson-liointc: add hierarchy irq support
Date:   Fri,  9 Dec 2022 11:33:09 +0800
Message-Id: <20221209033309.4374-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxd1d2rJJjbdsoAA--.16617S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXFy3KrWrXr47Cw15JF4kCrg_yoWrJr1UpF
        4Fy3sFqrWUJayUXr47Cw1kWa4ak3yftrZrtayfWF9rZ3WDGr95uFW8uF9F9r1YkryUGF1j
        vF4fWay8ua15AaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
        6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UYxBIdaVFxhVjvjDU0xZFpf9x07U_uc_UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the irq of hierarchical interrupt chip was routed to liointc
that asked liointc driver to support hierarchy irq and this patch
was to add such support.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v2:
		1. Keep consistent approach for irq handle of dts and acpi.
		2. Use a domain to cover all case.
		3. Fixup the commit log.

 drivers/irqchip/Kconfig                |  1 +
 drivers/irqchip/irq-loongson-liointc.c | 53 +++++++++++++++++---------
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d07568a2c539..97f589d681c6 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -593,6 +593,7 @@ config LOONGSON_LIOINTC
 	default y
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
 	help
 	  Support for the Loongson Local I/O Interrupt Controller.
 
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 85b754f7f4e6..e5670cc6123a 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -160,26 +160,48 @@ static u32 parent_int_map[LIOINTC_NUM_PARENT];
 static const char *const parent_names[] = {"int0", "int1", "int2", "int3"};
 static const char *const core_reg_names[] = {"isr0", "isr1", "isr2", "isr3"};
 
-static int liointc_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
-			     const u32 *intspec, unsigned int intsize,
-			     unsigned long *out_hwirq, unsigned int *out_type)
+static int liointc_irq_domain_translate(struct irq_domain *d,
+			struct irq_fwspec *fwspec, unsigned long *out_hwirq,
+			unsigned int *out_type)
 {
-	if (WARN_ON(intsize < 1))
+	if (WARN_ON(fwspec->param_count < 1))
 		return -EINVAL;
-	*out_hwirq = intspec[0] - GSI_MIN_CPU_IRQ;
 
-	if (intsize > 1)
-		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+	if (!acpi_disabled)
+		*out_hwirq = fwspec->param[0] - GSI_MIN_CPU_IRQ;
+	else
+		*out_hwirq = fwspec->param[0];
+
+	if (fwspec->param_count > 1)
+		*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	else
 		*out_type = IRQ_TYPE_NONE;
 
 	return 0;
 }
 
-static const struct irq_domain_ops acpi_irq_gc_ops = {
-	.map	= irq_map_generic_chip,
-	.unmap  = irq_unmap_generic_chip,
-	.xlate	= liointc_domain_xlate,
+static int liointc_irq_domain_alloc(struct irq_domain *domain,
+		unsigned int virq, unsigned int nr_irqs, void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = liointc_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_map_generic_chip(domain, virq + i, hwirq + i);
+
+	return 0;
+}
+
+static const struct irq_domain_ops irq_gc_ops = {
+	.translate = liointc_irq_domain_translate,
+	.alloc     = liointc_irq_domain_alloc,
+	.free      = irq_domain_free_irqs_top,
 };
 
 static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
@@ -222,12 +244,9 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 	}
 
 	/* Setup IRQ domain */
-	if (!acpi_disabled)
-		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
-					&acpi_irq_gc_ops, priv);
-	else
-		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
-					&irq_generic_chip_ops, priv);
+	domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
+					  &irq_gc_ops, priv);
+
 	if (!domain) {
 		pr_err("loongson-liointc: cannot add IRQ domain\n");
 		goto out_iounmap;
-- 
2.20.1

