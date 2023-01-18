Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F867103B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjARBkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjARBjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:39:06 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C865143A;
        Tue, 17 Jan 2023 17:39:04 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NxT1v2pcZz4f4fwl;
        Wed, 18 Jan 2023 09:38:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOqxTcdjBACUBw--.30342S12;
        Wed, 18 Jan 2023 09:39:01 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v4 11/14] blk-mq: remove unnecessary error count and check in blk_mq_dispatch_rq_list
Date:   Wed, 18 Jan 2023 17:37:23 +0800
Message-Id: <20230118093726.3939160-11-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOqxTcdjBACUBw--.30342S12
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar47WrW5WFW7Cr45Cr45Jrb_yoW8tw4rpF
        45Gan0y34rXr40qry8Aa9xGwn0qrs5AryDWF9xC3yavF17Krs7Jr4rJrWUuFyfKrs0kF47
        XF18WrWYyws7XrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUxD7aUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_mq_dispatch_rq_list will notify if hctx is busy in return bool. It will
return true if we are not busy and can handle more and return false on the
opposite. Inside blk_mq_dispatch_rq_list, errors is only used if list is
empty and we will return true if list is empty and (errors + queued) != 0.

There are three types of status returned from request:
 -busy error BLK_STS*_RESOURCE: the failed request will be added back
to list and list will not be empty.
 -BLK_STS_OK: We count queued for BLK_STS_OK
 -rest error: We count errors for rest error

If list is empty, there is no request gets busy error then (errors +
queued) will be total requests in the list which is checked not empty at
beginning of blk_mq_dispatch_rq_list. So (errors + queued) != 0 is always
met if list is empty. Then the (errors + queued) != 0 check and errors
number count is not needed.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4fdb01475b6..90471b5c868f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2033,7 +2033,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	enum prep_dispatch prep;
 	struct request_queue *q = hctx->queue;
 	struct request *rq, *nxt;
-	int errors, queued;
+	int queued;
 	blk_status_t ret = BLK_STS_OK;
 	LIST_HEAD(zone_list);
 	bool needs_resource = false;
@@ -2044,7 +2044,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
-	errors = queued = 0;
+	queued = 0;
 	do {
 		struct blk_mq_queue_data bd;
 
@@ -2097,7 +2097,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 			needs_resource = true;
 			break;
 		default:
-			errors++;
 			blk_mq_end_request(rq, ret);
 		}
 	} while (!list_empty(list));
@@ -2175,10 +2174,10 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
 
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

