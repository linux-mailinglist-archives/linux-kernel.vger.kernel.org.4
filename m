Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A40633CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKVMhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiKVMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:37:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC818B;
        Tue, 22 Nov 2022 04:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eEwn/jgijxzT0bTyhHon1GnPIusHbd+BLkxVvvIWLZE=; b=f5Vum9ZmrKnT1UDkwMjNUYBsm4
        GIHnoIC9IcNcmKb51j0iGoXc9LjprOoe/m2MzzjYdHie3eZy9OZLefDRygrOShJTB7c9yoFhdFMbJ
        L/XipT7GNdRPWsmr0SqCi+35+XBSUfP7yWGUakItGVjTngmXE+yfBu0wJOegJ31K7ugG8KCMFbBB3
        aC4tXSCpCnanqdhGMOlpRPxFhpvUmwn1XmNaZy2D0r2H1Grwlvvy088D5h+OriypZ9bwnpjo/n2pL
        XD+Hke7ddEE8xtToJFjAgFGSOLeC+6AsbQcY/RS2Lm2+A0Wm5qDWe/3h/I9INWtdU/6x8bpkD/eHT
        noUdZM6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxSWS-009DG6-9l; Tue, 22 Nov 2022 12:37:08 +0000
Date:   Tue, 22 Nov 2022 04:37:08 -0800
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
Message-ID: <Y3zCdJr5dKsADsnM@infradead.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
 <Y3XM62P7CaeKXFsz@infradead.org>
 <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 04:03:11PM +0000, Daniel Golle wrote:
> That works, but has slightly less utility value than the partition
> parser approach as in this way I cannot easily populate the PARTNAME
> uevent which can later help userspace to identify a device by the FIT
> subimage name -- I'd have to either invent a new bus_type or
> device_type, both seem inappropriate and have unwanted side effects.
> Or am I missing something and there is a way to use add_uevent_var()
> for a disk_type device?

You're not exposing a partition here - this is an image format that
sits in a partition and we should not pretend that is a partition.

> However, I don't see a way to avoid using (or duplicating)
> devt_from_devname() to select the lower device somehow without having
> to probe and parse *all* block devices present (which is, from what I
> understood, what you want to avoid, and I agree that it is more safe to
> not do that...)
> 
> Can you or anyone give some advise on how this should be done?

Just set the block driver up from an initramfs, like we do for all
modern stackable drivers.

> Yet another (imho not terrible) problem is removal of the lower device.
> Many of the supported SBC use a micro SD card to boot, which can be
> removed by the user while the system is running (which is generally not
> a good idea, but anyway). For partitions this is handled automatically
> by blk_drop_partitions() called directly from genhd.c.
> I'm currently playing with doing something similar using the bus device
> removal notification, but it doesn't seem to work for all cases, e.g.
> mmcblk device do not seem to have the ->bus pointer populated at all
> (ie. disk_to_dev(disk)->bus == NULL for mmcblk devices).

I have WIP patches that allow the claimer of a block device get
resize and removal notification.  It's not going to land for 6.2,
but I hope I have it ready in time for the next merge window.
