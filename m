Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70121702E78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbjEONj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjEONj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:39:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F41BC;
        Mon, 15 May 2023 06:39:25 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QKgN86mwlzqSS4;
        Mon, 15 May 2023 21:35:04 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 21:39:22 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miklos@szeredi.hu>, <amir73il@gmail.com>, <brauner@kernel.org>
CC:     <linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH v2 1/2] ovl: ovl_permission: Fix null pointer dereference at realinode in rcu-walk mode
Date:   Mon, 15 May 2023 21:36:28 +0800
Message-ID: <20230515133629.1974610-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515133629.1974610-1-chengzhihao1@huawei.com>
References: <20230515133629.1974610-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following process:
          P1                     P2
 path_lookupat
  link_path_walk
   inode_permission
    ovl_permission
      ovl_i_path_real(inode, &realpath)
        path->dentry = ovl_i_dentry_upper(inode)
                          drop_cache
			   __dentry_kill(ovl_dentry)
		            iput(ovl_inode)
		             ovl_destroy_inode(ovl_inode)
		              dput(oi->__upperdentry)
		               dentry_kill(upperdentry)
		                dentry_unlink_inode
				 upperdentry->d_inode = NULL
      realinode = d_inode(realpath.dentry) // return NULL
      inode_permission(realinode)
       inode->i_sb  // NULL pointer dereference
, will trigger an null pointer dereference at realinode:
  [  335.664979] BUG: kernel NULL pointer dereference,
                 address: 0000000000000002
  [  335.668032] CPU: 0 PID: 2592 Comm: ls Not tainted 6.3.0
  [  335.669956] RIP: 0010:inode_permission+0x33/0x2c0
  [  335.678939] Call Trace:
  [  335.679165]  <TASK>
  [  335.679371]  ovl_permission+0xde/0x320
  [  335.679723]  inode_permission+0x15e/0x2c0
  [  335.680090]  link_path_walk+0x115/0x550
  [  335.680771]  path_lookupat.isra.0+0xb2/0x200
  [  335.681170]  filename_lookup+0xda/0x240
  [  335.681922]  vfs_statx+0xa6/0x1f0
  [  335.682233]  vfs_fstatat+0x7b/0xb0

Fetch a reproducer in [Link].

Add a new helper ovl_i_path_realinode() to get realpath and real inode
after non-nullptr checking, use the helper to replace the current realpath
getting logic.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217405
Fixes: 4b7791b2e958 ("ovl: handle idmappings in ovl_permission()")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 541cf3717fc2..cc3ef5a6666a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -278,6 +278,26 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return err;
 }
 
+static inline int ovl_i_path_realinode(struct inode *inode,
+				       struct path *realpath,
+				       struct inode **realinode, int rcu)
+{
+	/* Careful in RCU walk mode */
+	ovl_i_path_real(inode, realpath);
+	if (!realpath->dentry) {
+		WARN_ON(!rcu);
+		return -ECHILD;
+	}
+
+	*realinode = d_inode(realpath->dentry);
+	if (!*realinode) {
+		WARN_ON(!rcu);
+		return -ECHILD;
+	}
+
+	return 0;
+}
+
 int ovl_permission(struct mnt_idmap *idmap,
 		   struct inode *inode, int mask)
 {
@@ -287,12 +307,10 @@ int ovl_permission(struct mnt_idmap *idmap,
 	const struct cred *old_cred;
 	int err;
 
-	/* Careful in RCU walk mode */
-	ovl_i_path_real(inode, &realpath);
-	if (!realpath.dentry) {
-		WARN_ON(!(mask & MAY_NOT_BLOCK));
-		return -ECHILD;
-	}
+	err = ovl_i_path_realinode(inode, &realpath, &realinode,
+				   mask & MAY_NOT_BLOCK);
+	if (err)
+		return err;
 
 	/*
 	 * Check overlay inode with the creds of task and underlying inode
@@ -302,7 +320,6 @@ int ovl_permission(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	realinode = d_inode(realpath.dentry);
 	old_cred = ovl_override_creds(inode->i_sb);
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
-- 
2.39.2

