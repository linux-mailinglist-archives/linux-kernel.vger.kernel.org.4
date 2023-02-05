Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED89068AF85
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 12:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBELaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 06:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBEL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:29:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A956E1E5E6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 03:29:55 -0800 (PST)
Date:   Sun, 05 Feb 2023 11:29:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675596592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mP3XJsTShQL14hAC+mnjW3TmxZmxPDuuvtQahw08qMo=;
        b=LKw/e55/tpjYTJOaM0hxZcb1hJHTjblWzVlg82iMZARZgsmkoE79yJ0neH8HCmAwwBHKop
        LwQ/eDW/gvF/NRwj2YAJjdd/S3YaRJ5oXrEraBX7A67NhHM/RIQcbg3oQ7BaAhm6jB0ZXG
        2TjpGEGvZDPvMw7wOx1KwdMGuCh+ODGG56bNJNdlDsbt/Z8letS6/+TtrfBYuqFcYv7UmO
        hq2LwXr5LYvmIWbotn8bxECwzLpuG+WdoXZBSAcDxcUxRQSpU+caJ8NiTiWEltNXBu0LLq
        C18yqHnYEPAExpi7zX32t0RzQsNl+gMFpS9vOoXi+hExk79Oz0OrNNuIpZCieg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675596592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mP3XJsTShQL14hAC+mnjW3TmxZmxPDuuvtQahw08qMo=;
        b=t+dx30LQf4QZvBYHW4j4+u+Bo1QHI/pB3Lsyc1IAlVlp+aKQPdH4tQUoYMKjby1OZ96ID8
        /VKxkmnFy2CxgEBA==
From:   "irqchip-bot for Miaoqian Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ti-sci: Fix refcount leak in
 ti_sci_intr_irq_domain_probe
Cc:     Miaoqian Lin <linmq006@gmail.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230102085611.3955984-1-linmq006@gmail.com>
References: <20230102085611.3955984-1-linmq006@gmail.com>
MIME-Version: 1.0
Message-ID: <167559659238.4906.13590911560182651325.tip-bot2@tip-bot2>
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

Commit-ID:     02298b7bae12936ca313975b02e7f98b06670d37
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/02298b7bae12936ca313975b02e7f98b06670d37
Author:        Miaoqian Lin <linmq006@gmail.com>
AuthorDate:    Mon, 02 Jan 2023 12:56:10 +04:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 05 Feb 2023 11:11:24 

irqchip/ti-sci: Fix refcount leak in ti_sci_intr_irq_domain_probe

of_irq_find_parent() returns a node pointer with refcount incremented,
We should use of_node_put() on it when not needed anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: cd844b0715ce ("irqchip/ti-sci-intr: Add support for Interrupt Router driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230102085611.3955984-1-linmq006@gmail.com
---
 drivers/irqchip/irq-ti-sci-intr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index fe8fad2..020ddf2 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -236,6 +236,7 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 	}
 
 	parent_domain = irq_find_host(parent_node);
+	of_node_put(parent_node);
 	if (!parent_domain) {
 		dev_err(dev, "Failed to find IRQ parent domain\n");
 		return -ENODEV;
