Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1582A64B566
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiLMMql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiLMMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:46:36 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6291D2;
        Tue, 13 Dec 2022 04:46:35 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1p54g5-0002H9-3A; Tue, 13 Dec 2022 13:46:33 +0100
Date:   Tue, 13 Dec 2022 12:46:26 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 2/2] block: add uImage.FIT block partition driver
Message-ID: <Y5h0C4iKoeCJgRCb@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a small block driver which allows exposing filesystem sub-images
contained in U-Boot uImage.FIT images as block partitions.
The driver is intended for system using the U-Boot bootloader and
requires the user to specify the lower block device to be specified
as module parameter 'lower_dev'.

The initial approach of using a partition parser for this job has been
NACK'ed[1], the suggestion was to implement a tiny stackable block
driver instead for this job. Here it comes.

As discussed previously, the removal-notification part doesn't work
at this point as it depends on a future change introducing such
notifications[2].

[1]: https://lore.kernel.org/lkml/Y3Xb2YbBP1jr9Q1j@infradead.org/
[2]: https://lore.kernel.org/lkml/Y3zCdJr5dKsADsnM@infradead.org/

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---

 MAINTAINERS            |   6 +
 drivers/block/Kconfig  |  11 +
 drivers/block/Makefile |   2 +
 drivers/block/fitblk.c | 493 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 512 insertions(+)
 create mode 100644 drivers/block/fitblk.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 08b67532e374..39402d6d0b9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21184,6 +21184,12 @@ F:	Documentation/filesystems/ubifs-authentication.rst
 F:	Documentation/filesystems/ubifs.rst
 F:	fs/ubifs/
 
+U-BOOT UIMAGE.FIT PARSER
+M:	Daniel Golle <daniel@makrotopia.org>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	drivers/block/fitblk.c
+
 UBLK USERSPACE BLOCK DRIVER
 M:	Ming Lei <ming.lei@redhat.com>
 L:	linux-block@vger.kernel.org
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index a41145d52de9..f8618bc869b2 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -383,6 +383,17 @@ config VIRTIO_BLK
 	  This is the virtual block driver for virtio.  It can be used with
           QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
+config UIMAGE_FIT_BLK
+	bool "uImage.FIT block driver"
+	help
+	  This is driver allows using filesystems contained in uImage.FIT images
+	  by mapping them as block devices.
+
+	  This driver can currently not be built as a module.
+
+	  Say Y if you want to mount filesystems sub-images of a uImage.FIT
+	  stored in a block device partition, mtdblock or ubiblock device.
+
 config BLK_DEV_RBD
 	tristate "Rados block device (RBD)"
 	depends on INET && BLOCK
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..60ab4fc1442d 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -39,4 +39,6 @@ obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
 
