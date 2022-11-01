Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23436146C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiKAJev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiKAJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CA018E05;
        Tue,  1 Nov 2022 02:34:25 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1lBM5CnNzpW50;
        Tue,  1 Nov 2022 17:30:51 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:23 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 06/20] block, bfq: correct interactive weight-raise check in bfq_set_budget_timeout
Date:   Tue, 1 Nov 2022 17:34:03 +0800
Message-ID: <20221101093417.10540-7-shikemeng@huawei.com>
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

After weight-raise finished, bfqq->wr_coeff is reset to 1 while
bfqq->wr_cur_max_time may not be reset. For example,
Function bfq_update_bfqq_wr_on_rq_arrival will only reset wr_coeff to 1 if
bfqq is created in burst creation. Function bfq_set_budget_timeout will be
called when bfqq is selected while it's wr_cur_max_time is set and wr_coeff
is 1. Fix this by check wr_coeff > 1 before check wr_cur_max_time.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f4b4ba05f804..20ae52882235 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3271,7 +3271,8 @@ static void bfq_set_budget_timeout(struct bfq_data *bfqd,
 {
 	unsigned int timeout_coeff;
 
-	if (bfqq->wr_cur_max_time == bfqd->bfq_wr_rt_max_time)
+	if (bfqq->wr_coeff > 1 &&
+	    bfqq->wr_cur_max_time == bfqd->bfq_wr_rt_max_time)
 		timeout_coeff = 1;
 	else
 		timeout_coeff = bfqq->entity.weight / bfqq->entity.orig_weight;
-- 
2.30.0

