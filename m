Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7050363A770
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiK1LyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiK1LyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:54:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64608BE24
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:54:01 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:53:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669636439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7Dj4YRn/F1RC7Yk4YJJYULL90/HqhKhsQ2qPWq7Zzo=;
        b=bdVhoYal1btiDi1BptSWh3gjNbTxnasoVQJh7zDMSv8UsIdqwYnxwS8zDlhNul9f9ycjC3
        ZRQItryCUsLtctS9+dCnO/a2JOpyBNQQ4lqgc4RgiJ1d4NfyNj6MCmwgnf5lQjcxV9UkSq
        3lyXcpep8KinPeBopN5NWACPmRYBmswnwumiAtbYgEqqBiWCvJ+UbmqAkHycthTQKXellM
        zG0heZqxvyNOv3LwLrHVvNJCHbepPok5ywrXWsgo85/WKY4KGmMy0cC2fjENm5YaItf6Mc
        UqpJXg9OUhWB294+xz69qQeW3v7Y/fPMjrpYEdqE0+lzlT+bn8e+zLto7b9qTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669636439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7Dj4YRn/F1RC7Yk4YJJYULL90/HqhKhsQ2qPWq7Zzo=;
        b=7iXMX0Fv8iTqfeMyuA+BcfvUXOfoK5ruXkzH+yEygzMciMDAyxp/hNZXC6sg1G/TZVssCj
        TRRADpRncnT1eKDA==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/sifive-plic: Support wake IRQs
Cc:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221126194805.19431-1-samuel@sholland.org>
References: <20221126194805.19431-1-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <166963643864.4906.15315016442741987261.tip-bot2@tip-bot2>
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

Commit-ID:     f5259b045c19f6e997bd12d53a5f76663537c1fd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f5259b045c19f6e997bd12d53a5f76663537c1fd
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Sat, 26 Nov 2022 13:48:05 -06:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 28 Nov 2022 09:44:24 

irqchip/sifive-plic: Support wake IRQs

The PLIC does not define any special method for marking interrupts as
wakeup-capable, so it should have the IRQCHIP_SKIP_SET_WAKE flag set.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221126194805.19431-1-samuel@sholland.org
---
 drivers/irqchip/irq-sifive-plic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 2f47848..ff47bd0 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -187,7 +187,8 @@ static struct irq_chip plic_edge_chip = {
 	.irq_set_affinity = plic_set_affinity,
 #endif
 	.irq_set_type	= plic_irq_set_type,
-	.flags		= IRQCHIP_AFFINITY_PRE_STARTUP,
+	.flags		= IRQCHIP_SKIP_SET_WAKE |
+			  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static struct irq_chip plic_chip = {
@@ -201,7 +202,8 @@ static struct irq_chip plic_chip = {
 	.irq_set_affinity = plic_set_affinity,
 #endif
 	.irq_set_type	= plic_irq_set_type,
-	.flags		= IRQCHIP_AFFINITY_PRE_STARTUP,
+	.flags		= IRQCHIP_SKIP_SET_WAKE |
+			  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type)
