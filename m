Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE770737E60
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjFUIxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjFUIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:52:45 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E1495;
        Wed, 21 Jun 2023 01:52:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QmHMD0Y37z4f4c9g;
        Wed, 21 Jun 2023 16:52:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLBWupJkbVnFMA--.53622S5;
        Wed, 21 Jun 2023 16:52:40 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com, pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 1/8] md: move initialization and destruction of 'io_acct_set' to md.c
Date:   Thu, 22 Jun 2023 00:51:03 +0800
Message-Id: <20230621165110.1498313-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
References: <20230621165110.1498313-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLBWupJkbVnFMA--.53622S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWDAFW7Jry5Xw4DtFy5Jwb_yoW3Cw18pa
        1Sg3ZYgr4FqrWSga1DA3yv9a4Fqrn7Kr97trW7J348Aw4Ivr4DG3W5uFyFvryDJ3yrCr13
        Zw4rKFWUuF17KFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRCeHDUUUU
        U
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

'io_acct_set' is only used for raid0 and raid456, prepare to use it for
raid1 and raid10, so that io accounting from different levels can be
consistent.

By the way, follow up patches will also use this io clone mechanism to
make sure 'active_io' represents in flight io, not io that is dispatching,
so that mddev_suspend will wait for io to be done as designed.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
---
 drivers/md/md.c    | 27 ++++++++++-----------------
 drivers/md/md.h    |  2 --
 drivers/md/raid0.c | 16 ++--------------
 drivers/md/raid5.c | 41 +++++++++++------------------------------
 4 files changed, 23 insertions(+), 63 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0c2421486d36..e56e1dd80999 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5886,6 +5886,13 @@ int md_run(struct mddev *mddev)
 			goto exit_bio_set;
 	}
 
+	if (!bioset_initialized(&mddev->io_acct_set)) {
+		err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
+				  offsetof(struct md_io_acct, bio_clone), 0);
+		if (err)
+			goto exit_sync_set;
+	}
+
 	spin_lock(&pers_lock);
 	pers = find_pers(mddev->level, mddev->clevel);
 	if (!pers || !try_module_get(pers->owner)) {
@@ -6063,6 +6070,8 @@ int md_run(struct mddev *mddev)
 	module_put(pers->owner);
 	md_bitmap_destroy(mddev);
 abort:
+	bioset_exit(&mddev->io_acct_set);
+exit_sync_set:
 	bioset_exit(&mddev->sync_set);
 exit_bio_set:
 	bioset_exit(&mddev->bio_set);
@@ -6286,6 +6295,7 @@ static void __md_stop(struct mddev *mddev)
 	percpu_ref_exit(&mddev->active_io);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
+	bioset_exit(&mddev->io_acct_set);
 }
 
 void md_stop(struct mddev *mddev)
@@ -8642,23 +8652,6 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 }
 EXPORT_SYMBOL_GPL(md_submit_discard_bio);
 
-int acct_bioset_init(struct mddev *mddev)
-{
-	int err = 0;
-
-	if (!bioset_initialized(&mddev->io_acct_set))
-		err = bioset_init(&mddev->io_acct_set, BIO_POOL_SIZE,
-			offsetof(struct md_io_acct, bio_clone), 0);
-	return err;
-}
-EXPORT_SYMBOL_GPL(acct_bioset_init);
-
-void acct_bioset_exit(struct mddev *mddev)
-{
-	bioset_exit(&mddev->io_acct_set);
-}
-EXPORT_SYMBOL_GPL(acct_bioset_exit);
-
 static void md_end_io_acct(struct bio *bio)
 {
 	struct md_io_acct *md_io_acct = bio->bi_private;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 7cab9c7c45b8..11299d94b239 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -776,8 +776,6 @@ extern void md_error(struct mddev *mddev, struct md_rdev *rdev);
 extern void md_finish_reshape(struct mddev *mddev);
 void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 			struct bio *bio, sector_t start, sector_t size);
-int acct_bioset_init(struct mddev *mddev);
-void acct_bioset_exit(struct mddev *mddev);
 void md_account_bio(struct mddev *mddev, struct bio **bio);
 
 extern bool __must_check md_flush_request(struct mddev *mddev, struct bio *bio);
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index f8ee9a95e25d..38d9209cada1 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -365,7 +365,6 @@ static void raid0_free(struct mddev *mddev, void *priv)
 	struct r0conf *conf = priv;
 
 	free_conf(mddev, conf);
-	acct_bioset_exit(mddev);
 }
 
 static int raid0_run(struct mddev *mddev)
@@ -380,16 +379,11 @@ static int raid0_run(struct mddev *mddev)
 	if (md_check_no_bitmap(mddev))
 		return -EINVAL;
 
-	if (acct_bioset_init(mddev)) {
-		pr_err("md/raid0:%s: alloc acct bioset failed.\n", mdname(mddev));
-		return -ENOMEM;
-	}
-
 	/* if private is not null, we are here after takeover */
 	if (mddev->private == NULL) {
 		ret = create_strip_zones(mddev, &conf);
 		if (ret < 0)
-			goto exit_acct_set;
+			return ret;
 		mddev->private = conf;
 	}
 	conf = mddev->private;
