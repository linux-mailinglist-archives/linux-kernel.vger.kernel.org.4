Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF66C4374
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCVGol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCVGoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:44:07 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BC81BADE;
        Tue, 21 Mar 2023 23:43:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PhJmp5pkrz4f4397;
        Wed, 22 Mar 2023 14:42:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiBHoxpkI55qFQ--.38915S10;
        Wed, 22 Mar 2023 14:42:20 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     guoqing.jiang@linux.dev, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 6/6] md: enhance checking in md_check_recovery()
Date:   Wed, 22 Mar 2023 14:41:22 +0800
Message-Id: <20230322064122.2384589-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
References: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiBHoxpkI55qFQ--.38915S10
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4UXF48Gw1xuFWfJF1kZrb_yoW8Cr4fpF
        WfWas8GrW8ZFW3ZrZrta4kXay5Aw40q3yjyryfWa4rJF1rta1I9345uF17AFWDJasaq3WY
        y3W5JFZ3Zry8Cw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
        X7UUUUU==
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

For md_check_recovery():

1) if 'MD_RECOVERY_RUNING' is not set, register new sync_thread.
2) if 'MD_RECOVERY_RUNING' is set:
 a) if 'MD_RECOVERY_DONE' is not set, don't do anything, wait for
   md_do_sync() to be done.
 b) if 'MD_RECOVERY_DONE' is set, unregister sync_thread. Current code
   expects that sync_thread is not NULL, otherwise new sync_thread will
   be registered, which will corrupt raid.

This patch add a WARN_ON_ONCE() in the above corruption, and make sure
md_check_recovery() won't register new sync_thread if 'MD_RECOVERY_RUNING'
is still set.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index cabdfd4ec001..048ec21932e9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9377,16 +9377,24 @@ void md_check_recovery(struct mddev *mddev)
 		if (mddev->sb_flags)
 			md_update_sb(mddev, 0);
 
-		if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
-		    !test_bit(MD_RECOVERY_DONE, &mddev->recovery)) {
-			/* resync/recovery still happening */
-			clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-			goto unlock;
-		}
-		if (mddev->sync_thread) {
+		/*
+		 * Never start a new sync thread if MD_RECOVERY_RUNNING is
+		 * still set.
+		 */
+		if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+			if (!test_bit(MD_RECOVERY_DONE, &mddev->recovery)) {
+				/* resync/recovery still happening */
+				clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+				goto unlock;
+			}
+
+			if (WARN_ON_ONCE(!mddev->sync_thread))
+				goto unlock;
+
 			md_reap_sync_thread(mddev);
 			goto unlock;
 		}
+
 		/* Set RUNNING before clearing NEEDED to avoid
 		 * any transients in the value of "sync_action".
 		 */
-- 
2.31.1

