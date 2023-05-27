Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F260C71331F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjE0Hl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjE0Hll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:41:41 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949F1B1;
        Sat, 27 May 2023 00:41:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QStZP27SJz4f3w0P;
        Sat, 27 May 2023 15:23:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLAKsHFk67lAKQ--.30654S7;
        Sat, 27 May 2023 15:23:58 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, bingjingc@synology.com, allenpeng@synology.com,
        shli@fb.com, alexwu@synology.com, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH v3 3/4] md/raid10: fix incorrect done of recovery
Date:   Sat, 27 May 2023 15:22:17 +0800
Message-Id: <20230527072218.2365857-4-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230527072218.2365857-1-linan666@huaweicloud.com>
References: <20230527072218.2365857-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLAKsHFk67lAKQ--.30654S7
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyktF13tF17GFWDXr17GFg_yoW8ur4fpa
        n3JFZ3tr98WayfJ3WDAryUXFWFy348J347Kr4xW34j9F9YqrWDZFWfXFWUXFyDWr1FqayY
        qw4DJrW5CFyxKaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
        Ja73UjIFyTuYvjxUwfHjUUUUU
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

Recovery will go to giveup and let chunks_skipped++ in
raid10_sync_request() if there are some bad_blocks, and it will return
max_sector when chunks_skipped >= geo.raid_disks. Now, recovery fail and
data is inconsistent but user think recovery is done, it is wrong.

Fix it by set mirror's recovery_disabled, spare device will not  be added
to here. The same issue alos exists on resync, it will be fixd in future.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index d93d8cb2b620..3ba1516ea160 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3303,6 +3303,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 	int chunks_skipped = 0;
 	sector_t chunk_mask = conf->geo.chunk_mask;
 	int page_idx = 0;
+	int error_disk = -1;
 
 	/*
 	 * Allow skipping a full rebuild for incremental assembly
@@ -3386,7 +3387,20 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		return reshape_request(mddev, sector_nr, skipped);
 
 	if (chunks_skipped >= conf->geo.raid_disks) {
-		/* if there has been nothing to do on any drive,
+		pr_err("md/raid10:%s: %s fail\n", mdname(mddev),
+			test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?  "resync" : "recovery");
+		if (error_disk >= 0 &&
+		    !test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
+			/*
+			 * recovery fail, set mirrors.recovory_disabled,
+			 * device shouldn't be added to there.
+			 */
+			conf->mirrors[error_disk].recovery_disabled =
+						mddev->recovery_disabled;
+			return 0;
+		}
+		/*
+		 * if there has been nothing to do on any drive,
 		 * then there is nothing to do at all..
 		 */
 		*skipped = 1;
@@ -3638,6 +3652,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 						       mdname(mddev));
 					mirror->recovery_disabled
 						= mddev->recovery_disabled;
+				} else {
+					error_disk = i;
 				}
 				put_buf(r10_bio);
 				if (rb2)
-- 
2.31.1

