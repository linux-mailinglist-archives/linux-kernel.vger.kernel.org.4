Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7BE654C15
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiLWEyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiLWExe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:53:34 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904072654D;
        Thu, 22 Dec 2022 20:53:33 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NdZZJ2DZ0z4f3p5T;
        Fri, 23 Dec 2022 12:53:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXjbFHNKVjpOduAQ--.93S8;
        Fri, 23 Dec 2022 12:53:31 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, john.garry@huawei.com, shikemeng@huaweicloud.com
Subject: [PATCH 06/13] blk-mq: remove unncessary error count and flush in blk_mq_plug_issue_direct
Date:   Fri, 23 Dec 2022 20:52:16 +0800
Message-Id: <20221223125223.1687670-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221223125223.1687670-1-shikemeng@huaweicloud.com>
References: <20221223125223.1687670-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXjbFHNKVjpOduAQ--.93S8
X-Coremail-Antispam: 1UD129KBjvJXoW7AF13uFW7Xr43tF1DCr4kZwb_yoW8Kw4xpF
        W5GanFkrn5XrW8Zry8Aa9rA34jvrWrJFW3Wrn0yw13XrZ8GrWa9ry5trWSgryIyrs3Aw43
        ur4Yg34DXr15XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
index a447a7586032..01f48a73eacd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2686,11 +2686,10 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
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
@@ -2710,7 +2709,6 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 			return;
 		default:
 			blk_mq_end_request(rq, ret);
-			errors++;
 			break;
 		}
 	}
@@ -2719,7 +2717,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_schedule)
 	 * If we didn't flush the entire list, we could have told the driver
 	 * there was more coming, but that turned out to be a lie.
 	 */
-	if (errors)
+	if (ret != BLK_STS_OK)
 		blk_mq_commit_rqs(hctx, &queued, from_schedule);
 }
 
-- 
2.30.0

