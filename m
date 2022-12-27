Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6406566D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 03:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiL0Cah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 21:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiL0CaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 21:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35750B6F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 18:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672108184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zS2731Tqsl5rZOtBPgZHUDyyYtPAz2zgn9cswpCwiq8=;
        b=FUfsN85staqCrzoJqLjDtMfHP/pu9gMMEO45DKWabvuINyagncvi5tuTFlC2C5gSr0y5z8
        pSMehgCZN8ALb5agIMVPaTvx8u6bKhJf3unkRERrNRtI8MI6CR8gr7hWET6ASVu5cbS3Jc
        e8pHPAVsLJfpLpjrEGSI5SwPln+s6Gk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-980IQXpiPf-Q_89jrFImbA-1; Mon, 26 Dec 2022 21:29:39 -0500
X-MC-Unique: 980IQXpiPf-Q_89jrFImbA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19FD43C0F7E1;
        Tue, 27 Dec 2022 02:29:39 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0957D492C14;
        Tue, 27 Dec 2022 02:29:37 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 6/6] blk-mq: Build default queue map via group_cpus_evenly()
Date:   Tue, 27 Dec 2022 10:29:05 +0800
Message-Id: <20221227022905.352674-7-ming.lei@redhat.com>
In-Reply-To: <20221227022905.352674-1-ming.lei@redhat.com>
References: <20221227022905.352674-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default queue mapping builder of blk_mq_map_queues doesn't take NUMA
topo into account, so the built mapping is pretty bad, since CPUs
belonging to different NUMA node are assigned to same queue. It is
observed that IOPS drops by ~30% when running two jobs on same hctx
of null_blk from two CPUs belonging to two NUMA nodes compared with
from same NUMA node.

Address the issue by reusing group_cpus_evenly() for building queue
mapping since group_cpus_evenly() does group cpus according to CPU/NUMA
locality.

Also performance data becomes more stable with this patchset given
correct queue mapping is applied wrt. numa locality viewpoint, for
example, on one two nodes arm64 machine with 160 cpus, node 0(cpu 0~79),
node 1(cpu 80~159):

1) modprobe null_blk nr_devices=1 submit_queues=2

2) run 'fio(t/io_uring -p 0 -n 4 -r 20 /dev/nullb0)', and observe that
IOPS becomes much stable on multiple tests:

- without patched: IOPS is 2.5M ~ 4.5M
- patched: IOPS is 4.3 ~ 5M

Lots of drivers may benefit from the change, such as nvme pci poll,
nvme tcp, ...

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-cpumap.c | 63 +++++++++----------------------------------
 1 file changed, 13 insertions(+), 50 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9c2fce1a7b50..0c612c19feb8 100644
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
 
-- 
2.31.1

