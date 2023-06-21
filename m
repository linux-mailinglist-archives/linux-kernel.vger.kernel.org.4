Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9930B737B74
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjFUGjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjFUGi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:38:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8AA1998
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:38:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QmDNk6JR0z1FDgk;
        Wed, 21 Jun 2023 14:38:46 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 21 Jun
 2023 14:38:53 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] sched/topology: fix potential memoryleak in sched_init_numa()
Date:   Wed, 21 Jun 2023 14:38:17 +0800
Message-ID: <20230621063817.3753617-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sched_init_numa() fails to allocate enough memory for sched domains
numa masks, it forgot to free the allocated memory leading to memoryleak.
Add a helper to help release the resource.

Fixes: cb83b629bae0 ("sched/numa: Rewrite the CONFIG_NUMA sched domain support")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/topology.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 290509383419..dcec4d653ae3 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1807,6 +1807,20 @@ static void init_numa_topology_type(int offline_node)
 
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
 
+static void sched_free_numa_mask(struct cpumask ***masks, int nr_levels)
+{
+	int i, j;
+
+	for (i = 0; i < nr_levels; i++) {
+		if (!masks[i])
+			continue;
+		for_each_node(j)
+			kfree(masks[i][j]);
+		kfree(masks[i]);
+	}
+	kfree(masks);
+}
+
 void sched_init_numa(int offline_node)
 {
 	struct sched_domain_topology_level *tl;
@@ -1886,15 +1900,19 @@ void sched_init_numa(int offline_node)
 	 */
 	for (i = 0; i < nr_levels; i++) {
 		masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
-		if (!masks[i])
+		if (!masks[i]) {
+			sched_free_numa_mask(masks, nr_levels);
 			return;
+		}
 
 		for_each_cpu_node_but(j, offline_node) {
 			struct cpumask *mask = kzalloc(cpumask_size(), GFP_KERNEL);
 			int k;
 
-			if (!mask)
+			if (!mask) {
+				sched_free_numa_mask(masks, nr_levels);
 				return;
+			}
 
 			masks[i][j] = mask;
 
-- 
2.27.0

