Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B24734054
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 12:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjFQKnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 06:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQKnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 06:43:03 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AC910DB;
        Sat, 17 Jun 2023 03:43:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qjt0K34yQz4f56MJ;
        Sat, 17 Jun 2023 18:42:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHuKsujo1kJ6GfLw--.51912S4;
        Sat, 17 Jun 2023 18:42:56 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, brauner@kernel.org, hare@suse.de,
        dsterba@suse.com, jinpu.wang@ionos.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] block: fix wrong mode for blkdev_get_by_dev() from disk_scan_partitions()
Date:   Sat, 17 Jun 2023 18:38:13 +0800
Message-Id: <20230617103813.3708374-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHuKsujo1kJ6GfLw--.51912S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4rWFWfKF17Jr4rGr45Wrg_yoW8Gw1kpF
        WUWF45tryqgryxuF4vy3ZrGay5Gan8GryxKrWIgw1Fv39xXrnYkF92krZ8Wr10vFWSg3y5
        WFnrZFyFqF1F9wUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
 block/genhd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 2c2f9a716822..1fb964866fd0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -365,7 +365,8 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	}
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL, NULL);
+	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL,
+				 NULL);
 	if (IS_ERR(bdev))
 		ret =  PTR_ERR(bdev);
 	else
-- 
2.39.2

