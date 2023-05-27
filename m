Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB371331C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjE0Hly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjE0Hll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:41:41 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA64BC;
        Sat, 27 May 2023 00:41:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QStZN5Xq7z4f3w0L;
        Sat, 27 May 2023 15:23:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLAKsHFk67lAKQ--.30654S6;
        Sat, 27 May 2023 15:23:57 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, bingjingc@synology.com, allenpeng@synology.com,
        shli@fb.com, alexwu@synology.com, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH v3 2/4] md/raid10: improve code of mrdev in raid10_sync_request
Date:   Sat, 27 May 2023 15:22:16 +0800
Message-Id: <20230527072218.2365857-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230527072218.2365857-1-linan666@huaweicloud.com>
References: <20230527072218.2365857-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLAKsHFk67lAKQ--.30654S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWxCw45uFWxtr45KFy8Xwb_yoW5Ar17p3
        y3tFyayryUJ3yUGF1DA3WDuF1SvrWxtayYyrW7W34xGw1SgryDCa4rWFWYqF1UZFWrXw15
        Xw1UJws8Ca4IqF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
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
        C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
        vjDU0xZFpf9x07UNAwxUUUUU=
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

'need_recover' and 'mrdev' are equivalent in raid10_sync_request(), and
inc mrdev->nr_pending is unreasonable if don't need recovery. Replace
'need_recover' with 'mrdev', and only inc nr_pending when needed.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0acb4c103c10..d93d8cb2b620 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3437,7 +3437,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			sector_t sect;
 			int must_sync;
 			int any_working;
-			int need_recover = 0;
 			struct raid10_info *mirror = &conf->mirrors[i];
 			struct md_rdev *mrdev, *mreplace;
 
@@ -3445,14 +3444,13 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 			mrdev = rcu_dereference(mirror->rdev);
 			mreplace = rcu_dereference(mirror->replacement);
 
-			if (mrdev != NULL &&
-			    !test_bit(Faulty, &mrdev->flags) &&
-			    !test_bit(In_sync, &mrdev->flags))
-				need_recover = 1;
+			if (mrdev && (test_bit(Faulty, &mrdev->flags) ||
+			    test_bit(In_sync, &mrdev->flags)))
+				mrdev = NULL;
 			if (mreplace && test_bit(Faulty, &mreplace->flags))
 				mreplace = NULL;
 
-			if (!need_recover && !mreplace) {
+			if (!mrdev && !mreplace) {
 				rcu_read_unlock();
 				continue;
 			}
@@ -3486,7 +3484,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				rcu_read_unlock();
 				continue;
 			}
-			atomic_inc(&mrdev->nr_pending);
+			if (mrdev)
+				atomic_inc(&mrdev->nr_pending);
 			if (mreplace)
 				atomic_inc(&mreplace->nr_pending);
 			rcu_read_unlock();
@@ -3573,7 +3572,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				r10_bio->devs[1].devnum = i;
 				r10_bio->devs[1].addr = to_addr;
 
-				if (need_recover) {
+				if (mrdev) {
 					bio = r10_bio->devs[1].bio;
 					bio->bi_next = biolist;
 					biolist = bio;
@@ -3618,7 +3617,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 					for (k = 0; k < conf->copies; k++)
 						if (r10_bio->devs[k].devnum == i)
 							break;
-					if (!test_bit(In_sync,
+					if (mrdev && !test_bit(In_sync,
 						      &mrdev->flags)
 					    && !rdev_set_badblocks(
 						    mrdev,
@@ -3644,12 +3643,14 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 				if (rb2)
 					atomic_dec(&rb2->remaining);
 				r10_bio = rb2;
-				rdev_dec_pending(mrdev, mddev);
+				if (mrdev)
+					rdev_dec_pending(mrdev, mddev);
 				if (mreplace)
 					rdev_dec_pending(mreplace, mddev);
 				break;
 			}
-			rdev_dec_pending(mrdev, mddev);
+			if (mrdev)
+				rdev_dec_pending(mrdev, mddev);
 			if (mreplace)
 				rdev_dec_pending(mreplace, mddev);
 			if (r10_bio->devs[0].bio->bi_opf & MD_FAILFAST) {
-- 
2.31.1

