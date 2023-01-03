Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2554465B916
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 02:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjACByl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 20:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjACByY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:54:24 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C0C766F;
        Mon,  2 Jan 2023 17:54:23 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NmG4T6xhLz4f3v4j;
        Tue,  3 Jan 2023 09:54:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBHr7LJirNj9wMDBA--.19481S5;
        Tue, 03 Jan 2023 09:54:20 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     jack@suse.com, paolo.valente@linaro.org, axboe@kernel.dk
Cc:     hch@lst.de, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] block, bfq: initialize bfqq->decrease_time_jif correctly
Date:   Tue,  3 Jan 2023 17:52:58 +0800
Message-Id: <20230103095303.2223546-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230103095303.2223546-1-shikemeng@huaweicloud.com>
References: <20230103095303.2223546-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHr7LJirNj9wMDBA--.19481S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4Utw1kuw4fJr45tF4ruFg_yoW8Aw4xpa
        9Fgr47KF1jqFy3WF1UA3WDGFy5Krs09ry7J3W2g392y3yUArnF9FsYkrWYvFWfGrs7Aw10
        qw4vqr9ruw1F9FJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIq2MUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inject limit is updated or reset when time_is_before_eq_jiffies(
decrease_time_jif + several msecs) or think-time state changes.
decrease_time_jif is initialized to 0 and will be set to current jiffies
when inject limit is updated or reset. If the jiffies is slightly greater
than LONG_MAX, time_is_after_eq_jiffies(0) will keep for a long time, so as
time_is_after_eq_jiffies(decrease_time_jif + several msecs). If the
think-time state never chages, then the injection will not work as expected
for long time.

To be more specific:
Function bfq_update_inject_limit maybe triggered when jiffies pasts
decrease_time_jif + msecs_to_jiffies(10) in bfq_add_request by setting
bfqd->wait_dispatch to true.
Function bfq_reset_inject_limit are called in two conditions:
1. jiffies pasts bfqq->decrease_time_jif + msecs_to_jiffies(1000) in
function bfq_add_request.
2. jiffies pasts bfqq->decrease_time_jif + msecs_to_jiffies(100) or
bfq think-time state change from short to long.

Fix this by initializing bfqq->decrease_time_jif to current jiffies
to trigger service injection soon when service injection conditions
are met.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5a6d9e8c329d..9441fc98961a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5491,6 +5491,8 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	/* first request is almost certainly seeky */
 	bfqq->seek_history = 1;
+
+	bfqq->decrease_time_jif = jiffies;
 }
 
 static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
-- 
2.30.0

