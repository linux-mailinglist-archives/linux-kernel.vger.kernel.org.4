Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81A6B70DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCMIHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCMIHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:07:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6932726;
        Mon, 13 Mar 2023 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678694682; x=1710230682;
  h=from:to:cc:subject:date:message-id;
  bh=gDIv4qJwZoJtfa0NlmSgzOfssIbCR1lN3aQEVECdGbc=;
  b=Xdz1IslvmvmSeBFCow1Z1C8RwiNWoLArogskr9YJTzNfuqOLa7YQziEU
   bfMEN2+1bFe+RQeWc+++1IoHfZ0JoItyJbPfXXRTpS0qWsXUrTQXWIEos
   8cYiZOmtHeOSMocjC1s1c+r8ETAPR9K01L3iXW32a9KMKJXRNhNeziEqB
   /Px9ZwkoS4DBGQsOPu1+I7JkiOR6lYVweVFwcp/cwr+fS8y/VlaBBTbY8
   y/MICqH9qE4IL5zEuOp/mAIZijjbwovwznb6eGO3f38MGN1VS3V/Vd1UV
   Qv3ESVojcv7xgz+Za0bslJ6zvT7NN7M0XuOpJvffOyaXVrB/eqhZ6JLGd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="399682281"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="399682281"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 01:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="708784876"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="708784876"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.105])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 01:04:34 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale
Date:   Mon, 13 Mar 2023 16:04:03 +0800
Message-Id: <20230313080403.89290-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the 'kfree_rcu_test' test case with commands [1] the call
trace [2] was thrown. This was because the kfree_scale_thread thread(s)
still run after unloading rcuscale and torture modules. Fix the call
trace by invoking kfree_scale_cleanup() when removing the rcuscale module.

[1] modprobe torture
    modprobe rcuscale kfree_rcu_test=1
    // After some time
    rmmod rcuscale
    rmmod torture

[2] BUG: unable to handle page fault for address: ffffffffc0601a87
    #PF: supervisor instruction fetch in kernel mode
    #PF: error_code(0x0010) - not-present page
    PGD 11de4f067 P4D 11de4f067 PUD 11de51067 PMD 112f4d067 PTE 0
    Oops: 0010 [#1] PREEMPT SMP NOPTI
    CPU: 1 PID: 1798 Comm: kfree_scale_thr Not tainted 6.3.0-rc1-rcu+ #1
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
    RIP: 0010:0xffffffffc0601a87
    Code: Unable to access opcode bytes at 0xffffffffc0601a5d.
    RSP: 0018:ffffb25bc2e57e18 EFLAGS: 00010297
    RAX: 0000000000000000 RBX: ffffffffc061f0b6 RCX: 0000000000000000
    RDX: 0000000000000000 RSI: ffffffff962fd0de RDI: ffffffff962fd0de
    RBP: ffffb25bc2e57ea8 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
    R13: 0000000000000000 R14: 000000000000000a R15: 00000000001c1dbe
    FS:  0000000000000000(0000) GS:ffff921fa2200000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffffffffc0601a5d CR3: 000000011de4c006 CR4: 0000000000370ee0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
     <TASK>
     ? kvfree_call_rcu+0xf0/0x3a0
     ? kthread+0xf3/0x120
     ? kthread_complete_and_exit+0x20/0x20
     ? ret_from_fork+0x1f/0x30
     </TASK>
    Modules linked in: rfkill sunrpc ... [last unloaded: torture]
    CR2: ffffffffc0601a87
    ---[ end trace 0000000000000000 ]---

Fixes: e6e78b004fa7 ("rcuperf: Add kfree_rcu() performance Tests")
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 kernel/rcu/rcuscale.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 91fb5905a008..5e580cd08c58 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -522,6 +522,8 @@ rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
 		 scale_type, tag, nrealreaders, nrealwriters, verbose, shutdown);
 }
 
+static void kfree_scale_cleanup(void);
+
 static void
 rcu_scale_cleanup(void)
 {
@@ -542,6 +544,11 @@ rcu_scale_cleanup(void)
 	if (gp_exp && gp_async)
 		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
 
+	if (kfree_rcu_test) {
+		kfree_scale_cleanup();
+		return;
+	}
+
 	if (torture_cleanup_begin())
 		return;
 	if (!cur_ops) {
-- 
2.17.1

