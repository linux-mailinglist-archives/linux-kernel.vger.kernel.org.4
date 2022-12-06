Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF76442C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiLFL7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiLFL6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:58:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8054728704;
        Tue,  6 Dec 2022 03:57:58 -0800 (PST)
Date:   Tue, 06 Dec 2022 11:57:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670327876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdsOvn9qH/3x0ajXkWx0p8XrIZu+IBeVVw5n8nacL2w=;
        b=LSBUdbr5AHPND8urKFPwdtPUs7rp3LQO/HUzggTMWLhnQmytGOlME1B65LrRzEbNmuzbDy
        NzHyuLgbgLsP5seTIMi7ETLv9EDuBiLdW5SnetcWr7Ffi0dLZRXgCrtTsmS+h3H/4rr3sz
        CbsJd6Q70tmgw7xILsoiu3fmc4JYKfUvuN+Hx8tLjXaPEK77AX7+qWN5X+Xn+4CLcFNrbs
        3oVAqtASWFnONY1uyEvP7jeHThjTcM5voqUkEC2kY9yt48hx1HQH0xG5WIIHTWo6CVC4wj
        AoUYmMK/bOKA13ZRkj9OxrAPPBrI8g6tE6AFT2MJYAxHcqg/jmU8LCil2UkrWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670327876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdsOvn9qH/3x0ajXkWx0p8XrIZu+IBeVVw5n8nacL2w=;
        b=hFTFH6HxDinHw6kiPf8tdZBpSCTap5OUfe9xDFo1Xj6Tk7jynGh83stpfvpKSFW729VYbW
        3pKSOZcwyjg5guCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-mvebu-icu: Fix works by chance pointer assignment
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221121140048.344525618@linutronix.de>
References: <20221121140048.344525618@linutronix.de>
MIME-Version: 1.0
Message-ID: <167032787659.4906.13112643126419077191.tip-bot2@tip-bot2>
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

Commit-ID:     55721afa8d8b82e442cb4eaf7173330f79cbfb48
Gitweb:        https://git.kernel.org/tip/55721afa8d8b82e442cb4eaf7173330f79cbfb48
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 21 Nov 2022 15:39:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 Dec 2022 12:50:17 +01:00

irqchip/irq-mvebu-icu: Fix works by chance pointer assignment

Assigning a void pointer which points to a struct to two different data
types only works by chance if the second type is the first member of the
struct.

Replace this works by chance code by using the primary struct pointer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221121140048.344525618@linutronix.de

---
 drivers/irqchip/irq-mvebu-icu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 497da34..3c77acc 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -151,9 +151,9 @@ static int
 mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 			       unsigned long *hwirq, unsigned int *type)
 {
-	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
-	struct mvebu_icu *icu = platform_msi_get_host_data(d);
 	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
+	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
+	struct mvebu_icu *icu = msi_data->icu;
 
 	/* Check the count of the parameters in dt */
 	if (WARN_ON(fwspec->param_count != param_count)) {
