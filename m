Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40DD71FAE3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjFBHVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjFBHVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:21:20 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1791B3;
        Fri,  2 Jun 2023 00:21:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QXZDV1ZKBz4f3tqJ;
        Fri,  2 Jun 2023 15:21:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP2 (Coremail) with SMTP id Syh0CgA33epimHlkYdujKg--.62283S5;
        Fri, 02 Jun 2023 15:21:15 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH v6 1/2] md/raid10: Do not add spare disk when recovery fail
Date:   Fri,  2 Jun 2023 15:17:16 +0800
Message-Id: <20230602071717.503287-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602071717.503287-1-linan666@huaweicloud.com>
References: <20230602071717.503287-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33epimHlkYdujKg--.62283S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw17JF4kCrykXr13Kw48WFg_yoW8Kr1Upa
        nrJF93t34DXw4fJ3Z8AryUXFWFy348Ja47KryxW34j93y3tryDZFWxXF4UXFWUWF1FqFWY
        qw4DJr45CFykKaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1mFAPUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/md/raid10.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index d93d8cb2b620..9fb55902e58a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3303,6 +3303,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 	int chunks_skipped = 0;
 	sector_t chunk_mask = conf->geo.chunk_mask;
 	int page_idx = 0;
+	int error_disk = -1;
 
 	/*
 	 * Allow skipping a full rebuild for incremental assembly
@@ -3386,8 +3387,21 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		return reshape_request(mddev, sector_nr, skipped);
 
 	if (chunks_skipped >= conf->geo.raid_disks) {
-		/* if there has been nothing to do on any drive,
-		 * then there is nothing to do at all..
+		pr_err("md/raid10:%s: %s fail\n", mdname(mddev),
+			test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?  "resync" : "recovery");
+		if (error_disk >= 0 &&
+		    !test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
+			/*
+			 * recovery fail, set mirrors.recovery_disabled,
+			 * device shouldn't be added to there.
+			 */
+			conf->mirrors[error_disk].recovery_disabled =
+						mddev->recovery_disabled;
+			return 0;
+		}
+		/*
+		 * if there has been nothing to do on any drive,
+		 * then there is nothing to do at all.
 		 */
 		*skipped = 1;
 		return (max_sector - sector_nr) + sectors_skipped;
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
2.39.2

