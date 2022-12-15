Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E9664D893
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiLOJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiLOJ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:29:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AF746669;
        Thu, 15 Dec 2022 01:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=edlW2xfA2QHeHNZ6KkGM6URZHwgsPvQgRUxm+S1DUQo=; b=ELFgGpIX3unGSx5AlmPmG58rjV
        7W0ygd8BM7vJDR4B1cFdELKHqqddXiN+cxe2fG+jk+lNKfVL7cVx9o90Z9MUTzA1bEh26KTHwtWTw
        wRKCfUGUEAmR46tX3xRaS90/gbKMoOJ4+8tRWNFNNhZYiyqwtdxuvMSpkVtDPY6Egp+pBlsTf0Htn
        waSqMFM2ZMWMzjth8HbUJasLYMPjF/eXs9ko6Xs9qhBwOyjzmB5pXF1yHFIZnDGAzJ2/rWNxFvx6q
        64gyF4Z3QmCqBBW7ebezYn/znpPFjeNj6xQumVhNtTazPV22C9O36R5M9uUU6DGU3EMf76RgdpCWs
        x/HORjjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5kXy-008GTg-Kq; Thu, 15 Dec 2022 09:28:58 +0000
Date:   Thu, 15 Dec 2022 01:28:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/21] block, blksnap: module management interface
 functions
Message-ID: <Y5ro2qv8pxGQ5bTN@infradead.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-7-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-7-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	ret = register_chrdev(0, THIS_MODULE->name, &ctrl_fops);

This crashed when blksnap is built into the kernel because THIS_MODULE
is NULL for that case.

But I think most of this boilerplate can be removed - just use a misc
device and use /proc/misc to find the major from userspace if anything
cares, but nothing should as the misc devices already create the
node through udev.  I.e.g:

diff --git a/drivers/block/blksnap/Makefile b/drivers/block/blksnap/Makefile
index b196b17f9d9d97..cbcac12cc61d59 100644
--- a/drivers/block/blksnap/Makefile
+++ b/drivers/block/blksnap/Makefile
@@ -12,7 +12,6 @@ blksnap-y := 		\
 	main.o		\
 	snapimage.o	\
 	snapshot.o	\
-	sysfs.o		\
 	tracker.o
 
 obj-$(CONFIG_BLK_SNAP)	 += blksnap.o
diff --git a/drivers/block/blksnap/ctrl.c b/drivers/block/blksnap/ctrl.c
index 990ffb004db3f9..d1a5e3a13a19be 100644
--- a/drivers/block/blksnap/ctrl.c
+++ b/drivers/block/blksnap/ctrl.c
@@ -5,6 +5,7 @@
 #include <linux/poll.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/miscdevice.h>
 #include <uapi/linux/blksnap.h>
 #include "ctrl.h"
 #include "params.h"
@@ -16,16 +17,6 @@
 static_assert(sizeof(uuid_t) == sizeof(struct blk_snap_uuid),
 	"Invalid size of struct blk_snap_uuid or uuid_t.");
 
-static int blk_snap_major;
-
-static long ctrl_unlocked_ioctl(struct file *filp, unsigned int cmd,
-				unsigned long arg);
-
-static const struct file_operations ctrl_fops = {
-	.owner = THIS_MODULE,
-	.unlocked_ioctl = ctrl_unlocked_ioctl,
-};
-
 static const struct blk_snap_version version = {
 	.major = VERSION_MAJOR,
 	.minor = VERSION_MINOR,
@@ -33,34 +24,6 @@ static const struct blk_snap_version version = {
 	.build = VERSION_BUILD,
 };
 
-int get_blk_snap_major(void)
-{
-	return blk_snap_major;
-}
-
-int ctrl_init(void)
-{
-	int ret;
-
-	ret = register_chrdev(0, THIS_MODULE->name, &ctrl_fops);
-	if (ret < 0) {
-		pr_err("Failed to register a character device. errno=%d\n",
-		       abs(blk_snap_major));
-		return ret;
-	}
-
-	blk_snap_major = ret;
-	pr_info("Register control device [%d:0].\n", blk_snap_major);
-	return 0;
-}
-
-void ctrl_done(void)
-{
-	pr_info("Unregister control device\n");
-
-	unregister_chrdev(blk_snap_major, THIS_MODULE->name);
-}
-
 static int ioctl_version(unsigned long arg)
 {
 	if (copy_to_user((void *)arg, &version, sizeof(version))) {
@@ -408,3 +371,24 @@ static long ctrl_unlocked_ioctl(struct file *filp, unsigned int cmd,
 
 	return blk_snap_ioctl_table[nr](arg);
 }
+
+static const struct file_operations blksnap_ctrl_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= ctrl_unlocked_ioctl,
+};
+
+static struct miscdevice blksnap_ctrl_misc = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "blksnap-control",
+	.fops		= &blksnap_ctrl_fops,
+};
+
+int ctrl_init(void)
+{
+	return misc_register(&blksnap_ctrl_misc);
+}
+
+void ctrl_done(void)
+{
+	misc_deregister(&blksnap_ctrl_misc);
+}
diff --git a/drivers/block/blksnap/ctrl.h b/drivers/block/blksnap/ctrl.h
index ade3f1cf57e90c..88f4b05296e575 100644
--- a/drivers/block/blksnap/ctrl.h
+++ b/drivers/block/blksnap/ctrl.h
@@ -2,8 +2,6 @@
 #ifndef __BLK_SNAP_CTRL_H
 #define __BLK_SNAP_CTRL_H
 
-int get_blk_snap_major(void);
-
 int ctrl_init(void);
 void ctrl_done(void);
 #endif /* __BLK_SNAP_CTRL_H */
diff --git a/drivers/block/blksnap/main.c b/drivers/block/blksnap/main.c
index a7939efc6497b9..f8b6f5c406ed7c 100644
--- a/drivers/block/blksnap/main.c
+++ b/drivers/block/blksnap/main.c
@@ -6,7 +6,6 @@
 #include "version.h"
 #include "params.h"
 #include "ctrl.h"
-#include "sysfs.h"
 #include "snapimage.h"
 #include "snapshot.h"
 #include "tracker.h"
@@ -44,8 +43,6 @@ static int __init blk_snap_init(void)
 	result = ctrl_init();
 	if (result)
 		return result;
-
-	result = sysfs_initialize();
 	return result;
 }
 
