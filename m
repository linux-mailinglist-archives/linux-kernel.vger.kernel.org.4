Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA50639633
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKZNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKZNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:35:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7D92180B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:47 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z+aAeOvcokyixQe3HMWUXwl0ngwH7WlfNDdh9p82BLM=;
        b=NYJfXhH6c1xpPWbIhzxbwEgl8qrRfYSghEpr94k3wG+sIomCJWw0OdZENrlVTkIccga4iS
        Yvsjl1Jgl40GM20KD8qKqlFPex3W/TukTGS0SUdF7KIyX/nuaeq0FgAZqan7L0cV/dt4Tl
        pzLDvnn42NfFMlUH6vhOvQSFQK3NLZ836LhfCOn0l4IdTuSggq2EOR0fGrumOtNgqBYmUE
        HhgvBCyUEJdUj69+5+uAPRK+mWDQaEB0TbCm2GXIK5/vq16BVRyL2vKkSiv30+We3hA8NU
        XhhnrdozCT7nyLgikrFyCJBF0mBZ8akiBXA++6HrS7UVwl2jHGKQE5Q6fTmdRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z+aAeOvcokyixQe3HMWUXwl0ngwH7WlfNDdh9p82BLM=;
        b=oBiWBLBPKrlmHbmx5/i4LD3BzBj7Ymq3lr6EGlCVuwq3QE0BFPiXaTXo4bwGlTI5fnoB/3
        7qu6ZPpTktiukXDQ==
From:   "irqchip-bot for Jianmin Lv" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] ACPI / PCI: fix LPIC IRQ model default
 PCI IRQ polarity
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221022075955.11726-2-lvjianmin@loongson.cn>
References: <20221022075955.11726-2-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <166946968496.4906.3078056706775236509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d0c50cc4b957b2cf6e43cec4998d212b5abe9220
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d0c50cc4b957b2cf6e43cec4998d212b5abe9220
Author:        Jianmin Lv <lvjianmin@loongson.cn>
AuthorDate:    Sat, 22 Oct 2022 15:59:52 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 12:57:18 

ACPI / PCI: fix LPIC IRQ model default PCI IRQ polarity

On LoongArch based systems, the PCI devices (e.g. SATA controllers and
PCI-to-PCI bridge controllers) in Loongson chipsets output high-level
interrupt signal to the interrupt controller they are connected (see
Loongson 7A1000 Bridge User Manual v2.00, sec 5.3, "For the bridge chip,
AC97 DMA interrupts are edge triggered, gpio interrupts can be configured
to be level triggered or edge triggered as needed, and the rest of the
interrupts are level triggered and active high."), while the IRQs are
active low from the perspective of PCI (see Conventional PCI spec r3.0,
sec 2.2.6, "Interrupts on PCI are optional and defined as level sensitive,
asserted low."), which means that the interrupt output of PCI devices plugged
into PCI-to-PCI bridges of Loongson chipset will be also converted to high-level.
So high level triggered type is required to be passed to acpi_register_gsi()
when creating mappings for PCI devices.

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221022075955.11726-2-lvjianmin@loongson.cn
---
 drivers/acpi/pci_irq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 08e1577..ff30cec 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -387,13 +387,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	u8 pin;
 	int triggering = ACPI_LEVEL_SENSITIVE;
 	/*
-	 * On ARM systems with the GIC interrupt model, level interrupts
+	 * On ARM systems with the GIC interrupt model, or LoongArch
+	 * systems with the LPIC interrupt model, level interrupts
 	 * are always polarity high by specification; PCI legacy
 	 * IRQs lines are inverted before reaching the interrupt
 	 * controller and must therefore be considered active high
 	 * as default.
 	 */
-	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
+	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ||
+		       acpi_irq_model == ACPI_IRQ_MODEL_LPIC ?
 				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
 	char *link = NULL;
 	char link_desc[16];
