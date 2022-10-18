Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91E8602B95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJRMTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJRMTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:19:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F242E6;
        Tue, 18 Oct 2022 05:19:38 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MsCbQ0hRbzHtx3;
        Tue, 18 Oct 2022 20:19:30 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 20:19:35 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <tj@kernel.org>, <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shikemeng@huawei.com>
Subject: [PATCH v2 2/5] blk-iocost: Reset vtime_base_rate in ioc_refresh_params
Date:   Tue, 18 Oct 2022 20:19:29 +0800
Message-ID: <20221018121932.10792-3-shikemeng@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
In-Reply-To: <20221018121932.10792-1-shikemeng@huawei.com>
References: <20221018121932.10792-1-shikemeng@huawei.com>
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

Since commit ac33e91e2daca("blk-iocost: implement vtime loss compensation")
split vtime_rate into vtime_rate and vtime_base_rate, we need reset both
vtime_base_rate and vtime_rate when device parameters are refreshed.
If vtime_base_rate is no reset here, vtime_rate will be overwritten with
old vtime_base_rate soon in ioc_refresh_vrate.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index be4bc38821e2..9214733bbc14 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -906,8 +906,10 @@ static bool ioc_refresh_params(struct ioc *ioc, bool force)
 	if (idx == ioc->autop_idx && !force)
 		return false;
 
-	if (idx != ioc->autop_idx)
+	if (idx != ioc->autop_idx) {
 		atomic64_set(&ioc->vtime_rate, VTIME_PER_USEC);
+		ioc->vtime_base_rate = VTIME_PER_USEC;
+	}
 
 	ioc->autop_idx = idx;
 	ioc->autop_too_fast_at = 0;
-- 
2.30.0

