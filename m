Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378D86C29D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCUFZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCUFZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:25:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C4D3B0E0;
        Mon, 20 Mar 2023 22:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679376270; x=1710912270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WIoVvAkmRwdIk8RpBsrQeOKQhl/bXKbU5Sl7z6ngXk8=;
  b=eVXpNA2djoiHAz515QnV3jRQr6jMGd/L3OhXSRqx+27xMlBVt9rdqHb9
   IGZspVlfm9k+XQ5QZXFlxaO97QwDT/JqrrZMlnDot0neeSj2ujgIAxuOy
   9bLNIcc6+ZV+6lpoVKfQjUjoLNRtzFhy72j0jXoqXz2ju2WlQN/M6A8FE
   vkXgCwd76ehNxwMCKFJ79xgzWAIQ9AR9B3aGg2T3Dt1m0KxO2vuVgbI24
   phCQIrIL5CSi2RDs6Osm2/IesG07Xr3B92PAnX7AKj+pQKr5pIvtz3fFE
   lOUgR3SaEaoiJM+xC1fCrkj4UeVSKvki1cQK21/UNvN+IZjGHl/06lIU3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="337571150"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="337571150"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="750397879"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="750397879"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:24:26 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     paulmck@kernel.org
Cc:     dave@stgolabs.net, frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        qiuxu.zhuo@intel.com, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, rostedt@goodmis.org
Subject: [PATCH v3 2/2] rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale
Date:   Tue, 21 Mar 2023 13:23:37 +0800
Message-Id: <20230321052337.26553-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230321052337.26553-1-qiuxu.zhuo@intel.com>
References: <72ba8619-88cb-4bf4-8232-18d8a1b6b5bf@paulmck-laptop>
 <20230321052337.26553-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the 'kfree_rcu_test' test case with commands [1] the call
trace [2] was thrown. This was because the kfree_scale_thread thread(s)
still run after unloading rcuscale and torture modules. Fix the call
trace by invoking kfree_scale_cleanup() from rcu_scale_cleanup() when
removing the rcuscale module.

[1] modprobe rcuscale kfree_rcu_test=1
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
v1 -> v2:

 - Move rcu_scale_cleanup() after kfree_scale_cleanup() to eliminate the
   declaration of kfree_scale_cleanup().

 - Remove the unnecessary step "modprobe torture" from the commit message.

 - Add the description for why move rcu_scale_cleanup() after
   kfree_scale_cleanup() to the commit message.

v2 -> v3:

 - Split the single v2 patch into two patches.

 - Move the commit message description for why move rcu_scale_cleanup()
   after kfree_scale_cleanup() to Patch 1.

 kernel/rcu/rcuscale.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index e99096a4f094..5a000d26f03e 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -797,6 +797,11 @@ rcu_scale_cleanup(void)
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

