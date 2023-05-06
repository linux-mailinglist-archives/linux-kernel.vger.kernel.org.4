Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3ED6F8D7F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjEFBYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjEFBY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:24:29 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907D96EAF;
        Fri,  5 May 2023 18:24:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QCqbD2gl1z4f3npy;
        Sat,  6 May 2023 09:24:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7NHrFVkfh1lIw--.56086S8;
        Sat, 06 May 2023 09:24:26 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, neilb@suse.de, Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH v2 4/4] md/raid10: optimize check_decay_read_errors()
Date:   Sat,  6 May 2023 09:23:15 +0800
Message-Id: <20230506012315.3370489-5-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230506012315.3370489-1-linan666@huaweicloud.com>
References: <20230506012315.3370489-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7NHrFVkfh1lIw--.56086S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWxAF4UZFWfKrWkJrW8JFb_yoWrZF4fpa
        n8Aas8Jr1UJryUAw1DJFyDt3WFyryfAayjyrWxJa1xXwn5Jrn8ta4UGry29348Gas8Aw15
        XFZ8Grs8CF4DKFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
        A2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1nmitUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

check_decay_read_errors() is used to handle rdev->read_errors. But
read_errors is inc and read after check_decay_read_errors() is invoked
in fix_read_error().

Put all operations of read_errors into check_decay_read_errors() and
clean up unnecessary atomic_read of read_errors.

Suggested-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 66 ++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 4d615fcc6a50..79f94882227d 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2655,39 +2655,53 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 }
 
 /*
- * Used by fix_read_error() to decay the per rdev read_errors.
+ * Used by fix_read_error() to decay the per rdev read_errors and check if
+ * read_error > max_read_errors.
  * We halve the read error count for every hour that has elapsed
  * since the last recorded read error.
  *
  */
-static void check_decay_read_errors(struct mddev *mddev, struct md_rdev *rdev)
+static bool check_decay_read_errors(struct mddev *mddev, struct md_rdev *rdev)
 {
-	long cur_time_mon;
+	time64_t cur_time_mon = ktime_get_seconds();
 	unsigned long hours_since_last;
-	unsigned int read_errors = atomic_read(&rdev->read_errors);
-
-	cur_time_mon = ktime_get_seconds();
+	unsigned int read_errors;
+	unsigned int max_read_errors =
+			atomic_read(&mddev->max_corr_read_errors);
 
 	if (rdev->last_read_error == 0) {
 		/* first time we've seen a read error */
 		rdev->last_read_error = cur_time_mon;
-		return;
-	}
+	} else {
+		hours_since_last = (long)(cur_time_mon -
+				    rdev->last_read_error) / 3600;
 
-	hours_since_last = (long)(cur_time_mon -
-			    rdev->last_read_error) / 3600;
+		rdev->last_read_error = cur_time_mon;
 
-	rdev->last_read_error = cur_time_mon;
+		/*
+		 * if hours_since_last is > the number of bits in read_errors
+		 * just set read errors to 0. We do this to avoid
+		 * overflowing the shift of read_errors by hours_since_last.
+		 */
+		read_errors = atomic_read(&rdev->read_errors);
+		if (hours_since_last >= 8 * sizeof(read_errors))
+			atomic_set(&rdev->read_errors, 0);
+		else
+			atomic_set(&rdev->read_errors,
+				   read_errors >> hours_since_last);
+	}
 
-	/*
-	 * if hours_since_last is > the number of bits in read_errors
-	 * just set read errors to 0. We do this to avoid
-	 * overflowing the shift of read_errors by hours_since_last.
-	 */
-	if (hours_since_last >= 8 * sizeof(read_errors))
-		atomic_set(&rdev->read_errors, 0);
-	else
-		atomic_set(&rdev->read_errors, read_errors >> hours_since_last);
+	read_errors = atomic_inc_return(&rdev->read_errors);
+	if (read_errors > max_read_errors) {
+		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %u:max %u]\n",
+			  mdname(mddev), rdev->bdev, read_errors, max_read_errors);
+		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
+			  mdname(mddev), rdev->bdev);
+		md_error(mddev, rdev);
+		return false;
+	}
+
+	return true;
 }
 
 static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
@@ -2727,8 +2741,6 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 	int sect = 0; /* Offset from r10_bio->sector */
 	int sectors = r10_bio->sectors;
 	struct md_rdev *rdev;
-	unsigned int max_read_errors =
-			atomic_read(&mddev->max_corr_read_errors);
 	int d = r10_bio->devs[r10_bio->read_slot].devnum;
 
 	/* still own a reference to this rdev, so it cannot
@@ -2741,15 +2753,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 		   more fix_read_error() attempts */
 		return;
 
-	check_decay_read_errors(mddev, rdev);
-	atomic_inc(&rdev->read_errors);
-	if (atomic_read(&rdev->read_errors) > max_read_errors) {
-		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %u:max %u]\n",
-			  mdname(mddev), rdev->bdev,
-			  atomic_read(&rdev->read_errors), max_read_errors);
-		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
-			  mdname(mddev), rdev->bdev);
-		md_error(mddev, rdev);
+	if (check_decay_read_errors(mddev, rdev)) {
 		r10_bio->devs[r10_bio->read_slot].bio = IO_BLOCKED;
 		return;
 	}
-- 
2.31.1

