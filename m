Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DFD5FB1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJKLsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJKLsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:48:43 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C26CDF;
        Tue, 11 Oct 2022 04:48:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MmvBR5mf9z6PgM4;
        Tue, 11 Oct 2022 19:46:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgD39sgUWEVjhiNqAA--.38017S4;
        Tue, 11 Oct 2022 19:48:38 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, ming.lei@redhat.com, hare@suse.de,
        john.garry@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH] blk-mq: fix null pointer dereference in blk_mq_clear_rq_mapping()
Date:   Tue, 11 Oct 2022 20:10:51 +0800
Message-Id: <20221011121051.3149442-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD39sgUWEVjhiNqAA--.38017S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ury8ZF45ArWDWF45JF43Wrg_yoW8Ww1UpF
        4UGa1YkFZYqr1Uua18Xa9rAryjqw4kWr1rC3W5C3sYvryjkr12kF1ktFWjqr1FyrZ3AFZr
        Jr4ak3y8Ar1DJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Our syzkaller report a null pointer dereference, root cause is
following:

__blk_mq_alloc_map_and_rqs
 set->tags[hctx_idx] = blk_mq_alloc_map_and_rqs
  blk_mq_alloc_map_and_rqs
   blk_mq_alloc_rqso
    // failed due to oom
    alloc_pages_node
    // set->stags[hctx_idx] is still NULL
    blk_mq_free_rqs
     drv_tags = set->tags[hctx_idx];
     // null pointer dereference is triggered
     blk_mq_clear_rq_mapping(drv_tags, ...)

This is because commit 63064be150e4 ("blk-mq:
Add blk_mq_alloc_map_and_rqs()") merged the two steps:

1) set->tags[hctx_idx] = blk_mq_alloc_rq_map()
2) blk_mq_alloc_rqs(..., set->tags[hctx_idx])

into one step:

set->tags[hctx_idx] = blk_mq_alloc_map_and_rqs()

Since tags is not initialized yet in this case, fix the problem by
checking if tags is NULL pointer in blk_mq_clear_rq_mapping().

Fixes: 63064be150e4 ("blk-mq: Add blk_mq_alloc_map_and_rqs()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..33292c01875d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3112,8 +3112,11 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
 	struct page *page;
 	unsigned long flags;
 
-	/* There is no need to clear a driver tags own mapping */
-	if (drv_tags == tags)
+	/*
+	 * There is no need to clear mapping if driver tags is not initialized
+	 * or the mapping belongs to the driver tags.
+	 */
+	if (!drv_tags || drv_tags == tags)
 		return;
 
 	list_for_each_entry(page, &tags->page_list, lru) {
-- 
2.31.1

