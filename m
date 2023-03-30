Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF3A6D0472
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjC3MO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjC3MO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:14:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE5A5240
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:14:26 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PnMhV0k1RzgZgq;
        Thu, 30 Mar 2023 20:11:06 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 20:14:23 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <chenzhongjin@huawei.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <rmk+kernel@armlinux.org.uk>, <geert@linux-m68k.org>,
        <keescook@chromium.org>
Subject: [PATCH] wchan: Fix get_wchan() when task in schedule
Date:   Thu, 30 Mar 2023 20:12:37 +0800
Message-ID: <20230330121238.176534-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_wchan() check task to unwind is not running or going to run by:
state != TASK_RUNNING && state != TASK_WAKING && !p->on_rq

However this cannot detect task which is going to be scheduled out.
For example, in this path:

  __wait_for_common(x, schedule_timeout, timeout, TASK_UNINTERRUPTIBLE)
  do_wait_for_common() // state == TASK_UNINTERRUPTIBLE
  schedule_timeout()
  __schedule()
    deactivate_task() // on_rq = 0

After this point get_wchan() can be run on the task but it is still
running actually, and p->pi_lock doesn't work for this case.

It can trigger some warning when running stacktrace on a running task.
Also check p->on_cpu to promise task is really switched out can prevent
this.

Fixes: 42a20f86dc19 ("sched: Add wrapper for get_wchan() to keep task blocked")
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..2071d1c0eaca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2041,7 +2041,8 @@ unsigned long get_wchan(struct task_struct *p)
 	raw_spin_lock_irq(&p->pi_lock);
 	state = READ_ONCE(p->__state);
 	smp_rmb(); /* see try_to_wake_up() */
-	if (state != TASK_RUNNING && state != TASK_WAKING && !p->on_rq)
+	if (state != TASK_RUNNING && state != TASK_WAKING &&
+	    !p->on_rq && !p->on_cpu)
 		ip = __get_wchan(p);
 	raw_spin_unlock_irq(&p->pi_lock);
 
-- 
2.17.1

