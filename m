Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E2070D5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjEWHqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjEWHqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48943CD;
        Tue, 23 May 2023 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NuqUt/SA0tArkg7W1LEJGmKUOec797sU9VTyk7THy0c=; b=jK/iZN7bp8bIaLZwCaLCJWeWgm
        1dkvnK5NgJ7Q7VL/hcbjQUA+5HqmuPcfj3JcVfZgf2t8ZGbmEJyXzsfynf4731n9B25kdcNH0tq56
        PvLw8rMVEC5S20bKx0hoCqF1BQF79t8UsFO30SPSnNjhrLRNazMFPaysfBFO+Rb6byZXeIt1pqN/i
        3Ea4GJMFBlrGoSo3pkWAGIGBlXn2JkANuY1MSqFqmdOMmqYy/Pw3YfiYc1ns/zZ3LCNwvo5NrOJXC
        /47TyNt1o/yXIvlyW45GiQPWl3ROCSZu+BPoIpnQoUYPybFY0lTW7DcJv+FOSWA4kIjVBYXUMk3gr
        D69RZYZg==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1MiV-009Gf8-1x;
        Tue, 23 May 2023 07:46:00 +0000
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
Subject: [PATCH 08/24] init: pass root_device_name explicitly
Date:   Tue, 23 May 2023 09:45:19 +0200
Message-Id: <20230523074535.249802-9-hch@lst.de>
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

Instead of declaring root_device_name as a global variable pass it as an
argument to the funtions using it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.c        | 29 ++++++++++++++++-------------
 init/do_mounts.h        | 14 +++++++-------
 init/do_mounts_initrd.c | 11 ++++++-----
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index e708b02d9d6566..1405ee7218bf00 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -28,7 +28,6 @@
 #include "do_mounts.h"
 
 int root_mountflags = MS_RDONLY | MS_SILENT;
-static char * __initdata root_device_name;
 static char __initdata saved_root_name[64];
 static int root_wait;
 
@@ -391,7 +390,7 @@ static int __init do_mount_root(const char *name, const char *fs,
 	return ret;
 }
 
-void __init mount_root_generic(char *name, int flags)
+void __init mount_root_generic(char *name, char *pretty_name, int flags)
 {
 	struct page *page = alloc_page(GFP_KERNEL);
 	char *fs_names = page_address(page);
@@ -425,7 +424,7 @@ void __init mount_root_generic(char *name, int flags)
 		 * and give them a list of the available devices
 		 */
 		printk("VFS: Cannot open root device \"%s\" or %s: error %d\n",
-				root_device_name, b, err);
+				pretty_name, b, err);
 		printk("Please append a correct \"root=\" boot option; here are the available partitions:\n");
 
 		printk_all_partitions();
@@ -541,7 +540,7 @@ static bool __init fs_is_nodev(char *fstype)
 	return ret;
 }
 
-static int __init mount_nodev_root(void)
+static int __init mount_nodev_root(char *root_device_name)
 {
 	char *fs_names, *fstype;
 	int err = -EINVAL;
@@ -569,21 +568,21 @@ static int __init mount_nodev_root(void)
 }
 
 #ifdef CONFIG_BLOCK
-static void __init mount_block_root(void)
+static void __init mount_block_root(char *root_device_name)
 {
 	int err = create_dev("/dev/root", ROOT_DEV);
 
 	if (err < 0)
 		pr_emerg("Failed to create /dev/root: %d\n", err);
-	mount_root_generic("/dev/root", root_mountflags);
+	mount_root_generic("/dev/root", root_device_name, root_mountflags);
 }
 #else
-static inline void mount_block_root(void)
+static inline void mount_block_root(char *root_device_name)
 {
 }
 #endif /* CONFIG_BLOCK */
 
-void __init mount_root(void)
+void __init mount_root(char *root_device_name)
 {
 	switch (ROOT_DEV) {
 	case Root_NFS:
@@ -593,11 +592,12 @@ void __init mount_root(void)
 		mount_cifs_root();
 		break;
 	case 0:
-		if (root_device_name && root_fs_names && mount_nodev_root() == 0)
+		if (root_device_name && root_fs_names &&
+		    mount_nodev_root(root_device_name) == 0)
 			break;
 		fallthrough;
 	default:
-		mount_block_root();
+		mount_block_root(root_device_name);
 		break;
 	}
 }
