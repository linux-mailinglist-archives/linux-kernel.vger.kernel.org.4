Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564FD736D31
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjFTNXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjFTNWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:22:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432371739
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687267324; x=1718803324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N/5ArQUYGQfRH1L3tWdATWu4BWdx5d0l9hRBqqCWul4=;
  b=Ohbsun0nhnebXGpg5mJsk0EbhHYkoFIjSF+R92224bQqKq76IORg2Jvs
   UwU9tj6GUX5J/Nx6TeR2EcKXIRDbHlsjUTjh3vAgfr5irhlrxn2NzD3w/
   ptVd0spXD2HCpSo05nAvdA7be96uNdxMBUlJTDkimDk4i8BmbpzHnf8Gg
   Ezk6mwBnc63bqAZDXiw6TabouhrdpJTeaMpvXcivBmPxgRCwBN4qZSdVl
   +iElxDEOxm/t7pKdGIVhNJqbWbAGlFjxfiOdtfpd8hmBvKDnYIgEgdyYJ
   s00+kIQaavTLogabp6y/HfTYxrVALUyBBMDl6GfE1EQYz95/yia9yfgcb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349588289"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="349588289"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691426972"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="691426972"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 06:20:01 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] mtd: use refcount to prevent corruption
Date:   Tue, 20 Jun 2023 16:19:04 +0300
Message-Id: <20230620131905.648089-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620131905.648089-1-alexander.usyskin@intel.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

When underlying device is removed mtd core will crash
in case user space is holding open handle.
Need to use proper refcounting so device is release
only when has no users.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/mtd/mtdcore.c   | 72 ++++++++++++++++++++++-------------------
 drivers/mtd/mtdcore.h   |  1 +
 drivers/mtd/mtdpart.c   | 14 ++++----
 include/linux/mtd/mtd.h |  2 +-
 4 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index abf4cb58a8ab..84bd1878367d 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -93,10 +93,33 @@ static void mtd_release(struct device *dev)
 	struct mtd_info *mtd = dev_get_drvdata(dev);
 	dev_t index = MTD_DEVT(mtd->index);
 
+	if (mtd_is_partition(mtd))
+		release_mtd_partition(mtd);
+
 	/* remove /dev/mtdXro node */
 	device_destroy(&mtd_class, index + 1);
 }
 
+static void mtd_device_release(struct kref *kref)
+{
+	struct mtd_info *mtd = container_of(kref, struct mtd_info, refcnt);
+
+	debugfs_remove_recursive(mtd->dbg.dfs_dir);
+
+	/* Try to remove the NVMEM provider */
+	nvmem_unregister(mtd->nvmem);
+
+	device_unregister(&mtd->dev);
+
+	/* Clear dev so mtd can be safely re-registered later if desired */
+	memset(&mtd->dev, 0, sizeof(mtd->dev));
+
+	idr_remove(&mtd_idr, mtd->index);
+	of_node_put(mtd_get_of_node(mtd));
+
+	module_put(THIS_MODULE);
+}
+
 #define MTD_DEVICE_ATTR_RO(name) \
 static DEVICE_ATTR(name, 0444, mtd_##name##_show, NULL)
 
@@ -666,7 +689,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	}
 
 	mtd->index = i;
-	mtd->usecount = 0;
+	kref_init(&mtd->refcnt);
 
 	/* default value if not set by driver */
 	if (mtd->bitflip_threshold == 0)
