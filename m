Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56978737CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFUICv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjFUICt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:02:49 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000EBFE;
        Wed, 21 Jun 2023 01:02:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QmGFY2Gmtz4f4vLv;
        Wed, 21 Jun 2023 16:02:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgA30JOerpJk+MDCMA--.36412S4;
        Wed, 21 Jun 2023 16:02:40 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, yukuai3@huawei.com, axboe@kernel.dk
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH] scsi/sg: don't grab scsi host module reference
Date:   Thu, 22 Jun 2023 00:01:11 +0800
Message-Id: <20230621160111.1433521-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA30JOerpJk+MDCMA--.36412S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uryxZFyUtF47uF13Gr4fGrg_yoW8ZrWfpF
        WUWa90krW09rWUG3WUZw1UZFyxK3yIv3yfJFWxKw15uFW8Jryj9ryktFy8XF15ArZagFWD
        CFnxtFWvgF1UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9q14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
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
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

In order to prevent request_queue to be freed before cleaning up
blktrace debugfs entries, commit db59133e9279 ("scsi: sg: fix blktrace
debugfs entries leakage") use scsi_device_get(), however,
scsi_device_get() will also grab scsi module reference and scsi module
can't be removed.

It's reported that blktests can't unload scsi_debug after block/001:

blktests (master) # ./check block
block/001 (stress device hotplugging) [failed]
     +++ /root/blktests/results/nodev/block/001.out.bad 2023-06-19
      Running block/001
      Stressing sd
     +modprobe: FATAL: Module scsi_debug is in use.

Fix this problem by grabbing request_queue reference directly, so that
scsi host module can still be unloaded while request_queue will be
pinged by sg device.

Reported-by: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Link: https://lore.kernel.org/all/1760da91-876d-fc9c-ab51-999a6f66ad50@nvidia.com/
Fixes: db59133e9279 ("scsi: sg: fix blktrace debugfs entries leakage")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/scsi/sg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 2433eeef042a..dcb73787c29d 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1497,7 +1497,7 @@ sg_add_device(struct device *cl_dev)
 	int error;
 	unsigned long iflags;
 
-	error = scsi_device_get(scsidp);
+	error = blk_get_queue(scsidp->request_queue);
 	if (error)
 		return error;
 
@@ -1558,7 +1558,7 @@ sg_add_device(struct device *cl_dev)
 out:
 	if (cdev)
 		cdev_del(cdev);
-	scsi_device_put(scsidp);
+	blk_put_queue(scsidp->request_queue);
 	return error;
 }
 
@@ -1575,7 +1575,7 @@ sg_device_destroy(struct kref *kref)
 	 */
 
 	blk_trace_remove(q);
-	scsi_device_put(sdp->device);
+	blk_put_queue(q);
 
 	write_lock_irqsave(&sg_index_lock, flags);
 	idr_remove(&sg_index_idr, sdp->index);
-- 
2.39.2

