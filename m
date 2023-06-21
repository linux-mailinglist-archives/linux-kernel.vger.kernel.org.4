Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EB4737B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjFUGbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFUGbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:31:07 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A631AC;
        Tue, 20 Jun 2023 23:31:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QmDCp0gxKz4f4qKt;
        Wed, 21 Jun 2023 14:31:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZQkmZJkXPK9MA--.34642S4;
        Wed, 21 Jun 2023 14:31:02 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, yukuai3@huawei.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH] md: fix 'delete_mutex' deadlock
Date:   Wed, 21 Jun 2023 22:29:33 +0800
Message-Id: <20230621142933.1395629-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZQkmZJkXPK9MA--.34642S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWfKw45GrW8ZF4fWFykZrb_yoWrGr48pr
        WftasxGr4DArZxXF4UX397ua45Xw1kKayDtry7u3WfZ3W5ursFgryfX348ur95Ga93Ar4q
        q3W0gr4avFyUGFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0p
        RQo7tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Commit 3ce94ce5d05a ("md: fix duplicate filename for rdev") introduce a
new lock 'delete_mutex', and trigger a new deadlock:

t1: remove rdev			t2: sysfs writer

rdev_attr_store			rdev_attr_store
 mddev_lock
 state_store
 md_kick_rdev_from_array
  lock delete_mutex
  list_add mddev->deleting
  unlock delete_mutex
 mddev_unlock
				 mddev_lock
				 ...
  lock delete_mutex
  kobject_del
  // wait for sysfs writers to be done
				 mddev_unlock
				 lock delete_mutex
				 // wait for delete_mutex, deadlock

'delete_mutex' is used to protect the list 'mddev->deleting', turns out
that this list can be protected by 'reconfig_mutex' directly, and this
lock can be removed.

Fix this problem by removing the lock, and use 'reconfig_mutex' to
protect the list. mddev_unlock() will move this list to a local list to
be handled after 'reconfig_mutex' is dropped.

Fixes: 3ce94ce5d05a ("md: fix duplicate filename for rdev")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 28 +++++++++-------------------
 drivers/md/md.h |  4 +---
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1086d7282ee7..089f7d7a9052 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -643,7 +643,6 @@ void mddev_init(struct mddev *mddev)
 {
 	mutex_init(&mddev->open_mutex);
 	mutex_init(&mddev->reconfig_mutex);
-	mutex_init(&mddev->delete_mutex);
 	mutex_init(&mddev->sync_mutex);
 	mutex_init(&mddev->bitmap_info.mutex);
 	INIT_LIST_HEAD(&mddev->disks);
@@ -751,26 +750,15 @@ static void mddev_free(struct mddev *mddev)
 
 static const struct attribute_group md_redundancy_group;
 
-static void md_free_rdev(struct mddev *mddev)
+void mddev_unlock(struct mddev *mddev)
 {
 	struct md_rdev *rdev;
 	struct md_rdev *tmp;
+	LIST_HEAD(delete);
 
-	mutex_lock(&mddev->delete_mutex);
-	if (list_empty(&mddev->deleting))
-		goto out;
+	if (!list_empty(&mddev->deleting))
+		list_splice_init(&mddev->deleting, &delete);
 
-	list_for_each_entry_safe(rdev, tmp, &mddev->deleting, same_set) {
-		list_del_init(&rdev->same_set);
-		kobject_del(&rdev->kobj);
-		export_rdev(rdev, mddev);
-	}
-out:
-	mutex_unlock(&mddev->delete_mutex);
-}
-
-void mddev_unlock(struct mddev *mddev)
-{
 	if (mddev->to_remove) {
 		/* These cannot be removed under reconfig_mutex as
 		 * an access to the files will try to take reconfig_mutex
@@ -810,7 +798,11 @@ void mddev_unlock(struct mddev *mddev)
 	} else
 		mutex_unlock(&mddev->reconfig_mutex);
 
-	md_free_rdev(mddev);
+	list_for_each_entry_safe(rdev, tmp, &delete, same_set) {
+		list_del_init(&rdev->same_set);
+		kobject_del(&rdev->kobj);
+		export_rdev(rdev, mddev);
+	}
 
 	md_wakeup_thread(mddev->thread);
 	wake_up(&mddev->sb_wait);
@@ -2490,9 +2482,7 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
 	 * reconfig_mutex is held, hence it can't be called under
 	 * reconfig_mutex and it's delayed to mddev_unlock().
 	 */
-	mutex_lock(&mddev->delete_mutex);
 	list_add(&rdev->same_set, &mddev->deleting);
-	mutex_unlock(&mddev->delete_mutex);
 }
 
 static void export_array(struct mddev *mddev)
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 892a598a5029..8ae957480976 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -531,11 +531,9 @@ struct mddev {
 
 	/*
 	 * Temporarily store rdev that will be finally removed when
-	 * reconfig_mutex is unlocked.
+	 * reconfig_mutex is unlocked, protected by reconfig_mutex.
 	 */
 	struct list_head		deleting;
-	/* Protect the deleting list */
-	struct mutex			delete_mutex;
 
 	/* Used to synchronize idle and frozen for action_store() */
 	struct mutex			sync_mutex;
-- 
2.39.2

