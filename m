Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C54690858
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBIMLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBIMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:11:13 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907A57A9B;
        Thu,  9 Feb 2023 04:09:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PCFyz5cttz4f3mJK;
        Thu,  9 Feb 2023 20:09:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrFr4uRj4rAuDQ--.53349S4;
        Thu, 09 Feb 2023 20:09:18 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, hch@lst.de, jack@suse.cz
Cc:     andriy.shevchenko@linux.intel.com, qiulaibin@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] blk-mq: count changed hctx as active in blk_mq_get_tag
Date:   Fri, 10 Feb 2023 04:11:11 +0800
Message-Id: <20230209201116.579809-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230209201116.579809-1-shikemeng@huaweicloud.com>
References: <20230209201116.579809-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrFr4uRj4rAuDQ--.53349S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyUZw15ury7ZFy7XryUGFg_yoW8Xr4kp3
        yrta1UKw1ftr4qvF48Gay7Zr1UKan7Wr45J3Z3Xw1rZryDK34Sgw4v9w18ta4FvrZ3CrW3
        Zw1jkrW5tF98C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
        0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUnwa9DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d263ed9926823 ("blk-mq: count the hctx as active before allocating
tag") active hctx before blk_mq_get_tag to avoid petential starvation.
However, the hctx to alloc tag may change in blk_mq_get_tag if
BLK_MQ_REQ_NOWAIT is not set, then there are two problems:
1. The hctx without real allocation is marked active.
2. The starvation problem mentioned in Commit d263ed9926823 ("blk-mq:
count the hctx as active before allocating tag") still exists on the
changed hctx as it maybe not marked active before tag allocation.

For problem 1, the hctx which is marked active probably gets IO
soon or will be marked inactive after lazy detection of tag idle.
Mark changed hctx active to fix problem 2.

Fixes: d263ed992682 ("blk-mq: count the hctx as active before allocating tag")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq-tag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 1d3135acfc98..e566fd96dc26 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -191,6 +191,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		data->ctx = blk_mq_get_ctx(data->q);
 		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
 						data->ctx);
+		if (!(data->rq_flags & RQF_ELV))
+			blk_mq_tag_busy(data->hctx);
+
 		tags = blk_mq_tags_from_data(data);
 		if (data->flags & BLK_MQ_REQ_RESERVED)
 			bt = &tags->breserved_tags;
-- 
2.30.0

