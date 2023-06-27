Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3380573F09A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjF0Bo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjF0Bo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:44:26 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D071700;
        Mon, 26 Jun 2023 18:44:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqnZD3tllz4f3jqt;
        Tue, 27 Jun 2023 09:44:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCHK5_zPppkR9B7Mg--.52784S4;
        Tue, 27 Jun 2023 09:44:21 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH v2] md/raid1: prioritize adding disk to 'removed' mirror
Date:   Tue, 27 Jun 2023 09:43:32 +0800
Message-Id: <20230627014332.3810102-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHK5_zPppkR9B7Mg--.52784S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7ArWDGF1ftFy7KF1fXrb_yoW8Cr17pa
        nIqasxWF48Ar17KrsrJayUC3Wftw4kJFWkGFyfWw1j9FZIqrWrX3y8tFy5Gr1DAFWUAw13
        J3WYkrZ8t3WUCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40E
        w7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwc_TUU
        UUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

New disk should be added to "removed" position first instead of to be a
replacement. Commit 6090368abcb4 ("md/raid10: prioritize adding disk to
'removed' mirror") has fixed this issue for raid10. Fix it for raid1 now.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2:
 - improve commit log.

 drivers/md/raid1.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 68a9e2d9985b..320bede4bfab 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1782,7 +1782,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 {
 	struct r1conf *conf = mddev->private;
 	int err = -EEXIST;
-	int mirror = 0;
+	int mirror = 0, repl_slot = -1;
 	struct raid1_info *p;
 	int first = 0;
 	int last = conf->raid_disks - 1;
@@ -1825,17 +1825,21 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			break;
 		}
 		if (test_bit(WantReplacement, &p->rdev->flags) &&
-		    p[conf->raid_disks].rdev == NULL) {
-			/* Add this device as a replacement */
-			clear_bit(In_sync, &rdev->flags);
-			set_bit(Replacement, &rdev->flags);
-			rdev->raid_disk = mirror;
-			err = 0;
-			conf->fullsync = 1;
-			rcu_assign_pointer(p[conf->raid_disks].rdev, rdev);
-			break;
-		}
+		    p[conf->raid_disks].rdev == NULL && repl_slot < 0)
+			repl_slot = mirror;
 	}
+
+	if (err && repl_slot >= 0) {
+		/* Add this device as a replacement */
+		p = conf->mirrors + repl_slot;
+		clear_bit(In_sync, &rdev->flags);
+		set_bit(Replacement, &rdev->flags);
+		rdev->raid_disk = repl_slot;
+		err = 0;
+		conf->fullsync = 1;
+		rcu_assign_pointer(p[conf->raid_disks].rdev, rdev);
+	}
+
 	print_conf(conf);
 	return err;
 }
-- 
2.39.2

