Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B479D632751
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiKUPHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiKUPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:06:39 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933DCCFE82;
        Mon, 21 Nov 2022 06:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669042558; x=1700578558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8QUfeKTpW+sRnX1y6HoJ/uLsh9DSsSLnb3p4CCAFZVE=;
  b=noIl2BvKcHsAMveTEtjFB/l27/vKr5ree+nGPQ+EJH4M5tZUf2g/QYQt
   pKtVt885QxByqE9hER5U6sr8nsNP4INLD8KAVYqcGF44ff2kIv0vCBojm
   PBK09AXZKM1fXwzzNIYdfokCWAHhz2H3WogRaOUdJxIwytkrrVCEbB4CM
   Wa4mmPKV207MB8boURdEojTc/3MKV0brQQ0uOztFT5brarqLO+8I0dmOC
   dzn8lBABYjXDd0mtImvKeiT3JhJUweXtW1QTmjDN3PJDZmJDXAJ8mIxTh
   M6y2sKw+kXO+w1Vqk4P2iBnZys2qJcwSJkYkjJCU6J5TZODQSpey5PnVo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="296930035"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="296930035"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 06:55:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="815736261"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="815736261"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 06:55:56 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Use accurate runstart time for RCU Tasks boot-time testing
Date:   Mon, 21 Nov 2022 23:01:50 +0800
Message-Id: <20221121150150.319715-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only get jiffies once as the runstart time for all RCU
Tasks testing. it's not accurate, for each RCU Tasks type test, since
corresponding type of synchronize_rcu_tasks*() be invoked, so before
each RCU Tasks test starts, we need to wait for the grace period of
the previous RCU Tasks test to end, there will be a deviation in the
start time of the RCU Tasks test.

Therefore, this commit at the start of each RCU Tasks test, re-fetch the
jiffies time as the runstart time.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b0b885e071fa..4a991311be9b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1813,23 +1813,21 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
 
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
2.25.1

