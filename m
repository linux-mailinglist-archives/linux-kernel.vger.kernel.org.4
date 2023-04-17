Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82976E5388
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjDQU7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjDQU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:58:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62355B752
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 678CF62A46
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E86CC433D2;
        Mon, 17 Apr 2023 20:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681764996;
        bh=0+A/sy/nKjWGdM2ei3CM0vIESLpQzczKIP5odrvO/rI=;
        h=From:To:Cc:Subject:Date:From;
        b=N1XAB+9dQnTChAkENPua0gGLRD1ygRlXZAODcMKunV80KTpADPPha0Ms9qvO89yBP
         iZFljBQx+99yKfwsx0Bz02t8h0s+IYOEHXu0G/z9MNnErNFsyqv3wVMQwBwfjyaH/M
         GmDy0n3fgcz3yoXf0sPN1j6c0UtyiLOo2WLE1ubYP+vu9IBtPn2KvH3O1dMjn1hH6o
         mB1KWFdSbFPQjEm7RoXrYREQg4lj/dOAPxrWlhI3+RFCvJhiKD6hkxlXHp55mWZPWH
         mccVhdsGyG+/GEdkjhfp27vMD8AvB8r2xXnMdQ39drve81rc8/mVksozX+h1r/WlH5
         nUpO064QicxEg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: reduce ioctl stack usage
Date:   Mon, 17 Apr 2023 22:56:24 +0200
Message-Id: <20230417205631.1956027-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

On 32-bit architectures with KASAN_STACK enabled, the total stack usage
of the ocfs2_ioctl function grows beyond the warning limit:

fs/ocfs2/ioctl.c: In function 'ocfs2_ioctl':
fs/ocfs2/ioctl.c:934:1: error: the frame size of 1448 bytes is larger than 1400 bytes [-Werror=frame-larger-than=]

Move each of the variables into a basic block, and mark ocfs2_info_handle()
as noinline_for_stack, in order to have the variable share stack slots.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ocfs2/ioctl.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index 811a6ea374bb..b1550ba73f96 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -803,8 +803,8 @@ static int ocfs2_get_request_ptr(struct ocfs2_info *info, int idx,
  * a better backward&forward compatibility, since a small piece of
  * request will be less likely to be broken if disk layout get changed.
  */
-static int ocfs2_info_handle(struct inode *inode, struct ocfs2_info *info,
-			     int compat_flag)
+static noinline_for_stack int
+ocfs2_info_handle(struct inode *inode, struct ocfs2_info *info, int compat_flag)
 {
 	int i, status = 0;
 	u64 req_addr;
@@ -840,27 +840,26 @@ static int ocfs2_info_handle(struct inode *inode, struct ocfs2_info *info,
 long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	int new_clusters;
-	int status;
-	struct ocfs2_space_resv sr;
-	struct ocfs2_new_group_input input;
-	struct reflink_arguments args;
-	const char __user *old_path;
-	const char __user *new_path;
-	bool preserve;
-	struct ocfs2_info info;
 	void __user *argp = (void __user *)arg;
+	int status;
 
 	switch (cmd) {
 	case OCFS2_IOC_RESVSP:
 	case OCFS2_IOC_RESVSP64:
 	case OCFS2_IOC_UNRESVSP:
 	case OCFS2_IOC_UNRESVSP64:
+	{
+		struct ocfs2_space_resv sr;
+
 		if (copy_from_user(&sr, (int __user *) arg, sizeof(sr)))
 			return -EFAULT;
 
 		return ocfs2_change_file_space(filp, cmd, &sr);
+	}
 	case OCFS2_IOC_GROUP_EXTEND:
+	{
+		int new_clusters;
+
 		if (!capable(CAP_SYS_RESOURCE))
 			return -EPERM;
 
@@ -873,8 +872,12 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		status = ocfs2_group_extend(inode, new_clusters);
 		mnt_drop_write_file(filp);
 		return status;
+	}
 	case OCFS2_IOC_GROUP_ADD:
 	case OCFS2_IOC_GROUP_ADD64:
+	{
+		struct ocfs2_new_group_input input;
+
 		if (!capable(CAP_SYS_RESOURCE))
 			return -EPERM;
 
@@ -887,7 +890,14 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		status = ocfs2_group_add(inode, &input);
 		mnt_drop_write_file(filp);
 		return status;
+	}
 	case OCFS2_IOC_REFLINK:
+	{
+		struct reflink_arguments args;
+		const char __user *old_path;
+		const char __user *new_path;
+		bool preserve;
+
 		if (copy_from_user(&args, argp, sizeof(args)))
 			return -EFAULT;
 		old_path = (const char __user *)(unsigned long)args.old_path;
@@ -895,11 +905,16 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		preserve = (args.preserve != 0);
 
 		return ocfs2_reflink_ioctl(inode, old_path, new_path, preserve);
+	}
 	case OCFS2_IOC_INFO:
+	{
+		struct ocfs2_info info;
+
 		if (copy_from_user(&info, argp, sizeof(struct ocfs2_info)))
 			return -EFAULT;
 
 		return ocfs2_info_handle(inode, &info, 0);
+	}
 	case FITRIM:
 	{
 		struct super_block *sb = inode->i_sb;
-- 
2.39.2

