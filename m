Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4829E649A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiLLJDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiLLJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:03:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8177BAE7F;
        Mon, 12 Dec 2022 01:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h9R03OIQVvMKQfBIXkiDgeYM1mKgmNkY4rps+5GjU1U=; b=jr82jioBJd3KjKPauS+sy8YrM6
        Nb0H2LDwI2VpHuZpweburY0bzpvoDi9RFtXDmgG+a8DLp1txaPcGT2P62Z3ePPuMAcGFvcVIqMaO9
        y+OLstZ1YbEcBTKc+3/CL6TtTWOn7QK4Y9hth+uMbc5KbJWe3N/YsyJeMeKjKhyDl2aXvGsPHnUZo
        Ovy4n0nEry3jhm35vCOtIrUt18ZxAafiLExZOpoU2snQuYVTzJiKEGSkxjU8Q8lfdds7lMhXQxKM1
        qlUv1cdm22Fjm1RgNNJTSBzc8rrEj4/R75Z+g5sxWC2j0tbqW1yXOGCLKd/cMB1DWMGDV98UYp3M3
        3QLmsmCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4eiL-00AkrC-2l; Mon, 12 Dec 2022 09:03:09 +0000
Date:   Mon, 12 Dec 2022 01:03:09 -0800
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
Message-ID: <Y5buTVuu0pfqBQh+@infradead.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
 <Y3XM62P7CaeKXFsz@infradead.org>
 <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
 <Y3zCdJr5dKsADsnM@infradead.org>
 <Y5NpsmN/npnG8lxY@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5NpsmN/npnG8lxY@makrotopia.org>
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

On Fri, Dec 09, 2022 at 05:00:34PM +0000, Daniel Golle wrote:
> It doesn't need to be literally the PARTNAME uevent, just any way to
> communicate the names of mapped subimages to userspace.
> 
> My understanding by now is that there is no way around introducing a
> new device_type and then mitigate the unwanted side effects by
> follow-up changes, ie. make it possible to use that new device_type
> when specifying the rootfs= cmdline variable (currently only disks and
> partitions are considered there).
> 
> Or give up on the idea that uImage.FIT subimages mapped by the new
> driver can be identified by userspace by poking uevent from sysfs and
> just rely on convention and ordering.

To be honest I'm still really confused by the patch set.  What is
the problem with simply using an initramfs, which is the way to
deal with any non-trivial init issue for about 20 years now, predated
by the somewhat more awkware initrd...

> Needing an initramfs, even if it boils down to just one statically
> compile executable, is a massive bloat and complication when building
> embedded device firmware and none of the over 1580 devices currently
> supported by OpenWrt need an intermediate initramfs to mount their
> on-flash squashfs rootfs (some, however, already use this uImage.FIT
> partition parser, and not needing a downstream patch for that would be
> nice).

You can always build the initrams into the kernel image, I don't
see how that is bloat.

> Carrying the read-only squashfs filesystem inside the uImage.FIT
> structure has the advantage of being agnostic regarding the
> storage-type (NOR/mtdblockX, NAND/ubiblockX, MMC/mmcblkXpY) and allows
> the bootloader to validate the filesystem hash before starting the
> kernel, ie. ensuring integrity of the firmware as-a-whole which
> includes the root filesystem.

What is the point of the uImage.FIT?  Why can't you use a sane
format?  Or at least not use it on top of partitions, which is just
braindead.  Who actually came up with this amazingly convoluted and
annoying scheme and why?
