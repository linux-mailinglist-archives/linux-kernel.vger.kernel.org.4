Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8842D673656
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjASLGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjASLGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:06:53 -0500
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BEB2DE3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:06:51 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 1C818B008082F;
        Thu, 19 Jan 2023 19:06:49 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 19:06:48 +0800
Date:   Thu, 19 Jan 2023 19:06:42 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   Tio Zhang <tiozhang@didiglobal.com>
To:     <pmladek@suse.com>, <yu.c.chen@intel.com>
CC:     <juri.lelli@redhat.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <tiozhang@didiglobal.com>,
        <zyhtheonly@gmail.com>, <zwp10758@gmail.com>, <zyhtheonly@yeah.net>
Subject: [PATCH v2] sched: print parent comm in sched_show_task()
Message-ID: <20230119110642.GA6463@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: pmladek@suse.com, yu.c.chen@intel.com,
        juri.lelli@redhat.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        zyhtheonly@gmail.com, zwp10758@gmail.com, zyhtheonly@yeah.net
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
Also, we move the parent info to a following new line while keeping the
original line the same.
And we would print "parent:unknown         ppid:<NULL>"
when the task is not alive.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 kernel/sched/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b54c7a..5690a5700f9e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8854,6 +8854,7 @@ void sched_show_task(struct task_struct *p)
 {
 	unsigned long free = 0;
 	int ppid;
+	char *pcomm = NULL;
 
 	if (!try_get_task_stack(p))
 		return;
@@ -8867,13 +8868,22 @@ void sched_show_task(struct task_struct *p)
 #endif
 	ppid = 0;
 	rcu_read_lock();
-	if (pid_alive(p))
-		ppid = task_pid_nr(rcu_dereference(p->real_parent));
+	if (pid_alive(p)) {
+		struct task_struct *parent = rcu_dereference(p->real_parent);
+
+		ppid = task_pid_nr(parent);
+		pcomm = parent->comm;
+	}
 	rcu_read_unlock();
 	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
 		free, task_pid_nr(p), ppid,
 		read_task_thread_flags(p));
 
+	if (!ppid)
+		pr_info("parent:unknown         ppid:<NULL>\n");
+	else
+		pr_info("parent:%-15.15s ppid:%-6d\n", pcomm, ppid);
+
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
 	show_stack(p, NULL, KERN_INFO);
-- 
2.17.1
