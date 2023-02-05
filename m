Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B6268AF87
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 12:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBELaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 06:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBEL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:29:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C90F1A49D
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 03:29:55 -0800 (PST)
Date:   Sun, 05 Feb 2023 11:29:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675596593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2TicbofqkAmxUjRzC+2PbdREpPAkt1O6GQO28HW9+A8=;
        b=ob6VqVCuIV25IdHgrFJbrtQHkmQQNEcLvA3O9LrASZ7bqwO9C5F6arzBY+DySOlpY7iHby
        9RWNXGmP9uo2VeDgDuUuqvmNErzPm2mO0hykXQB80A8vJ/ecCR9gpWngl/tiMNGsDXyH9+
        +37gns+3IYlApeilbaI/3wbwhE8rbSShtIKZkj2TA4sAyc4RqqLYqEFgtiraQeKa2gvooS
        v90DTNUU/7Pw8WcHUC1/2z9lEfmNnHDvM6tKOU050bjZ25DecwjEUk4VOeb17zuKgvKnrD
        1H1Oc030muFpYi6N3zFFE1eqpPjPO3oz1CPOo95hvdQv2+vzW0bHHFrdYIrY3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675596593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2TicbofqkAmxUjRzC+2PbdREpPAkt1O6GQO28HW9+A8=;
        b=/0LlyogzI2v9yiXRadh9FIZc9vgrJByTU2raDzymQw/gmNfS5Iw0H5oM1Zp2vxRGLHZmyf
        QJEVi0b4/T83csDw==
From:   "irqchip-bot for Miaoqian Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-mvebu-gicp: Fix refcount leak
 in mvebu_gicp_probe
Cc:     Miaoqian Lin <linmq006@gmail.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230102084208.3951758-1-linmq006@gmail.com>
References: <20230102084208.3951758-1-linmq006@gmail.com>
MIME-Version: 1.0
Message-ID: <167559659275.4906.14558130983699966637.tip-bot2@tip-bot2>
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

Commit-ID:     9419e700021a393f67be36abd0c4f3acc6139041
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9419e700021a393f67be36abd0c4f3acc6139041
Author:        Miaoqian Lin <linmq006@gmail.com>
AuthorDate:    Mon, 02 Jan 2023 12:42:08 +04:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 05 Feb 2023 11:11:24 

irqchip/irq-mvebu-gicp: Fix refcount leak in mvebu_gicp_probe

of_irq_find_parent() returns a node pointer with refcount incremented,
We should use of_node_put() on it when not needed anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: a68a63cb4dfc ("irqchip/irq-mvebu-gicp: Add new driver for Marvell GICP")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230102084208.3951758-1-linmq006@gmail.com
---
 drivers/irqchip/irq-mvebu-gicp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index fe88a78..c43a345 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -221,6 +221,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 	}
 
 	parent_domain = irq_find_host(irq_parent_dn);
+	of_node_put(irq_parent_dn);
 	if (!parent_domain) {
 		dev_err(&pdev->dev, "failed to find parent IRQ domain\n");
 		return -ENODEV;
