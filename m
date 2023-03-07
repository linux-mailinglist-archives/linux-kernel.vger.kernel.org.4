Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992246ADC0A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCGKdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCGKdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:33:03 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF872737;
        Tue,  7 Mar 2023 02:32:47 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PWBbY1QDGz4f3l22;
        Tue,  7 Mar 2023 18:32:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyHHEgdkLkH6EQ--.28053S4;
        Tue, 07 Mar 2023 18:32:41 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, jack@suse.cz, julianr@linux.ibm.com, axboe@kernel.dk,
        yukuai3@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH] block: fix wrong mode for blkdev_put() from disk_scan_partitions()
Date:   Tue,  7 Mar 2023 18:55:52 +0800
Message-Id: <20230307105552.1560439-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <a3a4351375d51aa5e93e06bba212ba3637665885.camel@linux.ibm.com>
References: <a3a4351375d51aa5e93e06bba212ba3637665885.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyHHEgdkLkH6EQ--.28053S4
X-Coremail-Antispam: 1UD129KBjvJXoWrKry8Xw1ftF18Kr1rKw45Wrg_yoW8Jr47pr
        9rKa1YyFy0gryIk3WUX3WxJayUWanrGryfGFWIgr1SyFnrXw4vkF92kr4UWry0yFZag3y5
        XFnF9FyFqa4rurDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

If disk_scan_partitions() is called with 'FMODE_EXCL',
blkdev_get_by_dev() will be called without 'FMODE_EXCL', however, follow
blkdev_put() is still called with 'FMODE_EXCL', which will cause
'bd_holders' counter to leak.

Fix the problem by using the right mode for blkdev_put().

Reported-by: syzbot+2bcc0d79e548c4f62a59@syzkaller.appspotmail.com
Link: https://lore.kernel.org/lkml/f9649d501bc8c3444769418f6c26263555d9d3be.camel@linux.ibm.com/T/
Tested-by: Julian Ruess <julianr@linux.ibm.com>
Fixes: e5cfefa97bcc ("block: fix scan partition for exclusively open device again")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 3ee5577e1586..02d9cfb9e077 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -385,7 +385,7 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 	if (IS_ERR(bdev))
 		ret =  PTR_ERR(bdev);
 	else
-		blkdev_put(bdev, mode);
+		blkdev_put(bdev, mode & ~FMODE_EXCL);
 
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(disk->part0, disk_scan_partitions);
-- 
2.31.1

