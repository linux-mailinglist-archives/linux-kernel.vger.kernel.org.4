Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8735BCD19
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiISN0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiISN0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:26:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744442ED52;
        Mon, 19 Sep 2022 06:25:52 -0700 (PDT)
Date:   Mon, 19 Sep 2022 13:25:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663593950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ml7OVGA9Fxj2BuTWibjQ0NEM/vLTau6YlCd+0x83adU=;
        b=WI7z/G5Z0K7Gh4Cn5+BHRHpL4XdFrAUDxq5du1H+ltOiyPdfZQbpErJ7tlfpEVzb9RxY7E
        8p6GKw3dQHqQ9o7hJaeddko/L1rhjoHyO3zYInkmoYbFUIwzZufQ/1ZQYB1Ufv0Cf2a2xa
        YcUkrgRMjEzTllpDJ/yV7fzVb1reM8FtoDQOqOGEAS4aaVHghExooNekI96nMbWzL1tnxJ
        0ALgqW0D2JDoEfAIMiqV5DkH+tW0gD1JyDUuoQYj9WtdlMjcKh5GvNcwk1OHtaCVlKeJC9
        LmQ5shdkvsao5wi1Ic8MUzF+7GgPulyVWXDC6lx0tuitSXbC3ILZFax7juUA8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663593950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ml7OVGA9Fxj2BuTWibjQ0NEM/vLTau6YlCd+0x83adU=;
        b=aeVL28NGz6qQwcKPI6OU7iGmB5yXioCn5tJiRorRmGy3BTPVCtxfegKWqXpDh4lui0llFM
        5+DR/VbgbM9gF7Dw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] gpio: mlxbf2: Use generic_handle_irq_safe()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <YnkfWFzvusFFktSt@linutronix.de>
References: <YnkfWFzvusFFktSt@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359394905.401.1668196469711198651.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     118c3ba24d04f084eadd9d4a0ab7830f495e9106
Gitweb:        https://git.kernel.org/tip/118c3ba24d04f084eadd9d4a0ab7830f495e9106
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 19 Sep 2022 14:45:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 15:08:38 +02:00

gpio: mlxbf2: Use generic_handle_irq_safe()

On PREEMPT_RT enabled kernels the demultiplex interrupt handler is force
threaded and runs with interrupts enabled. The invocation of
generic_handle_irq() with interrupts enabled triggers a lockdep warning due
to a non-irq safe lock acquisition.

Instead of disabling interrupts on the driver level, use
generic_handle_domain_irq_safe().

[ tglx: Split out from combo patch ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/YnkfWFzvusFFktSt@linutronix.de
---
 drivers/gpio/gpio-mlxbf2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 64cb060..77a4115 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -273,10 +273,8 @@ static irqreturn_t mlxbf2_gpio_irq_handler(int irq, void *ptr)
 	pending = readl(gs->gpio_io + YU_GPIO_CAUSE_OR_CAUSE_EVTEN0);
 	writel(pending, gs->gpio_io + YU_GPIO_CAUSE_OR_CLRCAUSE);
 
-	for_each_set_bit(level, &pending, gc->ngpio) {
-		int gpio_irq = irq_find_mapping(gc->irq.domain, level);
-		generic_handle_irq(gpio_irq);
-	}
+	for_each_set_bit(level, &pending, gc->ngpio)
+		generic_handle_domain_irq_safe(gc->irq.domain, level);
 
 	return IRQ_RETVAL(pending);
 }
