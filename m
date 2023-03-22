Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525056C43C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCVHB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCVHB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:01:57 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE005B5F5;
        Wed, 22 Mar 2023 00:01:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PhJmm5HfJz4f3lKb;
        Wed, 22 Mar 2023 14:42:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiBHoxpkI55qFQ--.38915S6;
        Wed, 22 Mar 2023 14:42:18 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     guoqing.jiang@linux.dev, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 2/6] md: refactor action_store() for 'idle' and 'frozen'
Date:   Wed, 22 Mar 2023 14:41:18 +0800
Message-Id: <20230322064122.2384589-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
References: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiBHoxpkI55qFQ--.38915S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45Ww4rtw1rCF1Duw1kuFg_yoW5Xr1kp3
        yftas8ArW8JFy3Z343K3WDZay5Zwn2qrWDtrW3W3s5JF1fJF47Gw1Y9a4xAFykJasaqr45
        Xa98JFWfuryrGr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHbyAUUUUU
        =
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

Prepare to handle 'idle' and 'frozen' differently to fix a deadlock, there
are no functional changes except that MD_RECOVERY_RUNNING is checked
again after 'reconfig_mutex' is held.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 61 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index acf57a5156c7..076936fee65a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4753,6 +4753,46 @@ action_show(struct mddev *mddev, char *page)
 	return sprintf(page, "%s\n", type);
 }
 
+static void stop_sync_thread(struct mddev *mddev)
+{
+	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+		return;
+
+	if (mddev_lock(mddev))
+		return;
+
+	/*
+	 * Check again in case MD_RECOVERY_RUNNING is cleared before lock is
+	 * held.
+	 */
+	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+		mddev_unlock(mddev);
+		return;
+	}
+
+	if (work_pending(&mddev->del_work))
+		flush_workqueue(md_misc_wq);
+
+	if (mddev->sync_thread) {
+		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+		md_reap_sync_thread(mddev);
+	}
+
+	mddev_unlock(mddev);
+}
+
+static void idle_sync_thread(struct mddev *mddev)
+{
+	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev);
+}
+
+static void frozen_sync_thread(struct mddev *mddev)
+{
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev);
+}
+
 static ssize_t
 action_store(struct mddev *mddev, const char *page, size_t len)
 {
@@ -4760,22 +4800,11 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 		return -EINVAL;
 
 
-	if (cmd_match(page, "idle") || cmd_match(page, "frozen")) {
-		if (cmd_match(page, "frozen"))
-			set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-		else
-			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-		if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
-		    mddev_lock(mddev) == 0) {
-			if (work_pending(&mddev->del_work))
-				flush_workqueue(md_misc_wq);
-			if (mddev->sync_thread) {
-				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-				md_reap_sync_thread(mddev);
-			}
-			mddev_unlock(mddev);
-		}
-	} else if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+	if (cmd_match(page, "idle"))
+		idle_sync_thread(mddev);
+	else if (cmd_match(page, "frozen"))
+		frozen_sync_thread(mddev);
+	else if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		return -EBUSY;
 	else if (cmd_match(page, "resync"))
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-- 
2.31.1

