Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D005B2EB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiIIGVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiIIGVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:21:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9B1203DA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:21:34 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MP5Px4dlTz14QWp;
        Fri,  9 Sep 2022 14:17:41 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:21:32 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 14:21:31 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <jlbec@evilplan.org>, <hch@lst.de>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next 1/3] configfs: Add configfs_remove_drop_dirent helper
Date:   Fri, 9 Sep 2022 14:56:09 +0800
Message-ID: <20220909065611.31695-2-shangxiaojing@huawei.com>
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

Wrap repeated code in helper function configf_remove_drop_dirent, which
remove dirent and drop dentry.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 fs/configfs/configfs_internal.h |  1 +
 fs/configfs/dir.c               | 16 +++++++++++-----
 fs/configfs/inode.c             |  6 +-----
 fs/configfs/symlink.c           |  6 +-----
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index c0395363eab9..4905b6d35dda 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -76,6 +76,7 @@ extern int configfs_dirent_is_ready(struct configfs_dirent *);
 extern void configfs_hash_and_remove(struct dentry * dir, const char * name);
 
 extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
+extern void configfs_remove_drop_dirent(struct configfs_dirent *sd, struct dentry *dentry);
 extern void configfs_drop_dentry(struct configfs_dirent *sd, struct dentry *parent);
 extern int configfs_setattr(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, struct iattr *iattr);
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index d1f9d2632202..4e086635b3ed 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -257,6 +257,16 @@ int configfs_make_dirent(struct configfs_dirent * parent_sd,
 	return 0;
 }
 
+void configfs_remove_drop_dirent(struct configfs_dirent *sd,
+				  struct dentry *dentry)
+{
+	spin_lock(&configfs_dirent_lock);
+	list_del_init(&sd->s_sibling);
+	spin_unlock(&configfs_dirent_lock);
+	configfs_drop_dentry(sd, dentry);
+	configfs_put(sd);
+}
+
 static void configfs_remove_dirent(struct dentry *dentry)
 {
 	struct configfs_dirent *sd = dentry->d_fsdata;
@@ -562,11 +572,7 @@ static void detach_attrs(struct config_item * item)
 	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
 		if (!sd->s_element || !(sd->s_type & CONFIGFS_NOT_PINNED))
 			continue;
-		spin_lock(&configfs_dirent_lock);
-		list_del_init(&sd->s_sibling);
-		spin_unlock(&configfs_dirent_lock);
-		configfs_drop_dentry(sd, dentry);
-		configfs_put(sd);
+		configfs_remove_drop_dirent(sd, dentry);
 	}
 
 	/**
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index b601610e9907..c91fe11e4450 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -232,11 +232,7 @@ void configfs_hash_and_remove(struct dentry * dir, const char * name)
 		if (!sd->s_element)
 			continue;
 		if (!strcmp(configfs_get_name(sd), name)) {
-			spin_lock(&configfs_dirent_lock);
-			list_del_init(&sd->s_sibling);
-			spin_unlock(&configfs_dirent_lock);
-			configfs_drop_dentry(sd, dir);
-			configfs_put(sd);
+			configfs_remove_drop_dirent(sd, dir);
 			break;
 		}
 	}
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 0623c3edcfb9..529d204b807f 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -233,12 +233,8 @@ int configfs_unlink(struct inode *dir, struct dentry *dentry)
 	parent_item = configfs_get_config_item(dentry->d_parent);
 	type = parent_item->ci_type;
 
-	spin_lock(&configfs_dirent_lock);
-	list_del_init(&sd->s_sibling);
-	spin_unlock(&configfs_dirent_lock);
-	configfs_drop_dentry(sd, dentry->d_parent);
+	configfs_remove_drop_dirent(sd, dentry->d_parent);
 	dput(dentry);
-	configfs_put(sd);
 
 	/*
 	 * drop_link() must be called before
-- 
2.17.1

