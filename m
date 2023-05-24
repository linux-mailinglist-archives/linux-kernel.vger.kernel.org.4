Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE81170EAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 03:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbjEXBoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 21:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239003AbjEXBom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 21:44:42 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3A3186;
        Tue, 23 May 2023 18:44:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QQvBD3S8Mz4f3kjD;
        Wed, 24 May 2023 09:44:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLAEbG1kePtSKA--.3965S4;
        Wed, 24 May 2023 09:44:38 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, song@kernel.org, axboe@kernel.dk,
        chaitanya.kulkarni@wdc.com, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH] md/raid5: fix miscalculation of 'end_sector' in raid5_read_one_chunk()
Date:   Wed, 24 May 2023 09:41:18 +0800
Message-Id: <20230524014118.3172781-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLAEbG1kePtSKA--.3965S4
X-Coremail-Antispam: 1UD129KBjvdXoWruFWxGw47Cr48Jw1fCFy5XFb_yoWDWwc_K3
        WxZF1Yqr1rGrn2g3429a1furWkZw18uF4UuF4YgFWFvF4rX3ZYkr1Dur9Yvr47CFZrXF15
        tr13Jw13tw1kJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

'end_sector' is compared to 'rdev->recovery_offset', which is offset to
rdev, however, commit e82ed3a4fbb5 ("md/raid6: refactor
raid5_read_one_chunk") changes the calculation of 'end_sector' to offset
to the array. Fix this miscalculation.

Fixes: e82ed3a4fbb5 ("md/raid6: refactor raid5_read_one_chunk")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7e2bbcfef325..8686d629e3f2 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5516,7 +5516,7 @@ static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
 
 	sector = raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector, 0,
 				      &dd_idx, NULL);
-	end_sector = bio_end_sector(raid_bio);
+	end_sector = sector + bio_sectors(raid_bio);
 
 	rcu_read_lock();
 	if (r5c_big_stripe_cached(conf, sector))
-- 
2.39.2

