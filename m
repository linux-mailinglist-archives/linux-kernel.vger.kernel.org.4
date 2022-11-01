Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ED96146D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiKAJfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiKAJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5644218E30;
        Tue,  1 Nov 2022 02:34:30 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1l8r2g2YzRnsw;
        Tue,  1 Nov 2022 17:29:32 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:27 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 14/20] block, bfq: remove redundant oom_bfqq check for bfqq from bfq_find_close_cooperator
Date:   Tue, 1 Nov 2022 17:34:11 +0800
Message-ID: <20221101093417.10540-15-shikemeng@huawei.com>
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

The oom_bfqq is never added to tree in bfq_pos_tree_add_move, so bfqq
returned from bfq_find_close_cooperator is no need to be checked if it's
oom_bfqq.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b8af0bb98d66..776951156fbc 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3014,8 +3014,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	new_bfqq = bfq_find_close_cooperator(bfqd, bfqq,
 			bfq_io_struct_pos(io_struct, request));
 
-	if (new_bfqq && likely(new_bfqq != &bfqd->oom_bfqq) &&
-	    bfq_may_be_close_cooperator(bfqq, new_bfqq))
+	if (new_bfqq && bfq_may_be_close_cooperator(bfqq, new_bfqq))
 		return bfq_setup_merge(bfqq, new_bfqq);
 
 	return NULL;
-- 
2.30.0

