Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FEF6546C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiLVTk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLVTky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:40:54 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D51388D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:40:53 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1p8RQy-0004XZ-02;
        Thu, 22 Dec 2022 20:40:52 +0100
Date:   Thu, 22 Dec 2022 19:40:46 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Subject: [RFC PATCH] mtd: ubi: attach MTD partition from device-tree
Message-ID: <a547e14ac90af041e8135af5fed9272931dda463.1671738005.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split ubi_init() function into early function to be called by
device_initcall() and keep cmdline attachment in late_initcall().

Register MTD notifier and automatically attach MTD devices which are
marked as compatible with 'linux,ubi' in OF device-tree.

Keep behavior regarding ubiblock creation and attaching of UBI device
from kernel or module cmdline unchanged.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/block.c | 16 +++-----
 drivers/mtd/ubi/build.c | 85 ++++++++++++++++++++++++++++++++---------
 drivers/mtd/ubi/ubi.h   |  2 +
 3 files changed, 74 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index d725215ae66e5..cbdbf6578869e 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -619,7 +619,7 @@ open_volume_desc(const char *name, int ubi_num, int vol_id)
 		return ubi_open_volume(ubi_num, vol_id, UBI_READONLY);
 }
 
-static void __init ubiblock_create_from_param(void)
+void __init ubiblock_create_from_param(void)
 {
 	int i, ret = 0;
 	struct ubiblock_param *p;
@@ -648,9 +648,10 @@ static void __init ubiblock_create_from_param(void)
 
 		ret = ubiblock_create(&vi);
 		if (ret) {
-			pr_err(
-			       "UBI: block: can't add '%s' volume on ubi%d_%d, err=%d\n",
-			       vi.name, p->ubi_num, p->vol_id, ret);
+			if (ret != -EEXIST && ret != -ENOENT)
+				pr_err(
+				       "UBI: block: can't add '%s' volume on ubi%d_%d, err=%d\n",
+				       vi.name, p->ubi_num, p->vol_id, ret);
 			continue;
 		}
 	}
@@ -681,13 +682,6 @@ int __init ubiblock_init(void)
 	if (ubiblock_major < 0)
 		return ubiblock_major;
 
-	/*
-	 * Attach block devices from 'block=' module param.
-	 * Even if one block device in the param list fails to come up,
-	 * still allow the module to load and leave any others up.
-	 */
-	ubiblock_create_from_param();
-
 	/*
 	 * Block devices are only created upon user requests, so we ignore
 	 * existing volumes.
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 5e90a4423b699..9c5bd0524b9fe 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -27,6 +27,7 @@
 #include <linux/log2.h>
 #include <linux/kthread.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/major.h>
 #include "ubi.h"
@@ -1198,9 +1199,42 @@ static struct mtd_info * __init open_mtd_device(const char *mtd_dev)
 	return mtd;
 }
 
+static void __init ubi_notify_add(struct mtd_info *mtd)
+{
+	struct device_node *np = mtd_get_of_node(mtd);
+	int err;
+
+	if (!of_device_is_compatible(np, "linux,ubi"))
+		return;
+
+	mutex_lock(&ubi_devices_mutex);
+	err = ubi_attach_mtd_dev(mtd, UBI_DEV_NUM_AUTO, 0, 0, false);
+	mutex_unlock(&ubi_devices_mutex);
+	if (err >= 0)
+		ubiblock_create_from_param();
+}
+
+static void __init ubi_notify_remove(struct mtd_info *mtd)
+{
+	int i;
+
+	for (i = 0; i < UBI_MAX_DEVICES; i++)
+		if (ubi_devices[i]) {
+			mutex_lock(&ubi_devices_mutex);
+			if (ubi_devices[i]->mtd->index == mtd->index)
+				ubi_detach_mtd_dev(ubi_devices[i]->ubi_num, 1);
+			mutex_unlock(&ubi_devices_mutex);
+		}
+}
+
+static struct mtd_notifier ubi_mtd_notifier __initdata = {
+	.add = ubi_notify_add,
+	.remove = ubi_notify_remove,
+};
+
 static int __init ubi_init(void)
 {
-	int err, i, k;
+	int err;
 
 	/* Ensure that EC and VID headers have correct size */
 	BUILD_BUG_ON(sizeof(struct ubi_ec_hdr) != 64);
@@ -1235,6 +1269,33 @@ static int __init ubi_init(void)
 	if (err)
 		goto out_slab;
 
+	err = ubiblock_init();
+	if (err) {
+		pr_err("UBI error: block: cannot initialize, error %d\n", err);
+
+		/* See comment above re-ubi_is_module(). */
+		if (ubi_is_module())
+			goto out_slab;
+	}
+
+	register_mtd_user(&ubi_mtd_notifier);
+
+	return 0;
+out_slab:
+	kmem_cache_destroy(ubi_wl_entry_slab);
+out_dev_unreg:
+	misc_deregister(&ubi_ctrl_cdev);
+out:
+	class_unregister(&ubi_class);
+	pr_err("UBI error: cannot initialize UBI, error %d\n", err);
+
+	return err;
+}
+device_initcall(ubi_init);
+
+static int __init ubi_init_attach(void)
+{
+	int err, i, k;
 
 	/* Attach MTD devices */
 	for (i = 0; i < mtd_devs; i++) {
@@ -1282,14 +1343,10 @@ static int __init ubi_init(void)
 		}
 	}
 
-	err = ubiblock_init();
-	if (err) {
-		pr_err("UBI error: block: cannot initialize, error %d\n", err);
-
-		/* See comment above re-ubi_is_module(). */
-		if (ubi_is_module())
-			goto out_detach;
-	}
+	/*
+	 * Attach block devices from 'block=' module param.
+	 */
+	ubiblock_create_from_param();
 
 	return 0;
 
@@ -1300,17 +1357,9 @@ static int __init ubi_init(void)
 			ubi_detach_mtd_dev(ubi_devices[k]->ubi_num, 1);
 			mutex_unlock(&ubi_devices_mutex);
 		}
-	ubi_debugfs_exit();
-out_slab:
-	kmem_cache_destroy(ubi_wl_entry_slab);
-out_dev_unreg:
-	misc_deregister(&ubi_ctrl_cdev);
-out:
-	class_unregister(&ubi_class);
-	pr_err("UBI error: cannot initialize UBI, error %d\n", err);
 	return err;
 }
-late_initcall(ubi_init);
+late_initcall(ubi_init_attach);
 
 static void __exit ubi_exit(void)
 {
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index c8f1bd4fa1008..ad8593b8ad17e 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -976,11 +976,13 @@ static inline void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol) {}
 
 /* block.c */
 #ifdef CONFIG_MTD_UBI_BLOCK
+void ubiblock_create_from_param(void);
 int ubiblock_init(void);
 void ubiblock_exit(void);
 int ubiblock_create(struct ubi_volume_info *vi);
 int ubiblock_remove(struct ubi_volume_info *vi);
 #else
+static inline void ubiblock_create_from_param(void) {}
 static inline int ubiblock_init(void) { return 0; }
 static inline void ubiblock_exit(void) {}
 static inline int ubiblock_create(struct ubi_volume_info *vi)

base-commit: e45fb347b630ee76482fe938ba76cf8eab811290
-- 
2.39.0

