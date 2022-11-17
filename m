Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ACC62E2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiKQRNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbiKQRND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:13:03 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4696F769DB;
        Thu, 17 Nov 2022 09:13:02 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1oviRY-0005Ko-IO; Thu, 17 Nov 2022 18:12:52 +0100
Date:   Thu, 17 Nov 2022 17:12:46 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] blkdev: add function to add named read-only
 partitions
Message-ID: <Y3Zrjsr3N76mFijj@makrotopia.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <2015e6097f7166915d829740ff33aab506948a0a.1668644705.git.daniel@makrotopia.org>
 <Y3XNFXMaYFesFa+j@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3XNFXMaYFesFa+j@infradead.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 09:56:37PM -0800, Christoph Hellwig wrote:
> On Thu, Nov 17, 2022 at 12:44:40AM +0000, Daniel Golle wrote:
> > Add function bdev_add_partition_ro() which can be used by drivers to
> > register named read-only partitions on a disk device.
> > Unlike the existing bdev_add_partition() function, there is also no
> > check for overlapping partitions.
> > This new function is going to be used by the uImage.FIT parser.
> 
> Err, no.  No on has any business adding partitions to the block device
> except for the partition parser.

Well, there is a user-space ioctl for this as well[1], just that won't
set the partition to read-only and also doesn't allow naming it...

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/ioctl.c#n40
