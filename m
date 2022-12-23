Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB5654C19
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiLWEy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiLWExf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:53:35 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBAA12771;
        Thu, 22 Dec 2022 20:53:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NdZZK23gYz4f3xJn;
        Fri, 23 Dec 2022 12:53:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXjbFHNKVjpOduAQ--.93S11;
        Fri, 23 Dec 2022 12:53:32 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, john.garry@huawei.com, shikemeng@huaweicloud.com
Subject: [PATCH 09/13] blk-mq: remove unnecessary error count and check in blk_mq_dispatch_rq_list
Date:   Fri, 23 Dec 2022 20:52:19 +0800
Message-Id: <20221223125223.1687670-10-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221223125223.1687670-1-shikemeng@huaweicloud.com>
References: <20221223125223.1687670-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXjbFHNKVjpOduAQ--.93S11
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar47WrW7uF4kWFyrGw15Jwb_yoW8uw1xpF
        45Gan0y3yrXF40qFy8Aa9xGwn5trs5Cw1DGFy3C3yavFnrKrs7JF4rJrWUu3WfKrs09F47
        XF18WrWYvan7WrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
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

blk_mq_dispatch_rq_list will notify if hctx is busy in return bool. It will
return true if we are not busy and can handle more and return false on the
opposite. Inside blk_mq_dispatch_rq_list, we will return true if list is
empty and (errors + queued) != 0.

For busy error BLK_STS*_RESOURCE, the failed request will be added back
to list and list will not be empty. We count queued for BLK_STS_OK and
errors for rest error except busy error.
So if list is empty, (errors + queued) will be total requests in the list
which is checked not empty at beginning of blk_mq_dispatch_rq_list. So
(errors + queued) != 0 is always met if all requests are handled. Then the
(errors + queued) != 0 check and errors number count is not needed.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9c5971b04adc..97e2a07062de 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2009,7 +2009,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	enum prep_dispatch prep;
 	struct request_queue *q = hctx->queue;
 	struct request *rq, *nxt;
-	int errors, queued;
+	int queued;
 	blk_status_t ret = BLK_STS_OK;
 	LIST_HEAD(zone_list);
 	bool needs_resource = false;
@@ -2020,7 +2020,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
-	errors = queued = 0;
+	queued = 0;
 	do {
 		struct blk_mq_queue_data bd;
 
@@ -2073,7 +2073,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			needs_resource = true;
 			break;
 		default:
-			errors++;
 			blk_mq_end_request(rq, ret);
 		}
 	} while (!list_empty(list));
@@ -2151,10 +2150,10 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 
 		blk_mq_update_dispatch_busy(hctx, true);
 		return false;
-	} else
-		blk_mq_update_dispatch_busy(hctx, false);
+	}
 
-	return (queued + errors) != 0;
+	blk_mq_update_dispatch_busy(hctx, false);
+	return true;
 }
 
 /**
-- 
2.30.0

