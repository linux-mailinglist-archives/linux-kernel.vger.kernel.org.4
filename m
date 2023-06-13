Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93A572D8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbjFMFDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFMFDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:03:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285568E;
        Mon, 12 Jun 2023 22:03:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA06668BFE; Tue, 13 Jun 2023 07:02:59 +0200 (CEST)
Date:   Tue, 13 Jun 2023 07:02:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
Subject: Re: [PATCH v2] block: fine-granular CAP_SYS_ADMIN for Persistent
 Reservation ioctl
Message-ID: <20230613050259.GA13751@lst.de>
References: <20230612074103.4866-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612074103.4866-1-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static bool blkdev_pr_allowed(struct block_device *bdev, fmode_t mode)

With my resent series the use of fmode_t in the block layer has been
replaced with a new blk_mode_t, so you'll need to rebase.

> +{
> +	if (capable(CAP_SYS_ADMIN))
> +		return true;
> +
> +	/* no sense to make reservations for partitions */
> +	if (bdev_is_partition(bdev))
> +		return false;

I think we should disallow the PR ioctls for partitions entirely.
Yes, that's a change of behavior (and should be a separate patch),
but this is the right time to fix it.

Otherwise this change log good, thanks a lot!

