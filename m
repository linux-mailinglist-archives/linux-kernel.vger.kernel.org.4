Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0BF630F51
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiKSQDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKSQDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:03:34 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CB7167E6;
        Sat, 19 Nov 2022 08:03:32 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1owQJG-0004Da-58; Sat, 19 Nov 2022 17:03:14 +0100
Date:   Sat, 19 Nov 2022 16:03:11 +0000
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
Message-ID: <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
 <Y3XM62P7CaeKXFsz@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3XM62P7CaeKXFsz@infradead.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Nov 16, 2022 at 09:55:55PM -0800, Christoph Hellwig wrote:
> On Thu, Nov 17, 2022 at 12:42:43AM +0000, Daniel Golle wrote:
> > In init/do_mounts.c there are helper functions devt_from_partuuid,
> > devt_from_partlabel and devt_from_devname. In order to make these
> > functions available to other users, move them to block/bdev.c.
> 
> Yes, they should be moved and I have an old patch to do this a bit
> smarter.  But that doesn't mean anyone else should call them.

I have followed your advise and implemented a "real" block driver
stacking on top of an existing block device to expose uImage.FIT
filesystem subimages as block devices. It mangles any bio submitted to
it and re-submits the bio with changed bi_bdev and sector offset added
to bi_iter.bi_sector for all list elements.

That works, but has slightly less utility value than the partition
parser approach as in this way I cannot easily populate the PARTNAME
uevent which can later help userspace to identify a device by the FIT
subimage name -- I'd have to either invent a new bus_type or
device_type, both seem inappropriate and have unwanted side effects.
Or am I missing something and there is a way to use add_uevent_var()
for a disk_type device?

In exchange, instead of using the PARTNAME= uevent var, I can now
freely name the device node by setting the disk_name string in
struct gendisk. While this doesn't offer the same amount of freedom, it
is sufficient for our use-case.

However, I don't see a way to avoid using (or duplicating)
devt_from_devname() to select the lower device somehow without having
to probe and parse *all* block devices present (which is, from what I
understood, what you want to avoid, and I agree that it is more safe to
not do that...)

Can you or anyone give some advise on how this should be done?

As block partitions are not present in device tree, using a cmdline
argument (with similar semantics to 'root=') specifying the lower block
device seems unavoidable.

Also note that due to libfdt not exporting symbols, the driver
currently cannot be built as a module. Hence, I would either need to
export most of libfdt API or only allow the driver to be built-into the
kernel. I don't see a problem with having it always built-in.

Yet another (imho not terrible) problem is removal of the lower device.
Many of the supported SBC use a micro SD card to boot, which can be
removed by the user while the system is running (which is generally not
a good idea, but anyway). For partitions this is handled automatically
by blk_drop_partitions() called directly from genhd.c.
I'm currently playing with doing something similar using the bus device
removal notification, but it doesn't seem to work for all cases, e.g.
mmcblk device do not seem to have the ->bus pointer populated at all
(ie. disk_to_dev(disk)->bus == NULL for mmcblk devices).

Any ideas regarding that?


Thank you for your advise!


Daniel
