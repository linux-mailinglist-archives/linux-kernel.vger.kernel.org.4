Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0545B2EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiIIGVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiIIGVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:21:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138C21203E5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:21:38 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MP5SC1s82zHnng;
        Fri,  9 Sep 2022 14:19:39 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:21:33 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 14:21:32 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <jlbec@evilplan.org>, <hch@lst.de>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next 3/3] configfs: Add subsys_to_item helper
Date:   Fri, 9 Sep 2022 14:56:11 +0800
Message-ID: <20220909065611.31695-4-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909065611.31695-1-shangxiaojing@huawei.com>
References: <20220909065611.31695-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper function subsys_to_item, which get the corresponding
config_item of the configfs_subsystem.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 fs/configfs/dir.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index b5614b66add2..e4386eab3428 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -281,7 +281,7 @@ static void configfs_remove_dirent(struct dentry *dentry)
 
 /**
  *	configfs_create_dir - create a directory for an config_item.
- *	@item:		config_itemwe're creating directory for.
+ *	@item:		config_item we're creating directory for.
  *	@dentry:	config_item's dentry.
  *	@frag:		config_item's fragment.
  *
@@ -616,6 +616,12 @@ static inline struct dentry *group_to_dentry(struct config_group *group)
 	return group->cg_item.ci_dentry;
 }
 
+static inline
+struct config_item *subsys_to_item(struct configfs_subsystem *subsys)
+{
+	return &subsys->su_group.cg_item;
+}
+
 static int configfs_attach_group(struct config_item *parent_item,
 				 struct config_item *item,
 				 struct dentry *dentry,
@@ -1119,7 +1125,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
 {
 	int ret;
 	struct configfs_dirent *subsys_sd;
-	struct config_item *s_item = &subsys->su_group.cg_item;
+	struct config_item *s_item = subsys_to_item(subsys);
 	struct dentry *root;
 
 	/*
@@ -1238,11 +1244,11 @@ int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
 		 */
 		subsys_sd = configfs_find_subsys_dentry(
 				group_to_dentry(root)->d_fsdata,
-				&target_subsys->su_group.cg_item);
+				subsys_to_item(target_subsys));
 		if (!subsys_sd)
 			goto out_root_unlock;
 	} else {
-		subsys_sd = target_subsys->su_group.cg_item.ci_dentry->d_fsdata;
+		subsys_sd = subsys_to_item(target_subsys)->ci_dentry->d_fsdata;
 	}
 
 	/* Now we can execute core of depend item */
@@ -1315,11 +1321,11 @@ static int configfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	 * being created.  We don't want to safely pin the new item but
 	 * fail to pin the subsystem it sits under.
 	 */
-	if (!subsys->su_group.cg_item.ci_type) {
+	if (!subsys_to_item(subsys)->ci_type) {
 		ret = -EINVAL;
 		goto out_put;
 	}
-	subsys_owner = subsys->su_group.cg_item.ci_type->ct_owner;
+	subsys_owner = subsys_to_item(subsys)->ci_type->ct_owner;
 	if (!try_module_get(subsys_owner)) {
 		ret = -EINVAL;
 		goto out_put;
@@ -1469,8 +1475,8 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
 	}
 
 	/* configfs_mkdir() shouldn't have allowed this */
-	BUG_ON(!subsys->su_group.cg_item.ci_type);
-	subsys_owner = subsys->su_group.cg_item.ci_type->ct_owner;
+	BUG_ON(!subsys_to_item(subsys)->ci_type);
+	subsys_owner = subsys_to_item(subsys)->ci_type->ct_owner;
 
 	/*
 	 * Ensure that no racing symlink() will make detach_prep() fail while
-- 
2.17.1

