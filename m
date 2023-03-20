Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0BA6C0947
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCTDUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCTDTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:19:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13681168A9;
        Sun, 19 Mar 2023 20:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679282387; x=1710818387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y/3oX6k69l7HpvCmddKmZ0LkHuSXoSFxCBBErt+mKrU=;
  b=QJ5+KqwesqfuYsrmzFnJ8OeyOCYLT0YOCXHMSFHvXoXmXRJcM7mrKN4d
   gLCJ35VtZvZLqPHrPB1DwzxN+J9p2xvNvANWuUyk50iq/4i89CXR/cXuG
   PXlYrxrsdZaMipvsD4lryLMjlXs0NYf4E9OMySVdAUlPCCjEk9G1ZG7vl
   dlUYfpefKmHmySbFuBr19NmOCsFZLa7BcasCdlvbHqNeQjNVroodmTPe+
   qXWWjxKNg3tqFy0p1MGl8xOyQQczd6LhjaXKNoH7HvDQ9EA/wOqDS+MDU
   fzg3c2A/uPOo/v7Mb0zylG/1QdNdSj9/rBQk7jLgRJF+4kTWCvyJDl47y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="337280867"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="337280867"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 20:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="770032018"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="770032018"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 20:19:45 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcutorture: Convert schedule_timeout_uninterruptible() to mdelay() in rcu_torture_stall()
Date:   Mon, 20 Mar 2023 11:24:22 +0800
Message-Id: <20230320032422.4010801-1-qiang1.zhang@intel.com>
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

Suggested-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d06c2da04c34..a08a72bef5f1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2472,7 +2472,7 @@ static int rcu_torture_stall(void *args)
 #ifdef CONFIG_PREEMPTION
 				preempt_schedule();
 #else
-				schedule_timeout_uninterruptible(HZ);
+				mdelay(jiffies_to_msecs(HZ));
 #endif
 			} else if (stall_no_softlockup) {
 				touch_softlockup_watchdog();
-- 
2.25.1

