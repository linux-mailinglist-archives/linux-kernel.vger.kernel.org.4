Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C4C5ED38E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiI1Dh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiI1Dhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:37:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8C6B6037
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 20:37:48 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MchvH2f9NzpVMC;
        Wed, 28 Sep 2022 11:34:51 +0800 (CST)
Received: from huawei.com (10.67.174.166) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 11:37:47 +0800
From:   Zucheng Zheng <zhengzucheng@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <frederic@kernel.org>,
        <hucool.lihua@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sched/cputime: Fix the time backward issue about /proc/stat
Date:   Wed, 28 Sep 2022 11:34:02 +0800
Message-ID: <20220928033402.181530-1-zhengzucheng@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.166]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Zucheng <zhengzucheng@huawei.com>

The cputime of cpuN read from /proc/stat has an issue of cputime descent.
For example, the phenomenon of cputime descent of user is as followed:

The value read first is 319, and the value read again is 318. As follows:
first:
 cat /proc/stat |  grep cpu1
 cpu1    319    0    496    41665    0    0    0    0    0    0
again:
 cat /proc/stat |  grep cpu1
 cpu1    318    0    497    41674    0    0    0    0    0    0

The value read from /proc/stat should be monotonically increasing. Otherwise
user may get incorrect CPU usage.

The root cause of this problem is that, in the implementation of
kcpustat_cpu_fetch_vtime, vtime->utime + delta is added to the stack variable
cpustat instantaneously. If the task is switched between two times, the value
added to cpustat for the second time may be smaller than that for the first time.

				CPU0						CPU1
First:
show_stat()
 ->kcpustat_cpu_fetch()
  ->kcpustat_cpu_fetch_vtime()
   ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu) + vtime->utime + delta       rq->curr is task A
                                                                            A switch to B，and A->vtime->utime is less than 1 tick
Then:
show_stat()
 ->kcpustat_cpu_fetch()
  ->kcpustat_cpu_fetch_vtime()
   ->cpustat[CPUTIME_USER] = kcpustat_cpu(cpu) + vtime->utime + delta;     rq->curr is task B

Fixes: 74722bb223d0 ("sched/vtime: Bring up complete kcpustat accessor")
Signed-off-by: Li Hua <hucool.lihua@huawei.com>
Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
---
 kernel/sched/cputime.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 95fc77853743..c7a812ff1fb7 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -1060,9 +1060,17 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 	return 0;
 }
 
+DEFINE_PER_CPU(struct kernel_cpustat, kernel_cpustat_reverse);
+DEFINE_PER_CPU(raw_spinlock_t, kernel_cpustat_reverse_lock);
+
 void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
 {
 	const struct kernel_cpustat *src = &kcpustat_cpu(cpu);
+	struct kernel_cpustat *reverse = &per_cpu(kernel_cpustat_reverse, cpu);
+	raw_spinlock_t *cpustat_lock = &per_cpu(kernel_cpustat_reverse_lock, cpu);
+	u64 *dstat = dst->cpustat;
+	u64 *restat = reverse->cpustat;
+	unsigned long flags;
 	struct rq *rq;
 	int err;
 
@@ -1087,8 +1095,22 @@ void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
 		err = kcpustat_cpu_fetch_vtime(dst, src, curr, cpu);
 		rcu_read_unlock();
 
-		if (!err)
+		if (!err) {
+			raw_spin_lock_irqsave(cpustat_lock, flags);
+			if (dstat[CPUTIME_USER] < restat[CPUTIME_USER])
+				dstat[CPUTIME_USER] = restat[CPUTIME_USER];
+			if (dstat[CPUTIME_SYSTEM] < restat[CPUTIME_SYSTEM])
+				dstat[CPUTIME_SYSTEM] = restat[CPUTIME_SYSTEM];
+			if (dstat[CPUTIME_NICE] < restat[CPUTIME_NICE])
+				dstat[CPUTIME_NICE] = restat[CPUTIME_NICE];
+			if (dstat[CPUTIME_GUEST] < restat[CPUTIME_GUEST])
+				dstat[CPUTIME_GUEST] = restat[CPUTIME_GUEST];
+			if (dstat[CPUTIME_GUEST_NICE] < restat[CPUTIME_GUEST_NICE])
+				dstat[CPUTIME_GUEST_NICE] = restat[CPUTIME_GUEST_NICE];
+			*reverse = *dst;
+			raw_spin_unlock_irqrestore(cpustat_lock, flags);
 			return;
+		}
 
 		cpu_relax();
 	}
-- 
2.18.0.huawei.25

