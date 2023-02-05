Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A340268AF84
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 12:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBEL36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 06:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBEL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:29:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02765B1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 03:29:55 -0800 (PST)
Date:   Sun, 05 Feb 2023 11:29:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675596593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yjL/Z4iFc6CqJp/Zk4BmOcZSeCI08VlDLWSwmsCg3/k=;
        b=B2D1puvfUWID8aheZ3CfqRozv0l6GPpGQz2twqI9JpM1uYY1tYq8rWjVU8i+83/hOsZP0b
        pwGHeCQEVrGAkq+Ncw6QmSNaXA0obWjR0YhWM/7WQI/BpzwtfIQMRkwXjXvjBAeHXWWID+
        bfMF6Dsvtt1Prfh33wZ0TA4Ys1f8Lwt7IVofm8k/fV2N43VWOASyqUFUPyE4Z6huYsYOMX
        wsMzt4IH6rp0KFfoiYb8/Jb4WT4JKv/sVNqljML9y6WpfKiFiqKTKybCt9hmAappUjm/Ny
        GTaOMY7OR0SAw+QkQ/I+ygy1p+ecvW1TwNPFhHB/zDwN7Jmt0wSisZdY7zBXMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675596593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yjL/Z4iFc6CqJp/Zk4BmOcZSeCI08VlDLWSwmsCg3/k=;
        b=cjX9QIr+tksAjZqg1ZXnSE43GL7C8nIAUzyPLeiDILhWYWXTM2C30P2Z1o3y5OlLfqlhby
        M1X7vEoJAP0xn0Bg==
From:   "irqchip-bot for Miaoqian Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/alpine-msi: Fix refcount leak in
 alpine_msix_init_domains
Cc:     Miaoqian Lin <linmq006@gmail.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230102082811.3947760-1-linmq006@gmail.com>
References: <20230102082811.3947760-1-linmq006@gmail.com>
MIME-Version: 1.0
Message-ID: <167559659312.4906.6176942072338587443.tip-bot2@tip-bot2>
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

Commit-ID:     071d068b89e95d1b078aa6bbcb9d0961b77d6aa1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/071d068b89e95d1b078aa6bbcb9d0961b77d6aa1
Author:        Miaoqian Lin <linmq006@gmail.com>
AuthorDate:    Mon, 02 Jan 2023 12:28:10 +04:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 05 Feb 2023 11:11:24 

irqchip/alpine-msi: Fix refcount leak in alpine_msix_init_domains

of_irq_find_parent() returns a node pointer with refcount incremented,
We should use of_node_put() on it when not needed anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: e6b78f2c3e14 ("irqchip: Add the Alpine MSIX interrupt controller")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230102082811.3947760-1-linmq006@gmail.com
---
 drivers/irqchip/irq-alpine-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 5ddb8e5..fc1ef7d 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -199,6 +199,7 @@ static int alpine_msix_init_domains(struct alpine_msix_data *priv,
 	}
 
 	gic_domain = irq_find_host(gic_node);
+	of_node_put(gic_node);
 	if (!gic_domain) {
 		pr_err("Failed to find the GIC domain\n");
 		return -ENXIO;
