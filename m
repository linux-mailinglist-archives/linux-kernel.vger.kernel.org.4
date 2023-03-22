Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CE96C43C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCVHB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCVHB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:01:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB9953DAC;
        Wed, 22 Mar 2023 00:01:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PhJmp3PvFz4f41GR;
        Wed, 22 Mar 2023 14:42:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiBHoxpkI55qFQ--.38915S9;
        Wed, 22 Mar 2023 14:42:19 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     guoqing.jiang@linux.dev, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 5/6] md: wake up 'resync_wait' at last in md_reap_sync_thread()
Date:   Wed, 22 Mar 2023 14:41:21 +0800
Message-Id: <20230322064122.2384589-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
References: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiBHoxpkI55qFQ--.38915S9
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1rur47Kr1UCw1xAw1kKrg_yoWktFc_WF
        nrZrWkWry7W39rKr1Yvw1SvrWvqws8Ww1kZFyftFyjyFW5Jw1UJryfuw13Awnxu3yUG3s0
        9rWj9FWfZrW5GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbq8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
        IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

We just replace md_reap_sync_thread() with wait_event(resync_wait, ...)
from action_store(), this patch just make sure action_store() will still
wait for everything to be done in md_reap_sync_thread().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ddf33a11d8de..cabdfd4ec001 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9511,7 +9511,6 @@ void md_reap_sync_thread(struct mddev *mddev)
 	if (mddev_is_clustered(mddev) && is_reshaped
 				      && !test_bit(MD_CLOSING, &mddev->flags))
 		md_cluster_ops->update_size(mddev, old_dev_sectors);
-	wake_up(&resync_wait);
 	/* flag recovery needed just to double check */
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	sysfs_notify_dirent_safe(mddev->sysfs_completed);
@@ -9519,6 +9518,7 @@ void md_reap_sync_thread(struct mddev *mddev)
 	md_new_event();
 	if (mddev->event_work.func)
 		queue_work(md_misc_wq, &mddev->event_work);
+	wake_up(&resync_wait);
 }
 EXPORT_SYMBOL(md_reap_sync_thread);
 
-- 
2.31.1

