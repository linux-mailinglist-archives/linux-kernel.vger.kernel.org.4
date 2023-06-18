Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44261734507
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 08:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjFRGFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 02:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRGF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 02:05:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175F10E3;
        Sat, 17 Jun 2023 23:05:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QkMnb1BKvz4f4PNl;
        Sun, 18 Jun 2023 14:05:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCH77Kgno5k_0DdLw--.62007S4;
        Sun, 18 Jun 2023 14:05:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, brauner@kernel.org, dsterba@suse.com,
        hare@suse.de, jinpu.wang@ionos.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2] block: fix wrong mode for blkdev_get_by_dev() from disk_scan_partitions()
Date:   Sun, 18 Jun 2023 22:04:02 +0800
Message-Id: <20230618140402.7556-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77Kgno5k_0DdLw--.62007S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4rWFWfKF17Jr4rGr45Wrg_yoW8Xr4UpF
        W5WF45tryqgryxZF4vv3ZrGay5Ga98GryxKrWIgw1Fv39xXrsYkF92krs8Wr10vFZagrW5
        WFnrZFyFqFyF9wUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9q14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
        kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
        WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
        0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWr
        Jr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjTRNgAwUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

After commit 2736e8eeb0cc ("block: use the holder as indication for
exclusive opens"), blkdev_get_by_dev() will warn if holder is NULL and
mode contains 'FMODE_EXCL'.

holder from blkdev_get_by_dev() from disk_scan_partitions() is always NULL,
hence it should not use 'FMODE_EXCL', which is broben by the commit. For
consequence, WARN_ON_ONCE() will be triggered from blkdev_get_by_dev()
if user scan partitions with device opened exclusively.

Fix this problem by removing 'FMODE_EXCL' from disk_scan_partitions(),
as it used to be.

Reported-by: syzbot+00cd27751f78817f167b@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=00cd27751f78817f167b
Fixes: 2736e8eeb0cc ("block: use the holder as indication for exclusive opens")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---

Changes in v2:
 - fix a typo

 block/genhd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 2c2f9a716822..d1e845ae1b32 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -365,7 +365,8 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	}
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL, NULL);
+	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXEC, NULL,
+				 NULL);
 	if (IS_ERR(bdev))
 		ret =  PTR_ERR(bdev);
 	else
-- 
2.39.2

