Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C856024C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJRGxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJRGw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:52:57 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0C252DE3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:52:55 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 378E51E80D76;
        Tue, 18 Oct 2022 14:52:13 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rymyJ6sXaElW; Tue, 18 Oct 2022 14:52:10 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4226D1E80D17;
        Tue, 18 Oct 2022 14:52:10 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] orangefs: inode: Optimized orangefs* correlation function
Date:   Tue, 18 Oct 2022 14:52:47 +0800
Message-Id: <20221018065247.83191-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The orangefs* function has been optimized as follows.
1. Remove the initialization assignment of variables, which are assigned
first.
2. Remove void* associated variable cast.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/orangefs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 7a8c0c6e698d..54d47b9ad0db 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -719,7 +719,7 @@ static int orangefs_setattr_size(struct inode *inode, struct iattr *iattr)
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	struct orangefs_kernel_op_s *new_op;
 	loff_t orig_size;
-	int ret = -EINVAL;
+	int ret;
 
 	gossip_debug(GOSSIP_INODE_DEBUG,
 		     "%s: %pU: Handle is %pU | fs_id %d | size is %llu\n",
@@ -941,7 +941,7 @@ static int orangefs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 static int orangefs_fileattr_set(struct user_namespace *mnt_userns,
 				 struct dentry *dentry, struct fileattr *fa)
 {
-	u64 val = 0;
+	u64 val;
 
 	gossip_debug(GOSSIP_FILE_DEBUG, "%s: called on %pd\n", __func__,
 		     dentry);
@@ -1021,7 +1021,7 @@ static inline ino_t orangefs_handle_hash(struct orangefs_object_kref *ref)
  */
 static int orangefs_set_inode(struct inode *inode, void *data)
 {
-	struct orangefs_object_kref *ref = (struct orangefs_object_kref *) data;
+	struct orangefs_object_kref *ref = data;
 	ORANGEFS_I(inode)->refn.fs_id = ref->fs_id;
 	ORANGEFS_I(inode)->refn.khandle = ref->khandle;
 	ORANGEFS_I(inode)->attr_valid = 0;
@@ -1036,8 +1036,8 @@ static int orangefs_set_inode(struct inode *inode, void *data)
  */
 static int orangefs_test_inode(struct inode *inode, void *data)
 {
-	struct orangefs_object_kref *ref = (struct orangefs_object_kref *) data;
-	struct orangefs_inode_s *orangefs_inode = NULL;
+	struct orangefs_object_kref *ref = data;
+	struct orangefs_inode_s *orangefs_inode;
 
 	orangefs_inode = ORANGEFS_I(inode);
 	/* test handles and fs_ids... */
@@ -1056,7 +1056,7 @@ static int orangefs_test_inode(struct inode *inode, void *data)
 struct inode *orangefs_iget(struct super_block *sb,
 		struct orangefs_object_kref *ref)
 {
-	struct inode *inode = NULL;
+	struct inode *inode;
 	unsigned long hash;
 	int error;
 
-- 
2.18.2

