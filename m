Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7442E6694EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbjAMK7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbjAMK6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:58:46 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CC90459F9A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:54:28 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 4A6A611069780C;
        Fri, 13 Jan 2023 18:54:25 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Jan 2023 18:54:24 +0800
Date:   Fri, 13 Jan 2023 18:54:13 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   Tio Zhang <tiozhang@didiglobal.com>
To:     <yu.c.chen@intel.com>, <pmladek@suse.com>,
        <tiozhang@didiglobal.com>, <zyhtheonly@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: print parent comm in sched_show_task()
Message-ID: <20230113105413.GA30243@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: yu.c.chen@intel.com, pmladek@suse.com,
        zyhtheonly@gmail.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY03-PUBMBX-01.didichuxing.com (10.79.71.12) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Knowing who the parent is might be useful for debugging.
For example, we can sometimes resolve kernel hung tasks by stopping
the person who begins those hung tasks.
With the parent's name printed in sched_show_task(),
it might be helpful to let people know which "service" should be operated.
Also, we move the parent info to a following new line.
It would better solve the situation when the task
is not alive and we could not get information about the parent.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 kernel/sched/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b54c7a..5be3f476ee5b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8853,7 +8853,6 @@ SYSCALL_DEFINE2(sched_rr_get_interval_time32, pid_t, pid,
 void sched_show_task(struct task_struct *p)
 {
 	unsigned long free = 0;
-	int ppid;
 
 	if (!try_get_task_stack(p))
 		return;
@@ -8865,14 +8864,16 @@ void sched_show_task(struct task_struct *p)
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	free = stack_not_used(p);
 #endif
-	ppid = 0;
+	pr_cont(" stack:%-5lu pid:%-5d flags:0x%08lx\n",
+		free, task_pid_nr(p), read_task_thread_flags(p));
+
 	rcu_read_lock();
-	if (pid_alive(p))
-		ppid = task_pid_nr(rcu_dereference(p->real_parent));
+	if (pid_alive(p)) {
+		struct task_struct *parent = rcu_dereference(p->real_parent);
+
+		pr_info("parent:%-15.15s ppid:%-6d", parent->comm, task_pid_nr(parent));
+	}
 	rcu_read_unlock();
-	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
-		free, task_pid_nr(p), ppid,
-		read_task_thread_flags(p));
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
-- 
2.17.1

