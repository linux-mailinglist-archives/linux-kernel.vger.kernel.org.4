Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F29C62A474
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiKOVsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiKOVr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:47:59 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765C193D6;
        Tue, 15 Nov 2022 13:47:58 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ov3mU-0005J5-8v; Tue, 15 Nov 2022 22:47:46 +0100
Date:   Tue, 15 Nov 2022 21:46:21 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Golle <daniel@makrotopia.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v5 2/4] block: add partition parser for U-Boot uImage.FIT
Message-ID: <a8d4df0b7684350d655a00d6b5ca1dc8c319edee.1668548123.git.daniel@makrotopia.org>
References: <cover.1668548123.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668548123.git.daniel@makrotopia.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new partition parser for U-Boot's Flattened-Image-Tree (FIT) in
order to allow Linux to mount the filesystem part of a uImage.FIT.

uImage.FIT needs to be created with external data and aligned to the
system's memory page size. e.g.
 mkimage -E -B 0x1000 -p 0x1000 ...

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 MAINTAINERS               |   6 +
 block/partitions/Kconfig  |  15 ++
 block/partitions/Makefile |   1 +
 block/partitions/check.h  |   4 +
 block/partitions/core.c   |   3 +
 block/partitions/fit.c    | 346 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 375 insertions(+)
 create mode 100644 block/partitions/fit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 547ba994ea98..632672eb33ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8059,6 +8059,12 @@ F:	Documentation/firmware_class/
 F:	drivers/base/firmware_loader/
 F:	include/linux/firmware.h
 
+FIT PARTITION TABLE (uImage.FIT)
+M:	Daniel Golle <daniel@makrotopia.org>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	block/partitions/fit.c
+
 FLEXTIMER FTM-QUADDEC DRIVER
 M:	Patrick Havelange <patrick.havelange@essensium.com>
 L:	linux-iio@vger.kernel.org
diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 7aff4eb81c60..77dc85d3797d 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -103,6 +103,21 @@ config ATARI_PARTITION
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned under the Atari OS.
 
+config FIT_PARTITION
+	bool "Flattened-Image-Tree (FIT) partition support" if PARTITION_ADVANCED
+	default n
+	select LIBFDT
+	help
+	  Say Y here if your system needs to mount the filesystem part of
+	  a Flattened-Image-Tree (FIT) image commonly used with Das U-Boot.
+
+	  uImage.FIT needs to be created with external data and aligned to
+	  the systems memory page size. e.g.
+	    mkimage -E -B 0x1000 -p 0x1000 ...
+
+	  If your system doesn't use U-Boot or you don't need to mount uImage.FIT
+	  filesystem sub-images in Linux, say N.
+
 config IBM_PARTITION
 	bool "IBM disk label and partition support"
 	depends on PARTITION_ADVANCED && S390
diff --git a/block/partitions/Makefile b/block/partitions/Makefile
index a7f05cdb02a8..d319eb1deba9 100644
--- a/block/partitions/Makefile
+++ b/block/partitions/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ACORN_PARTITION) += acorn.o
 obj-$(CONFIG_AMIGA_PARTITION) += amiga.o
 obj-$(CONFIG_ATARI_PARTITION) += atari.o
 obj-$(CONFIG_AIX_PARTITION) += aix.o
+obj-$(CONFIG_FIT_PARTITION) += fit.o
 obj-$(CONFIG_CMDLINE_PARTITION) += cmdline.o
 obj-$(CONFIG_MAC_PARTITION) += mac.o
 obj-$(CONFIG_LDM_PARTITION) += ldm.o
diff --git a/block/partitions/check.h b/block/partitions/check.h
index 8d70a880c372..76b006d3cb27 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -57,6 +57,7 @@ int amiga_partition(struct parsed_partitions *state);
 int atari_partition(struct parsed_partitions *state);
 int cmdline_partition(struct parsed_partitions *state);
 int efi_partition(struct parsed_partitions *state);
+int fit_partition(struct parsed_partitions *state);
 int ibm_partition(struct parsed_partitions *);
 int karma_partition(struct parsed_partitions *state);
 int ldm_partition(struct parsed_partitions *state);
@@ -67,3 +68,6 @@ int sgi_partition(struct parsed_partitions *state);
 int sun_partition(struct parsed_partitions *state);
 int sysv68_partition(struct parsed_partitions *state);
 int ultrix_partition(struct parsed_partitions *state);
