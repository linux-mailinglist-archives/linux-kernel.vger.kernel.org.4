Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA44473B3AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjFWJe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjFWJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:34:18 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FFC184;
        Fri, 23 Jun 2023 02:34:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QnXBB6JpXz4f3qRk;
        Fri, 23 Jun 2023 17:34:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCXaK8TZ5VkaZ1hMQ--.14505S7;
        Fri, 23 Jun 2023 17:34:12 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 3/3] md/raid10: handle replacement devices in fix_read_error
Date:   Sat, 24 Jun 2023 01:32:36 +0800
Message-Id: <20230623173236.2513554-4-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623173236.2513554-1-linan666@huaweicloud.com>
References: <20230623173236.2513554-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXaK8TZ5VkaZ1hMQ--.14505S7
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1xZFyUJFW3JryfJF47Jwb_yoW5ur1Upr
        ZrGa4YvrZxJrWUur1jqrWDuanYkr1fGFWFyr48Jw1xWwn5try5KF1UGryY9ry5AFZxZr10
        qFn8KrsruF9rKF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUHlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
        6r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
        Ij64vIr41lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
        MxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
        jaMKZUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

In fix_read_error(), the handling of replacement devices is missing. If
read replacement device errors, we will attempt to fix 'mirror->rdev'.
It is wrong. Get rdev from r10bio to ensure that the fixed device is the
one which read error occurred.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a36e53fce21f..4a7c8eaf6ea0 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2726,15 +2726,10 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 {
 	int sect = 0; /* Offset from r10_bio->sector */
 	int sectors = r10_bio->sectors, slot = r10_bio->read_slot;
-	struct md_rdev *rdev;
+	struct md_rdev *rdev = r10_bio->devs[slot].rdev;
 	int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
 	int d = r10_bio->devs[slot].devnum;
 
-	/* still own a reference to this rdev, so it cannot
-	 * have been cleared recently.
-	 */
-	rdev = conf->mirrors[d].rdev;
-
 	if (test_bit(Faulty, &rdev->flags))
 		/* drive has already been failed, just ignore any
 		   more fix_read_error() attempts */
@@ -2763,12 +2758,11 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			s = PAGE_SIZE >> 9;
 
 		rcu_read_lock();
+		rdev = r10_bio->devs[slot].rdev;
 		do {
 			sector_t first_bad;
 			int bad_sectors;
 
-			d = r10_bio->devs[sl].devnum;
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
 			if (rdev &&
 			    test_bit(In_sync, &rdev->flags) &&
 			    !test_bit(Faulty, &rdev->flags) &&
@@ -2790,6 +2784,8 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			sl++;
 			if (sl == conf->copies)
 				sl = 0;
+			d = r10_bio->devs[sl].devnum;
+			rdev = rcu_dereference(conf->mirrors[d].rdev);
 		} while (sl != slot);
 		rcu_read_unlock();
 
@@ -2798,9 +2794,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			 * as bad on the first device to discourage future
 			 * reads.
 			 */
-			int dn = r10_bio->devs[slot].devnum;
-			rdev = conf->mirrors[dn].rdev;
-
+			rdev = r10_bio->devs[slot].rdev;
 			if (!rdev_set_badblocks(
 				    rdev,
 				    r10_bio->devs[slot].addr
@@ -2820,8 +2814,12 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			if (sl==0)
 				sl = conf->copies;
 			sl--;
-			d = r10_bio->devs[sl].devnum;
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			if (sl == slot) {
+				rdev = r10_bio->devs[slot].rdev;
+			} else {
+				d = r10_bio->devs[sl].devnum;
+				rdev = rcu_dereference(conf->mirrors[d].rdev);
+			}
 			if (!rdev ||
 			    test_bit(Faulty, &rdev->flags) ||
 			    !test_bit(In_sync, &rdev->flags))
@@ -2854,8 +2852,12 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			if (sl==0)
 				sl = conf->copies;
 			sl--;
-			d = r10_bio->devs[sl].devnum;
-			rdev = rcu_dereference(conf->mirrors[d].rdev);
+			if (sl == slot) {
+				rdev = r10_bio->devs[slot].rdev;
+			} else {
+				d = r10_bio->devs[sl].devnum;
+				rdev = rcu_dereference(conf->mirrors[d].rdev);
+			}
 			if (!rdev ||
 			    test_bit(Faulty, &rdev->flags) ||
 			    !test_bit(In_sync, &rdev->flags))
-- 
2.39.2

