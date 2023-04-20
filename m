Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F43D6E92CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjDTLcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjDTLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:31:44 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACF630D6;
        Thu, 20 Apr 2023 04:31:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q2Fpp5KjSz4f3yb9;
        Thu, 20 Apr 2023 19:31:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7OAIkFkVY8hHw--.17021S9;
        Thu, 20 Apr 2023 19:31:16 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, neilb@suse.de, akpm@osdl.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 5/8] md/raid1-10: submit write io directly if bitmap is not enabled
Date:   Thu, 20 Apr 2023 19:29:43 +0800
Message-Id: <20230420112946.2869956-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
References: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7OAIkFkVY8hHw--.17021S9
X-Coremail-Antispam: 1UD129KBjvJXoWxuF15JFyrGw47Ww45AF1DJrb_yoW5ZFyfpa
        yDGa4Ykr15JFW3X3ZxAa4DAFyFy3s3tr9rKryfC398uFy3XFsxGr4rGay5t3ZrCrnxGF43
        Xr1YkryUCr18XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Commit 6cce3b23f6f8 ("[PATCH] md: write intent bitmap support for raid10")
add bitmap support, and it changed that write io is submitted through demon
thread because bitmap need to be updated before write io. And later, plug
is used to fix performance regression because all the write io will go to
demon thread, which means io can't be issued concurrently.

However, if bitmap is not enabled, the write io should not go to demon
thread in the first place, and plug is not needed as well.

Fixes: 6cce3b23f6f8 ("[PATCH] md: write intent bitmap support for raid10")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c |  4 +---
 drivers/md/md-bitmap.h |  7 +++++++
 drivers/md/raid1-10.h  | 15 +++++++++++++--
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index ab27f66dbb1f..4bd980b272ef 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1000,7 +1000,6 @@ static int md_bitmap_file_test_bit(struct bitmap *bitmap, sector_t block)
 	return set;
 }
 
-
 /* this gets called when the md device is ready to unplug its underlying
  * (slave) device queues -- before we let any writes go down, we need to
  * sync the dirty pages of the bitmap file to disk */
@@ -1010,8 +1009,7 @@ void md_bitmap_unplug(struct bitmap *bitmap)
 	int dirty, need_write;
 	int writing = 0;
 
-	if (!bitmap || !bitmap->storage.filemap ||
-	    test_bit(BITMAP_STALE, &bitmap->flags))
+	if (!md_bitmap_enabled(bitmap))
 		return;
 
 	/* look at each page to see if there are any set bits that need to be
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index cfd7395de8fd..3a4750952b3a 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -273,6 +273,13 @@ int md_bitmap_copy_from_slot(struct mddev *mddev, int slot,
 			     sector_t *lo, sector_t *hi, bool clear_bits);
 void md_bitmap_free(struct bitmap *bitmap);
 void md_bitmap_wait_behind_writes(struct mddev *mddev);
+
+static inline bool md_bitmap_enabled(struct bitmap *bitmap)
+{
+	return bitmap && bitmap->storage.filemap &&
+	       !test_bit(BITMAP_STALE, &bitmap->flags);
+}
+
 #endif
 
 #endif
diff --git a/drivers/md/raid1-10.h b/drivers/md/raid1-10.h
index 9dc53d8a8129..95b2fb4dd9aa 100644
--- a/drivers/md/raid1-10.h
+++ b/drivers/md/raid1-10.h
@@ -2,6 +2,8 @@
 #ifndef _RAID1_10_H
 #define _RAID1_10_H
 
+#include "md-bitmap.h"
+
 /* Maximum size of each resync request */
 #define RESYNC_BLOCK_SIZE (64*1024)
 #define RESYNC_PAGES ((RESYNC_BLOCK_SIZE + PAGE_SIZE-1) / PAGE_SIZE)
@@ -133,9 +135,18 @@ static inline bool md_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
 				      blk_plug_cb_fn unplug)
 {
 	struct raid1_plug_cb *plug = NULL;
-	struct blk_plug_cb *cb = blk_check_plugged(unplug, mddev,
-						   sizeof(*plug));
+	struct blk_plug_cb *cb;
+
+	/*
+	 * If bitmap is not enabled, it's safe to submit the io directly, and
+	 * this can get optimal performance.
+	 */
+	if (!md_bitmap_enabled(mddev->bitmap)) {
+		md_submit_write(bio);
+		return true;
+	}
 
+	cb = blk_check_plugged(unplug, mddev, sizeof(*plug));
 	if (!cb)
 		return false;
 
-- 
2.39.2

