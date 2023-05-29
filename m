Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966DE714A42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjE2NYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjE2NYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:24:24 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14678A8;
        Mon, 29 May 2023 06:24:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QVGTF2CKwz4f3wQj;
        Mon, 29 May 2023 21:24:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbB9p3RkWVPoKQ--.23397S10;
        Mon, 29 May 2023 21:24:18 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 6/6] md: enhance checking in md_check_recovery()
Date:   Mon, 29 May 2023 21:20:37 +0800
Message-Id: <20230529132037.2124527-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbB9p3RkWVPoKQ--.23397S10
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1DXF15WF4fCry5trW3Awb_yoW8CryUpF
        WfWas8GrW8ZFW3ZrW7Ka4DJayrAw40vayjyFy3Wa4rJF13ta129345uF1UAFWDAa9aq3WY
        y3W5JFs3Zry8Cw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU17G
        YJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
   be registered, which will corrupt the array.

Make sure md_check_recovery() won't register new sync_thread if
'MD_RECOVERY_RUNING' is still set, and a new WARN_ON_ONCE() is added for
the above corruption,

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index f90226e6ddf8..9da0fc906bbd 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9397,16 +9397,24 @@ void md_check_recovery(struct mddev *mddev)
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
2.39.2

