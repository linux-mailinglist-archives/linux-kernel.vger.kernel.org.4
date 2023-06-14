Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D0772FDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244436AbjFNMA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244443AbjFNL7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:59:54 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6202D2137
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:59:43 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.116])
        by gateway (Coremail) with SMTP id _____8Cxd+mrq4lkzx0FAA--.8894S3;
        Wed, 14 Jun 2023 19:59:39 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.116])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxNeSoq4lkzJMaAA--.10424S7;
        Wed, 14 Jun 2023 19:59:38 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        loongson-kernel@lists.loongnix.cn,
        yangqiming <yangqiming@loongson.cn>
Subject: [PATCH V3 5/5] irqchip/loongson-eiointc: Fix irq affinity setting during resume
Date:   Wed, 14 Jun 2023 19:59:36 +0800
Message-Id: <20230614115936.5950-6-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230614115936.5950-1-lvjianmin@loongson.cn>
References: <20230614115936.5950-1-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxNeSoq4lkzJMaAA--.10424S7
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF1xWw45Gr4DJF1xGry8JFc_yoW8Wr17pF
        W7C3Wq9rW5G34UXrZ0kr1UXa42yay5ZrZrta13XFWxZr98Ka1DKF1SkF1kuFZ2yr17AFyj
        vFWaq3yruF1DAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
        AwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
        JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU022NJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hierarchy of PCH PIC, PCH PCI MSI and EIONTC is as following:

        PCH PIC ------->|
                        |---->EIOINTC
        PCH PCI MSI --->|

so the irq_data list of irq_desc for IRQs on PCH PIC and PCH PCI MSI
is like this:

irq_desc->irq_data(domain: PCH PIC)->parent_data(domain: EIOINTC)
irq_desc->irq_data(domain: PCH PCI MSI)->parent_data(domain: EIOINTC)

In eiointc_resume(), the irq_data passed into eiointc_set_irq_affinity()
should be matched to EIOINTC domain instead of PCH PIC or PCH PCI MSI
domain, so fix it.

Fixes: a90335c2dfb4 ("irqchip/loongson-eiointc: Add suspend/resume support")

Reported-by: yangqiming <yangqiming@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 71ef19f77a5a..a7fcde3e3ecc 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -314,7 +314,7 @@ static void eiointc_resume(void)
 			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
 			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
 				raw_spin_lock(&desc->lock);
-				irq_data = &desc->irq_data;
+				irq_data = irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, irq_desc_get_irq(desc));
 				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
 				raw_spin_unlock(&desc->lock);
 			}
-- 
2.31.1

