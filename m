Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BB369BE46
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 03:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBSCmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 21:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBSCla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 21:41:30 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0B11EB8;
        Sat, 18 Feb 2023 18:41:29 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PK8v86GY0z4f3t7T;
        Sun, 19 Feb 2023 10:41:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7utQjPFjPmleDw--.7604S17;
        Sun, 19 Feb 2023 10:41:26 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 15/17] block, bfq: some cleanups for function bfq_pos_tree_add_move
Date:   Sun, 19 Feb 2023 18:43:07 +0800
Message-Id: <20230219104309.1511562-16-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
References: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7utQjPFjPmleDw--.7604S17
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW5Xw4rAF4UtF13Cw4kZwb_yoW8ur4xpF
        13KFWFy348Xrn8WryrZ3WUZw1Syw1fWr97GrZxZw1rJr47ArnFqFnIvwnYqFyfZFZ7C3W3
        Xr4Yq34kAr1Uua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ee02c7502394..6ba096e9aec6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -783,17 +783,16 @@ void __cold
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
@@ -807,14 +806,13 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
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