@@ -607,6 +607,8 @@ void __init mount_root(void)
  */
 void __init prepare_namespace(void)
 {
+	char *root_device_name;
+
 	if (root_delay) {
 		printk(KERN_INFO "Waiting %d sec before mounting root device...\n",
 		       root_delay);
@@ -628,7 +630,8 @@ void __init prepare_namespace(void)
 		root_device_name = saved_root_name;
 		if (!strncmp(root_device_name, "mtd", 3) ||
 		    !strncmp(root_device_name, "ubi", 3)) {
-			mount_root_generic(root_device_name, root_mountflags);
+			mount_root_generic(root_device_name, root_device_name,
+					   root_mountflags);
 			goto out;
 		}
 		ROOT_DEV = name_to_dev_t(root_device_name);
@@ -636,7 +639,7 @@ void __init prepare_namespace(void)
 			root_device_name += 5;
 	}
 
-	if (initrd_load())
+	if (initrd_load(root_device_name))
 		goto out;
 
 	/* wait for any asynchronous scanning to complete */
@@ -649,7 +652,7 @@ void __init prepare_namespace(void)
 		async_synchronize_full();
 	}
 
-	mount_root();
+	mount_root(root_device_name);
 out:
 	devtmpfs_mount();
 	init_mount(".", "/", NULL, MS_MOVE, NULL);
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 33623025f6951a..15e372b00ce704 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -10,8 +10,8 @@
 #include <linux/root_dev.h>
 #include <linux/init_syscalls.h>
 
-void  mount_root_generic(char *name, int flags);
-void  mount_root(void);
+void  mount_root_generic(char *name, char *pretty_name, int flags);
+void  mount_root(char *root_device_name);
 extern int root_mountflags;
 
 static inline __init int create_dev(char *name, dev_t dev)
@@ -33,11 +33,11 @@ static inline int rd_load_image(char *from) { return 0; }
 #endif
 
 #ifdef CONFIG_BLK_DEV_INITRD
-
-bool __init initrd_load(void);
-
+bool __init initrd_load(char *root_device_name);
 #else
-
-static inline bool initrd_load(void) { return false; }
+static inline bool initrd_load(char *root_device_name)
+{
+	return false;
+	}
 
 #endif
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 686d1ff3af4bb1..425f4bcf4b77e0 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -83,7 +83,7 @@ static int __init init_linuxrc(struct subprocess_info *info, struct cred *new)
 	return 0;
 }
 
-static void __init handle_initrd(void)
+static void __init handle_initrd(char *root_device_name)
 {
 	struct subprocess_info *info;
 	static char *argv[] = { "linuxrc", NULL, };
@@ -95,7 +95,8 @@ static void __init handle_initrd(void)
 	real_root_dev = new_encode_dev(ROOT_DEV);
 	create_dev("/dev/root.old", Root_RAM0);
 	/* mount initrd on rootfs' /root */
-	mount_root_generic("/dev/root.old", root_mountflags & ~MS_RDONLY);
+	mount_root_generic("/dev/root.old", root_device_name,
+			   root_mountflags & ~MS_RDONLY);
 	init_mkdir("/old", 0700);
 	init_chdir("/old");
 
@@ -117,7 +118,7 @@ static void __init handle_initrd(void)
 
 	init_chdir("/");
 	ROOT_DEV = new_decode_dev(real_root_dev);
-	mount_root();
+	mount_root(root_device_name);
 
 	printk(KERN_NOTICE "Trying to move old root to /initrd ... ");
 	error = init_mount("/old", "/root/initrd", NULL, MS_MOVE, NULL);
@@ -133,7 +134,7 @@ static void __init handle_initrd(void)
 	}
 }
 
-bool __init initrd_load(void)
+bool __init initrd_load(char *root_device_name)
 {
 	if (mount_initrd) {
 		create_dev("/dev/ram", Root_RAM0);
@@ -145,7 +146,7 @@ bool __init initrd_load(void)
 		 */
 		if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
 			init_unlink("/initrd.image");
-			handle_initrd();
+			handle_initrd(root_device_name);
 			return true;
 		}
 	}
-- 
2.39.2

