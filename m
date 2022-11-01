Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0315E6146D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKAJfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiKAJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB09119027;
        Tue,  1 Nov 2022 02:34:30 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1l8r705dzRnsb;
        Tue,  1 Nov 2022 17:29:32 +0800 (CST)
Received: from huawei.com (10.174.178.129) by kwepemi500016.china.huawei.com
 (7.221.188.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 17:34:28 +0800
From:   Kemeng Shi <shikemeng@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>
Subject: [PATCH 15/20] block, bfq: some cleanups for function bfq_pos_tree_add_move
Date:   Tue, 1 Nov 2022 17:34:12 +0800
Message-ID: <20221101093417.10540-16-shikemeng@huawei.com>
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

There are three cleanups in this patch:
1. The oom_bfqq is never inserted to tree, so return immediately for
oom_bfqq before unnecessary NULL check of bfqq->pos_root.
2. Only set bfqq->pos_root after bfq_rq_pos_tree_lookup successes rather
than set bfqq->pos_root unconditionally and reset to NULL if
bfq_rq_pos_tree_lookup fails.
3. Remove unnecessary local variable __bfqq which is only used to check
return value of bfq_rq_pos_tree_lookup.

Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
---
 block/bfq-iosched.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 776951156fbc..dd9a51255a0f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -758,17 +758,16 @@ void __cold
 bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
 	struct rb_node **p, *parent;
-	struct bfq_queue *__bfqq;
+
+	/* oom_bfqq does not participate in queue merging */
+	if (bfqq == &bfqd->oom_bfqq)
+		return;
 
 	if (bfqq->pos_root) {
 		rb_erase(&bfqq->pos_node, bfqq->pos_root);
 		bfqq->pos_root = NULL;
 	}
 
-	/* oom_bfqq does not participate in queue merging */
-	if (bfqq == &bfqd->oom_bfqq)
-		return;
-
 	/*
 	 * bfqq cannot be merged any longer (see comments in
 	 * bfq_setup_cooperator): no point in adding bfqq into the
@@ -782,14 +781,13 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	if (!bfqq->next_rq)
 		return;
 
+	if (bfq_rq_pos_tree_lookup(bfqd, &bfqq_group(bfqq)->rq_pos_tree,
+			blk_rq_pos(bfqq->next_rq), &parent, &p))
+		return;
+
 	bfqq->pos_root = &bfqq_group(bfqq)->rq_pos_tree;
-	__bfqq = bfq_rq_pos_tree_lookup(bfqd, bfqq->pos_root,
-			blk_rq_pos(bfqq->next_rq), &parent, &p);
-	if (!__bfqq) {
-		rb_link_node(&bfqq->pos_node, parent, p);
-		rb_insert_color(&bfqq->pos_node, bfqq->pos_root);
-	} else
-		bfqq->pos_root = NULL;
+	rb_link_node(&bfqq->pos_node, parent, p);
+	rb_insert_color(&bfqq->pos_node, bfqq->pos_root);
 }
 
 /*
-- 
2.30.0

