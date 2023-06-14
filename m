Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4AB72FC29
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjFNLOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjFNLOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:14:31 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 142F71BE5;
        Wed, 14 Jun 2023 04:14:29 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.116])
        by gateway (Coremail) with SMTP id _____8Cx8OgUoYlkRBoFAA--.8923S3;
        Wed, 14 Jun 2023 19:14:28 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.116])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx+OQSoYlk_IkaAA--.10128S4;
        Wed, 14 Jun 2023 19:14:28 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        loongson-kernel@lists.loongnix.cn,
        Liu Peibao <liupeibao@loongson.cn>, stable@vger.kernel.org
Subject: [PATCH V1 2/4] irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment
Date:   Wed, 14 Jun 2023 19:14:24 +0800
Message-Id: <20230614111426.5545-3-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230614111426.5545-1-lvjianmin@loongson.cn>
References: <20230614111426.5545-1-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx+OQSoYlk_IkaAA--.10128S4
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF48ZrWxXFWfGr4kXw47Awc_yoW8Cr1kpF
        4UCw4S9F4DAF1jyw18Gw4kW343A39xtFW7Ka1SyF93Wr1kJ34qkF1UZF1F9r1kArWfAFWU
        ZrZI9FWY9F1xAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14v3UUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Peibao <liupeibao@loongson.cn>

In DeviceTree path, when ht_vec_base is not zero, the hwirq of PCH PIC will
be assigned incorrectly. Because when pch_pic_domain_translate() adds the
ht_vec_base to hwirq, the hwirq dose not subtract the ht_vec_base when
calling irq_domain_set_info().

The ht_vec_base is designed for the parent irq chip/domain of the PCH PIC.
It seems not proper to deal this in callbacks of the PCH PIC domain and
let's put this back like the initial commit ef8c01eb64ca ("irqchip: Add
Loongson PCH PIC controller").

Fixes: bcdd75c596c8 ("irqchip/loongson-pch-pic: Add ACPI init support")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-pic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 921c5c0190d1..93a71f66efeb 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -164,7 +164,7 @@ static int pch_pic_domain_translate(struct irq_domain *d,
 		if (fwspec->param_count < 2)
 			return -EINVAL;
 
-		*hwirq = fwspec->param[0] + priv->ht_vec_base;
+		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	} else {
 		if (fwspec->param_count < 1)
@@ -196,7 +196,7 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
 
 	parent_fwspec.fwnode = domain->parent->fwnode;
 	parent_fwspec.param_count = 1;
-	parent_fwspec.param[0] = hwirq;
+	parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
 
 	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
 	if (err)
-- 
2.31.1

