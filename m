Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D9C64D5B9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 04:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiLODwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 22:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLODw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 22:52:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36D355A9A;
        Wed, 14 Dec 2022 19:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671076348; x=1702612348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jj0nRxwLU+V9DN32BOIUegCyAzKtt5gtTufXftUHSM0=;
  b=LVWjSKuZ8h0878O05tqQD4XdHPiISEquswn0Jmek2aezpUG6FjHTGPWA
   luAct5T3ckBr/Wbvxn3a0JveF1NNcJu1DjsCZzr4SQ9m+c+vh1kh1VK62
   +SEdOMTxVgEOKmKcUzpZkgFrBiW6Y0nXz/ZiB3ygR0rRloXB74ANSdDot
   M7e399Abykl8w6kCGYbd3gnI57Tc7OIe2ycYlgagM3YOWkyd3/M/S11TT
   W+WnC/olHiJS/rSNaxk77NhsN/3WEJ4iArorL90sZSyxDcl90YmEdb3cc
   nVvbqNEXU0hnyjTQz14ECEetMfDh2kE4QgFXF8ihYEhgKj2dF7aGTH9ON
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="298922376"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="298922376"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 19:52:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="773564476"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="773564476"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 19:52:17 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Fix opposite might_sleep() check in rcu_blocking_is_gp()
Date:   Thu, 15 Dec 2022 11:57:55 +0800
Message-Id: <20221215035755.2820163-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if the system is in the RCU_SCHEDULER_INACTIVE state, invoke
synchronize_rcu_*() will implies a grace period and return directly,
so there is no sleep action due to waiting for a grace period to end,
but this might_sleep() check is the opposite. therefore, this commit
puts might_sleep() check in the correct palce.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee8a6a711719..65f3dd2fd3ae 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3379,9 +3379,10 @@ void __init kfree_rcu_scheduler_running(void)
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
2.25.1

