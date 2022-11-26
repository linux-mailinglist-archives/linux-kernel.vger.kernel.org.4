Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1304F639624
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiKZNeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZNec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C83819033
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:31 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yw2+g2S+dV4R09fdSwSfX8T30y+JATdBOLxt9/8tVGs=;
        b=265U3cbXZjiBTKRmS2rIuO1kV7SKF7iiUz7L9xZZGXugj2VLY/GOG03RQNHYKxmZhbdAUD
        5+wqb5TGO6SWpw3HJvJNe0N2QAOhkK0gydITmuh4pGDGZN/JyaxTvnhcAq2NEf6v9X0ing
        ZSRaEd19U76/piNBldZcAJwZIkqFVwQ7d3Et2kGULILpQzxaQlHNAwNL5q4crVqBjMfUed
        p3hMVPs+BCbsVdbHwh4kbbgzq2/3Bi6QtP0/0Xm0xneUwHXxPFeoYlQj+9l2Z8Cj7IBL8x
        mvJySBSCXzXkjuOVuALeJ9YHi81/7ydkpTltRdzB5WxrUi3VIpJOTT1Vk9G3nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yw2+g2S+dV4R09fdSwSfX8T30y+JATdBOLxt9/8tVGs=;
        b=IHEjtgsuuuNYxZpQkG1ibGyxm8LPAfzq25xzzbRc6e7r35lauWpGZjyvY1kqdDnAnnrz7/
        d5AX4UnEWpXIENCw==
From:   "irqchip-bot for Aidan MacDonald" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/sl28cpld: Replace irqchip
 mask_invert with unmask_base
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221112152701.41990-1-aidanmacdonald.0x0@gmail.com>
References: <20221112152701.41990-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Message-ID: <166946966809.4906.9388873806018936021.tip-bot2@tip-bot2>
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

Commit-ID:     d502c558fd2b190c9125e8da54bef3f302fa9b15
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d502c558fd2b190c9125e8da54bef3f302fa9b15
Author:        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
AuthorDate:    Sat, 12 Nov 2022 15:27:01 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:29:52 

irqchip/sl28cpld: Replace irqchip mask_invert with unmask_base

Remove use of the deprecated mask_invert flag. Inverted mask
registers (where a '1' bit enables an IRQ) can be described more
directly as an unmask register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221112152701.41990-1-aidanmacdonald.0x0@gmail.com
---
 drivers/irqchip/irq-sl28cpld.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sl28cpld.c b/drivers/irqchip/irq-sl28cpld.c
index fbb3544..f217224 100644
--- a/drivers/irqchip/irq-sl28cpld.c
+++ b/drivers/irqchip/irq-sl28cpld.c
@@ -65,8 +65,7 @@ static int sl28cpld_intc_probe(struct platform_device *pdev)
 	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
 	irqchip->chip.num_regs = 1;
 	irqchip->chip.status_base = base + INTC_IP;
-	irqchip->chip.mask_base = base + INTC_IE;
-	irqchip->chip.mask_invert = true;
+	irqchip->chip.unmask_base = base + INTC_IE;
 	irqchip->chip.ack_base = base + INTC_IP;
 
 	return devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
