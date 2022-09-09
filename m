Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE45B2EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiIIGVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiIIGVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:21:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018F510B02E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:21:35 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MP5Py1Dvwz14QYV;
        Fri,  9 Sep 2022 14:17:42 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:21:32 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 14:21:32 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <jlbec@evilplan.org>, <hch@lst.de>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next 2/3] configfs: Add group_to_dentry helper
Date:   Fri, 9 Sep 2022 14:56:10 +0800
Message-ID: <20220909065611.31695-3-shangxiaojing@huawei.com>
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

Add group_to_dentry helper function for more clear, which get the
corresponding dentry of the config_group.

Space is deleted due to checkpatch.pl.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 fs/configfs/dir.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 4e086635b3ed..b5614b66add2 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -611,6 +611,11 @@ static int populate_attrs(struct config_item *item)
 	return error;
 }
 
+static inline struct dentry *group_to_dentry(struct config_group *group)
+{
+	return group->cg_item.ci_dentry;
+}
+
 static int configfs_attach_group(struct config_item *parent_item,
 				 struct config_item *item,
 				 struct dentry *dentry,
@@ -619,7 +624,7 @@ static void configfs_detach_group(struct config_item *item);
 
 static void detach_groups(struct config_group *group)
 {
-	struct dentry * dentry = dget(group->cg_item.ci_dentry);
+	struct dentry *dentry = dget(group_to_dentry(group));
 	struct dentry *child;
 	struct configfs_dirent *parent_sd;
 	struct configfs_dirent *sd, *tmp;
@@ -668,7 +673,7 @@ static int create_default_group(struct config_group *parent_group,
 	int ret;
 	struct configfs_dirent *sd;
 	/* We trust the caller holds a reference to parent */
-	struct dentry *child, *parent = parent_group->cg_item.ci_dentry;
+	struct dentry *child, *parent = group_to_dentry(parent_group);
 
 	if (!group->cg_item.ci_name)
 		group->cg_item.ci_name = group->cg_item.ci_namebuf;
@@ -1225,14 +1230,14 @@ int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
 		 * additional locking to prevent other subsystem from being
 		 * unregistered
 		 */
-		inode_lock(d_inode(root->cg_item.ci_dentry));
+		inode_lock(d_inode(group_to_dentry(root)));
 
 		/*
 		 * As we are trying to depend item from other subsystem
 		 * we have to check if this subsystem is still registered
 		 */
 		subsys_sd = configfs_find_subsys_dentry(
-				root->cg_item.ci_dentry->d_fsdata,
+				group_to_dentry(root)->d_fsdata,
 				&target_subsys->su_group.cg_item);
 		if (!subsys_sd)
 			goto out_root_unlock;
@@ -1249,7 +1254,7 @@ int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
 		 * We were called from subsystem other than our target so we
 		 * took some locks so now it's time to release them
 		 */
-		inode_unlock(d_inode(root->cg_item.ci_dentry));
+		inode_unlock(d_inode(group_to_dentry(root)));
 
 	return ret;
 }
@@ -1745,7 +1750,7 @@ int configfs_register_group(struct config_group *parent_group,
 	link_group(parent_group, group);
 	mutex_unlock(&subsys->su_mutex);
 
-	parent = parent_group->cg_item.ci_dentry;
+	parent = group_to_dentry(parent_group);
 
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
 	ret = create_default_group(parent_group, group, frag);
@@ -1753,7 +1758,7 @@ int configfs_register_group(struct config_group *parent_group,
 		goto err_out;
 
 	spin_lock(&configfs_dirent_lock);
-	configfs_dir_set_ready(group->cg_item.ci_dentry->d_fsdata);
+	configfs_dir_set_ready(group_to_dentry(group)->d_fsdata);
 	spin_unlock(&configfs_dirent_lock);
 	inode_unlock(d_inode(parent));
 	put_fragment(frag);
@@ -1777,7 +1782,7 @@ EXPORT_SYMBOL(configfs_register_group);
 void configfs_unregister_group(struct config_group *group)
 {
 	struct configfs_subsystem *subsys = group->cg_subsys;
-	struct dentry *dentry = group->cg_item.ci_dentry;
+	struct dentry *dentry = group_to_dentry(group);
 	struct dentry *parent = group->cg_item.ci_parent->ci_dentry;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
@@ -1913,7 +1918,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 {
 	struct config_group *group = &subsys->su_group;
-	struct dentry *dentry = group->cg_item.ci_dentry;
+	struct dentry *dentry = group_to_dentry(group);
 	struct dentry *root = dentry->d_sb->s_root;
 	struct configfs_dirent *sd = dentry->d_fsdata;
 	struct configfs_fragment *frag = sd->s_frag;
-- 
2.17.1

