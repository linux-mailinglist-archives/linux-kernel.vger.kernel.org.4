Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0616146D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiKAJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiKAJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2454F1901B;
        Tue,  1 Nov 2022 02:34:30 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N1lCB3wcMzJnM3;
        Tue,  1 Nov 2022 17:31:34 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:26 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 12/20] block, bfq: start/restart service_from_wr accumulating correctly
Date:   Tue, 1 Nov 2022 17:34:09 +0800
Message-ID: <20221101093417.10540-13-shikemeng@huawei.com>
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

1. Start accumulating service_from_wr when async queues are weight raised.
The service_from_wr for async queues is accumulated and checked to finish
weight-raise as sync queues. We need to charge service_from_wr for async
queues about to weight-raise.
2. Restart accumulating service_from_wr when queues are deemed interactive
again The weight-raising period is restarted when queues are deemed
interactive again in bfq_add_request. It's more reasonable to restart
service_from_wr accumulating too.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 261ba2d63925..a46e49de895a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1726,6 +1726,7 @@ static void bfq_update_bfqq_wr_on_rq_arrival(struct bfq_data *bfqd,
 					    2 * bfq_min_budget(bfqd));
 	} else if (old_wr_coeff > 1) {
 		if (interactive) { /* update wr coeff and duration */
+			bfqq->service_from_wr = 0;
 			bfqq->wr_coeff = bfqd->bfq_wr_coeff;
 			bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
 		} else if (in_burst)
@@ -2311,6 +2312,7 @@ static void bfq_add_request(struct request *rq)
 		    time_is_before_jiffies(
 				bfqq->last_wr_start_finish +
 				bfqd->bfq_wr_min_inter_arr_async)) {
+			bfqq->service_from_wr = 0;
 			bfqq->wr_coeff = bfqd->bfq_wr_coeff;
 			bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
 
-- 
2.30.0

