Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3027C5EDDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiI1Nhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiI1NhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:37:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D28F94A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:37:23 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:37:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664372242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyWsaM00jEwIygiWh5DBam3Hhuki93uWWEdb1ZJONcY=;
        b=lwAMSYIneadlnVVnJB8RBa9AE/vlDyixp3NSPsD+ibmYdPy/mncFz4uvwTtdHOlmCVRTDE
        DlX6NRTN/16U/9mIG1JC5Zg+hgHiyO+1x6mecg4QGzEStmQOe72IA9S0ktNCZuLWyyGcil
        QRGRSH2do4BAW64EIM2Ewp8yh8r61la5tl+2F+o022a5hGzHZXQlQN9CjyQ5fGsUXXl00T
        eNGKWYvdSOcIzHH3X5P+7iasNPx8VYNcTis/5PyWZnu0xgh34W5kr2zdRncvJPPY+P6VMI
        gdZDeoKp+/PlD3a3SfYYkXUWqIvalpyEuyd+/5pVFGG4UyFZ/XCKYfbAronCbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664372242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyWsaM00jEwIygiWh5DBam3Hhuki93uWWEdb1ZJONcY=;
        b=tJc2SaEqdfj1UCp7iP/ArwVUEBvnC+csp9T6UaIxMRlbXhjjJLlJuxqdgcOd3F2JzbYBTV
        7tw+Id4JlPqlXYDw==
From:   "irqchip-bot for Sander Vanheule" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/realtek-rtl: use irq_domain_add_linear()
Cc:     Sander Vanheule <sander@svanheule.net>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C0c4cd9f7661a30a4cb7ab9881c4a94bc8a379162=2E16636?=
 =?utf-8?q?17425=2Egit=2Esander=40svanheule=2Enet=3E?=
References: =?utf-8?q?=3C0c4cd9f7661a30a4cb7ab9881c4a94bc8a379162=2E166361?=
 =?utf-8?q?7425=2Egit=2Esander=40svanheule=2Enet=3E?=
MIME-Version: 1.0
Message-ID: <166437224118.401.7829396877307953721.tip-bot2@tip-bot2>
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

Commit-ID:     a1cc8a62c2b21d6d71d5a3d5d7c7658e3ab42d47
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a1cc8a62c2b21d6d71d5a3d5d7c7658e3ab42d47
Author:        Sander Vanheule <sander@svanheule.net>
AuthorDate:    Mon, 19 Sep 2022 22:24:41 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 28 Sep 2022 14:17:10 +01:00

irqchip/realtek-rtl: use irq_domain_add_linear()

When using an offset of 0, irq_domain_add_simple() is identical to
irq_domain_add_linear() on DT-based systems, so use the latter instead.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/0c4cd9f7661a30a4cb7ab9881c4a94bc8a379162.1663617425.git.sander@svanheule.net
---
 drivers/irqchip/irq-realtek-rtl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 56bf502..160feae 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -171,8 +171,7 @@ static int __init realtek_rtl_of_init(struct device_node *node, struct device_no
 	/* Disable all cascaded interrupts */
 	writel(0, REG(RTL_ICTL_GIMR));
 
-	domain = irq_domain_add_simple(node, 32, 0,
-				       &irq_domain_ops, NULL);
+	domain = irq_domain_add_linear(node, 32, &irq_domain_ops, NULL);
 
 	ret = map_interrupts(node, domain);
 	if (ret) {
