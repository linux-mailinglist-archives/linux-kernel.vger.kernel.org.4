Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227C664B563
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiLMMqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiLMMp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:45:56 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C020288;
        Tue, 13 Dec 2022 04:45:54 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1p54f8-0002G7-NG; Tue, 13 Dec 2022 13:45:34 +0100
Date:   Tue, 13 Dec 2022 12:45:27 +0000
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
Message-ID: <Y5hz5+yXWDadDhRB@makrotopia.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
 <Y3XM62P7CaeKXFsz@infradead.org>
 <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
 <Y3zCdJr5dKsADsnM@infradead.org>
 <Y5NpsmN/npnG8lxY@makrotopia.org>
 <Y5buTVuu0pfqBQh+@infradead.org>
 <Y5cKSRmZ45OJq6Qq@makrotopia.org>
 <Y5ggLBy+XBjl/vYj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5ggLBy+XBjl/vYj@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 10:48:12PM -0800, Christoph Hellwig wrote:
> On Mon, Dec 12, 2022 at 11:02:33AM +0000, Daniel Golle wrote:
> > The thing is that there isn't anything extraordinarily complex here,
> > just dynamically partitioning a block device based on a well-known
> > format.
> 
> Yes, but a completely non-standard format that nests inside an
> partition.

The reason for this current discussion (see subject line) is exactly
that you didn't like the newly introduced partition type GUID which
then calls the newly introduced partition parser taking care of the
uImage.FIT content of a partition.
Instead you suggested to implement it as a small stackable block
driver, which I did (and will post as RFC in a moment from now).

This block driver (if built-into the kernel and relied upon to expose
the block device used as root filesystem) will need to identify the
lower device it should work on. And for that the helper functions such
as devt_from_devname() need to be available for that driver.

> 
> > Using initramfs implies that we would need a 2nd copy of the standard C
> > library and libfdt, both alone will already occupy more than just a
> > single 64kB block of flash.
> 
> Why do you need libfdt?

uImage.FIT is based on FDT, so the easiest way to parse this format
without reinventing the wheel is using libfdt.

> And with a simple statically linked kpartx you won't pull in much of
> libc either.

Well, enough to have kpartx and libfdt covered. I still assume that's
more than 64KiB of compressed bytecode in total.

> 
> > I understand that from the point of view of
> > classic x86 servers or even embedded devices with eMMC this seems
> > negligible. However, keep in mind that a huge number of existing
> > devices and also new designs of embedded devices often boot from just a
> > few megabytes of NOR flash, and there every byte counts.
> 
> So I've worked quite a bit on really small deeply embedded systems,
> and for those I wouldn't even think of using strange image formats
> or the rather wasteful GPT partition format.
> There we wouldn't dare to use paritions or weird image formats, but

Well, the reality as of today is that even the smallest of all embedded
devices will need updated firmware at some point.

Using an image format which allows to dynamically partition a firmware
image into kernel and rootfs parts is needed **especially** on devices
with very little storage space -- it's there that we cannot afford to
use hard-coded MTD partition sizes either limiting or overestimating
the future kernel size.

And having a unified format which serves a whole range of devices does
make that easier -- surely, on NOR flash, there would not be a GPT
partition; mtdblock on top of an MTD partition is used in that case.

> 
> > > What is the point of the uImage.FIT?
> > 
> > It is the format used by Das U-Boot, which is by far the most common
> > bootloader found on small embedded devices running Linux.
> > Is is already used by Das U-Boot to validate and load kernel,
> > devicetree, initramfs, ... to RAM before launching Linux.
> > I've included a link to the documentation[1] which gives insights
> > regarding the motivation to create such a format.
> 
> That doesn't explain why you'd want to use it.  Nor how people
> came up with it.

I didn't want to quote all the history here, but it is explained rather
well in their documentation I had linked there.

> 
> > In fact, that's only one out of three possible uses in which parsing
> > the contained sub-image boundaries can be useful:
> >  * On devices with NOR flash uImage.FIT is stored in an MTD partition,
> >    hence the uImage.FIT partition parser (or small stackable block
> >    driver) would then operate on top of /dev/mtdblockX.
> > 
> >  * On devices with NAND flash uImage.FIT is stored in a UBI volume,
> >    hence in this case /dev/ubiblockX needs to be processed.
> 
> And all the mtdblock / ubiblock is due to the lack of a native
> mtd/ubi backend for squashfs?  Why can't we take the block layer
> out of the loop entirely?

A block representation is the common denominator of all the
above. Sure, I could implement splitting MTD devices according to
uImage.FIT and then add MTD support to squashfs. Then implement
splitting of UBI volumes and add UBI support to squashfs.

However, simply using mtdblock on NOR and ubiblock on NAND seem
well-suited and hence there wasn't ever a need to implement
MTD or UBI support for any **read-only** filesystem.
Afaik that is what mtdblock and ubiblock are intended to be used
for.

> > I hope this explains my motivation. Please ask should there by any
> > doubts or if any of my explainations above are not clear.
> 
> None of this explains the silly nesting inside the GPT partition.
> It is not needed for the any use cases and the root probem here.

So where would you store the uImage (which will have to exist
even to just load kernel and DTB in U-Boot, even without containing
the root filesystem) on devices with eMMC then?

I did consider block2mtd on eMMC and gluebi (which is deprecated) on
UBI, but in order to mount the filesystem I'd then use mtdblock further
down the road, and that'd actually be silly.

> Without that you could simply implement a parition format, with that
> you get into crazy nesting behavior.  Note that it would have
> any benefit over just not doing this silly image.

Are you suggesting to come up with an entirely new type of partition
table only for that purpose? Which will require its own tools and
implementation in both, U-Boot and Linux? What would be the benefit
over just using GPT partitioning?

I'm not saying that this cannot be done (and I will do it if you
convince me that it'd be needed).

> 
> Maybe someone just needs to go back and come up wit ha scheme that
> actually works and implement that in uboot as well.

In terms of "works" both are working very well, the uImage.FIT
partition parser as well as the tiny stackable block driver you had
asked me to write instead. I've tested both on multiple devices by now,
the former is even used in production on one of the currently most
popular devices running OpenWrt (according to update backend stats).


Thank you for your patience!


Daniel
