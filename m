Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9576A65B917
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbjACByx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjACByY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:54:24 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A356766C;
        Mon,  2 Jan 2023 17:54:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NmG4T1575z4f3kph;
        Tue,  3 Jan 2023 09:54:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBHr7LJirNj9wMDBA--.19481S3;
        Tue, 03 Jan 2023 09:54:19 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.com, paolo.valente@linaro.org, axboe@kernel.dk
Cc:     hch@lst.de, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] block, bfq: correctly raise inject limit in bfq_choose_bfqq_for_injection
Date:   Tue,  3 Jan 2023 17:52:56 +0800
Message-Id: <20230103095303.2223546-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230103095303.2223546-1-shikemeng@huaweicloud.com>
References: <20230103095303.2223546-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHr7LJirNj9wMDBA--.19481S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4xCr1xXrWruF18AF45trb_yoW8ZrW3pa
        47K347C348JF1ruF1jq3WfZFyYqan3CrnrtF13W34Fqryxur92gasFg3y5Za1ftFZ3Aw4j
        v3WUWa4q9F15CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsgyZUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function bfq_choose_bfqq_for_injection may temporarily raise inject limit
to one request if current inject_limit is 0 before search of the source
queue for injection. However the search below will reset inject limit to
bfqd->in_service_queue which is zero for raised inject limit. Then the
temporarily raised inject limit never works as expected.
Assigment limit to bfqd->in_service_queue in search is needed as limit
maybe overwriten to min_t(unsigned int, 1, limit) for condition that
a large in-flight request is on non-rotational devices in found queue.
So we need to reset limit to bfqd->in_service_queue for normal case.

Actually, we have already make sure bfqd->rq_in_driver is < limit before
search, then
 -Limit is >= 1 as bfqd->rq_in_driver is >= 0. Then min_t(unsigned int,
1, limit) is always 1. So we can simply check bfqd->rq_in_driver with
1 instead of result of min_t(unsigned int, 1, limit) for larget request in
non-rotational device case to avoid overwritting limit and the bug is gone.
 -For normal case, we have already check bfqd->rq_in_driver is < limit,
so we can return found bfqq unconditionally to remove unncessary check.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a72304c728fc..1220c41fc767 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4641,12 +4641,10 @@ bfq_choose_bfqq_for_injection(struct bfq_data *bfqd)
 			 */
 			if (blk_queue_nonrot(bfqd->queue) &&
 			    blk_rq_sectors(bfqq->next_rq) >=
-			    BFQQ_SECT_THR_NONROT)
-				limit = min_t(unsigned int, 1, limit);
-			else
-				limit = in_serv_bfqq->inject_limit;
-
-			if (bfqd->rq_in_driver < limit) {
+			    BFQQ_SECT_THR_NONROT &&
+			    bfqd->rq_in_driver >= 1)
+				continue;
+			else {
 				bfqd->rqs_injected = true;
 				return bfqq;
 			}
-- 
2.30.0

