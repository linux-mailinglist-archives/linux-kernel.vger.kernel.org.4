Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4AF7447E7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGAIGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjGAIGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:06:41 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F81CE5E;
        Sat,  1 Jul 2023 01:06:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QtPsN4r5Jz4f3svp;
        Sat,  1 Jul 2023 16:06:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgA30JOH3p9kdvLGMw--.57184S5;
        Sat, 01 Jul 2023 16:06:33 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, guoqing.jiang@cloud.ionos.com, xni@redhat.com,
        colyli@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH v2 1/3] md/raid10: check replacement and rdev to prevent submit the same io twice
Date:   Sat,  1 Jul 2023 16:05:27 +0800
Message-Id: <20230701080529.2684932-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230701080529.2684932-1-linan666@huaweicloud.com>
References: <20230701080529.2684932-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA30JOH3p9kdvLGMw--.57184S5
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWxZw48Cr48Kw4fWFW3Jrb_yoWfurXEkw
        s5AF9aqr1xKF13Cwn0kr1IvrWDXw1qgFy7WrWYgrWYvFy5uryUKrW0gFZ7W3W5CrWDZr15
        Ar1DKa1UArn8AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbk8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
        8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
        4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
        xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
        6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2
        kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
        UjIFyTuYvjxUc6wZUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

After commit 4ca40c2ce099 ("md/raid10: Allow replacement device to be
replace old drive."), 'rdev' and 'replacement' could appear to be
identical. There are already checks for that in wait_blocked_dev() and
raid10_write_request(). Add check for raid10_handle_discard() now.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index fabc340aae4f..3e6a09aaaba6 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1811,6 +1811,8 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		r10_bio->devs[disk].bio = NULL;
 		r10_bio->devs[disk].repl_bio = NULL;
 
+		if (rdev == rrdev)
+			rrdev = NULL;
 		if (rdev && (test_bit(Faulty, &rdev->flags)))
 			rdev = NULL;
 		if (rrdev && (test_bit(Faulty, &rrdev->flags)))
-- 
2.39.2

