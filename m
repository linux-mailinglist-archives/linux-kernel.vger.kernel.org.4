Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E676C27D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCUCIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCUCIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:08:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C2F9EC3;
        Mon, 20 Mar 2023 19:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679364500; x=1710900500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SGLovbWZIElFZLDpV9vpB/8mL3+r7tu+YDWIR/1tseo=;
  b=Wqok2+HLCE41/lX9yAK8+l4zj9+FBNahI4BjmqAHbDkWh1mK968PMCsV
   tn7EiF3jVI/xN68XrjxcrigXfoGtzsGRYH31tHe1Iq5wBbIJDyr4jVHn2
   gLLPrjLRg8WAth3N4fHsg9zyT8x5nSidUxbmu2zXokv/FVkIp9WlvX0Rg
   i190ziZgXTnftNfkenXBuURbNc1r9SPq8040Z8tlpZxOjEVAi1eDdWpj2
   r5iB/uI7yL9hK6alMpUMhHbFnMdEZLsOx6q4cuAqm4FiDhJH9FqjV8E4e
   SKVBopkriKH9b7bC/V0xJp7llcDwyR481//YojU7fK3UGdPK9wELRhI5X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="366553525"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="366553525"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 19:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="681345970"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="681345970"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 19:07:58 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] doc/rcutorture: Add description of rcutorture.stall_cpu_block
Date:   Tue, 21 Mar 2023 10:12:34 +0800
Message-Id: <20230321021234.51431-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kernels built with CONFIG_PREEMPTION=n and CONFIG_PREEMPT_COUNT=y,
run the RCU stall tests.

runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4"
bootparams="console=ttyS0 rcutorture.stall_cpu=30
rcutorture.stall_no_softlockup=1 rcutorture.stall_cpu_block=1" -d

[   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
[   10.841073] rcu_torture_stall start on CPU 3.
[   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x0000000
....
[   10.841108] Call Trace:
[   10.841110]  <TASK>
[   10.841112]  dump_stack_lvl+0x64/0xb0
[   10.841118]  dump_stack+0x10/0x20
[   10.841121]  __schedule_bug+0x8b/0xb0
[   10.841126]  __schedule+0x2172/0x2940
[   10.841157]  schedule+0x9b/0x150
[   10.841160]  schedule_timeout+0x2e8/0x4f0
[   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
[   10.841195]  rcu_torture_stall+0x2e8/0x300
[   10.841199]  kthread+0x175/0x1a0
[   10.841206]  ret_from_fork+0x2c/0x50

Due to invoke schedule_timeout() forces the CPU to go through a
quiescent state, cause RCU stall not appear and also cause scheduling
while atomic complaints. so this commit add description of
rcutorture.stall_cpu_block, it should not to be set in CONFIG_PREEMPTION=n
kernels.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6734d1255682..56f4eb8c7cf2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5053,6 +5053,11 @@
 			Sleep while stalling if set.  This will result
 			in warnings from preemptible RCU in addition
 			to any other stall-related activity.
+			Note that for CONFIG_PREEMPTION=n kernel, if set.
+			will forces the CPU to go through a quiescent state
+			and it can also cause scheduling-while-atomic
+			complaints(CONFIG_PREEMPT_COUNT=y), so should not be set.
+
 
 	rcutorture.stall_cpu_holdoff= [KNL]
 			Time to wait (s) after boot before inducing stall.
-- 
2.25.1

