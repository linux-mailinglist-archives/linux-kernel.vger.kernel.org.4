Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8CE6146BE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKAJef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiKAJeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EFF18E05;
        Tue,  1 Nov 2022 02:34:24 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1lBL0FpnzpW45;
        Tue,  1 Nov 2022 17:30:50 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:21 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 03/20] block, bfq: correct bfq_max_budget and bfq_min_budget
Date:   Tue, 1 Nov 2022 17:34:00 +0800
Message-ID: <20221101093417.10540-4-shikemeng@huawei.com>
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

The budgets_assigned is checked to make sure enough samples have been
computed for auto-tuning. Ignore budgets_assigned if auto-tuning is
disabled as bfq_default_max_budget is set by user.
The bfq_default_max_budget check is added after budgets_assigned check,
so no extra cost is added for normal branch to return bfqd->bfq_max_budget.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 13370c41ad36..b21c3711d69d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1485,7 +1485,8 @@ static int bfq_bfqq_budget_left(struct bfq_queue *bfqq)
  */
 static int bfq_max_budget(struct bfq_data *bfqd)
 {
-	if (bfqd->budgets_assigned < bfq_stats_min_budgets)
+	if (bfqd->budgets_assigned < bfq_stats_min_budgets &&
+			bfqd->bfq_user_max_budget == 0)
 		return bfq_default_max_budget;
 	else
 		return bfqd->bfq_max_budget;
@@ -1497,7 +1498,8 @@ static int bfq_max_budget(struct bfq_data *bfqd)
  */
 static int bfq_min_budget(struct bfq_data *bfqd)
 {
-	if (bfqd->budgets_assigned < bfq_stats_min_budgets)
+	if (bfqd->budgets_assigned < bfq_stats_min_budgets &&
+			bfqd->bfq_user_max_budget == 0)
 		return bfq_default_max_budget / 32;
 	else
 		return bfqd->bfq_max_budget / 32;
-- 
2.30.0

