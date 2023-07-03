Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B82746326
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGCTAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjGCTAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:00:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190C9E6B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:00:30 -0700 (PDT)
Date:   Mon, 03 Jul 2023 19:00:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688410828;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKhXlmbNlkSzh7GXP62fqrW0/HPTfBTzxq98qGCo0nU=;
        b=jKxybCFzzcdPtLRCJ37twNCwgQ1iAYUVWhoH7Sb6zWpugXxZ4MMiioegI0SzDiR4Dyo5TN
        FPfHIV6T2pWVRmd+vPEMtaztI64+ogpJhQHI4L9WYPSZvKNLU6ewtOohNsin7tSCG3Vphm
        IMuLZ+2ZEuLbV2qonhmevZOFRTUZ8DR7UBMEd8JBnpAuFGDgs52A4YmR/77M0Ihn8FYKE5
        jA6Mxy7qN0DTnoh+VjfrR/1QQ7/DnbLpYuDlLrZq+R8RbYUzi/bbnU2j45ktuD27Wa0Ah9
        NGW1kASYw1DiyQkxsZfyJbaP4NBbU2gfWD51tcysMwozKgi73wMSGTYOjHlrfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688410828;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKhXlmbNlkSzh7GXP62fqrW0/HPTfBTzxq98qGCo0nU=;
        b=AxRnJLj/HPe1Xnxe9odqWWubGJ6mDfg4k6JA6GjYKzwz9z0VKBHsAUsazXrlguNkesJr3P
        cssYPH2pX6kSzNCA==
From:   "irqchip-bot for Jonas Gorski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irq-bcm6345-l1: Do not assume a fixed
 block to cpu mapping
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, philmd@linaro.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230629072620.62527-1-jonas.gorski@gmail.com>
References: <20230629072620.62527-1-jonas.gorski@gmail.com>
MIME-Version: 1.0
Message-ID: <168841082817.404.2381514452871552922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irq=
chip:

Commit-ID:     55ad24857341c36616ecc1d9580af5626c226cf1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/55ad24857341c36616ecc1d9580af5626c226cf1
Author:        Jonas Gorski <jonas.gorski@gmail.com>
AuthorDate:    Thu, 29 Jun 2023 09:26:20 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 03 Jul 2023 19:47:51 +01:00

irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

The irq to block mapping is fixed, and interrupts from the first block
will always be routed to the first parent IRQ. But the parent interrupts
themselves can be routed to any available CPU.

This is used by the bootloader to map the first parent interrupt to the
boot CPU, regardless wether the boot CPU is the first one or the second
one.

When booting from the second CPU, the assumption that the first block's
IRQ is mapped to the first CPU breaks, and the system hangs because
interrupts do not get routed correctly.

Fix this by passing the appropriate bcm6434_l1_cpu to the interrupt
handler instead of the chip itself, so the handler always has the right
block.

Fixes: c7c42ec2baa1 ("irqchips/bmips: Add bcm6345-l1 interrupt controller")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230629072620.62527-1-jonas.gorski@gmail.com
---
 drivers/irqchip/irq-bcm6345-l1.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l=
1.c
index fa113cb..6341c01 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -82,6 +82,7 @@ struct bcm6345_l1_chip {
 };
=20
 struct bcm6345_l1_cpu {
+	struct bcm6345_l1_chip	*intc;
 	void __iomem		*map_base;
 	unsigned int		parent_irq;
 	u32			enable_cache[];
@@ -115,17 +116,11 @@ static inline unsigned int cpu_for_irq(struct bcm6345_l=
1_chip *intc,
=20
 static void bcm6345_l1_irq_handle(struct irq_desc *desc)
 {
-	struct bcm6345_l1_chip *intc =3D irq_desc_get_handler_data(desc);
-	struct bcm6345_l1_cpu *cpu;
+	struct bcm6345_l1_cpu *cpu =3D irq_desc_get_handler_data(desc);
+	struct bcm6345_l1_chip *intc =3D cpu->intc;
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	unsigned int idx;
=20
-#ifdef CONFIG_SMP
-	cpu =3D intc->cpus[cpu_logical_map(smp_processor_id())];
-#else
-	cpu =3D intc->cpus[0];
-#endif
-
 	chained_irq_enter(chip, desc);
=20
 	for (idx =3D 0; idx < intc->n_words; idx++) {
@@ -253,6 +248,7 @@ static int __init bcm6345_l1_init_one(struct device_node =
*dn,
 	if (!cpu)
 		return -ENOMEM;
=20
+	cpu->intc =3D intc;
 	cpu->map_base =3D ioremap(res.start, sz);
 	if (!cpu->map_base)
 		return -ENOMEM;
@@ -271,7 +267,7 @@ static int __init bcm6345_l1_init_one(struct device_node =
*dn,
 		return -EINVAL;
 	}
 	irq_set_chained_handler_and_data(cpu->parent_irq,
-						bcm6345_l1_irq_handle, intc);
+						bcm6345_l1_irq_handle, cpu);
=20
 	return 0;
 }
