Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442FD66976F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbjAMMgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbjAMMcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D23B56891;
        Fri, 13 Jan 2023 04:31:16 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTcUQs4uK1vY95BNm1lDcumclDV3Mv1N0dB6QITg0wY=;
        b=heICSrpeRgdFQxt8EgyQGmUaCUqpHzTJ8VwFdmL48JW7kcSypCJP57zaML/Ua+xxh+XWw/
        yNMHIevKvuBgkC5U8gs3aEmkPt8CB3MwWAHPlER61tFCiHKnZa2DFE1Ux6svo8RgKagn6+
        0oHV5aR2GQqxD9hhX7HwBfgCefrFWEGtMCHNauz0hIO5NZzhzNdj0phiF6amOXrejPkb/4
        Ke+7yMeoV/fhTkBse1iVOnZZAKGI+baFo7xdKRR8Q3qerb3OBV+ptmeKaQz1//MD//C7Kg
        bm1x5TtexKSBvuMp0E9ABBbwHII+90h7cAcf/U1K8JPa1dTJXa9MO/xyOqw9RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTcUQs4uK1vY95BNm1lDcumclDV3Mv1N0dB6QITg0wY=;
        b=tX0PLiOWZYSlpN12E+xxzk1WlX4kGtHkC3c7CnMHLLNZyZ5SNr1YwB9l/Pf9dz1I1O+VLA
        9YNMMKK0gSfJCLDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, ARM/imx6: Push RCU-idle into driver
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195539.821714572@infradead.org>
References: <20230112195539.821714572@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307465.4906.223147863550715410.tip-bot2@tip-bot2>
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

Commit-ID:     b3f46658ce40a3467cda82f920dd9d5325ab0eaf
Gitweb:        https://git.kernel.org/tip/b3f46658ce40a3467cda82f920dd9d5325ab0eaf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:46:40 +01:00

cpuidle, ARM/imx6: Push RCU-idle into driver

Doing RCU-idle outside the driver, only to then temporarily enable it
again, at least twice, before going idle is suboptimal.

Notably both cpu_pm_enter() and cpu_cluster_pm_enter() implicity
re-enable RCU.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20230112195539.821714572@infradead.org
---
 arch/arm/mach-imx/cpuidle-imx6sx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index 74ea172..1dc01f6 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -47,7 +47,9 @@ static int imx6sx_enter_wait(struct cpuidle_device *dev,
 		cpu_pm_enter();
 		cpu_cluster_pm_enter();
 
+		ct_idle_enter();
 		cpu_suspend(0, imx6sx_idle_finish);
+		ct_idle_exit();
 
 		cpu_cluster_pm_exit();
 		cpu_pm_exit();
@@ -87,7 +89,8 @@ static struct cpuidle_driver imx6sx_cpuidle_driver = {
 			 */
 			.exit_latency = 300,
 			.target_residency = 500,
-			.flags = CPUIDLE_FLAG_TIMER_STOP,
+			.flags = CPUIDLE_FLAG_TIMER_STOP |
+				 CPUIDLE_FLAG_RCU_IDLE,
 			.enter = imx6sx_enter_wait,
 			.name = "LOW-POWER-IDLE",
 			.desc = "ARM power off",
