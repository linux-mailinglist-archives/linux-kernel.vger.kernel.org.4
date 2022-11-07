Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC4E61E89A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 03:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiKGCeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 21:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKGCeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:34:16 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 076CA2BDC;
        Sun,  6 Nov 2022 18:34:13 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8Dxu9ihbmhjfO0EAA--.16207S3;
        Mon, 07 Nov 2022 10:34:09 +0800 (CST)
Received: from loongson-PC.loongson.cn (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxr+Ccbmhj2D0OAA--.40061S2;
        Mon, 07 Nov 2022 10:34:09 +0800 (CST)
From:   Liu Peibao <liupeibao@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] irqchip: loongarch-cpu: add DT support
Date:   Mon,  7 Nov 2022 10:34:03 +0800
Message-Id: <20221107023404.26730-1-liupeibao@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxr+Ccbmhj2D0OAA--.40061S2
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQABCmNmUmQAPwAGsA
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cw4fCw1fZFyUXryxAF48Crg_yoW8Jw13pa
        y7u3yavr1xJFnrWwn3C345Wr9Ivr1rK3y2qayfKa4Skrs8G34DZF10yF9xuFs5C3y3JF12
        9F18tF18uF15JFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoongArch is coming to support booting with FDT, so DT
support of this driver is desired.

Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
---
 drivers/irqchip/irq-loongarch-cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 741612ba6a52..a28b7c549654 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -92,6 +92,25 @@ static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+#ifdef CONFIG_OF
+int __init loongarch_cpu_irq_of_init(struct device_node *of_node,
+				struct device_node *parent)
+{
+	cpuintc_handle = of_node_to_fwnode(of_node);
+
+	irq_domain = irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
+				&loongarch_cpu_intc_irq_domain_ops, NULL);
+	if (!irq_domain)
+		panic("Failed to add irqdomain for loongarch CPU");
+
+	set_handle_irq(&handle_cpu_irq);
+
+	return 0;
+}
+IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller",
+					loongarch_cpu_irq_of_init);
+#endif
+
 static int __init
 liointc_parse_madt(union acpi_subtable_headers *header,
 		       const unsigned long end)
-- 
2.20.1