@@ -779,7 +802,6 @@ int del_mtd_device(struct mtd_info *mtd)
 {
 	int ret;
 	struct mtd_notifier *not;
-	struct device_node *mtd_of_node;
 
 	mutex_lock(&mtd_table_mutex);
 
@@ -793,28 +815,8 @@ int del_mtd_device(struct mtd_info *mtd)
 	list_for_each_entry(not, &mtd_notifiers, list)
 		not->remove(mtd);
 
-	if (mtd->usecount) {
-		printk(KERN_NOTICE "Removing MTD device #%d (%s) with use count %d\n",
-		       mtd->index, mtd->name, mtd->usecount);
-		ret = -EBUSY;
-	} else {
-		mtd_of_node = mtd_get_of_node(mtd);
-		debugfs_remove_recursive(mtd->dbg.dfs_dir);
-
-		/* Try to remove the NVMEM provider */
-		nvmem_unregister(mtd->nvmem);
-
-		device_unregister(&mtd->dev);
-
-		/* Clear dev so mtd can be safely re-registered later if desired */
-		memset(&mtd->dev, 0, sizeof(mtd->dev));
-
-		idr_remove(&mtd_idr, mtd->index);
-		of_node_put(mtd_of_node);
-
-		module_put(THIS_MODULE);
-		ret = 0;
-	}
+	kref_put(&mtd->refcnt, mtd_device_release);
+	ret = 0;
 
 out_error:
 	mutex_unlock(&mtd_table_mutex);
@@ -1228,19 +1230,21 @@ int __get_mtd_device(struct mtd_info *mtd)
 	if (!try_module_get(master->owner))
 		return -ENODEV;
 
+	kref_get(&mtd->refcnt);
+
 	if (master->_get_device) {
 		err = master->_get_device(mtd);
 
 		if (err) {
+			kref_put(&mtd->refcnt, mtd_device_release);
 			module_put(master->owner);
 			return err;
 		}
 	}
 
-	master->usecount++;
-
 	while (mtd->parent) {
-		mtd->usecount++;
+		if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER) || mtd->parent != master)
+			kref_get(&mtd->parent->refcnt);
 		mtd = mtd->parent;
 	}
 
@@ -1327,18 +1331,20 @@ void __put_mtd_device(struct mtd_info *mtd)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 
-	while (mtd->parent) {
-		--mtd->usecount;
-		BUG_ON(mtd->usecount < 0);
-		mtd = mtd->parent;
-	}
+	while (mtd != master) {
+		struct mtd_info *parent = mtd->parent;
 
-	master->usecount--;
+		kref_put(&mtd->refcnt, mtd_device_release);
+		mtd = parent;
+	}
 
 	if (master->_put_device)
 		master->_put_device(master);
 
 	module_put(master->owner);
+
+	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER))
+		kref_put(&master->refcnt, mtd_device_release);
 }
 EXPORT_SYMBOL_GPL(__put_mtd_device);
 
diff --git a/drivers/mtd/mtdcore.h b/drivers/mtd/mtdcore.h
index b5eefeabf310..b014861a06a6 100644
--- a/drivers/mtd/mtdcore.h
+++ b/drivers/mtd/mtdcore.h
@@ -12,6 +12,7 @@ int __must_check add_mtd_device(struct mtd_info *mtd);
 int del_mtd_device(struct mtd_info *mtd);
 int add_mtd_partitions(struct mtd_info *, const struct mtd_partition *, int);
 int del_mtd_partitions(struct mtd_info *);
+void release_mtd_partition(struct mtd_info *mtd);
 
 struct mtd_partitions;
 
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index a46affbb037d..23483db8f30c 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -32,6 +32,12 @@ static inline void free_partition(struct mtd_info *mtd)
 	kfree(mtd);
 }
 
+void release_mtd_partition(struct mtd_info *mtd)
+{
+	WARN_ON(!list_empty(&mtd->part.node));
+	free_partition(mtd);
+}
+
 static struct mtd_info *allocate_partition(struct mtd_info *parent,
 					   const struct mtd_partition *part,
 					   int partno, uint64_t cur_offset)
@@ -309,13 +315,11 @@ static int __mtd_del_partition(struct mtd_info *mtd)
 
 	sysfs_remove_files(&mtd->dev.kobj, mtd_partition_attrs);
 
+	list_del_init(&mtd->part.node);
 	err = del_mtd_device(mtd);
 	if (err)
 		return err;
 
-	list_del(&mtd->part.node);
-	free_partition(mtd);
-
 	return 0;
 }
 
@@ -333,6 +337,7 @@ static int __del_mtd_partitions(struct mtd_info *mtd)
 			__del_mtd_partitions(child);
 
 		pr_info("Deleting %s MTD partition\n", child->name);
+		list_del_init(&child->part.node);
 		ret = del_mtd_device(child);
 		if (ret < 0) {
 			pr_err("Error when deleting partition \"%s\" (%d)\n",
@@ -340,9 +345,6 @@ static int __del_mtd_partitions(struct mtd_info *mtd)
 			err = ret;
 			continue;
 		}
-
-		list_del(&child->part.node);
-		free_partition(child);
 	}
 
 	return err;
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 7c58c44662b8..914a9f974baa 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -379,7 +379,7 @@ struct mtd_info {
 
 	struct module *owner;
 	struct device dev;
-	int usecount;
+	struct kref refcnt;
 	struct mtd_debug_info dbg;
 	struct nvmem_device *nvmem;
 	struct nvmem_device *otp_user_nvmem;
-- 
2.34.1

