Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DF162A46F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKOVrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiKOVqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:46:55 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AD2AE7A;
        Tue, 15 Nov 2022 13:46:54 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ov3lH-0005HO-0k; Tue, 15 Nov 2022 22:46:31 +0100
Date:   Tue, 15 Nov 2022 21:45:05 +0000
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
Subject: [PATCH v5 0/4] partition parser for U-Boot's uImage.FIT
Message-ID: <cover.1668548123.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uImage.FIT partition parser and wire it up to allow mounting
filesystem sub-images from uImage.FIT in GPT partitions as well as
mtdblock and ubiblock devices within Linux (e.g. as root filesystem).

Using uImage.FIT to store the root filesystem besides kernel and dtb has
several obvious advantages which are hard to obtain in any other way:
 * single image accross different storage types
 * dynamically sized partitions for kernel and rootfs
 * hash also for rootfs checked by U-Boot before launching kernel
 * images may include additional filesystems e.g. for localization or
   branding

For this to work, the image has to be created with external data and
sub-images aligned to the system's memory page boundaries, ie.
 mkimage -E -B 0x1000 -p 0x1000 ...

Booting such images has been supported by U-Boot since v2018.01.

A previous version of this partition parser is in production use on some
OpenWrt devices, eg. the BananaPi R64 where using the FIT parser allows
booting the very same image from eMMC, SD Card or SPI-NAND/UBI and also
using it as a firmware-upgrade image at the same time.
The Ubiquiti UniFi 6 LR access point served as a reference board with
SPI-NOR flash and use of the partition parser on top of a mtdblock
device.

As U-Boot by now also passes down the selected configuration node name
via device tree this allows the partition parser (or userspace process
via sysfs) to identify the selected image configuration.

Device Tree schema for that:
https://github.com/devicetree-org/dt-schema/commit/a24d97d43491e55d4def006213213a6c4045b646

In most cases this partition parser can be used without relying on the
bootloader to pass-down the configuration node name. The default
configuration node is used then.

Changes since v4:
 * use folio instead of page (requested by Matthew Wilcox)
 * remove unneeded checks (requested by Matthew Wilcox)
 * use strscpy instead of strlcpy (strlcpy is deprecated)
 * fix off-by-one string size limit label_min (discovered during tests)
 * use only a single config symbol MTD_BLOCK_PARTITION affecting both
   ubiblock and mtdblock (requested by Richard Weinberger)

Changes since v3:
 * use min_t(size_t, ...)

Changes since v2:
 * use returned length to limit all strings read from fit/dt
 * use __be32 type for 32-bit values read from fit/dt
Reported-by: kernel test robot <lkp@intel.com>
 * Kconfig: select LIBFDT for FIT_PARTITION
Reported-by: kernel test robot <lkp@intel.com>

Changes since v1:
 * Use again #ifdef's in partitions/efi to only build against FIT
   parser symbols if it is actually selected. Otherwise the efi/gpt
   would unconditionally depend on the FTT parser to be present.

Changes since RFC:
 * fixed wrong variable used in error path
 * introduced dedicated Kconfig options to enable partition
   parsers on mtdblock and ubiblock
 * drop #ifdef'ery, use IS_ENABLED(...) where needed

Daniel Golle (4):
  block: add new flag to add partitions read-only
  block: add partition parser for U-Boot uImage.FIT
  partitions/efi: add support for uImage.FIT sub-partitions
  mtd: add option to enable scanning for partitions

 MAINTAINERS               |   6 +
 block/blk.h               |   1 +
 block/partitions/Kconfig  |  15 ++
 block/partitions/Makefile |   1 +
 block/partitions/check.h  |   4 +
 block/partitions/core.c   |   6 +
 block/partitions/efi.c    |   9 +
 block/partitions/efi.h    |   3 +
 block/partitions/fit.c    | 346 ++++++++++++++++++++++++++++++++++++++
 drivers/mtd/Kconfig       |  11 ++
 drivers/mtd/mtd_blkdevs.c |   4 +-
 drivers/mtd/ubi/block.c   |   5 +-
 12 files changed, 409 insertions(+), 2 deletions(-)
 create mode 100644 block/partitions/fit.c

-- 
2.38.1

