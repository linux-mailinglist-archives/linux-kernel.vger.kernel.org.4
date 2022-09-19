Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E645BCD1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiISN0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiISN0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:26:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58132E6A0;
        Mon, 19 Sep 2022 06:25:51 -0700 (PDT)
Date:   Mon, 19 Sep 2022 13:25:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663593949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TI62/gxswWvoqRf/CjBCtWirkvO0DCMeR9WFLDT87aE=;
        b=1bfEQk3ey1J+XOJwWrSBx+tJEKZ8BDtXOaRvn6kWDNm87MJi078m3+RTF/ShX8K8m0LmPb
        YgTf5xxWihhBVN4aCle2cldvA8nlFvHLyq5po4dUZ9QALPqmEHut2WB1Iak/j6bkGbFnG7
        7NKOXz0cf8PKr0DsyKS5V1/EnVRjq+w0oTRA40VgSuQnG8Y0nxeBCUjYxwfc/sYGjhBqMy
        RG4tP4jvUaFY1M1my0JcK/83fEFegEI7QnTIalxIPfcg0lCy3VWyUaZH2E0fyeBBANkcEJ
        jWTwnvjt9IhBdTfDM6Zvu3Y66fJkfA0LTEVp7dcbUpS+DhGfXHoS0bZOcGfhfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663593949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TI62/gxswWvoqRf/CjBCtWirkvO0DCMeR9WFLDT87aE=;
        b=4C2RBBIW2is3dr1tpAgf3vekCOxkr7476TvzB/G94otjwQVA09IWenKcL9nQo9/EoA98/u
        f+PT3V08yzlj3YAw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] bcma: gpio: Use generic_handle_irq_safe()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <YnkfWFzvusFFktSt@linutronix.de>
References: <YnkfWFzvusFFktSt@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359394784.401.3409947686571906652.tip-bot2@tip-bot2>
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

Commit-ID:     94ec234a16cf3acdb319f05917b1efec9642222e
Gitweb:        https://git.kernel.org/tip/94ec234a16cf3acdb319f05917b1efec9642222e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 19 Sep 2022 14:46:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 15:08:39 +02:00

bcma: gpio: Use generic_handle_irq_safe()

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
 drivers/bcma/driver_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index fac8ff9..65fb9ba 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -115,7 +115,7 @@ static irqreturn_t bcma_gpio_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	for_each_set_bit(gpio, &irqs, gc->ngpio)
-		generic_handle_irq(irq_find_mapping(gc->irq.domain, gpio));
+		generic_handle_domain_irq_safe(gc->irq.domain, gpio);
 	bcma_chipco_gpio_polarity(cc, irqs, val & irqs);
 
 	return IRQ_HANDLED;
