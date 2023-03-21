Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541256C2BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCUIJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCUIJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:09:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377F51ABEA;
        Tue, 21 Mar 2023 01:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679386155; x=1710922155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z9MtnBK+WiQPSiqFvqevRecURoB+6gHv0DiaZceZ0pA=;
  b=VIFemrVnESMFFnI2cbQ3II1w2HHkiS1jp7BryB0cEld65sEKRJAuyiME
   ameH8Z4O467ULJZPXOt/+P8q4YUzMBKPYwWs7n2ugtDf8svcOb/F6HPYV
   19eQ5OJCZfGaCP108BIAX+xcfqtEonknGnY09hu08CnKDr/OuMH3Yf/0V
   bai3rBKeZRZ/2iA7UMOFfa6SMzKQuY1RRFL4J31rLryEdBg0SBZf9x1OY
   P5TL90mBisyvT4d4wo3+KwQqnlVfNE0aO+OGQwuKYKcwVAFLFpO+BYeeg
   /lBDWL6I9lxvzl3fSkQIbj6utKBicD+6qx+Le3KPEcQWkuuXgHTsKnoWV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="425152263"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="425152263"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 01:09:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="683762734"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="683762734"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 01:09:10 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Fix flush sup work warning in cleanup_srcu_struct()
Date:   Tue, 21 Mar 2023 16:13:46 +0800
Message-Id: <20230321081346.192000-1-qiang1.zhang@intel.com>
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

insmod rcutorture.ko
rmmod rcutorture.ko

[  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:3167 __flush_work+0x50a/0x540
[  209.437346] Modules linked in: rcutorture(-) torture [last unloaded: rcutorture]
[  209.437382] CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto-standard+
[  209.437406] RIP: 0010:__flush_work+0x50a/0x540
.....
[  209.437758]  flush_delayed_work+0x36/0x90
[  209.437776]  cleanup_srcu_struct+0x68/0x2e0
[  209.437817]  srcu_module_notify+0x71/0x140
[  209.437854]  blocking_notifier_call_chain+0x9d/0xd0
[  209.437880]  __x64_sys_delete_module+0x223/0x2e0
[  209.438046]  do_syscall_64+0x43/0x90
[  209.438062]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU(),
when compiling and loading as modules, the srcu_module_coming() is invoked,
allocate memory for srcu structure's->sda and initialize sda structure,
due to not fully initialize srcu structure's->sup, so at this time the
sup structure's->delaywork.func is null, if not invoke init_srcu_struct_fields()
before unloading modules, in srcu_module_going() the __flush_work() find
work->func is empty, will raise the warning above.

This commit add init_srcu_struct_fields() to initialize srcu structure's->sup,
in srcu_module_coming().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/srcutree.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1fb078abbdc9..42d8720e016c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct module *mod)
 		ssp->sda = alloc_percpu(struct srcu_data);
 		if (WARN_ON_ONCE(!ssp->sda))
 			return -ENOMEM;
-		init_srcu_struct_data(ssp);
+		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
+			return -ENOMEM;
 	}
 	return 0;
 }
@@ -1931,9 +1932,13 @@ static void srcu_module_going(struct module *mod)
 {
 	int i;
 	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
+	struct srcu_struct *ssp;
 
-	for (i = 0; i < mod->num_srcu_structs; i++)
-		cleanup_srcu_struct(*(sspp++));
+	for (i = 0; i < mod->num_srcu_structs; i++) {
+		ssp = *(sspp++);
+		cleanup_srcu_struct(ssp);
+		free_percpu(ssp->sda);
+	}
 }
 
 /* Handle one module, either coming or going. */
-- 
2.25.1

