Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567856B5A14
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCKJcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCKJcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:32:33 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D39EDCA45;
        Sat, 11 Mar 2023 01:32:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PYd4C6SlSz4f3jHj;
        Sat, 11 Mar 2023 17:32:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiCqSgxkFn3mEg--.16173S7;
        Sat, 11 Mar 2023 17:32:29 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 3/5] md: use md_thread api to wake up sync_thread
Date:   Sat, 11 Mar 2023 17:31:46 +0800
Message-Id: <20230311093148.2595222-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230311093148.2595222-1-yukuai1@huaweicloud.com>
References: <20230311093148.2595222-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiCqSgxkFn3mEg--.16173S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar47Jw4rGw13JFWkXw4rAFb_yoW8WFy7pa
        yxAF95ur10yry3ZFZxJa4qva4rXF10q342vry7ua1rJw15tw45tFy3ury8AryvvayfAw45
        Zw1rtFWxuFs29r7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Instead of wake_up_process() directly, convert to use
md_wakeup_thread().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 97e87df4ee43..4ecfd0508afb 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6267,10 +6267,12 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	}
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-	if (mddev->sync_thread)
-		/* Thread might be blocked waiting for metadata update
-		 * which will now never happen */
-		wake_up_process(mddev->sync_thread->tsk);
+
+	/*
+	 * Thread might be blocked waiting for metadata update
+	 * which will now never happen
+	 */
+	md_wakeup_thread(&mddev->sync_thread, mddev);
 
 	if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
 		return -EBUSY;
@@ -6331,10 +6333,12 @@ static int do_md_stop(struct mddev *mddev, int mode,
 	}
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-	if (mddev->sync_thread)
-		/* Thread might be blocked waiting for metadata update
-		 * which will now never happen */
-		wake_up_process(mddev->sync_thread->tsk);
+
+	/*
+	 * Thread might be blocked waiting for metadata update
+	 * which will now never happen
+	 */
+	md_wakeup_thread(&mddev->sync_thread, mddev);
 
 	mddev_unlock(mddev);
 	wait_event(resync_wait, (mddev->sync_thread == NULL &&
-- 
2.31.1

