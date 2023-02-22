Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC77369ED9E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjBVDql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBVDqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:46:37 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B8A1167D;
        Tue, 21 Feb 2023 19:46:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PM2Bs63VDz4f3l88;
        Wed, 22 Feb 2023 11:46:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgA35CEVkPVjUibtDg--.64292S6;
        Wed, 22 Feb 2023 11:46:31 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, ncroxon@redhat.com, vmayatskikh@digitalocean.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        guoqing.jiang@linux.dev, logang@deltatee.com, axboe@kernel.dk,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com
Subject: [PATCH 2/2] md/raid10: fix null-ptr-deref in  raid10_sync_request
Date:   Wed, 22 Feb 2023 12:10:00 +0800
Message-Id: <20230222041000.3341651-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230222041000.3341651-1-linan666@huaweicloud.com>
References: <20230222041000.3341651-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA35CEVkPVjUibtDg--.64292S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyfGr4rKF15JF4ktFyDGFg_yoW8ZFWfpa
        nrXwnxtrW8W39Yya1kJw17WFyF934xJ3y5tr4fu3s3CFn5WFW7ArW5Kay2qFyUXryrtFWU
        X3yUJrW5CFn8AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU1H7K7UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

init_resync() init mempool and set conf->have_replacemnt at the begaining
of sync, close_sync() free the mempool when sync is completed.

After commit 7e83ccbecd60 ("md/raid10: Allow skipping recovery when clean
arrays are assembled"), recovery might skipped and init_resync() is called
but close_sync() is not. null-ptr-deref occurs as below:
  1) creat a array, wait for resync to complete, mddev->recovery_cp is set
     to MaxSector.
  2) recovery is woken and it is skipped. conf->have_replacement is set to
     0 in init_resync(). close_sync() not called.
  3) some io errors and rdev A is set to WantReplacement.
  4) a new device is added and set to A's replacement.
  5) recovery is woken, A have replacement, but conf->have_replacemnt is
     0. r10bio->dev[i].repl_bio will not be alloced and null-ptr-deref
     occurs.

Fix it by not init_resync() if recovery skipped.

Fixes: 7e83ccbecd60 md/raid10: Allow skipping recovery when clean arrays are assembled")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index db9ee3b637d6..9e0e7bf524aa 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3297,10 +3297,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 	sector_t chunk_mask = conf->geo.chunk_mask;
 	int page_idx = 0;
 
-	if (!mempool_initialized(&conf->r10buf_pool))
-		if (init_resync(conf))
-			return 0;
-
 	/*
 	 * Allow skipping a full rebuild for incremental assembly
 	 * of a clean array, like RAID1 does.
@@ -3316,6 +3312,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		return mddev->dev_sectors - sector_nr;
 	}
 
+	if (!mempool_initialized(&conf->r10buf_pool))
+		if (init_resync(conf))
+			return 0;
+
  skipped:
 	max_sector = mddev->dev_sectors;
 	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||
-- 
2.31.1

