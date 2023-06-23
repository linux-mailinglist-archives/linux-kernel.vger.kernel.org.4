Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6421273B3AB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjFWJeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjFWJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:34:18 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECBC1FE9;
        Fri, 23 Jun 2023 02:34:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QnXBC2ryHz4f3sCS;
        Fri, 23 Jun 2023 17:34:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCXaK8TZ5VkaZ1hMQ--.14505S5;
        Fri, 23 Jun 2023 17:34:12 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 1/3] md/raid10: optimize fix_read_error
Date:   Sat, 24 Jun 2023 01:32:34 +0800
Message-Id: <20230623173236.2513554-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623173236.2513554-1-linan666@huaweicloud.com>
References: <20230623173236.2513554-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXaK8TZ5VkaZ1hMQ--.14505S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWryxtFWfCrykZFWfJrWxCrg_yoW5WFW7pF
        Zrua4FyrW5JF1UZr1UtrWDCanYy34fuFWUGrs5tw1xWw1Skr9xKF18WryavryUJF93uw17
        Zas09rsrCFs7tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUHvb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
        4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVJ
        KsUUUUU
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

We dereference r10_bio->read_slot too many times in fix_read_error().
Optimize it by using a variable to store read_slot.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 381c21f7fb06..94ae294c8a3c 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2725,10 +2725,10 @@ static int r10_sync_page_io(struct md_rdev *rdev, sector_t sector,
 static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10bio *r10_bio)
 {
 	int sect = 0; /* Offset from r10_bio->sector */
-	int sectors = r10_bio->sectors;
+	int sectors = r10_bio->sectors, slot = r10_bio->read_slot;
 	struct md_rdev *rdev;
 	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
-	int d = r10_bio->devs[r10_bio->read_slot].devnum;
+	int d = r10_bio->devs[slot].devnum;
 
 	/* still own a reference to this rdev, so it cannot
 	 * have been cleared recently.
@@ -2749,13 +2749,13 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 		pr_notice("md/raid10:%s: %pg: Failing raid device\n",
 			  mdname(mddev), rdev->bdev);
 		md_error(mddev, rdev);
-		r10_bio->devs[r10_bio->read_slot].bio = IO_BLOCKED;
+		r10_bio->devs[slot].bio = IO_BLOCKED;
 		return;
 	}
 
 	while(sectors) {
 		int s = sectors;
-		int sl = r10_bio->read_slot;
+		int sl = slot;
 		int success = 0;
 		int start;
 
@@ -2790,7 +2790,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			sl++;
 			if (sl == conf->copies)
 				sl = 0;
-		} while (!success && sl != r10_bio->read_slot);
+		} while (!success && sl != slot);
 		rcu_read_unlock();
 
 		if (!success) {
@@ -2798,16 +2798,16 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			 * as bad on the first device to discourage future
 			 * reads.
 			 */
-			int dn = r10_bio->devs[r10_bio->read_slot].devnum;
+			int dn = r10_bio->devs[slot].devnum;
 			rdev = conf->mirrors[dn].rdev;
 
 			if (!rdev_set_badblocks(
 				    rdev,
-				    r10_bio->devs[r10_bio->read_slot].addr
+				    r10_bio->devs[slot].addr
 				    + sect,
 				    s, 0)) {
 				md_error(mddev, rdev);
-				r10_bio->devs[r10_bio->read_slot].bio
+				r10_bio->devs[slot].bio
 					= IO_BLOCKED;
 			}
 			break;
@@ -2816,7 +2816,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 		start = sl;
 		/* write it back and re-read */
 		rcu_read_lock();
-		while (sl != r10_bio->read_slot) {
+		while (sl != slot) {
 			if (sl==0)
 				sl = conf->copies;
 			sl--;
@@ -2850,7 +2850,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			rcu_read_lock();
 		}
 		sl = start;
-		while (sl != r10_bio->read_slot) {
+		while (sl != slot) {
 			if (sl==0)
 				sl = conf->copies;
 			sl--;
-- 
2.39.2

