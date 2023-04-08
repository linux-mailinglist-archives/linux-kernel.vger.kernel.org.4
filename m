Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFA86DBA39
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjDHKtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjDHKtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:49:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5354F113D1
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:48:44 -0700 (PDT)
Date:   Sat, 08 Apr 2023 10:45:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680950720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQoN1el7Rg83k5j+HcRFNlbKbOkdn6NvXnV3T7yJPDU=;
        b=ur+eMC1nMFV5mCQnd25gkuBth+w669U9v1LEX28RsMMM5WOyjO5oLp0iSmbC3C2DW1rFQQ
        /8e9/d2wRPs5hR3Yuh0ZHUpBINpMMlaOGheFJC+osLPrBwpqmzGYGuWkVlo618+9zXLwyp
        AWwhyy6q4/JEJJFzeT7wQNCOLQ5Ueg0pxK2NTY1HqEri0kbuUX9WiMkqAFqgGDO9z3Tv7R
        fH9y8nm9F0qkCCv4lbf/7Uch4p3R4DptmrWpSwB/7tM5L3KL8Tk+f5YXZ/miKksax9w5V6
        4sVTsJtL/RuXQ3W2X7tOaMV+pwTiSnjHcKEWhOaPYzylOOxVAsHIZD52H6Axcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680950720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQoN1el7Rg83k5j+HcRFNlbKbOkdn6NvXnV3T7yJPDU=;
        b=CVyoyFjAkSRMlqp35+nu2xWqP9cM98A2WzfvP0+9zZ0RxTuEDDMyIxXtYSiPJQjOT/o9hk
        fLa8QhU87oIj9AAQ==
From:   "irqchip-bot for Rob Herring" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip: Use of_property_read_bool() for
 boolean properties
Cc:     Rob Herring <robh@kernel.org>, Guo Ren <guoren@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230310144710.1543070-1-robh@kernel.org>
References: <20230310144710.1543070-1-robh@kernel.org>
MIME-Version: 1.0
Message-ID: <168095072029.404.13607319176829594584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9dfc77917e3b82dc7f93d62cebf1ebb885e9cc6a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9dfc77917e3b82dc7f93d62cebf1ebb885e9cc6a
Author:        Rob Herring <robh@kernel.org>
AuthorDate:    Fri, 10 Mar 2023 08:47:10 -06:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Apr 2023 11:07:49 +01:00

irqchip: Use of_property_read_bool() for boolean properties

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Guo Ren <guoren@kernel.org> (csky)
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230310144710.1543070-1-robh@kernel.org
---
 drivers/irqchip/irq-csky-apb-intc.c | 2 +-
 drivers/irqchip/irq-gic-v2m.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index 42d8a24..6710691 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -68,7 +68,7 @@ static void __init ck_set_gc(struct device_node *node, void __iomem *reg_base,
 	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
 	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
 
-	if (of_find_property(node, "csky,support-pulse-signal", NULL))
+	if (of_property_read_bool(node, "csky,support-pulse-signal"))
 		gc->chip_types[0].chip.irq_unmask = irq_ck_mask_set_bit;
 }
 
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f1e75b3..f2ff438 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -421,7 +421,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 		u32 spi_start = 0, nr_spis = 0;
 		struct resource res;
 
-		if (!of_find_property(child, "msi-controller", NULL))
+		if (!of_property_read_bool(child, "msi-controller"))
 			continue;
 
 		ret = of_address_to_resource(child, 0, &res);
