Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464A268C4D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBFRa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjBFRaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:30:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0786A5245
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:30:11 -0800 (PST)
Date:   Mon, 06 Feb 2023 17:30:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675704609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CFBCRdsDf0oDJduomNR7hJ7n93kuzTkx6Sy+Vjn70rQ=;
        b=2CURftn8TK9sw2G2lEB+RIFxZukDmAraD+4fH9MYDx7EGmIuHyKsaC9xtNIXw5/RWjqGGg
        XjAkbMNWUQxuKLRM453sar+v14n6lyHkAYDPs7mzMQNKHcwL2X5lXYU/+YOJftgGYeDh9+
        +PUnOZH+oViZCGWRrshN/ZX46qFz8NIf2NjB5LLHlVriZdH2qfzSSGJ1lz8g/WOSvDPJOi
        wQ2zvLVHa6GNmTCe1ksb0e1k3yglcyP4k3WXtBpRbbQFLfa0kBOKxY5EtVjX7F8I/p9DfZ
        HHa/V3UdS3vUvz92pYfvUnB1ec+4pXs+BrVSe0v0yZu2nEMzMggxo2xIKXtxxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675704609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CFBCRdsDf0oDJduomNR7hJ7n93kuzTkx6Sy+Vjn70rQ=;
        b=op2EkjFbzFFI6wp/oYSXkzFGiOrUSxGHswdeNzyzbk6CQKnkeMa+mky4+JawxEgHZsS3xH
        E+LrkrNHfe1XaaBA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq/ipi-mux: Use irq_domain_alloc_irqs()
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <167570460879.4906.13823581978207975292.tip-bot2@tip-bot2>
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

Commit-ID:     3d812a0f27baa2d094f2c18298d48b012878dc0b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3d812a0f27baa2d094f2c18298d48b012878dc0b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 06 Feb 2023 17:21:15 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 06 Feb 2023 17:21:15 

genirq/ipi-mux: Use irq_domain_alloc_irqs()

Using __irq_domain_alloc_irqs() is an unnecessary complexity. Use
irq_domain_alloc_irqs(), which is simpler and makes the code more
readable.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/ipi-mux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq/ipi-mux.c b/kernel/irq/ipi-mux.c
index 3a403c3..fa4fc18 100644
--- a/kernel/irq/ipi-mux.c
+++ b/kernel/irq/ipi-mux.c
@@ -185,8 +185,7 @@ int ipi_mux_create(unsigned int nr_ipi, void (*mux_send)(unsigned int cpu))
 	domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
 	irq_domain_update_bus_token(domain, DOMAIN_BUS_IPI);
 
-	rc = __irq_domain_alloc_irqs(domain, -1, nr_ipi,
-				     NUMA_NO_NODE, NULL, false, NULL);
+	rc = irq_domain_alloc_irqs(domain, nr_ipi, NUMA_NO_NODE, NULL);
 	if (rc <= 0) {
 		pr_err("unable to alloc IRQs from IPI Mux domain\n");
 		goto fail_free_domain;
