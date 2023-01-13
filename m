Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DD466976A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241592AbjAMMf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbjAMMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CFA559F9;
        Fri, 13 Jan 2023 04:31:15 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hP/k/NMqAdiQz8WBcJ0kwxY2utEsP452HHTIG3MkVw4=;
        b=rgxJ6a3mxj4FyrboxhMfMvxXHX0zTZo3Jkm8UZpHEf95ltmxldde/jrItjxO2JCzrrkCTk
        rJ7buqtf/Y14sU2iXJ0c/VXR3amR45qikey2Xhx/SHMzJENiZpEo+J6TuI1J4QuIBdnbD2
        v8ymCikbEFLbHq8FKXcGGoRg6xy2FX2brq78psZFWFKjd82r7Y8iMmzBsML3dH1ov1XTmj
        hZ4NxchbIZ3sPb14u4noPYmVlk1SU1so6JWpzLf4gPB/fJNFgc5mY3PbNNE8AYIzIJdMJy
        2By7myYiy9hU6SsHfVVU9wnpl9O2g2gMvnZRa6S4+XxGWBw05vNoC+rA8dsr9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hP/k/NMqAdiQz8WBcJ0kwxY2utEsP452HHTIG3MkVw4=;
        b=e49LbSOx/HqASJeklYg/kBWJBlDFhf0b2hfeg8I8EU77XOpHKK/lm3QbLVjv9oQ0l7cH9X
        ACIH29giojARKTBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, cpu_pm: Remove RCU fiddling from
 cpu_pm_{enter,exit}()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195540.190860672@infradead.org>
References: <20230112195540.190860672@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307344.4906.3430175996894589521.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     924aed1646bf2859726f7e5dd9265ba14358fbb8
Gitweb:        https://git.kernel.org/tip/924aed1646bf2859726f7e5dd9265ba14358fbb8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:15 +01:00

cpuidle, cpu_pm: Remove RCU fiddling from cpu_pm_{enter,exit}()

All callers should still have RCU enabled.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195540.190860672@infradead.org
---
 kernel/cpu_pm.c |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index ba4ba71..b0f0d15 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -30,16 +30,9 @@ static int cpu_pm_notify(enum cpu_pm_event event)
 {
 	int ret;
 
-	/*
-	 * This introduces a RCU read critical section, which could be
-	 * disfunctional in cpu idle. Copy RCU_NONIDLE code to let RCU know
-	 * this.
-	 */
-	ct_irq_enter_irqson();
 	rcu_read_lock();
 	ret = raw_notifier_call_chain(&cpu_pm_notifier.chain, event, NULL);
 	rcu_read_unlock();
-	ct_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
 }
@@ -49,11 +42,9 @@ static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event ev
 	unsigned long flags;
 	int ret;
 
-	ct_irq_enter_irqson();
 	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
 	ret = raw_notifier_call_chain_robust(&cpu_pm_notifier.chain, event_up, event_down, NULL);
 	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
-	ct_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
 }
