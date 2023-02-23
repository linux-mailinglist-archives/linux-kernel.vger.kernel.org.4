Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DBF6A034D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjBWHdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWHdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:33:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1DB3ABC;
        Wed, 22 Feb 2023 23:33:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B84DA61486;
        Thu, 23 Feb 2023 07:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01211C433D2;
        Thu, 23 Feb 2023 07:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677137612;
        bh=YLGNpiKGKeQXS7cWFQgkghK8DLlHfbcET0IszUJPvQM=;
        h=From:To:Cc:Subject:Date:From;
        b=pP9fXt/tXJ1degBWfaPBvR4/7EIlfuAoEEitMXtixJh/D8a85c3sNDhf4CWUfxgDt
         1N3fLUncs1mzcXLhI3hU511eZAEbztQrX1k3TXomdFn0JMcBTjYvDJv3WxaCaMxGF2
         zuQSnrGO/xqMgXbj0w9EkefmQFYTEwsjsFC/9wQg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] driver core: remove CONFIG_SYSFS_DEPRECATED and CONFIG_SYSFS_DEPRECATED_V2
Date:   Thu, 23 Feb 2023 08:33:26 +0100
Message-Id: <20230223073326.2073220-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9765; i=gregkh@linuxfoundation.org; h=from:subject; bh=YLGNpiKGKeQXS7cWFQgkghK8DLlHfbcET0IszUJPvQM=; b=owGbwMvMwCRo6H6F97bub03G02pJDMnfxY7m7OyeIFhcc88tQj9uu4u9cu8yjpCnQi9ZnoV9nb2t bcPSjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIHUWGBTvnJ0ZP5zlZE553m50tNP SfotS1JwxzZQUbXj9ev3LelF/2cfwRUgvNjjBdAgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SYSFS_DEPRECATED was added in commit 88a22c985e35
("CONFIG_SYSFS_DEPRECATED") in 2006 to allow systems with older versions
of some tools (i.e. Fedora 3's version of udev) to boot properly.  Four
years later, in 2010, the option was attempted to be removed as most of
userspace should have been fixed up properly by then, but some kernel
developers clung to those old systems and refused to update, so we added
CONFIG_SYSFS_DEPRECATED_V2 in commit e52eec13cd6b ("SYSFS: Allow boot
time switching between deprecated and modern sysfs layout") to allow
them to continue to boot properly, and we allowed a boot time parameter
to be used to switch back to the old format if needed.

Over time, the logic that was covered under these config options was
slowly removed from individual driver subsystems successfully, removed,
and the only thing that is now left in the kernel are some changes in
the block layer's representation in sysfs where real directories are
used instead of symlinks like normal.

Because the original changes were done to userspace tools in 2006, and
all distros that use those tools are long end-of-life, and older
non-udev-based systems do not care about the block layer's sysfs
representation, it is time to finally remove this old logic and the
config entries from the kernel.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-block@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../admin-guide/kernel-parameters.txt         |  9 -----
 block/genhd.c                                 | 19 ++++------
 drivers/base/class.c                          |  2 +-
 drivers/base/core.c                           | 37 ------------------
 include/linux/device.h                        |  6 ---
 init/Kconfig                                  | 38 -------------------
 6 files changed, 8 insertions(+), 103 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..65a741732b04 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6101,15 +6101,6 @@
 			later by a loaded module cannot be set this way.
 			Example: sysctl.vm.swappiness=40
 
-	sysfs.deprecated=0|1 [KNL]
-			Enable/disable old style sysfs layout for old udev
-			on older distributions. When this option is enabled
-			very new udev will not work anymore. When this option
-			is disabled (or CONFIG_SYSFS_DEPRECATED not compiled)
-			in older udev will not work anymore.
-			Default depends on CONFIG_SYSFS_DEPRECATED_V2 set in
-			the kernel configuration.
-
 	sysrq_always_enabled
 			[KNL]
 			Ignore sysrq setting - this boot parameter will
diff --git a/block/genhd.c b/block/genhd.c
index 09f2ac548832..45b9a81d2de2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -452,12 +452,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	if (ret)
 		goto out_device_del;
 
-	if (!sysfs_deprecated) {
-		ret = sysfs_create_link(block_depr, &ddev->kobj,
-					kobject_name(&ddev->kobj));
-		if (ret)
-			goto out_device_del;
-	}
+	ret = sysfs_create_link(block_depr, &ddev->kobj,
+				kobject_name(&ddev->kobj));
+	if (ret)
+		goto out_device_del;
 
 	/*
 	 * avoid probable deadlock caused by allocating memory with
@@ -535,8 +533,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 out_del_integrity:
 	blk_integrity_del(disk);
 out_del_block_link:
-	if (!sysfs_deprecated)
-		sysfs_remove_link(block_depr, dev_name(ddev));
+	sysfs_remove_link(block_depr, dev_name(ddev));
 out_device_del:
 	device_del(ddev);
 out_free_ext_minor:
@@ -638,8 +635,7 @@ void del_gendisk(struct gendisk *disk)
 
 	part_stat_set_all(disk->part0, 0);
 	disk->part0->bd_stamp = 0;
-	if (!sysfs_deprecated)
-		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
+	sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
 	device_del(disk_to_dev(disk));
 
@@ -893,8 +889,7 @@ static int __init genhd_device_init(void)
 	register_blkdev(BLOCK_EXT_MAJOR, "blkext");
 
 	/* create top-level block dir */
-	if (!sysfs_deprecated)
-		block_depr = kobject_create_and_add("block", NULL);
+	block_depr = kobject_create_and_add("block", NULL);
 	return 0;
 }
 
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 2373b3e210d8..fb8f2a1e1c19 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -180,7 +180,7 @@ int __class_register(struct class *cls, struct lock_class_key *key)
 
 #if defined(CONFIG_BLOCK)
 	/* let the block class directory show up in the root of sysfs */
-	if (!sysfs_deprecated || cls != &block_class)
+	if (cls != &block_class)
 		cp->subsys.kobj.kset = class_kset;
 #else
 	cp->subsys.kobj.kset = class_kset;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index f9297c68214a..64b9fd960342 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -36,19 +36,6 @@
 #include "physical_location.h"
 #include "power/power.h"
 
-#ifdef CONFIG_SYSFS_DEPRECATED
-#ifdef CONFIG_SYSFS_DEPRECATED_V2
-long sysfs_deprecated = 1;
-#else
-long sysfs_deprecated = 0;
-#endif
-static int __init sysfs_deprecated_setup(char *arg)
-{
-	return kstrtol(arg, 10, &sysfs_deprecated);
-}
-early_param("sysfs.deprecated", sysfs_deprecated_setup);
-#endif
-
 /* Device links support. */
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
@@ -3179,15 +3166,6 @@ static struct kobject *get_device_parent(struct device *dev,
 		struct kobject *parent_kobj;
 		struct kobject *k;
 
-#ifdef CONFIG_BLOCK
-		/* block disks show up in /sys/block */
-		if (sysfs_deprecated && dev->class == &block_class) {
-			if (parent && parent->class == &block_class)
-				return &parent->kobj;
-			return &block_class.p->subsys.kobj;
-		}
-#endif
-
 		/*
 		 * If we have no parent, we live in "virtual".
 		 * Class-devices with a non class-device as parent, live
@@ -3366,12 +3344,6 @@ static int device_add_class_symlinks(struct device *dev)
 			goto out_subsys;
 	}
 
-#ifdef CONFIG_BLOCK
-	/* /sys/block has directories and does not need symlinks */
-	if (sysfs_deprecated && dev->class == &block_class)
-		return 0;
-#endif
-
 	/* link in the class directory pointing to the device */
 	error = sysfs_create_link(&dev->class->p->subsys.kobj,
 				  &dev->kobj, dev_name(dev));
@@ -3401,10 +3373,6 @@ static void device_remove_class_symlinks(struct device *dev)
 	if (dev->parent && device_is_not_partition(dev))
 		sysfs_remove_link(&dev->kobj, "device");
 	sysfs_remove_link(&dev->kobj, "subsystem");
-#ifdef CONFIG_BLOCK
-	if (sysfs_deprecated && dev->class == &block_class)
-		return;
-#endif
 	sysfs_delete_link(&dev->class->p->subsys.kobj, &dev->kobj, dev_name(dev));
 }
 
@@ -4694,11 +4662,6 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 	if (error)
 		goto out;
 
-#ifdef CONFIG_BLOCK
-	if (sysfs_deprecated && dev->class == &block_class)
-		goto out;
-#endif
-
 	/*
 	 * Change the owner of the symlink located in the class directory of
 	 * the device class associated with @dev which points to the actual
diff --git a/include/linux/device.h b/include/linux/device.h
index 1508e637bb26..19b6ba478fbf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1092,10 +1092,4 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
 #define MODULE_ALIAS_CHARDEV_MAJOR(major) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-*")
 
-#ifdef CONFIG_SYSFS_DEPRECATED
-extern long sysfs_deprecated;
-#else
-#define sysfs_deprecated 0
-#endif
-
 #endif /* _DEVICE_H_ */
diff --git a/init/Kconfig b/init/Kconfig
index 44e90b28a30f..28be8621381e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1297,44 +1297,6 @@ config SCHED_AUTOGROUP
 	  desktop applications.  Task group autogeneration is currently based
 	  upon task session.
 
-config SYSFS_DEPRECATED
-	bool "Enable deprecated sysfs features to support old userspace tools"
-	depends on SYSFS
-	default n
-	help
-	  This option adds code that switches the layout of the "block" class
-	  devices, to not show up in /sys/class/block/, but only in
-	  /sys/block/.
-
-	  This switch is only active when the sysfs.deprecated=1 boot option is
-	  passed or the SYSFS_DEPRECATED_V2 option is set.
-
-	  This option allows new kernels to run on old distributions and tools,
-	  which might get confused by /sys/class/block/. Since 2007/2008 all
-	  major distributions and tools handle this just fine.
-
-	  Recent distributions and userspace tools after 2009/2010 depend on
-	  the existence of /sys/class/block/, and will not work with this
-	  option enabled.
-
-	  Only if you are using a new kernel on an old distribution, you might
-	  need to say Y here.
-
-config SYSFS_DEPRECATED_V2
-	bool "Enable deprecated sysfs features by default"
-	default n
-	depends on SYSFS
-	depends on SYSFS_DEPRECATED
-	help
-	  Enable deprecated sysfs by default.
-
-	  See the CONFIG_SYSFS_DEPRECATED option for more details about this
-	  option.
-
-	  Only if you are using a new kernel on an old distribution, you might
-	  need to say Y here. Even then, odds are you would not need it
-	  enabled, you can always pass the boot option if absolutely necessary.
-
 config RELAY
 	bool "Kernel->user space relay support (formerly relayfs)"
 	select IRQ_WORK
-- 
2.39.2

