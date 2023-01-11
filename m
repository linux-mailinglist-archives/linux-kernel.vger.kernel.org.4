Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575F46662E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbjAKSiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjAKSis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:38:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006A714007;
        Wed, 11 Jan 2023 10:38:47 -0800 (PST)
Date:   Wed, 11 Jan 2023 18:38:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673462326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8y8nobWxJCXxABHliZ6sNM8bCx6NZKVFz9SwmPoCrQ=;
        b=bJppQ4+5qgJcHNToETLOWI0fnwbdB0QsXaPx3UeLFdg1Ozm+rj8QmcX4WHsaO8jl1baQDG
        OgVmLo+wKewLI7K13pwiTDKeIn3V6EVrAhcLRp+gU+Dpw8EPPiVGZKa5ImWDF094iAJ8l/
        lUJrtxke6l0xx4qmiWzr9s/codS3ykGLjieHqmElM2pfKfY+pz86Ffqtj69Tang19qn/qo
        3fgReC3VbFtp6yYK+M2RKIDnfszQckHcAWGLHrYmAOqDbYjUQ94gtxkTnShQGvqCG/VB+V
        CiWuN6LuorE+43OUWWypP9cD9+0HZtJ7adbRTLSFWYgZfHd16M2sxxwylTUNzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673462326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8y8nobWxJCXxABHliZ6sNM8bCx6NZKVFz9SwmPoCrQ=;
        b=RH4yXX5IdR2kk9r3Qkrbrek4InvKcH87oft2+4swQysIdmTfn5sAVDB9+XnBsQjvgabbHd
        pvmVsEDmcJ5ij5Cw==
From:   "tip-bot2 for Manfred Spraul" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add might_sleep() to disable_irq()
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221216150441.200533-3-manfred@colorfullife.com>
References: <20221216150441.200533-3-manfred@colorfullife.com>
MIME-Version: 1.0
Message-ID: <167346232582.4906.17142708908609012375.tip-bot2@tip-bot2>
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

Commit-ID:     17549b0f184d870f2cfa4e5cfa79f4c4905ed757
Gitweb:        https://git.kernel.org/tip/17549b0f184d870f2cfa4e5cfa79f4c4905ed757
Author:        Manfred Spraul <manfred@colorfullife.com>
AuthorDate:    Fri, 16 Dec 2022 16:04:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Jan 2023 19:35:13 +01:00

genirq: Add might_sleep() to disable_irq()

With the introduction of threaded interrupt handlers, it is virtually
never safe to call disable_irq() from non-premptible context.

Thus: Update the documentation, add an explicit might_sleep() to catch any
offenders. This is more obvious and straight forward than the implicit
might_sleep() check deeper down in the disable_irq() call chain.

Fixes: 3aa551c9b4c4 ("genirq: add threaded interrupt handler support")
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221216150441.200533-3-manfred@colorfullife.com


---
 kernel/irq/manage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 5b7cf28..8ce7549 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -723,10 +723,13 @@ EXPORT_SYMBOL(disable_irq_nosync);
  *	to complete before returning. If you use this function while
  *	holding a resource the IRQ handler may need you will deadlock.
  *
- *	This function may be called - with care - from IRQ context.
+ *	Can only be called from preemptible code as it might sleep when
+ *	an interrupt thread is associated to @irq.
+ *
  */
 void disable_irq(unsigned int irq)
 {
+	might_sleep();
 	if (!__disable_irq_nosync(irq))
 		synchronize_irq(irq);
 }
