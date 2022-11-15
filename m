Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F73F629B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiKONuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiKONth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:49:37 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4218525E82;
        Tue, 15 Nov 2022 05:49:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NBSGJ15WDz4f3k6c;
        Tue, 15 Nov 2022 21:49:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBni9jnmHNjrPFIAg--.61645S9;
        Tue, 15 Nov 2022 21:49:31 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH RFC v3 05/10] dm: make sure create and remove dm device won't race with open and close table
Date:   Tue, 15 Nov 2022 22:10:49 +0800
Message-Id: <20221115141054.1051801-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBni9jnmHNjrPFIAg--.61645S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw43tFWkKF1ftF4rCr18AFb_yoW8Wr4UpF
        1YgrWavry5WrsrZw1UZr1Uuw15twsY93y8Jr9xGa4a9a4UZFy7ZFWIyF93X3WkJa97KF98
        WFW7trs5Gw48Kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
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

open_table_device() and close_table_device() is protected by
table_devices_lock, hence use it to protect add_disk() and
del_gendisk().

Prepare to track per-add_disk holder relations in dm.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2917700b1e15..3728b56b364b 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1952,7 +1952,14 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		spin_unlock(&_minor_lock);
 		if (dm_get_md_type(md) != DM_TYPE_NONE) {
 			dm_sysfs_exit(md);
+
+			/*
+			 * Hold lock to make sure del_gendisk() won't concurrent
+			 * with open/close_table_device().
+			 */
+			mutex_lock(&md->table_devices_lock);
 			del_gendisk(md->disk);
+			mutex_unlock(&md->table_devices_lock);
 		}
 		dm_queue_destroy_crypto_profile(md->queue);
 		put_disk(md->disk);
@@ -2312,15 +2319,24 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 	if (r)
 		return r;
 
+	/*
+	 * Hold lock to make sure add_disk() and del_gendisk() won't concurrent
+	 * with open_table_device() and close_table_device().
+	 */
+	mutex_lock(&md->table_devices_lock);
 	r = add_disk(md->disk);
+	mutex_unlock(&md->table_devices_lock);
 	if (r)
 		return r;
 
 	r = dm_sysfs_init(md);
 	if (r) {
+		mutex_lock(&md->table_devices_lock);
 		del_gendisk(md->disk);
+		mutex_unlock(&md->table_devices_lock);
 		return r;
 	}
+
 	md->type = type;
 	return 0;
 }
-- 
2.31.1

