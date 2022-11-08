Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C54620886
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiKHExi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiKHEwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:52:44 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1889F326F9;
        Mon,  7 Nov 2022 20:52:36 -0800 (PST)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N5wcZ1b8DzJnVD;
        Tue,  8 Nov 2022 12:49:34 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 12:52:33 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 10/10] block, bfq: remove check of bfq_wr_max_softrt_rate which is always greater than 0
Date:   Tue, 8 Nov 2022 12:52:24 +0800
Message-ID: <20221108045224.19092-11-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221108045224.19092-1-shikemeng@huawei.com>
References: <20221108045224.19092-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bfqd->bfq_wr_max_softrt_rate is assigned with 7000 in bfq_init_queue and
never changed. So we can remove bfqd->bfq_wr_max_softrt_rate > 0 check
which is always true.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 40ac219b2d8f..d0a867b2569b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1840,8 +1840,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 *   to control its weight explicitly)
 	 */
 	in_burst = bfq_bfqq_in_large_burst(bfqq);
-	soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
-		!BFQQ_TOTALLY_SEEKY(bfqq) &&
+	soft_rt = !BFQQ_TOTALLY_SEEKY(bfqq) &&
 		!in_burst &&
 		time_is_before_jiffies(bfqq->soft_rt_next_start) &&
 		bfqq->dispatched == 0 &&
@@ -4350,8 +4349,7 @@ void bfq_bfqq_expire(struct bfq_data *bfqd,
 	if (bfqd->low_latency && bfqq->wr_coeff == 1)
 		bfqq->last_wr_start_finish = jiffies;
 
-	if (bfqd->low_latency && bfqd->bfq_wr_max_softrt_rate > 0 &&
-	    RB_EMPTY_ROOT(&bfqq->sort_list)) {
+	if (bfqd->low_latency && RB_EMPTY_ROOT(&bfqq->sort_list)) {
 		/*
 		 * If we get here, and there are no outstanding
 		 * requests, then the request pattern is isochronous
-- 
2.30.0

