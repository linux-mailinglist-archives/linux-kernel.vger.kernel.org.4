Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EB96C6997
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjCWNem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjCWNek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:34:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C4723C41;
        Thu, 23 Mar 2023 06:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679578479; x=1711114479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xsZovgnVI6YXdKsMNC55Uvzf/XWrC47HO9Z29rxh3Y4=;
  b=IDp8fDpnR1JpIls0WHcJEaB692RTcT9jXnIyZhruMJZVIRHlqRH6v5Ty
   zLVcLq3MMVaHpfwdXqb9nQDA/OeLkk1RPylW5KlkGAfH0tVVBvxGutNGu
   mnbz1wny9nfwa8paxFdGAe8FqvHwzTdI86lHq9I412uxpRLmuTk0pxWSv
   B+hh7conUy6SFthuPD8CnAL+2pk7LDi4bcGLDWWhTjsKqs5aLibXENU9X
   ZLSn+PWqsOLjECeG4l4MtCPY51FHpwpQ/YcuwMy8by2pk8bD0Vgazv90e
   wFLXk+niZ44ScI1VgsajEUdMZgpVWj3Ywmiqzf4hNTMWO7H5NWrmJvw2E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339520915"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="339520915"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 06:34:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675701403"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="675701403"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 06:34:37 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] srcu: Fix flush srcu structure's->sup work warning in cleanup_srcu_struct()
Date:   Thu, 23 Mar 2023 21:46:21 +0800
Message-Id: <20230323134621.336832-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When unloading rcutorture kmod will trigger the following callstack:

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

flush_delayed_work()
->__flush_work()
   ->if (WARN_ON(!work->func))
        return false;

For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU(),
when compiling and loading as modules, the srcu_module_coming() is
invoked, allocate memory for srcu structure's->sda and initialize
sda structure, due to not fully initialize srcu structure's->sup,
so at this time the sup structure's->work.work.func is null, if not
invoke init_srcu_struct_fields() before unloading modules, the
__flush_work() be invoked in srcu_module_going() and find work->func
is empty, will raise the warning above.

This commit add the check of srcu_sup structure's->srcu_gp_seq_needed
to determine whether the check_init_srcu_struct() has been invoked to
initialize srcu objects in srcu_module_going(), if not initialize, there
are no pending or running works, so there is no need to flush, only invoke
free_percpu() to release srcu structure's->sda.

Co-developed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/srcutree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1fb078abbdc9..edf894e3b96e 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1921,7 +1921,6 @@ static int srcu_module_coming(struct module *mod)
 		ssp->sda = alloc_percpu(struct srcu_data);
 		if (WARN_ON_ONCE(!ssp->sda))
 			return -ENOMEM;
-		init_srcu_struct_data(ssp);
 	}
 	return 0;
 }
@@ -1931,9 +1930,14 @@ static void srcu_module_going(struct module *mod)
 {
 	int i;
 	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
+	struct srcu_struct *ssp;
 
-	for (i = 0; i < mod->num_srcu_structs; i++)
-		cleanup_srcu_struct(*(sspp++));
+	for (i = 0; i < mod->num_srcu_structs; i++) {
+		ssp = (*sspp++);
+		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)))
+			cleanup_srcu_struct(ssp);
+		free_percpu(ssp->sda);
+	}
 }
 
 /* Handle one module, either coming or going. */
-- 
2.25.1

