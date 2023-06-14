Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4299F72FDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244381AbjFNMAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244413AbjFNL7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:59:51 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0FCA2126
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:59:41 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.116])
        by gateway (Coremail) with SMTP id _____8Cxd+mqq4lkyh0FAA--.8893S3;
        Wed, 14 Jun 2023 19:59:38 +0800 (CST)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.116])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxNeSoq4lkzJMaAA--.10424S6;
        Wed, 14 Jun 2023 19:59:38 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>,
        loongson-kernel@lists.loongnix.cn,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH V3 4/5] irqchip/loongson-liointc: Add IRQCHIP_SKIP_SET_WAKE flag
Date:   Wed, 14 Jun 2023 19:59:35 +0800
Message-Id: <20230614115936.5950-5-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230614115936.5950-1-lvjianmin@loongson.cn>
References: <20230614115936.5950-1-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxNeSoq4lkzJMaAA--.10424S6
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jw1DGFW3GrW8Jr4kCr4rWFX_yoWkurc_WF
        yxJws5uryftr4aka48Cr4UJrnYk3y5uan7ua1FvFs3Z348tw43Ca13Z3W3GFWUKryqyF93
        Gr4UWr4rAryxJosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7
        McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2Hq7UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yinbo Zhu <zhuyinbo@loongson.cn>

LIOINTC doesn't require specific logic to work with wakeup IRQs,
and no irq_set_wake callback is needed. To allow registered IRQs
from LIOINTC to be used as a wakeup-source, and ensure irq_set_irq_wake()
works well, the flag IRQCHIP_SKIP_SET_WAKE should be added.

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 5dd9db8f8fa8..e4b33aed1c97 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -295,6 +295,7 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
 	ct->chip.irq_set_type = liointc_set_type;
+	ct->chip.flags = IRQCHIP_SKIP_SET_WAKE;
 
 	gc->mask_cache = 0;
 	priv->gc = gc;
-- 
2.31.1

