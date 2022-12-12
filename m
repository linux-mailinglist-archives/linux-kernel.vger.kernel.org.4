Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16F6649D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiLLLKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiLLLJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:09:30 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCAD219C;
        Mon, 12 Dec 2022 03:03:05 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1p4ga1-0002nt-SE; Mon, 12 Dec 2022 12:02:42 +0100
Date:   Mon, 12 Dec 2022 11:02:33 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] init: move block device helpers from
 init/do_mounts.c
Message-ID: <Y5cKSRmZ45OJq6Qq@makrotopia.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
 <Y3XM62P7CaeKXFsz@infradead.org>
 <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
 <Y3zCdJr5dKsADsnM@infradead.org>
 <Y5NpsmN/npnG8lxY@makrotopia.org>
 <Y5buTVuu0pfqBQh+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5buTVuu0pfqBQh+@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 01:03:09AM -0800, Christoph Hellwig wrote:
> On Fri, Dec 09, 2022 at 05:00:34PM +0000, Daniel Golle wrote:
> > It doesn't need to be literally the PARTNAME uevent, just any way to
> > communicate the names of mapped subimages to userspace.
> > 
> > My understanding by now is that there is no way around introducing a
> > new device_type and then mitigate the unwanted side effects by
> > follow-up changes, ie. make it possible to use that new device_type
> > when specifying the rootfs= cmdline variable (currently only disks and
> > partitions are considered there).
> > 
> > Or give up on the idea that uImage.FIT subimages mapped by the new
> > driver can be identified by userspace by poking uevent from sysfs and
> > just rely on convention and ordering.
> 
> To be honest I'm still really confused by the patch set.  What is
> the problem with simply using an initramfs, which is the way to
> deal with any non-trivial init issue for about 20 years now, predated
> by the somewhat more awkware initrd...

The thing is that there isn't anything extraordinarily complex here,
just dynamically partitioning a block device based on a well-known
format.

> 
> > Needing an initramfs, even if it boils down to just one statically
> > compile executable, is a massive bloat and complication when building
> > embedded device firmware and none of the over 1580 devices currently
> > supported by OpenWrt need an intermediate initramfs to mount their
> > on-flash squashfs rootfs (some, however, already use this uImage.FIT
> > partition parser, and not needing a downstream patch for that would be
> > nice).
> 
> You can always build the initrams into the kernel image, I don't
> see how that is bloat.

Using initramfs implies that we would need a 2nd copy of the standard C
library and libfdt, both alone will already occupy more than just a
single 64kB block of flash. I understand that from the point of view of
classic x86 servers or even embedded devices with eMMC this seems
negligible. However, keep in mind that a huge number of existing
devices and also new designs of embedded devices often boot from just a
few megabytes of NOR flash, and there every byte counts.

> 
> > Carrying the read-only squashfs filesystem inside the uImage.FIT
> > structure has the advantage of being agnostic regarding the
> > storage-type (NOR/mtdblockX, NAND/ubiblockX, MMC/mmcblkXpY) and allows
> > the bootloader to validate the filesystem hash before starting the
> > kernel, ie. ensuring integrity of the firmware as-a-whole which
> > includes the root filesystem.
> 
> What is the point of the uImage.FIT?

It is the format used by Das U-Boot, which is by far the most common
bootloader found on small embedded devices running Linux.
Is is already used by Das U-Boot to validate and load kernel,
devicetree, initramfs, ... to RAM before launching Linux.
I've included a link to the documentation[1] which gives insights
regarding the motivation to create such a format.

> Why can't you use a sane format?

Define "sane format". :) And tell that to the people over at Das U-Boot
please. I'm just trying to make best use of the status-quo which is
that uImage.FIT is the de-facto standard to boot Linux on small
embedded devices.

> Or at least not use it on top of partitions, which is just
> braindead.

In fact, that's only one out of three possible uses in which parsing
the contained sub-image boundaries can be useful:
 * On devices with NOR flash uImage.FIT is stored in an MTD partition,
   hence the uImage.FIT partition parser (or small stackable block
   driver) would then operate on top of /dev/mtdblockX.

 * On devices with NAND flash uImage.FIT is stored in a UBI volume,
   hence in this case /dev/ubiblockX needs to be processed.

 * On devices with block storage (like eMMC or SD card) the image is
   stored on a (GPT) partition (/dev/mmcblkXpY).

Generally speaking, when it comes to storing the rootfs (typically
squashfs), this can be solved in two ways:
 a) keep the rootfs inside the uImage.FIT structure (to be then dealt
    with by this patch series)

 b) store the rootfs on an additional partition or volume:
    - additional GPT partition on block devices
    - additional MTD partition on devices with NOR flash
    - additional UBI volume on devices with NAND flash

Now lets look at the consequences of each approach:

I.
It is often a requirement that the bootloader shall decide about the
integrity of the firmware before starting it (ie. verify hashes of
kernel, dtb, **and rootfs**). In case of approch b) this will have to
be implemented in a custom, platform-specific way; many vendors do
things like this, resulting in huge variety of different, customs ways
which let the bootloader validate the rootfs. As a huge majority of
devices actually use Das U-Boot which already supports validating
uImage.FIT content, this becomes a no-brainer when using approach a).

II.
Updating the firmware in case of approach a) being used is very simple:
Just write the whole image to a storage volume. In case of approach b)
an archive or tarball has to be used, allowing kernel.uImage and rootfs
to each be written to different storage volumes. And for the special
case of NOR flash, developers came up with a complete out-of-tree
subsystem handling only the splitting of MTD partitions in the various
ways used by vendor-modified bootloaders [2].

III.
Approach a) allows the very same uImage.FIT binary to be read by the
bootloader, used as firmware-upgrade format within Linux userland and
also serve as a recovery image format which can be loaded e.g. via TFTP
and stored by the bootloader. Approach b) will require different
formats for firmware upgrades (eg. a tarball) and storage on-disk,
depending on the platform and type of storage media. And when it comes
to bootloader-level recovery via TFTP, one would have to implement
extraction of that tarball **by the bootloader** or use yet another
format.

IV.
When it comes to devices allowing to boot from different media,
approach a) allows using the exact same firmware image independently of
the storage media used for booting. When using approach b), different
firmware images have to be provided **for the same device**, depending
on whether a block device, NAND/UBI or NOR/MTD is used for booting.
The BananaPi BPi-R64 and more recent BananaPi BPi-R3 boards are good
examples for boards which allow booting of different media, and are
already using uImage.FIT as a unified format.

I hope this explains my motivation. Please ask should there by any
doubts or if any of my explainations above are not clear.

> Who actually came up with this amazingly convoluted and
> annoying scheme and why?

This may answer your question:
[1]: https://source.denx.de/u-boot/u-boot/-/blob/master/doc/uImage.FIT/howto.txt

[2]: https://git.openwrt.org/?p=openwrt/openwrt.git;a=tree;f=target/linux/generic/files/drivers/mtd/mtdsplit
