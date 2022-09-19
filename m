Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5C5BCD23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiISN0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiISN0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:26:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316A2EF2C;
        Mon, 19 Sep 2022 06:25:53 -0700 (PDT)
Date:   Mon, 19 Sep 2022 13:25:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663593951;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NCI/fY3dO/GqyQEAdoFj9APwXoEXKqA5FFdTDWcnpk4=;
        b=3Z2+FINXkUWFUw83SAmr3suNQ1j9rPucv+vRbFXfInd1iepVK5W8tSaRCrA0JwkKsZP+ZU
        ShoU0qdMBYxNEufNSZD1Es7RF2BbosK4NDozisIsyzp+Sp/pf/kkAuCcgPWJzuf25bDl4w
        Z/QH/tQJcryN7xAfGy/hmCeqrcEk81oKgvEh+Ba0Nacc9N/3spHvtPJMNKtHjh52MwkBfU
        LU7nTYuaL9LaOHN7zmQTzpQWZ14NPM9iUUc9lNi94xK9BcWL0iZx2nXkt7KEk0SsKOg01U
        WWH2R60MvvEYLFSXaBHmQa3q1lFEhs4gM1QGuaFWnEA1UKhc4ZC44H+eUaU0+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663593951;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NCI/fY3dO/GqyQEAdoFj9APwXoEXKqA5FFdTDWcnpk4=;
        b=wzfXoaKbKSqOHOPA15yJdMLvoO3sIU1TVU4y3NoLITqZhh6vXhMXWFfd40xFiDDf9G+H8T
        C6GOyzojFcM+MaCg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] platform/x86: intel_int0002_vgpio: Use
 generic_handle_irq_safe()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <YnkfWFzvusFFktSt@linutronix.de>
References: <YnkfWFzvusFFktSt@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359395017.401.1995056895481499815.tip-bot2@tip-bot2>
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

Commit-ID:     c6a91405ac5cd5baa03fea061e11b05788223160
Gitweb:        https://git.kernel.org/tip/c6a91405ac5cd5baa03fea061e11b05788223160
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 19 Sep 2022 14:44:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 15:08:38 +02:00

platform/x86: intel_int0002_vgpio: Use generic_handle_irq_safe()

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
 drivers/platform/x86/intel/int0002_vgpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/int0002_vgpio.c b/drivers/platform/x86/intel/int0002_vgpio.c
index 617dbf9..97cfbc5 100644
--- a/drivers/platform/x86/intel/int0002_vgpio.c
+++ b/drivers/platform/x86/intel/int0002_vgpio.c
@@ -125,8 +125,7 @@ static irqreturn_t int0002_irq(int irq, void *data)
 	if (!(gpe_sts_reg & GPE0A_PME_B0_STS_BIT))
 		return IRQ_NONE;
 
-	generic_handle_irq(irq_find_mapping(chip->irq.domain,
-					    GPE0A_PME_B0_VIRT_GPIO_PIN));
+	generic_handle_domain_irq_safe(chip->irq.domain, GPE0A_PME_B0_VIRT_GPIO_PIN);
 
 	pm_wakeup_hard_event(chip->parent);
 
