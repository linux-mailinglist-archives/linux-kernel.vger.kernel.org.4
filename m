Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49812671034
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjARBjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjARBjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:39:05 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEC751C7C;
        Tue, 17 Jan 2023 17:39:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NxT1t1nxSz4f3jJ5;
        Wed, 18 Jan 2023 09:38:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOqxTcdjBACUBw--.30342S7;
        Wed, 18 Jan 2023 09:38:59 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v4 06/14] blk-mq: remove unncessary from_schedule parameter in blk_mq_plug_issue_direct
Date:   Wed, 18 Jan 2023 17:37:18 +0800
Message-Id: <20230118093726.3939160-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOqxTcdjBACUBw--.30342S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CryxAF45uw43WF4rCrWrAFb_yoW8tw1DpF
        W5Xa12yrWrXrZ7X3y8Aan3Zry3Cr4kKrW3Kr1ay34fXr45K3yIqw4rJ343ArWIyFs5Ar43
        ur45K343Jr15GwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU058n7UUUUU==
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

Function blk_mq_plug_issue_direct tries to issue batch requests in plug
list to driver directly. We will only issue plug request to driver if we
are not from scheduler, so from_scheduler parameter of
blk_mq_plug_issue_direct is always false.
Remove unncessary from_scheduler of blk_mq_plug_issue_direct.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7160af49c245..5d146ec9f8cb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2688,7 +2688,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	return __blk_mq_try_issue_directly(rq->mq_hctx, rq, true, last);
 }
 
-static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
+static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
 	struct request *rq;
@@ -2701,7 +2701,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 
 		if (hctx != rq->mq_hctx) {
 			if (hctx)
-				blk_mq_commit_rqs(hctx, &queued, from_schedule);
+				blk_mq_commit_rqs(hctx, &queued, false);
 			hctx = rq->mq_hctx;
 		}
 
@@ -2713,7 +2713,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
 			blk_mq_request_bypass_insert(rq, false, true);
-			blk_mq_commit_rqs(hctx, &queued, from_schedule);
+			blk_mq_commit_rqs(hctx, &queued, false);
 			return;
 		default:
 			blk_mq_end_request(rq, ret);
@@ -2727,7 +2727,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 	 * there was more coming, but that turned out to be a lie.
 	 */
 	if (errors)
-		blk_mq_commit_rqs(hctx, &queued, from_schedule);
+		blk_mq_commit_rqs(hctx, &queued, false);
 }
 
 static void __blk_mq_flush_plug_list(struct request_queue *q,
@@ -2798,7 +2798,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		}
 
 		blk_mq_run_dispatch_ops(q,
-				blk_mq_plug_issue_direct(plug, false));
+				blk_mq_plug_issue_direct(plug));
 		if (rq_list_empty(plug->mq_list))
 			return;
 	}
-- 
2.30.0

