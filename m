Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287D3600512
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJQCAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJQCAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:00:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BEF248E0;
        Sun, 16 Oct 2022 19:00:20 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MrKp14d6czmVCT;
        Mon, 17 Oct 2022 09:55:37 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 10:00:17 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shikemeng@huawei.com>
Subject: [PATCH 7/8] blk-iocost: Remove redundant initialization of struct ioc_gq
Date:   Mon, 17 Oct 2022 10:00:10 +0800
Message-ID: <20221017020011.25016-8-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221017020011.25016-1-shikemeng@huawei.com>
References: <20221017020011.25016-1-shikemeng@huawei.com>
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

Some member of struct ioc_gq will not be accessed before it's
first activation and will be initialized again in it's first
activation after ioc_pd_init. To be more specific:
1)Member iocg->vtime and iocg->done_vtime will set to target in
activation which only expects vtime is equal to done_vtime in
first activation.
2)Member iocg->active_period will be set with ioc->cur_period
again in first activation.

Remove the redundant initialization to improve ioc_pd_init a
littile bit.

The parameter now of weight_updated will not be used if iocg is
not active, so pass NULL to weight_update here is safe and we
can remove call to ioc_now.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-iocost.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index fa90f471dfdc..4815e676733d 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2946,16 +2946,10 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 	struct blkcg_gq *blkg = pd_to_blkg(&iocg->pd);
 	struct ioc *ioc = q_to_ioc(blkg->q);
-	struct ioc_now now;
 	struct blkcg_gq *tblkg;
 	unsigned long flags;
 
-	ioc_now(ioc, &now);
-
 	iocg->ioc = ioc;
-	atomic64_set(&iocg->vtime, now.vnow);
-	atomic64_set(&iocg->done_vtime, now.vnow);
-	atomic64_set(&iocg->active_period, atomic64_read(&ioc->cur_period));
 	INIT_LIST_HEAD(&iocg->active_list);
 	INIT_LIST_HEAD(&iocg->walk_list);
 	INIT_LIST_HEAD(&iocg->surplus_list);
@@ -2974,7 +2968,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	}
 
 	spin_lock_irqsave(&ioc->lock, flags);
-	weight_updated(iocg, &now);
+	weight_updated(iocg, NULL);
 	spin_unlock_irqrestore(&ioc->lock, flags);
 }
 
-- 
2.30.0

