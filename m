Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870AD669754
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbjAMMdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbjAMMcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF815132E;
        Fri, 13 Jan 2023 04:31:10 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJj1Ihp5HQNm3eP2yvjGdkDtetNs/i3WmJ1/xIAoosc=;
        b=rFhiTx3JA2agohDm++lwQVQcwRpB3G4Z7G/K53a31g5ePPvgJM2bAiCKHFQM9+2KCq+HIT
        ANRpFgthcYclvnAtCQB9cQRhdpZ+F7uvecQbn6BdieALKPZ/Qmqp3iaYwtvieStKwi54AT
        l6zTyq31YBU1h/Zb0ltkZ/udEx1HKxPhTVs8+LB4w7xylakhAoaDBr/VtlB/wt8XtawQL1
        NviWb5ID8tPfxG29vPutsq5m1nwBCC5VRVo2H+bIxjRiskAYLf3Lw8OQkDEcsqvPjPY7qr
        mwsSYOmOLrJMujPOsTOHqpq1CZcYaHzmL2dymCm5GAJIO1ZNVt+FJOq4d2c4DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJj1Ihp5HQNm3eP2yvjGdkDtetNs/i3WmJ1/xIAoosc=;
        b=BQVdOBaOEwbkUy9LdGyntbFAxHT+998s+jZYuFmAgTPp2h1eV7L3qcpeFQYP3kjgD2ZBxJ
        wJrfmzX/TA4XXUBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, clk: Remove trace_.*_rcuidle()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.844982902@infradead.org>
References: <20230112195541.844982902@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306675.4906.5551268690310641457.tip-bot2@tip-bot2>
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

Commit-ID:     ca502fc6d9d90c8384eb3e97e964177521d9df48
Gitweb:        https://git.kernel.org/tip/ca502fc6d9d90c8384eb3e97e964177521d9df48
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:17 +01:00

cpuidle, clk: Remove trace_.*_rcuidle()

OMAP was the one and only user.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.844982902@infradead.org
---
 drivers/clk/clk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e62552a..f6d7c6a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1055,12 +1055,12 @@ static void clk_core_disable(struct clk_core *core)
 	if (--core->enable_count > 0)
 		return;
 
-	trace_clk_disable_rcuidle(core);
+	trace_clk_disable(core);
 
 	if (core->ops->disable)
 		core->ops->disable(core->hw);
 
-	trace_clk_disable_complete_rcuidle(core);
+	trace_clk_disable_complete(core);
 
 	clk_core_disable(core->parent);
 }
@@ -1114,12 +1114,12 @@ static int clk_core_enable(struct clk_core *core)
 		if (ret)
 			return ret;
 
-		trace_clk_enable_rcuidle(core);
+		trace_clk_enable(core);
 
 		if (core->ops->enable)
 			ret = core->ops->enable(core->hw);
 
-		trace_clk_enable_complete_rcuidle(core);
+		trace_clk_enable_complete(core);
 
 		if (ret) {
 			clk_core_disable(core->parent);
