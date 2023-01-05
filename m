Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A809A65E200
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjAEAuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjAEAuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:50:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDD658318;
        Wed,  4 Jan 2023 16:46:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C85686189D;
        Thu,  5 Jan 2023 00:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E7EC433F1;
        Thu,  5 Jan 2023 00:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879503;
        bh=HEwgkfItho+scdtz7EMh//sZ9TZpxPJIVeZwBitEPbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQureTlSGVqziMDCkl6CBkxBIl/wji10X2T/xwK6J4INqCDExjd4j+B3rDy9T0HS0
         C3iSONGip2Ym678wJH7gmmSDx8tDAgzLXwlpg5MX376HWtMBz2EwAvpSfV7qSPh9oH
         6Y77ejI6pC8ylHgjTObWCACt6+F6+QVjQeT3WkCOnVsSyl0zU6phny4+/Cz9xalx4M
         gGOkrqlLi1sYEGR17OD2FxDgnB/UbDix00q7cd4VbtuRGhlDFey6+pE2vkjLfsAFfV
         iRbiKof/gRaTgPzLsN7771VpB+ZCIV9tWgUvr48YBNP13BX6lvmJlG01pwyOI466RR
         zhT9n+2BRDYrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D7B9B5C05CA; Wed,  4 Jan 2023 16:45:02 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/6] rcu-tasks: Use accurate runstart time for RCU Tasks boot-time testing
Date:   Wed,  4 Jan 2023 16:44:49 -0800
Message-Id: <20230105004501.1771332-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
References: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

Currently, test_rcu_tasks_callback() reads from the jiffies counter only
once when this function is invoked.  This introduces inaccuracies because
of the latencies induced by the synchronize_rcu_tasks*() invocations.
This commit therefore re-reads the jiffies counter at the beginning
of each test, thus avoiding penalizing later tests for the latencies
induced by earlier tests.

Therefore, this commit at the start of each RCU Tasks test, re-fetch the
jiffies time as the runstart time.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fe9840d90e960..c418aa1c038a9 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1815,23 +1815,21 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
 
 static void rcu_tasks_initiate_self_tests(void)
 {
-	unsigned long j = jiffies;
-
 	pr_info("Running RCU-tasks wait API self tests\n");
 #ifdef CONFIG_TASKS_RCU
-	tests[0].runstart = j;
+	tests[0].runstart = jiffies;
 	synchronize_rcu_tasks();
 	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_RUDE_RCU
-	tests[1].runstart = j;
+	tests[1].runstart = jiffies;
 	synchronize_rcu_tasks_rude();
 	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_TRACE_RCU
-	tests[2].runstart = j;
+	tests[2].runstart = jiffies;
 	synchronize_rcu_tasks_trace();
 	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
 #endif
-- 
2.31.1.189.g2e36527f23

