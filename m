Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7B264D816
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLOIzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiLOIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:54:55 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E112C658;
        Thu, 15 Dec 2022 00:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671094494; x=1702630494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uev9S5ocS7bK1HqwVkJ4NTAo0vUxSsTQB2xMcXsLcAw=;
  b=BreZfMrcKeDrDHjqakC9qCEOaVT0kB8LX7nZGM4l9SneICIpU5VOqNoo
   BZjOa/ODz0lVlSOPsprms1m5NbqRIFDDD7b4SYAQJhokjcb8F8lKbBxeF
   V72gvUaU4xelSlSIu49c6wIe9ztV4yw/6Kdb+QhinuM7CXnCDle2A6iU2
   nA4VAnXTTAy9r+iivJctEx3NDDngO09Nuq86tQ1SUWO0vm0I/K3MKzwfj
   QSPslb11JnOUtNCAeKFgGGADKL9AP8YUp/BVxXMJtBjQg8+8SEUwY4Wql
   pT04XGQcsI5R7QErCb5a1wdnHp9g/DeKQ5i3UTjeE2loMOquyzUgqnMHW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="316263154"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="316263154"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 00:54:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="642838888"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="642838888"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 00:54:52 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Remove duplicate settings for rcu boost kthreads affinity
Date:   Thu, 15 Dec 2022 17:00:29 +0800
Message-Id: <20221215090029.2972236-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when CPUs going offline, the rcu boost kthreads CPU
affinity has been reset in rcutree_offline_cpu(), therefore this
commit remove duplicate settings in rcutree_dead_cpu().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 65f3dd2fd3ae..20de83ed0c7e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4122,15 +4122,10 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
  */
 int rcutree_dead_cpu(unsigned int cpu)
 {
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
-
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
-	/* Adjust any no-longer-needed kthreads. */
-	rcu_boost_kthread_setaffinity(rnp, -1);
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
 	return 0;
-- 
2.25.1

