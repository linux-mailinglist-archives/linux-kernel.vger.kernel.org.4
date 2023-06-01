Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E14719310
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjFAGQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjFAGQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:16:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9DBE2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:16:09 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QWwkR1gVyz18LnG;
        Thu,  1 Jun 2023 14:11:27 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 14:16:06 +0800
From:   Li Lingfeng <lilingfeng3@huawei.com>
To:     <dm-devel@redhat.com>
CC:     <agk@redhat.com>, <snitzer@kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>,
        <lilingfeng3@huawei.com>
Subject: [PATCH] dm: don't lock fs when the map is NULL in process of suspend
Date:   Thu, 1 Jun 2023 14:14:23 +0800
Message-ID: <20230601061423.3594104-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in commit 38d11da522aa ("dm: don't lock fs when the map is
NULL in process of resume"), deadlock may be triggered between do_resume
and do_mount.
What's more, do_suspend and do_mount can also trigger it.
So clear DM_SUSPEND_LOCKFS_FLAG in dm_suspend instead of do_resume.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 drivers/md/dm-ioctl.c | 5 +----
 drivers/md/dm.c       | 3 +++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index cc77cf3d4109..7d5c9c582ed2 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1168,13 +1168,10 @@ static int do_resume(struct dm_ioctl *param)
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
-		int srcu_idx;
 
 		/* Suspend if it isn't already suspended */
-		old_map = dm_get_live_table(md, &srcu_idx);
-		if ((param->flags & DM_SKIP_LOCKFS_FLAG) || !old_map)
+		if (param->flags & DM_SKIP_LOCKFS_FLAG)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
-		dm_put_live_table(md, srcu_idx);
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
 		if (!dm_suspended_md(md))
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3b694ba3a106..39424a0b3cd6 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2809,6 +2809,9 @@ int dm_suspend(struct mapped_device *md, unsigned int suspend_flags)
 
 	map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
 
+	if (!map)
+		suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
+
 	r = __dm_suspend(md, map, suspend_flags, TASK_INTERRUPTIBLE, DMF_SUSPENDED);
 	if (r)
 		goto out_unlock;
-- 
2.31.1

