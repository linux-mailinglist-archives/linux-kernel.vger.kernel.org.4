Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521016F82E5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjEEM0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjEEM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:26:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EC21CFE2;
        Fri,  5 May 2023 05:26:06 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QCVDR67GfzZflD;
        Fri,  5 May 2023 20:21:59 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 5 May
 2023 20:26:04 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <miklos@szeredi.hu>, <amir73il@gmail.com>, <brauner@kernel.org>
CC:     <linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ovl: ovl_permission: Fix null pointer dereference at realinode in rcu-walk mode
Date:   Fri, 5 May 2023 20:24:52 +0800
Message-ID: <20230505122452.405661-3-chengzhihao1@huawei.com>
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

Fix it by checking realinode whether to be NULL before accessing it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217405
Fixes: 4b7791b2e958 ("ovl: handle idmappings in ovl_permission()")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/overlayfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 38cfdf9e2b44..a4c56584b8c2 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -293,6 +293,11 @@ int ovl_permission(struct mnt_idmap *idmap,
 		WARN_ON(!(mask & MAY_NOT_BLOCK));
 		return -ECHILD;
 	}
+	realinode = d_inode(realpath.dentry);
+	if (!realinode) {
+		WARN_ON(!(mask & MAY_NOT_BLOCK));
+		return -ECHILD;
+	}
 
 	/*
 	 * Check overlay inode with the creds of task and underlying inode
@@ -302,7 +307,6 @@ int ovl_permission(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	realinode = d_inode(realpath.dentry);
 	old_cred = ovl_override_creds(inode->i_sb);
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
-- 
2.31.1

