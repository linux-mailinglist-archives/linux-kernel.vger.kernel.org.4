Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A4A669770
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbjAMMgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbjAMMcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8C256898;
        Fri, 13 Jan 2023 04:31:16 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0cZZAZSTrqYu0gbJNkXuBSXWsztONJlo8KvNyVa3IA=;
        b=p4+li1LEpTK6di04MspXLaS+evvgPOFXIEJ4NmPEfde5rR2NwdskBUBWAXZrvGZs4XHA78
        /qMnNtMzn67srgijzPmQgrMU+YBu5qwSem6h76RUXKN0d34Q+og+PyQcGxzyEXB+R0NR6x
        RmW74Ck4vv6LH9GlF58Gub20XlBd//TcvMOjta9DPNF/9DhPjppZv8r2MoG7Xi39zDfO2n
        8ybFylmpQtgkVezUZLMam8dZTMOE4kIhOVGl+WfoaE+NUcVporAsEWwaRtqm6Oy3jo+QKu
        lYQMAuM2bQgc7a+7T0QlN6D92HEwDcAnxe5JmZ1sr6x8xzoDswylDCJwoWrJgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0cZZAZSTrqYu0gbJNkXuBSXWsztONJlo8KvNyVa3IA=;
        b=68AIeLujAN0bManKfxRWaakf0npl3p/e71LahqWOoRlOvAwTr/eT57b9vRrYm6LhqehCHo
        nlelKQCaj103BxAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, psci: Push RCU-idle into driver
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195539.760296658@infradead.org>
References: <20230112195539.760296658@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307481.4906.6468882883967767760.tip-bot2@tip-bot2>
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

Commit-ID:     e038f7b8028a1d1bc8ac82351c71ea538f19a879
Gitweb:        https://git.kernel.org/tip/e038f7b8028a1d1bc8ac82351c71ea538f19a879
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:03:22 +01:00

cpuidle, psci: Push RCU-idle into driver

Doing RCU-idle outside the driver, only to then temporarily enable it
again, at least twice, before going idle is suboptimal.

Notably once implicitly through the cpu_pm_*() calls and once
explicitly doing ct_irq_*_irqon().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20230112195539.760296658@infradead.org
---
 drivers/cpuidle/cpuidle-psci.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 57bc3e3..969808c 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -69,12 +69,12 @@ static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
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
 
 	state = psci_get_domain_state();
 	if (!state)
@@ -82,12 +82,12 @@ static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
 
-	ct_irq_enter_irqson();
+	ct_idle_exit();
+
 	if (s2idle)
 		dev_pm_genpd_resume(pd_dev);
 	else
 		pm_runtime_get_sync(pd_dev);
-	ct_irq_exit_irqson();
 
 	cpu_pm_exit();
 
@@ -240,6 +240,7 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * of a shared state for the domain, assumes the domain states are all
 	 * deeper states.
 	 */
+	drv->states[state_count - 1].flags |= CPUIDLE_FLAG_RCU_IDLE;
 	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
 	psci_cpuidle_use_cpuhp = true;
