Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A859B6BFA35
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCRNUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRNUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:20:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B53712BD8;
        Sat, 18 Mar 2023 06:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679145599; x=1710681599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4yNcKM9zVdmfoXuxxRmQqn/SArvovMwG9AXxCmxyH8E=;
  b=C+YXQlIE2reC6R2128NNrF+GoE7Z6vni1zb3Uak1+AQOdATrT88n/zmY
   9XGib+e3nTGkIKZqYRGI//6ygZ/3Bh3OoyjGEemoNJvaJPU2wM7VSgllZ
   39EiUI3iNCP2IyyNSJGL67NsgCcziwWBdyZQ/WjonBKKwbl6XJq+tnAef
   rZpHp+UUjCjBVKtzsCCct48Wnh1Vxs8eK0XqQ+TtLs8WwrjSQhmT6UdMa
   cKy1iY+8d6264QT62PaeQgBJL5tC9YhR8yiBuKehwhjfl1ofj1F2Cp8jf
   OTAy0jnUa9nyq29QNpUvM372RCJFTrWkikUSYRfBSZjVdNfDt5N7x7idI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="424711112"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="424711112"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 06:19:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="744845455"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="744845455"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 06:19:57 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Fix incorrect trace string in rcu_boost_kthread()
Date:   Sat, 18 Mar 2023 21:24:35 +0800
Message-Id: <20230318132435.3671003-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the trace string information before and after rcu_wait()
and schedule_timeout_idle() are reversed, this commit therefore
switches these strings in order to correctly trace.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7b0fe741a088..7b622b5196a8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1114,10 +1114,10 @@ static int rcu_boost_kthread(void *arg)
 	trace_rcu_utilization(TPS("Start boost kthread@init"));
 	for (;;) {
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_WAITING);
-		trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
+		trace_rcu_utilization(TPS("Start boost kthread@rcu_wait"));
 		rcu_wait(READ_ONCE(rnp->boost_tasks) ||
 			 READ_ONCE(rnp->exp_tasks));
-		trace_rcu_utilization(TPS("Start boost kthread@rcu_wait"));
+		trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_RUNNING);
 		more2boost = rcu_boost(rnp);
 		if (more2boost)
@@ -1126,9 +1126,9 @@ static int rcu_boost_kthread(void *arg)
 			spincnt = 0;
 		if (spincnt > 10) {
 			WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_YIELDING);
-			trace_rcu_utilization(TPS("End boost kthread@rcu_yield"));
-			schedule_timeout_idle(2);
 			trace_rcu_utilization(TPS("Start boost kthread@rcu_yield"));
+			schedule_timeout_idle(2);
+			trace_rcu_utilization(TPS("End boost kthread@rcu_yield"));
 			spincnt = 0;
 		}
 	}
-- 
2.25.1

