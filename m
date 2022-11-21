Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B045563215C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiKULxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiKULxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:53:23 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDAF165B2;
        Mon, 21 Nov 2022 03:53:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NG5PS4wjJz4f3jYt;
        Mon, 21 Nov 2022 19:53:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgDHONatZntj0uehAw--.51112S6;
        Mon, 21 Nov 2022 19:53:19 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 2/3] ext4: record error when detect abnormal 'i_reserved_data_blocks'
Date:   Mon, 21 Nov 2022 20:14:33 +0800
Message-Id: <20221121121434.1061725-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221121121434.1061725-1-yebin@huaweicloud.com>
References: <20221121121434.1061725-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHONatZntj0uehAw--.51112S6
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1DXr1UJFW8Zr17uF13XFb_yoWkGrbEqw
        40yF10v393Xw4xWFs5GrnxJFsYkF4kCr18Ww4rKF15Zr1jvF4DAw4kAry7Zrn5Way8Grn0
        9rWfJry3GrWrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
        8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
        4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
        73UjIFyTuYvjxU2_MaUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

If 'i_reserved_data_blocks' is not cleared which mean something wrong with
code, free space accounting is likely wrong, according to Jan Kara's advice
use ext4_error() to record this abnormal let fsck to repair and also we can
capture this issue.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/super.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0690e2e0b74d..3d30007502a4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1387,10 +1387,9 @@ static void ext4_destroy_inode(struct inode *inode)
 	}
 
 	if (EXT4_I(inode)->i_reserved_data_blocks)
-		ext4_msg(inode->i_sb, KERN_ERR,
-			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
-			 inode->i_ino, EXT4_I(inode),
-			 EXT4_I(inode)->i_reserved_data_blocks);
+		ext4_error(inode->i_sb, "Inode %lu (%p) i_reserved_data_blocks"
+			   " (%u) not cleared!", inode->i_ino, EXT4_I(inode),
+			   EXT4_I(inode)->i_reserved_data_blocks);
 }
 
 static void init_once(void *foo)
-- 
2.31.1

