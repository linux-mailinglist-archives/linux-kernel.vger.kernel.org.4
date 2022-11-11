Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D919462562C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiKKJFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiKKJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:05:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7001D20364;
        Fri, 11 Nov 2022 01:05:26 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7t7t25QVzHvnr;
        Fri, 11 Nov 2022 17:04:58 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 17:05:24 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 17:05:23 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <quwenruo.btrfs@gmx.com>
Subject: [PATCH v3] btrfs: qgroup: fix sleep from invalid context bug in update_qgroup_limit_item()
Date:   Fri, 11 Nov 2022 17:20:00 +0800
Message-ID: <20221111092000.2275068-1-chenxiaosong2@huawei.com>
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

Fix this by delaying the limit item updates until unlock the spin lock.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/btrfs/qgroup.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9334c3157c22..0071b2be6785 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2860,6 +2860,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	bool need_rescan = false;
 	u32 level_size = 0;
 	u64 nums;
+	bool update_limit = false;
+	int err;
 
 	/*
 	 * There are only two callers of this function.
@@ -2950,15 +2952,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		dstgroup->max_excl = inherit->lim.max_excl;
 		dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
 		dstgroup->rsv_excl = inherit->lim.rsv_excl;
-
-		ret = update_qgroup_limit_item(trans, dstgroup);
-		if (ret) {
-			qgroup_mark_inconsistent(fs_info);
-			btrfs_info(fs_info,
-				   "unable to update quota limit for %llu",
-				   dstgroup->qgroupid);
-			goto unlock;
-		}
+		update_limit = true;
 	}
 
 	if (srcid) {
@@ -2985,6 +2979,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		dstgroup->max_excl = srcgroup->max_excl;
 		dstgroup->rsv_rfer = srcgroup->rsv_rfer;
 		dstgroup->rsv_excl = srcgroup->rsv_excl;
+		update_limit = true;
 
 		qgroup_dirty(fs_info, dstgroup);
 		qgroup_dirty(fs_info, srcgroup);
@@ -3053,6 +3048,16 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 unlock:
 	spin_unlock(&fs_info->qgroup_lock);
+	if (update_limit) {
+		err = update_qgroup_limit_item(trans, dstgroup);
+		if (err) {
+			ret = err;
+			qgroup_mark_inconsistent(fs_info);
+			btrfs_info(fs_info,
+				   "unable to update quota limit for %llu",
+				   dstgroup->qgroupid);
+		}
+	}
 	if (!ret)
 		ret = btrfs_sysfs_add_one_qgroup(fs_info, dstgroup);
 out:
-- 
2.31.1

