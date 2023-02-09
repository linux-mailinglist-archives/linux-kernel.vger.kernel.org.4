Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47B369085A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjBIML6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBIMLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:11:14 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD505B461;
        Thu,  9 Feb 2023 04:09:21 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PCFz074J6z4f3jZj;
        Thu,  9 Feb 2023 20:09:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrFr4uRj4rAuDQ--.53349S7;
        Thu, 09 Feb 2023 20:09:19 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, hch@lst.de, jack@suse.cz
Cc:     andriy.shevchenko@linux.intel.com, qiulaibin@huawei.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] blk-mq: remove unnecessary "set->queue_depth == 0" check in blk_mq_alloc_set_map_and_rqs
Date:   Fri, 10 Feb 2023 04:11:14 +0800
Message-Id: <20230209201116.579809-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230209201116.579809-1-shikemeng@huaweicloud.com>
References: <20230209201116.579809-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrFr4uRj4rAuDQ--.53349S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWxAr47WF4xJw4fCrWrAFb_yoW8JF4kpr
        4rJF1kGa4IgrsYkrW2kay7WF1jk398Wr4UJF4Sq345ArZrKrWa9F4rJF4jqryxZrZ3Cw4j
        93y5K3yDXa1UGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0TqcUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will break the loop and set err to -ENOMEM if "set->queue_depth" is
less than "set->reserved_tags + BLK_MQ_TAG_MIN". set->reserved_tags is
unsigned int and should not be less than 0 logically. BLK_MQ_TAG_MIN is
1 and should be greater than 0 logically. So "set->reserved_tags +
BLK_MQ_TAG_MIN" should be greater than 0. For case set->queue_depth is
halved to zero, "set->queue_depth < set->reserved_tags + BLK_MQ_TAG_MIN"
check is always met first, then this branch will set err to -ENOMEM and
break the loop. Then the loop break condition "while(set->queue_depth)"
is never met and set->queue_depth check in "if (!set->queue_depth ||
err)" is redundant. Just remove these checks.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6014d9b5e296..4d2ab01549cd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4324,9 +4324,9 @@ static int blk_mq_alloc_set_map_and_rqs(struct blk_mq_tag_set *set)
 			err = -ENOMEM;
 			break;
 		}
-	} while (set->queue_depth);
+	} while (true);
 
-	if (!set->queue_depth || err) {
+	if (err) {
 		pr_err("blk-mq: failed to allocate request map\n");
 		return -ENOMEM;
 	}
-- 
2.30.0

