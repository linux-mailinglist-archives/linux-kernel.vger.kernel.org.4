Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4694F6B378B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCJHkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjCJHju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:39:50 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56237F9ED4;
        Thu,  9 Mar 2023 23:39:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PXycP1wcVz4f3nTY;
        Fri, 10 Mar 2023 15:39:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R+03gpkwSimEg--.34063S6;
        Fri, 10 Mar 2023 15:39:34 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     guoqing.jiang@linux.dev, song@kernel.org, jgq516@gmail.com,
        neilb@suse.de, shli@fb.com, lzhong@suse.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 2/6] md: fix soft lockup in status_resync
Date:   Fri, 10 Mar 2023 15:38:51 +0800
Message-Id: <20230310073855.1337560-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230310073855.1337560-1-yukuai1@huaweicloud.com>
References: <20230310073855.1337560-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R+03gpkwSimEg--.34063S6
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4UXryrCry7tFW3Xw1xAFb_yoW8Aryrpa
        93ZFWxArWFvFWxJrZxJr1UZa4rAa4FyrZrKF4Uuw43ZF1fCr1jyr1UCF4DWrykWF95Jryj
        qa4Fyr98CF1UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
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
index 546b1b81eb28..98970bbe32bf 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8009,16 +8009,16 @@ static int status_resync(struct seq_file *seq, struct mddev *mddev)
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