+obj-$(CONFIG_UIMAGE_FIT_BLK)	+= fitblk.o
+
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/fitblk.c b/drivers/block/fitblk.c
new file mode 100644
index 000000000000..addb30c44a80
--- /dev/null
+++ b/drivers/block/fitblk.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * uImage.FIT virtual block device driver.
+ *
+ * Copyright (C) 2022 Daniel Golle
+ * Copyright (C) 2007 Nick Piggin
+ * Copyright (C) 2007 Novell Inc.
+ *
+ * Derived from drivers/block/brd.c which is in parts derived from
+ * drivers/block/rd.c, and drivers/block/loop.c, copyright of their respective
+ * owners.
+ *
+ * uImage.FIT headers extracted from U-Boot mkimage sources
+ *  (C) Copyright 2008 Semihalf
+ *  (C) Copyright 2000-2005
+ *  Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+#include <linux/init.h>
+#include <linux/initrd.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/major.h>
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/ctype.h>
+#include <linux/hdreg.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_fdt.h>
+#include <linux/pagemap.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/libfdt.h>
+
+#define FIT_IMAGES_PATH		"/images"
+#define FIT_CONFS_PATH		"/configurations"
+
+/* hash/signature/key node */
+#define FIT_HASH_NODENAME	"hash"
+#define FIT_ALGO_PROP		"algo"
+#define FIT_VALUE_PROP		"value"
+#define FIT_IGNORE_PROP		"uboot-ignore"
+#define FIT_SIG_NODENAME	"signature"
+#define FIT_KEY_REQUIRED	"required"
+#define FIT_KEY_HINT		"key-name-hint"
+
+/* cipher node */
+#define FIT_CIPHER_NODENAME	"cipher"
+#define FIT_ALGO_PROP		"algo"
+
+/* image node */
+#define FIT_DATA_PROP		"data"
+#define FIT_DATA_POSITION_PROP	"data-position"
+#define FIT_DATA_OFFSET_PROP	"data-offset"
+#define FIT_DATA_SIZE_PROP	"data-size"
+#define FIT_TIMESTAMP_PROP	"timestamp"
+#define FIT_DESC_PROP		"description"
+#define FIT_ARCH_PROP		"arch"
+#define FIT_TYPE_PROP		"type"
+#define FIT_OS_PROP		"os"
+#define FIT_COMP_PROP		"compression"
+#define FIT_ENTRY_PROP		"entry"
+#define FIT_LOAD_PROP		"load"
+
+/* configuration node */
+#define FIT_KERNEL_PROP		"kernel"
+#define FIT_FILESYSTEM_PROP	"filesystem"
+#define FIT_RAMDISK_PROP	"ramdisk"
+#define FIT_FDT_PROP		"fdt"
+#define FIT_LOADABLE_PROP	"loadables"
+#define FIT_DEFAULT_PROP	"default"
+#define FIT_SETUP_PROP		"setup"
+#define FIT_FPGA_PROP		"fpga"
+#define FIT_FIRMWARE_PROP	"firmware"
+#define FIT_STANDALONE_PROP	"standalone"
+
+#define MIN_FREE_SECT		16
+#define MAX_FIT_LOADABLES	16
+
+static char *lower_dev;
+static const char *ubootver;
+static LIST_HEAD(fitblk_devices);
+static DEFINE_MUTEX(devices_mutex);
+
+module_param(lower_dev, charp, 0444);
+MODULE_PARM_DESC(lower_dev, "virtual block device mapping uImage.FIT filesystem images");
+
+struct fitblk {
+	struct gendisk		*lower_disk;
+	sector_t		start_sect;
+	struct gendisk		*disk;
+	struct list_head	list;
+};
+
+static void fitblk_submit_bio(struct bio *orig_bio)
+{
+	struct bio *bio = orig_bio;
+	struct fitblk *fitblk = bio->bi_bdev->bd_disk->private_data;
+
+	/* mangle bio and re-submit */
+	while (bio) {
+		bio->bi_iter.bi_sector += fitblk->start_sect;
+		bio->bi_bdev = fitblk->lower_disk->part0;
+		bio = bio->bi_next;
+	}
+	submit_bio(orig_bio);
+}
+
+static const struct block_device_operations fitblk_fops = {
+	.owner		= THIS_MODULE,
+	.submit_bio	= fitblk_submit_bio,
+};
+
+static void remove_all_subimages(struct device *dev)
+{
+	struct list_head *n, *tmp;
+	struct fitblk *fitblk;
+
+	pr_err("FIT: removing affected devices\n");
+
+	mutex_lock(&devices_mutex);
+	list_for_each_safe (n, tmp, &fitblk_devices) {
+		fitblk = list_entry(n, struct fitblk, list);
+		if (disk_to_dev(fitblk->lower_disk) != dev)
+			continue;
+
+		del_gendisk(fitblk->disk);
+		kfree(fitblk);
+	}
+	mutex_unlock(&devices_mutex);
+}
+
+static int fitblk_notify(struct notifier_block *nb, unsigned long action,
+			 void *data)
+{
+	struct device *dev = data;
+
+	pr_err("FIT: got notification\n");
+
+	switch (action) {
+	case BUS_NOTIFY_DEL_DEVICE:
+		remove_all_subimages(dev);
+		break;
+	}
+	return 0;
+};
+
+static struct notifier_block fitblk_nb = {
+	.notifier_call = fitblk_notify,
+};
+
+
+static int add_fit_subimage_device(struct gendisk *lower_disk, unsigned int slot,
+				   sector_t start_sect, sector_t nr_sect,
+				   bool readonly)
+{
+	struct fitblk *fitblk;
+	struct gendisk *disk;
+	int err;
+
+	mutex_lock(&devices_mutex);
+
+	fitblk = kzalloc(sizeof(struct fitblk), GFP_KERNEL);
+	if (!fitblk) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	fitblk->lower_disk = lower_disk;
+	fitblk->start_sect = start_sect;
+
+	disk = blk_alloc_disk(NUMA_NO_NODE);
+	if (!disk) {
+		err = -ENOMEM;
+		goto out_free_fitblk;
+	}
+
+	fitblk->disk = disk;
+	disk->first_minor = 0;
+	disk->flags = lower_disk->flags | GENHD_FL_NO_PART;
+	disk->fops = &fitblk_fops;
+	disk->private_data = fitblk;
+	if (readonly) {
+		set_disk_ro(disk, 1);
+		snprintf(disk->disk_name, sizeof(disk->disk_name), "fit%u", slot);
+	} else {
+		strcpy(disk->disk_name, "fitrw");
+	}
+
+	set_capacity(disk, nr_sect);
+
+	disk->queue->queue_flags = lower_disk->queue->queue_flags;
+	memcpy(&disk->queue->limits, &lower_disk->queue->limits, sizeof(struct queue_limits));
+
+	err = device_add_disk(disk_to_dev(lower_disk), disk, NULL);
+	if (err)
+		goto out_cleanup_disk;
+
+	list_add_tail(&fitblk->list, &fitblk_devices);
+
+	mutex_unlock(&devices_mutex);
+
+	return 0;
+
+out_cleanup_disk:
+	put_disk(disk);
+out_free_fitblk:
+	kfree(fitblk);
+out_unlock:
+	mutex_unlock(&devices_mutex);
+	return err;
+}
+
+static int parse_fit_on_dev(struct device *dev)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct gendisk *disk = dev_to_disk(dev);
+	struct address_space *mapping = disk->part0->bd_inode->i_mapping;
+	struct folio *folio;
+	void *fit;
+	u64 dsize, dsectors, imgmaxsect = 0;
+	u32 size, image_pos, image_len;
+	const __be32 *image_offset_be, *image_len_be, *image_pos_be;
+	int ret = 0, node, images, config;
+	const char *image_name, *image_type, *image_description,
+		*config_default, *config_description, *config_loadables;
+	u32 image_name_len, image_type_len, image_description_len,
+		bootconf_len, config_default_len, config_description_len,
+		config_loadables_len;
+	sector_t fit_start_sect = bdev->bd_start_sect, start_sect, nr_sects;
+	struct device_node *np = NULL;
+	const char *bootconf;
+	const char *loadable;
+	bool found;
+	int loadables_rem_len, loadable_len;
+	u16 loadcnt;
+	bool lower_is_part = !(bdev == disk->part0);
+	unsigned int slot = 0;
+
+	/* uImage.FIT should be aligned to page boundaries on disk */
+	if (fit_start_sect % (1 << (PAGE_SHIFT - SECTOR_SHIFT)))
+		return -ESPIPE;
+
+	/* map first page */
+	folio = read_mapping_folio(mapping,
+				   fit_start_sect >> (PAGE_SHIFT - SECTOR_SHIFT),
+				   NULL);
+
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+
+	fit = folio_address(folio) +
+	      offset_in_folio(folio, fit_start_sect * SECTOR_SIZE);
+
+	/* uImage.FIT is based on flattened device tree structure */
+	if (fdt_check_header(fit)) {
+		ret = -EINVAL;
+		goto out_folio;
+	}
+
+	/* acquire disk size */
+	dsectors = bdev_nr_sectors(bdev);
+	dsize = dsectors << SECTOR_SHIFT;
+
+	/* silently skip non-external-data legacy uImage.FIT */
+	size = fdt_totalsize(fit);
+	if (size > PAGE_SIZE) {
+		ret = -EOPNOTSUPP;
+		goto out_folio;
+	}
+
+	/* abort if FIT structure is larger than disk or partition size */
+	if (size >= dsize) {
+		ret = -EFBIG;
+		goto out_folio;
+	}
+
+	/* set boot config node name U-Boot may have added to the device tree */
+	np = of_find_node_by_path("/chosen");
+	if (np)
+		bootconf = of_get_property(np, "u-boot,bootconf", &bootconf_len);
+	else
+		bootconf = NULL;
+
+	/* find configuration path in uImage.FIT */
+	config = fdt_path_offset(fit, FIT_CONFS_PATH);
+	if (config < 0) {
+		pr_err("FIT: Cannot find %s node: %d\n",
+		       FIT_CONFS_PATH, config);
+		ret = -ENOENT;
+		goto out_folio;
+	}
+
+	/* get default configuration node name */
+	config_default =
+		fdt_getprop(fit, config, FIT_DEFAULT_PROP, &config_default_len);
+
+	/* make sure we got either default or selected boot config node name */
+	if (!config_default && !bootconf) {
+		pr_err("FIT: Cannot find default configuration\n");
+		ret = -ENOENT;
+		goto out_folio;
+	}
+
+	/* find selected boot config node, fallback on default config node */
+	node = fdt_subnode_offset(fit, config, bootconf ?: config_default);
+	if (node < 0) {
+		pr_err("FIT: Cannot find %s node: %d\n",
+		       bootconf ?: config_default, node);
+		ret = -ENOENT;
+		goto out_folio;
+	}
+
+	pr_info("FIT: Detected U-Boot %s\n", ubootver);
+
+	/* get selected configuration data */
+	config_description =
+		fdt_getprop(fit, node, FIT_DESC_PROP, &config_description_len);
+	config_loadables = fdt_getprop(fit, node, FIT_LOADABLE_PROP,
+				       &config_loadables_len);
+
+	pr_info("FIT: %s configuration: \"%.*s\"%s%.*s%s\n",
+		bootconf ? "Selected" : "Default",
+		bootconf ? bootconf_len : config_default_len,
+		bootconf ?: config_default,
+		config_description ? " (" : "",
+		config_description ? config_description_len : 0,
+		config_description ?: "",
+		config_description ? ")" : "");
+
+	if (!config_loadables || !config_loadables_len) {
+		pr_err("FIT: No loadables configured in \"%s\"\n",
+		       bootconf ?: config_default);
+		ret = -ENOENT;
+		goto out_folio;
+	}
+
+	/* get images path in uImage.FIT */
+	images = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images < 0) {
+		pr_err("FIT: Cannot find %s node: %d\n", FIT_IMAGES_PATH, images);
+		ret = -EINVAL;
+		goto out_folio;
+	}
+
+	/* register for notifications, so device removal can be tracked */
+	if (disk_to_dev(disk)->bus) {
+		pr_err("FIT: registering notified on bus %s\n", disk_to_dev(disk)->bus->name);
+		ret = bus_register_notifier(disk_to_dev(disk)->bus, &fitblk_nb);
+		if (ret)
+			goto out_folio;
+	}
+
+	/* iterate over images in uImage.FIT */
+	fdt_for_each_subnode(node, fit, images) {
+		image_name = fdt_get_name(fit, node, &image_name_len);
+		image_type = fdt_getprop(fit, node, FIT_TYPE_PROP, &image_type_len);
+		image_offset_be = fdt_getprop(fit, node, FIT_DATA_OFFSET_PROP, NULL);
+		image_pos_be = fdt_getprop(fit, node, FIT_DATA_POSITION_PROP, NULL);
+		image_len_be = fdt_getprop(fit, node, FIT_DATA_SIZE_PROP, NULL);
+
+		if (!image_name || !image_type || !image_len_be)
+			continue;
+
+		image_len = be32_to_cpu(*image_len_be);
+		if (!image_len)
+			continue;
+
+		if (image_offset_be)
+			image_pos = be32_to_cpu(*image_offset_be) + size;
+		else if (image_pos_be)
+			image_pos = be32_to_cpu(*image_pos_be);
+		else
+			continue;
+
+		image_description = fdt_getprop(fit, node, FIT_DESC_PROP,
+						&image_description_len);
+
+		pr_info("FIT: %16s sub-image 0x%08x..0x%08x \"%.*s\"%s%.*s%s\n",
+			image_type, image_pos, image_pos + image_len - 1,
+			image_name_len, image_name, image_description ? " (" : "",
+			image_description ? image_description_len : 0,
+			image_description ?: "", image_description ? ") " : "");
+
+		/* only 'filesystem' images should be mapped as partitions */
+		if (strncmp(image_type, FIT_FILESYSTEM_PROP, image_type_len))
+			continue;
+
+		/* check if sub-image is part of configured loadables */
+		found = false;
+		loadable = config_loadables;
+		loadables_rem_len = config_loadables_len;
+		for (loadcnt = 0; loadables_rem_len > 1 &&
+				  loadcnt < MAX_FIT_LOADABLES; ++loadcnt) {
+			loadable_len =
+				strnlen(loadable, loadables_rem_len - 1) + 1;
+			loadables_rem_len -= loadable_len;
+			if (!strncmp(image_name, loadable, loadable_len)) {
+				found = true;
+				break;
+			}
+			loadable += loadable_len;
+		}
+		if (!found)
+			continue;
+
+		if (image_pos % (1 << PAGE_SHIFT)) {
+			pr_err("FIT: image %.*s start not aligned to page boundaries, skipping\n",
+			       image_name_len, image_name);
+			continue;
+		}
+
+		if (image_len % (1 << PAGE_SHIFT)) {
+			pr_err("FIT: sub-image %.*s end not aligned to page boundaries, skipping\n",
+			       image_name_len, image_name);
+			continue;
+		}
+
+		start_sect = image_pos >> SECTOR_SHIFT;
+		nr_sects = image_len >> SECTOR_SHIFT;
+		imgmaxsect = max_t(sector_t, imgmaxsect, start_sect + nr_sects);
+
+		if (start_sect + nr_sects > dsectors) {
+			pr_err("FIT: sub-image %.*s disk access beyond EOD\n",
+			       image_name_len, image_name);
+			continue;
+		}
+
+		add_fit_subimage_device(disk, slot++, fit_start_sect + start_sect,
+					nr_sects, true);
+	}
+
+	/* in case uImage.FIT is stored in a partition, map the remaining space */
+	if (lower_is_part && (imgmaxsect + MIN_FREE_SECT) < dsectors)
+		add_fit_subimage_device(disk, slot++, fit_start_sect + imgmaxsect,
+					dsectors - imgmaxsect, false);
+
+out_folio:
+	folio_put(folio);
+	return ret;
+}
+
+static int fitblk_probe(struct platform_device *pdev)
+{
+	dev_t devt = devt_from_devname(lower_dev);
+	struct device *dev;
+
+	if (!devt)
+		return -EPROBE_DEFER;
+
+	dev = class_find_device_by_devt(&block_class, devt);
+	if (!dev)
+		return -EPROBE_DEFER;
+
+	return parse_fit_on_dev(dev);
+}
+
+static struct platform_driver fitblk_driver = {
+	.probe		= fitblk_probe,
+	.driver		= {
+		.name   = "fitblk",
+		.owner   = THIS_MODULE,
+	},
+};
+
+static int __init fitblk_init(void)
+{
+	struct device_node *np;
+
+	if (!lower_dev)
+		return 0;
+
+	/* detect U-Boot firmware */
+	ubootver = NULL;
+	np = of_find_node_by_path("/chosen");
+	if (np)
+		ubootver = of_get_property(np, "u-boot,version", NULL);
+
+	if (!ubootver)
+		return 0;
+
+	platform_device_register_simple("fitblk", -1, NULL, 0);
+	return platform_driver_register(&fitblk_driver);
+}
+module_init(fitblk_init);
+
+MODULE_AUTHOR("Daniel Golle");
+MODULE_DESCRIPTION("uImage.FIT virtual block driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:fitblk");
-- 
2.39.0

