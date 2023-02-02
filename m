Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD95687616
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjBBG5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBG5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:57:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E2818ABE;
        Wed,  1 Feb 2023 22:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675321060; x=1706857060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wzqp+Jk3onerpOsKwl6dtIABBtz+CT+6UyzxpOGfv20=;
  b=EAhOvgqye7/fgluD6+RSdoHwWZlr5MrcOMBNjDfQIYB4yP+g/nuiCpAs
   +93L4mCD8W9PLp6A4a/fHfpzOMoF+9zJt7tjqTB25XNZYKu3QWGjRvBZt
   0QLoG5796h45eEF0ioFc7dozAlDxKQaVjLprErZr5SfXm7ig5wAxdA2kY
   vMnZm0y6LOgdy37FvbLbLVTBOERK4m9wIHQwvHevZ/mEjtHdlgFgapp7X
   0pBVa0rP4VmWv2Kh9/0l8akQMlZ6W14Zyg15s4pUVO9d+FCd0F1Y+wJO+
   k4Hdu3jxTETEUz+hy7I6Y0O0Afrnt4VrO/9YFRxK099dFVYW3xALUJtRN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="326069302"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="326069302"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 22:57:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="773747679"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="773747679"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 22:57:38 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcutorture: Create nocb tasks only for CONFIG_RCU_NOCB_CPU=y kernels
Date:   Thu,  2 Feb 2023 15:02:45 +0800
Message-Id: <20230202070245.3311951-1-qiang1.zhang@intel.com>
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
index 297da28ce92d..ced0a8e1d765 100644
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
+	if (!cur_ops->can_nocbs_toggle && nocbs_nthreads != 0) {
+		pr_alert("rcu-torture: ->can_nocbs_toggle false and non-zero nocbs_nthreads, nocbs_toggle disabled.\n");
+		nocbs_nthreads = 0;
+	}
 	if (cur_ops->init)
 		cur_ops->init();
 
-- 
2.25.1

