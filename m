Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3602973B3AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjFWJeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjFWJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:34:17 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783051BFC;
        Fri, 23 Jun 2023 02:34:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QnXBC4bK8z4f3v1X;
        Fri, 23 Jun 2023 17:34:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCXaK8TZ5VkaZ1hMQ--.14505S6;
        Fri, 23 Jun 2023 17:34:12 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 2/3] md: remove redundant check in fix_read_error()
Date:   Sat, 24 Jun 2023 01:32:35 +0800
Message-Id: <20230623173236.2513554-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623173236.2513554-1-linan666@huaweicloud.com>
References: <20230623173236.2513554-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXaK8TZ5VkaZ1hMQ--.14505S6
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw47Xr4fAF1rZF13Ar1xGrg_yoWkKwcEkw
        n3XF9xtr1Fyr17Xr1a9r1Ivryjva4v9r1xJ3y7KFZxZFy5uFyDurykur1kJw45AFW2vFy5
        A34qg3WUCr4DAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbLAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
        4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUn
        -txDUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

In fix_read_error(), 'success' will be checked immediately after assigning
it, if it is set to 1 then the loop will break. Checking it again in
condition of loop is redundant. Clean it up.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid1.c  | 2 +-
 drivers/md/raid10.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 3570da63969b..0391c2d0c109 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2318,7 +2318,7 @@ static void fix_read_error(struct r1conf *conf, int read_disk,
 			d++;
 			if (d == conf->raid_disks * 2)
 				d = 0;
-		} while (!success && d != read_disk);
+		} while (d != read_disk);
 
 		if (!success) {
 			/* Cannot read from anywhere - mark it bad */
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 94ae294c8a3c..a36e53fce21f 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2790,7 +2790,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
 			sl++;
 			if (sl == conf->copies)
 				sl = 0;
-		} while (!success && sl != slot);
+		} while (sl != slot);
 		rcu_read_unlock();
 
 		if (!success) {
-- 
2.39.2

