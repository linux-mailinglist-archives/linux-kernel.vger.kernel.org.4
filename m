Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190A671339F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjE0JVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjE0JVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:21:48 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D766FE3;
        Sat, 27 May 2023 02:21:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QSxBH3WZsz4f3nTh;
        Sat, 27 May 2023 17:21:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rGny3Fk4ZBGKQ--.53868S4;
        Sat, 27 May 2023 17:21:44 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH] md/raid10: prioritize adding disk to 'removed' mirror
Date:   Sat, 27 May 2023 17:20:07 +0800
Message-Id: <20230527092007.3008856-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rGny3Fk4ZBGKQ--.53868S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCF47Jw18KF4UArWrJFWxXrb_yoW5CF18pa
        nxJ3ZxGrW8JwsIkF4DJayDWFWSqrWkKaykKry3W34F9F43trWUGa48CrW5Zr98AFZ8Zw43
        t3W5JrZ8KF1xuFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40E
        w7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r4j6F4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUouc_DU
        UUU
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

When add a new disk to raid10, it will traverse conf->mirror from start
and find one of the following mirror to add:
  1. mirror->rdev is set to WantReplacement and it have no replacement,
     set new disk to mirror->replacement.
  2. no mirror->rdev, set new disk to mirror->rdev.

There is a array as below (sda is set to WantReplacement):

    Number   Major   Minor   RaidDevice State
       0       8        0        0      active sync set-A   /dev/sda
       -       0        0        1      removed
       2       8       32        2      active sync set-A   /dev/sdc
       3       8       48        3      active sync set-B   /dev/sdd

Use 'mdadm --add' to add a new disk to this array, the new disk will
become sda's replacement instead of add to removed position, which is
confusing for users. Meanwhile, after new disk recovery success, sda
will be set to Faulty.

Prioritize adding disk to 'removed' mirror is a better choice. In the
above scenario, the behavior is the same as before, except sda will not
be deleted. Before other disks are added, continued use sda is more
reliable.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 4fcfcb350d2b..d90eb830ca1a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2148,9 +2148,10 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 {
 	struct r10conf *conf = mddev->private;
 	int err = -EEXIST;
-	int mirror;
+	int mirror, repl_slot = -1;
 	int first = 0;
 	int last = conf->geo.raid_disks - 1;
+	struct raid10_info *p;
 
 	if (mddev->recovery_cp < MaxSector)
 		/* only hot-add to in-sync arrays, as recovery is
@@ -2173,23 +2174,14 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 	else
 		mirror = first;
 	for ( ; mirror <= last ; mirror++) {
-		struct raid10_info *p = &conf->mirrors[mirror];
+		p = &conf->mirrors[mirror];
 		if (p->recovery_disabled == mddev->recovery_disabled)
 			continue;
 		if (p->rdev) {
-			if (!test_bit(WantReplacement, &p->rdev->flags) ||
-			    p->replacement != NULL)
-				continue;
-			clear_bit(In_sync, &rdev->flags);
-			set_bit(Replacement, &rdev->flags);
-			rdev->raid_disk = mirror;
-			err = 0;
-			if (mddev->gendisk)
-				disk_stack_limits(mddev->gendisk, rdev->bdev,
-						  rdev->data_offset << 9);
-			conf->fullsync = 1;
-			rcu_assign_pointer(p->replacement, rdev);
-			break;
+			if (test_bit(WantReplacement, &p->rdev->flags) &&
+			    p->replacement == NULL && repl_slot < 0)
+				repl_slot = mirror;
+			continue;
 		}
 
 		if (mddev->gendisk)
@@ -2206,6 +2198,19 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		break;
 	}
 
+	if (err && repl_slot >= 0) {
+		p = &conf->mirrors[repl_slot];
+		clear_bit(In_sync, &rdev->flags);
+		set_bit(Replacement, &rdev->flags);
+		rdev->raid_disk = repl_slot;
+		err = 0;
+		if (mddev->gendisk)
+			disk_stack_limits(mddev->gendisk, rdev->bdev,
+					  rdev->data_offset << 9);
+		conf->fullsync = 1;
+		rcu_assign_pointer(p->replacement, rdev);
+	}
+
 	print_conf(conf);
 	return err;
 }
-- 
2.31.1

