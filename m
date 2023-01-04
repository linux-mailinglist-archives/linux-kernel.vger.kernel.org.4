Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E228E65CD07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjADGY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjADGYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:24:24 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AE417419;
        Tue,  3 Jan 2023 22:24:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nn01Y4G52z4f3pPn;
        Wed,  4 Jan 2023 14:24:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbGOG7Vju3lKBA--.23788S11;
        Wed, 04 Jan 2023 14:24:20 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v2 09/13] blk-mq: remove unnecessary error count and check in blk_mq_dispatch_rq_list
Date:   Wed,  4 Jan 2023 22:22:55 +0800
Message-Id: <20230104142259.2673013-10-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
References: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbGOG7Vju3lKBA--.23788S11
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar47WrW7uF4kWFyrGw15Jwb_yoW8uw1xpF
        45Gan0y3yrXF40qFy8Aa9xGwn5trs5Aw1DGF9xC3yavFsrKrs7JF4rJrWUua1fKrs09ay7
        XF1UWrWYyws7XrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0TqcUUUUUU==
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
index c543c14fdb47..c1d4d899f059 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2010,7 +2010,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	enum prep_dispatch prep;
 	struct request_queue *q = hctx->queue;
 	struct request *rq, *nxt;
-	int errors, queued;
+	int queued;
 	blk_status_t ret = BLK_STS_OK;
 	LIST_HEAD(zone_list);
 	bool needs_resource = false;
@@ -2021,7 +2021,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
-	errors = queued = 0;
+	queued = 0;
 	do {
 		struct blk_mq_queue_data bd;
 
@@ -2074,7 +2074,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			needs_resource = true;
 			break;
 		default:
-			errors++;
 			blk_mq_end_request(rq, ret);
 		}
 	} while (!list_empty(list));
@@ -2152,10 +2151,10 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 
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