@@ -420,15 +414,9 @@ static int raid0_run(struct mddev *mddev)
 
 	ret = md_integrity_register(mddev);
 	if (ret)
-		goto free;
+		free_conf(mddev, conf);
 
 	return ret;
-
-free:
-	free_conf(mddev, conf);
-exit_acct_set:
-	acct_bioset_exit(mddev);
-	return ret;
 }
 
 static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f8bc74e16811..29cf5455d7a5 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7787,19 +7787,12 @@ static int raid5_run(struct mddev *mddev)
 	struct md_rdev *rdev;
 	struct md_rdev *journal_dev = NULL;
 	sector_t reshape_offset = 0;
-	int i, ret = 0;
+	int i;
 	long long min_offset_diff = 0;
 	int first = 1;
 
-	if (acct_bioset_init(mddev)) {
-		pr_err("md/raid456:%s: alloc acct bioset failed.\n", mdname(mddev));
+	if (mddev_init_writes_pending(mddev) < 0)
 		return -ENOMEM;
-	}
-
-	if (mddev_init_writes_pending(mddev) < 0) {
-		ret = -ENOMEM;
-		goto exit_acct_set;
-	}
 
 	if (mddev->recovery_cp != MaxSector)
 		pr_notice("md/raid:%s: not clean -- starting background reconstruction\n",
@@ -7830,8 +7823,7 @@ static int raid5_run(struct mddev *mddev)
 	    (mddev->bitmap_info.offset || mddev->bitmap_info.file)) {
 		pr_notice("md/raid:%s: array cannot have both journal and bitmap\n",
 			  mdname(mddev));
-		ret = -EINVAL;
-		goto exit_acct_set;
+		return -EINVAL;
 	}
 
 	if (mddev->reshape_position != MaxSector) {
@@ -7856,15 +7848,13 @@ static int raid5_run(struct mddev *mddev)
 		if (journal_dev) {
 			pr_warn("md/raid:%s: don't support reshape with journal - aborting.\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 
 		if (mddev->new_level != mddev->level) {
 			pr_warn("md/raid:%s: unsupported reshape required - aborting.\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 		old_disks = mddev->raid_disks - mddev->delta_disks;
 		/* reshape_position must be on a new-stripe boundary, and one
@@ -7880,8 +7870,7 @@ static int raid5_run(struct mddev *mddev)
 		if (sector_div(here_new, chunk_sectors * new_data_disks)) {
 			pr_warn("md/raid:%s: reshape_position not on a stripe boundary\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 		reshape_offset = here_new * chunk_sectors;
 		/* here_new is the stripe we will write to */
@@ -7903,8 +7892,7 @@ static int raid5_run(struct mddev *mddev)
 			else if (mddev->ro == 0) {
 				pr_warn("md/raid:%s: in-place reshape must be started in read-only mode - aborting\n",
 					mdname(mddev));
-				ret = -EINVAL;
-				goto exit_acct_set;
+				return -EINVAL;
 			}
 		} else if (mddev->reshape_backwards
 		    ? (here_new * chunk_sectors + min_offset_diff <=
@@ -7914,8 +7902,7 @@ static int raid5_run(struct mddev *mddev)
 			/* Reading from the same stripe as writing to - bad */
 			pr_warn("md/raid:%s: reshape_position too early for auto-recovery - aborting.\n",
 				mdname(mddev));
-			ret = -EINVAL;
-			goto exit_acct_set;
+			return -EINVAL;
 		}
 		pr_debug("md/raid:%s: reshape will continue\n", mdname(mddev));
 		/* OK, we should be able to continue; */
@@ -7939,10 +7926,8 @@ static int raid5_run(struct mddev *mddev)
 	else
 		conf = mddev->private;
 
-	if (IS_ERR(conf)) {
-		ret = PTR_ERR(conf);
-		goto exit_acct_set;
-	}
+	if (IS_ERR(conf))
+		return PTR_ERR(conf);
 
 	if (test_bit(MD_HAS_JOURNAL, &mddev->flags)) {
 		if (!journal_dev) {
@@ -8140,10 +8125,7 @@ static int raid5_run(struct mddev *mddev)
 	free_conf(conf);
 	mddev->private = NULL;
 	pr_warn("md/raid:%s: failed to run raid set.\n", mdname(mddev));
-	ret = -EIO;
-exit_acct_set:
-	acct_bioset_exit(mddev);
-	return ret;
+	return -EIO;
 }
 
 static void raid5_free(struct mddev *mddev, void *priv)
@@ -8151,7 +8133,6 @@ static void raid5_free(struct mddev *mddev, void *priv)
 	struct r5conf *conf = priv;
 
 	free_conf(conf);
-	acct_bioset_exit(mddev);
 	mddev->to_remove = &raid5_attrs_group;
 }
 
-- 
2.39.2