@@ -53,7 +50,6 @@ static void __exit blk_snap_exit(void)
 {
 	pr_info("Unloading module\n");
 
-	sysfs_finalize();
 	ctrl_done();
 
 	diff_io_done();
diff --git a/drivers/block/blksnap/sysfs.c b/drivers/block/blksnap/sysfs.c
deleted file mode 100644
index 6f53c4217d6c7b..00000000000000
--- a/drivers/block/blksnap/sysfs.c
+++ /dev/null
@@ -1,80 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define pr_fmt(fmt) KBUILD_MODNAME "-sysfs: " fmt
-
-#include <linux/module.h>
-#include <linux/blkdev.h>
-#include <linux/sysfs.h>
-#include <linux/device.h>
-#include <uapi/linux/blksnap.h>
-#include "sysfs.h"
-#include "ctrl.h"
-
-static ssize_t major_show(struct class *class, struct class_attribute *attr,
-			  char *buf)
-{
-	sprintf(buf, "%d", get_blk_snap_major());
-	return strlen(buf);
-}
-
-/* Declare class_attr_major */
-CLASS_ATTR_RO(major);
-
-static struct class *blk_snap_class;
-
-static struct device *blk_snap_device;
-
-int sysfs_initialize(void)
-{
-	struct device *dev;
-	int res;
-
-	blk_snap_class = class_create(THIS_MODULE, THIS_MODULE->name);
-	if (IS_ERR(blk_snap_class)) {
-		res = PTR_ERR(blk_snap_class);
-
-		pr_err("Bad class create. errno=%d\n", abs(res));
-		return res;
-	}
-
-	pr_info("Create 'major' sysfs attribute\n");
-	res = class_create_file(blk_snap_class, &class_attr_major);
-	if (res) {
-		pr_err("Failed to create 'major' sysfs file\n");
-
-		class_destroy(blk_snap_class);
-		blk_snap_class = NULL;
-		return res;
-	}
-
-	dev = device_create(blk_snap_class, NULL,
-			    MKDEV(get_blk_snap_major(), 0), NULL,
-			    THIS_MODULE->name);
-	if (IS_ERR(dev)) {
-		res = PTR_ERR(dev);
-		pr_err("Failed to create device, errno=%d\n", abs(res));
-
-		class_remove_file(blk_snap_class, &class_attr_major);
-		class_destroy(blk_snap_class);
-		blk_snap_class = NULL;
-		return res;
-	}
-
-	blk_snap_device = dev;
-	return res;
-}
-
-void sysfs_finalize(void)
-{
-	pr_info("Cleanup sysfs\n");
-
-	if (blk_snap_device) {
-		device_unregister(blk_snap_device);
-		blk_snap_device = NULL;
-	}
-
-	if (blk_snap_class != NULL) {
-		class_remove_file(blk_snap_class, &class_attr_major);
-		class_destroy(blk_snap_class);
-		blk_snap_class = NULL;
-	}
-}
diff --git a/drivers/block/blksnap/sysfs.h b/drivers/block/blksnap/sysfs.h
deleted file mode 100644
index 5fc200d3678964..00000000000000
--- a/drivers/block/blksnap/sysfs.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __BLK_SNAP_SYSFS_H
-#define __BLK_SNAP_SYSFS_H
-
-int sysfs_initialize(void);
-void sysfs_finalize(void);
-#endif /* __BLK_SNAP_SYSFS_H */
