Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68DC6950D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjBMTks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjBMTko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:40:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048E946A2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:40:43 -0800 (PST)
Date:   Mon, 13 Feb 2023 19:40:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676317241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xO14wHwXOgLXvxWYFtIOhF7vSMZ9cOX/QwkmI9hSoE0=;
        b=2BqSS/ZVQh6nGSUbPn3XQCxIAqu271owkEht9fSCiCJWPeTfLk4Aku3IJso4mDIKpOIKvv
        JpUfHNpvKOa7u8HRQK6bdH7OJ4iOsRQ4HwUI37U7qQCgEi1AWe+70OaqNK9e309ybn16gV
        HrgqvgC5zD4IiU9r+alKI2euSE1KDSongrws9/faJQ8GVtQMqI/oACmgubaILecxOLFPzm
        +tU14KaweJUH2cNU0lb4E2NRo0cdEI17I86C+hzi5H1cy0jbaBHnlzOWoIxj/zlvddDBrZ
        alb3uJHoCEsqSzN7Z8EceRKxjKPNxItdIbsQ/A3AXQGHIOmr93paDtfLtfjsaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676317241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xO14wHwXOgLXvxWYFtIOhF7vSMZ9cOX/QwkmI9hSoE0=;
        b=gJ5zGxmAlJvBHln13P1mxGBgtMyQrdBJ+kFN2Np6hjo29I1+FRYxx+uSw7xTFTZY3vGvsW
        dqgvJbQfvOheBmCA==
From:   "irqchip-bot for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3-its: Use
 irq_domain_create_hierarchy()
Cc:     "Hsin-Yi Wang" <hsinyi@chromium.org>,
        "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230213104302.17307-17-johan+linaro@kernel.org>
References: <20230213104302.17307-17-johan+linaro@kernel.org>
MIME-Version: 1.0
Message-ID: <167631724131.4906.9954797080241580623.tip-bot2@tip-bot2>
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

Commit-ID:     1e46e040decede1723a5b11f0689942134c29d9a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1e46e040decede1723a5b11f0689942134c29d9a
Author:        Johan Hovold <johan+linaro@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 11:42:58 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 13 Feb 2023 19:31:25 

irqchip/gic-v3-its: Use irq_domain_create_hierarchy()

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Note that the domain host_data was first set to the struct its_node
during allocation only to immediately be overwritten with the struct
msi_domain_info.

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230213104302.17307-17-johan+linaro@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 973ede0..5634d29 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4909,18 +4909,19 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 	if (!info)
 		return -ENOMEM;
 
-	inner_domain = irq_domain_create_tree(handle, &its_domain_ops, its);
+	info->ops = &its_msi_domain_ops;
+	info->data = its;
+
+	inner_domain = irq_domain_create_hierarchy(its_parent,
+						   its->msi_domain_flags, 0,
+						   handle, &its_domain_ops,
+						   info);
 	if (!inner_domain) {
 		kfree(info);
 		return -ENOMEM;
 	}
 
-	inner_domain->parent = its_parent;
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	inner_domain->flags |= its->msi_domain_flags;
-	info->ops = &its_msi_domain_ops;
-	info->data = its;
-	inner_domain->host_data = info;
 
 	return 0;
 }
