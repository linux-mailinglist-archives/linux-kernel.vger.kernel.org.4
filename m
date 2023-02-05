Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7999368AF8A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 12:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBELaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 06:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBEL37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:29:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D21B1E5EC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 03:29:58 -0800 (PST)
Date:   Sun, 05 Feb 2023 11:29:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675596595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uU+75hijWf4LeON+GJg8O86maQJcUfJnmQe+VQLePtY=;
        b=zc+eMeXgoSDV4ZXXI/z9YY2RHml6Y3t7dH6475FRdNqjFihbRNH9k1pYAJdRNi7aclq4wu
        oHiK6GL9saM77a0D6rY1uuIoWM5c2kLNF50em9oqTsxGKGxnPeXHQm2yauTzk9wqFE2Bai
        iU+7u4IZQwqH/vrDKMxsxq9BNtoJ6WY+CQqs/RAjfULu9uosJZ+1NP1BHk9pt9CzeDtxQd
        HeWqAH3PwubHgEVtvzNp2H0sO717c6A8aUNiorgEj8/rUVEnXvjN71mew+ibw7ZrqDa5xC
        Lrwi5PrVS9WYnQCvTHwJ/weu6mXlw5edBd1Avv8WsaQMyakPk1n82wsZyPXlIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675596595;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uU+75hijWf4LeON+GJg8O86maQJcUfJnmQe+VQLePtY=;
        b=v7G9RyaIL+4dRuVqsXXJd8cfdM6IpS1yz0wVdiLq4CVb4TiL52Qak4WTdFN0WziAusUXO8
        UFcgQq8u26afzVCw==
From:   "irqchip-bot for Ryan Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/aspeed-scu-ic: Correctly
 initialise status and enable registers
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230130085430.635583-1-ryan_chen@aspeedtech.com>
References: <20230130085430.635583-1-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Message-ID: <167559659489.4906.7761150673099928632.tip-bot2@tip-bot2>
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

Commit-ID:     e740604232dc5c3097808f3e91fd02d9316010c5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e740604232dc5c3097808f3e91fd02d9316010c5
Author:        Ryan Chen <ryan_chen@aspeedtech.com>
AuthorDate:    Mon, 30 Jan 2023 16:54:30 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 05 Feb 2023 10:55:19 

irqchip/aspeed-scu-ic: Correctly initialise status and enable registers

The status and enable registers are never initialised with sensible
default values. Fix those.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
[maz: commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230130085430.635583-1-ryan_chen@aspeedtech.com
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 279e92c..94a7223 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -17,8 +17,9 @@
 
 #define ASPEED_SCU_IC_REG		0x018
 #define ASPEED_SCU_IC_SHIFT		0
-#define ASPEED_SCU_IC_ENABLE		GENMASK(6, ASPEED_SCU_IC_SHIFT)
+#define ASPEED_SCU_IC_ENABLE		GENMASK(15, ASPEED_SCU_IC_SHIFT)
 #define ASPEED_SCU_IC_NUM_IRQS		7
+#define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
 #define ASPEED_SCU_IC_STATUS_SHIFT	16
 
 #define ASPEED_AST2600_SCU_IC0_REG	0x560
@@ -155,6 +156,8 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 		rc = PTR_ERR(scu_ic->scu);
 		goto err;
 	}
+	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_STATUS, ASPEED_SCU_IC_STATUS);
+	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_ENABLE, 0);
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq) {
