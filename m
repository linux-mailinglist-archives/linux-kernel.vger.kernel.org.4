Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58063E91C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLAEzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLAEy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:54:57 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58FA9FEC1;
        Wed, 30 Nov 2022 20:54:56 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NN3cg3ZLbzHwMr;
        Thu,  1 Dec 2022 12:53:39 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 1 Dec
 2022 12:54:10 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huaweicloud.com>, <linfeilong@huawei.com>,
        <liuzhiqiang@huawei.com>
Subject: [PATCH 1/5] sbitmap: don't consume nr for inactive waitqueue to avoid lost wakeups
Date:   Thu, 1 Dec 2022 12:54:04 +0800
Message-ID: <20221201045408.21908-2-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221201045408.21908-1-shikemeng@huawei.com>
References: <20221201045408.21908-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we decremented queue without waiters, we should not decremente freed
bits number "nr", or all "nr" could be consumed in a empty queue and no
wakeup will be called.
Currently, for case "wait_cnt > 0", "nr" will not be decremented if we
decremented queue without watiers and retry is returned to avoid lost
wakeups. However for case "wait_cnt == 0", "nr" will be decremented
unconditionally and maybe decremented to zero. Although retry is
returned by active state of queue, it's not actually executed for "nr"
is zero.

Fix this by only decrementing "nr" for active queue when "wait_cnt ==
0". After this fix, "nr" will always be non-zero when we decremented
inactive queue for case "wait_cnt == 0", so the need to retry could
be returned by "nr" and active state of waitqueue returned for the same
purpose is not needed.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 lib/sbitmap.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 7280ae8ca88c..e40759bcf821 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -604,7 +604,6 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
 	struct sbq_wait_state *ws;
 	unsigned int wake_batch;
 	int wait_cnt, cur, sub;
-	bool ret;
 
 	if (*nr <= 0)
 		return false;
@@ -632,15 +631,15 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
 	if (wait_cnt > 0)
 		return !waitqueue_active(&ws->wait);
 
-	*nr -= sub;
-
 	/*
 	 * When wait_cnt == 0, we have to be particularly careful as we are
 	 * responsible to reset wait_cnt regardless whether we've actually
-	 * woken up anybody. But in case we didn't wakeup anybody, we still
-	 * need to retry.
+	 * woken up anybody. But in case we didn't wakeup anybody, we should
+	 * not consume nr and need to retry to avoid lost wakeups.
 	 */
-	ret = !waitqueue_active(&ws->wait);
+	if (waitqueue_active(&ws->wait))
+		*nr -= sub;
+
 	wake_batch = READ_ONCE(sbq->wake_batch);
 
 	/*
@@ -669,7 +668,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
 	sbq_index_atomic_inc(&sbq->wake_index);
 	atomic_set(&ws->wait_cnt, wake_batch);
 
-	return ret || *nr;
+	return *nr;
 }
 
 void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
-- 
2.30.0

