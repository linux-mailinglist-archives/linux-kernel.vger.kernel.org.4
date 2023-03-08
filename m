Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB56AFCB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCHCJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCHCJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:09:05 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02C49CFD1;
        Tue,  7 Mar 2023 18:09:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PWbMt5fNPz4f3nTX;
        Wed,  8 Mar 2023 10:08:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDHcyE47gdkBs8gEg--.52407S4;
        Wed, 08 Mar 2023 10:08:58 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, shinichiro.kawasaki@wdc.com,
        paolo.valente@linaro.org, axboe@kernel.dk, glusvardi@posteo.net,
        damien.lemoal@opensource.wdc.com, felicigb@gmail.com,
        inbox@emilianomaccaferri.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH] block, bfq: fix uaf for 'stable_merge_bfqq'
Date:   Wed,  8 Mar 2023 10:32:08 +0800
Message-Id: <20230308023208.379465-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <4e6e1606-1d9e-9903-8a44-ccac58a1fe06@kernel.dk>
References: <4e6e1606-1d9e-9903-8a44-ccac58a1fe06@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHcyE47gdkBs8gEg--.52407S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45XryUWF4kKry7Jr48Crg_yoW5JrWkpa
        1DKw4avr1rJrW5XrWxAw40vF98tr43Ar9FyryrW347uw1DJrySvFsF9ayI9Fn2vr48CFnx
        Xw1qqas2kr48JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Before commit fd571df0ac5b ("block, bfq: turn bfqq_data into an array
in bfq_io_cq"), process reference is read before bfq_put_stable_ref(),
and it's safe if bfq_put_stable_ref() put the last reference, because
process reference will be 0 and 'stable_merge_bfqq' won't be accessed
in this case. However, the commit changed the order and  will cause
uaf for 'stable_merge_bfqq'.

In order to emphasize that bfq_put_stable_ref() can drop the last
reference, fix the problem by moving bfq_put_stable_ref() to the end of
bfq_setup_stable_merge().

Fixes: fd571df0ac5b ("block, bfq: turn bfqq_data into an array in bfq_io_cq")
Reported-and-tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/linux-block/20230307071448.rzihxbm4jhbf5krj@shindev/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 8a8d4441519c..d9ed3108c17a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2854,11 +2854,11 @@ bfq_setup_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	int proc_ref = min(bfqq_process_refs(bfqq),
 			   bfqq_process_refs(stable_merge_bfqq));
-	struct bfq_queue *new_bfqq;
+	struct bfq_queue *new_bfqq = NULL;
 
-	if (idling_boosts_thr_without_issues(bfqd, bfqq) ||
-	    proc_ref == 0)
-		return NULL;
+	bfqq_data->stable_merge_bfqq = NULL;
+	if (idling_boosts_thr_without_issues(bfqd, bfqq) || proc_ref == 0)
+		goto out;
 
 	/* next function will take at least one ref */
 	new_bfqq = bfq_setup_merge(bfqq, stable_merge_bfqq);
@@ -2873,6 +2873,11 @@ bfq_setup_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			new_bfqq_data->stably_merged = true;
 		}
 	}
+
+out:
+	/* deschedule stable merge, because done or aborted here */
+	bfq_put_stable_ref(stable_merge_bfqq);
+
 	return new_bfqq;
 }
 
@@ -2933,11 +2938,6 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			struct bfq_queue *stable_merge_bfqq =
 				bfqq_data->stable_merge_bfqq;
 
-			/* deschedule stable merge, because done or aborted here */
-			bfq_put_stable_ref(stable_merge_bfqq);
-
-			bfqq_data->stable_merge_bfqq = NULL;
-
 			return bfq_setup_stable_merge(bfqd, bfqq,
 						      stable_merge_bfqq,
 						      bfqq_data);
-- 
2.31.1

