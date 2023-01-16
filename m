Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566A966C87D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjAPQjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjAPQjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:39:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34452C650;
        Mon, 16 Jan 2023 08:27:52 -0800 (PST)
Date:   Mon, 16 Jan 2023 16:27:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673886470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQQL6K9+g3nFmYTxhhPBdAWY0ZIqAkC6J7tK4XIrDaU=;
        b=4u6LSUXNyZSxsGSltzZE00kMT/aUmQ+VxdSsJ4DfrJUjWUwti00Yh60m/MD0HDMhouXc+4
        4/jsDYItlUPEgpzN447amyAKlEW3CtjeV/FBzJyq3mMimdh2OXjIK1eQwhvkMvgQl75pqC
        3nKQZD+J/1cpDX1IIU/qkt1KAE+YIYCGdze5SE1a56Z0QFnSVOwlhCf6CAilmA4g6dxM25
        RP6jsAIP//uumxjvV+vOAamJGuWM61sxOD/d13sgdLpXrkUfu8KvBBIiYhrdZ+7ZQJJyA+
        1Lr6wOYgiRJbrFleUBVOFIgUQFWrlaYzShpXUahw7tpclwTpTMun/bIPKPmTRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673886470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQQL6K9+g3nFmYTxhhPBdAWY0ZIqAkC6J7tK4XIrDaU=;
        b=sgeWZOaocyIlaAYRTu9ifRlcpmZvVtfxIx7xVVr5adfXPXKlhAl4gx/4lB5+qBfKHpHGU3
        Sn4I8c7cqemL0FDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/i8259: Mark legacy PIC interrupts with IRQ_LEVEL
Cc:     Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87mt6rjrra.ffs@tglx>
References: <87mt6rjrra.ffs@tglx>
MIME-Version: 1.0
Message-ID: <167388646935.4906.13609836242653190947.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5fa55950729d0762a787451dc52862c3f850f859
Gitweb:        https://git.kernel.org/tip/5fa55950729d0762a787451dc52862c3f850f859
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 09 Jan 2023 22:57:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Jan 2023 17:24:56 +01:00

x86/i8259: Mark legacy PIC interrupts with IRQ_LEVEL

Baoquan reported that after triggering a crash the subsequent crash-kernel
fails to boot about half of the time. It triggers a NULL pointer
dereference in the periodic tick code.

This happens because the legacy timer interrupt (IRQ0) is resent in
software which happens in soft interrupt (tasklet) context. In this context
get_irq_regs() returns NULL which leads to the NULL pointer dereference.

The reason for the resend is a spurious APIC interrupt on the IRQ0 vector
which is captured and leads to a resend when the legacy timer interrupt is
enabled. This is wrong because the legacy PIC interrupts are level
triggered and therefore should never be resent in software, but nothing
ever sets the IRQ_LEVEL flag on those interrupts, so the core code does not
know about their trigger type.

Ensure that IRQ_LEVEL is set when the legacy PCI interrupts are set up.

Fixes: a4633adcdbc1 ("[PATCH] genirq: add genirq sw IRQ-retrigger")
Reported-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Baoquan He <bhe@redhat.com>
Link: https://lore.kernel.org/r/87mt6rjrra.ffs@tglx
---
 arch/x86/kernel/i8259.c   | 1 +
 arch/x86/kernel/irqinit.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 3aa5304..4d8aff0 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -114,6 +114,7 @@ static void make_8259A_irq(unsigned int irq)
 	disable_irq_nosync(irq);
 	io_apic_irqs &= ~(1<<irq);
 	irq_set_chip_and_handler(irq, &i8259A_chip, handle_level_irq);
+	irq_set_status_flags(irq, IRQ_LEVEL);
 	enable_irq(irq);
 	lapic_assign_legacy_vector(irq, true);
 }
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index beb1bad..c683666 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -65,8 +65,10 @@ void __init init_ISA_irqs(void)
 
 	legacy_pic->init(0);
 
-	for (i = 0; i < nr_legacy_irqs(); i++)
+	for (i = 0; i < nr_legacy_irqs(); i++) {
 		irq_set_chip_and_handler(i, chip, handle_level_irq);
+		irq_set_status_flags(i, IRQ_LEVEL);
+	}
 }
 
 void __init init_IRQ(void)
