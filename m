Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C4B60836E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 03:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJVByX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 21:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJVByV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 21:54:21 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911692CDEB;
        Fri, 21 Oct 2022 18:54:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MvPTM4YpNzKFt3;
        Sat, 22 Oct 2022 09:51:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBHWTBGTVNjcFznAA--.52S4;
        Sat, 22 Oct 2022 09:54:16 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v2] block: fix memory leak for elevator on add_disk failure
Date:   Sat, 22 Oct 2022 10:16:15 +0800
Message-Id: <20221022021615.2756171-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHWTBGTVNjcFznAA--.52S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4kXFyUuFWxWw1ftFyDGFg_yoW8CF4fpr
        s8Z3s0grWDWr4UWF1jqa17JFy5Cw1kGr93WFW3Gr1a9wnakFsFva4UKa15Way5ArZ3Xan7
        XFWxGFy0gF18Aw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

The default elevator is allocated in the beginning of device_add_disk(),
however, it's not freed in the following error path.

Fixes: 50e34d78815e ("block: disable the elevator int del_gendisk")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes in v2:
 - fix wrong fix tag
 - add review tag

 block/genhd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index b3d04e79e854..fea319c8f99e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -437,9 +437,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	 * Otherwise just allocate the device numbers for both the whole device
 	 * and all partitions from the extended dev_t space.
 	 */
+	ret = -EINVAL;
 	if (disk->major) {
 		if (WARN_ON(!disk->minors))
-			return -EINVAL;
+			goto out_exit_elevator;
 
 		if (disk->minors > DISK_MAX_PARTS) {
 			pr_err("block: can't allocate more than %d partitions\n",
@@ -447,14 +448,14 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 			disk->minors = DISK_MAX_PARTS;
 		}
 		if (disk->first_minor + disk->minors > MINORMASK + 1)
-			return -EINVAL;
+			goto out_exit_elevator;
 	} else {
 		if (WARN_ON(disk->minors))
-			return -EINVAL;
+			goto out_exit_elevator;
 
 		ret = blk_alloc_ext_minor();
 		if (ret < 0)
-			return ret;
+			goto out_exit_elevator;
 		disk->major = BLOCK_EXT_MAJOR;
 		disk->first_minor = ret;
 	}
@@ -571,6 +572,9 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 out_free_ext_minor:
 	if (disk->major == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(disk->first_minor);
+out_exit_elevator:
+	if (disk->queue->elevator)
+		elevator_exit(disk->queue);
 	return ret;
 }
 EXPORT_SYMBOL(device_add_disk);
-- 
2.31.1

