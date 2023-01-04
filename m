Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50A565CD06
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjADGYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjADGYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:24:23 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC81C17E3E;
        Tue,  3 Jan 2023 22:24:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nn01X2dNwz4f3pPX;
        Wed,  4 Jan 2023 14:24:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbGOG7Vju3lKBA--.23788S8;
        Wed, 04 Jan 2023 14:24:18 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v2 06/13] blk-mq: remove unncessary error count and flush in blk_mq_plug_issue_direct
Date:   Wed,  4 Jan 2023 22:22:52 +0800
Message-Id: <20230104142259.2673013-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
References: <20230104142259.2673013-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbGOG7Vju3lKBA--.23788S8
X-Coremail-Antispam: 1UD129KBjvJXoW7AF13uFW7Xr43tF1DCr4kZwb_yoW8Kw4xpF
        W5GanFkrn5XrW8ZrW8Aa9rA34j9rWrtFW3Wrs0yw13XrZ8GrWY9ry5trWSgryIkrs3Aw43
        Wrs0g3s8Xr15XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

blk_mq_plug_issue_direct try to send a list of requests which belong to
different hctxs. Normally, we will send flush when hctx changes as there
maybe no more request for the same hctx. Besides we will send flush along
with last request in the list by set last parameter of
blk_mq_request_issue_directly.

Extra flush is needed for two cases:
1. We stop sending at middle of list, then normal flush sent after last
request of current hctx is miss.
2. Error happens at sending last request and normal flush may be lost.

In blk_mq_plug_issue_direct, we only break the list walk if we get
BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE error. We will send extra flush
for this case already.
We count error number and send extra flush if error number is non-zero
after sending all requests in list. This could cover case 2 described
above, but there are two things to improve:
1. If last request is sent successfully, error of request at middle of list
will trigger an unnecessary flush.
2. We only need error of last request instead of error number and error of
last request can be simply retrieved from ret.

Cover case 2 above by simply check ret of last request and remove
unnecessary error count and flush to improve blk_mq_plug_issue_direct.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d84ce1f758ce..ba917b6b5cc1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2687,11 +2687,10 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 	struct blk_mq_hw_ctx *hctx = NULL;
 	struct request *rq;
 	int queued = 0;
-	int errors = 0;
+	blk_status_t ret;
 
 	while ((rq = rq_list_pop(&plug->mq_list))) {
 		bool last = rq_list_empty(plug->mq_list);
-		blk_status_t ret;
 
 		if (hctx != rq->mq_hctx) {
 			if (hctx)
@@ -2711,7 +2710,6 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 			return;
 		default:
 			blk_mq_end_request(rq, ret);
-			errors++;
 			break;
 		}
 	}
@@ -2720,7 +2718,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 	 * If we didn't flush the entire list, we could have told the driver
 	 * there was more coming, but that turned out to be a lie.
 	 */
-	if (errors)
+	if (ret != BLK_STS_OK)
 		blk_mq_commit_rqs(hctx, &queued, from_schedule);
 }
 
-- 
2.30.0

