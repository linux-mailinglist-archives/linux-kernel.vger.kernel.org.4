Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DF66D088D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjC3Ons (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjC3Onn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:43:43 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F7983E8;
        Thu, 30 Mar 2023 07:43:40 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1phtUl-0006N5-0n;
        Thu, 30 Mar 2023 16:43:19 +0200
Date:   Thu, 30 Mar 2023 15:43:14 +0100
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
Message-ID: <ZCWgAvLh6sNs03SW@makrotopia.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
 <Y3XM62P7CaeKXFsz@infradead.org>
 <Y3j+Pzy1JpqG8Yd8@makrotopia.org>
 <Y3zCdJr5dKsADsnM@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3zCdJr5dKsADsnM@infradead.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, Nov 22, 2022 at 04:37:08AM -0800, Christoph Hellwig wrote:
> On Sat, Nov 19, 2022 at 04:03:11PM +0000, Daniel Golle wrote:
> > [...]
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

Any news about that patchset? I'd happily review, test and use it ;)
