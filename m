Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399AA6F02D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbjD0I5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0I5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:57:14 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637EC19AF;
        Thu, 27 Apr 2023 01:57:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q6V3n03fMz4f3mJP;
        Thu, 27 Apr 2023 16:57:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rHjOEpkmCsBIQ--.37560S5;
        Thu, 27 Apr 2023 16:57:10 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, neilb@suse.de, Rob.Becker@riverbed.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 1/3] md/raid10: fix slab-out-of-bounds in md_bitmap_get_counter
Date:   Thu, 27 Apr 2023 16:56:10 +0800
Message-Id: <20230427085612.1346752-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230427085612.1346752-1-linan666@huaweicloud.com>
References: <20230427085612.1346752-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rHjOEpkmCsBIQ--.37560S5
X-Coremail-Antispam: 1UD129KBjvdXoWrur48urW5XF4UKw4rZFy7Jrb_yoWftrX_C3
        4rXFyxJrWUCry3AwnrXw4xZrWjyw1Du3Z7WFsaqrySvF18u343WrW0yrnxt3WrGrW09ry5
        Jryj9ayrur4YkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbkxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
        8IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
        4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
        xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
        6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2
        kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU858n5UUUUU==
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

If we write a large number to md/bitmap_set_bits, md_bitmap_checkpage()
will return -EINVAL because "page >= bitmap->pages", but the return value
was not checked immediately in md_bitmap_get_counter() in order to set
*blocks value and slab-out-of-bounds occurs.

Return directly if err is -EINVAL.

Fixes: ef4256733506 ("md/bitmap: optimise scanning of empty bitmaps.")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md-bitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 920bb68156d2..0b41ef422da7 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1388,6 +1388,8 @@ __acquires(bitmap->lock)
 	int err;
 
 	err = md_bitmap_checkpage(bitmap, page, create, 0);
+	if (err == -EINVAL)
+		return NULL;
 
 	if (bitmap->bp[page].hijacked ||
 	    bitmap->bp[page].map == NULL)
-- 
2.31.1

