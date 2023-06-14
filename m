Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A37C72F14D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbjFNBEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241706AbjFNBEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:04:33 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8E81BEC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 18:04:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgnJB09Bjz4f3nTj
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:04:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbAYEolki8WaLg--.13805S4;
        Wed, 14 Jun 2023 09:04:26 +0800 (CST)
From:   linan666@huaweicloud.com
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2] dm: Support turning off io stat accounting
Date:   Wed, 14 Jun 2023 08:59:55 +0800
Message-Id: <20230614005955.939034-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbAYEolki8WaLg--.13805S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyDAw1ftF15WF1UKF4rZrb_yoW5GrWkpF
        WDW34SyrWrWr4jga1Uu3yxu3WFka93Kry7ArW3A3yF9a1jyr90yr1UtFyYqrykJFZ7AFyI
        qF10kFZruayYkrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
        AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAK
        j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UKoGdUUU
        UU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

Commit bc59ba9468d9 ("block: add sysfs file for controlling io stats
accounting") allowed user to turn off disk stat accounting completely by
queue flag QUEUE_FLAG_IO_STAT. In dm, this flag is not set for BIO_BASED
device, io stats is continuously counted and cannot be turn off.

Support turning off io stat accounting for dm. Set QUEUE_FLAG_IO_STAT for
dm request_queue. When the io starts, we account the io using DM_IO_STAT
dm_io flag to avoid io stats disable in the middle of the io. DM statistics
is independent of block io stat and remains unchanged.

Signed-off-by: Li Nan <linan122@huawei.com>
---
v2:
 - set QUEUE_FLAG_IO_STAT in dm_setup_md_queue()
 - get request_queue by md->queue
---
 drivers/md/dm-core.h |  3 ++-
 drivers/md/dm.c      | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index aecab0c0720f..8b0af3e1331a 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -307,7 +307,8 @@ struct dm_io {
  */
 enum {
 	DM_IO_ACCOUNTED,
-	DM_IO_WAS_SPLIT
+	DM_IO_WAS_SPLIT,
+	DM_IO_STAT
 };
 
 static inline bool dm_io_flagged(struct dm_io *io, unsigned int bit)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3b694ba3a106..fee27ae4129e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -511,11 +511,14 @@ static void dm_io_acct(struct dm_io *io, bool end)
 	else
 		sectors = io->sectors;
 
-	if (!end)
-		bdev_start_io_acct(bio->bi_bdev, bio_op(bio), start_time);
-	else
-		bdev_end_io_acct(bio->bi_bdev, bio_op(bio), sectors,
-				 start_time);
+	if (dm_io_flagged(io, DM_IO_STAT)) {
+		if (!end)
+			bdev_start_io_acct(bio->bi_bdev, bio_op(bio),
+					   start_time);
+		else
+			bdev_end_io_acct(bio->bi_bdev, bio_op(bio),
+					 sectors, start_time);
+	}
 
 	if (static_branch_unlikely(&stats_enabled) &&
 	    unlikely(dm_stats_used(&md->stats))) {
@@ -592,6 +595,8 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	spin_lock_init(&io->lock);
 	io->start_time = jiffies;
 	io->flags = 0;
+	if (blk_queue_io_stat(md->queue))
+		dm_io_set_flag(io, DM_IO_STAT);
 
 	if (static_branch_unlikely(&stats_enabled))
 		dm_stats_record_start(&md->stats, &io->stats_aux);
@@ -2341,6 +2346,7 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 		break;
 	case DM_TYPE_BIO_BASED:
 	case DM_TYPE_DAX_BIO_BASED:
+		blk_queue_flag_set(QUEUE_FLAG_IO_STAT, md->queue);
 		break;
 	case DM_TYPE_NONE:
 		WARN_ON_ONCE(true);
-- 
2.39.2

