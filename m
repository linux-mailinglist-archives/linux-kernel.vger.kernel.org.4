Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6996F6146CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiKAJe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKAJe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B054918E2C;
        Tue,  1 Nov 2022 02:34:26 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1lG70LybzHvXl;
        Tue,  1 Nov 2022 17:34:07 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:24 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 08/20] block, bfq: do srt filtering for interactive queues in bfq_completed_request
Date:   Tue, 1 Nov 2022 17:34:05 +0800
Message-ID: <20221101093417.10540-9-shikemeng@huawei.com>
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

Commit 20cd32450bcbec ("block, bfq: do not consider interactive queues in
srt filtering") remove the updating of soft_rt_next_start for bfq_queues
in interactive weight raising.
Commit 3c337690d2ebb7 ("block, bfq: avoid spurious switches to soft_rt of
interactive queues") try to revert the first commit to add back updating of
soft_rt_next_start for bfq_queues in interactive weight raising and fix
original problem by reset consumed bandwidth if a bfq_queue switches from
interactive to normal mode.
The problem this patch fixes is that first commit is not fully reverted as
updating of soft_rt_next_start for bfq_queues in interactive weight
raising is still removed in bfq_completed_request. Fix this by updating
soft_rt_next_start for bfq_queues in interactive weight raising in
bfq_completed_request.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 15e7d6c6fa83..fa96cbca7814 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6317,14 +6317,11 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 	 * isochronous, and both requisites for this condition to hold
 	 * are now satisfied, then compute soft_rt_next_start (see the
 	 * comments on the function bfq_bfqq_softrt_next_start()). We
-	 * do not compute soft_rt_next_start if bfqq is in interactive
-	 * weight raising (see the comments in bfq_bfqq_expire() for
-	 * an explanation). We schedule this delayed update when bfqq
-	 * expires, if it still has in-flight requests.
+	 * schedule this delayed update when bfqq expires, if it still
+	 * has in-flight requests.
 	 */
 	if (bfq_bfqq_softrt_update(bfqq) && bfqq->dispatched == 0 &&
-	    RB_EMPTY_ROOT(&bfqq->sort_list) &&
-	    bfqq->wr_coeff != bfqd->bfq_wr_coeff)
+	    RB_EMPTY_ROOT(&bfqq->sort_list))
 		bfqq->soft_rt_next_start =
 			bfq_bfqq_softrt_next_start(bfqd, bfqq);
 
-- 
2.30.0

