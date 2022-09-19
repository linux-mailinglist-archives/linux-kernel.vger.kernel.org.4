Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742E35BCD1E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiISN00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiISN0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:26:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F155E2F032;
        Mon, 19 Sep 2022 06:25:54 -0700 (PDT)
Date:   Mon, 19 Sep 2022 13:25:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663593952;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gkEUxmbmNeNmtyG91wJAUNUhBlRTNcFpYPfZMCRaYtg=;
        b=BzGkQ2Foo1OVvNsq/BWs7quN6t5Td6bzRU9gnUYkeABufsk3DKUd7azNa8sHAVXPCDXsTY
        eu3voQvQc2tWXUZDpCFNgTU1Ouh5uhh0hRFJL7m9PvknrCmJFB5hVxhVAYq536nMBCCxMZ
        od6zJc7U4JstOiBJmEjzyBJiXtmk8jwR09peBjxZsGwNGl1R/jCNIWA+JGz2V5ZTtldavH
        qTlR+cXchDQRSQHn0uDU3eDGn0md9aN+Eq/iaT3JwrWJfcDQteIrR4QeFfD18LVIF5OTOH
        8kBPn4OTPv8xBc2r5kMlVfoxQfPYiOIW3IR5eou0h2G0CscjdBM3WTX+/V30Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663593952;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gkEUxmbmNeNmtyG91wJAUNUhBlRTNcFpYPfZMCRaYtg=;
        b=HdgftkhNDl5FOkMWfZOfRmBB9VNRHgfSKN5qqM8+rZ3dbzWiOywag/DgF3rp5akrigzWAs
        Furz4sqcE2hbkiDQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ssb: gpio: Use generic_handle_irq_safe()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <YnkfWFzvusFFktSt@linutronix.de>
References: <YnkfWFzvusFFktSt@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359395126.401.17652549119726855935.tip-bot2@tip-bot2>
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

Commit-ID:     f285de79569f9e674816a67308316206e4eb30ee
Gitweb:        https://git.kernel.org/tip/f285de79569f9e674816a67308316206e4eb30ee
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 19 Sep 2022 14:43:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 15:08:38 +02:00

ssb: gpio: Use generic_handle_irq_safe()

On PREEMPT_RT enabled kernels the demultiplex interrupt handler is force
threaded and runs with interrupts enabled. The invocation of
generic_handle_domain_irq() with interrupts enabled triggers a lockdep
warning due to a non-irq safe lock acquisition.

Instead of disabling interrupts on the driver level, use
generic_handle_domain_irq_safe().

[ tglx: Split out from combo patch ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/YnkfWFzvusFFktSt@linutronix.de
---
 drivers/ssb/driver_gpio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 2de3896..897cb8d 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -132,7 +132,8 @@ static irqreturn_t ssb_gpio_irq_chipco_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	for_each_set_bit(gpio, &irqs, bus->gpio.ngpio)
-		generic_handle_irq(ssb_gpio_to_irq(&bus->gpio, gpio));
+		generic_handle_domain_irq_safe(bus->irq_domain, gpio);
+
 	ssb_chipco_gpio_polarity(chipco, irqs, val & irqs);
 
 	return IRQ_HANDLED;
@@ -330,7 +331,8 @@ static irqreturn_t ssb_gpio_irq_extif_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	for_each_set_bit(gpio, &irqs, bus->gpio.ngpio)
-		generic_handle_irq(ssb_gpio_to_irq(&bus->gpio, gpio));
+		generic_handle_domain_irq_safe(bus->irq_domain, gpio);
+
 	ssb_extif_gpio_polarity(extif, irqs, val & irqs);
 
 	return IRQ_HANDLED;
