Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA5173F2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjF0Dpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjF0Dox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:44:53 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F130E3598;
        Mon, 26 Jun 2023 20:42:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QqrBJ3VcJz4f3nZx;
        Tue, 27 Jun 2023 11:42:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7OXWppk2B6CMg--.877S5;
        Tue, 27 Jun 2023 11:42:17 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 1/2] md/raid10: a simple cleanup for fix_recovery_read_error
Date:   Tue, 27 Jun 2023 11:41:26 +0800
Message-Id: <20230627034127.4000994-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627034127.4000994-1-linan666@huaweicloud.com>
References: <20230627034127.4000994-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7OXWppk2B6CMg--.877S5
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4DurWfCrW5Ww4ktF13Arb_yoWDZFX_Ka
        4xZr93XryIyF47A343Wr18Z3yvya1jgrnFq3y2kFZY9398X3WjgrZ5uwn5XF43ZFZ5urs8
        C3s5Ww15Cr4jkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbmxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
        8IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
        4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
        xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
        6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24lc7
        CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_
        Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2OJ5UUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

There is no need to use a new variable 'rdev2' for write device since
'rdev' is not used again later. Use 'rdev' directly. Assigning return
value to 'ok' is also unnecessary. Clean it up.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 4fcfcb350d2b..5105273f60e9 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2590,10 +2590,9 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
 
 			if (rdev != conf->mirrors[dw].rdev) {
 				/* need bad block on destination too */
-				struct md_rdev *rdev2 = conf->mirrors[dw].rdev;
+				rdev = conf->mirrors[dw].rdev;
 				addr = r10_bio->devs[1].addr + sect;
-				ok = rdev_set_badblocks(rdev2, addr, s, 0);
-				if (!ok) {
+				if (!rdev_set_badblocks(rdev, addr, s, 0)) {
 					/* just abort the recovery */
 					pr_notice("md/raid10:%s: recovery aborted due to read error\n",
 						  mdname(mddev));
-- 
2.39.2

