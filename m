Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB43E669755
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbjAMMdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241282AbjAMMcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B350E6C;
        Fri, 13 Jan 2023 04:31:10 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAbWbWFp5L/glYPOmdVPYhFeA2m/53BCTwuDYTVEMEs=;
        b=c2Xg9tsMQin8MhuGwZMegWwt5I8Xns76thjtfPd65ZLxn8znq7GqwwNCnYJrRUNSQXaR31
        EsXGo6/XHESDeQzAHADfW5dM7GvxxHpahXk6U/ZrVaF9ygO3JkfbafUUNO290dP16QatyP
        xAIh24Y8zeH34rgZ0M7zBW3lQDyfj7hhcC8UGTWb2OOsgVrdLZ2iMMcYY4XIQfOsVwcyK+
        wgzMCHx67nzNIsz9DgKOEAazA6YKixiEjsJSZwHd2KyrjdpGWleRlgU7hDM/RHku5xjFDT
        09CJvIr7hAQm5ZZfryh2EIzGGzNSlQoJzwTLJsODQIqL8SFoKtIMhqdRTC5zNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAbWbWFp5L/glYPOmdVPYhFeA2m/53BCTwuDYTVEMEs=;
        b=MKXKYAImy/ibaYTvpG+Mv+TSFMtwe9esW2aBSvR7JDzogaXpxSync/O0wE0CFJ/XT8sJHA
        N0A8uio1NhJLnlBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] intel_idle: Add force_irq_on module param
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.967699392@infradead.org>
References: <20230112195541.967699392@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306638.4906.12963791326475300764.tip-bot2@tip-bot2>
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

Commit-ID:     365bd03ff63fb7433a49c453472cf54830b677bf
Gitweb:        https://git.kernel.org/tip/365bd03ff63fb7433a49c453472cf54830b677bf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:57 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:17 +01:00

intel_idle: Add force_irq_on module param

For testing purposes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.967699392@infradead.org
---
 drivers/idle/intel_idle.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 7b996a0..e2d64a8 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1837,6 +1837,9 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 	return true;
 }
 
+static bool force_irq_on __read_mostly;
+module_param(force_irq_on, bool, 0444);
+
 static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 {
 	int cstate;
@@ -1889,8 +1892,10 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		/* Structure copy. */
 		drv->states[drv->state_count] = cpuidle_state_table[cstate];
 
-		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE)
+		if ((cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE) || force_irq_on) {
+			printk("intel_idle: forced intel_idle_irq for state %d\n", cstate);
 			drv->states[drv->state_count].enter = intel_idle_irq;
+		}
 
 		if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
 		    cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IBRS) {
