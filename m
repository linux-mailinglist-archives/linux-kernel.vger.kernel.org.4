Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82299669775
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbjAMMgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbjAMMcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4941CB17;
        Fri, 13 Jan 2023 04:31:16 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdHvpPSQSZAkV9++SX1Wbo6VK6lNx4oK1LX4BODVDuM=;
        b=Rxo3nIFYac09XXf1iHPYN0cJtsDJXsUPGperJrvzh8J+Eia5lph4QlZ2kqQoY0TiblV2YZ
        tHOy/1IeK8l21qXiwtxa57p/D8aLGqUuNRfjHt1W2DV5OqDRgl3wN/Jol8MRX6fqXMMT7z
        TCmG9LrR9TJezy/8BgIfLLCNZ8r5UkTY+JH2mYMFjO7z8IcimkbxFkLv3F++aqrGYCCXyv
        Z95TJw9Z4L87Avq0yyZPd2EDQ+CEdhYJpsGGD7G21lVBuuyrdJ+khWbEzXph60GrX1OnKv
        e9TgX93WHJ27QSpIaRm8TSEsD+cXsZfiqcOyMeRk+AG4bq2Fj3ZQ87iWyfdL4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdHvpPSQSZAkV9++SX1Wbo6VK6lNx4oK1LX4BODVDuM=;
        b=m6DjOo2gOAfG1//egqVuiphILBH//iBHWkSNndZhRtD3SZaxq1fasvbWpKtTtNlIKKryBJ
        C/bGxNl+UFCFbKAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, armada: Push RCU-idle into driver
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195539.946630819@infradead.org>
References: <20230112195539.946630819@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307427.4906.15441555774819619097.tip-bot2@tip-bot2>
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

Commit-ID:     4ce40e9dbe83153f60d7e4ccd24a1eb4f8264f6a
Gitweb:        https://git.kernel.org/tip/4ce40e9dbe83153f60d7e4ccd24a1eb4f8264f6a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:47:27 +01:00

cpuidle, armada: Push RCU-idle into driver

Doing RCU-idle outside the driver, only to then temporarily enable it
again before going idle is suboptimal.

Notably the cpu_pm_*() calls implicitly re-enable RCU for a bit.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20230112195539.946630819@infradead.org
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 01a8569..c9568aa 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -36,7 +36,10 @@ static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
 	if (drv->states[index].flags & MVEBU_V7_FLAG_DEEP_IDLE)
 		deepidle = true;
 
+	ct_idle_enter();
 	ret = mvebu_v7_cpu_suspend(deepidle);
+	ct_idle_exit();
+
 	cpu_pm_exit();
 
 	if (ret)
@@ -49,6 +52,7 @@ static struct cpuidle_driver armadaxp_idle_driver = {
 	.name			= "armada_xp_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 100,
 		.power_usage		= 50,
@@ -57,6 +61,7 @@ static struct cpuidle_driver armadaxp_idle_driver = {
 		.desc			= "CPU power down",
 	},
 	.states[2]		= {
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 1000,
 		.power_usage		= 5,
@@ -72,6 +77,7 @@ static struct cpuidle_driver armada370_idle_driver = {
 	.name			= "armada_370_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 100,
 		.power_usage		= 5,
@@ -87,6 +93,7 @@ static struct cpuidle_driver armada38x_idle_driver = {
 	.name			= "armada_38x_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 10,
 		.power_usage		= 5,
