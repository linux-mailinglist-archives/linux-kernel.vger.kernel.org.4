Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E5662CF66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiKQATn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKQATk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:19:40 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B582547328;
        Wed, 16 Nov 2022 16:19:37 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ovScc-0002P6-CE; Thu, 17 Nov 2022 01:19:14 +0100
Date:   Thu, 17 Nov 2022 00:19:10 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 3/4] partitions/efi: add support for uImage.FIT
 sub-partitions
Message-ID: <Y3V9/pmHs7ypE7lb@makrotopia.org>
References: <cover.1668548123.git.daniel@makrotopia.org>
 <7526fc5a461a0d68eb1dab575f9c1950638fc21a.1668548123.git.daniel@makrotopia.org>
 <Y3R8oQXRQ8uq8p4P@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3R8oQXRQ8uq8p4P@infradead.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, Nov 15, 2022 at 10:01:05PM -0800, Christoph Hellwig wrote:
> On Tue, Nov 15, 2022 at 09:47:06PM +0000, Daniel Golle wrote:
> > Add new GUID allowing to parse uImage.FIT stored in a GPT partition
> > and map filesystem sub-image as sub-partitions.
> 
> NAK, we should not go out from the partition code to parse random
> weird image formats.

While weirdness is certainly subjective, uImage.FIT is not just a
random image format but used by a great majority of headless embedded
Linux devices out there. It's the default image format of many of the
SDKs distributed by chip vendors such as Allwinner, Marvell, MediaTek,
NXP, Qualcomm/Atheros, ...

Having better support for it in Linux hence doesn't seem too far-fetched
to me, especially given that we got partition parsers for all sorts of
historic (Acorn, Amiga, Atari, ...) or actually exotic (Karma?) formats.
Even Microsoft Windows' Logical Disk Manager is supported natively by
the kernel...

> If you want to support uImage.FIT just write a tiny stackable block
> driver or dm table for it.

As this is used on rather tiny embedded devices my hope was to keep
things simple and not having to enable device mapper on systems which
have anyway only very small amounts of storage and won't ever need
most of the device mapper features.

Using a tiny block driver instead is an option, I've implemented this
approach in the past couple of hours and it works just as fine.

In this case I would introduce a new kernel cmdline option allowing
to specify which block device (ie. a partition on eMMC, or mtdblock
or ubiblock device) to launch the uImage.FIT parser on.

Allowing this new driver to add block partitions by exporting a new
helper functions for that in block/partition/core.c would greatly
simplify things, as then the existing partitioning code could still
be used (instead of basically having to re-implement loopdev and
introduce a whole new type of block devices).

I will post an RFC series illustrating this approach.

Please let me know if this sounds acceptable, so I won't put effort
into implementing something which will then be rejected again after 5
iterations on the mailing list for reasons which could have been
expressed from the beginning. An RFC for this series was posted on
2022-04-25 [1], I wouldn't have worked months to fix all requests of
other maintainers and tested it on a variety of different hardware
knowing that the whole approach will be NACK'ed...

And, of course, thank you anyway for reviewing!


Cheers


Daniel

[1]: https://patchwork.kernel.org/project/linux-block/list/?series=635369&state=*
