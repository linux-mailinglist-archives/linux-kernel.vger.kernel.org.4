Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC65FD3AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiJMEGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJMEGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:06:05 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A9FD100BCC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:06:02 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id F2E5C1E80D99;
        Thu, 13 Oct 2022 12:06:04 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AfHexhvLqMdh; Thu, 13 Oct 2022 12:06:02 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 0E21A1E80D90;
        Thu, 13 Oct 2022 12:06:02 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] orangefs: inode: Optimized variable usage in orangefs_* correlation functions
Date:   Thu, 13 Oct 2022 12:05:51 +0800
Message-Id: <20221013040551.277251-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are optimized as follows.
1. Remove some variables to initialize the assignment, they are assigned
first.
2. Removes the cast part of a variable assignment of type void*.
3. The orangefs_inode variable is directly assigned at the definition.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/orangefs/inode.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 7a8c0c6e698d..ea557b3b989e 100644
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
@@ -1021,7 +1021,7 @@ static inline ino_t orangefs_handle_hash(struct orangefs_object_kref *ref)
  */
 static int orangefs_set_inode(struct inode *inode, void *data)
 {
-	struct orangefs_object_kref *ref = (struct orangefs_object_kref *) data;
+	struct orangefs_object_kref *ref = data;
 	ORANGEFS_I(inode)->refn.fs_id = ref->fs_id;
 	ORANGEFS_I(inode)->refn.khandle = ref->khandle;
 	ORANGEFS_I(inode)->attr_valid = 0;
@@ -1036,10 +1036,9 @@ static int orangefs_set_inode(struct inode *inode, void *data)
  */
 static int orangefs_test_inode(struct inode *inode, void *data)
 {
-	struct orangefs_object_kref *ref = (struct orangefs_object_kref *) data;
-	struct orangefs_inode_s *orangefs_inode = NULL;
+	struct orangefs_object_kref *ref = data;
+	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 
-	orangefs_inode = ORANGEFS_I(inode);
 	/* test handles and fs_ids... */
 	return (!ORANGEFS_khandle_cmp(&(orangefs_inode->refn.khandle),
 				&(ref->khandle)) &&
@@ -1056,7 +1055,7 @@ static int orangefs_test_inode(struct inode *inode, void *data)
 struct inode *orangefs_iget(struct super_block *sb,
 		struct orangefs_object_kref *ref)
 {
-	struct inode *inode = NULL;
+	struct inode *inode;
 	unsigned long hash;
 	int error;
 
-- 
2.18.2

