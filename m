Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12A169DBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjBUIFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjBUIFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:05:39 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183FB1E1D0;
        Tue, 21 Feb 2023 00:05:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PLX0F05xDz4f3vf1;
        Tue, 21 Feb 2023 16:05:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR9Ne_RjCzK9Dg--.13531S4;
        Tue, 21 Feb 2023 16:05:34 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, axboe@kernel.dk, paolo.valente@linaro.org,
        damien.lemoal@opensource.wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH] block, bfq: free 'sync_bfqq' after bic_set_bfqq() in bfq_sync_bfqq_move()
Date:   Tue, 21 Feb 2023 16:29:05 +0800
Message-Id: <20230221082905.3389012-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <e2071a24-cd25-e5bd-9166-a3b575b7bf4a@huaweicloud.com>
References: <e2071a24-cd25-e5bd-9166-a3b575b7bf4a@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR9Ne_RjCzK9Dg--.13531S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1xtw1xJFyUJF1DCr1kAFb_yoWDGFX_t3
        WkGrn7tr48Cas0kF1jyFn0yFW5K3y8Xws8XFnYgF9xZa45JFn8C3s3trn7Can5ZFW7K343
        Xw1fWry7AFsYyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
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

As explained in commit b600de2d7d3a ("block, bfq: fix uaf for bfqq in
bic_set_bfqq()"), bfqq should not be freed before bic_set_bfqq().
However, this is broken while merging commit 9778369a2d6c ("block, bfq:
split sync bfq_queues on a per-actuator basis") from branch
for-6.3/block.

Fixes: 9778369a2d6c ("block, bfq: split sync bfq_queues on a per-actuator basis")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index ea3638e06e04..89ffb3aa992c 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -746,8 +746,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
 		 * old cgroup.
 		 */
 		bfq_put_cooperator(sync_bfqq);
-		bfq_release_process_ref(bfqd, sync_bfqq);
 		bic_set_bfqq(bic, NULL, true, act_idx);
+		bfq_release_process_ref(bfqd, sync_bfqq);
 	}
 }
 
-- 
2.31.1

