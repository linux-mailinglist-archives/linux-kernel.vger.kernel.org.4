Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057A866E5CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjAQSQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjAQSOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:14:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3105959E42;
        Tue, 17 Jan 2023 09:55:00 -0800 (PST)
Date:   Tue, 17 Jan 2023 17:54:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673978097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQcgs/gZzBl+B7TsSGFyPNXbOKfIcXW+ewk0g5LuBAs=;
        b=FebkwlXyNt/QvcRlqP2e2ODF801LwQvy8pLHm8+5rYd+GUBTR8EpwhgYXkk6i1gkoj20U2
        JwmSwDQW8hJgeFtgOSmbrcRWmKc4f9Tscn/RQpPjL0YzK0j4aM5LvSwtVGG0Dlweq8Sj3g
        eCNtLWKzpZJsxichtENTxeJAmEIcayVjnfaBON5o6ysUiVb/x2eUrQayS2YOUHoNxNntPi
        f3JS7d7/7+TmzujPzCXVvwd/cEWyQmLJiYn6/3tDGF//2bzVrJP6PkDKOLOCD7LuWab3uS
        0cDjwRmxQqQpd+uPpCHz6IdwdZk2sqbYUTfRtYZnRJaaLuLYqB8vc5+nbKSuYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673978097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQcgs/gZzBl+B7TsSGFyPNXbOKfIcXW+ewk0g5LuBAs=;
        b=Pe4ejAGe7ctTLneORQMPSIfvAlhqga7TqaZ+dLqhAp/T8W2t3po691JVAXtYHUUrtJsWuy
        8gO1XNYGsO9YZ9Cw==
From:   "tip-bot2 for Ming Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] blk-mq: Build default queue map via group_cpus_evenly()
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.g.garry@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221227022905.352674-7-ming.lei@redhat.com>
References: <20221227022905.352674-7-ming.lei@redhat.com>
MIME-Version: 1.0
Message-ID: <167397809674.4906.6016765295947842293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6a6dcae8f486c3f3298d0767d34505121c7b0b81
Gitweb:        https://git.kernel.org/tip/6a6dcae8f486c3f3298d0767d34505121c7b0b81
Author:        Ming Lei <ming.lei@redhat.com>
AuthorDate:    Tue, 27 Dec 2022 10:29:05 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 17 Jan 2023 18:50:06 +01:00

blk-mq: Build default queue map via group_cpus_evenly()

The default queue mapping builder of blk_mq_map_queues doesn't take NUMA
topo into account, so the built mapping is pretty bad, since CPUs
belonging to different NUMA node are assigned to same queue. It is
observed that IOPS drops by ~30% when running two jobs on same hctx
of null_blk from two CPUs belonging to two NUMA nodes compared with
from same NUMA node.

Address the issue by reusing group_cpus_evenly() for building queue mapping
since group_cpus_evenly() does group cpus according to CPU/NUMA locality.

Also performance data becomes more stable with this given correct queue
mapping is applied wrt. numa locality viewpoint, for example, on one two
nodes arm64 machine with 160 cpus, node 0(cpu 0~79), node 1(cpu 80~159):

1) modprobe null_blk nr_devices=1 submit_queues=2

2) run 'fio(t/io_uring -p 0 -n 4 -r 20 /dev/nullb0)', and observe that
IOPS becomes much stable on multiple tests:

 - unpatched: IOPS is 2.5M ~ 4.5M
 - patched:   IOPS is 4.3M ~ 5.0M

Lots of drivers may benefit from the change, such as nvme pci poll,
nvme tcp, ...

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>                                                                                                                                                                                                    
Link: https://lore.kernel.org/r/20221227022905.352674-7-ming.lei@redhat.com

---
 block/blk-mq-cpumap.c | 63 ++++++++----------------------------------
 1 file changed, 13 insertions(+), 50 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9c2fce1..0c612c1 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -10,66 +10,29 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
+#include <linux/group_cpus.h>
 
 #include <linux/blk-mq.h>
 #include "blk.h"
 #include "blk-mq.h"
 
-static int queue_index(struct blk_mq_queue_map *qmap,
-		       unsigned int nr_queues, const int q)
-{
-	return qmap->queue_offset + (q % nr_queues);
-}
-
-static int get_first_sibling(unsigned int cpu)
-{
-	unsigned int ret;
-
-	ret = cpumask_first(topology_sibling_cpumask(cpu));
-	if (ret < nr_cpu_ids)
-		return ret;
-
-	return cpu;
-}
-
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
-	unsigned int *map = qmap->mq_map;
-	unsigned int nr_queues = qmap->nr_queues;
-	unsigned int cpu, first_sibling, q = 0;
-
-	for_each_possible_cpu(cpu)
-		map[cpu] = -1;
-
-	/*
-	 * Spread queues among present CPUs first for minimizing
-	 * count of dead queues which are mapped by all un-present CPUs
-	 */
-	for_each_present_cpu(cpu) {
-		if (q >= nr_queues)
-			break;
-		map[cpu] = queue_index(qmap, nr_queues, q++);
+	const struct cpumask *masks;
+	unsigned int queue, cpu;
+
+	masks = group_cpus_evenly(qmap->nr_queues);
+	if (!masks) {
+		for_each_possible_cpu(cpu)
+			qmap->mq_map[cpu] = qmap->queue_offset;
+		return;
 	}
 
-	for_each_possible_cpu(cpu) {
-		if (map[cpu] != -1)
-			continue;
-		/*
-		 * First do sequential mapping between CPUs and queues.
-		 * In case we still have CPUs to map, and we have some number of
-		 * threads per cores then map sibling threads to the same queue
-		 * for performance optimizations.
-		 */
-		if (q < nr_queues) {
-			map[cpu] = queue_index(qmap, nr_queues, q++);
-		} else {
-			first_sibling = get_first_sibling(cpu);
-			if (first_sibling == cpu)
-				map[cpu] = queue_index(qmap, nr_queues, q++);
-			else
-				map[cpu] = map[first_sibling];
-		}
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		for_each_cpu(cpu, &masks[queue])
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
+	kfree(masks);
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_queues);
 
