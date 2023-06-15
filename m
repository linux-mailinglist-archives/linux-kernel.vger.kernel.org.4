Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66369731292
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245329AbjFOIqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240784AbjFOIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:46:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EB630C7;
        Thu, 15 Jun 2023 01:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49D956162D;
        Thu, 15 Jun 2023 08:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34869C433C8;
        Thu, 15 Jun 2023 08:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686818732;
        bh=tapidRMc5Z8lk3YcrY6Gm0xjUyUbhK/trrVH5pOq0pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdHdIFr1IfC+gs/LEZSxtm1jgdeM7jJG0MERI61Ay3HCdD8h3x9mDIUHlWyTdqqTI
         A1v9U83J6rlkQvRN/F+hxr01eWkjPw/A/10vMVB2BuBRyMdPuKTJNbIgnH79dfn4gn
         UMbPDd12Yd7F8CXhPKhMW6L0v4s78XB3dksoLHMA=
Date:   Thu, 15 Jun 2023 10:45:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "min15.li" <min15.li@samsung.com>
Cc:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, wsa@kernel.org, vkoul@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: add capacity validation in bdev_add_partition()
Message-ID: <2023061559-sloppily-amply-1e28@gregkh>
References: <CGME20230615081227epcas5p40cd9cdf762fcaeedaa8cf8d92d425560@epcas5p4.samsung.com>
 <20230615160929.9240-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615160929.9240-1-min15.li@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 04:09:29PM +0000, min15.li wrote:
> In the function bdev_add_partition(),there is no check that the start
> and end sectors exceed the size of the disk before calling add_partition.
> When we call the block's ioctl interface directly to add a partition,
> and the capacity of the disk is set to 0 by driver,the command will
> continue to execute.
> 
> Signed-off-by: min15.li <min15.li@samsung.com>
> ---
>  block/partitions/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 49e0496ff23c..9806a804e1a4 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -445,6 +445,12 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
>  		goto out;
>  	}
>  
> +	if (start >= get_capacity(disk) ||
> +		start + length > get_capacity(disk)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	if (partition_overlaps(disk, start, length, -1)) {
>  		ret = -EBUSY;
>  		goto out;
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
