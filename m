Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9E36F82E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjEEM0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjEEM0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:26:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FAA1CFE1;
        Fri,  5 May 2023 05:26:06 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QCVFw2tNdzLpGC;
        Fri,  5 May 2023 20:23:16 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 20:26:03 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miklos@szeredi.hu>, <amir73il@gmail.com>, <brauner@kernel.org>
CC:     <linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ovl: get_acl: Fix null pointer dereference at realinode in rcu-walk mode
Date:   Fri, 5 May 2023 20:24:51 +0800
Message-ID: <20230505122452.405661-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230505122452.405661-1-chengzhihao1@huawei.com>
References: <20230505122452.405661-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
 path_openat
  link_path_walk
   may_lookup
    inode_permission(rcu)
     ovl_permission
      acl_permission_check
       check_acl
        get_cached_acl_rcu
	 ovl_get_inode_acl
	  realinode = ovl_inode_real(ovl_inode)
	                      drop_cache
		               __dentry_kill(ovl_dentry)
				iput(ovl_inode)
		                 ovl_destroy_inode(ovl_inode)
		                  dput(oi->__upperdentry)
		                   dentry_kill(upperdentry)
		                    dentry_unlink_inode
				     upperdentry->d_inode = NULL
	    ovl_inode_upper
	     upperdentry = ovl_i_dentry_upper(ovl_inode)
	     d_inode(upperdentry) // returns NULL
	  IS_POSIXACL(realinode) // NULL pointer dereference
, will trigger an null pointer dereference at realinode:
  [  205.472797] BUG: kernel NULL pointer dereference, address:
                 0000000000000028
  [  205.476701] CPU: 2 PID: 2713 Comm: ls Not tainted
                 6.3.0-12064-g2edfa098e750-dirty #1216
  [  205.478754] RIP: 0010:do_ovl_get_acl+0x5d/0x300
  [  205.489584] Call Trace:
  [  205.489812]  <TASK>
  [  205.490014]  ovl_get_inode_acl+0x26/0x30
  [  205.490466]  get_cached_acl_rcu+0x61/0xa0
  [  205.490908]  generic_permission+0x1bf/0x4e0
  [  205.491447]  ovl_permission+0x79/0x1b0
  [  205.491917]  inode_permission+0x15e/0x2c0
  [  205.492425]  link_path_walk+0x115/0x550
  [  205.493311]  path_lookupat.isra.0+0xb2/0x200
  [  205.493803]  filename_lookup+0xda/0x240
  [  205.495747]  vfs_fstatat+0x7b/0xb0

Fetch a reproducer in [Link].

Fix it by checking realinode whether to be NULL before accessing it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217404
Fixes: 332f606b32b6 ("ovl: enable RCU'd ->get_acl()")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/overlayfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 541cf3717fc2..38cfdf9e2b44 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -563,16 +563,16 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 	struct posix_acl *acl;
 	struct path realpath;
 
-	if (!IS_POSIXACL(realinode))
-		return NULL;
-
 	/* Careful in RCU walk mode */
 	ovl_i_path_real(inode, &realpath);
-	if (!realpath.dentry) {
+	if (!realpath.dentry || !realinode) {
 		WARN_ON(!rcu);
 		return ERR_PTR(-ECHILD);
 	}
 
+	if (!IS_POSIXACL(realinode))
+		return NULL;
+
 	if (rcu) {
 		/*
 		 * If the layer is idmapped drop out of RCU path walk
-- 
2.31.1

