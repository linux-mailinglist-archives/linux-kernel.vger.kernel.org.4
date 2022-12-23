Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D49654C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiLWEye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiLWExg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:53:36 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066618E1C;
        Thu, 22 Dec 2022 20:53:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NdZZK5DtNz4f3xK8;
        Fri, 23 Dec 2022 12:53:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXjbFHNKVjpOduAQ--.93S12;
        Fri, 23 Dec 2022 12:53:32 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, john.garry@huawei.com, shikemeng@huaweicloud.com
Subject: [PATCH 10/13] blk-mq: remove set of bd->last when get driver tag for next request fails
Date:   Fri, 23 Dec 2022 20:52:20 +0800
Message-Id: <20221223125223.1687670-11-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221223125223.1687670-1-shikemeng@huaweicloud.com>
References: <20221223125223.1687670-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXjbFHNKVjpOduAQ--.93S12
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryrKr17Cr1DAw1rCrWxWFg_yoW8Kr18pF
        43Jayakr45XF40gFW8AwsrWr45Jw4DArWayrn8u34Fqrn8Crs7KFy8J3y8ZFySvrZ7CrsI
        gr4qgryDZr48WFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 113285b473824 ("blk-mq: ensure that bd->last is always set
correctly") will set last if we failed to get driver tag for next
request to avoid flush miss as we break the list walk and will not
send the last request in the list which will be sent with last set
normally.
This code seems stale now becase the flush introduced is always
redundant as:
For case tag is really out, we will send a extra flush if we find
list is not empty after list walk.
For case some tag is freed before retry in blk_mq_prep_dispatch_rq for
next, then we can get a tag for next request in retry and flush notified
already is not necessary.

Just remove these stale codes.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 97e2a07062de..452f2e0fba05 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1916,16 +1916,6 @@ static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
 static void blk_mq_handle_dev_resource(struct request *rq,
 				       struct list_head *list)
 {
-	struct request *next =
-		list_first_entry_or_null(list, struct request, queuelist);
-
-	/*
-	 * If an I/O scheduler has been configured and we got a driver tag for
-	 * the next request already, free it.
-	 */
-	if (next)
-		blk_mq_put_driver_tag(next);
-
 	list_add(&rq->queuelist, list);
 	__blk_mq_requeue_request(rq);
 }
@@ -2008,7 +1998,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 {
 	enum prep_dispatch prep;
 	struct request_queue *q = hctx->queue;
-	struct request *rq, *nxt;
+	struct request *rq;
 	int queued;
 	blk_status_t ret = BLK_STS_OK;
 	LIST_HEAD(zone_list);
@@ -2034,17 +2024,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 		list_del_init(&rq->queuelist);
 
 		bd.rq = rq;
-
-		/*
-		 * Flag last if we have no more requests, or if we have more
-		 * but can't assign a driver tag to it.
-		 */
-		if (list_empty(list))
-			bd.last = true;
-		else {
-			nxt = list_first_entry(list, struct request, queuelist);
-			bd.last = !blk_mq_get_driver_tag(nxt);
-		}
+		bd.last = list_empty(list);
 
 		/*
 		 * once the request is queued to lld, no need to cover the
-- 
2.30.0

