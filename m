Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B236AA872
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 07:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCDGjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 01:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCDGjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 01:39:00 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5F911656;
        Fri,  3 Mar 2023 22:38:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PTFYB2lhtz4f3jJ2;
        Sat,  4 Mar 2023 14:38:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyF_5wJkKh8_EQ--.5411S4;
        Sat, 04 Mar 2023 14:38:56 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] md: fix soft lockup in status_resync
Date:   Sat,  4 Mar 2023 15:02:13 +0800
Message-Id: <20230304070213.1137011-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyF_5wJkKh8_EQ--.5411S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4UXryrCry7tFW3Ar1DWrg_yoW8Aryrpa
        93ZFWxArW5tFWxJrZxJF1UXa4rAa4FyFZrKF4Uuw43ZF1fCr1jyr1UCF4DWrykWFykJrW0
        qa4Fyr98WF1UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
        v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

status_resync() will calculate 'curr_resync - recovery_active' to show
user a progress bar like following:

[============>........]  resync = 61.4%

'curr_resync' and 'recovery_active' is updated in md_do_sync(), and
status_resync() can read them concurrently, hence it's possible that
'curr_resync - recovery_active' can overflow to a huge number. In this
case status_resync() will be stuck in the loop to print a large amount
of '=', which will end up soft lockup.

Fix the problem by setting 'resync' to MD_RESYNC_ACTIVE in this case,
this way resync in progress will be reported to user.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 927a43db5dfb..ee405e793fc7 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8029,16 +8029,16 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
 	} else if (resync > max_sectors) {
 		resync = max_sectors;
 	} else {
-		resync -= atomic_read(&mddev->recovery_active);
-		if (resync < MD_RESYNC_ACTIVE) {
-			/*
-			 * Resync has started, but the subtraction has
-			 * yielded one of the special values. Force it
-			 * to active to ensure the status reports an
-			 * active resync.
-			 */
+		res = atomic_read(&mddev->recovery_active);
+		/*
+		 * Resync has started, but the subtraction has overflowed or
+		 * yielded one of the special values. Force it to active to
+		 * ensure the status reports an active resync.
+		 */
+		if (resync < res || resync - res < MD_RESYNC_ACTIVE)
 			resync = MD_RESYNC_ACTIVE;
-		}
+		else
+			resync -= res;
 	}
 
 	if (resync == MD_RESYNC_NONE) {
-- 
2.31.1

