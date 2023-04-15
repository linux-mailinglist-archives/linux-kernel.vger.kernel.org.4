Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5906E2FB1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 10:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDOIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 04:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDOIUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 04:20:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E424ED5;
        Sat, 15 Apr 2023 01:20:35 -0700 (PDT)
Date:   Sat, 15 Apr 2023 08:20:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681546833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiIvPGenEBT6gAsxlbg/0DJsj/OvvM8nyaJ/KHx0twc=;
        b=Asznsa5n+CvFKhi+0Tcw7GHHRXr9gQVaEI8vN34w14fn+D8vEF2QizLfk/I7rsne3S4vRX
        UJ6ypDNI1IuveVijHQcWgoD9eOFLSLZEM3ZXrVwFQ9fzMxg2LCIjQfyz115pVszZNP/M83
        9MDOMChdwP4nqqjI4qgtgw6ZhYIA8WW/tplPoDcI1yV6tAjTUqzeZaHUO6pvszClKtJye8
        /uENgWuYOOs6M5jQPvekx8fCG42OGGqiJWl8plodV76d1R4l942GK2Ck6mv0VTdlWixUqr
        NlJT3DjWpBqvocYlE2ms/5gSSOBqBwSjCJIzED2Gtf8e0NfHtqr3lr03XatiDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681546833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiIvPGenEBT6gAsxlbg/0DJsj/OvvM8nyaJ/KHx0twc=;
        b=FKY87IGkBIJ/jW8uOAk8n+X04CxG0X752hi90Anzyr/rWqJloGwGvqFGxsAP6TpR0x8lZw
        3nBtQ3x1m2e270BA==
From:   "tip-bot2 for John Keeping" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Update affinity of secondary threads
Cc:     John Keeping <john@metanate.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230406180857.588682-1-john@metanate.com>
References: <20230406180857.588682-1-john@metanate.com>
MIME-Version: 1.0
Message-ID: <168154683244.404.11833513907758281471.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     803235982b8c086184d04798d9079d236f352f88
Gitweb:        https://git.kernel.org/tip/803235982b8c086184d04798d9079d236f352f88
Author:        John Keeping <john@metanate.com>
AuthorDate:    Thu, 06 Apr 2023 19:08:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 15 Apr 2023 10:17:16 +02:00

genirq: Update affinity of secondary threads

For interrupts with secondary threads, the affinity is applied when the
thread is created but if the interrupts affinity is changed later only
the primary thread is updated.

Update the secondary thread's affinity as well to keep all the interrupts
activity on the assigned CPUs.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230406180857.588682-1-john@metanate.com

---
 kernel/irq/manage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8ce7549..d2742af 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -189,9 +189,12 @@ void irq_set_thread_affinity(struct irq_desc *desc)
 {
 	struct irqaction *action;
 
-	for_each_action_of_desc(desc, action)
+	for_each_action_of_desc(desc, action) {
 		if (action->thread)
 			set_bit(IRQTF_AFFINITY, &action->thread_flags);
+		if (action->secondary && action->secondary->thread)
+			set_bit(IRQTF_AFFINITY, &action->secondary->thread_flags);
+	}
 }
 
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
