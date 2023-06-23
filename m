Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6772D73B37F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjFWJ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFWJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:27:07 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A130E9D;
        Fri, 23 Jun 2023 02:27:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QnX1x03NZz4f3mWf;
        Fri, 23 Jun 2023 17:27:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZRkZZVkAjlhMQ--.8026S4;
        Fri, 23 Jun 2023 17:27:01 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH] md/raid1: prioritize adding disk to 'removed' mirror
Date:   Sat, 24 Jun 2023 01:25:25 +0800
Message-Id: <20230623172525.2513235-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZRkZZVkAjlhMQ--.8026S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7ArWDGF1ftFy7tr47Jwb_yoW8ArWkpa
        nIqasxGF48Aw12grsrJayDC3Wftw4kJFWkGFyfWw1j9FZIqrWrX3y8tFy5Gr1UJFW5Aw13
        JF1YkrZ8ta4UuFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
        tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gc
        CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x07j33ktUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

New disk should be added to "removed" position first instead of to be a
replacement. Commit 6090368abcb4 ("md/raid10: prioritize adding disk to
'removed' mirror") has fixed this issue for raid10. This patch fixes raid1.

Signed-off-by: Li Nan <linan122@huawei.com>
---
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

