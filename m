Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24D26875FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjBBGno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBBGnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:43:42 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C1C7922D;
        Wed,  1 Feb 2023 22:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675320221; x=1706856221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AbJPm8XyOE6u+c+tbjXp1HOVwUKFslPxDYdbNHssaLU=;
  b=YqunBDI1GabFPa5ymzQP3cXkrv3ms3hIshrI0rsAhtWpICi1kkiq8SEL
   2DsupdKFXxLeu9ULVcb6Mynz6uyKCp4vhg+yddU/lPISof6C88Ja3QPEg
   V0OJIl+46D6oYqNl8oHuF+exaer5M1uT9/yBQKv5jAt+BG8fuCOKmWtw4
   FhRtk3mlroAw2t3vMvuuVHBcLLfaknvF63aZ+NBKnHBegQb8nt+FNOoGO
   KTyosncJpfjx3+yNW69Iq0amW4IoHDiS+7CBVoRaS7fH+FzH7sAcnMbkr
   x388wat65IGHBR/HQzSkamFUh0xh+EL6hpRfwRqkSF9nHO6oDaA8ziZRm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="329659521"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="329659521"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 22:43:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="807862214"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="807862214"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 22:43:38 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Create nocb tasks only for CONFIG_RCU_NOCB_CPU=y kernels
Date:   Thu,  2 Feb 2023 14:48:46 +0800
Message-Id: <20230202064846.3306975-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting nocbs_nthreads to start rcutorture test with a non-zero value,
the nocb tasks will be created and invoke rcu_nocb_cpu_offload/deoffload()
to toggle CPU's callback-offload state, but for CONFIG_RCU_NOCB_CPU=n
kernel, the rcu_nocb_cpu_offload/deoffload() is a no-op and this is also
meaningless for torture_type is non-rcu.

This commit therefore add member can_nocbs_toggle to rcu_torture_ops
structure to avoid unnecessary nocb tasks creation.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/rcutorture.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 297da28ce92d..27becacbe3b2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -383,6 +383,7 @@ struct rcu_torture_ops {
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
+	int can_nocbs_toggle;
 	int extendables;
 	int slow_gps;
 	int no_pi_lock;
@@ -569,6 +570,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.stall_dur		= rcu_jiffies_till_stall_check,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
+	.can_nocbs_toggle	= IS_ENABLED(CONFIG_RCU_NOCB_CPU),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
 	.name			= "rcu"
 };
@@ -2356,7 +2358,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "read_exit_delay=%d read_exit_burst=%d "
-		 "nocbs_nthreads=%d nocbs_toggle=%d "
+		 "nocbs_nthreads=%d/%d nocbs_toggle=%d "
 		 "test_nmis=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
@@ -2368,7 +2370,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
 		 read_exit_delay, read_exit_burst,
-		 nocbs_nthreads, nocbs_toggle,
+		 nocbs_nthreads, cur_ops->can_nocbs_toggle, nocbs_toggle,
 		 test_nmis);
 }
 
@@ -3708,6 +3710,10 @@ rcu_torture_init(void)
 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
 		fqs_duration = 0;
 	}
+	if (!cur_ops->can_nocbs_toggle && nocbs_nthreads > 0) {
+		pr_alert("rcu-torture: ->can_nocbs_toggle false and non-zero nocbs_nthreads, nocbs_toggle disabled.\n");
+		nocbs_nthreads = 0;
+	}
 	if (cur_ops->init)
 		cur_ops->init();
 
-- 
2.25.1

