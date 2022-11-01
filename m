Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C336146CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiKAJfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiKAJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925951900B;
        Tue,  1 Nov 2022 02:34:28 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1l8p4gBtzRnsP;
        Tue,  1 Nov 2022 17:29:30 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:26 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 11/20] block, bfq: remove unnecessary "wr" part of wr_or_deserves_wr
Date:   Tue, 1 Nov 2022 17:34:08 +0800
Message-ID: <20221101093417.10540-12-shikemeng@huawei.com>
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

Before commit 96a291c38c3299 ("block, bfq: preempt lower-weight or
lower-priority queues"), wr_or_deserves_wr is used to check if
preempt is wanted. Currently, wr_or_deserves_wr is only used in
bfq_update_bfqq_wr_on_rq_arrival to check if weight raising is
needed, so the "wr" part of wr_or_deserves_wr is not needed
anymore. Rename wr_or_deserves_wr to deserves_wr and remove
unnecessary bfqq->wr_coeff > 1 for original wr_or_deserves_wr.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0ecb3640d715..261ba2d63925 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1681,12 +1681,12 @@ static unsigned long bfq_smallest_from_now(void)
 static void bfq_update_bfqq_wr_on_rq_arrival(struct bfq_data *bfqd,
 					     struct bfq_queue *bfqq,
 					     unsigned int old_wr_coeff,
-					     bool wr_or_deserves_wr,
+					     bool deserves_wr,
 					     bool interactive,
 					     bool in_burst,
 					     bool soft_rt)
 {
-	if (old_wr_coeff == 1 && wr_or_deserves_wr) {
+	if (old_wr_coeff == 1 && deserves_wr) {
 		/* start a weight-raising period */
 		if (interactive) {
 			bfqq->service_from_wr = 0;
@@ -1866,7 +1866,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	bfq_clear_bfqq_just_created(bfqq);
 
 	if (bfqd->low_latency) {
-		bool soft_rt, in_burst,	wr_or_deserves_wr;
+		bool soft_rt, in_burst,	deserves_wr;
 		/*
 		 * bfqq deserves to be weight-raised if:
 		 * - it is sync,
@@ -1905,14 +1905,13 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 			 * processes. So let also stably-merged queued enjoy weight
 			 * raising.
 			 */
-			wr_or_deserves_wr = (bfqq->wr_coeff > 1 ||
-					(bfq_bfqq_sync(bfqq) &&
+			deserves_wr = (bfq_bfqq_sync(bfqq) &&
 					 (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
-					 (*interactive || soft_rt)));
+					 (*interactive || soft_rt));
 
 			bfq_update_bfqq_wr_on_rq_arrival(bfqd, bfqq,
 							 old_wr_coeff,
-							 wr_or_deserves_wr,
+							 deserves_wr,
 							 *interactive,
 							 in_burst,
 							 soft_rt);
-- 
2.30.0

