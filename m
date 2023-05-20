Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52CD70A5FA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 08:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjETGih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 02:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjETGia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 02:38:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D5C21AC;
        Fri, 19 May 2023 23:38:28 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.176])
        by gateway (Coremail) with SMTP id _____8DxzOrkamhkB18KAA--.17949S3;
        Sat, 20 May 2023 14:38:28 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.176])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxFLXaamhkd1JrAA--.51105S5;
        Sat, 20 May 2023 14:38:27 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org
Subject: [PATCH V1 3/4] irqchip/loongson-liointc: Fix IRQ trigger polarity
Date:   Sat, 20 May 2023 14:38:17 +0800
Message-Id: <20230520063818.27208-4-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230520063818.27208-1-lvjianmin@loongson.cn>
References: <20230520063818.27208-1-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxFLXaamhkd1JrAA--.51105S5
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zw1rKF1ruw4xKr48Cr43GFg_yoW8Zw4fp3
        yfC3Wktr4aqFyUW3WUKr48X3W3AwnIq39rKa13W345uFZ0kan5A34ruFZFvr1xKa48GF4a
        krWrGay5Way3uwUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
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
        JbIYCTnIWIevJa73UjIFyTuYvjxUcYiiDUUUU
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For IRQ controller INT_POLARITY regitser of Loongson-2K CPU
series, '0' indicates high level or rising edge triggered IRQ,
'1' indicates low level or falling edge triggered IRQ.

For Loongson-3A CPU series, setting INT_POLARITY register is not
supported and writting it has no effect.

So trigger polarity setting shouled be fixed for Loongson-2K CPU
series.

Fixes: 17343d0b4039 ("irqchip/loongson-liointc: Support to set IRQ type for ACPI path")
Cc: stable@vger.kernel.org
Signed-off-by: Chong Qiao <qiaochong@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 8d00a9ad5b00..9a9c2bf048a3 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -116,19 +116,19 @@ static int liointc_set_type(struct irq_data *data, unsigned int type)
 	switch (type) {
 	case IRQ_TYPE_LEVEL_HIGH:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
 		break;
 	case IRQ_TYPE_EDGE_RISING:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, true);
-		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
+		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
 		break;
 	default:
 		irq_gc_unlock_irqrestore(gc, flags);
-- 
2.31.1

