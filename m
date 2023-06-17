Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B4733EFA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjFQHCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFQHCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:02:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83809199F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:02:48 -0700 (PDT)
Date:   Sat, 17 Jun 2023 07:02:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686985367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6HC5wxQcIEqAgSQJdb+UHn0VmVyLap03X1VIiek8n0=;
        b=T+js6W1HnY8TYaiyhLEu0eJnKbvr33ciR71ohSJfhLKCuJQHe0zLB25CNlnZEI3imZCkWE
        Rv/LWwY4FAgmh8+X+o250R+/6nBoQYDzuBJS3iWM8I2NY5zm6YnTlmovbg/wk33zUygnWo
        DvltwBtvD4QVd4DzyPGXSwvaLbNXGRoCaDyu3t5VcbbI+vUkF9IvLLIaWpaE0017Qr0lDL
        9cgYYyH4uYa5n+SIRRJ/uXO2wnmOzcjPLtVubAXwF+qbEYb6Fzb+iqSh64FgBb8MV6w96d
        R6kgSByhvnvhArcukl/TmdBphJhSss/RoidRZ3M9jtcrhj3lpQFkhYMBYm4NuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686985367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6HC5wxQcIEqAgSQJdb+UHn0VmVyLap03X1VIiek8n0=;
        b=/+EtQbT6+8pK0YopFX5C8mU7LzxT2AcaRCgeqMX5VpxiNjwZQoLx3YqBteENpcHAU2opx8
        /XD+Rm5UhaTIkWAQ==
From:   "irqchip-bot for John Paul Adrian Glaubitz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/jcore-aic: Fix missing allocation
 of IRQ descriptors
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rob Landley <rob@landley.net>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
References: <20230510163343.43090-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Message-ID: <168698536627.404.550156100246054585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4848229494a323eeaab62eee5574ef9f7de80374
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4848229494a323eeaab62eee5574ef9f7de80374
Author:        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
AuthorDate:    Wed, 10 May 2023 18:33:42 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 17 Jun 2023 07:54:48 +01:00

irqchip/jcore-aic: Fix missing allocation of IRQ descriptors

The initialization function for the J-Core AIC aic_irq_of_init() is
currently missing the call to irq_alloc_descs() which allocates and
initializes all the IRQ descriptors. Add missing function call and
return the error code from irq_alloc_descs() in case the allocation
fails.

Fixes: 981b58f66cfc ("irqchip/jcore-aic: Add J-Core AIC driver")
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Tested-by: Rob Landley <rob@landley.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230510163343.43090-1-glaubitz@physik.fu-berlin.de
---
 drivers/irqchip/irq-jcore-aic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 5f47d8e..b9dcc8e 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
 	unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
 	unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
 	struct irq_domain *domain;
+	int ret;
 
 	pr_info("Initializing J-Core AIC\n");
 
@@ -100,6 +101,12 @@ static int __init aic_irq_of_init(struct device_node *node,
 	jcore_aic.irq_unmask = noop;
 	jcore_aic.name = "AIC";
 
+	ret = irq_alloc_descs(-1, min_irq, dom_sz - min_irq,
+			      of_node_to_nid(node));
+
+	if (ret < 0)
+		return ret;
+
 	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
 				       &jcore_aic_irqdomain_ops,
 				       &jcore_aic);
