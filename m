Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C997370D5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjEWHqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbjEWHqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BEFE0;
        Tue, 23 May 2023 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4j+Tp8TcnUGqT/X9I2ry3tJxNtOyoD54dmfstpWfMBY=; b=g3WlkN9YuAgQfAWxcRvpyPoq0p
        zKY+ZIdk1LTGPSfbB5SRkaZiK1ld98FMzxsHtMyBdfj8zkjp/lj/RovRidn7+j5E0K1MrkbpuTSWS
        AzZ7A6V0vkAksP4mdxuQJ7PzCz+oY8bco+dEPScI0TXYwbtCpRdo2ruVlZdAxubdPqXYWjSDqduUZ
        8J88omX94t2v5HRD0RKPU+zcPUDDZFbsAr7RSv+i6NBIdC5QcwyqdWc/U3rQHmA6+QkLk4lzC0fPr
        QMNXJocjjbtveOUx8u6PIhwC7vAbKRu+04KdJi9x5quM6gIbi+lx1rtdQXf/cpIbee7h6XsvxK1bC
        aqUL7s/w==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1MiS-009Gce-39;
        Tue, 23 May 2023 07:45:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 07/24] init: refactor mount_root
Date:   Tue, 23 May 2023 09:45:18 +0200
Message-Id: <20230523074535.249802-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523074535.249802-1-hch@lst.de>
References: <20230523074535.249802-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide stubs for all the lower level mount helpers, and just switch
on ROOT_DEV in the main function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.c | 104 +++++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 48 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index a2c0baace0992c..e708b02d9d6566 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -453,15 +453,14 @@ void __init mount_root_generic(char *name, int flags)
 #define NFSROOT_TIMEOUT_MAX	30
 #define NFSROOT_RETRY_MAX	5
 
-static int __init mount_nfs_root(void)
+static void __init mount_nfs_root(void)
 {
 	char *root_dev, *root_data;
 	unsigned int timeout;
-	int try, err;
+	int try;
 
-	err = nfs_root_data(&root_dev, &root_data);
-	if (err != 0)
-		return 0;
+	if (nfs_root_data(&root_dev, &root_data))
+		goto fail;
 
 	/*
 	 * The server or network may not be ready, so try several
@@ -470,10 +469,8 @@ static int __init mount_nfs_root(void)
 	 */
 	timeout = NFSROOT_TIMEOUT_MIN;
 	for (try = 1; ; try++) {
-		err = do_mount_root(root_dev, "nfs",
-					root_mountflags, root_data);
-		if (err == 0)
-			return 1;
+		if (!do_mount_root(root_dev, "nfs", root_mountflags, root_data))
+			return;
 		if (try > NFSROOT_RETRY_MAX)
 			break;
 
@@ -483,9 +480,14 @@ static int __init mount_nfs_root(void)
 		if (timeout > NFSROOT_TIMEOUT_MAX)
 			timeout = NFSROOT_TIMEOUT_MAX;
 	}
-	return 0;
+fail:
+	pr_err("VFS: Unable to mount root fs via NFS.\n");
 }
-#endif
+#else
+static inline void mount_nfs_root(void)
+{
+}
+#endif /* CONFIG_ROOT_NFS */
 
 #ifdef CONFIG_CIFS_ROOT
 
@@ -495,22 +497,20 @@ extern int cifs_root_data(char **dev, char **opts);
 #define CIFSROOT_TIMEOUT_MAX	30
 #define CIFSROOT_RETRY_MAX	5
 
-static int __init mount_cifs_root(void)
+static void __init mount_cifs_root(void)
 {
 	char *root_dev, *root_data;
 	unsigned int timeout;
-	int try, err;
+	int try;
 
-	err = cifs_root_data(&root_dev, &root_data);
-	if (err != 0)
-		return 0;
+	if (cifs_root_data(&root_dev, &root_data))
+		goto fail;
 
 	timeout = CIFSROOT_TIMEOUT_MIN;
 	for (try = 1; ; try++) {
-		err = do_mount_root(root_dev, "cifs", root_mountflags,
-				    root_data);
-		if (err == 0)
-			return 1;
+		if (!do_mount_root(root_dev, "cifs", root_mountflags,
+				   root_data))
+			return;
 		if (try > CIFSROOT_RETRY_MAX)
 			break;
 
@@ -519,9 +519,14 @@ static int __init mount_cifs_root(void)
 		if (timeout > CIFSROOT_TIMEOUT_MAX)
 			timeout = CIFSROOT_TIMEOUT_MAX;
 	}
-	return 0;
+fail:
+	pr_err("VFS: Unable to mount root fs via SMB.\n");
 }
-#endif
+#else
+static inline void mount_cifs_root(void)
+{
+}
+#endif /* CONFIG_CIFS_ROOT */
 
 static bool __init fs_is_nodev(char *fstype)
 {
@@ -563,35 +568,38 @@ static int __init mount_nodev_root(void)
 	return err;
 }
 
-void __init mount_root(void)
-{
-#ifdef CONFIG_ROOT_NFS
-	if (ROOT_DEV == Root_NFS) {
-		if (!mount_nfs_root())
-			printk(KERN_ERR "VFS: Unable to mount root fs via NFS.\n");
-		return;
-	}
-#endif
-#ifdef CONFIG_CIFS_ROOT
-	if (ROOT_DEV == Root_CIFS) {
-		if (!mount_cifs_root())
-			printk(KERN_ERR "VFS: Unable to mount root fs via SMB.\n");
-		return;
-	}
-#endif
-	if (ROOT_DEV == 0 && root_device_name && root_fs_names) {
-		if (mount_nodev_root() == 0)
-			return;
-	}
 #ifdef CONFIG_BLOCK
-	{
-		int err = create_dev("/dev/root", ROOT_DEV);
+static void __init mount_block_root(void)
+{
+	int err = create_dev("/dev/root", ROOT_DEV);
+
+	if (err < 0)
+		pr_emerg("Failed to create /dev/root: %d\n", err);
+	mount_root_generic("/dev/root", root_mountflags);
+}
+#else
+static inline void mount_block_root(void)
+{
+}
+#endif /* CONFIG_BLOCK */
 
-		if (err < 0)
-			pr_emerg("Failed to create /dev/root: %d\n", err);
-		mount_root_generic("/dev/root", root_mountflags);
+void __init mount_root(void)
+{
+	switch (ROOT_DEV) {
+	case Root_NFS:
+		mount_nfs_root();
+		break;
+	case Root_CIFS:
+		mount_cifs_root();
+		break;
+	case 0:
+		if (root_device_name && root_fs_names && mount_nodev_root() == 0)
+			break;
+		fallthrough;
+	default:
+		mount_block_root();
+		break;
 	}
-#endif
 }
 
 /*
-- 
2.39.2