+
+int parse_fit_partitions(struct parsed_partitions *state, u64 fit_start_sector,
+			 u64 sectors, int *slot, int max_slot, bool add_remain);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 355646b0707d..9d4bb8f48d35 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -43,6 +43,9 @@ static int (*check_part[])(struct parsed_partitions *) = {
 #ifdef CONFIG_CMDLINE_PARTITION
 	cmdline_partition,
 #endif
+#ifdef CONFIG_FIT_PARTITION
+	fit_partition,
+#endif
 #ifdef CONFIG_EFI_PARTITION
 	efi_partition,		/* this must come before msdos */
 #endif
diff --git a/block/partitions/fit.c b/block/partitions/fit.c
new file mode 100644
index 000000000000..1c19a250f8e6
--- /dev/null
+++ b/block/partitions/fit.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  fs/partitions/fit.c
+ *  Copyright (C) 2021  Daniel Golle
+ *
+ *  headers extracted from U-Boot mkimage sources
+ *  (C) Copyright 2008 Semihalf
+ *  (C) Copyright 2000-2005
+ *  Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ *  based on existing partition parsers
+ *  Copyright (C) 1991-1998  Linus Torvalds
+ *  Re-organised Feb 1998 Russell King
+ */
+
+#include <linux/libfdt.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_fdt.h>
+#include <linux/types.h>
+
+#include "check.h"
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
+#define REMAIN_VOLNAME		"rootfs_data"
+#define MAX_FIT_LOADABLES	16
+
+/**
+ * parse_fit_partitions - map uImage.FIT filesystem sub-images into sub-partitions
+ * @state: pointer to partition parser state
+ * @fit_start_sector: start sector of the FIT structure on disk
+ * @sectors: number of sectors of the uImage.FIT partition or 0 if whole device
+ * @slot: pointer to the current partition slot number
+ * @add_remain: map unused sectors into additional partition
+ *
+ * To be called by other partition parsers on physical block devices or using
+ * wrapper function int fit_partition(struct parsed_partitions *state) for the
+ * whole disk, relevant typically for ubiblock or mtdblock devices.
+ */
+int parse_fit_partitions(struct parsed_partitions *state, u64 fit_start_sector,
+			 u64 sectors, int *slot, int max_slot, bool add_remain)
+{
+	struct block_device *bdev = state->disk->part0;
+	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct folio *folio;
+	void *fit, *init_fit;
+	struct partition_meta_info *info;
+	char tmp[sizeof(info->volname) + 2]; /* 2 extra bytes for parentheses */
+	u64 dsize, dsectors, imgmaxsect = 0;
+	u32 size, image_pos, image_len;
+	const __be32 *image_offset_be, *image_len_be, *image_pos_be;
+	int ret = 1, node, images, config;
+	const char *image_name, *image_type, *image_description,
+		*config_default, *config_description, *config_loadables;
+	u32 image_name_len, image_type_len, image_description_len,
+		config_default_len, config_description_len,
+		config_loadables_len;
+	sector_t start_sect, nr_sects;
+	size_t label_min;
+	struct device_node *np = NULL;
+	const char *bootconf;
+	const char *loadable;
+	bool found;
+	int loadables_rem_len, loadable_len;
+	u16 loadcnt;
+
+	/* uImage.FIT should be aligned to page boundaries */
+	if (fit_start_sector % (1 << (PAGE_SHIFT - SECTOR_SHIFT)))
+		return 0;
+
+	/* map first page */
+	folio = read_mapping_folio(
+		mapping, fit_start_sector >> (PAGE_SHIFT - SECTOR_SHIFT), NULL);
+
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+
+	init_fit = folio_address(folio) + offset_in_folio(folio, fit_start_sector * SECTOR_SIZE);
+
+	/* uImage.FIT is based on flattened device tree structure */
+	if (fdt_check_header(init_fit)) {
+		folio_put(folio);
+		return 0;
+	}
+
+	/* acquire disk or partition size */
+	dsectors = get_capacity(bdev->bd_disk);
+	if (sectors)
+		dsectors = min_t(u64, sectors, dsectors);
+
+	dsize = dsectors << SECTOR_SHIFT;
+	size = fdt_totalsize(init_fit);
+
+	/* silently skip non-external-data legacy uImage.FIT */
+	if (size > PAGE_SIZE) {
+		folio_put(folio);
+		return 0;
+	}
+
+	/* abort if FIT structure is larger than disk or partition size */
+	if (size >= dsize) {
+		state->access_beyond_eod = 1;
+		folio_put(folio);
+		return -EFBIG;
+	}
+
+	/*
+	 * copy FIT structure for further processing
+	 * this is necessary for libfdt to work
+	 */
+	fit = kmemdup(init_fit, size, GFP_KERNEL);
+	folio_put(folio);
+	if (!fit)
+		return -ENOMEM;
+
+	/* set boot config node name U-Boot may have added to the device tree */
+	np = of_find_node_by_path("/chosen");
+	if (np)
+		bootconf = of_get_property(np, "u-boot,bootconf", NULL);
+	else
+		bootconf = NULL;
+
+	/* find configuration path in uImage.FIT */
+	config = fdt_path_offset(fit, FIT_CONFS_PATH);
+	if (config < 0) {
+		pr_err("FIT: Cannot find %s node: %d\n",
+		       FIT_CONFS_PATH, config);
+		ret = -ENOENT;
+		goto ret_out;
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
+		goto ret_out;
+	}
+
+	/* find selected boot config node, fallback on default config node */
+	node = fdt_subnode_offset(fit, config, bootconf ?: config_default);
+	if (node < 0) {
+		pr_err("FIT: Cannot find %s node: %d\n",
+		       bootconf ?: config_default, node);
+		ret = -ENOENT;
+		goto ret_out;
+	}
+
+	/* get selected configuration data */
+	config_description =
+		fdt_getprop(fit, node, FIT_DESC_PROP, &config_description_len);
+	config_loadables = fdt_getprop(fit, node, FIT_LOADABLE_PROP,
+				       &config_loadables_len);
+
+	pr_info("FIT: %s configuration: \"%s\"%s%.*s%s\n",
+		bootconf ? "Selected" : "Default", bootconf ?: config_default,
+		config_description ? " (" : "",
+		config_description ? config_description_len : 0,
+		config_description ?: "",
+		config_description ? ")" : "");
+
+	if (!config_loadables || !config_loadables_len) {
+		pr_err("FIT: No loadables configured in \"%s\"\n",
+		       bootconf ?: config_default);
+		ret = -ENOENT;
+		goto ret_out;
+	}
+
+	/* get images path in uImage.FIT */
+	images = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images < 0) {
+		pr_err("FIT: Cannot find %s node: %d\n", FIT_IMAGES_PATH, images);
+		ret = -EINVAL;
+		goto ret_out;
+	}
+
+	/* allocate one slot for mapping remaing space */
+	if (add_remain)
+		--max_slot;
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
+		imgmaxsect = (imgmaxsect < (start_sect + nr_sects)) ?
+				     (start_sect + nr_sects) :
+					   imgmaxsect;
+
+		if (start_sect + nr_sects > dsectors) {
+			state->access_beyond_eod = 1;
+			continue;
+		}
+
+		put_partition(state, *slot, fit_start_sector + start_sect,
+			      nr_sects);
+		state->parts[*slot].flags = ADDPART_FLAG_READONLY;
+		state->parts[*slot].has_info = true;
+		info = &state->parts[*slot].info;
+
+		label_min = min_t(size_t, sizeof(info->volname), image_name_len + 1);
+		strscpy(info->volname, image_name, label_min);
+
+		snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
+		strlcat(state->pp_buf, tmp, PAGE_SIZE);
+
+		if (++(*slot) > max_slot)
+			break;
+	}
+
+	/* in case uImage.FIT is stored in a partition, map the remaining space */
+	if (add_remain && (imgmaxsect + MIN_FREE_SECT) < dsectors) {
+		put_partition(state, *slot, fit_start_sector + imgmaxsect,
+			      dsectors - imgmaxsect);
+		state->parts[*slot].flags = 0;
+		info = &state->parts[*slot].info;
+		strcpy(info->volname, REMAIN_VOLNAME);
+		snprintf(tmp, sizeof(tmp), "(%s)", REMAIN_VOLNAME);
+		strlcat(state->pp_buf, tmp, PAGE_SIZE);
+		++(*slot);
+	}
+ret_out:
+	kfree(fit);
+	return ret;
+}
+
+/**
+ * fit_partition - map uImage.FIT filesystem sub-images into partitions
+ * @state: pointer to partition parser state
+ *
+ * Used to parse uImage.FIT structure for images directly stored on
+ * the whole block device (typically ubiblock or mtdblock).
+ */
+int fit_partition(struct parsed_partitions *state)
+{
+	int slot = 1;
+
+	return parse_fit_partitions(state, 0, 0, &slot, MAX_FIT_LOADABLES, false);
+}
-- 
2.38.1

