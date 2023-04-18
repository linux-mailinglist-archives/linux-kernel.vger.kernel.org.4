Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F506E5C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjDRIjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjDRIji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:39:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654664EE9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:39:12 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [7.185.36.110])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q0y332TYczsRFq;
        Tue, 18 Apr 2023 16:37:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Apr
 2023 16:38:48 +0800
From:   Li Lingfeng <lilingfeng3@huawei.com>
To:     <dm-devel@redhat.com>
CC:     <agk@redhat.com>, <snitzer@kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>,
        <lilingfeng3@huawei.com>
Subject: [PATCH -next] dm: don't lock fs when the map is NULL in process of resume
Date:   Tue, 18 Apr 2023 16:38:04 +0800
Message-ID: <20230418083804.2548437-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fa247089de99 ("dm: requeue IO if mapping table not yet available")
added a detection of whether the mapping table is available in the IO
submission process. If the mapping table is unavailable, it returns
BLK_STS_RESOURCE and requeues the IO.
This can lead to the following deadlock problem:

dm create                                      mount
ioctl(DM_DEV_CREATE_CMD)
ioctl(DM_TABLE_LOAD_CMD)
                               do_mount
                                vfs_get_tree
                                 ext4_get_tree
                                  get_tree_bdev
                                   sget_fc
                                    alloc_super
                                     // got &s->s_umount
                                     down_write_nested(&s->s_umount, ...);
                                   ext4_fill_super
                                    ext4_load_super
                                     ext4_read_bh
                                      submit_bio
                                      // submit and wait io end
ioctl(DM_DEV_SUSPEND_CMD)
dev_suspend
 do_resume
  dm_suspend
   __dm_suspend
    lock_fs
     freeze_bdev
      get_active_super
       grab_super
        // wait for &s->s_umount
        down_write(&s->s_umount);
  dm_swap_table
   __bind
    // set md->map(can't get here)

IO will be continuously requeued while holding the lock since mapping
table is null. At the same time, mapping table won't be set since the
lock is not available.
Like request-based DM, bio-based DM also has the same problem.

It's not proper to just abort IO if the mapping table not available.
So clear DM_SKIP_LOCKFS_FLAG when the mapping table is NULL.

Fixes: fa247089de99 ("dm: requeue IO if mapping table not yet available")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 drivers/md/dm-ioctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 50a1259294d1..48e5554e3b69 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1168,10 +1168,14 @@ static int do_resume(struct dm_ioctl *param)
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
+		int srcu_idx;
 
+		old_map = dm_get_live_table(md, &srcu_idx);
 		/* Suspend if it isn't already suspended */
-		if (param->flags & DM_SKIP_LOCKFS_FLAG)
+		if ((param->flags & DM_SKIP_LOCKFS_FLAG) || !old_map)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
+		dm_put_live_table(md, srcu_idx);
+
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
 		if (!dm_suspended_md(md))
-- 
2.31.1

