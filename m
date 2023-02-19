Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F7069BE32
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 03:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBSCle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 21:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBSCl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 21:41:28 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A5B1204D;
        Sat, 18 Feb 2023 18:41:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PK8v54774z4f3npn;
        Sun, 19 Feb 2023 10:41:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgBH7utQjPFjPmleDw--.7604S7;
        Sun, 19 Feb 2023 10:41:23 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 05/17] block, bfq: Update bfqd->max_budget with bfqd->lock held
Date:   Sun, 19 Feb 2023 18:42:57 +0800
Message-Id: <20230219104309.1511562-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
References: <20230219104309.1511562-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7utQjPFjPmleDw--.7604S7
X-Coremail-Antispam: 1UD129KBjvJXoW7WF17Gr47JFy8XF1rurW5Awb_yoW8AF18pa
        sFq34Sqr1UJ39aqrsrGa18X3WagwsxWrZrKw4Fqw17JF92yF1Iy3Wjq3WagF4rJF4fAwsr
        Z3Wvga9Yqa42yrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bfq_max_budget and bfq_user_max_budget maybe be in inconsisten state if
bfq_max_budget configuration and bfq_max_budget auto-update happen
concurrently.
Example sequence:
config                          auto-update
bfqd->bfq_max_budget =
  __data
                                if (bfqd->bfq_user_max_budget == 0)
                                  bfqd->bfq_max_budget =
                                    bfq_calc_max_budget(bfqd);
bfqd->bfq_user_max_budget =
  __data;

Users may set bfq_max_budget successfully while read a different value
from they set.
bfq_max_budget is only update in update_thr_responsiveness_params and
configuration code. As update_thr_responsiveness_params is always called
under bfqd->lock, fix this by holding lock in configuration code.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/bfq-iosched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index edbf5c9aeb47..5b08711cbaf6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7489,6 +7489,7 @@ static ssize_t bfq_max_budget_store(struct elevator_queue *e,
 	if (ret)
 		return ret;
 
+	spin_lock_irq(&bfqd->lock);
 	if (__data == 0)
 		bfqd->bfq_max_budget = bfq_calc_max_budget(bfqd);
 	else {
@@ -7498,6 +7499,7 @@ static ssize_t bfq_max_budget_store(struct elevator_queue *e,
 	}
 
 	bfqd->bfq_user_max_budget = __data;
+	spin_unlock_irq(&bfqd->lock);
 
 	return count;
 }
@@ -7523,8 +7525,11 @@ static ssize_t bfq_timeout_sync_store(struct elevator_queue *e,
 		__data = INT_MAX;
 
 	bfqd->bfq_timeout = msecs_to_jiffies(__data);
+
+	spin_lock_irq(&bfqd->lock);
 	if (bfqd->bfq_user_max_budget == 0)
 		bfqd->bfq_max_budget = bfq_calc_max_budget(bfqd);
+	spin_unlock_irq(&bfqd->lock);
 
 	return count;
 }
-- 
2.30.0

