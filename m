Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2E8738807
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjFUOyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjFUOxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8162D7D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C7CB615BB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 14:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D73C433C8;
        Wed, 21 Jun 2023 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358980;
        bh=Cj2Q7NnXKWgbtOgOZOjzN49NX82O0+W8R1sITnlopBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7PEBlpa2v4zDswyQTlXr4xmiS28PYWdfKb4kSXcqGAUyqdnjRrig/yGLvR4ZnBvb
         mRBUyf4Weoyqg/CifbdFZqp227MKHPxfiMMipRIOaKTSgB1cQLTdqvCELQgTTL2vZw
         C5hk0vmCfifRwye4Dq+A69Ydd2XNGOez7vopcPrnKeVXwfbZsb0/0kZuF8vSFhfJZM
         Dq6bh5jf7gtKb9zccuou+SfbHixHopfz6BZEizUZhIM91rsKai/xtMOas+rgbsZAUs
         xhjPHvRirKiE7g/VPvk2Vd3F5PK83y30jymjcA4bpLwyJ0Dal9Zc40eLtHCCzCQgmp
         vdV3zNweTpsNA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 72/79] mqueue: switch to new ctime accessors
Date:   Wed, 21 Jun 2023 10:46:25 -0400
Message-ID: <20230621144735.55953-71-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 ipc/mqueue.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 71881bddad25..dd8564be3894 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -302,7 +302,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
-	inode->i_mtime = inode->i_ctime = inode->i_atime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 
 	if (S_ISREG(mode)) {
 		struct mqueue_inode_info *info;
@@ -596,7 +596,7 @@ static int mqueue_create_attr(struct dentry *dentry, umode_t mode, void *arg)
 
 	put_ipc_ns(ipc_ns);
 	dir->i_size += DIRENT_SIZE;
-	dir->i_ctime = dir->i_mtime = dir->i_atime = current_time(dir);
+	inode_ctime_set(dir, dir->i_mtime = dir->i_atime = current_time(dir));
 
 	d_instantiate(dentry, inode);
 	dget(dentry);
@@ -618,7 +618,7 @@ static int mqueue_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 
-	dir->i_ctime = dir->i_mtime = dir->i_atime = current_time(dir);
+	inode_ctime_set(dir, dir->i_mtime = dir->i_atime = current_time(dir));
 	dir->i_size -= DIRENT_SIZE;
 	drop_nlink(inode);
 	dput(dentry);
@@ -656,7 +656,7 @@ static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
 	if (ret <= 0)
 		return ret;
 
-	file_inode(filp)->i_atime = file_inode(filp)->i_ctime = current_time(file_inode(filp));
+	file_inode(filp)->i_atime = inode_ctime_set_current(file_inode(filp));
 	return ret;
 }
 
@@ -1162,8 +1162,7 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
 				goto out_unlock;
 			__do_notify(info);
 		}
-		inode->i_atime = inode->i_mtime = inode->i_ctime =
-				current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	}
 out_unlock:
 	spin_unlock(&info->lock);
@@ -1257,8 +1256,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 
 		msg_ptr = msg_get(info);
 
-		inode->i_atime = inode->i_mtime = inode->i_ctime =
-				current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 
 		/* There is now free space in queue. */
 		pipelined_receive(&wake_q, info);
@@ -1396,7 +1394,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 	if (notification == NULL) {
 		if (info->notify_owner == task_tgid(current)) {
 			remove_notification(info);
-			inode->i_atime = inode->i_ctime = current_time(inode);
+			inode->i_atime = inode_ctime_set_current(inode);
 		}
 	} else if (info->notify_owner != NULL) {
 		ret = -EBUSY;
@@ -1422,7 +1420,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 
 		info->notify_owner = get_pid(task_tgid(current));
 		info->notify_user_ns = get_user_ns(current_user_ns());
-		inode->i_atime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode_ctime_set_current(inode);
 	}
 	spin_unlock(&info->lock);
 out_fput:
@@ -1485,7 +1483,7 @@ static int do_mq_getsetattr(int mqdes, struct mq_attr *new, struct mq_attr *old)
 			f.file->f_flags &= ~O_NONBLOCK;
 		spin_unlock(&f.file->f_lock);
 
-		inode->i_atime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode_ctime_set_current(inode);
 	}
 
 	spin_unlock(&info->lock);
-- 
2.41.0

