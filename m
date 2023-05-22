Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592C170B67D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjEVH11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjEVH1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:27:18 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A60CA;
        Mon, 22 May 2023 00:27:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QPptL3Mf1z4f3jHg;
        Mon, 22 May 2023 15:27:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgBH7epJGWtkztVuJw--.34097S7;
        Mon, 22 May 2023 15:27:08 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, neilb@suse.de, Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH v4 3/3] md/raid10: optimize check_decay_read_errors()
Date:   Mon, 22 May 2023 15:25:35 +0800
Message-Id: <20230522072535.1523740-4-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230522072535.1523740-1-linan666@huaweicloud.com>
References: <20230522072535.1523740-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH7epJGWtkztVuJw--.34097S7
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWxAF4UZFWfKrWDKry3Jwb_yoWrXryDpa
        15Aas8Jr4UJryUAw1DJryqya4FyryfCayjyrWxJa1Iqwn5Jrn8ta45GFy2g348GF9xJw15
        XrZ8Gr4DCr4DKFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU1BOJ7UUUUU==
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
 drivers/md/raid10.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 4fcfcb350d2b..d31eed17f186 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2655,23 +2655,24 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
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
+		goto increase;
 	}
 
 	hours_since_last = (long)(cur_time_mon -
@@ -2684,10 +2685,25 @@ static void check_decay_read_errors(struct mddev *mddev, struct md_rdev *rdev)
 	 * just set read errors to 0. We do this to avoid
 	 * overflowing the shift of read_errors by hours_since_last.
 	 */
+	read_errors = atomic_read(&rdev->read_errors);
 	if (hours_since_last >= 8 * sizeof(read_errors))
 		atomic_set(&rdev->read_errors, 0);
 	else
 		atomic_set(&rdev->read_errors, read_errors >> hours_since_last);
+
+increase:
+	read_errors = atomic_inc_return(&rdev->read_errors);
+	if (read_errors > max_read_errors) {
+		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %d:max %d]\n",
+			  mdname(mddev), rdev->bdev,
+			  read_errors, max_read_errors);
+		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
+			  mdname(mddev), rdev->bdev);
+		md_error(mddev, rdev);
+		return false;
+	}
+
+	return true;
 }
 
 static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
@@ -2727,7 +2743,6 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 	int sect = 0; /* Offset from r10_bio->sector */
 	int sectors = r10_bio->sectors;
 	struct md_rdev *rdev;
-	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
 	int d = r10_bio->devs[r10_bio->read_slot].devnum;
 
 	/* still own a reference to this rdev, so it cannot
@@ -2740,15 +2755,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 		   more fix_read_error() attempts */
 		return;
 
-	check_decay_read_errors(mddev, rdev);
-	atomic_inc(&rdev->read_errors);
-	if (atomic_read(&rdev->read_errors) > max_read_errors) {
-		pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %d:max %d]\n",
-			  mdname(mddev), rdev->bdev,
-			  atomic_read(&rdev->read_errors), max_read_errors);
-		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
-			  mdname(mddev), rdev->bdev);
-		md_error(mddev, rdev);
+	if (!check_decay_read_errors(mddev, rdev)) {
 		r10_bio->devs[r10_bio->read_slot].bio = IO_BLOCKED;
 		return;
 	}
-- 
2.31.1

