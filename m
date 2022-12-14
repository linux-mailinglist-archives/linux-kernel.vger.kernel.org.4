Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0634164D0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLNUKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiLNUJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:09:53 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1BC2C13D;
        Wed, 14 Dec 2022 12:02:12 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1p5Xwt-0001md-V8; Wed, 14 Dec 2022 21:01:52 +0100
Date:   Wed, 14 Dec 2022 20:01:48 +0000
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
Message-ID: <Y5orrN6THpkTuiA8@makrotopia.org>
References: <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
 <Y3XM62P7CaeKXFsz@infradead.org>
 <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
 <Y3zCdJr5dKsADsnM@infradead.org>
 <Y5NpsmN/npnG8lxY@makrotopia.org>
 <Y5buTVuu0pfqBQh+@infradead.org>
 <Y5cKSRmZ45OJq6Qq@makrotopia.org>
 <Y5ggLBy+XBjl/vYj@infradead.org>
 <Y5hz5+yXWDadDhRB@makrotopia.org>
 <Y5n9MYEkrnAF4Ztv@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5n9MYEkrnAF4Ztv@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 08:43:29AM -0800, Christoph Hellwig wrote:
> On Tue, Dec 13, 2022 at 12:45:27PM +0000, Daniel Golle wrote:
> > > Yes, but a completely non-standard format that nests inside an
> > > partition.
> > 
> > The reason for this current discussion (see subject line) is exactly
> > that you didn't like the newly introduced partition type GUID which
> > then calls the newly introduced partition parser taking care of the
> > uImage.FIT content of a partition.
> 
> Which is the exact nesting I'm complaining about.  Why do you need
> to use your format inside a GPT partition table?

The GPT partition table is typically written only once to an eMMC-
based device in factory. Firmware images (typically uImage.FIT) are
stored in partitions because there are sometimes two of them (for
A/B dual-boot, or recovery/production dual-boot).

As a working device firmware consists of kernel, dtb and rootfs, all
these three things have to be written and used together, typically
they also come together in one file for firmware upgrade (ie.
rootfs appended to kernel, tarballs, or uImage.FIT containing all three
of them).

As the size of kernel and rootfs cannot be determined accurately at
the time the device is made, having individual GPT partitions for
kernel and rootfs ends up to either being a limit to future groth of
the kernel image or wastes space by overestimating the kernel size.

Changing the GPT partitioning when updating the device to match the
exact sizes is also not an option as a damage to the GPT would then
present a single point of failure (backup GPT also wouldn't help
much here), so for dual-boot to actually be meaningful, we shouldn't
ever write to any parts of the disk/flash which affect more than one
of the dual-boot options.

> What you're doing is bascially nesting a partition table format
> inside another one, which doesn't make any sense at all.

See the last paragraph of this message for good reasons why one would
want to do exactly that.

> 
> > This block driver (if built-into the kernel and relied upon to expose
> > the block device used as root filesystem) will need to identify the
> > lower device it should work on. And for that the helper functions such
> > as devt_from_devname() need to be available for that driver.
> 
> And devt_from_devname must not be used by more non-init code.  It is
> bad it got exposed at all, but new users are not acceptable.

I assume that implementing anything similar using blk_lookup_devt in
the driver itself is then also not acceptable, right?

Yet another option would be to implement a way to acquire this
information from device tree. Ie. have a reference to the disk device
as well as an unsigned integer in the 'chosen' node which the
bootloader can use to communicate this to the kernel. Example:
chosen {
	bootdev = <&mmc0 3>;
};

It's a bit more tricky for ubiblock or mtdblock devices because they
don't have *any* representation in device tree at all at this point.

In case of an MTD partition (for mtdblockX) we would just reference
the mtd partition in the same way.

To do this cleanly with NAND/UBI, I'd start with adding
device-tree-based attaching of an MTD partition to UBI using a
device-tree attribute 'compatible = "linux,ubi"' on the MTD partition.
We could then have sub-nodes referencing specific UBI volumes, to
select them for use with ubiblock but also for those nodes then
being a valid reference for use with the to-be-introduced 'bootdev'
attribute in 'chosen'.

Does that sound acceptable from your perspective?

> 
> > A block representation is the common denominator of all the
> > above. Sure, I could implement splitting MTD devices according to
> > uImage.FIT and then add MTD support to squashfs. Then implement
> > splitting of UBI volumes and add UBI support to squashfs.
> 
> Implementing MTD and/or UBI support would allow you to build a
> kernel without CONFIG_BLOCK, which will save you a lot more than
> the 64k you were whining about above.

Even devices with NOR flash may still want support for removable
block devices like USB pendrives or SD cards... Many home-routers
got only 8MiB of NOR flash and yet come with USB 2.0 ports intended
for a pendrive which is then shared via Samba.

Also, heavily customzied per-device kernel builds would never
scale up to support thousands of devices -- hence OpenWrt uses the
exact same kernel build for many devices, which makes both, the
build process and also debugging kernel bugs, much much easier (or
even doable at all).

> 
> > > None of this explains the silly nesting inside the GPT partition.
> > > It is not needed for the any use cases and the root probem here.
> > 
> > So where would you store the uImage (which will have to exist
> > even to just load kernel and DTB in U-Boot, even without containing
> > the root filesystem) on devices with eMMC then?
> 
> Straight on the block device, where else?

As the first few blocks are typically used for bootloader code and
bootloader environment, we would then need to hard-code the offset(s)
of the uImage.FIT on the block device. Imho this becomes messy and just
using partitions seemed like a straight forward solution.

And what about dual-boot systems where you have more than one firmware
image? Hard-code more offsets? For each device?

In a way, I was considering this by using blkdevparts= cmdline option
instead of GPT, but 

> 
> > Are you suggesting to come up with an entirely new type of partition
> > table only for that purpose? Which will require its own tools and
> > implementation in both, U-Boot and Linux? What would be the benefit
> > over just using GPT partitioning?
> 
> Why do you need another layer of partitioning instead of storing
> all your information either in the uImage, or in some other
> partition format of your choice?

The reason is the different life-cycle of the device main partition
table, bootloader, bootloader environment, ... on one hand and each
firmware image on a dual boot system on the other hand.
Hence there is more than just one uImage: typically bootloader,
bootloader environment, firmware A (uImage.FIT) and firmware B.
Relace "A" and "B" with "recovery" and "production", depending on the
dual-boot style implemented.

Therefore re-writing the whole disk during firmware upgrades is not an
option because it is risky, eg. in case of a sudden power failure we
could end up with a hard-bricked system. So to me it makes sense that
for a firmware upgrade, we write only to one partition and don't touch
GPT or anything else on the device. So in case something goes wrong,
the device will still boot, the bootloader will realize that the
uImage.FIT in one partition is broken (uImage.FIT also comes with
hashes to ensure image integrity) and it will load something else (from
another partition) instead.
