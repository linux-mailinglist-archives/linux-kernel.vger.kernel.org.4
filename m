Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7104B6A0362
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjBWHta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWHt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:49:29 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A644BEA9;
        Wed, 22 Feb 2023 23:49:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PMlXg035tz4f3jLS;
        Thu, 23 Feb 2023 15:49:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLODGvdjJROgEA--.43840S4;
        Thu, 23 Feb 2023 15:49:24 +0800 (CST)
From:   Xiongfeng Wang <wangxiongfeng@huaweicloud.com>
To:     axboe@kernel.dk, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangxiongfeng2@huawei.com, wangxiongfeng@huaweicloud.com,
        liwei391@huawei.com, wangkefeng.wang@huawei.com
Subject: [RFC PATCH] blk-mq: avoid housekeeping CPUs scheduling a worker on a non-housekeeping CPU
Date:   Thu, 23 Feb 2023 15:48:26 +0800
Message-Id: <20230223074826.3782643-1-wangxiongfeng@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLODGvdjJROgEA--.43840S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyktr4rGw1fKFWrWFyrXrb_yoW8tFWrpF
        Z8uay3GrsrXF1jk3WfZwsrAFy5WFs5Gr1ktr93Wws8Z342gr1DWrWvkF9xKF95ArZ7Cr47
        Z3y5trWfCw4DZ3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbE_M3UUUUU==
X-CM-SenderInfo: pzdqw5plrqwwhhqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

When NOHZ_FULL is enabled, such as in HPC situation, CPUs are divided
into housekeeping CPUs and non-housekeeping CPUs. Non-housekeeping CPUs
are NOHZ_FULL CPUs and are often monopolized by the userspace process,
such HPC application process. Any sort of interruption is not expected.

blk_mq_hctx_next_cpu() selects each cpu in 'hctx->cpumask' alternately
to schedule the work thread blk_mq_run_work_fn(). When 'hctx->cpumask'
contains housekeeping CPU and non-housekeeping CPU at the same time, a
housekeeping CPU, which want to request a IO, may schedule a worker on a
non-housekeeping CPU. This may affect the performance of the userspace
application running on non-housekeeping CPUs.

So let's just schedule the worker thread on the current CPU when the
current CPU is housekeeping CPU.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 block/blk-mq.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d3494a796ba8..1e84d393cce3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -21,6 +21,7 @@
 #include <linux/llist.h>
 #include <linux/cpu.h>
 #include <linux/cache.h>
+#include <linux/sched/isolation.h>
 #include <linux/sched/sysctl.h>
 #include <linux/sched/topology.h>
 #include <linux/sched/signal.h>
@@ -2245,6 +2246,8 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 					unsigned long msecs)
 {
+	int work_cpu;
+
 	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
 
@@ -2255,7 +2258,17 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		}
 	}
 
-	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
+	/*
+	 * Avoid housekeeping CPUs scheduling a worker on a non-housekeeping
+	 * CPU
+	 */
+	if (tick_nohz_full_enabled() && housekeeping_cpu(smp_processor_id(),
+							 HK_TYPE_WQ))
+		work_cpu = smp_processor_id();
+	else
+		work_cpu = blk_mq_hctx_next_cpu(hctx);
+
+	kblockd_mod_delayed_work_on(work_cpu, &hctx->run_work,
 				    msecs_to_jiffies(msecs));
 }
 
-- 
2.25.1

