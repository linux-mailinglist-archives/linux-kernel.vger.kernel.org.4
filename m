Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D35A6146BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiKAJeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiKAJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D618E11;
        Tue,  1 Nov 2022 02:34:23 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1lGL65LYzmVW6;
        Tue,  1 Nov 2022 17:34:18 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:20 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 02/20] block, bfq: Update bfqd->max_budget with bfqd->lock held
Date:   Tue, 1 Nov 2022 17:33:59 +0800
Message-ID: <20221101093417.10540-3-shikemeng@huawei.com>
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

bfq_max_budget and bfq_user_max_budget maybe be in inconsisten state if
bfq_max_budget configuration and bfq_max_budget auto-update happen
concurrently.
Example sequence:
config                          auto-update
bfqd->bfq_max_budget =
  __data
                                if (bfqd->bfq_user_max_budget == 0)
                                  bfqd->bfq_max_budget =
                                    bfq_calc_max_budget(bfqd);
bfqd->bfq_user_max_budget =
  __data;

bfq_max_budget is only update in update_thr_responsiveness_params and
configuration code. As update_thr_responsiveness_params is always called
under bfqd->lock, fix this by holding lock in configuration code.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 25a88ffd997e..13370c41ad36 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7328,6 +7328,7 @@ static ssize_t bfq_max_budget_store(struct elevator_queue *e,
 	if (ret)
 		return ret;
 
+	spin_lock_irq(&bfqd->lock);
 	if (__data == 0)
 		bfqd->bfq_max_budget = bfq_calc_max_budget(bfqd);
 	else {
@@ -7337,6 +7338,7 @@ static ssize_t bfq_max_budget_store(struct elevator_queue *e,
 	}
 
 	bfqd->bfq_user_max_budget = __data;
+	spin_unlock_irq(&bfqd->lock);
 
 	return count;
 }
@@ -7362,8 +7364,11 @@ static ssize_t bfq_timeout_sync_store(struct elevator_queue *e,
 		__data = INT_MAX;
 
 	bfqd->bfq_timeout = msecs_to_jiffies(__data);
+
+	spin_lock_irq(&bfqd->lock);
 	if (bfqd->bfq_user_max_budget == 0)
 		bfqd->bfq_max_budget = bfq_calc_max_budget(bfqd);
+	spin_unlock_irq(&bfqd->lock);
 
 	return count;
 }
-- 
2.30.0

