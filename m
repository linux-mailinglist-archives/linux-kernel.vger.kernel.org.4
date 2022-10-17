Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B67600513
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJQCAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJQCAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:00:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1817F26101;
        Sun, 16 Oct 2022 19:00:21 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MrKqg1lPtzpW9D;
        Mon, 17 Oct 2022 09:57:03 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 10:00:18 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shikemeng@huawei.com>
Subject: [PATCH 8/8] blk-iocost: Get ioc_now inside weight_updated
Date:   Mon, 17 Oct 2022 10:00:11 +0800
Message-ID: <20221017020011.25016-9-shikemeng@huawei.com>
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

The ioc_now parameter of weight_updated is only needed if we need call
propagate_weights. Move ioc_now inside weight_updated to remove
unnecessary get of ioc_now from outside of weight_updated.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/blk-iocost.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 4815e676733d..e2aaf133deb8 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1220,18 +1220,21 @@ static u32 current_hweight_max(struct ioc_gq *iocg)
 	return max_t(u32, hwm, 1);
 }
 
-static void weight_updated(struct ioc_gq *iocg, struct ioc_now *now)
+static void weight_updated(struct ioc_gq *iocg)
 {
 	struct ioc *ioc = iocg->ioc;
 	struct blkcg_gq *blkg = iocg_to_blkg(iocg);
 	struct ioc_cgrp *iocc = blkcg_to_iocc(blkg->blkcg);
+	struct ioc_now now;
 	u32 weight;
 
 	lockdep_assert_held(&ioc->lock);
 
 	weight = iocg->cfg_weight ?: iocc->dfl_weight;
-	if (weight != iocg->weight && iocg->active)
-		propagate_weights(iocg, weight, iocg->inuse, true, now);
+	if (weight != iocg->weight && iocg->active) {
+		ioc_now(iocg->ioc, &now);
+		propagate_weights(iocg, weight, iocg->inuse, true, &now);
+	}
 	iocg->weight = weight;
 }
 
@@ -2968,7 +2971,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	}
 
 	spin_lock_irqsave(&ioc->lock, flags);
-	weight_updated(iocg, NULL);
+	weight_updated(iocg);
 	spin_unlock_irqrestore(&ioc->lock, flags);
 }
 
@@ -3053,7 +3056,6 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 	struct blkcg *blkcg = css_to_blkcg(of_css(of));
 	struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
 	struct blkg_conf_ctx ctx;
-	struct ioc_now now;
 	struct ioc_gq *iocg;
 	u32 v;
 	int ret;
@@ -3074,8 +3076,7 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 
 			if (iocg) {
 				spin_lock(&iocg->ioc->lock);
-				ioc_now(iocg->ioc, &now);
-				weight_updated(iocg, &now);
+				weight_updated(iocg);
 				spin_unlock(&iocg->ioc->lock);
 			}
 		}
@@ -3101,8 +3102,7 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 
 	spin_lock(&iocg->ioc->lock);
 	iocg->cfg_weight = v * WEIGHT_ONE;
-	ioc_now(iocg->ioc, &now);
-	weight_updated(iocg, &now);
+	weight_updated(iocg);
 	spin_unlock(&iocg->ioc->lock);
 
 	blkg_conf_finish(&ctx);
-- 
2.30.0

