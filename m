Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFC064D78A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLOIKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLOIKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:10:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52231EC0;
        Thu, 15 Dec 2022 00:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cef1UzqWfVAbvA6+u55m3YXipeQMyViKSaX0VjPe9YU=; b=nfljYgtR+5cOVEIFxn9RUMpY+8
        2Nt2YUwahox8qkXB6AzNrTiFWPZvG2jJM4S2pjw/miAqlqEQk2FgUm27fpAllJHEM6LCVlNSp9ZJA
        yqH0ras/O7RJBF4Cx5eJAdK6cbUKeqO/CnmTFH1ht/374F4fBwT8ziO0CP6KdJbkgB3lSSRr5A8nJ
        G+Btr5jrC4+SsJHHi75yj/FzR7OH+fZuShccJpOS4SsgkZq2x3tGB6eS7t8QYgQ1g1TQxadSryZhj
        RCmOHe9puOi6BBpveW6RO7NixC8AZM1OnOBYby/8fN4aI6wi5x+0NL3xSK/2hgBZdspev088LUCr2
        cYT6T7hA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5jJQ-007WnA-8V; Thu, 15 Dec 2022 08:09:52 +0000
Date:   Thu, 15 Dec 2022 00:09:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] init: move block device helpers from
 init/do_mounts.c
Message-ID: <Y5rWUJ6fv6DLkJ5a@infradead.org>
References: <Y3XM62P7CaeKXFsz@infradead.org>
 <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
 <Y3zCdJr5dKsADsnM@infradead.org>
 <Y5NpsmN/npnG8lxY@makrotopia.org>
 <Y5buTVuu0pfqBQh+@infradead.org>
 <Y5cKSRmZ45OJq6Qq@makrotopia.org>
 <Y5ggLBy+XBjl/vYj@infradead.org>
 <Y5hz5+yXWDadDhRB@makrotopia.org>
 <Y5n9MYEkrnAF4Ztv@infradead.org>
 <Y5orrN6THpkTuiA8@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5orrN6THpkTuiA8@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 08:01:48PM +0000, Daniel Golle wrote:
> I assume that implementing anything similar using blk_lookup_devt in
> the driver itself is then also not acceptable, right?

No.  blk_lookup_devt is a workaround for the early init code where
the file system is not available yet.  The only reasonable use case
is the early init code, but even that is better handled by an initramfs.

> Yet another option would be to implement a way to acquire this
> information from device tree. Ie. have a reference to the disk device
> as well as an unsigned integer in the 'chosen' node which the
> bootloader can use to communicate this to the kernel. Example:
> chosen {
> 	bootdev = <&mmc0 3>;
> };
> 
> It's a bit more tricky for ubiblock or mtdblock devices because they
> don't have *any* representation in device tree at all at this point.
> 
> In case of an MTD partition (for mtdblockX) we would just reference
> the mtd partition in the same way.
> 
> To do this cleanly with NAND/UBI, I'd start with adding
> device-tree-based attaching of an MTD partition to UBI using a
> device-tree attribute 'compatible = "linux,ubi"' on the MTD partition.
> We could then have sub-nodes referencing specific UBI volumes, to
> select them for use with ubiblock but also for those nodes then
> being a valid reference for use with the to-be-introduced 'bootdev'
> attribute in 'chosen'.
> 
> Does that sound acceptable from your perspective?

Device tree questions are really out of my knowledge and domain, the
right people to talk to would be the device-tree and relevant driver
maintainers. 

> Even devices with NOR flash may still want support for removable
> block devices like USB pendrives or SD cards... Many home-routers
> got only 8MiB of NOR flash and yet come with USB 2.0 ports intended
> for a pendrive which is then shared via Samba.

Ok, so we're not _that_ resource contrained at all, because for the
really small devices with just a few MB of ram, not having the block
layer makes a huge difference.

> As the first few blocks are typically used for bootloader code and
> bootloader environment, we would then need to hard-code the offset(s)
> of the uImage.FIT on the block device. Imho this becomes messy and just
> using partitions seemed like a straight forward solution.

Ok, so the whole DOS-World boot load nightmare has spread to these
devices as well.

> And what about dual-boot systems where you have more than one firmware
> image? Hard-code more offsets? For each device?

Is this for a fail save use case where on image is update while the
other on is in use?  I've usually seen people use two different NOR
chips for that to have full error isolation.

> The reason is the different life-cycle of the device main partition
> table, bootloader, bootloader environment, ... on one hand and each
> firmware image on a dual boot system on the other hand.

Oh, so the firmware image doesn't even include the bootloader, but the
bootload is on the same device?  That just seems like a very odd
setup, but I'll take your word for it being used.

> Therefore re-writing the whole disk during firmware upgrades is not an
> option because it is risky, eg. in case of a sudden power failure we
> could end up with a hard-bricked system. So to me it makes sense that
> for a firmware upgrade, we write only to one partition and don't touch
> GPT or anything else on the device. So in case something goes wrong,
> the device will still boot, the bootloader will realize that the
> uImage.FIT in one partition is broken (uImage.FIT also comes with
> hashes to ensure image integrity) and it will load something else (from
> another partition) instead.

I'm just really confused about this whole setup.  Maybe it's just
because what I've worked with, which is either really deeply embededd
devices where the everything is one image, that you might in some case
have twice, or a full blown UEFI-like setup where the boot loader is
separate, but can simply load a kernel from the actual root file system.

I have to say even after all these round trip I'm still not sure
what problem where really solving. In basically all other environments
that have a powerful enough bootloader to read file systems your rootfs
would simply store the kernel image and dtb if they are interdependent.
Is the root cause that uboot doesn't support reading files from squashfs
despite supporting half a dozen other file systems?
