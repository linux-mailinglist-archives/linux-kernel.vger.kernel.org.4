Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282016C06D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCTA2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTA2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:28:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B7E1284A;
        Sun, 19 Mar 2023 17:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679272122; x=1710808122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lyXTxJMbbk8wy2ewc/Bwdw41SIVEUEcTA92IvbzzJ8Q=;
  b=kE8NkJa8+l5I+MNv2RUhvExaxYu2nBuKtMJM4z1BuWhWJcHp518DO9YZ
   2lqip9rSO6fghmla4JzTJ9UVV6xit/luz3azqSmehoDxkeJv6Sat8IwPd
   H5JmEAwKP0Q6ZYJfPLSCka63Q8qdIRXGtMWA0EJn5Z/AXg9Dc2SeHxrar
   GVgiQIb5jv6vt1FhOmkd49FWnGD+XF/WXKqfuivJjtpycFotnD2sXUr/W
   7FsdDfygd76t2e0UonRAbLnwqdQbhK1LwWECaz2tjYF76njD6s06ZTTyM
   19yTBxzMcqveTNVAjunRnQGHF+Y7vmiIqIHXMWxH6VWBRxL/aXccqcTiH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="424824675"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="424824675"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 17:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="674163012"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="674163012"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 17:28:39 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Convert schedule_timeout_uninterruptible() to mdelay() in rcu_torture_stall()
Date:   Mon, 20 Mar 2023 08:33:16 +0800
Message-Id: <20230320003316.3897447-1-qiang1.zhang@intel.com>
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

For kernels built with enable PREEMPT_NONE and CONFIG_DEBUG_ATOMIC_SLEEP,
running the RCU stall tests.

runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4"
bootparams="nokaslr console=ttyS0 rcutorture.stall_cpu=30
rcutorture.stall_no_softlockup=1 rcutorture.stall_cpu_irqsoff=1
rcutorture.stall_cpu_block=1" -d

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

The above calltrace occurs in the local_irq_disable/enable() critical
section call schedule_timeout(), and invoke schedule_timeout() also
implies a quiescent state, of course it also fails to trigger RCU stall,
this commit therefore use mdelay() instead of schedule_timeout() to
trigger RCU stall.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d06c2da04c34..fe4f5a4074e3 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2472,7 +2472,7 @@ static int rcu_torture_stall(void *args)
 #ifdef CONFIG_PREEMPTION
 				preempt_schedule();
 #else
-				schedule_timeout_uninterruptible(HZ);
+				mdelay(HZ);
 #endif
 			} else if (stall_no_softlockup) {
 				touch_softlockup_watchdog();
-- 
2.25.1

