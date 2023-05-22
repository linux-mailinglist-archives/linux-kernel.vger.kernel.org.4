Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1474970BC7D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjEVL4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjEVL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:56:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684EC93;
        Mon, 22 May 2023 04:56:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QPws05YqSz4f426c;
        Mon, 22 May 2023 19:56:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLNiWGtk2XrkJw--.28031S6;
        Mon, 22 May 2023 19:56:21 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, shli@fb.com, allenpeng@synology.com,
        alexwu@synology.com, bingjingc@synology.com, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 2/3] md/raid10: fix incorrect done of recovery
Date:   Mon, 22 May 2023 19:54:48 +0800
Message-Id: <20230522115449.2203939-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230522115449.2203939-1-linan666@huaweicloud.com>
References: <20230522115449.2203939-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLNiWGtk2XrkJw--.28031S6
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyktF13tF1rZF43Zw48Xrb_yoW8ZFy7pa
        n3JFZ3t398W3yfJ3WDAryUXFWFy348Ja42krsrW34j9r90qrWDZFWfXFW8XF9rWF1FqayY
        qw4DJrW5uFyxKaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2
        ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
        vjDU0xZFpf9x07UNAwxUUUUU=
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

Recovery will go to giveup and let chunks_skipped++ in
raid10_sync_request() if there are some bad_blocks, and it will return
max_sector when chunks_skipped >= geo.raid_disks. Now, recovery fail and
data is inconsistent but user think recovery is done, it is wrong.

Fix it by set mirror's recovery_disabled and spare device shouln't be
added to here.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index e21502c03b45..70cc87c7ee57 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3303,6 +3303,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 	int chunks_skipped = 0;
 	sector_t chunk_mask = conf->geo.chunk_mask;
 	int page_idx = 0;
+	int error_disk = -1;
 
 	/*
 	 * Allow skipping a full rebuild for incremental assembly
@@ -3386,7 +3387,18 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		return reshape_request(mddev, sector_nr, skipped);
 
 	if (chunks_skipped >= conf->geo.raid_disks) {
-		/* if there has been nothing to do on any drive,
+		pr_err("md/raid10:%s: %s fail\n", mdname(mddev),
+			test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?  "resync" : "recovery");
+		if (error_disk >= 0 && !test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
+			/*
+			 * recovery fail, set mirrors.recovory_disabled,
+			 * device shouldn't be added to there.
+			 */
+			conf->mirrors[error_disk].recovery_disabled = mddev->recovery_disabled;
+			return 0;
+		}
+		/*
+		 * if there has been nothing to do on any drive,
 		 * then there is nothing to do at all..
 		 */
 		*skipped = 1;
@@ -3640,6 +3652,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
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

