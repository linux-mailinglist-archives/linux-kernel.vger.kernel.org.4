Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4EF65E183
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbjAEAXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbjAEAXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:23:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25D4435A;
        Wed,  4 Jan 2023 16:23:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CE8AB81982;
        Thu,  5 Jan 2023 00:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E02FC433A4;
        Thu,  5 Jan 2023 00:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878188;
        bh=2WSJ8n/mVkUaqRO+2OU4uVBj5A9i4K7XPBfFkEnpujQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPKGOamfbyj/w6a6jbRFZwcg+TgZGWBmQ0+ZtF5mmm9iETuuYIIXFn89wPPPupKtV
         A/KwX+0ZZCcRtmqQi2QN/WjEkyAqCwkMxnd/jDwdo9mkAJlK/YBPH8t+xhaAiK2tIL
         HGLaWf+om9DQsYS1jREDI2jqwkZX8YcV9tucW61XOq2RvCZz7eAK+XDE+yfkBFG5rQ
         B3PzYb/nsPPDop+EZ+DR5+Y7T9MQmWAye2coVn+SrNELR7O5ebEOQhKS4f0vy5q70U
         4fbvSSxTtmFu27iqzWxQrhG7Qg5bT41Kg3l+cYL6nYe028t/yjWIVKccq3zECCjubv
         ygU8w6/RzQdTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7F4CE5C1AE0; Wed,  4 Jan 2023 16:23:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 07/10] rcu: Make rcu_blocking_is_gp() stop early-boot might_sleep()
Date:   Wed,  4 Jan 2023 16:23:02 -0800
Message-Id: <20230105002305.1768591-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
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

Currently, rcu_blocking_is_gp() invokes might_sleep() even during early
boot when interrupts are disabled and before the scheduler is scheduling.
This is at best an accident waiting to happen.  Therefore, this commit
moves that might_sleep() under an rcu_scheduler_active check in order
to ensure that might_sleep() is not invoked unless sleeping might actually
happen.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0147e69ea85a9..15f9765064727 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3333,9 +3333,10 @@ void __init kfree_rcu_scheduler_running(void)
  */
 static int rcu_blocking_is_gp(void)
 {
-	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE)
+	if (rcu_scheduler_active != RCU_SCHEDULER_INACTIVE) {
+		might_sleep();
 		return false;
-	might_sleep();  /* Check for RCU read-side critical section. */
+	}
 	return true;
 }
 
-- 
2.31.1.189.g2e36527f23

