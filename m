Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829B9656CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiL0QOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiL0QOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:14:23 -0500
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 16F1DCDC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:14:21 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id A20A511002B812;
        Wed, 28 Dec 2022 00:14:17 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 00:14:17 +0800
Date:   Wed, 28 Dec 2022 00:14:00 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   Tio Zhang <tiozhang@didiglobal.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <pmladek@suse.com>,
        <zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>, <zwp10758@gmail.com>
Subject: [PATCH] sched: print parent comm in sched_show_task()
Message-ID: <20221227161400.GA7646@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        zyhtheonly@gmail.com, zyhtheonly@yeah.net, zwp10758@gmail.com
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

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 kernel/sched/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b54c7a..6f4aef0fed58 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8854,6 +8854,7 @@ void sched_show_task(struct task_struct *p)
 {
 	unsigned long free = 0;
 	int ppid;
+	char pcomm[TASK_COMM_LEN];
 
 	if (!try_get_task_stack(p))
 		return;
@@ -8867,11 +8868,13 @@ void sched_show_task(struct task_struct *p)
 #endif
 	ppid = 0;
 	rcu_read_lock();
-	if (pid_alive(p))
+	if (pid_alive(p)) {
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
+		get_task_comm(pcomm, rcu_dereference(p->real_parent));
+	}
 	rcu_read_unlock();
-	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
-		free, task_pid_nr(p), ppid,
+	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d parent:%-15.15s flags:0x%08lx\n",
+		free, task_pid_nr(p), ppid, pcomm,
 		read_task_thread_flags(p));
 
 	print_worker_info(KERN_INFO, p);
-- 
2.17.1

