Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7671266977B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbjAMMhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240802AbjAMMcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D126A574C5;
        Fri, 13 Jan 2023 04:31:16 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/oyZgvO33ZtyKUfO22o+/oe9NkApuzXcK0D+XIHMSFg=;
        b=EYsMOvwnSZrkdiBLaho7e+R0+u2451f0UwPaQOjG2XcXZmq99Wt2XDeYPcGJ9+gEgNGqjp
        snnav7Rkjp7czRlnFjInWLvCEOyM2gIj5LtXbzLXTrkfhZ64ADW35avLPrstLXDb3gDPxX
        K3N8Z5HVHeB/rXQ1k4o7UWiLilr/LV1fN3fShkHvTkf7NFTC9ZouHIEIwp2Gab4ayvitSa
        m1VD98Cnp2pO8DAdwpV8XBaB5Xi18q2Lv8BZSZjL32hv6camNDd7cGc55QrM1ElrC5hwDb
        K+tn6Bf9jNFuYo+eH7f0wG6e4+h13eJZpHHXoXhbYTqq5CDH74VoCreM5NoBQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/oyZgvO33ZtyKUfO22o+/oe9NkApuzXcK0D+XIHMSFg=;
        b=Y2jE269CGToUVClMFXekdPdvzQrpzJF8TjlMYMb6Nt6D2VmizuhoeGSKLsmAnrevrFTUq3
        CjSuHgBSP5LmnHAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, riscv: Push RCU-idle into driver
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195539.637185846@infradead.org>
References: <20230112195539.637185846@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307515.4906.5088931102976542675.tip-bot2@tip-bot2>
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

Commit-ID:     8e9ab9e8da1eae61fdff35690d998eaf8cd527dc
Gitweb:        https://git.kernel.org/tip/8e9ab9e8da1eae61fdff35690d998eaf8cd527dc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:03:22 +01:00

cpuidle, riscv: Push RCU-idle into driver

Doing RCU-idle outside the driver, only to then temporarily enable it
again, at least twice, before going idle is suboptimal.

That is, once implicitly through the cpu_pm_*() calls and once
explicitly doing ct_irq_*_irqon().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20230112195539.637185846@infradead.org
---
 drivers/cpuidle/cpuidle-riscv-sbi.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 05fe290..cbdbb11 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -121,12 +121,12 @@ static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
 		return -1;
 
 	/* Do runtime PM to manage a hierarchical CPU toplogy. */
-	ct_irq_enter_irqson();
 	if (s2idle)
 		dev_pm_genpd_suspend(pd_dev);
 	else
 		pm_runtime_put_sync_suspend(pd_dev);
-	ct_irq_exit_irqson();
+
+	ct_idle_enter();
 
 	if (sbi_is_domain_state_available())
 		state = sbi_get_domain_state();
@@ -135,12 +135,12 @@ static int __sbi_enter_domain_idle_state(struct cpuidle_device *dev,
 
 	ret = sbi_suspend(state) ? -1 : idx;
 
-	ct_irq_enter_irqson();
+	ct_idle_exit();
+
 	if (s2idle)
 		dev_pm_genpd_resume(pd_dev);
 	else
 		pm_runtime_get_sync(pd_dev);
-	ct_irq_exit_irqson();
 
 	cpu_pm_exit();
 
@@ -251,6 +251,7 @@ static int sbi_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * of a shared state for the domain, assumes the domain states are all
 	 * deeper states.
 	 */
+	drv->states[state_count - 1].flags |= CPUIDLE_FLAG_RCU_IDLE;
 	drv->states[state_count - 1].enter = sbi_enter_domain_idle_state;
 	drv->states[state_count - 1].enter_s2idle =
 					sbi_enter_s2idle_domain_idle_state;
