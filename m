Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3ED62CFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiKQAmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKQAma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:42:30 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83066175B;
        Wed, 16 Nov 2022 16:42:29 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ovSyx-0002UU-VU; Thu, 17 Nov 2022 01:42:20 +0100
Date:   Thu, 17 Nov 2022 00:42:13 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] block: uImage.FIT filesystem image mapper
Message-ID: <cover.1668644705.git.daniel@makrotopia.org>
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

uImage.FIT is the default image format of Das U-Boot bootloader which
is used on the great majority of embedded Linux devices.

Using uImage.FIT to also store the root filesystem besides kernel and
dtb has several obvious advantages which are hard to obtain in any
other way:
 * single image accross different storage types (mmcblk, mtdblock, ubiblock)
 * dynamically sized partitions for kernel and rootfs
 * hash also for rootfs checked by U-Boot before launching kernel
 * images may include additional filesystems e.g. for localization or
   branding

Add uImage.FIT partition parser, this time implemented as a tiny block
driver which can be built as a module. Being an early RFC, module
unloading by now has only been implemented rudimentary without removing
partitions added by the driver on unload. If the overall approach looks
acceptable, this can of course be improved.

For this to work, the image has to be created with external data and
sub-images aligned to the system's memory page boundaries, ie.
 mkimage -E -B 0x1000 -p 0x1000 ...

Booting such images has been supported by Das U-Boot since v2018.01.

A previous version of this partition parser is in production use on some
OpenWrt devices, eg. the BananaPi R64 where using the FIT parser allows
booting the very same image from eMMC, SD Card or SPI-NAND/UBI and also
using it as a firmware-upgrade image at the same time.
The Ubiquiti UniFi 6 LR access point served as a reference board with
SPI-NOR flash and use of the partition parser on top of a mtdblock
device.

As Das U-Boot by now also passes down the selected configuration node
name via device tree this allows the partition parser (or userspace
process via sysfs) to identify the selected image configuration.

Device Tree schema for that has also been merged already[1].

In most cases this partition parser can be used without relying on the
bootloader to pass-down the configuration node name. The default
configuration node is used then in that case.

A check of the chosen/u-boot,version node is used to make sure that
Das U-Boot has been used to boot the system and the user (or the
bootloader) is required to specify the lower block device to be used
by the parser. In case any of the two is missing, this driver won't
start.

This RFC presents an alternative implementation of the previously
posted patch series "partition parser for U-Boot's uImage.FIT"[1].

[1]: https://github.com/devicetree-org/dt-schema/commit/a24d97d43491e55d4def006213213a6c4045b646
[2]: https://patchwork.kernel.org/project/linux-block/list/?series=695709

Daniel Golle (4):
  init: move block device helpers from init/do_mounts.c
  block: add new flag to add partitions read-only
  blkdev: add function to add named read-only partitions
  block: add uImage.FIT block partition driver

 MAINTAINERS             |   6 +
 block/bdev.c            | 166 ++++++++++++++++++
 block/blk.h             |   1 +
 block/partitions/core.c |  37 ++++
 drivers/block/Kconfig   |   6 +
 drivers/block/Makefile  |   2 +
 drivers/block/fitblk.c  | 364 ++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h  |  22 +++
 init/do_mounts.c        | 166 +-----------------
 9 files changed, 606 insertions(+), 164 deletions(-)
 create mode 100644 drivers/block/fitblk.c

-- 
2.38.1

