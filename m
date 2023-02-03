Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA4688FBF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjBCGgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjBCGf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:35:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303698C1EE;
        Thu,  2 Feb 2023 22:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675406153; x=1706942153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MgxvjTKf5mNizCRob2Fn1KxHBq1yI368snScIZruVlE=;
  b=nCs5BRCEqgo73s1Lpawe+PAovCbk4SMVMb4jOS27OjIib5dBjwVhPBrQ
   sfbFOIOxgi41A1UjvWEoNohzdKESrN/cC/uEheC65Cbg9fsf5kBa9/N/H
   X9TVeK4NibV+N2wn2H20kHulHVpQeCISyw6F0RHDsxeKl3JZjMwCCwMCR
   ADPXNIE9kQFgHY0uAsa/JJxSHePW0gRLTlebu4dpOMvGzSXch8gyCJw3R
   itpM8IuTYdMh1gGAxXIJ0VIiW2l+RIo+VsConyqBRdZpGGE1FzTkZ3Dww
   1xGMxAi1TlDGFdTVvW8QWnGVD5OMt/4HntWYDJZ7HrcDElJpTgvEiyCVC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393262862"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="393262862"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 22:35:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="808239720"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="808239720"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 22:35:47 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] rcutorture: Create nocb tasks only for rcu testing and CONFIG_RCU_NOCB_CPU=y kernel
Date:   Fri,  3 Feb 2023 14:40:54 +0800
Message-Id: <20230203064054.3418539-1-qiang1.zhang@intel.com>
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
to toggle CPU's callback-offload state, but this is meaningless for non-rcu
testing or CONFIG_RCU_NOCB_CPU=n kernel create nocb tasks to periodically
toggle CPU's callback-offload state and adds unnecessary testing overhead.

This commit therefore add checks for cur_ops types and CONFIG_RCU_NOCB_CPU
options when nocbs_nthreads is non-zero to avoid unnecessary nocb task
creation.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 297da28ce92d..d01127e0e8cd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3708,6 +3708,12 @@ rcu_torture_init(void)
 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
 		fqs_duration = 0;
 	}
+	if (nocbs_nthreads != 0 && (cur_ops != &rcu_ops ||
+					!IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
+		pr_alert("rcu-torture types: %s and CONFIG_RCU_NOCB_CPU=%d, nocb toggle disabled.\n",
+				cur_ops->name, IS_ENABLED(CONFIG_RCU_NOCB_CPU));
+		nocbs_nthreads = 0;
+	}
 	if (cur_ops->init)
 		cur_ops->init();
 
-- 
2.25.1

