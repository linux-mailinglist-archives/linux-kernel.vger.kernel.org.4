Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB42F6146D2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKAJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiKAJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247201901C;
        Tue,  1 Nov 2022 02:34:30 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N1lCC0pDLzJnMC;
        Tue,  1 Nov 2022 17:31:35 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:27 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 13/20] block,bfq: remove redundant nonrot_with_queueing check in bfq_setup_cooperator
Date:   Tue, 1 Nov 2022 17:34:10 +0800
Message-ID: <20221101093417.10540-14-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221101093417.10540-1-shikemeng@huawei.com>
References: <20221101093417.10540-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 430a67f9d6169 ("block, bfq: merge bursts of newly-created queues")
add stable merge logic in bfq_setup_cooperator and will only be executed
for !nonrot_with_queueing device. Actually, bfq_setup_cooperator is
designed for only !nonrot_with_queueing and has already returned NULL
before doing real work if device is nonrot_with_queueing. We can add
stable merge after existing nonrot_with_queueing check and no need to
re-check nonrot_with_queueing.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 97 ++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 50 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a46e49de895a..b8af0bb98d66 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2886,56 +2886,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (bfqq->new_bfqq)
 		return bfqq->new_bfqq;
 
-	/*
-	 * Check delayed stable merge for rotational or non-queueing
-	 * devs. For this branch to be executed, bfqq must not be
-	 * currently merged with some other queue (i.e., bfqq->bic
-	 * must be non null). If we considered also merged queues,
-	 * then we should also check whether bfqq has already been
-	 * merged with bic->stable_merge_bfqq. But this would be
-	 * costly and complicated.
-	 */
-	if (unlikely(!bfqd->nonrot_with_queueing)) {
-		/*
-		 * Make sure also that bfqq is sync, because
-		 * bic->stable_merge_bfqq may point to some queue (for
-		 * stable merging) also if bic is associated with a
-		 * sync queue, but this bfqq is async
-		 */
-		if (bfq_bfqq_sync(bfqq) && bic->stable_merge_bfqq &&
-		    !bfq_bfqq_just_created(bfqq) &&
-		    time_is_before_jiffies(bfqq->split_time +
-					  msecs_to_jiffies(bfq_late_stable_merging)) &&
-		    time_is_before_jiffies(bfqq->creation_time +
-					   msecs_to_jiffies(bfq_late_stable_merging))) {
-			struct bfq_queue *stable_merge_bfqq =
-				bic->stable_merge_bfqq;
-			int proc_ref = min(bfqq_process_refs(bfqq),
-					   bfqq_process_refs(stable_merge_bfqq));
-
-			/* deschedule stable merge, because done or aborted here */
-			bfq_put_stable_ref(stable_merge_bfqq);
-
-			bic->stable_merge_bfqq = NULL;
-
-			if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
-			    proc_ref > 0) {
-				/* next function will take at least one ref */
-				struct bfq_queue *new_bfqq =
-					bfq_setup_merge(bfqq, stable_merge_bfqq);
-
-				if (new_bfqq) {
-					bic->stably_merged = true;
-					if (new_bfqq->bic)
-						new_bfqq->bic->stably_merged =
-									true;
-				}
-				return new_bfqq;
-			} else
-				return NULL;
-		}
-	}
-
 	/*
 	 * Do not perform queue merging if the device is non
 	 * rotational and performs internal queueing. In fact, such a
@@ -2976,6 +2926,53 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (likely(bfqd->nonrot_with_queueing))
 		return NULL;
 
+	/*
+	 * Check delayed stable merge for rotational or non-queueing
+	 * devs. For this branch to be executed, bfqq must not be
+	 * currently merged with some other queue (i.e., bfqq->bic
+	 * must be non null). If we considered also merged queues,
+	 * then we should also check whether bfqq has already been
+	 * merged with bic->stable_merge_bfqq. But this would be
+	 * costly and complicated.
+	 * Make sure also that bfqq is sync, because
+	 * bic->stable_merge_bfqq may point to some queue (for
+	 * stable merging) also if bic is associated with a
+	 * sync queue, but this bfqq is async
+	 */
+	if (bfq_bfqq_sync(bfqq) && bic->stable_merge_bfqq &&
+			!bfq_bfqq_just_created(bfqq) &&
+			time_is_before_jiffies(bfqq->split_time +
+				msecs_to_jiffies(bfq_late_stable_merging)) &&
+			time_is_before_jiffies(bfqq->creation_time +
+				msecs_to_jiffies(bfq_late_stable_merging))) {
+		struct bfq_queue *stable_merge_bfqq =
+			bic->stable_merge_bfqq;
+		int proc_ref = min(bfqq_process_refs(bfqq),
+				bfqq_process_refs(stable_merge_bfqq));
+
+		/* deschedule stable merge, because done or aborted here */
+		bfq_put_stable_ref(stable_merge_bfqq);
+
+		bic->stable_merge_bfqq = NULL;
+
+		if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
+				proc_ref > 0) {
+			/* next function will take at least one ref */
+			struct bfq_queue *new_bfqq =
+				bfq_setup_merge(bfqq, stable_merge_bfqq);
+
+			if (new_bfqq) {
+				bic->stably_merged = true;
+				if (new_bfqq->bic)
+					new_bfqq->bic->stably_merged =
+						true;
+			}
+			return new_bfqq;
+		} else
+			return NULL;
+	}
+
+
 	/*
 	 * Prevent bfqq from being merged if it has been created too
 	 * long ago. The idea is that true cooperating processes, and
-- 
2.30.0

