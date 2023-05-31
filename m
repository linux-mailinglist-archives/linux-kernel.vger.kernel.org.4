Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7A717BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjEaJab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjEaJaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:30:10 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49404129;
        Wed, 31 May 2023 02:30:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QWPB05BT1z4f3lx0;
        Wed, 31 May 2023 17:30:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rGZE3dkpNpxKg--.21739S4;
        Wed, 31 May 2023 17:30:02 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH v4 2/2] md/raid10: fix incorrect done of recovery
Date:   Wed, 31 May 2023 17:28:20 +0800
Message-Id: <20230531092820.694836-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rGZE3dkpNpxKg--.21739S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw17JF4kCrykXr1fXF45Awb_yoW8try8pa
        n7JF93t3s8X3yfJ3WDAryUXFWFy348Ja43KrWxW34jgayaqr9rZFWxXFW0qFyUWF1FqFWY
        qw4DJrW5CF97KaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487
        Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aV
        AFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40E
        w7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1I6r4UMIIF0xvEx4A2jsIE14v26r4j6F4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFvtCDU
        UUU
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

In raid10_sync_request(), if data cannot be read from any disk for
recovery, it will go to 'giveup' and let 'chunks_skipped' + 1. After
multiple 'giveup', when 'chunks_skipped >= geo.raid_disks', it will
return 'max_sector', indicating that the recovery has been completed.
However, the recovery is just aborted and the data remains inconsistent.

Fix it by setting mirror->recovery_disabled, which will prevent the spare
disk from being added to this mirror. The same issue also exists during
resync, it will be fixed afterwards.

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

