Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3866531E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjAKFEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjAKFDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:03:35 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DCADE8D;
        Tue, 10 Jan 2023 21:03:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NsFv45ykCz4f3v4X;
        Wed, 11 Jan 2023 13:03:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDX9S8fQ75jGl2gBQ--.10280S10;
        Wed, 11 Jan 2023 13:03:31 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, jack@suse.cz
Subject: [PATCH v3 08/14] blk-mq: remove unncessary error count and commit in blk_mq_plug_issue_direct
Date:   Wed, 11 Jan 2023 21:01:53 +0800
Message-Id: <20230111130159.3741753-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDX9S8fQ75jGl2gBQ--.10280S10
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfJryDGFyUGF18Jry5urg_yoW8WrykpF
        W3GanIkrs2qr48Za48JayxA3WUJrs5KryUArZ0kw1ag3yDGr4Sqw4rtryxWry0yrZ3Aa13
        Zrn8W34DJF13Ww7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need only to explicitly commit in two error cases:
 -did not queue everything initially scheduled to queue
 -the last attempt to queue a request failed
(see comment of blk_mq_commit_rqs for more details).
Both cases can be checked with ret of last request which breaks list walk.
Remove unnecessary error count and unnecessary commit triggered by error
which is not covered by cases described above.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 98f6003474f2..c6c84f44c7a6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2706,11 +2706,10 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
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
@@ -2726,20 +2725,15 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 		case BLK_STS_RESOURCE:
 		case BLK_STS_DEV_RESOURCE:
 			blk_mq_request_bypass_insert(rq, false, true);
-			blk_mq_plug_commit_rqs(hctx, &queued);
-			return;
+			goto out;
 		default:
 			blk_mq_end_request(rq, ret);
-			errors++;
 			break;
 		}
 	}
 
-	/*
-	 * If we didn't flush the entire list, we could have told the driver
-	 * there was more coming, but that turned out to be a lie.
-	 */
-	if (errors)
+out:
+	if (ret != BLK_STS_OK)
 		blk_mq_plug_commit_rqs(hctx, &queued);
 }
 
-- 
2.30.0

