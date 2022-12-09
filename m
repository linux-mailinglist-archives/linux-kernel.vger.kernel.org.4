Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AFF648724
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLIRA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLIRA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:00:56 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4716311;
        Fri,  9 Dec 2022 09:00:55 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1p3gjm-0003BX-4w; Fri, 09 Dec 2022 18:00:38 +0100
Date:   Fri, 9 Dec 2022 17:00:34 +0000
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
Message-ID: <Y5NpsmN/npnG8lxY@makrotopia.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
 <Y3XM62P7CaeKXFsz@infradead.org>
 <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
 <Y3zCdJr5dKsADsnM@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3zCdJr5dKsADsnM@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, Nov 22, 2022 at 04:37:08AM -0800, Christoph Hellwig wrote:
> On Sat, Nov 19, 2022 at 04:03:11PM +0000, Daniel Golle wrote:
> > That works, but has slightly less utility value than the partition
> > parser approach as in this way I cannot easily populate the PARTNAME
> > uevent which can later help userspace to identify a device by the FIT
> > subimage name -- I'd have to either invent a new bus_type or
> > device_type, both seem inappropriate and have unwanted side effects.
> > Or am I missing something and there is a way to use add_uevent_var()
> > for a disk_type device?
> 
> You're not exposing a partition here - this is an image format that
> sits in a partition and we should not pretend that is a partition.

It doesn't need to be literally the PARTNAME uevent, just any way to
communicate the names of mapped subimages to userspace.

My understanding by now is that there is no way around introducing a
new device_type and then mitigate the unwanted side effects by
follow-up changes, ie. make it possible to use that new device_type
when specifying the rootfs= cmdline variable (currently only disks and
partitions are considered there).

Or give up on the idea that uImage.FIT subimages mapped by the new
driver can be identified by userspace by poking uevent from sysfs and
just rely on convention and ordering.

> 
> > However, I don't see a way to avoid using (or duplicating)
> > devt_from_devname() to select the lower device somehow without having
> > to probe and parse *all* block devices present (which is, from what I
> > understood, what you want to avoid, and I agree that it is more safe to
> > not do that...)
> > 
> > Can you or anyone give some advise on how this should be done?
> 
> Just set the block driver up from an initramfs, like we do for all
> modern stackable drivers.

Instead of using a kernel cmdline parameter we could also have the
bootloader embed that information as string in the 'chosen' section in
the device tree blob, right next to the cmdline. However, as there is
no representation of block partitions in device tree, also in that case
the lower device will have to be referenced by a string somehow, ie.
devt_from_devname() or the like will be needed.

Needing an initramfs, even if it boils down to just one statically
compile executable, is a massive bloat and complication when building
embedded device firmware and none of the over 1580 devices currently
supported by OpenWrt need an intermediate initramfs to mount their
on-flash squashfs rootfs (some, however, already use this uImage.FIT
partition parser, and not needing a downstream patch for that would be
nice).

uImage.FIT typically contains the complete firmware used on an embedded
device, ie. at least a Linux kernel, device tree blob and a filesystem.
The main use of this whole uImage.FIT-parsing-in-Linux approach I'm
trying to get across here is to expose one or more 'filesystem'-type
subimages of such an image as block devices, also so that one of them
can directly be mounted as rootfs by the kernel.

This *replaces* the use of 'ramdisk' type sub-images which need to
remain allocated at runtime, while using a squashfs 'filesystem' type
sub-image allows freeing the filesystem cache if ram is becomes scarce.

As both, storage and memory, are often very limited on small embedded
devices, OpenWrt has always been using a squashfs as rootfs with a
storage-type specific filesytem used as r/w overlay on top. Up to now,
the rootfs is often stored in platform-specific ways, ie. an additional
partition on block devices, MTD partition on NOR flash or UBI volume on
NAND flash.

Carrying the read-only squashfs filesystem inside the uImage.FIT
structure has the advantage of being agnostic regarding the
storage-type (NOR/mtdblockX, NAND/ubiblockX, MMC/mmcblkXpY) and allows
the bootloader to validate the filesystem hash before starting the
kernel, ie. ensuring integrity of the firmware as-a-whole which
includes the root filesystem.


> 
> > Yet another (imho not terrible) problem is removal of the lower device.
> > Many of the supported SBC use a micro SD card to boot, which can be
> > removed by the user while the system is running (which is generally not
> > a good idea, but anyway). For partitions this is handled automatically
> > by blk_drop_partitions() called directly from genhd.c.
> > I'm currently playing with doing something similar using the bus device
> > removal notification, but it doesn't seem to work for all cases, e.g.
> > mmcblk device do not seem to have the ->bus pointer populated at all
> > (ie. disk_to_dev(disk)->bus == NULL for mmcblk devices).
> 
> I have WIP patches that allow the claimer of a block device get
> resize and removal notification.  It's not going to land for 6.2,
> but I hope I have it ready in time for the next merge window.

I'm looking forward to integrate that in the uImage.FIT block driver
I've been working on. In the meantime, should I already post my current
draft so we can start discussing if that solution could be acceptable?


Best regards


Daniel
