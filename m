Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F60A6243C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKJN7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiKJN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:59:14 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3F19C19;
        Thu, 10 Nov 2022 05:59:13 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7Njc2LD6zRnvL;
        Thu, 10 Nov 2022 21:59:00 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 21:59:11 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 21:59:10 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] btrfs: qgroup: fix sleep from invalid context bug in update_qgroup_limit_item()
Date:   Thu, 10 Nov 2022 22:13:42 +0800
Message-ID: <20221110141342.2129475-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported BUG as follows:

  BUG: sleeping function called from invalid context at
       include/linux/sched/mm.h:274
  Call Trace:
   <TASK>
   dump_stack_lvl+0xcd/0x134
   __might_resched.cold+0x222/0x26b
   kmem_cache_alloc+0x2e7/0x3c0
   update_qgroup_limit_item+0xe1/0x390
   btrfs_qgroup_inherit+0x147b/0x1ee0
   create_subvol+0x4eb/0x1710
   btrfs_mksubvol+0xfe5/0x13f0
   __btrfs_ioctl_snap_create+0x2b0/0x430
   btrfs_ioctl_snap_create_v2+0x25a/0x520
   btrfs_ioctl+0x2a1c/0x5ce0
   __x64_sys_ioctl+0x193/0x200
   do_syscall_64+0x35/0x80

Fix this by introducing __update_qgroup_limit_item() helper, allocate
memory outside of the spin lock.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/btrfs/qgroup.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9334c3157c22..99a61cc04b68 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -768,11 +768,11 @@ static int del_qgroup_item(struct btrfs_trans_handle *trans, u64 qgroupid)
 	return ret;
 }
 
-static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
-				    struct btrfs_qgroup *qgroup)
+static int __update_qgroup_limit_item(struct btrfs_trans_handle *trans,
+				      struct btrfs_qgroup *qgroup,
+				      struct btrfs_path *path)
 {
 	struct btrfs_root *quota_root = trans->fs_info->quota_root;
-	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct extent_buffer *l;
 	struct btrfs_qgroup_limit_item *qgroup_limit;
@@ -783,10 +783,6 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_QGROUP_LIMIT_KEY;
 	key.offset = qgroup->qgroupid;
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
 	ret = btrfs_search_slot(trans, quota_root, &key, path, 0, 1);
 	if (ret > 0)
 		ret = -ENOENT;
@@ -806,6 +802,21 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(l);
 
 out:
+	return ret;
+}
+
+static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
+				    struct btrfs_qgroup *qgroup)
+{
+	struct btrfs_path *path;
+	int ret;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = __update_qgroup_limit_item(trans, qgroup, path);
+
 	btrfs_free_path(path);
 	return ret;
 }
@@ -2860,6 +2871,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	bool need_rescan = false;
 	u32 level_size = 0;
 	u64 nums;
+	struct btrfs_path *path;
 
 	/*
 	 * There are only two callers of this function.
@@ -2935,6 +2947,11 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		ret = 0;
 	}
 
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	spin_lock(&fs_info->qgroup_lock);
 
@@ -2950,8 +2967,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		dstgroup->max_excl = inherit->lim.max_excl;
 		dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
 		dstgroup->rsv_excl = inherit->lim.rsv_excl;
-
-		ret = update_qgroup_limit_item(trans, dstgroup);
+		ret = __update_qgroup_limit_item(trans, dstgroup, path);
 		if (ret) {
 			qgroup_mark_inconsistent(fs_info);
 			btrfs_info(fs_info,
@@ -3053,6 +3069,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 unlock:
 	spin_unlock(&fs_info->qgroup_lock);
+	btrfs_free_path(path);
 	if (!ret)
 		ret = btrfs_sysfs_add_one_qgroup(fs_info, dstgroup);
 out:
-- 
2.31.1

