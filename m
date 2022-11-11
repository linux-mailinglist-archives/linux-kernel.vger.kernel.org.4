Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDCA6257B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiKKKNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiKKKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:13:21 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7973EE20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:13:18 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7vZQ4bVTzbndc;
        Fri, 11 Nov 2022 18:09:34 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 18:13:17 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 18:13:16 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <mhiramat@kernel.org>
CC:     <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <rostedt@goodmis.org>,
        <joe.lawrence@redhat.com>, <zhaogongyi@huawei.com>,
        <lihuafei1@huawei.com>
Subject: [PATCH] kprobes: Update ftrace_ops when clearing ftrace-based aggrprobe's post_handler
Date:   Fri, 11 Nov 2022 18:10:06 +0800
Message-ID: <20221111101006.239177-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __unregister_kprobe_top(), if the currently unregistered probe has
post_handler but other child probes of the aggrprobe do not have
post_handler, the post_handler of the aggrprobe is cleared. If this is
a ftrace-based probe, there is a problem. In later calls to
disarm_kprobe(), we will use kprobe_ftrace_ops because post_handler is
NULL. But we're armed with kprobe_ipmodify_ops. This triggers a WARN in
__disarm_kprobe_ftrace() and may even cause use-after-free:

  Failed to disarm kprobe-ftrace at kernel_clone+0x0/0x3c0 (error -2)
  WARNING: CPU: 5 PID: 137 at kernel/kprobes.c:1135 __disarm_kprobe_ftrace.isra.21+0xcf/0xe0
  Modules linked in: testKprobe_007(-)
  CPU: 5 PID: 137 Comm: rmmod Not tainted 6.1.0-rc4-dirty #18
  [...]
  Call Trace:
   <TASK>
   __disable_kprobe+0xcd/0xe0
   __unregister_kprobe_top+0x12/0x150
   ? mutex_lock+0xe/0x30
   unregister_kprobes.part.23+0x31/0xa0
   unregister_kprobe+0x32/0x40
   __x64_sys_delete_module+0x15e/0x260
   ? do_user_addr_fault+0x2cd/0x6b0
   do_syscall_64+0x3a/0x90
   entry_SYSCALL_64_after_hwframe+0x63/0xcd
   [...]

For ftrace kprobe, update post_handler at the same time update
ftrace_ops, moving it from kprobe_ipmodify_ops to kprobe_ftrace_ops.

Fixes: 0bc11ed5ab60 ("kprobes: Allow kprobes coexist with livepatch")
Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 kernel/kprobes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cd9f5a66a690..f8bec48a9cf9 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1766,7 +1766,17 @@ static int __unregister_kprobe_top(struct kprobe *p)
 				if ((list_p != p) && (list_p->post_handler))
 					goto noclean;
 			}
-			ap->post_handler = NULL;
+			/*
+			 * For ftrace kprobe, we need to update ftrace_ops
+			 * at the same time as we update post_handler, moving
+			 * it from kprobe_ipmodify_ops to kprobe_ftrace_ops.
+			 */
+			if (unlikely(kprobe_ftrace(ap))) {
+				disarm_kprobe(ap, false);
+				ap->post_handler = NULL;
+				arm_kprobe(ap);
+			} else
+				ap->post_handler = NULL;
 		}
 noclean:
 		/*
-- 
2.17.1

