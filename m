Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C93071423B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 05:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjE2DOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 23:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2DO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 23:14:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72514AF;
        Sun, 28 May 2023 20:14:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QV0xS5cszz4f3jJG;
        Mon, 29 May 2023 11:14:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LOMGHRkx1PJKQ--.20684S4;
        Mon, 29 May 2023 11:14:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] md/raid5: don't allow concurrent reshape with recovery
Date:   Mon, 29 May 2023 11:10:45 +0800
Message-Id: <20230529031045.1760883-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LOMGHRkx1PJKQ--.20684S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWUKr17AFy8KFy5Kw1fCrg_yoW8Gw45pa
        9FkFn8ur4UZw4aqF4DC34DCa4Ykr48JrWftFy3Xw1rA3ZxJryxu3yrGFW5KF1UJFWFqan0
        vr1rJrWDCrW2k3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

commit 0aecb06e2249 ("md/raid5: don't allow replacement while reshape
is in progress") fix that replacement can be set if reshape is
interrupted, which will cause that array can't be assemebled.

There is a similar on the other side, if recovery is interrupted, then
reshape can start, which will cause the same problem.

Fix the prblem by don't start reshape is recovery is still in progress.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 64865f9dd3f5..6db783ca71b7 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8500,6 +8500,7 @@ static int raid5_start_reshape(struct mddev *mddev)
 	struct r5conf *conf = mddev->private;
 	struct md_rdev *rdev;
 	int spares = 0;
+	int i;
 	unsigned long flags;
 
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
@@ -8511,6 +8512,13 @@ static int raid5_start_reshape(struct mddev *mddev)
 	if (has_failed(conf))
 		return -EINVAL;
 
+	/* raid5 can't handle concurrent reshape and recovery */
+	if (mddev->recovery_cp < MaxSector)
+		return -EBUSY;
+	for (i = 0; i < conf->raid_disks; i++)
+		if (rdev_mdlock_deref(mddev, conf->disks[i].replacement))
+			return -EBUSY;
+
 	rdev_for_each(rdev, mddev) {
 		if (!test_bit(In_sync, &rdev->flags)
 		    && !test_bit(Faulty, &rdev->flags))
-- 
2.39.2

