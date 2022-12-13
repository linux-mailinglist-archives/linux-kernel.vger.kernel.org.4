Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1805A64B009
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiLMGs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiLMGs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:48:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1607817E25;
        Mon, 12 Dec 2022 22:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s0r3sKZ22FIW4RvgWC+odYHiBjrvzyEHiairyKLURUw=; b=Fm6ZNDDEmC3fVLokI8VI0Gp2MS
        Yh8D7Z85GByribjANlhRTC6B/h6YIlKrFAQHvCcVzw+9DOKKK7UkrjjRAhjdEKIZRgS7CQYm3Tcfq
        3JCkXGKhXxCwv76phRO+ch2i56rSxizrcJN4qDcOdxwmdm3xPyT69TcMYIEzKwj+fogN1QKOXMGh9
        qsHMLVS7x9/gMv6Lxvaq91BRXMAwjJAsw852mPRphL/7O7d+H5TiUOu7Wdx4whLSQ8Th7XMmbqGJG
        GmsFz+lDdQxVtbjr0sBEBhEZOyKElejvc9NRU9qr5x/xNSvOgr/VlZtDqGUKm0NxBFPjO0nUhj3+y
        KuL5dk/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4z5I-00Btcm-Bb; Tue, 13 Dec 2022 06:48:12 +0000
Date:   Mon, 12 Dec 2022 22:48:12 -0800
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
Message-ID: <Y5ggLBy+XBjl/vYj@infradead.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
 <Y3XM62P7CaeKXFsz@infradead.org>
 <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
 <Y3zCdJr5dKsADsnM@infradead.org>
 <Y5NpsmN/npnG8lxY@makrotopia.org>
 <Y5buTVuu0pfqBQh+@infradead.org>
 <Y5cKSRmZ45OJq6Qq@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5cKSRmZ45OJq6Qq@makrotopia.org>
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

On Mon, Dec 12, 2022 at 11:02:33AM +0000, Daniel Golle wrote:
> The thing is that there isn't anything extraordinarily complex here,
> just dynamically partitioning a block device based on a well-known
> format.

Yes, but a completely non-standard format that nests inside an
partition.

> Using initramfs implies that we would need a 2nd copy of the standard C
> library and libfdt, both alone will already occupy more than just a
> single 64kB block of flash.

Why do you need libfdt?  And with a simple statically linked kpartx
you won't pull in much of libc either.

> I understand that from the point of view of
> classic x86 servers or even embedded devices with eMMC this seems
> negligible. However, keep in mind that a huge number of existing
> devices and also new designs of embedded devices often boot from just a
> few megabytes of NOR flash, and there every byte counts.

So I've worked quite a bit on really small deeply embedded systems,
and for those I wouldn't even think of using strange image formats
or the rather wasteful GPT partition format.
There we wouldn't dare to use paritions or weird image formats, but

> > What is the point of the uImage.FIT?
> 
> It is the format used by Das U-Boot, which is by far the most common
> bootloader found on small embedded devices running Linux.
> Is is already used by Das U-Boot to validate and load kernel,
> devicetree, initramfs, ... to RAM before launching Linux.
> I've included a link to the documentation[1] which gives insights
> regarding the motivation to create such a format.

That doesn't explain why you'd want to use it.  Nor how people
came up with it.

> In fact, that's only one out of three possible uses in which parsing
> the contained sub-image boundaries can be useful:
>  * On devices with NOR flash uImage.FIT is stored in an MTD partition,
>    hence the uImage.FIT partition parser (or small stackable block
>    driver) would then operate on top of /dev/mtdblockX.
> 
>  * On devices with NAND flash uImage.FIT is stored in a UBI volume,
>    hence in this case /dev/ubiblockX needs to be processed.

And all the mtdblock / ubiblock is due to the lack of a native
mtd/ubi backend for squashfs?  Why can't we take the block layer
out of the loop entirely?

> I hope this explains my motivation. Please ask should there by any
> doubts or if any of my explainations above are not clear.

None of this explains the silly nesting inside the GPT partition.
It is not needed for the any use cases and the root probem here.
Without that you could simply implement a parition format, with that
you get into crazy nesting behavior.  Note that it would have
any benefit over just not doing this silly image.

Maybe someone just needs to go back and come up wit ha scheme that
actually works and implement that in uboot as well.

