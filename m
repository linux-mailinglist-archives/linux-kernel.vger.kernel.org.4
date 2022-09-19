Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA45BCD21
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiISN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiISN0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:26:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42B72F652;
        Mon, 19 Sep 2022 06:25:56 -0700 (PDT)
Date:   Mon, 19 Sep 2022 13:25:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663593954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2h/cIlzRy5zmeSJltcUtoDmP/xA/4MFWJdjpPbCC5U=;
        b=tuS/oXyV4cQAWmA4iO7kxT+3A57zqHjTt52onkeHG5kjJ0Td7BsHqc/ijF/i3gCCsaEeM7
        HEe9NRCOMlSP04nTW31NhZ3UgyI7haXqXixG2UN6qJl6y+uCY09Pc1yPfwoy2Y07HcNLMC
        j5kp7+1Z/kiIof8086HFVlBNkVFw4yz36QJOhNcWanTJRSLylFD25kZtZZbHk68j7xwPsL
        VJFhiGXsAwwRR4zQlEW4f7sAvKjxwDTrA1jS4l37+OMyJdJ45r9+heTfeC/1t8vRdt35r2
        dNb9MWu71acb0uksv3+HpAE1hF+zGLmYo2Mov70FLqDdiZBDIgyGimCFvjK2+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663593954;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2h/cIlzRy5zmeSJltcUtoDmP/xA/4MFWJdjpPbCC5U=;
        b=xIeX8YcwtRumaIgksXv6hDfeupozwddiSWIL0kRBf4x+DHYrutG7+Yw+duFev4JWfOWAnz
        VT0+0VCA1+Z1GBBA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] pinctrl: amd: Use generic_handle_irq_safe()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <YnkfWFzvusFFktSt@linutronix.de>
References: <YnkfWFzvusFFktSt@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359395235.401.11910910505403542234.tip-bot2@tip-bot2>
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

Commit-ID:     f460c70125bcb1b753f152d9d0c9cee3ddbc2d91
Gitweb:        https://git.kernel.org/tip/f460c70125bcb1b753f152d9d0c9cee3ddbc2d91
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 19 Sep 2022 14:42:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 15:08:38 +02:00

pinctrl: amd: Use generic_handle_irq_safe()

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
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215954
---
 drivers/pinctrl/pinctrl-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 4691a33..4ed2b4b 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -639,7 +639,7 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
 			if (!(regval & PIN_IRQ_PENDING) ||
 			    !(regval & BIT(INTERRUPT_MASK_OFF)))
 				continue;
-			generic_handle_domain_irq(gc->irq.domain, irqnr + i);
+			generic_handle_domain_irq_safe(gc->irq.domain, irqnr + i);
 
 			/* Clear interrupt.
 			 * We must read the pin register again, in case the
