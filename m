Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D236CB50E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjC1DrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjC1DrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:47:13 -0400
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Mar 2023 20:47:11 PDT
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C0B6F171F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:47:11 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id E13641100D962F;
        Tue, 28 Mar 2023 11:45:06 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 11:45:06 +0800
Date:   Tue, 28 Mar 2023 11:44:59 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   Tio Zhang <tiozhang@didiglobal.com>
To:     <pmladek@suse.com>, <yu.c.chen@intel.com>,
        <akpm@linux-foundation.org>
CC:     <juri.lelli@redhat.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <tiozhang@didiglobal.com>,
        <zyhtheonly@gmail.com>, <zwp10758@gmail.com>, <zyhtheonly@yeah.net>
Subject: [PATCH v3] sched: print parent comm in sched_show_task()
Message-ID: <20230328034438.GA8421@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: pmladek@suse.com, yu.c.chen@intel.com,
        akpm@linux-foundation.org, juri.lelli@redhat.com, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, zyhtheonly@gmail.com,
        zwp10758@gmail.com, zyhtheonly@yeah.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCGBaQIHIC8GMNtn@alley>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY03-PUBMBX-01.didichuxing.com (10.79.71.12) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
It would be better to solve the situation when the task
is not alive and we could not get information about the parent.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 kernel/sched/core.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b54c7a..d8fd35684d6c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8853,7 +8853,6 @@ SYSCALL_DEFINE2(sched_rr_get_interval_time32, pid_t, pid,
 void sched_show_task(struct task_struct *p)
 {
 	unsigned long free = 0;
-	int ppid;
 
 	if (!try_get_task_stack(p))
 		return;
@@ -8865,14 +8864,19 @@ void sched_show_task(struct task_struct *p)
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	free = stack_not_used(p);
 #endif
-	ppid = 0;
+
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
+	} else {
+		pr_info("parent:unknown         ppid:<NULL>\n");
+	}
 	rcu_read_unlock();
-	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
-		free, task_pid_nr(p), ppid,
-		read_task_thread_flags(p));
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
-- 
2.17.1

