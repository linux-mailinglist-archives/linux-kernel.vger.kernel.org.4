Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B376146C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKAJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiKAJeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3997918B13;
        Tue,  1 Nov 2022 02:34:24 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1lBL3twtzpW4d;
        Tue,  1 Nov 2022 17:30:50 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:22 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 04/20] block, bfq: simpfy computation of bfqd->budgets_assigned
Date:   Tue, 1 Nov 2022 17:34:01 +0800
Message-ID: <20221101093417.10540-5-shikemeng@huawei.com>
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

The computation of budgets_assigned is a little confusing as we only need
to check if it's updated more than 10 times. Simpfy the computation to
improve readability.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b21c3711d69d..be69b0e061f7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -175,7 +175,7 @@ static const int bfq_back_penalty = 2;
 static u64 bfq_slice_idle = NSEC_PER_SEC / 125;
 
 /* Minimum number of assigned budgets for which stats are safe to compute. */
-static const int bfq_stats_min_budgets = 194;
+static const int bfq_stats_min_budgets = 11;
 
 /* Default maximum budget values, in sectors and number of requests. */
 static const int bfq_default_max_budget = 16 * 1024;
@@ -3288,7 +3288,7 @@ static void __bfq_set_in_service_queue(struct bfq_data *bfqd,
 	if (bfqq) {
 		bfq_clear_bfqq_fifo_expire(bfqq);
 
-		bfqd->budgets_assigned = (bfqd->budgets_assigned * 7 + 256) / 8;
+		bfqd->budgets_assigned++;
 
 		if (time_is_before_jiffies(bfqq->last_wr_start_finish) &&
 		    bfqq->wr_coeff > 1 &&
-- 
2.30.0

